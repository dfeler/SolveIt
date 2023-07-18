//
//  CreatePostViewModel.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import SwiftUI

class CreatePostViewModel: ObservableObject {
    @Published var username: String = "dfeler"
    @Published var postTitle: String = ""
    @Published var responseText: String = ""
    @Published var titleText: String = ""
    @Published var text: String = ""
    @Published var textHeight: CGFloat = 150
    @Published var showSheet = false
    @Published var selectedSubject: Subject? = nil
    
    var presentationMode: Binding<PresentationMode>?
    
    init(presentationMode: Binding<PresentationMode>? = nil) {
        self.presentationMode = presentationMode
    }
    
    func cancel() {
        presentationMode?.wrappedValue.dismiss()
    }
    
    func post() {
    }
    
    func chooseSubject() {
        showSheet = true
    }
    
    func selectSubject(_ subject: Subject) {
        selectedSubject = subject
        showSheet = false
    }
}

