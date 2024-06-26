//
//  File.swift
//  
//
//  Created by Andy Torres on 25-06-24.
//

import Foundation
import SwiftUI

struct SheetView: View {
    @Environment(\.presentationMode) var presentationMode
    var title: String
    var message: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "multiply.circle")
                        .font(.title)
                }
                .padding()
            }
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom)
                
                Text(message)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding(20)
            Spacer()
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(title: "Title", message: "Message")
    }
}
