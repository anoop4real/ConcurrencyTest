//
//  ConcurrencyOperation.swift
//  Concurrency
//
//  Created by anoop mohanan on 23/03/18.
//  Copyright © 2018 com.anoopm. All rights reserved.
//

import Foundation

class ConcurrencyOperation: Operation {
    
    let iterations: Int
    let tag: String
    
    init(iterations: Int, tag: String) {
        
        self.iterations = iterations
        self.tag = tag
    }
    override func main() {
        performCalculations()
    }
    func doCalc(){
        
        let x = 100
        let y = x*x
        _ = y/x
    }
    
    func performCalculations(){
        
        let start = CFAbsoluteTimeGetCurrent()
        
        for _ in 0 ..< iterations {
            doCalc()
        }
        let end = CFAbsoluteTimeGetCurrent()
        
        print( "time for \(tag) is \(end-start)" )
    }
}
