//
//  HomeViewModel.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var showWelcome = false
    @Published var isOpenOutside = false
    @Published var showSettings = false
    @Published var isSelected = false
    @Published var feedData = [FeedCards]()
    @AppStorage("logStatus") var logStatus: Bool?
    @AppStorage("guestMode") var guestMode: Bool?
    
    init() {
        guard let feedData: [FeedCards] = loadJSONData(from: "homeFeed") else {
            return
        }
        self.feedData = feedData
    }
}


