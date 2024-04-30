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
            .background(.white)
            .navigationDestination(for: NavigationDestination.self) {
                NavigationRoutingView(destination: $0)
            }
        }
    }
}

private struct HomeContentView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @State var isShowFileImporter: Bool = false
    @Binding var book: Book?
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))],
                      spacing: 40) {
                
                Button(action: {
                    isShowFileImporter = true
                }, label: {
                    BookItemEmptyView()
                })
                .fileImporter(isPresented: $isShowFileImporter,
                              allowedContentTypes: [.pdf]
                ) { result in
                    switch result {
                    case .success(let url):
                        homeViewModel.send(action: .makeNewBook(url))
                    case .failure(let error):
                        print(error)
                    }
                }
                
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
