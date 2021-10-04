//
//  RealmService.swift
//  AppSmartTestApp
//
//  Created by Kantemir Vologirov on 10/4/21.
//

import Foundation
import RealmSwift

final class RealmService {
    
    //MARK: - Properties
    
    private let realm = try! Realm()
    private lazy var charactersArray: Results<Character>? = realm.objects(Character.self)
    
    public static let shared = RealmService()
    
    //MARK:- Lifecycle
    
    private init() {}
    
    //MARK: - Helpers
    
    public func realmSaveCharacters(characters: [Character]?) {
        guard let characters = characters else { return }
        do {
            try realm.write {
                characters.forEach { character in
                    realm.add(character, update: .all)
                }
            }
        } catch {
            print("Error saving characters, \(error)")
        }
    }

    public func realmLoadCharacters(to charactersToDisplay: inout [Character], completion: (()->())?) {
        guard let charactersArray = charactersArray else { return }
        
        charactersToDisplay = []
        
        for character in charactersArray {
            charactersToDisplay.append(character)
        }

        completion?()
    }
    
}
