//
//  CreatePostView.swift
//  SolveIt
//
//  Created by Daniel Feler on 2/15/23.
//

import SwiftUI

struct CreatePostView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: CreatePostViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: CreatePostViewModel())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    viewModel.chooseSubject()
                }) {
                    HStack {
                        Image(systemName: "books.vertical")
                            .foregroundColor(.primary)
                        
                        if viewModel.selectedSubject != nil {
                            Text(viewModel.selectedSubject!.name)
                                .foregroundColor(.primary)
                        } else {
                            Text("Choose a topic")
                                .foregroundColor(.primary)
                        }
                        Spacer()
                        Image(systemName: "arrowtriangle.down.circle")
                            .foregroundColor(.primary)
                    }
                    .padding()
                }
                .sheet(isPresented: $viewModel.showSheet) {
                    SubjectListView(viewModel: viewModel)
                }
                .frame(minWidth: 0, maxWidth: .infinity)

                HStack(alignment: .firstTextBaseline) {
                    Text("Posting as  ·")
                    Text(viewModel.username)
                    Spacer()
                }
                .font(.system(size: 12, weight: .regular, design: .default))
                .padding([.leading, .trailing, .top], 20)
                TextField("Write a specific title", text: $viewModel.titleText)
                    .padding([.leading, .trailing], 20)
                TextView(placeholder: "Keep it relevant. If the community flags your post for going off topic it will be invisible to the community.", text: $viewModel.text, minHeight: viewModel.textHeight, calculatedHeight: $viewModel.textHeight)
                    .frame(minHeight: viewModel.textHeight, maxHeight: viewModel.textHeight)
                    .padding()
                Spacer()
            }
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                }),
                trailing: NavigationLink(destination: Text("Post Detail View"), isActive: .constant(false), label: {
                    Text("Post")
                })
                .disabled(viewModel.text.isEmpty)
            )
        }
    }
}



struct SubjectListView: View {
    @ObservedObject var viewModel: CreatePostViewModel
    
    var subjects: [Subject] {
        guard let subjects: [Subject] = loadJSONData(from: "subjectFeed") else {
            return []
        }
        return subjects
    }
    
    var body: some View {
        NavigationView {
            List(subjects) { subject in
                Button(action: {
                    viewModel.selectSubject(subject)
                }) {
                    Text(subject.name)
                }
            }
            .navigationTitle("Choose a topic")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct ContentView: View {
    var body: some View {
        CreatePostView()
    }
}
