//
//  ViewController.swift
//  AppSmartTestApp
//
//  Created by Kantemir Vologirov on 10/3/21.
//

import UIKit

class FirstViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    ///CollectionView characters viewModel
    private var feedViewModel: FeedViewModelProtocol!
    
    ///CollectionView footer activity indicator
    private let activityIndicator = ActivityIndicatorView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewModel()
        configureSearchController()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - API
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    private func configureViewModel() {
        feedViewModel = FeedViewModel()
        feedViewModel.fetchFeedModelData()
        feedViewModel.onFeedModelUpdatedCallback = { [weak self] in
            self?.collectionView.reloadData()
            self?.activityIndicator.stop()
        }
    }
    
    private func configureCollectionView() {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 25, height: UIScreen.main.bounds.width / 2)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.footerReferenceSize = CGSize(width: collectionView.bounds.width, height: 50)
        
        collectionView.collectionViewLayout = collectionViewFlowLayout
        if #available(iOS 13, *) {
            collectionView.backgroundColor = .systemBackground
        }
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        
        collectionView.addSubview(activityIndicator)
        activityIndicator.setDimensions(height: 25, width: 25)
        activityIndicator.centerX(inView: view)
        activityIndicator.anchor(bottom: collectionView.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10)
    }
    
    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search for a character", comment: "")
        searchController.searchBar.delegate = self
        searchController.searchBar.setValue(NSLocalizedString("Cancel", comment: ""), forKey: "cancelButtonText")
        
        navigationItem.title = NSLocalizedString("Marvel", comment: "")
        navigationItem.searchController = searchController
    }

    //MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        feedViewModel?.numberOfRows() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configureWith(character: feedViewModel?.getCharacterViewModelAt(indexPath: indexPath))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let feedViewModel = feedViewModel else { return }
        
        //Setting up pagination
        if indexPath.row == feedViewModel.numberOfRows() - 1 {
            activityIndicator.start()
            feedViewModel.fetchFeedModelData()
        }
    }
    
    //MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = SecondViewController()
        controller.characterViewModel = feedViewModel.getCharacterViewModelAt(indexPath: indexPath)
        navigationController?.pushViewController(controller, animated: true)
    }

}

//MARK: - UISearchBarDelegate

extension FirstViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = nil
    }
}

//MARK: - UISearchResultsUpdating

extension FirstViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        feedViewModel.filteringWords = searchText
    }
}

