#if canImport(Combine)

import XCTest
import Combine
import CombineStorable
@testable import NotificationSubscribable

// MARK: - XCTestCase
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class NotificationSubscribableTests: XCTestCase {
    
    // MARK: Test
    
    func testStartObserve() {
        let name = Notification.Name("Test1")
        let expectation = XCTNSNotificationExpectation(name: name)
        var cancellables = Set<AnyCancellable>()
        
        [name]
            .map { NotificationCenter.Publisher(center: .default, name: $0) }
            .publisher
            .flatMap { $0 }
            .sink(receiveCompletion: { _ in
                expectation.fulfill()
            }, receiveValue: { notification in
                XCTAssertEqual(notification.name.rawValue, "Test1")
            })
            .store(in: &cancellables)
        
        _ = XCTWaiter().wait(for: [expectation], timeout: 1)
    }
}
#endif
