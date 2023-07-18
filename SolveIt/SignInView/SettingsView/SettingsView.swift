//
//  SettingsView.swift
//  SolveIt
//
//  Created by Daniel Feler on 12/24/22.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("")) {
                    if viewModel.guestMode == true {
                        Button(action: {
                            viewModel.signIn()
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "person.circle")
                                    .font(.body)
                                Text("Sign in")
                                    .font(.body)
                            }
                            .foregroundColor(Color(.label))
                        }
                    } else if viewModel.logStatus == true {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Daniel Feler")
                                    .font(.system(size: 25, weight: .bold, design: .default))
                                Text("Joined 2022")
                                    .font(.system(size: 14, weight: .regular, design: .default))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image("verify_badge")
                                .resizable()
                                .frame(width: 50, height: 49)
                        }
                    }
                }
                
                Section(header: Text("")) {
                    NavigationLink(destination: MailView(isPresenting: $viewModel.isPresentingMailView, result: $viewModel.mailViewResult), isActive: $viewModel.isPresentingMailView) {
                        HStack {
                            Image(systemName: "message")
                                .font(.body)
                            Text("Give feedback")
                                .font(.body)
                        }
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(destination: AboutView()) {
                        HStack {
                            Image(systemName: "info.circle")
                                .font(.body)
                            Text("About the app")
                                .font(.body)
                        }
                    }
                }
                
                if viewModel.logStatus != nil && (viewModel.guestMode == nil || viewModel.guestMode == false) {
                    Section(header: Text("")) {
                        Button(action: {
                            viewModel.signOut()
                            presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            HStack {
                                Image(systemName: "door.left.hand.open")
                                    .font(.body)
                                Text("Sign Out")
                                    .font(.body)
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AboutView: View {
    @StateObject var viewModel = AboutViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Button {
                        viewModel.showPrivacyAndTerms = true
                    } label: {
                        HStack {
                            Image(systemName: "doc.text")
                            Text("Privacy and Terms")
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .sheet(isPresented: $viewModel.showPrivacyAndTerms) {
                        SafariView(url: URL(string: "https://www.google.com")!)
                    }
                    Button(action: {
                        print("Rate App")
                    }) {
                        HStack {
                            Image(systemName: "star")
                            Text("Rate this app")
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                } footer: {
                    Text("App version: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")")
                        .foregroundColor(Color(.lightGray))
                        .font(.footnote)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .padding()
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            
        }
        
        
    }
}



