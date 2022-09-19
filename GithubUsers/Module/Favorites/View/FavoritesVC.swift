//
//  FavoritesVC.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 16/09/22.
//

import UIKit

class FavoritesVC: UIViewController {

    // MARK: - Properties
    var presenter: FavoritesPresenterProtocol?
    @IBOutlet weak var favoritesTableView: UITableView!
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.fetchAllFavoriteUsers()
        setupRefreshView()
    }

    func setupTableView(){
        favoritesTableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: UserTableViewCell.identifier)
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
    }
    
    func setupRefreshView() {
        refreshControl.attributedTitle = NSAttributedString(string: "Tarik untuk memperbarui")
        refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
        favoritesTableView.addSubview(refreshControl)
    }
    
    @objc func refreshData(_ sender: AnyObject) {
        presenter?.resetData()
        self.refreshControl.endRefreshing()
        self.favoritesTableView.reloadData()
    }

}

extension FavoritesVC: FavoritesViewProtocol {
    func reloadData() {
        favoritesTableView.reloadData()
    }
}

extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.allUsers?.count ?? 0
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
        let removeFromFavorites = UIContextualAction(style: .destructive, title: "Remove") {  [weak self] (contextualAction, view, boolValue) in
            if let user = self?.presenter?.allUsers?[indexPath.row] {
                self?.presenter?.removeUserFromFavorite(user: user)
                self?.presenter?.resetData()
            }
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [removeFromFavorites])

        return swipeActions
    }
}
