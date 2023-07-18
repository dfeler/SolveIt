//
//  SafariView.swift
//  SolveIt
//
//  Created by Daniel Feler on 1/7/23.
//

import SwiftUI
import Foundation
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}
