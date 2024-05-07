//
//  LoadingView.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 5/7/24.
//

import SwiftUI

enum LoadingType: String {
    case upload = "업로드 중입니다.\n잠시만 기다려 주세요."
    case save = "학습 내용을 기록 중입니다.\n잠시만 기다려 주세요."
}

struct LoadingView: View {
    var loadingType: LoadingType
    
    var body: some View {
        VStack {
            Text(loadingType.rawValue)
                .font(.title2)
                .multilineTextAlignment(.center)
            
            ProgressView()
        }
    }
}
