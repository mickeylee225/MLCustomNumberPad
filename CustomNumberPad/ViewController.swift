//
//  ViewController.swift
//  CustomNumberPad
//
//  Created by Mickey on 2018/6/26.
//  Copyright © 2018年 Mickey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CustomNumberPadDelegate {
    
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numberPad = initNumberPad()
        numberPad.delegate = self
        textField.inputView = UIView()
        textField.inputAccessoryView = numberPad
    }
    
    func initNumberPad() -> CustomNumberPad {
        let numberPad = CustomNumberPad(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150))
        numberPad.setViewBgColor(.clear)
        numberPad.setButtonsTitleColor(.black, selectedColor: .lightGray)
        numberPad.setButtonsBgColor(UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.6), selectedColor: UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8))
        numberPad.setButtonsFont(UIFont(name: ".SFUIText-Semibold", size: 28)!)
        numberPad.setTouchIDButtonImage(UIImage(named: "touchId")!)
        
        return numberPad
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CustomNumberPadDelegate
    
    func touchIDButtonClicked(numberPad: CustomNumberPad) {
        
    }
    
}

