//
//  PIA11IAPApp.swift
//  PIA11IAP
//
//  Created by Bill Martensson on 2022-11-24.
//

import SwiftUI

@main
struct PIA11IAPApp: App {
    
    @StateObject var storeManager = StoreManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(storeManager: storeManager)
        }
    }
}
