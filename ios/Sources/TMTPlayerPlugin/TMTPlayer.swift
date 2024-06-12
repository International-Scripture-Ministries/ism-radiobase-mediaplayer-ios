import Foundation

@objc public class TMTPlayer: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
