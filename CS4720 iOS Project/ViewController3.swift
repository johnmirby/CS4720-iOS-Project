//
//  ViewController3.swift
//  CS4720 iOS Project
//
//  Created by Kyle Eklund on 10/26/15.
//  Copyright © 2015 John Irby. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController3: UIViewController {
    
    let tableData = ["1. Nab the #1 ticket at Bodo's","2. Sing the Good Ole Song", "3. Attend Rotunda Sing", "4. High-five Dean Groves", "5. Make a Class Gift", "6. Paint Beta Bridge", "7. Chow down on late night food on the Corner", "8. Tailgate a football game", "9. Eat at Pancakes for Parkinson's", "10. Check out a book from a library", "11. Dress up in ties and pearls", "12. Tube down the James River", "13. See the Jefferson Statue in it's new home", "14. Relive O'Hill brunch (Yum!!!)", "15. Stroll around the Farmers market downtown", "16. Eat at a food truck", "17. Attend Tom Tom Festival", "18. Order food to Clemons", "19. Cheer on the baseball team at Davenport", "20. Take a historical tour of U.Va.", "21. Get lunch at Bellair Market", "22. Watch an improv show", "23. Carve a pumpkin at puppies and pumpkins", "24. Attend a concert on the Downtown Mall", "25. Watch the sunrise from Humpback Mountain or Old Rag", "26. Sign up for an Alumni Membership", "27. Hug Ms. Kathy in Newcomb", "28. Visit Monticello", "29. Attend a class you are not enrolled in", "30. Pick apples at Carter's Mountain", "31. Check out the Declaration of Independence in Special Collections", "32. Trek to a Charlottesville brewery or vineyard", "33. Jam at Fridays After Five", "34. Attend a themed party or date function", "35. Complete the Dining Hall Marathon - 3 Dining Halls, 1 Day", "36. Volunteer through Madison House", "37. Celebrate Lighting of the Lawn", "38. Go on a real date", "39. Visit Carr's Hill", "40. Ice Skate Downtown", "41. Attend the Virginia Film Festival", "42. Write on the Freedom Wall downtown", "43. Get swole at all four gyms", "44. Experience a performance in Old Cabell Hall", "45. Make a home cooked meal", "46. Enjoy a picnic on the Lawn", "47. Compete in an Intramural Sport", "48. Take Picture in front of the \"I Love Charlottesville Sign\" in Belmont", "49. Get Spooked at Brown College Haunting", "50. Attend Trick or Treating on the Lawn", "51. Run the 4th Year 5K", "52. Attend a Musical or Play in the Drama Building", "53. Participate in a Greek philanthropy event", "54. Play in Mad Bowl", "55. Hang Out at a Final Friday Reception at the Fralin", "56. Sport Some 2016 Gear", "57. Drive up Skyline Drive", "58. Check Out a Multicultural Event", "59. Watch a U.Va. Away Game at a Local Establishment", "60. Support Someone Who Does St. Baldrick", "61. Attend a Homecomings Event", "62. Plant in the U.Va. community Garden", "63. Witness a Probate", "64. Visit a Pavilion Resident", "65. Stargaze on the Lawn", "66. Support the tennis teams at Snyder courts", "67. Eat at Cavalier Diner", "68. Spread the U.Va. love and host a non-U.Va. friend", "69. \"Take back the Night\"", "70. Attend UPC Springfest", "71. Bake, Braid, or enjoy a loaf with Challah for Hunger", "72. Attend an Earth Week event", "73. Play a sport on Nameless field", "74. Groove to the vibes of a local band", "75. Support the lacrosse/soccer teams at Klockner", "76. Make a poster for a basketball game", "77. Indulge in College Inn cheesy bread", "78. Build a snowman on the Lawn/have a snowball fight", "79. Enjoy a U.Va. club ice hockey game", "80. Attend a lecture at the Miller Center", "81. Go snow tubing at Wintergreen", "82. Survive one hour at Biltmore", "83. Attend the class party", "84. Pull an all nighter at Clemons", "85. Play a game of cornhole", "86. Attend a flash seminar", "87. Listen to a U.Va radio broadcast", "88. Eat at Duck Donuts", "89. Get your Corks & Curls", "90. Chase a squirrel", "91. Eat brunch at a local establishment", "92. Test your knowledge at trivia night", "93. Accept a flyer from someone tabling (and actually go to the event)", "94. Try slacklinging on Grounds", "95. Read an article from a student publication", "96. Dance the Virginia Reel at Restoration/Colonnade Ball", "97. Participate in drag bingo", "98. Take a U-V-A picture", "99. Sing Karaoke at Fellini's", "100. Sing in a booth at the Virginian", "101. Vote in a Student Election", "102. Study in a Garden", "103. Grab a Frisbee from the 21 box on the Lawn (next to Lawn room 21)", "104. Befriend a first year", "105. Run on the Rivanna trail", "106. Witness the Purple Shadows on Jefferson's Birthday", "107. Watch the sunset from the top floor of Culberth parking garage", "108. Attend an Awareness Training (Green Dot, Safe Space, Diversity, etc...)", "109. Think about applying for a job (UCS can help!!)", "110. Encourage someone to apply to U.Va.", "111. Tell a secret at the Whispering wall", "112. Appreciate a Horse at Foxfield", "113. Thank your parents", "114. Get the feels at Graduation", "115. Go to Valediction", "116. Wear the Honors of Honor"]
    var valueToPass:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "detailSegue"){
            if let svc = segue.destinationViewController as? ViewController4 {
                svc.nameToDisplay = valueToPass
            }
        }
    }
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"cell")
        cell.textLabel?.text = tableData[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!;
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!;
        
        valueToPass = currentCell.textLabel!.text
        performSegueWithIdentifier("detailSegue", sender: self)
    }
    
    override func motionEnded(motion: UIEventSubtype,
        withEvent event: UIEvent?) {
            
            if motion == .MotionShake{
                let random = Int(arc4random_uniform(116))
                valueToPass = tableData[random]
                performSegueWithIdentifier("detailSegue", sender: nil)
            }
            
    }
}
