//
//  PencilPDFDemoAppApp.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/27/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct PencilPDFDemoAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: .init(container: container))
                .environmentObject(container)
        }
    }
}
