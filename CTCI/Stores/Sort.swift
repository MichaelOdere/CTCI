import UIKit

struct Iteration{
    var pivot:Int
    var wall:Int
    var swapIndex1:Int
    var swapIndex2:Int
    var message:String
}

class Sort{
    
    var arr:Array<Int> = Array(0...9)
    var arrShuffled:Array<Int>!
    var arrSorted:Array<Int>!
    var operations:[Iteration] = []
    
    init(arr: Array<Int>?){
        
        if let arr = arr{
            self.arr = arr
        }
    }
    
    func shuffle(arr: Array<Int>)->Array<Int>{
        
        var tempArr = arr
        for index in 0..<tempArr.count{
            let random =  Int(arc4random_uniform(UInt32(arr.count)))
            let tempVal = tempArr[random]
            tempArr[random] = tempArr[index]
            tempArr[index] = tempVal
        }
        
        return tempArr
    }
    
}

class QuickSort:Sort {
    
    override init(arr: Array<Int>?) {
        super.init(arr: arr)
        
    }
    
    // Sort Functionality
    func partition(arr: inout Array<Int>, low:Int, high:Int)->Int{
        
        let pivot = arr[high]
        var i = (low - 1)
        
        for j in low..<high{
            if arr[j] <= pivot{
                print("The pivot is \(pivot)")
                print("That wall is \(i)")
                print("Swap \(i) and \(j)")
                i += 1
                swap(arr: &arr, first: i, second: j)
                
                let iter = createIteration(index1: i, index2: j, pivot: pivot)
                if let iter = iter{
                    operations.append(iter)
                }
                
            }
        }
        swap(arr: &arr, first: i+1, second: high)
        
        let iter = createIteration(index1: i+1, index2: high, pivot: pivot)
        if let iter = iter{
            operations.append(iter)
        }
        
        return (i + 1)
    }
    
    func sort(arr: inout Array<Int>, low:Int, high:Int){
        
        if low < high{
            let partitionValue = partition(arr: &arr, low: low, high: high)
            
            sort(arr: &arr, low: low, high: partitionValue - 1)
            sort(arr: &arr, low: partitionValue + 1, high: high)
        }
    }
    
    func swap(arr: inout Array<Int>, first:Int, second:Int){
        let temp = arr[first]
        arr[first] = arr[second]
        arr[second] = temp
    }
    
    // Create Iteration and Iteration Info
    func createIteration(index1:Int, index2:Int, pivot:Int)->Iteration?{
        if index1 != index2{
            let message = createActionMessage(index1: index1 , index2: index2)
            let iter = Iteration(pivot: pivot, wall: min(index1 ,index2), swapIndex1: index1 , swapIndex2: index2, message: message)
            return iter
        }
        return nil
    }
    
    func createActionMessage(index1:Int, index2:Int)->String{
        return "Swap values at index: \(index1) and index: \(index2)"
    }
    
    // Functionality Operations
    func reset(){
        self.operations.removeAll()
        self.arrShuffled = shuffle(arr: self.arr)
        self.arrSorted = self.arrShuffled
        var arr = self.arrSorted
        sort(arr: &arr!, low: 0, high: self.arrSorted.count - 1)
    }
    
    
}
