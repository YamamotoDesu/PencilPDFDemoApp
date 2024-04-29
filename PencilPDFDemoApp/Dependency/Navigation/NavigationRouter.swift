//
//  NavigationRoutable.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/29/24.
//

import Combine
import Foundation

protocol NavigationRoutable {
    var destinations: [NavigationDestination] { get set }
    
    func push(to view: NavigationDestination)
    func pop()
}

class NavigationRouter: NavigationRoutable, ObservableObjectSettable {
    var objectWillChange: ObservableObjectPublisher?
    
    var destinations: [NavigationDestination] = [] {
        didSet {
            objectWillChange?.send()
        }
    }
    
    func push(to view: NavigationDestination) {
        destinations.append(view)
    }
    
    func pop() {
        _ = destinations.popLast()
    }
}
