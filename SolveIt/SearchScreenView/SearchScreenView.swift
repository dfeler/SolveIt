//
//  SearchScreenView.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import SwiftUI

struct SearchScreenView: View {
    var list: [String] = []
    @State var searchText = String()
    @State private var tabBar: UITabBar? = nil
    var body: some View {
        NavigationView {
            
            VStack(alignment: .center) {
                Spacer(minLength: 0)
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                if list.isEmpty {
                    VStack {
                        Spacer()
                        ZStack {
                            Lottielmage(animationName: "search", loopMode: .playOnce, pauseTime: 1)
                                .frame(width: 150, height: 150)
                            Text("Got a question? Get some help!")
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .foregroundColor(Color("grayTextColor"))
                                .padding(.top, 120)
                        }
                        .padding(.bottom, 10)
                        Spacer()
                    }
                } else {
                    List(list, id: \.self) { item in
                        Text(item)
                    }
                }
                Spacer()
            }
            .padding(.bottom, 20)

            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
