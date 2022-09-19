//
//  SearchVC.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 16/09/22.
//

import UIKit
import CoreMIDI

class SearchVC: UIViewController {
    
    // MARK: - Properties
    var presenter: SearchPresenterProtocol?
    @IBOutlet weak var usersTableView: UITableView!
    let searchController = UISearchController()
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        setupRefreshView()
    }
    
    func setupTableView(){
        usersTableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: UserTableViewCell.identifier)
        usersTableView.delegate = self
        usersTableView.dataSource = self
    }
    
    func setupRefreshView() {
        refreshControl.attributedTitle = NSAttributedString(string: "Tarik untuk memperbarui")
        refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
        usersTableView.addSubview(refreshControl)
    }
    
    @objc func refreshData(_ sender: AnyObject) {
        presenter?.resetData()
        self.refreshControl.endRefreshing()
        self.usersTableView.reloadData()
        presenter?.fetchSearchUsers()
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
            presenter?.resetData()
            presenter?.searchQuery = text
            presenter?.fetchSearchUsers()
        }
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = presenter?.allUsers?.count, let isLoading = presenter?.isLoadData, let firstCalled = presenter?.firstCalled {
            if count == 0 && !isLoading {
                tableView.setEmptyView(title: firstCalled ? "Search any user to show result" : "No users found")
            } else {
                tableView.restore()
            }
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell
        if let data = presenter?.allUsers?[indexPath.row], let avatar = data.avatarUrl, let username = data.username {
            cell?.configure(avatarUrl: avatar, username: username)
        }
        cell?.selectionStyle = .none
        cell?.layoutIfNeeded()
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToFavorite = UIContextualAction(style: .normal, title: "Favorite") {  [weak self] (contextualAction, view, boolValue) in
            self?.presenter?.saveFavoriteUser(with: (self?.presenter?.allUsers?[indexPath.row])!)
        }
        addToFavorite.backgroundColor = .systemGreen
        let swipeActions = UISwipeActionsConfiguration(actions: [addToFavorite])

        return swipeActions
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y + scrollView.frame.size.height
        let scrollView = scrollView.contentSize.height
        let totalPage = presenter?.totalPage ?? 1
        let currentPage = presenter?.currentPage ?? 1
        let isLoadData = presenter?.isLoadData
        if scrollOffset > scrollView, isLoadData == false, totalPage != 1 {
            let nextPage = currentPage + 1
            if nextPage <= totalPage {
                presenter?.isLoadData = true
                presenter?.currentPage = nextPage
                presenter?.fetchSearchUsers()
            }
        }
    }
}
