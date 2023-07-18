//
//  PostDetailViewModel.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import UIKit
import SwiftUI


class PostDetailViewModel: ObservableObject {
    let feedCard: FeedCards

    init(feedCard: FeedCards) {
        self.feedCard = feedCard
    }

    var title: String {
        feedCard.title
    }

    var content: String {
        feedCard.content
    }

    var commentCount: String {
        String(feedCard.comment)
    }

    var viewCount: String {
        String(feedCard.views)
    }

    func likeAction() {
        print("Feed Liked")
    }

    func commentAction() {
        print("Comments Selected")
    }

    func eyeAction() {
        print("Eye Selected")
    }
}


