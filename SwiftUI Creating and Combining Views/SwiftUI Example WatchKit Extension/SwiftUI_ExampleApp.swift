//
//  SwiftUI_ExampleApp.swift
//  SwiftUI Example WatchKit Extension
//
//  Created by Daniel Williams on 20/01/2021.
//

import SwiftUI

@main
struct SwiftUI_ExampleApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
