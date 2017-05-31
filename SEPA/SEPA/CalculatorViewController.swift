//
//  CalculatorViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 19/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    var currentOperation: Operator = Operator.nothing
    var calcState: CalculationState = CalculationState.enteringNum
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var firstValue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    @IBAction func numberClicked(sender: UIButton){
        updateDisplay(String(sender.tag))
    }
    
    @IBAction func operatorClicked(sender: UIButton){
        if let num = resultLabel.text {
            if num != "" {
                firstValue = num
                resultLabel.text = ""
            }
        }
        
        switch sender.tag{
            case 10 :
                currentOperation = Operator.add
            case 11 :
                currentOperation = Operator.subtract
            case 12 :
                currentOperation = Operator.multiply
            case 13 :
                currentOperation = Operator.divide
            default: return
        }
    }
    
    @IBAction func equalsClicked(sender: UIButton){
        calculateSum()
    }
    
    @IBAction func acClicked(sender: UIButton){
        firstValue = ""
        currentOperation = Operator.nothing
        calcState = CalculationState.enteringNum
        resultLabel.text = ""
    }
    
    func calculateSum(){
        if (firstValue.isEmpty){
            return
        }
        
        var result = ""
        
        if (currentOperation == Operator.add){
            result = "\(Double(firstValue)! + Double(resultLabel.text!)!)"
        }
        else if (currentOperation == Operator.subtract){
            result = "\(Double(firstValue)! - Double(resultLabel.text!)!)"
        }
        else if (currentOperation == Operator.multiply){
            result = "\(Double(firstValue)! * Double(resultLabel.text!)!)"
        }
        else if (currentOperation == Operator.divide){
            result = "\(Double(firstValue)! / Double(resultLabel.text!)!)"
        }
        
        resultLabel.text = result
        NSUserDefaults.standardUserDefaults().setDouble(Double(result)!, forKey:"lastCalc")
        calcState = CalculationState.newNumStarted
    }
    
    func updateDisplay(number: String){
        if calcState == CalculationState.newNumStarted {
            if let num = resultLabel.text {
                if num != "" {
                    firstValue = num
                }
            }
            calcState = CalculationState.enteringNum
            resultLabel.text = number
        }
        else if calcState == CalculationState.enteringNum {
            resultLabel.text = resultLabel.text! + number
        }
    }
    
    
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
