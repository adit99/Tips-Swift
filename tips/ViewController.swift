//
//  ViewController.swift
//  tips
//
//  Created by Aditya Jayaraman on 1/1/15.
//  Copyright (c) 2015 Aditya Jayaraman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var BillAmountField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var splitByLabelValue: UILabel!
    @IBOutlet weak var splitByLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var secondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        tipAmountLabel.text = "$0.0"
        totalAmountLabel.text = "$0.0"
        
        mainView.alpha = 1
        secondView.alpha = 0
    
        splitByLabel.hidden = true
        splitByLabelValue.hidden = true
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "billChanged")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChange(sender: AnyObject) {
        
        var tipPercentages = [0.15, 0.18, 0.20]
        var tip = tipPercentages[tipControl.selectedSegmentIndex]
        var billString = BillAmountField.text
        var bill = (billString as NSString).doubleValue
        
        var newMainFrame = mainView.frame
        var newSecondFrame = secondView.frame
        var mainVisible = 1
        var secondVisible = 1

        var defaults = NSUserDefaults.standardUserDefaults()
        var billChanged = defaults.boolForKey("billChanged")

        if (bill > 0 && billChanged) {
            newMainFrame.origin.y -= 100
            newSecondFrame.origin.y -= 100
            mainVisible = 1
            secondVisible = 1
            defaults.setBool(false, forKey: "billChanged")
            defaults.synchronize()
        }
        if (bill == 0){
            newMainFrame.origin.y += 100
            newSecondFrame.origin.y += 100
            mainVisible = 1
            secondVisible = 0
            defaults.setBool(true, forKey: "billChanged")
            defaults.synchronize()
        }

        UIView.animateWithDuration(0.4,
            animations:{
            self.mainView.alpha = CGFloat(mainVisible)
            self.secondView.alpha = CGFloat(secondVisible)
            self.mainView.frame = newMainFrame;
            self.secondView.frame = newSecondFrame
        })
        
        tipAmountLabel.text = "$\(bill * tip)"
        totalAmountLabel.text = "$\(bill + (bill * tip))"
        
        var splitBy = defaults.integerForKey("defaultSplitBy")
       // var splitByAmount = ((UInt8(bill) + (UInt8(bill)*UInt8(tip))) / UInt8(splitBy))
        
        var total = bill + (bill * tip)
        
        splitByLabel.text = "Split by \(splitBy)"
        splitByLabelValue.text = "\(total/Double(splitBy))"
        
    }

    @IBAction func onTaip(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("Main view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("Main view did appear")
        
        var defaults = NSUserDefaults.standardUserDefaults()
        
        let defaultTip = defaults.integerForKey("defaultTipControl")
        
        tipControl.selectedSegmentIndex = defaultTip
        
        var billString = BillAmountField.text
        var bill = (billString as NSString).doubleValue

        //Splitby
        var splitBy = defaults.integerForKey("defaultSplitBy")
        
        println("\(splitBy)")
        if (splitBy > 1) {
            splitByLabel.hidden = false
            splitByLabelValue.hidden = false
        }
        if (splitBy == 1) {
            splitByLabel.hidden = true
            splitByLabelValue.hidden = true
        }
        
        if (bill > 0) {
            onEditingChange(self)
        }
        
      
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("Main view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("Main view did disappear")
    }
    
}

