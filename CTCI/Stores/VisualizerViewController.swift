import UIKit

class VisulizerViewController:UIViewController{
    
    @IBOutlet weak var visualView: UIView!
    var visualObjects:[VisualObject]!
    var operations:[(Int, Int)] = []
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.purple, UIColor.yellow]
    override func viewDidLoad() {
        visualObjects = initializeVisualObjects()
        
        for object in visualObjects{
            visualView.addSubview(object)
        }
        
        let slideButton = UIButton(frame: CGRect(x: self.view.frame.width / 2 - 50, y: self.view.frame.height * 4/5, width: 100, height: 20))
        slideButton.addTarget(self, action:#selector(animateObjects), for: .touchUpInside)
        slideButton.titleLabel?.text = "Slide in!"
        slideButton.backgroundColor = UIColor.red
        self.view.addSubview(slideButton)
        
        let swapButton = UIButton(frame: CGRect(x: self.view.frame.width / 2 - 50, y: self.view.frame.height * 4/5 + 20, width: 100, height: 20))
        swapButton.addTarget(self, action:#selector(swapObjectsButton), for: .touchUpInside)
        swapButton.titleLabel?.text = "Swap!"
        swapButton.backgroundColor = UIColor.blue
        self.view.addSubview(swapButton)
        
        let sortButton = UIButton(frame: CGRect(x: self.view.frame.width / 2 - 50, y: self.view.frame.height * 4/5 + 40, width: 100, height: 20))
        swapButton.addTarget(self, action:#selector(sortObjects), for: .touchUpInside)
        swapButton.titleLabel?.text = "Swap!"
        swapButton.backgroundColor = UIColor.purple
        self.view.addSubview(swapButton)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateObjects()
        
    }
    
    func initializeVisualObjects()->[VisualObject]{
        
        let width = visualView.frame.width/10
        
        var objects:[VisualObject] = []
        var nums = Array(0...9)
        
        nums = shuffleArray(arr: nums)
        
        for last in 0..<nums.count{
            
            let index = nums.count - 1 - last
            let num = nums[index]
            let frame = CGRect(x: width * CGFloat(index) + width * 0.5, y: 100, width: width, height: 100)

//            let frame = CGRect(x: width * CGFloat(index) + width * 0.5, y: 100+CGFloat(90 - num * 10), width: width, height: CGFloat(num * 10)+10)

            let object = VisualObject(frame: frame, value: index)

            object.text = String(num)
            object.textAlignment = .center
            object.backgroundColor = colors[index % colors.count]
            objects.append(object)
            
        }
        
        quickSort(arr: &nums, low: 0, high: nums.count-1)
        
        return objects
    }
    
    func shuffleArray(arr: Array<Int>)->Array<Int>{
        
        var tempArr = arr
        for index in 0..<tempArr.count{
            let random =  Int(arc4random_uniform(UInt32(arr.count)))
            let tempVal = tempArr[random]
            tempArr[random] = tempArr[index]
            tempArr[index] = tempVal
        }
        
        return tempArr
    }
    
    @objc func animateObjects(){
        for index in 0..<visualObjects.count{
            let object = visualObjects[index]
            object.animateIntoPlace(width: self.view.frame.width, delay: 0.1 * CGFloat(index))
            visualView.addSubview(object)
        }
    }
    
    @objc func swapObjectsButton(){
        return
        let index1 =  Int(arc4random_uniform(UInt32(visualObjects.count)))
        var index2 =  Int(arc4random_uniform(UInt32(visualObjects.count)))

        while index1 == index2{
            index2 =  Int(arc4random_uniform(UInt32(visualObjects.count)))
        }
        
        let object1 = visualObjects[index1]
        let object2 = visualObjects[index2]

        let tempOrigin = object1.frame.origin

        object1.swapAnimation(destination: object2.frame.origin)
        object2.swapAnimation(destination: tempOrigin)

        visualObjects[index2] =  object1
        visualObjects[index1] =  object2
        
    }
    
    
    func swapObjects(index1: Int, index2: Int){
        
        let object1 = visualObjects[index1]
        let object2 = visualObjects[index2]
        
        let tempOrigin = object1.frame.origin
        
        object1.swapAnimation(destination: object2.frame.origin)
        object2.swapAnimation(destination: tempOrigin)
        
        visualObjects[index2] =  object1
        visualObjects[index1] =  object2

    }
    
    @objc func sortObjects(){

        if operations.count == 0{
            return
        }
        let (first, second) = operations.first!
        
        swapObjects(index1: visualObjects.count - first - 1, index2: visualObjects.count - second - 1)
        self.operations.removeFirst()
        
    }
    
    func partition(arr: inout Array<Int>, low:Int, high:Int)->Int{
        
        let pivot = arr[high]
        var i = (low - 1)
        
        for j in low..<high{
            
            if arr[j] <= pivot{
                i += 1
                swap(arr: &arr, first: i, second: j)
            }
        }
        swap(arr: &arr, first: i+1, second: high)
        return (i + 1)
    }
    
    func quickSort(arr: inout Array<Int>, low:Int, high:Int){
        
        if low < high{
            let partitionValue = partition(arr: &arr, low: low, high: high)
            
            quickSort(arr: &arr, low: low, high: partitionValue - 1)
            quickSort(arr: &arr, low: partitionValue + 1, high: high)
        }
    }
    
    func swap(arr: inout Array<Int>, first:Int, second:Int){

        if first != second{
            operations.append((first, second))
        }
        
        let temp = arr[first]
        arr[first] = arr[second]
        arr[second] = temp
    
    }
    
}





