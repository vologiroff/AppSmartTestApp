//
//  FeedModelTests.swift
//  AppSmartTestAppTests
//
//  Created by Kantemir Vologirov on 10/4/21.
//

import XCTest
@testable import AppSmartTestApp

class FeedModelTests: XCTestCase {
    
    //MARK: - Properties
    
    var feedModel: FeedModel?
    var mockFeedViewModel: MockFeedViewModel?
    var sut: FirstViewController?
    
    //MARK: - Lifecycle

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class. d
        
        sut = FirstViewController(collectionViewLayout: UICollectionViewFlowLayout())
        sut?.beginAppearanceTransition(true, animated: true)
        sut?.endAppearanceTransition()
        
        feedModel = FeedModel()
        mockFeedViewModel = MockFeedViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        feedModel = nil
        mockFeedViewModel = nil
        sut = nil
    }
    
    //MARK: - Models Test

    func testFeedModelIsNotNil() throws {
        XCTAssertNotNil(feedModel)
    }
    
    func testCharacterDataContainerIsNotNil() {
        let characterContainer = CharacterDataContainer()
        XCTAssertNotNil(characterContainer)
    }
    
    func testCharacterModelIsNotNil() {
        let character = Character()
        XCTAssertNotNil(character)
    }
    
    //MARK: - ViewControllers Tests
    
    func testFirstViewControllerIsNotNil() throws {
        XCTAssertNotNil(sut)
    }
    
    func testNumberOfSectionsInCollectionView() {
        let numberOfSections = sut?.collectionView.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func testNumberOfItemsInSectionIsCharactersCount() {
        let numberOfRowsInSection = sut?.collectionView.numberOfItems(inSection: 0)
        var charactersArray: [Character] = []
        
        RealmService.shared.realmLoadCharacters(to: &charactersArray, completion: {})
        
        let numberOfCharactersInSection = charactersArray.count
        XCTAssertEqual(numberOfRowsInSection, numberOfCharactersInSection)
    }
    
    
    func testCellForItemAtIndexPathReturnsCell() {
        sut!.collectionView.reloadData()
        
        let cell = sut!.collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: IndexPath(item: 0, section: 0))
        XCTAssertTrue(cell is CollectionViewCell)
    }
    
    func testCellForRowAtIndexPathDequeuesCellFromCollectionView() {
        let mockCollectionView = MockCollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 500), collectionViewLayout: UICollectionViewLayout())
        mockCollectionView.dataSource = sut
        mockCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        
        mockCollectionView.reloadData()
        _ = mockCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: IndexPath(item: 0, section: 0))
        XCTAssertTrue(mockCollectionView.cellIsDequed)
    }
    
    //MARK: - ViewModels Tests
    
    func testFeedViewModelIsNotNil() throws {
        XCTAssertNotNil(sut?.feedViewModel)
    }
    
    func testFeedViewModelReturnsNumberOfRows() {
        XCTAssertGreaterThan(sut!.feedViewModel!.numberOfRows(), 0)
    }
    
    //MARK: - APIService Tests
    
    func testFetchFeedModelCalledOnce() {
        mockFeedViewModel?.fetchFeedModelData()
        XCTAssertEqual(mockFeedViewModel?.fetchModelDataCount, 1)
    }
    
    func testFetchFilteredFeedModelDataCount() {
        mockFeedViewModel?.fetchFilteredFeedModelData(for: nil)
        XCTAssertEqual(mockFeedViewModel?.fetchFilteredFeedModelDataCount, 1)
    }
    
    //MARK: - RealmService Tests
    
    func testLoadedCharactersAreNotNil() {
        var charactersToDisplay = mockFeedViewModel!.charactersToDisplay
        RealmService.shared.realmLoadCharacters(to: &charactersToDisplay, completion: {})
        XCTAssertGreaterThan(charactersToDisplay.count, 0)
    }
    
    //MARK: - Perfomance Tests
 
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
