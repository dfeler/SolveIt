//
//  PostDetailView.swift
//  SolveIt
//
//  Created by Daniel Feler on 1/3/23.
//

import SwiftUI

struct PostDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: PostDetailViewModel
    
    let placeholder = "Enter Text Here"
    let feedCard: FeedCards
    
    
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.left.circle")
            Image("brainSmall")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
        }
    }
    }
    
    
    var body: some View {
        NavigationView {
                    VStack(alignment: .leading) {
                        Text(viewModel.title)
                            .font(.system(size: 18, weight: .bold, design: .default))
                            .multilineTextAlignment(.leading)
                            .lineLimit(4)
                            .padding()
                        Text(viewModel.content)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .lineLimit(nil)
                            .padding()
                        
                        HStack(alignment: .bottom) {
                            FeedActionButton(title: "Like", image: "heart", action: viewModel.likeAction)
                            Spacer()
                            FeedActionButton(title: viewModel.commentCount, image: "bubble.left", action: viewModel.commentAction)
                            Spacer()
                            FeedActionButton(title: viewModel.viewCount, image: "eye", action: viewModel.eyeAction)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        
                        Spacer()
                    }
                }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .navigationTitle("")
        .padding()
        Spacer()
    }
}


