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
                        Image(systemName: select.rawValue)
                            .tint(.black)
                    }
                    .frame(width: 30, height: 30)
                    .background(viewModel.selectedToolType == select ? .gray : .white)
                    
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
                            Capsule()
                                .fill(.black)
                                .frame(width: 26, height: select)
                        }
                        .frame(width: 30, height: 30)
                        .background(viewModel.selectedPencilWidth == select ? .gray : .white)
                        
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
                            Circle()
                                .fill(Color(select))
                                .frame(width: 26, height: 26)
                        }
                        .frame(width: 30, height: 30)
                        .background(viewModel.selectedPencilColor == select ? .gray : .white)
                        
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
                            Capsule()
                                .fill(.black)
                                .frame(width: 26, height: select)
                        }
                        .frame(width: 30, height: 30)
                        .background(viewModel.selectedHighlightWidth == select ? .gray : .white)
                        
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
                            Circle()
                                .fill(Color(select))
                                .frame(width: 26, height: 26)
                        }
                        .frame(width: 30, height: 30)
                        .background(viewModel.selectedHighlightColor == select ? .gray : .white)
                        
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
                            Circle()
                                .fill(.black)
                                .frame(width: select / 2, height: select / 2)
                                .clipped()
                        }
                        .frame(width: 30, height: 30)
                        .background(viewModel.selectedEraserWidth == select ? .gray : .white)
                        
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
        .background(.white)
    }
}
