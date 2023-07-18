//
//  FeedCardView.swift
//  SolveIt
//
//  Created by Daniel Feler on 12/26/22.
//

import SwiftUI

struct FeedCard: View {
    @ObservedObject var viewModel: FeedCardViewModel
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text(viewModel.title)
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color(.label))
                                .lineLimit(2)
                                .padding(.bottom, 10)
                            
                            Spacer()
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(viewModel.getColorForSubject(subject: viewModel.subject))

                                .frame(width: 85, height: 22)
                              Text(viewModel.subject)
                                .font(.system(size: 11, weight: .bold, design: .default))
                                .foregroundColor(.white)
                                .frame(width: 86, height: 22)
                            }
                        }
                        
                        Text(viewModel.description)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color(.label))
                            .lineLimit(3)
                    }
                    
                    Spacer()
                    HStack(alignment: .bottom) {
                        FeedActionButton(title: "Like", image: "heart", action: viewModel.likeAction)
                        Spacer()
                        FeedActionButton(title: viewModel.comments, image: "bubble.left", action: viewModel.commentAction)
                        Spacer()
                        FeedActionButton(title: viewModel.views, image: "eye", action: viewModel.viewAction)
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.bottom, .leading, .trailing], 15)
                }
            }
            .padding([.top, .leading, .trailing], 15)
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 200)
        .background(Color("gray"))
        .cornerRadius(10)
        .shadow(color: Color(.lightGray).opacity(0.4), radius: 5)
        .padding(.bottom, 5)
    }
}

struct FeedActionButton: View {
    var title: String
    var image: String
    var action: ()->Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Label {
                Text(title)
            } icon: {
                Image(systemName: image)
            }
            
        }
        .foregroundColor(Color(.lightGray))
    }
}


