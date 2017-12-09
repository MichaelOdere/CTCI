import UIKit

class VisulizerViewController:UIViewController{
    
    @IBOutlet weak var visualView: UIView!
    var visualObjects:[VisualObject]!
    var visualIndex:Int = 0
    var wall:VisualObject!
    var messageLabel:UILabel!
    var quickSort:QuickSort = QuickSort(arr: nil)
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.purple, UIColor.yellow]
   
    override func viewDidLoad() {

        quickSort.reset()
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
        
        let resetButton = UIButton(frame: CGRect(x: self.view.frame.width / 2 - 50, y: self.view.frame.height * 4/5 + 60, width: 100, height: 20))
        resetButton.addTarget(self, action:#selector(reset), for: .touchUpInside)
        resetButton.titleLabel?.text = "Reset!"
        resetButton.titleLabel?.textColor = UIColor.black
        resetButton.backgroundColor = UIColor.green
        self.view.addSubview(resetButton)
        
        messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        messageLabel.textColor = UIColor.black
        messageLabel.textAlignment = .center
        messageLabel.backgroundColor = UIColor.brown
        self.view.addSubview(messageLabel)
    }
    
    func initializeVisualObjects()->[VisualObject]{
        
        let width = visualView.frame.width/10
        let height:CGFloat = 100
        let startX = width / 2
        let y:CGFloat = 400
        
        var objects:[VisualObject] = []
        
        for last in 0..<quickSort.arr.count{
            
            let index = quickSort.arr.count - 1 - last
            let num = quickSort.arrShuffled[index]
            let frame = CGRect(x: width * CGFloat(index) + startX, y: y, width: width, height: height)

//            let frame = CGRect(x: width * CGFloat(index) + width * 0.5, y: 100+CGFloat(90 - num * 10), width: width, height: CGFloat(num * 10)+10)

            let object = VisualObject(frame: frame, value: index)


            object.text = String(num)
            object.textAlignment = .center
            object.backgroundColor = UIColor.orange //colors[index % colors.count]
            objects.insert(object, at: 0)
            
        }
        
        let frame = CGRect(x: 0, y: y - height, width: width/2, height: height)

        wall = VisualObject(frame: frame, value: -1)
        wall.backgroundColor = UIColor.gray
        self.view.addSubview(wall)
                
        return objects
    }
    
    
    @objc func animateObjects(){
        for index in 0..<visualObjects.count{
            let object = visualObjects[visualObjects.count - 1 - index]
            object.animateIntoPlace(width: self.view.frame.width, delay: 0.1 * CGFloat(index))
        }
        
        wall.animateIntoPlace(width:self.view.frame.width, delay: 0.1 * CGFloat(visualObjects.count))
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
        
        if visualIndex == quickSort.operations.count{
            return
        }
        
        if visualIndex != 0{
            let prevIter = quickSort.operations[visualIndex - 1]
            if prevIter.pivot == nil{
                visualObjects[prevIter.swapIndex1].backgroundColor = UIColor.orange
                visualObjects[prevIter.swapIndex2].backgroundColor = UIColor.orange
            }            
        }
        
        let iter:Iteration = quickSort.operations[visualIndex]
        
        if iter.pivot != nil{
            swapObjects(index1: iter.swapIndex1, index2: iter.swapIndex2)
        }else{
            visualObjects[iter.swapIndex1].backgroundColor = UIColor.blue
            visualObjects[iter.swapIndex2].backgroundColor = UIColor.blue
        }
        
        messageLabel.text = iter.message

        visualIndex += 1
    }
    
    @objc func reset(){
        for object in visualObjects{
            object.removeFromSuperview()
        }
        
        wall.removeFromSuperview()
        
        quickSort.reset()
        
        visualObjects = []
        visualObjects = initializeVisualObjects()
        animateObjects()
        
        
        for object in visualObjects{
            visualView.addSubview(object)
        }
        
        visualIndex = 0
        
        messageLabel.text = ""
    }

    func swapObjects(index1: Int, index2: Int){
        
        let object1 = visualObjects[index1]
        let object2 = visualObjects[index2]
        
        let tempOrigin = object1.frame.origin
        
        object1.swapAnimation(destination: object2.frame.origin)
        object2.swapAnimation(destination: tempOrigin)
        
        visualObjects[index2] =  object1
        visualObjects[index1] =  object2

        
        let smallerIndex = min(index1, index2)
        
        let width = visualView.frame.width/20 + visualView.frame.width/10 * CGFloat(smallerIndex+1)
        let orign = CGPoint(x: width, y: wall.frame.origin.y)

        UIView.animate(withDuration: 1) {
            self.wall.frame.origin = orign
        }
    }
    
}





