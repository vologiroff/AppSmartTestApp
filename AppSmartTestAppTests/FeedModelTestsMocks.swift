//
//  FeedModelTestsMocks.swift
//  AppSmartTestAppTests
//
//  Created by Kantemir Vologirov on 10/5/21.
//

import Foundation
import UIKit
@testable import AppSmartTestApp


//MARK: - Mock Objects

extension FeedModelTests {
    class MockFeedViewModel: FeedViewModel {
        var fetchModelDataCount = 0
        var fetchFilteredFeedModelDataCount = 0
        
        var charactersToDisplay: [Character] = []
        
        override func fetchFeedModelData() {
            fetchModelDataCount += 1
        }
        
        override func fetchFilteredFeedModelData(for word: String?) {
            fetchFilteredFeedModelDataCount += 1
        }
    }
    
    class MockCollectionView: UICollectionView {
        var cellIsDequed = false
        
        override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
            cellIsDequed = true
            return super.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        }
    }
}
