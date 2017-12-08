import UIKit

class VisulizerViewController:UIViewController{
    
    @IBOutlet weak var visualView: UIView!
    var visualObjects:[VisualObject]!

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
        swapButton.addTarget(self, action:#selector(swapObjects), for: .touchUpInside)
        swapButton.titleLabel?.text = "Swap!"
        swapButton.backgroundColor = UIColor.blue
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
            let frame = CGRect(x: width * CGFloat(index) + width * 0.5, y: 100, width: width, height: 100)
            let object = VisualObject(frame: frame, value: index)

            object.text = String(nums[index])
            object.textAlignment = .center
            object.backgroundColor = colors[index % colors.count]
            objects.append(object)
            
        }
        
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
    
    @objc func swapObjects(){
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

}





