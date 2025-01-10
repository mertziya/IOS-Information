//
//  ViewController.swift
//  ARC_Example
//
//  Created by Mert Ziya on 9.01.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var mert : Person?
    var horse : Horse?
    
    var dataFetcher : DataFetcher?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        createObjects()
        assignProperties() // deinit part doesnt works since it will create a retain cycle.
        nullifyTheProperties()
        
        
        weakService()
        strongService()
        
    }
    
    private func createObjects(){
        mert = Person(name: "mert", horse: nil)
        horse = Horse(name: "beyaz saray", owner: nil)
        print(mert?.name ?? "asd")
    }
    
    private func assignProperties(){
        mert?.horse = horse
        horse?.owner = mert
    }
    
    private func nullifyTheProperties(){
        mert = nil
        horse = nil
    }
    
    private func weakService(){
        dataFetcher = DataFetcher()
        dataFetcher?.identifier = "WEAK"
        dataFetcher?.weakFetchData()
        dataFetcher = nil
    }
    
    private func strongService(){
        dataFetcher = DataFetcher()
        dataFetcher?.identifier = "STRONG"
        dataFetcher?.strongFetchData()
        dataFetcher = nil
    }

}

class Horse {
    let name : String
    unowned var owner : Person?
    
    init(name: String, owner: Person?) {
        self.name = name
        self.owner = owner
    }
    
    
    deinit {
        print("Horse named \(name) is being cleaned from the memory")
    }
}

class Person {
    let name : String
    weak var horse : Horse?
    
    init(name: String, horse: Horse?) {
        self.name = name
        self.horse = horse
        
    }
    
    deinit {
        print("Person named \(name) is being cleaned from the memory")
    }
}

