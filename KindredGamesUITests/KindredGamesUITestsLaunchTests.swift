//  ----------------------------------------------------
//
//  KindredGamesUITestsLaunchTests.swift
//  Version 1.0
//
//  Unique ID:  E2E989D6-7477-48CA-A385-3431DBA1ED2E
//
//  part of the KindredGamesUITests™ product.
//
//  Written in Swift 5.0 on macOS 12.5
//
//  https://github.com/coldpointblue
//  Created by Hugo Diaz on 08/09/22.
//
//  ----------------------------------------------------

//  ----------------------------------------------------
/*  Goal explanation:  Configure UI code tests to ensure app runs smoothly
 and to identify problems as soon as they break any code. */
//  ----------------------------------------------------

import XCTest

class KindredGamesUITestsLaunchTests: XCTestCase {

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
