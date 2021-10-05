//
//  SecondViewController.swift
//  AppSmartTestApp
//
//  Created by Kantemir Vologirov on 10/3/21.
//

import UIKit

class SecondViewController: UITableViewController {
    
    // MARK: - Properties
    
    ///Characters viewModel
    public var characterViewModel: CharacterViewModel!
    
    private enum Section: Int {
        case Comics
        case Stories
        case Events
        case Series
    }
    
    private let characterAvatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.setDimensions(height: 30, width: 30)
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavBar()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        tableView.allowsSelection = false
    }
    
    private func configureNavBar() {
        navigationItem.title = characterViewModel.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: characterAvatarImageView)
        characterAvatarImageView.sd_setImage(with: characterViewModel.thumbnail)
    }
    
    //MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { fatalError() }
        switch section {
        case .Comics:  return characterViewModel.comics?.items.count ?? 0
        case .Stories: return characterViewModel.stories?.items.count ?? 0
        case .Events:  return characterViewModel.events?.items.count ?? 0
        case .Series:  return characterViewModel.series?.items.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        
        switch section {
        case .Comics:
            cell.textLabel?.text = characterViewModel.comics?.items[indexPath.row].name
        case .Stories:
            cell.textLabel?.text = characterViewModel.stories?.items[indexPath.row].name
        case .Events:
            cell.textLabel?.text = characterViewModel.events?.items[indexPath.row].name
        case .Series:
            cell.textLabel?.text = characterViewModel.series?.items[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { fatalError() }
        switch section {
        case .Comics:  return "Comics"
        case .Stories: return "Stories"
        case .Events:  return "Events"
        case .Series:  return "Series"
        }
    }
}
