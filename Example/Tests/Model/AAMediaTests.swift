//
//  AAMediaTests.swift
//  AwesomeAudio_Tests
//
//  Created by Evandro Harrison on 12/04/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import AwesomeAudio

class AAMediaTests: XCTestCase {

    func testUrl() {
        let media: AAMedia = AAMedia(media: "https://google.com")
        XCTAssertEqual(media.url, "https://google.com".url()?.offlineURLIfAvailable())
    }

    func testBackgroundUrl() {
        let media: AAMedia = AAMedia(media: "https://google.com", background: "https://google.com/background")
        XCTAssertEqual(media.url, "https://google.com".url()?.offlineURLIfAvailable())
        XCTAssertEqual(media.backgroundUrl, "https://google.com/background".url()?.offlineURLIfAvailable())
    }
}
