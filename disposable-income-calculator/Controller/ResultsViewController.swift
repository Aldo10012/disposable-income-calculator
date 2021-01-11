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

        // Do any additional setup after loading the view.
        
        print("\nValues in ResultsViewController")
        print("federal tax \(federalTax) ")
        print("fica tax \(ficaTax) ")
        print("state tax \(stateTax) ")
        
        updateUI()
    }
    
    @IBAction func payPeriodSegmentChanged(_ sender: UISegmentedControl) {
        switch payPeriodSegmentControler.selectedSegmentIndex{
        case 0:
            print("annual is selected")
            grossIncome *= 12
            federalTax *= 12
            ficaTax *= 12
            stateTax *= 12
            payPeriod = "year"
            updateUI()
            
        case 1:
            print("monthly is selected")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
