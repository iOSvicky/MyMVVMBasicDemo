//
//  UserDetailsViewController.swift
//  MyApp
//
//  Created by Vicky Singh on 10/09/24.
//

import UIKit

class UserDetailsViewController: UIViewController {
    var users: [User] = []
    var selectedIndex: Int = 0
    
    private var nameLabel: UILabel!
    private var usernameLabel: UILabel!
    private var emailLabel: UILabel!
    private var addressLabel: UILabel!
    private var phoneLabel: UILabel!
    private var websiteLabel: UILabel!
    private var companyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayUserDetails()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        nameLabel = createLabel()
        usernameLabel = createLabel()
        emailLabel = createLabel()
        addressLabel = createLabel()
        phoneLabel = createLabel()
        websiteLabel = createLabel()
        companyLabel = createLabel()
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, usernameLabel, emailLabel, addressLabel, phoneLabel, websiteLabel, companyLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)
        ])
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }
    
    private func displayUserDetails() {
        guard users.indices.contains(selectedIndex) else { return }
        let user = users[selectedIndex]
        
        nameLabel.text = "Name: \(user.name)"
        usernameLabel.text = "Username: \(user.username)"
        emailLabel.text = "Email: \(user.email)"
        addressLabel.text = "Address: \(user.address.street), \(user.address.suite), \(user.address.city), \(user.address.zipcode)"
        phoneLabel.text = "Phone: \(user.phone)"
        websiteLabel.text = "Website: \(user.website)"
        companyLabel.text = "Company: \(user.company.name)\nCatchphrase: \(user.company.catchPhrase)\nBS: \(user.company.bs)"
    }
}
