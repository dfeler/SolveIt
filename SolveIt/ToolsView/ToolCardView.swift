//
//  ToolCardView.swift
//  SolveIt
//
//  Created by Daniel Feler on 12/26/22.
//

import SwiftUI

struct ToolCard: View {
    var title: String
    var description: String
    var image: String
    var color: String
    var body: some View {
        
        VStack(alignment: .leading) {
            Spacer()
            Group {
                Text(title)
                    .font(.system(size: 25,
                                  weight: .bold,
                                  design: .default))
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5)
                
                Text(description)
                    .font(.system(size: 18,
                                  weight: .regular,
                                  design: .default))
                    .multilineTextAlignment(.leading)
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(alignment: .leading)
            
            HStack {
                Spacer()
                Image(systemName: image)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .padding([.leading, .trailing], 15)
                    .padding(.top, 5)
            }
            Spacer()
            
        }
        .padding()
        .foregroundColor(.white)
        .background(Color(color))
        .cornerRadius(20)
        .shadow(color: Color(.lightGray).opacity(0.4), radius: 10)
        
    }
}
