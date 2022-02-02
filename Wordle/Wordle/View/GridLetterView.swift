//
//  LetterView.swift
//  Wordle
//
//  Created by Денис Багмет on 02.02.2022.
//

import SwiftUI

struct GridLetterView: View {
    @Binding var symbol: String
    @Binding var type: TypeLette
    var body: some View {
        ZStack{
            if type == .contains{
                Color.yellow
            }else if type == .guess{
                Color.green
            }else if type == .notFound{
                Color.gray.opacity(0.3)
            }
            
            Text(symbol)
                .fontWeight(.bold)
                .font(.largeTitle)
        }
        .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6)
        .overlay(RoundedRectangle(cornerRadius: 5).stroke())
        .cornerRadius(5)
        
    }
}

struct LetterView_Previews: PreviewProvider {
    static var previews: some View {
        GridLetterView(symbol: .constant("F"), type: .constant(.notFound))
    }
}
