//
//  UserListViewModel.swift
//  MyApp
//
//  Created by Vicky Singh on 10/09/24.
//

import Foundation
import Alamofire

class UserListViewModel {
    private var users: [User] = []
    private var userSections: [String: [User]] = [:]
    private var sectionTitles: [String] = []
    
    var onUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?

    func fetchUsers() {
        let url = "https://jsonplaceholder.typicode.com/users"
        
        Alamofire.request(url).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: [])
                    let users = try JSONDecoder().decode([User].self, from: data)
                    self?.users = users
                    self?.groupUsersByUsername()
                    self?.onUpdate?()
                } catch {
                    self?.onError?(error)
                }
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    private func groupUsersByUsername() {
        userSections.removeAll()
        sectionTitles.removeAll()
        
        for user in users {
            if userSections[user.username] == nil {
                userSections[user.username] = []
                sectionTitles.append(user.username)
            }
            userSections[user.username]?.append(user)
        }
    }
    
    func numberOfSections() -> Int {
        return sectionTitles.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        let username = sectionTitles[section]
        return userSections[username]?.count ?? 0
    }
    
    func user(at indexPath: IndexPath) -> User {
        let username = sectionTitles[indexPath.section]
        return userSections[username]?[indexPath.row] ?? User(id: 0, name: "", username: "", email: "", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: ""))
    }
    
    func titleForHeader(in section: Int) -> String {
        return sectionTitles[section]
    }
    
    func userDetails(for username: String) -> [User] {
        return userSections[username] ?? []
    }
}
