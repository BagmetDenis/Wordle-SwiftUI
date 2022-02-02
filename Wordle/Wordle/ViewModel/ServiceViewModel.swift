//
//  ServiceViewModel.swift
//  Wordle
//
//  Created by Денис Багмет on 02.02.2022.
//

import Foundation

class ServiceViewModel: ObservableObject{
    
    @Published var word: String = ""
    @Published var gridLetters: [[String]] = [
        ["", "", "", "", ""],
        ["", "", "", "", ""],
        ["", "", "", "", ""],
        ["", "", "", "", ""],
        ["", "", "", "", ""],
        ["", "", "", "", ""]]
    
    @Published var gridLettersType: [[TypeLette]] = [[.empty, .empty, .empty, .empty, .empty], [.empty, .empty, .empty, .empty, .empty], [.empty, .empty, .empty, .empty, .empty], [.empty, .empty, .empty, .empty, .empty], [.empty, .empty, .empty, .empty, .empty], [.empty, .empty, .empty, .empty, .empty]]
    
    @Published var currentLine: Int = 0
    
    @Published var isShowAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertDescription: String = ""

    init(){
        self.getWord()
    }
    
    func getWord(){
        self.word = "песня"
    }
    
    func newGame(){
        self.gridLetters = [
            ["", "", "", "", ""],
            ["", "", "", "", ""],
            ["", "", "", "", ""],
            ["", "", "", "", ""],
            ["", "", "", "", ""],
            ["", "", "", "", ""]]
        
        self.gridLettersType = [[.empty, .empty, .empty, .empty, .empty], [.empty, .empty, .empty, .empty, .empty], [.empty, .empty, .empty, .empty, .empty], [.empty, .empty, .empty, .empty, .empty], [.empty, .empty, .empty, .empty, .empty], [.empty, .empty, .empty, .empty, .empty]]
        
        currentLine = 0
        
    }
    
    func addSymbol(symbol: String){
        for item in 0..<self.gridLetters[currentLine].count{
            if self.gridLetters[currentLine][item].isEmpty{
                self.gridLetters[currentLine][item] = symbol
                return
            }
        }
    }
    
    func removeSymbol(){
        for row in 0..<self.gridLetters.count{
            if row == currentLine{
                for item in 0..<gridLetters[row].count{
                    if item == 4{
                        self.gridLetters[row][4] = ""
                    }else if !gridLetters[row][item].isEmpty && gridLetters[row][item + 1].isEmpty{
                        self.gridLetters[row][item] = ""
                    }
                }
            }
        }
    }
    
    func checkWord(){
        for row in 0..<self.gridLetters.count{
            if row == self.currentLine{
                if !self.gridLetters[row][4].isEmpty{
                    
                    for index in 0..<self.gridLetters[row].count{
                        if word.contains(self.gridLetters[row][index]){
                            
                            let arrayWord = word.map({String($0)})
                            
                            self.gridLettersType[row][index] = .contains
                            
                            if arrayWord[index] == gridLetters[row][index]{
                                self.gridLettersType[row][index] = .guess
                            }
                        }else{
                            self.gridLettersType[row][index] = .notFound
                        }
                    }
                    
                    self.checkFinishOrGG()
                    
                    currentLine += 1
                }
            }
        }
    }
    
    func checkFinishOrGG(){
        if self.currentLine == 6{
            self.alertTitle = "Поражение"
            self.alertDescription = "Загаданное слово: \(self.word)"
            self.isShowAlert = true
        }
        else if word == self.gridLetters[currentLine].joined(){
            self.alertTitle = "Победа"
            self.alertDescription = "Загаданное слово: \(self.word)"
            self.isShowAlert = true
        }else if currentLine == 5{
            self.alertTitle = "Поражение"
            self.alertDescription = "Загаданное слово: \(self.word)"
            self.isShowAlert = true
        }
    }
}
