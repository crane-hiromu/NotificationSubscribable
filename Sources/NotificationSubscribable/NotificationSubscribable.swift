#if canImport(Combine)

import Foundation
import Combine
import CombineStorable

// MARK: - Protocol
@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public protocol NotificationSubscribable {

    func startObserve(
        notifications: [Notification.Name],
        receive: @escaping (Notification) -> Void
    )
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension NotificationSubscribable where Self: Storable {
    
    func startObserve(
        notifications: [Notification.Name],
        receive: @escaping (Notification) -> Void
    ) {
        notifications
            .map { NotificationCenter.Publisher(center: .default, name: $0) }
            .publisher
            .flatMap { $0 }
            .sink(receiveValue: receive)
            .store(in: &self.cancellables)
    }
}

#endif
