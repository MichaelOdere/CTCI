import Foundation
import UIKit

class MilestoneStore {
    var milestones:[Milestone] = []
    var prepMap:[Milestone]!
    
    init(){
        var total:Int = 0
        let desc = "Here is a somewhat long description of a cell"
        for elem in 0..<40{
            milestones.append(Milestone(title: String(elem), desc: desc, days: 30, totalDays: total))
            total += 30
        }
        
        prepMap = createPrepMap(curMilestones: milestones)
    }
    
    func createPrepMap(curMilestones: [Milestone])-> [Milestone]{
        
        var prepMapeMilestones:[Milestone] = []
        var count = 0
        var milestoneCount = 0
        
        while milestoneCount < curMilestones.count{
            
            if isAnArrow(index: count){
                prepMapeMilestones.append(Milestone(title: "nil", desc: "nil", days: 0, totalDays: 0))
            }else{
                prepMapeMilestones.append(curMilestones[milestoneCount])
                milestoneCount += 1
            }
            
            count += 1
            
        }
        
        return prepMapeMilestones
    }
    
    // C = Content
    // A = Arrow
    // [C, A, C, A, C, A, A, C, A, C, A, C, A, A]
    
    // This function returns the (A)rrow index's
    func isAnArrow(index: Int)->Bool{
        if (index % 7) % 2 == 1 || index % 7 == 6{
            return true
        }
        
        return false
    }
    
    func cellColor(milestone: Milestone, currentDaysFromSelectedDate: Int)->UIColor{
        // if this is the first miletone then days = running days because nothing else has been added
        var color = UIColor.red
        
        if milestone.totalDays <= currentDaysFromSelectedDate{
            if milestone.totalDays + milestone.days >= currentDaysFromSelectedDate{
                color = UIColor.blue

            }else{
                color = UIColor.green
            }
        }
        
        return color
    }

}
/*

func cellColor(milestone: Milestone, currentDaysFromSelectedDate: Int)->UIColor{
    // if this is the first miletone then days = running days because nothing else has been added
    var color = UIColor(red:204/255, green:203/255, blue:198/255, alpha:1.0)
    
    if milestone.totalDays <= currentDaysFromSelectedDate{
        if milestone.totalDays + milestone.days >= currentDaysFromSelectedDate{
            color = UIColor(red:239/255, green:217/255, blue:193/255, alpha:1.0)
            
        }else{
            color = UIColor(red:199/255, green:216/255, blue:198/255, alpha:1.0)
        }
    }
    
    return color
}

*/
