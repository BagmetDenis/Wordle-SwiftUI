//
//  ContentView.swift
//  Wordle
//
//  Created by Денис Багмет on 02.02.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var serviceData = ServiceViewModel()
    var body: some View {
        NavigationView{
            VStack(spacing: 5){
                
                Spacer(minLength: 0)
                
                ForEach(serviceData.gridLetters.indices, id: \.self){row in
                    HStack(spacing: 5){
                        ForEach(serviceData.gridLetters[row].indices, id: \.self){index in
                            GridLetterView(symbol: $serviceData.gridLetters[row][index], type: $serviceData.gridLettersType[row][index])
                        }
                    }
                }
                
                Spacer(minLength: 0)
                
                CustomKeyboard()
            }
            .alert(isPresented: $serviceData.isShowAlert) {
                Alert(title: Text(serviceData.alertTitle), message: Text(serviceData.alertDescription), dismissButton: .default(Text("Новая игра")){
                    serviceData.newGame()
                })
            }
            .navigationTitle("Wordle")
            
        }
        .navigationViewStyle(.stack)
        .environmentObject(serviceData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ServiceViewModel())
    }
}
