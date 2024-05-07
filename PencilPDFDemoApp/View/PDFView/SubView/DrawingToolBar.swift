//
//  DrawingToolBar.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/1/24.
//

import SwiftUI

struct DrawingToolBar: View {
    @ObservedObject var viewModel: PDFDrawingViewModel
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: width * 0.3)
            
            Divider()
                .frame(height: 20)
            
            // MARK: - Tool 선택
            HStack {
                Spacer()
                
                ForEach(ToolType.allCases, id: \.self) { select in
                    Button {
                        viewModel.selectedToolType = select
                    } label: {
                        ZStack {
                            Image(systemName: select.rawValue)
                                .tint(.black)
                                .zIndex(1)
                            
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.selectedGray)
                                .frame(width: 28, height: 28)
                                .opacity(viewModel.selectedToolType == select ? 1.0 : 0.0)
                                .zIndex(0)
                        }
                    }
                    .frame(width: 30, height: 30)
                    
                    Spacer()
                }
            }
            .frame(width: 150)
            
            Divider()
                .frame(height: 20)
            
            // MARK: - Tool에 따른 설정 선택
            switch viewModel.selectedToolType {
            case .pen:
                // MARK: - Pen Width 선택
                HStack {
                    Spacer()
                    
                    ForEach(viewModel.pencilWidthArr, id: \.self) { select in
                        Button {
                            viewModel.selectedPencilWidth = select
                        } label: {
                            ZStack {
                                Capsule()
                                    .fill(.black)
                                    .frame(width: 24, height: select)
                                    .zIndex(1)
                                
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(.selectedGray)
                                    .frame(width: 28, height: 28)
                                    .opacity(viewModel.selectedPencilWidth == select ? 1.0 : 0.0)
                                    .zIndex(0)
                            }
                        }
                        .frame(width: 30, height: 30)
                        
                        Spacer()
                    }
                }
                .frame(width: 150)
                
                Divider()
                    .frame(height: 20)
                
                // MARK: - Pen Color 선택
                HStack {
                    Spacer()
                    
                    ForEach(viewModel.pencilColorArr, id: \.self) { select in
                        Button {
                            viewModel.selectedPencilColor = select
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color(select))
                                    .frame(width: 20, height: 20)
                                    .zIndex(1)
                                
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(.selectedGray)
                                    .frame(width: 28, height: 28)
                                    .opacity(viewModel.selectedPencilColor == select ? 1.0 : 0.0)
                                    .zIndex(0)
                            }
                        }
                        .frame(width: 30, height: 30)
                        
                        Spacer()
                    }
                }
                .frame(width: 150)
                
                Divider()
                    .frame(height: 20)
                
            case .highlight:
                // MARK: - Highlight Width 선택
                HStack {
                    Spacer()
                    
                    ForEach(viewModel.highlightWidthArr, id: \.self) { select in
                        Button {
                            viewModel.selectedHighlightWidth = select
                        } label: {
                            ZStack {
                                Capsule()
                                    .fill(.black)
                                    .frame(width: 24, height: select)
                                    .zIndex(1)
                                
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(.selectedGray)
                                    .frame(width: 28, height: 28)
                                    .opacity(viewModel.selectedHighlightWidth == select ? 1.0 : 0.0)
                                    .zIndex(0)
                            }
                        }
                        .frame(width: 30, height: 30)
                        
                        Spacer()
                    }
                }
                .frame(width: 150)
                
                Divider()
                    .frame(height: 20)
                
                // MARK: - Highlight Color 선택
                HStack {
                    Spacer()
                    
                    ForEach(viewModel.highlightColorArr, id: \.self) { select in
                        Button {
                            viewModel.selectedHighlightColor = select
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color(select))
                                    .frame(width: 20, height: 20)
                                    .zIndex(1)
                                
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(.selectedGray)
                                    .frame(width: 28, height: 28)
                                    .opacity(viewModel.selectedHighlightColor == select ? 1.0 : 0.0)
                                    .zIndex(0)
                            }
                        }
                        .frame(width: 30, height: 30)
                        
                        Spacer()
                    }
                }
                .frame(width: 150)
                
                Divider()
                    .frame(height: 20)
                
            case .eraser:
                // MARK: - Eraser Width 선택
                HStack {
                    Spacer()
                    
                    ForEach(viewModel.eraserWidthArr, id: \.self) { select in
                        Button {
                            viewModel.selectedEraserWidth = select
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(.selectedGray)
                                    .frame(width: select / 2, height: select / 2)
                                    .zIndex(1)
                                
                                Circle()
                                    .fill(.blue)
                                    .frame(width: select / 2 + 10, height: select / 2 + 10)
                                    .opacity(viewModel.selectedEraserWidth == select ? 1.0 : 0.0)
                                    .zIndex(0)
                            }
                        }
                        .frame(width: 30, height: 30)
                        
                        Spacer()
                    }
                }
                .frame(width: 150)
                
                Divider()
                    .frame(height: 20)
            }
            
            Spacer()
        }
        .frame(height: 40)
        .background(.backgroundGray)
    }
}
