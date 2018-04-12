//
//  Calculations.swift
//  Concurrency
//
//  Created by anoop mohanan on 23/03/18.
//  Copyright © 2018 com.anoopm. All rights reserved.
//

import Foundation

class Calculations {
    
    func doCalc(){
        
        let x = 100
        let y = x*x
        _ = y/x
    }
    
    func performCalculations(_ iteration:Int, tag: String){
        
        let start = CFAbsoluteTimeGetCurrent()
        
        for _ in 0 ..< iteration {
            doCalc()
        }
        let end = CFAbsoluteTimeGetCurrent()
        
        print( "time for \(tag) is \(end-start)" )
    }
}
