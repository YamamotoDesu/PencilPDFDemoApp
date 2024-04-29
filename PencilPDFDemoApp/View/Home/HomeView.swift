//
//  ContentView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/27/24.
//

import SwiftUI
import MobileCoreServices

struct HomeView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: HomeViewModel
    @State var book: Book?
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destinations) {
            VStack(spacing: 0) {
                ButtonStackView()
                    .padding(.leading, 40)
                    .padding(.top, 20)
                
                Spacer()
                    .frame(height: 50)
                
                HomeContentView(homeViewModel: viewModel,
                                book: $book)
            }
            .navigationDestination(for: NavigationDestination.self) {
                NavigationRoutingView(destination: $0)
            }
        }
    }
}

private struct HomeContentView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @State var isShowDocumentView: Bool = false
    @Binding var book: Book?
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))],
                      spacing: 40) {
                
                Button(action: {
                    isShowDocumentView = true
                }, label: {
                    BookItemEmptyView()
                })
                .sheet(isPresented: $isShowDocumentView, content: {
                    DocumentPickerView(viewModel: homeViewModel)
                        .frame(height: UIScreen.main.bounds.height * 0.6)
                })
                
                ForEach(homeViewModel.books, id: \.self) { book in
                    Button(action: {
                        homeViewModel.send(action: .goToPDF(book))
                    }, label: {
                        BookItemView(title: book.title, 
                                     progress: book.progress)
                    })
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    HomeView(viewModel: .init(container: DIContainer.stub))
}
