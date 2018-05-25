//
//  SelectedGoalViewController.swift
//  InspirationalReminders
//
//  Created by David Porter on 5/25/18.
//  Copyright © 2018 Eve Denison. All rights reserved.
//

import UIKit

class SelectedGoalViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    var selectedGoalStep: GoalSteps?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let goalStep = self.selectedGoalStep {
            self.textLabel.text = goalStep.displayName
        }
        
        //textLabel.text = selectedGoalText

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
