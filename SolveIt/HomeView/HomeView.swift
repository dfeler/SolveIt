//
//  HomeView.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State var selectedCard: FeedCards?

    var body: some View {
        ZStack {
            if let selectedCard = selectedCard {
                NavigationLink(destination: PostDetailView(viewModel: PostDetailViewModel(feedCard: selectedCard), feedCard: selectedCard), isActive: $viewModel.isOpenOutside) {
                    Color.clear
                }
            }

            NavigationView {
                ScrollView(.vertical) {
                    VStack {
                        LazyVGrid(columns: [GridItem(.flexible())]) {
                            ForEach(viewModel.feedData, id: \.self) { card in
                                let cardModel = FeedCardModel(
                                    title: card.title,
                                    subject: card.subject,
                                    description: card.content,
                                    liked: card.like,
                                    comments: card.comment,
                                    views: card.views
                                )
                                let cardViewModel = FeedCardViewModel(model: cardModel)

                                FeedCard(viewModel: cardViewModel)
                                    .onTapGesture {
                                        selectedCard = card
                                        viewModel.isOpenOutside = selectedCard != nil
                                    }
                            }

                        }
                        .padding(.top, 20)
                        Spacer()
                    }
                    .onAppear {
                        viewModel.showWelcome = true
                    }
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Image("solveit+brain")
                                .resizable()
                                .frame(width: 160, height: 30)
                                .padding([.top, .bottom], 10)
                            
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                viewModel.showSettings = true
                            } label: {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .padding([.top, .trailing], 10)
                                    .padding(.bottom, 15)
                                    .foregroundColor(.blue)
                            }
                            .sheet(isPresented: $viewModel.showSettings) {
                                SettingsView()
                            }
                            
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

