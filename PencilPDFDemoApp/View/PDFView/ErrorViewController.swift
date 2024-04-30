//
//  ErrorViewController.swift
//  PencilPDFDemoApp
//
//  Created by Zerom on 4/30/24.
//

import UIKit

class ErrorViewController: UIViewController {
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PDF를 불러올 수 없습니다."
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
