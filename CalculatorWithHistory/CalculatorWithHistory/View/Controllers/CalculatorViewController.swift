//
//  CalculatorViewController.swift
//  IBInspectibletryingtoinitialize
//
//  Created by Mert Ziya on 17.12.2024.
//

import UIKit

struct History{
    let calculation: String?
    let result: String?
}

class CalculatorViewController: UIViewController {
    //MARK: - Properties:

    let deffaults = UserDefaults.standard // user daffaults is used to store the calculation history.
    
    var histories : [History] = []
    
    
    
    //MARK: - UI Components:
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threebutton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var seventhButton: UIButton!
    @IBOutlet weak var eigthButton: UIButton!
    @IBOutlet weak var ninthButton: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var paranthesisButton: UIButton!
    @IBOutlet weak var modulusButton: UIButton!
    
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var multiplicationButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var equalsButton: UIButton!
    
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    
    

    //MARK: - Lifecycles:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtons()
        view.backgroundColor = .systemGray5
    }

}




// MARK:- Bind buttons to
extension CalculatorViewController{
    
    private func setButtons(){
        zeroButton.addTarget(nil, action: #selector(tapped), for: .touchUpInside)
        oneButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        twoButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        threebutton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        fourButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        fiveButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        sixButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        seventhButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        eigthButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        ninthButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        dotButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        divisionButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        multiplicationButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        modulusButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        resetButton.addTarget(self, action: #selector(initializeResultLabel), for: .touchUpInside)
        
        equalsButton.addTarget(self, action: #selector(calculate), for: .touchUpInside)
        
        deleteButton.addTarget(self, action: #selector(deleteNumber), for: .touchUpInside)
        
        initializeResultLabel()
    }
    
    @objc private func tapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else {
            print("no title error bizzt")
            return
        }
        if resultLabel.text == "..." {
            self.resultLabel.textColor = UIColor.black
            self.resultLabel.text = ""
        } // If the result is nil.
        
        resultLabel.textColor = .buttonText
        resultLabel.text?.append(title)

    }
    
    
    
    @objc private func initializeResultLabel(){
        self.resultLabel.textColor = UIColor.systemGray2.withAlphaComponent(0.4)
        self.resultLabel.text = "..."
        self.resultLabel.textAlignment = .right
        
        self.historyLabel.textColor = UIColor.systemGray
        self.historyLabel.text = "."
    }
    
    @objc private func calculate() {
        guard let calculationString = self.resultLabel.text else {
            print("DEBUG: nil value")
            return
        }

        // Replace 'x' with '*' for multiplication
        let formattedString = calculationString.replacingOccurrences(of: "x", with: "*")

        // Evaluate the calculation string
        guard let floatResult = evaluateCalculationString(formattedString) else { return }
        let newHistory = History(calculation: calculationString, result: String(floatResult))

        self.histories.append(newHistory)
        self.resultLabel.text = newHistory.result
        self.historyLabel.text = newHistory.calculation
    }

    func evaluateCalculationString(_ formattedString: String) -> Float? {
        // Validate the expression
        guard isValidExpression(formattedString) else {
            self.resultLabel.text = "WRONG FORMAT"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.initializeResultLabel()
            }
            return nil
        }

        // Process modulus operations manually
        if formattedString.contains("%") {
            return evaluateWithModulus(formattedString)
        }

        // Use NSExpression for other operations
        let expression = NSExpression(format: formattedString)
        if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
            return result.floatValue
        } else {
            print("Evaluation failed for: \(formattedString)")
            return nil
        }
    }

    func evaluateWithModulus(_ expression: String) -> Float? {
        var modifiedExpression = expression

        while let range = modifiedExpression.range(of: #"[0-9\.]+%[0-9\.]+"#, options: .regularExpression) {
            let match = String(modifiedExpression[range]) // e.g., "5%3"
            let components = match.split(separator: "%").compactMap { Float($0) }
            if components.count == 2 {
                let modulusResult = components[0].truncatingRemainder(dividingBy: components[1])
                modifiedExpression = modifiedExpression.replacingOccurrences(of: match, with: String(modulusResult))
            } else {
                return nil
            }
        }

        // Evaluate the remaining expression with NSExpression
        let expression = NSExpression(format: modifiedExpression)
        if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
            return result.floatValue
        } else {
            print("Evaluation failed for: \(modifiedExpression)")
            return nil
        }
    }
    
    func isValidExpression(_ expression: String) -> Bool {
        // Regular expression to allow valid numbers and operators, including modulus (%)
        let regex = "^[0-9\\.]+([\\+\\-\\*/%][0-9\\.]+)*$"
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: expression)
    }
    
    @objc private func deleteNumber() {
        guard let text = self.resultLabel.text, !text.isEmpty else {
            return // Do nothing if the text is nil or empty
        }
        self.resultLabel.text = String(text.dropLast())
    }

}
