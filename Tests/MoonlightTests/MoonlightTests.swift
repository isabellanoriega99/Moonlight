import XCTest
import Combine
@testable import Moonlight

final class MoonlightTests: XCTestCase {

    var moonlight: MoonlightContract!

    override func setUpWithError() throws {
        try super.setUpWithError()
        moonlight = Moonlight()
    }

    override func tearDownWithError() throws {
        moonlight = nil
        try super.tearDownWithError()
    }
}
