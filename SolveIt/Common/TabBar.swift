//
//  TabBar.swift
//  SolveIt
//
//  Created by Daniel Feler on 1/8/23.
//

import SwiftUI
import Introspect
import PopupView

struct MainTabView: View {
    @State var isPresenting = false
    @State private var selectedItem = 1
    @State private var oldSelectedItem = 1
    
    @State private var showChatScreen = false
    @StateObject private var chatViewModel = ChatViewModel()
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedItem){
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }.tag(1)
                SearchScreenView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }.tag(2)
                Text("")
                    .tabItem {
                        Label("Post", systemImage: "plus.square.fill")
                    }.tag(3)
                ToolsView()
                    .tabItem {
                        Label("Study Tools", systemImage: "squareshape.controlhandles.on.squareshape.controlhandles")
                    }.tag(4)
                MessageView()
                    .tabItem {
                        Label("Messages", systemImage: "bell")
                    }.tag(5)
            }
            .onChange(of: selectedItem) {
                if 3 == selectedItem {
                    self.isPresenting = true
                } else {
                    self.oldSelectedItem = $0
                }
            }
            .fullScreenCover(isPresented: $isPresenting, onDismiss: {
                self.selectedItem = self.oldSelectedItem
            }) { CreatePostView() }
                .accentColor(Color(.label))
                .navigationBarTitleDisplayMode(.inline)

            if !showChatScreen {
                ChatBubbleView(showChatScreen: $showChatScreen)
            }
        }
        .sheet(isPresented: $showChatScreen) {
            NavigationView {
                ChatScreenView(showChatScreen: $showChatScreen, viewModel: chatViewModel)
            }
        }
    }
}








struct ToolsView: View {
    @State var toolOpen = false
    @State var aiTools = [AITools]()
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(aiTools, id: \.self) { tool in
                            
                            //TODO: Add navigation link to destination.
                            /*NavigationLink(destination: WriterFormView().navigationBarBackButtonHidden(true), isActive: $toolOpen) {
                             }*/
                            
                            Button {
                                print("\(tool.name) Selected")
                                
                                
                            } label: {
                                ToolCard(title: tool.name, description: tool.description, image: tool.image, color: tool.color)
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                    .frame(maxWidth: geometry.size.width)
                    .padding(.horizontal)
                    .padding(.top, 15)
                    .onAppear {
                        aiTools = [
                            AITools(name: "Writer", description: "Write any essay in minutes",image: "pencil.circle.fill", color: "blue"),
                            AITools(name: "Text Rephraser", description: "Rewrite any piece of text", image: "pencil.and.outline", color: "orange"),
                            AITools(name: "Scanner", description: "Scan any problem for answers", image: "doc.text.fill.viewfinder", color: "yellow"),
                            AITools(name: "Summarizer", description: "Summarize any large amount of text", image: "bookmark.square.fill", color: "purple"),
                            AITools(name: "Topic Cards", description: "Tell us a topic & study it", image: "bookmark.square.fill", color: "green"),
                            AITools(name: "Study Buddy", description: "Turn Audio/Video into Study Material", image: "studentdesk", color: "red")]
                    }
                    
                } }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Study Tools")
                        .font(.system(size: 28,
                                      weight: .bold,
                                      design: .default))
                        .padding(.bottom, 10)
                }
            }
            
        }
    }
}





struct BottomMessage: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("Your message has been sent to Alex")
                .font(.system(size: 15))
                .foregroundColor(.black)
            Spacer()
            Image("avatar2")
                .frame(width: 32, height: 32)
                .cornerRadius(16)
        }
        .padding(16)
        .background(Color.white.cornerRadius(12))
        //.shadowedStyle()
        .padding(.horizontal, 16)
    }
}


struct FeedCards: Codable, Hashable {
    let id, title, subject, content: String
    let like, comment, views: Int
}

struct AITools: Codable, Hashable {
    let name, description, image, color: String
}
