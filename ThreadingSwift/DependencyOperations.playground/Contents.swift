import UIKit

struct Employee
{
    func syncOfflineEmployeeRecords() {
        debugPrint("Syncing offline employee records...")
        Thread.sleep(forTimeInterval: 2)
        debugPrint("Offline employee records synced successfully.")
    }
    
}

struct Department
{
    func syncOfflineDepartmentRecords() {
        debugPrint("Syncing offline department records...")
        Thread.sleep(forTimeInterval: 2)
        debugPrint("Offline department records synced successfully.")
    }
}

struct SyncManager
{
    func syncAllOfflineRecords() {
        /*
        let employeeSyncOperation = BlockOperation ()
            
        employeeSyncOperation.addExecutionBlock {
            let employee = Employee()
            employee.syncOfflineEmployeeRecords()
        }
        
        let departmentSyncOperation = BlockOperation ()
            
        departmentSyncOperation.addExecutionBlock {
            let department = Department()
            department.syncOfflineDepartmentRecords()
        }
        departmentSyncOperation.addDependency(employeeSyncOperation)
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(employeeSyncOperation)
        operationQueue.addOperation(departmentSyncOperation)
         */
        
        // Lets see how we caqn do the above work using serial queue
        
//        let serialQueue = DispatchQueue(label: "com.example.serialQueue")
//        serialQueue.async{
//            let employee = Employee()
//            employee.syncOfflineEmployeeRecords()
//        }
//        serialQueue.async {
//            let department = Department()
//            department.syncOfflineDepartmentRecords()
//        }
        
        // Code readibility is better in operation queue , so will use it in these cases of dependency
    }
}

let obj = SyncManager()
obj.syncAllOfflineRecords()
