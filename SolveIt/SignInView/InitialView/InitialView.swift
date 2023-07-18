//
//  InitialView.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import SwiftUI
import NavigationTransitions

struct InitialView: View {
    @StateObject private var viewModel = InitialViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                PlayerView()
                    .edgesIgnoringSafeArea(.all)
                GeometryReader { geometry in
                    VStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            VStack(alignment: .leading) {
                                HStack {
                                    Image("solveit+brain_white")
                                        .resizable()
                                        .frame(width: 280, height: 53)
                                        .offset(x: -40)

                                    Spacer()
                                }
                                HStack {
                                    Text("Solve Problems")
                                        .font(.system(size: 28, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("Faster.")
                                        .font(.system(size: 28, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            }
                        }
                        .padding(20)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        
                        HStack(alignment: .center, spacing: 10) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: geometry.size.width / 2 - 15, height: 128)
                                .foregroundColor(Color(.gray).opacity(0.5))
                                .overlay(
                                    AIToolsVStack(geometry: geometry)
                                )
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: geometry.size.width / 2 - 15, height: 128)
                                .foregroundColor(Color(.gray).opacity(0.5))
                                .overlay(
                                    FindAnswersVStack(geometry: geometry)
                                )
                        }
                        
                        NavigationLink(destination: SignInView().navigationBarBackButtonHidden(true)) {
                            Text("Sign In")
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                                .background(Color.blue)
                                .cornerRadius(16)
                        }
                        .padding(.top, 20)
                        .buttonStyle(ScaleButtonStyle())
                        Spacer()
                    }
                }
                
            }
            .opacity(viewModel.isShowing ? 1 : 0)
            .onAppear {
                viewModel.startAnimation()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
        .navigationTransition(.slide(axis: .vertical))
        .navigationBarTitleDisplayMode(.inline)
    }
}

