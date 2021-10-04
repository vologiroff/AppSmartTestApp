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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return characterViewModel.comics?.items.count ?? 0
        case 1: return characterViewModel.stories?.items.count ?? 0
        case 2: return characterViewModel.events?.items.count ?? 0
        case 3: return characterViewModel.series?.items.count ?? 0
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = characterViewModel.comics?.items[indexPath.row].name
        case 1:
            cell.textLabel?.text = characterViewModel.stories?.items[indexPath.row].name
        case 2:
            cell.textLabel?.text = characterViewModel.events?.items[indexPath.row].name
        case 3:
            cell.textLabel?.text = characterViewModel.series?.items[indexPath.row].name
        default:
            fatalError("No such index in UITableView")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Comics"
        case 1:
            return "Stories"
        case 2:
            return "Events"
        case 3:
            return "Series"
        default:
            fatalError("No such index in UITableView")
        }
    }
}
