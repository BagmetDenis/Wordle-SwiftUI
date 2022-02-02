//
//  CustomKeyboard.swift
//  Wordle
//
//  Created by Денис Багмет on 02.02.2022.
//

import SwiftUI

func simpleSuccess() {
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    impactMed.impactOccurred()
}

struct CustomKeyboard: View {
    @EnvironmentObject var serviceData: ServiceViewModel
    let keyboardSymbols = [["й", "ц", "у", "к", "е", "н", "г", "ш", "щ", "з", "х", "ъ"], ["ф", "ы", "в", "а", "п", "р", "о", "л", "д", "ж", "э"],  ["clear", "я", "ч", "с", "м", "и", "т", "ь", "б", "ю", "check"]]
    var body: some View {
        VStack(spacing: 10){
            ForEach(keyboardSymbols.indices, id: \.self){row in
                HStack(spacing: 5){
                    ForEach(keyboardSymbols[row].indices, id: \.self){indexLetter in
                        if keyboardSymbols[row][indexLetter] == "clear"{
                            Button {
                                serviceData.removeSymbol()
                            } label: {
                                Image(systemName: "delete.left.fill")
                                    .imageScale(.large)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            }
                            .buttonStyle(.plain)
                        }else if keyboardSymbols[row][indexLetter] == "check"{
                            Button {
                                serviceData.checkWord()
                            } label: {
                                Image(systemName: "checkmark.rectangle.fill")
                                    .imageScale(.large)
                                    .padding(10)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            }
                            .buttonStyle(.plain)
                        }else{
                            Button {
                                serviceData.addSymbol(symbol: keyboardSymbols[row][indexLetter])
                                simpleSuccess()
                            } label: {
                                ButtonCustomKeyboard(symbol: keyboardSymbols[row][indexLetter])
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
    }
}

struct ButtonCustomKeyboard: View{
    var symbol: String
    var body: some View{
        VStack{
            Text(symbol)
                .font(.title)
                .padding(5)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
        }
        
    }
}

struct CustomKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        CustomKeyboard()
    }
}
