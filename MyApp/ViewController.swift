//
//  ViewController.swift
//  MyApp
//
//  Created by Vicky Singh on 10/09/24.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel = UserListViewModel()
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        viewModel.fetchUsers()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableView.allowsSelection = .random()
        view.addSubview(tableView)
    }
    
    private func setupBindings() {
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.onError = { error in
            print("Error fetching users: \(error)")
            // Optionally, show an alert to the user
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        cell.selectionStyle = .none
        let user = viewModel.user(at: indexPath)
        cell.textLabel?.text = user.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(in: section)
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let userDetailsVC = storyboard.instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController {
            let username = viewModel.titleForHeader(in: indexPath.section)
            userDetailsVC.users = viewModel.userDetails(for: username)
            userDetailsVC.selectedIndex = indexPath.row
            navigationController?.pushViewController(userDetailsVC, animated: true)
        } else {
            print("Error storyboard not found")
        }
    }
}
