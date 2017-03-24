//
//  ViewController.swift
//  loancalculate
//
//  Created by 上海海洋大学 on 17/3/21.
//  Copyright © 2017年 上海海洋大学. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loanAmountField: UITextField!
    
    
    @IBOutlet weak var loanTermField: UITextField!
    
    
    @IBOutlet weak var interestRateField: UITextField!
    
    
    @IBOutlet weak var result: UILabel!
    
    //实例化
    @IBAction func compoundbutton(_ sender: Any) {
        let calculate2=compoundCalculate()
        result.text=calculate2.calculate(loanAmount:Double(loanAmountField.text!)!, years: Int(loanTermField.text!)!, interestRate: Double(interestRateField.text!)!).money
    }
    @IBAction func simplebutton(_ sender: Any) {
        let calculate1=simpleCalculate()
        guard let loanTermField = loanTermField.text,let loanAmountField = loanAmountField.text,let interestRateField=interestRateField.text
            else{
                print("用户没有输入全部数据")
                return
        }
        guard let loanTerm=Int(loanTermField),let loanAmount=Double(loanAmountField),let interestRate=Double(interestRateField)
            else{
                print("用户输入格式错误")
                return
        }
        result.text=calculate1.calculate(loanAmount:loanAmount, years: loanTerm, interestRate: interestRate).money
        //result.text=calculate1.calculate(loanAmount:Double(loanAmountField.text!)!, years: Int(loanTermField.text!)!, interestRate: Double(interestRateField.text!)!).money
    }
    
    
    
    //shift+command+0调出官方参考文档
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //文本框输入的时候，会成为firstrespomder
        loanAmountField.resignFirstResponder()
        loanTermField.resignFirstResponder()
        interestRateField.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//简单计算
class simpleCalculate{
    func calculate(loanAmount:Double,years:Int,interestRate:Double)->Double{
        let rate=interestRate/100
        let interest=loanAmount*rate*Double(years)
        return loanAmount+interest
    }
}
//复利计算
class compoundCalculate {
    func calculate(loanAmount:Double,years:Int,interestRate:Double)->Double{
        let rate=interestRate/100
        let compoundInterest=pow(1.0+rate, Double(years))
        return compoundInterest*loanAmount
    }
}
//entension 可以扩展功能，扩展对象包括class，enum，struct
extension Double{
    var money:String{
        let formatter=NumberFormatter()
        formatter.numberStyle = .currency
        let result:String?
        result=formatter.string(from: NSNumber(value:self))
        if result==nil{
            return"format error"
        }
        return result!
    }
}



