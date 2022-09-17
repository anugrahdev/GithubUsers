//
//  SearchVC.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 16/09/22.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: - Properties
    var presenter: SearchPresenterProtocol?
    @IBOutlet weak var usersTableView: UITableView!
    let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func setupTableView(){
        usersTableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: UserTableViewCell.identifier)
        usersTableView.delegate = self
        usersTableView.dataSource = self
    }

}

extension SearchVC: SearchViewProtocol {
    func reloadData() {
        usersTableView.reloadData()
    }
}


extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.doingSearch(_:)), object: nil)
        self.perform(#selector(self.doingSearch), with: nil, afterDelay: 1)
    }
    
    @objc func doingSearch(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        if !text.isEmpty {
            presenter?.fetchSearchUsers(with: text)
        }
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = presenter?.allUsers?.count {
            if count == 0 {
                tableView.setEmptyView(title: "No users found")
            } else {
                tableView.restore()
            }
            return count
        }
        tableView.setEmptyView(title: "Search any user to show result")
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell
        if let data = presenter?.allUsers?[indexPath.row] {
            cell?.configure(with: data)
        }
        cell?.selectionStyle = .none
        cell?.layoutIfNeeded()
        return cell ?? UITableViewCell()
    }
}
