//
//  ResultsViewController.swift
//  disposable-income-calculator
//
//  Created by Alberto Dominguez on 1/4/21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var grossIncome: Int = 0
    var federalTax: Int = 0
    var ficaTax: Int = 0
    var stateTax: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("\nValues in ResultsViewController")
        print("federal tax \(federalTax) ")
        print("fica tax \(ficaTax) ")
        print("state tax \(stateTax) ")
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil) 
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
