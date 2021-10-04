//
//  FeedViewModel.swift
//  AppSmartTestApp
//
//  Created by Kantemir Vologirov on 10/3/21.
//

import UIKit
import RealmSwift


protocol FeedViewModelProtocol {
    var feedModel: FeedModel? { get }
    var onFeedModelUpdatedCallback: (() -> ())? { get set }
    var filteringWords: String? { get set }
    func numberOfRows() -> Int
    func getCharacterViewModelAt(indexPath: IndexPath) -> CharacterViewModel?
    func fetchFeedModelData()
}

final class FeedViewModel: FeedViewModelProtocol {
    
    // MARK: - Properties
    
    private(set) var feedModel: FeedModel? {
        didSet {
            guard let feedModel = feedModel else { return }
            //Saving data to Realm
            RealmService.shared.realmSaveCharacters(characters: feedModel.data?.results)
            
            //Loading/Refreshing data from Realm
            RealmService.shared.realmLoadCharacters(to: &charactersToDisplay, completion: onFeedModelUpdatedCallback)
        }
    }
    
    private var filteredFeedModel: FeedModel? {
        didSet {
            guard let _ = filteredFeedModel else { return }
            onFeedModelUpdatedCallback?()
        }
    }
    
    private var currentPage: Int = 0
    
    public var filteringWords: String? {
        didSet {
            //Cleaning up all the properties
            currentPage = 0
            feedModel = nil
            filteredFeedModel = nil
            charactersToDisplay = []
            
            // Cleaninig/Refreshing FirstViewController screen while fetching data
            onFeedModelUpdatedCallback?()
            
            if filteringWords == "" {
                fetchFeedModelData()
            } else {
                fetchFilteredFeedModelData(for: filteringWords)
            }
        }
    }
    
    ///List of characters to display in ColllectionView
    private var charactersToDisplay: [Character] = []
    
    ///CallBack to call after data fetching is done
    public var onFeedModelUpdatedCallback: (() -> ())?
    
    //MARK: - Lifecycle
    
    public init() {}
    
    //MARK: - API
    
    public func fetchFeedModelData() {
        guard filteringWords == nil || filteringWords == "" else {
            fetchFilteredFeedModelData(for: filteringWords)
            return
        } // In case there is still something to filter, otherwise fetch data
        
        filteredFeedModel = nil
        
        APIService.shared.fetchFeedModel(offset: currentPage * 12) { feedModel in
            guard let feedModel = feedModel else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if self.feedModel == nil {
                    self.feedModel = feedModel
                } else {
                    guard let results = feedModel.data?.results else { return }
                    self.feedModel?.data?.results?.append(contentsOf: results)
                    
                    //Saving data to Realm
                    RealmService.shared.realmSaveCharacters(characters: results)
                    
                    //Loading/Refreshing data from Realm
                    RealmService.shared.realmLoadCharacters(to: &self.charactersToDisplay, completion: self.onFeedModelUpdatedCallback)
                }
                
                //Increasing page number after fetching current page data
                self.currentPage += 1
            }
        }
    }
    
    func fetchFilteredFeedModelData(for word: String?) {
        APIService.shared.fetchFeedModel(offset: currentPage * 12, word: word) { filteredFeedModel in
            guard let filteredFeedModel = filteredFeedModel else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if self.filteredFeedModel == nil {
                    self.filteredFeedModel = filteredFeedModel
                } else {
                    guard let results = filteredFeedModel.data?.results else { return }
                    self.filteredFeedModel?.data?.results?.append(contentsOf: results)
                }
                
                //Increasing page number after fetching current page data
                self.currentPage += 1
            }
        }
    }
    
    
    //MARK: - Helpers
    
    public func numberOfRows() -> Int {
        return filteredFeedModel?.data?.results?.count ?? charactersToDisplay.count
    }
    
    public func getCharacterViewModelAt(indexPath: IndexPath) -> CharacterViewModel? {
        return filteredFeedModel == nil ? CharacterViewModel(character: charactersToDisplay[indexPath.row]) : CharacterViewModel(character: filteredFeedModel?.data?.results?[indexPath.row])
    }
}
