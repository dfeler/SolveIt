//
//  FeedCardViewModel.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import SwiftUI


class FeedCardViewModel: ObservableObject {
    @Published var model: FeedCardModel
    
    init(model: FeedCardModel) {
        self.model = model
    }
    
    var title: String { model.title }
    var subject: String { model.subject }
    var description: String { model.description }
    var liked: String { String(model.liked) }
    var comments: String { String(model.comments) }
    var views: String { String(model.views) }

    func likeAction() {
        print("Feed Liked")
    }
    
    func commentAction() {
        print("Comments Selected")
    }
    
    func viewAction() {
        print("Eye Selected")
    }
    
    func getColorForSubject(subject: String) -> Color {
        let mintGreen = Color(red: 0.6, green: 1.0, blue: 0.6)
        let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
        let cyan = Color(red: 0, green: 1, blue: 1)
        let brown = Color(red: 0.6, green: 0.4, blue: 0.2)
        
        switch subject {
        case "Biology":
            return Color.blue
        case "Physics":
            return Color.purple
        case "Chemistry":
            return Color.orange
        case "History":
            return brown
        case "English":
            return Color.red
        case "Economics":
            return Color.yellow
        case "Geography":
            return cyan
        case "Art":
            return Color.pink
        case "Algebra":
            return mintGreen
        case "Geometry":
            return Color.green
        case "Calculus":
            return Color.orange
        case "Statistics":
            return Color.red
        case "Astronomy":
            return Color.black
        case "Trigonometry":
            return Color.pink
        case "Music":
            return magenta
        default:
            return Color.gray
        }
    }
}
