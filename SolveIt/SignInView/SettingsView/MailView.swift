//
//  MailView.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import SwiftUI
import MessageUI

struct MailView: UIViewControllerRepresentable {
    @Binding var isPresenting: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        guard MFMailComposeViewController.canSendMail() else {
            fatalError("Cannot open mail view in simulator")
        }
        
        let controller = MFMailComposeViewController()
        controller.mailComposeDelegate = context.coordinator
        controller.setToRecipients(["dfeler99@gmail.app"])
        controller.setSubject("SolveIt App Feedback")
        
        let device = UIDevice.current
        let deviceModel = device.model
        let systemName = device.systemName
        let systemVersion = device.systemVersion

        controller.setMessageBody("Hello,\n\nI have some feedback for the SolveIt App:\n\n\nDo not edit below this line:\nDevice: \(deviceModel)\nOS: \(systemName) \(systemVersion)", isHTML: false)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isPresenting: $isPresenting, result: $result)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isPresenting: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(isPresenting: Binding<Bool>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isPresenting = isPresenting
            _result = result
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            self.result = .success(result)
            isPresenting = false
        }
    }
}
