//
//  FeedModel.swift
//  AppSmartTestApp
//
//  Created by Kantemir Vologirov on 10/3/21.
//

import Foundation
import RealmSwift

struct FeedModel: Decodable {
    var data: CharacterDataContainer?
}

class CharacterDataContainer: Decodable {
    let offset: Int? // The requested offset (number of skipped results) of the call.,
    let limit: Int? // The requested result limit.,
    let total: Int? //The total number of resources available given the current filter set.,
    let count: Int? // The total number of results returned by this call.,
    var results: [Character]? // The list of characters returned by the call.
}

class Character: Object, Decodable {
    @objc dynamic var id: Int = 0 // The unique ID of the character resource.,
    @objc dynamic var name: String? //The name of the character.,
    @objc dynamic var Description: String? // A short bio or description of the character.,
    @objc dynamic var thumbnail: Image?  // The representative image for this character.,
    @objc dynamic var comics: ComicList? // A resource list containing comics which feature this character.,
    @objc dynamic var stories: StoryList? // A resource list of stories in which this character appears.,
    @objc dynamic var events: EventList? // A resource list of events in which this character appears.,
    @objc dynamic var series: SeriesList? // A resource list of series in which this character appears.
    
    override class func primaryKey() -> String {
        return "id"
    }
}

class Image: Object, Decodable {
    @objc dynamic var path: String? // The directory path of to the image.,
    @objc dynamic var `extension`: String? // The file extension for the image.
}

class ComicList: Object, Decodable {
    @objc dynamic var available: Int = 0 // The number of total available issues in this list. Will always be greater than or equal to the "returned" value.,
    @objc dynamic var returned: Int = 0 // The number of issues returned in this collection (up to 20).,
    @objc dynamic var collectionURI: String? // The path to the full list of issues in this collection.,
    dynamic var items = List<ComicSummary>() // The list of returned issues in this collection.
}

class StoryList: Object, Decodable {
    @objc dynamic var available: Int = 0 //The number of total available stories in this list. Will always be greater than or equal to the "returned" value.,
    @objc dynamic var returned: Int = 0 // The number of stories returned in this collection (up to 20).,
    @objc dynamic var collectionURI: String? // The path to the full list of stories in this collection.,
    dynamic var items = List<StorySummary>() // The list of returned stories in this collection.
}

class EventList: Object, Decodable {
    @objc dynamic var available: Int = 0 // The number of total available events in this list. Will always be greater than or equal to the "returned" value.,
    @objc dynamic var returned: Int = 0 // The number of events returned in this collection (up to 20).,
    @objc dynamic var collectionURI: String? // The path to the full list of events in this collection.,
    dynamic var items = List<EventSummary>() // The list of returned events in this collection.
}

class SeriesList: Object, Decodable {
    @objc dynamic var available: Int = 0 // The number of total available series in this list. Will always be greater than or equal to the "returned" value.,
    @objc dynamic var returned: Int = 0 // The number of series returned in this collection (up to 20).,
    @objc dynamic var collectionURI: String? // The path to the full list of series in this collection.,
    dynamic var items = List<SeriesSummary>() // The list of returned series in this collection.
}

class ComicSummary: Object, Decodable {
    @objc dynamic var resourceURI: String? // The path to the individual comic resource.,
    @objc dynamic var name: String? // The canonical name of the comic.
}

class StorySummary: Object, Decodable {
    @objc dynamic var resourceURI: String? // The path to the individual story resource.,
    @objc dynamic var name: String? // The canonical name of the story.,
    @objc dynamic var type: String? // The type of the story (interior or cover).
}

class EventSummary: Object, Decodable {
    @objc dynamic var resourceURI: String? // The path to the individual event resource.,
    @objc dynamic var name: String? // The name of the event.
}

class SeriesSummary: Object, Decodable {
    @objc dynamic var resourceURI: String? // The path to the individual series resource.,
    @objc dynamic var name: String? // The canonical name of the series.
}
