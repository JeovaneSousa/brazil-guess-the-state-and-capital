//
//  brazil_guess_the_state_and_capitalUITestsLaunchTests.swift
//  brazil-guess-the-state-and-capitalUITests
//
//  Created by Jeovane Barbosa on 28/02/23.
//

import XCTest

final class brazil_guess_the_state_and_capitalUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
