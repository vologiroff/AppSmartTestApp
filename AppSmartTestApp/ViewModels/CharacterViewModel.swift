//
//  CharacterViewModel.swift
//  AppSmartTestApp
//
//  Created by Kantemir Vologirov on 10/3/21.
//

import Foundation

struct CharacterViewModel {
    
    // MARK: - Properties
    
    private let characterModel: Character?
    
    // MARK: - Lifecycle
    
    init?(character: Character?) {
        guard let character = character else { return nil }
        self.characterModel = character
    }
    
    public var id: Int? {
        return characterModel?.id
    }// The unique ID of the character resource.,
    
    public var name: String? {
        return characterModel?.name
    } //The name of the character.,
    
    public var description: String? {
        return characterModel?.descriptionKey
    }// A short bio or description of the character.,
    
    public var thumbnail: URL? {
        return URL(string: (characterModel?.thumbnail?.path ?? "") + "." + (characterModel?.thumbnail?.extension ?? ""))
    } // The representative image for this character.,
    
    public var comics: ComicList? {
        return characterModel?.comics
    } // A resource list containing comics which feature this character.,
    
    public var stories: StoryList? {
        return characterModel?.stories
    }// A resource list of stories in which this character appears.,
    
    public var events: EventList? {
        return characterModel?.events
    } // A resource list of events in which this character appears.,
    
    public var series: SeriesList? {
        return characterModel?.series
    }
    
    
    // MARK: - API
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
}
