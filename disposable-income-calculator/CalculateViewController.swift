//
//  ViewController.swift
//  disposable-income-calculator
//
//  Created by Alberto Dominguez on 1/4/21.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var hourlySalaryLabel: UILabel!
    @IBOutlet weak var hoursPerDayLabel: UILabel!
    @IBOutlet weak var hoursPerDaySlider: UISlider!
    @IBOutlet weak var daysPerWeekLabel: UILabel!
    @IBOutlet weak var daysPerWeekSlider: UISlider!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var singleButton: UIButton!
    @IBOutlet weak var marriedButton: UIButton!
    @IBOutlet weak var marriedSeparatlyButton: UIButton!
    @IBOutlet weak var headOfHouseholdButton: UIButton!
    
    var hourlySalary: Int = 25
    var hoursPerDay: Int = 8
    var daysPerWeek: Int = 5
    var stateCode: String!
    var fillingStatus: String = "Single"
    
    // variables for API
    var federalTaxValue: Int = 0
    var ficaTaxValue: Int = 0
    var stateTaxValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        hourlySalaryLabel.text = "$\(hourlySalary)/h"
        hoursPerDayLabel.text = "\(hoursPerDay) hours per day"
        daysPerWeekLabel.text = "\(daysPerWeek) days per week"
        hoursPerDaySlider.value = Float(hoursPerDay)
        daysPerWeekSlider.value = Float(daysPerWeek)

        singleButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        marriedButton.backgroundColor = #colorLiteral(red: 0.9593952298, green: 0.9594177604, blue: 0.959405601, alpha: 1)
        marriedSeparatlyButton.backgroundColor = #colorLiteral(red: 0.9593952298, green: 0.9594177604, blue: 0.959405601, alpha: 1)
        headOfHouseholdButton.backgroundColor = #colorLiteral(red: 0.9593952298, green: 0.9594177604, blue: 0.959405601, alpha: 1)
    }

    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        hourlySalaryLabel.text = "$\(String(25 + Int(sender.value)))/h"
        hourlySalary = 25 + Int(sender.value)
    }
    
    @IBAction func hoursPerDayChanged(_ sender: Any) {
        hoursPerDay = Int(hoursPerDaySlider.value)
        hoursPerDayLabel.text = "\(hoursPerDay) hours per day"
        
    }
    
    @IBAction func daysPerWeekChanged(_ sender: UISlider) {
        daysPerWeek = Int(daysPerWeekSlider.value)
        daysPerWeekLabel.text = "\(daysPerWeek) days per week"
    }
    
    
    @IBAction func fillingStatusChanged(_ sender: UIButton) {
        singleButton.backgroundColor = #colorLiteral(red: 0.9593952298, green: 0.9594177604, blue: 0.959405601, alpha: 1)
        marriedButton.backgroundColor = #colorLiteral(red: 0.9593952298, green: 0.9594177604, blue: 0.959405601, alpha: 1)
        marriedSeparatlyButton.backgroundColor = #colorLiteral(red: 0.9593952298, green: 0.9594177604, blue: 0.959405601, alpha: 1)
        headOfHouseholdButton.backgroundColor = #colorLiteral(red: 0.9593952298, green: 0.9594177604, blue: 0.959405601, alpha: 1)

        sender.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        fillingStatus = sender.currentTitle!
        print(fillingStatus)
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let grossIncome: Int = hourlySalary * hoursPerDay * daysPerWeek * 52
        stateCode = stateField.text!
        print(grossIncome)
        print(stateCode!)
        print(fillingStatus)
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults"{
            let destinatinVC = segue.destination as! ResultsViewController
        }
        
    }
    
}

