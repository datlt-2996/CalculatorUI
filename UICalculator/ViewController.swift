//
//  ViewController.swift
//  UICalculator
//
//  Created by Lê Tiến Đạt on 21/03/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculatorWorking: UILabel!
    
    @IBOutlet weak var calculatorResults: UILabel!
    
    var workings: String = ""
    var resultLabel: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
    }
    func clearAll(){
        workings = ""
        calculatorWorking.text = ""
        resultLabel = ""
        calculatorResults.text = ""
    }
    func addToWorkings(value: String){
        workings = workings + value
        calculatorWorking.text = workings
    }

    @IBAction func allClear(_ sender: Any) {
        clearAll()
    }
    
    @IBAction func backButton(_ sender: Any) {
        if (!workings.isEmpty){
            workings.removeLast()
            calculatorWorking.text = workings
        }
    }
    
    func specialCharacter(char: Character) -> Bool {
        if (char == "/" || char == "*" || char == "-" || char == "+" || char == ".") {
            return true
        }
        
        return false
    }
    func validInput() -> Bool {
        
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in workings {
            if specialCharacter(char: char) {
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        if workings.isEmpty {
            return false
        }
        
        var previousChar: Int = -1
        
        for index in funcCharIndexes {
            if index == 0 {
                return false
            }
            
            if index == workings.count - 1 {
                return false
            }
            
            if previousChar != -1 {
                
                if index - previousChar == 1 {
                    return false
                }
            }
            previousChar = index
            
        }
        
        return true
    }
    
    @IBAction func equalButton(_ sender: Any) {
        
        if validInput(){
            let expression = NSExpression(format: workings)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            calculatorResults.text = resultString
            resultLabel = String(resultString)
        }
        else
        {
            let alert = UIAlertController(title: "Wrong", message: "Try again", preferredStyle:  .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    func formatResult(result: Double) -> String{
        if(result.truncatingRemainder(dividingBy: 1) == 0){
            return String(format: "%.0f", result)
        }
        else{
            return String(format: "%.3f", result)
        }
    }
    

    @IBAction func percentButton(_ sender: Any) {
        if(!resultLabel.isEmpty){
            nextMath()
            workings = workings + "*0.01"
            calculatorWorking.text = workings
        }
        else{
            let fakeWorking = workings
            workings = workings + "*0.01"
            calculatorWorking.text = fakeWorking + "%"
        }
    }
    func nextMath(){
        workings = resultLabel
        calculatorWorking.text = workings
        resultLabel = ""
    }
    @IBAction func devideButton(_ sender: Any) {
        if(!resultLabel.isEmpty){
            nextMath()
            workings = workings + ".000"
            addToWorkings(value: "/")
        }
        else{
            workings = workings + ".000"
            addToWorkings(value: "/")
        }

    }
    
    @IBAction func mutilButton(_ sender: Any) {
        if(!resultLabel.isEmpty){
            nextMath()
            addToWorkings(value: "*")
        }
        else{
            addToWorkings(value: "*")
        }

    }
    
    @IBAction func minusButton(_ sender: Any) {
        if(!resultLabel.isEmpty){
            nextMath()
            addToWorkings(value: "-")
        }
        else{
            addToWorkings(value: "-")
        }

    }
    
    @IBAction func plusButton(_ sender: Any) {
        if(!resultLabel.isEmpty){
            nextMath()
            addToWorkings(value: "+")
        }
        else{
            addToWorkings(value: "+")
        }
    }
    

    @IBAction func dotButton(_ sender: Any) {
        if(!resultLabel.isEmpty){
            nextMath()
            addToWorkings(value: ".")
        }
        else{
            addToWorkings(value: ".")
        }

    }
    
    func newMathWithNumber(){
        workings = ""
        resultLabel = ""
    }
    
    @IBAction func numberButton(_ sender: UIButton) {
        let temp = (sender.titleLabel?.text)
        if(!resultLabel.isEmpty){
            newMathWithNumber()
            addToWorkings(value: temp ?? "0")
        }
        else{
            addToWorkings(value: temp ?? "0")
        }
    }
    
}

