//
//  ViewController.swift
//  Concurrency
//
//  Created by anoop mohanan on 23/03/18.
//  Copyright © 2018 com.anoopm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let calc = Calculations()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.execute()
        //self.executeBlocOp()
        //self.executeOpnQueueSubclass()
    }

    // Execute in concurrent and serial queue
    func execute(){
        
        let concurrentQueue = DispatchQueue(label: "com.example.anoop", attributes:.concurrent)
        let serialQueue = DispatchQueue(label: "com.example.anoop")
        
        concurrentQueue.async {[weak self] in
            self?.calc.performCalculations(1000, tag: "async1")
            self?.calc.performCalculations(1000, tag: "async5")
        }
        concurrentQueue.async {[weak self] in
            self?.calc.performCalculations(10000, tag: "async2")
        }
        concurrentQueue.async {[weak self] in
            self?.calc.performCalculations(1000000, tag: "async3")
        }
        
//        serialQueue.async {[weak self] in
//            self?.calc.performCalculations(1000, tag: "sync1")
//        }
//        serialQueue.async {[weak self] in
//            self?.calc.performCalculations(10000, tag: "sync2")
//        }
//        serialQueue.async {[weak self] in
//            self?.calc.performCalculations(1000000, tag: "sync3")
//        }
    }
    
    // Use block operation
    func executeBlocOp(){
        
        let blockOp1 = BlockOperation {[weak self] in
            self?.calc.performCalculations(1000000, tag: "Operation 1")
        }
        
        blockOp1.addExecutionBlock {[weak self] in
            self?.calc.performCalculations(100000, tag: "Operation 2")
        }
        
        blockOp1.addExecutionBlock {[weak self] in
            self?.calc.performCalculations(1000, tag: "Operation 3")
        }
        
        let operationQueue = OperationQueue()
        // Tasks will be executed in FIFO order
        operationQueue.addOperation(blockOp1)
    }
    
    // Subclass of operation
    func executeOpnQueueSubclass(){
        
        let opqueue = OperationQueue()
        
        opqueue.addOperation(ConcurrencyOperation(iterations: 1000000, tag: "SubOperation 1"))
        
        opqueue.addOperation(ConcurrencyOperation(iterations: 100000, tag: "SubOperation 2"))
        
        opqueue.addOperation(ConcurrencyOperation(iterations: 1000, tag: "SubOperation 3"))
    }

}

