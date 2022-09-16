//
//  FavoritesVCViewController.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 16/09/22.
//  
//

import UIKit

class FavoritesVCViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: FavoritesVCPresenterProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        
    }

}

// MARK: - View Protocol
extension FavoritesVCViewController: FavoritesVCViewProtocol {}
