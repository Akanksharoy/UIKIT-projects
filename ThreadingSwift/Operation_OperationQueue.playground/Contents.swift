import UIKit

// Operation: -- Any task , it is an abstract class

struct Example {
    
    func doWork() {
        let blockOperation = BlockOperation()
        blockOperation.qualityOfService = .utility
        
        blockOperation.addExecutionBlock {
            debugPrint("Hello")
        }
        blockOperation.addExecutionBlock {
            debugPrint("My name is")
        }
        
        blockOperation.addExecutionBlock {
            debugPrint("Ravi")
        }
        
        //Above we have only added the task
        //below line will execute
        
        /*blockOperation.start()*/   // one way to start executing blockoperation
        // another is operation queue
        
        // if we have to execute multiple operation at once (in one go) then we need to create multiple block operation
        // and add those operations to a queue and this is called operation queue.
        
        let anotherBlockOperation = BlockOperation()
        anotherBlockOperation.addExecutionBlock {
            debugPrint("I am")
        }
        anotherBlockOperation.addExecutionBlock {
            debugPrint("awesome")
        }
        
        
        let operationQueue = OperationQueue()
        // below is one way to add multiple blockoperation
//        operationQueue.addOperation(blockOperation)
//        operationQueue.addOperation(anotherBlockOperation)
        
        // another way to add multiple operation is
        
        operationQueue.addOperations([blockOperation, anotherBlockOperation], waitUntilFinished: false)
        
        //Since you are using operation queue so do, not use start method, it is heavy for the os
        
        //Advantage of operation queue is that we can pause, resume and cancel the task, can also know the status of the task - finished, isready or not
        // In case of dispatch queue we can only cancel the task using workitem
        // Also dependeny management is better with operation queue
        // Question:- What if we add 50 operations in an operationQ, will all execute at once
        // The ans is no , there is a property of operationQ class, maxConcurrentOperationCount , for example if we set it to 5 , only 5 operation will execute at once , but it is not adviced to set(let it be default) it as let the os handle it based on the load it can bear 
    }
    
}
let obj = Example()
obj.doWork()
