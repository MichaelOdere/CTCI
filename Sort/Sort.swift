import UIKit

struct Iteration{
    var pivot:Int?
    var wall:Int?
    var swapIndex1:Int
    var swapIndex2:Int
    var message:String?
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
            
            let iterCompare = createIterationCompare(index1: j, index2: high, wall: i+1)
            if let iterCompare = iterCompare{
                operations.append(iterCompare)
            }
            if arr[j] <= pivot{

                i += 1

                swap(arr: &arr, first: i, second: j)
                
                let iterSwap = createIterationSwap(index1: i, index2: j, pivot: pivot)
                if let iterSwap = iterSwap{
                    operations.append(iterSwap)
                }
                
            }
        }
        swap(arr: &arr, first: i+1, second: high)
        
        let iter = createIterationSwap(index1: i+1, index2: high, pivot: pivot)
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
    func createIterationSwap(index1:Int, index2:Int, pivot:Int)->Iteration?{
        if index1 != index2{
            let message = "Swap values at index \(index1) and \(index2)"
            let iter = Iteration(pivot: pivot, wall: min(index1 ,index2), swapIndex1: index1 , swapIndex2: index2, message: message)
            return iter
        }
        return nil
    }
    
    func createIterationCompare(index1:Int, index2:Int, wall:Int)->Iteration?{
        if index1 != index2{
            let message = "Compare values at index \(index1) and \(index2)"
            let iter = Iteration(pivot: nil, wall: nil, swapIndex1: index1 , swapIndex2: index2, message: message)
            return iter
        }
        return nil
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
