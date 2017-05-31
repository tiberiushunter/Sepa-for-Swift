//
//  ConverterViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 19/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var txtFrom: UITextField!
    
    @IBOutlet weak var txtTo: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var unitList = ["Celcius to Fahrenheit",
                    "Fahrenheit to Celcius",
                    "Miles to Kilometers",
                    "Kilometers to Miles",
                    "Inches to Centimeters",
                    "Centimeters to Inches"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func convertBtnClick(sender: AnyObject) {
        txtTo.text = ""
        let rowSelection = pickerView.selectedRowInComponent(0)
        
        if let from = Double(txtFrom.text!) {
            if(rowSelection == 0){
                let to = Utilities().convertToFahrenheit(from)
                txtTo.text = String(to)
                NSUserDefaults.standardUserDefaults().setDouble(to, forKey:"lastConv")
                NSUserDefaults.standardUserDefaults().setObject("°F", forKey:"lastConvUnit")
            }
            else if(rowSelection == 1){
                let to = Utilities().convertToCelsius(from)
                txtTo.text = String(to)
                NSUserDefaults.standardUserDefaults().setDouble(to, forKey:"lastConv")
                NSUserDefaults.standardUserDefaults().setObject("°C", forKey:"lastConvUnit")
            }
            else if(rowSelection == 2){
                let to = Utilities().convertToKilometers(from)
                txtTo.text = String(to)
                NSUserDefaults.standardUserDefaults().setDouble(to, forKey:"lastConv")
                NSUserDefaults.standardUserDefaults().setObject("KM", forKey:"lastConvUnit")
            }
            else if(rowSelection == 3){
                let to = Utilities().convertToMiles(from)
                txtTo.text = String(to)
                NSUserDefaults.standardUserDefaults().setDouble(to, forKey:"lastConv")
                NSUserDefaults.standardUserDefaults().setObject("Miles", forKey:"lastConvUnit")
            }
            else if(rowSelection == 4){
                let to = Utilities().convertToCentimeters(from)
                txtTo.text = String(to)
                NSUserDefaults.standardUserDefaults().setDouble(to, forKey:"lastConv")
                NSUserDefaults.standardUserDefaults().setObject("CM", forKey:"lastConvUnit")
            }
            else if(rowSelection == 5){
                let to = Utilities().convertToInches(from)
                txtTo.text = String(to)
                NSUserDefaults.standardUserDefaults().setDouble(to, forKey:"lastConv")
                NSUserDefaults.standardUserDefaults().setObject("Inches", forKey:"lastConvUnit")
            }
            
        } else {
            //Not Valid, show Not a Number response in To field
            txtTo.text = "NaN"
        }
    }
    
    func numberOfComponents(in dropDownList: UIPickerView) -> Int {
        return unitList.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return unitList.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(dropDownList: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unitList[row]
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
