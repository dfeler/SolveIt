//
//  ChatScreenView.swift
//  SolveIt
//
//  Created by Daniel Feler on 3/29/23.
//

import SwiftUI

struct ChatScreenView: View {
    @Binding var showChatScreen: Bool
    @ObservedObject var viewModel: ChatViewModel
    @State private var inputText: String = ""
    @State private var isImagePickerShown = false
    @State private var selectedImage: UIImage?
    @State private var showingActionSheet = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.messages) { message in
                        MessageConvoView(message: message)
                    }
                }
                .padding()
            }
            
            HStack {
                GrowingTextEditor(text: $inputText)
                    .frame(height: max(40, min(inputText.heightWithConstrainedWidth(width: UIScreen.main.bounds.width * 0.6, font: UIFont.systemFont(ofSize: 17)), 120)))
                    .padding(.leading)
                
                if inputText.isEmpty {
                    Button(action: {
                        showingActionSheet = true
                    }) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color(.systemBlue))
                    }
                }
                Button(action: {
                    print("Attach Image")
                }) {
                    Image(systemName: "paperplane")
                        .font(.system(size: 24))
                        .foregroundColor(Color.white)
                        .padding(12)
                        .background(inputText.isEmpty ? Color(.systemGray) : Color(.systemBlue))
                        .clipShape(Circle())
                }
                .disabled(inputText.isEmpty)
            }
            .padding()
        }
        .navigationBarTitle("AI Copilot")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button("Close") {
            withAnimation {
                showChatScreen.toggle()
            }
        })
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Add Image"), message: Text("Select an image from the camera roll or take a new photo"), buttons: [
                .default(Text("Camera"), action: {
                    sourceType = .camera
                    isImagePickerShown = true
                }),
                .default(Text("Photo Library"), action: {
                    sourceType = .photoLibrary
                    isImagePickerShown = true
                }),
                .cancel()
            ])
        }
        .sheet(isPresented: $isImagePickerShown, onDismiss: {
           
        }) {
            ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
        }
    }
}





