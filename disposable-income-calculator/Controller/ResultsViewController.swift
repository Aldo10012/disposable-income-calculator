//
//  ResultsViewController.swift
//  disposable-income-calculator
//
//  Created by Alberto Dominguez on 1/4/21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var grossIncome: Double = 0
    var federalTax: Double = 0
    var ficaTax: Double = 0
    var stateTax: Double = 0
    var payPeriod: String = "year"
    
    @IBOutlet weak var netIncomeLabel: UILabel!
    @IBOutlet weak var grossIncomeLabel: UILabel!
    @IBOutlet weak var federalTaxLabel: UILabel!
    @IBOutlet weak var ficaTaxLabel: UILabel!
    @IBOutlet weak var stateTaxLabel: UILabel!
    @IBOutlet weak var payPeriodSegmentControler: UISegmentedControl!
    @IBOutlet weak var payPeriodLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let font = UIFont.systemFont(ofSize: 20)
        payPeriodSegmentControler.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        updateUI()
    }
    
    @IBAction func payPeriodSegmentChanged(_ sender: UISegmentedControl) {
        switch payPeriodSegmentControler.selectedSegmentIndex{
        case 0:
            grossIncome *= 12
            federalTax *= 12
            ficaTax *= 12
            stateTax *= 12
            payPeriod = "year"
            updateUI()
            
        case 1:
            grossIncome /= 12
            federalTax /= 12
            ficaTax /= 12
            stateTax /= 12
            payPeriod = "month"
            updateUI()
        default:
            print("error")
        }
        
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil) 
    }
    
    func updateUI(){
        payPeriodLabel.text = "per \(payPeriod)"
        netIncomeLabel.text = "$\(Int(grossIncome - federalTax - ficaTax - stateTax))"
        grossIncomeLabel.text = "$\(Int(grossIncome))"
        federalTaxLabel.text = "- $\(Int(federalTax))"
        ficaTaxLabel.text = "- $\(Int(ficaTax))"
        stateTaxLabel.text = "- $\(Int(stateTax))"
    }

}
