//
//  HomeView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/27/24.
//

import SwiftUI
import MobileCoreServices

struct HomeView: View {
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: HomeViewModel
    @State var isShowFileImporter: Bool = false
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.destinations) {
            ZStack {
                if viewModel.phase == .loading {
                    VStack {
                        Text("로딩중")
                            .font(.title)
                        
                        ProgressView()
                    }
                }
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 40) {
                        // PDF 추가 버튼
                        Button(action: {
                            isShowFileImporter = true
                        }, label: {
                            BookItemEmptyCell()
                        })
                        .fileImporter(isPresented: $isShowFileImporter,
                                      allowedContentTypes: [.pdf]
                        ) { result in
                            viewModel.phase = .loading
                            switch result {
                            case .success(let url):
                                viewModel.send(action: .makeNewBook(url))
                            case .failure(let error):
                                print(error)
                                viewModel.phase = .fail
                            }
                        }
                        
                        ForEach(viewModel.books, id: \.self) { book in
                            Button(action: {
                                viewModel.send(action: .goToPDF(book))
                            }, label: {
                                BookItemCell(title: book.title,
                                             progress: book.progress)
                            })
                        }
                    } // VGrid
                    .padding(.horizontal, 10)
                } // ScrollView
            } // ZStack
            .background(.white)
            .toolbar {
                ToolbarItemGroup(placement: .principal) {
                    Text("PDFDemoApp")
                        .font(.title)
                        .foregroundStyle(.black)
                }
            }
            .navigationDestination(for: NavigationDestination.self) {
                NavigationRoutingView(destination: $0)
            }
            .onAppear {
                viewModel.send(action: .viewAppear)
            }
        } // NavigationStack
    }
}

#Preview {
    HomeView(viewModel: .init(container: DIContainer.stub))
}
