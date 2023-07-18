//
//  SettingsViewModel.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import SwiftUI
import MessageUI

class SettingsViewModel: ObservableObject {
    @Published var isPresentingMailView = false
    @Published var mailViewResult: Result<MFMailComposeResult, Error>?
    @AppStorage("logStatus") var logStatus: Bool?
    @AppStorage("guestMode") var guestMode: Bool?
    
    func signIn() {
        logStatus = false
        guestMode = false
    }
    
    func signOut() {
        logStatus = false
    }
}

class AboutViewModel: ObservableObject {
    @Published var showPrivacyAndTerms = false
}

class MailViewModel: ObservableObject {
    @Binding var isPresenting: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    init(isPresenting: Binding<Bool>, result: Binding<Result<MFMailComposeResult, Error>?>) {
        _isPresenting = isPresenting
        _result = result
    }
}
