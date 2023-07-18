//
//  SignInView.swift
//  SolveIt
//
//  Created by Daniel Feler on 12/24/22.
//


import SwiftUI
import AuthenticationServices
import Firebase
import AVFoundation
import AVKit
import NavigationTransitions



struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = SignInViewModel()

    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            ZStack {
                Color("black")
                    .ignoresSafeArea()
                VStack(alignment: .center) {
                    Image(systemName: "arrowtriangle.up.circle.fill")
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color(.lightGray))
                        .padding(.top, 10)
                    Text("Go back")
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .foregroundColor(Color(.lightGray))
                }
                .padding([.top, .bottom], 28)
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    Image("solveit+brain")
                        .resizable()
                        .frame(width: 320, height: 60)
                        .padding([.top, .bottom], 20)
                        .offset(x: -10)
                    Text("Learn faster with SolveIt.")
                        .frame(maxWidth: 300)
                        .font(.system(size: 25.5, weight: .bold, design: .default))
                        .foregroundColor(Color(.label))
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding(.top, 10)
                    Text("Effortless question help in minutes!")
                        .frame(maxWidth: 300)
                        .font(.system(size: 25.5, weight: .bold, design: .default))
                        .foregroundColor(Color(.label))
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .padding(.top, 10)
                        .foregroundColor(Color(.label))
                    CustomAppleSignInButton()
                        .padding([.top, .bottom], 10)
                    SignInWithGoogle(image: Image("google"), text: ("Sign In With Google"))
                    Separator(label: "OR")
                    NavigationLink(destination: MainTabView().navigationBarBackButtonHidden(true), isActive: $viewModel.guestMode) {
                        GuestButton {
                            viewModel.guestMode = true
                        }
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 0) {
                        Text("By signing in you accept our")
                            .fixedSize()
                            .font(.system(size: 16, weight: .regular, design: .default))
                        HStack(spacing: 0) {
                            BoldClickableText(text: "Terms of use", isPresented: $viewModel.showTermsOfUse) {
                                SafariView(url: URL(string: "https://google.com")!)
                            }
                            .fixedSize()
                            Text(" and")
                                .fixedSize()
                                .font(.system(size: 16, weight: .regular, design: .default))
                            BoldClickableText(text: " Privacy policy", isPresented: $viewModel.showPrivacyPolicy) {
                                SafariView(url: URL(string: "https://apple.com")!)
                            }
                            .fixedSize()
                            .font(.system(size: 16, weight: .regular, design: .default))
                            Text(".")
                                .fixedSize()
                                .font(.system(size: 16, weight: .regular, design: .default))
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        backButton
                    }
                }
                .navigationBarTitle("")
                .padding()
                .overlay(
                    ZStack {
                        if viewModel.isLoading {
                            Color.black
                                .opacity(0.25)
                                .ignoresSafeArea()
                            ProgressView()
                                .font(.title2)
                                .frame(width: 40, height: 60)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    }
                )
            }
        }
    }
}




struct SignInWithGoogle: View {
    let google = HandleSignIn()
    var image: Image
    var text: String
    
    var body: some View {
        
        ZStack{
            Button {
                google.signInWithGoogle()
            } label: {
                
                Label {
                    Text("Continue with Google")
                        .foregroundColor(Color(.label))
                } icon: {
                    Image("google")
                        .resizable()
                        .frame(width: 21, height: 21)
                    //.scaledToFit()
                }
                
                .padding()
                .frame(width: 340, height: 55)
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .background(Color("lightgray"))
                .cornerRadius(28)
                
                
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding(.horizontal)
        
    }
}

struct BoldClickableText<Content: View>: View {
    let text: String
    @Binding var isPresented: Bool
    let content: () -> Content
    
    var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.blue)
            .onTapGesture {
                self.isPresented = true
            }
            .sheet(isPresented: $isPresented) {
                self.content()
            }
    }
}

struct GuestButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(" Preview as Guest ")
                .font(.system(size: 14, weight: .bold, design: .default))
                .foregroundColor(Color(.label))
                .padding()
                .background(Color("lightgray"))
                .cornerRadius(28)
        }
        .buttonStyle(ScaleButtonStyle())
        
    }
}

struct Separator: View {
    
    let label: String
    let horizontalPadding: CGFloat
    let color: Color
    
    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }
    
    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color)
            line
        }
    }
    
    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}

struct AIToolsVStack: View {
    let geometry: GeometryProxy
    
    var body: some View {
        VStack {
            Image("computer_ai")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack {
                Text("Premium AI Tools")
                    .font(.system(size: 14,
                                  weight: .medium,
                                  design: .default))
                    .frame(width: geometry.size.width / 2 - 15, height: 20)
                
                    .foregroundColor(.white)
                    .background(Color(.gray).opacity(0.6))
                    .cornerRadius(20, corners: .bottomLeft)
                    .cornerRadius(20, corners: .bottomRight)
            }
        }
    }
}

struct FindAnswersVStack: View {
    let geometry: GeometryProxy
    
    var body: some View {
        VStack {
            Image("book_stack")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack {
                Text("Find Answers")
                    .font(.system(size: 14,
                                  weight: .medium,
                                  design: .default))
                    .frame(width: geometry.size.width / 2 - 15, height: 20)
               
                    .foregroundColor(.white)
                    .background(Color(.gray).opacity(0.6))
                    .cornerRadius(20, corners: .bottomLeft)
                    .cornerRadius(20, corners: .bottomRight)
            }
        }
    }
}


struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}





