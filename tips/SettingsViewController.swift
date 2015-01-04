//
//  SettingsViewController.swift
//  tips
//
//  Created by Aditya Jayaraman on 1/3/15.
//  Copyright (c) 2015 Aditya Jayaraman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var splitByLabel: UILabel!
    @IBOutlet weak var splitByStep: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
        splitByLabel.text = "1"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    
    
    @IBAction func onDefaultTipControlChange(sender: AnyObject) {
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: "defaultTipControl")
        defaults.synchronize()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("Settings view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("Settings view did appear")
        
        var defaults = NSUserDefaults.standardUserDefaults()
        
        let defaultTip = defaults.integerForKey("defaultTipControl")
        
        defaultTipControl.selectedSegmentIndex = defaultTip
        
        
        var defaultSplitBy = defaults.integerForKey("defaultSplitBy")
        
        if (defaultSplitBy == 0) {
            defaultSplitBy = 1
        }
        
        splitByStep.value = Double(defaultSplitBy)
        var b:String = String(format:"%d", defaultSplitBy)

        splitByLabel.text = b

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("Settings view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("Settings view did disappear")
    }
    
    @IBAction func onTapChange(sender: AnyObject) {
    
        println("on tap change")

        var b:String = String(format:"%0.0f", splitByStep.value)
        splitByLabel.text = b
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(Int(splitByStep.value), forKey: "defaultSplitBy")
        defaults.synchronize()

    }
    
    
}
