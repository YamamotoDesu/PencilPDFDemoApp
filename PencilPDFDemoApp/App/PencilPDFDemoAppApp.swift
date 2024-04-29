//
//  PencilPDFDemoAppApp.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/27/24.
//

import SwiftUI

@main
struct PencilPDFDemoAppApp: App {
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: .init(container: container))
                .environmentObject(container)
        }
    }
}
