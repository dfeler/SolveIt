//
//  SignInViewModel.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var showTermsOfUse = false
    @Published var showPrivacyPolicy = false
    @AppStorage("guestMode") var guestMode = false
}
