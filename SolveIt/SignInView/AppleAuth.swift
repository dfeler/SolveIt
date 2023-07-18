//
//  AppleAuth.swift
//  SolveIt
//
//  Created by Daniel Feler on 12/24/22.
//

import SwiftUI
import AuthenticationServices
import CryptoKit

var currentNonce: String?
class AppleSignInHandler: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    @AppStorage("logStatus") var logStatus = false
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // first window in the current window scene as the presentation anchor for the ASAuthorizationController
        return UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .flatMap { $0?.windows.first } ?? UIApplication.shared.windows.first!
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Apple Sign In was successful.
            withAnimation {
                logStatus = true
            }
            
            
            let userFullName = appleIDCredential
            
            print("Firstname is: \(userFullName.fullName?.givenName ?? "")")
            print("Lastname is: \(userFullName.fullName?.familyName ?? "")")
            print("Email is: \(userFullName.email ?? "")")
            print("User is: \(userFullName.user )")
            
            
            //MARK: Token
            let data: Data = userFullName.identityToken!
            let encoding: String.Encoding = .utf8
            
            if let string = String(data: data, encoding: encoding) {
                print("Token is: \(string)")
            }
            
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        switch (error as NSError).code {
        case ASAuthorizationError.canceled.rawValue:
            print("Apple Sign In was cancelled by the user.")
        case ASAuthorizationError.failed.rawValue:
            print("Apple Sign In failed with error: \(error.localizedDescription)")
        case ASAuthorizationError.invalidResponse.rawValue:
            print("Apple Sign In failed with error: \(error.localizedDescription)")
        case ASAuthorizationError.notHandled.rawValue:
            print("Apple Sign In failed with error: \(error.localizedDescription)")
        case ASAuthorizationError.unknown.rawValue:
            print("Apple Sign In failed with error: \(error.localizedDescription)")
        default:
            print("Apple Sign In failed with error: \(error.localizedDescription)")
        }
    }
}

struct CustomAppleSignInButton: View {
    let appleSignInHandler = AppleSignInHandler()
    
    var body: some View {
        Button(action: {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let nonce = randomNonceString()
            currentNonce = nonce
            request.nonce = sha256(nonce)
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = appleSignInHandler
            authorizationController.presentationContextProvider = appleSignInHandler
            authorizationController.performRequests()
        }) {
            HStack {
                Image(systemName: "apple.logo")
                    .resizable()
                    .frame(width: 21, height: 27)
                    .foregroundColor(Color("black")
                    )
                Text("Continue With Apple")
                    .foregroundColor(Color("black"))
                    .font(.system(size: 15, weight: .bold, design:
                            .rounded)
                    )
                
            }
            .padding()
            .frame(width: 340, height: 55)
            .background(Color(.label))
            .cornerRadius(28)
            
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    
    return result
}

func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
    }.joined()
    
    return hashString
}




struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}


