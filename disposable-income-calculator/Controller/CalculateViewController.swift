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
    var payRate: Int = 52000
    var stateCode: String = ""
    var fillingStatus: String = "single"
    
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
        //fillingStatus = sender.currentTitle!
        
        switch sender.currentTitle!{
        case "Single":
            fillingStatus = "single"
        case "Married":
            fillingStatus = "married"
        case "Married Separatly":
            fillingStatus = "married_separately"
        case "Head of Household":
            fillingStatus = "head_of_household"
        default:
            print("something whent wrong")
        }
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        payRate = hourlySalary * hoursPerDay * daysPerWeek * 52
        stateCode = stateField.text!
        print("\n=====================")
        print("Your Income:   \(payRate)\nYour Location: \(stateCode)\nYour status:   \(fillingStatus)\n")

        
        
        getTaxes(pay_rate: Double(payRate), state_code: stateCode, filling_status: fillingStatus)
        
        
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.grossIncome = payRate
            
        }
    }
    
    
    //pay_rate: Double, state_code: String, filling_status: String
    func getTaxes(pay_rate: Double, state_code: String, filling_status: String){
        
        // Prepare URL
        let url = URL(string: "https://stylinandy-taxee.p.rapidapi.com/v2/calculate/2020")
        guard let requestUrl = url else { fatalError() }
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // set http type
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJBUElfS0VZX01BTkFHRVIiLCJodHRwOi8vdGF4ZWUuaW8vdXNlcl9pZCI6IjVmZjI3ODMwYzU3OGU4N2EzYmE4M2IxYSIsImh0dHA6Ly90YXhlZS5pby9zY29wZXMiOlsiYXBpIl0sImlhdCI6MTYwOTcyNjI0Nn0.XwQXLkpn41mN7XQnRcm4fq3BwA4S9F_s31QBguppBDY",
            "x-rapidapi-key": "1b1013f78amshe4660e4e488532cp16183djsn3e15d0aa4c46",
            "x-rapidapi-host": "stylinandy-taxee.p.rapidapi.com"
        ]
        request.allHTTPHeaderFields = headers
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        //let postString = "filing_status=single&pay_rate=80000&state=tx";
        let postString = "filing_status=\(filling_status)&pay_rate=\(pay_rate)&state=\(state_code)";
        
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            do{
                let taxModel = try JSONDecoder().decode(TaxModel.self, from: data!)
                print("Federal Tax: \(taxModel.annual.federal.amount)")
                print("FICA Tax: \(taxModel.annual.fica.amount)")
                if taxModel.annual.state.amount != nil{
                    print("State Tax: \(taxModel.annual.state.amount!)")
                }else{
                    print("State Tax: \(0)")
                }
                
                
            }catch let jsonErr{
                print(jsonErr)
            }
            
            
        }
        task.resume()
        
    }
    
}

struct TaxModel: Codable{
    var annual: Annual
}

struct Annual: Codable{
    var fica: FicaModel
    var federal: FederalModel
    var state: StateModel
}

struct FicaModel: Codable{
    var amount: Double
}

struct FederalModel: Codable{
    var amount: Double}

struct StateModel: Codable{
    var amount: Double?}

