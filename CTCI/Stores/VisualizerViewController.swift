import UIKit

class VisulizerViewController:UIViewController{
    
    @IBOutlet weak var visualView: UIView!
    var visualObjects:[VisualObject]!
    var wall:VisualObject!
    var quickSort:QuickSort = QuickSort(arr: nil)
    
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.purple, UIColor.yellow]
    override func viewDidLoad() {
        visualObjects = initializeVisualObjects()
        
        for object in visualObjects{
            visualView.addSubview(object)
        }
        
       initializeButtons()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateObjects()
        
    }
    
    func initializeButtons(){
        let slideButton = UIButton(frame: CGRect(x: self.view.frame.width / 2 - 50, y: self.view.frame.height * 4/5, width: 100, height: 20))
        slideButton.addTarget(self, action:#selector(animateObjects), for: .touchUpInside)
        slideButton.titleLabel?.text = "Slide in!"
        slideButton.titleLabel?.textColor = UIColor.black
        slideButton.backgroundColor = UIColor.red
        self.view.addSubview(slideButton)
        
        let swapButton = UIButton(frame: CGRect(x: self.view.frame.width / 2 - 50, y: self.view.frame.height * 4/5 + 20, width: 100, height: 20))
        swapButton.addTarget(self, action:#selector(swapObjectsButton), for: .touchUpInside)
        swapButton.titleLabel?.text = "Swap!"
        swapButton.titleLabel?.textColor = UIColor.black
        swapButton.backgroundColor = UIColor.blue
        self.view.addSubview(swapButton)
        
        let sortButton = UIButton(frame: CGRect(x: self.view.frame.width / 2 - 50, y: self.view.frame.height * 4/5 + 40, width: 100, height: 20))
        sortButton.addTarget(self, action:#selector(sortObjects), for: .touchUpInside)
        sortButton.titleLabel?.text = "Sort!"
        sortButton.titleLabel?.textColor = UIColor.black
        sortButton.backgroundColor = UIColor.purple
        self.view.addSubview(sortButton)
    }
    
    func initializeVisualObjects()->[VisualObject]{
        
        let width = visualView.frame.width/10
        let height:CGFloat = 100
        let startX = width / 2
        let y:CGFloat = 100
        
        var objects:[VisualObject] = []
        
        for last in 0..<quickSort.arr.count{
            
            let index = quickSort.arr.count - 1 - last
            let num = quickSort.arr[index]
            let frame = CGRect(x: width * CGFloat(index) + startX, y: y, width: width, height: height)

//            let frame = CGRect(x: width * CGFloat(index) + width * 0.5, y: 100+CGFloat(90 - num * 10), width: width, height: CGFloat(num * 10)+10)

            let object = VisualObject(frame: frame, value: index)


            object.text = String(num)
            object.textAlignment = .center
            object.backgroundColor = colors[index % colors.count]
            objects.insert(object, at: 0)
            
        }
        
        let frame = CGRect(x: 0, y: 0, width: width/2, height: 100)

        wall = VisualObject(frame: frame, value: -1)
        wall.backgroundColor = UIColor.gray
        self.view.addSubview(wall)
        
//        quickSort(arr: &nums, low: 0, high: nums.count-1)
        
        return objects
    }
    
    
    @objc func animateObjects(){
        for index in 0..<visualObjects.count{
            let object = visualObjects[visualObjects.count - 1 - index]
            object.animateIntoPlace(width: self.view.frame.width, delay: 0.1 * CGFloat(index))
            visualView.addSubview(object)
        }
    }
    
    @objc func swapObjectsButton(){

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
    
    @objc func sortObjects(){
        
        if quickSort.operations.count == 0{
            return
        }
        let iter:Iteration = quickSort.operations.first!
        
//        swapObjects(index1: visualObjects.count - first - 1, index2: visualObjects.count - second - 1)
        swapObjects(index1: iter.swapIndex1, index2: iter.swapIndex2)

        quickSort.operations.removeFirst()
        
    }
    
    func swapObjects(index1: Int, index2: Int){
        
        let object1 = visualObjects[index1]
        let object2 = visualObjects[index2]
        
        let tempOrigin = object1.frame.origin
        
        object1.swapAnimation(destination: object2.frame.origin)
        object2.swapAnimation(destination: tempOrigin)
        
        visualObjects[index2] =  object1
        visualObjects[index1] =  object2

        
        var smallerIndex = index1
        
        if index1 < index2{
            smallerIndex = index2
        }
        smallerIndex = visualObjects.count - smallerIndex - 1
        let width = visualView.frame.width/20 + visualView.frame.width/10 * CGFloat(smallerIndex+1)
        let frame = CGRect(x: width, y: 0, width: visualView.frame.width/20, height: 100)
        
        UIView.animate(withDuration: 1) {
            self.wall.frame = frame
        }
    }
    
 

    
}





