//
//  CustomNumberPad.swift
//  CustomNumberPad
//
//  Created by Mickey on 2018/6/26.
//  Copyright © 2018年 Mickey. All rights reserved.
//

import UIKit

public protocol CustomNumberPadDelegate {
    func touchIDButtonClicked(numberPad: CustomNumberPad)
}

public class CustomNumberPad: UIView {
    
    private static let nibName = "CustomNumberPad"
    
    private static let viewWidth = Int(UIScreen.main.bounds.width)
    private static let viewHeight = Int(UIScreen.main.bounds.height)
    
    private weak var textInput: (UIResponder & UITextInput)?
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var touchIDButton: UIButton!

    public var delegate: CustomNumberPadDelegate?
    
    
    // MARK: - init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViewFromXib()
        addObserver()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViewFromXib()
        addObserver()
    }
    
    deinit {
        delegate = nil
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidEndEditing, object: nil)
        textInput = nil
    }
    
    private func setupViewFromXib() {
        let nib = UINib(nibName: CustomNumberPad.nibName, bundle: bundle()).instantiate(withOwner: self, options: nil)
        let view = nib.first as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
        [numberButtons, [deleteButton, touchIDButton]].joined().forEach {
            $0.layoutIfNeeded()
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = $0.frame.size.width/2
        }
    }
    
    private func bundle() -> Bundle {
        return Bundle(for: type(of: self))
    }
    
    private static func defaultFrame() -> CGRect {
        return CGRect(x: 0, y: 0, width: CustomNumberPad.viewWidth, height: CustomNumberPad.viewHeight)
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(editingDidBegin), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editingDidEnd), name: NSNotification.Name.UITextFieldTextDidEndEditing, object: nil)
    }
    
    // MARK: - Public Methods - Buttons Attributes
    
    public func setViewBgColor(_ color: UIColor) {
        containerView.backgroundColor = color
    }
    
    public func setButtonsTitleColor(_ normalColor: UIColor, selectedColor: UIColor) {
        setNumberButtonsTitleColor(normalColor, selectedColor: selectedColor)
        setDeleteButtonTitleColor(normalColor, selectedColor: selectedColor)
        setTouchIDButtonTitleColor(normalColor)
    }
    
    public func setButtonsBgColor(_ normalColor: UIColor, selectedColor: UIColor) {
        setNumberButtonsBgColor(normalColor, selectedColor: selectedColor)
        setDeleteButtonBgColor(normalColor, selectedColor: selectedColor)
        setTouchIDButtonBgColor(normalColor)
    }
    
    public func setButtonsFont(_ font:UIFont) {
        setNumberButtonsFont(font)
        setDeleteButtonFont(font)
    }
    
    /* Number Buttons */
    
    public func setNumberButtonsTitleColor(_ normalColor: UIColor, selectedColor: UIColor) {
        numberButtons.forEach {
            $0.setTitleColor(normalColor, for: .normal)
            $0.setTitleColor(selectedColor, for: .selected)
        }
    }
    
    public func setNumberButtonsBgColor(_ normalColor: UIColor, selectedColor: UIColor) {
        numberButtons.forEach {
            $0.backgroundColor = $0.isSelected ? selectedColor : normalColor
        }
    }
    
    public func setNumberButtonsFont(_ font: UIFont) {
        numberButtons.forEach {
            $0.titleLabel?.font = font
        }
    }
    
    /* Delete Button */
    
    public func setDeleteButtonTitleColor(_ normalColor: UIColor, selectedColor: UIColor) {
        deleteButton.setTitleColor(normalColor, for: .normal)
        deleteButton.setTitleColor(selectedColor, for: .selected)
    }
    
    public func setDeleteButtonBgColor(_ normalColor: UIColor, selectedColor: UIColor) {
        deleteButton.backgroundColor = deleteButton.isSelected ? selectedColor : normalColor
    }
    
    public func setDeleteButtonFont(_ font: UIFont) {
        deleteButton.titleLabel?.font = font
    }
    
    /* TouchID Button */
    
    public func setTouchIDButtonTitleColor(_ color: UIColor) {
        touchIDButton.tintColor = color
    }
    
    public func setTouchIDButtonImage(_ image: UIImage) {
        touchIDButton.setImage(image, for: .normal)
    }
    
    public func setTouchIDButtonBgColor(_ color: UIColor) {
        touchIDButton.backgroundColor = color
    }
    
    // MARK: - Buttons Actions
    
    @IBAction func numberButtonsClicked(_ sendor: UIButton) {
        if self.textInput == nil {
            return
        }
        
        let number = sendor.titleLabel?.text
        if let selectedTextRange = self.textInput?.selectedTextRange {
            self.textInput(self.textInput, replaceTextAt: selectedTextRange, with: number)
        }
    }
    
    @IBAction func deleteButtonClicked(_ sendor: UIButton) {
        if self.textInput == nil {
            return
        }
        
        if let selectedRange = self.textInput?.selectedTextRange {
            let startPosition = self.textInput?.position(from: selectedRange.start, offset: -1)
            if let startPosition = startPosition {
                let endPosition = selectedRange.end
                let rangeToDelete = self.textInput?.textRange(from: startPosition, to: endPosition)
                self.textInput(self.textInput, replaceTextAt: rangeToDelete, with: "")
            }
        }
    }
    
    @IBAction func touchIDButtonClicked(_ sendor: UIButton) {
        delegate?.touchIDButtonClicked(numberPad: self)
    }
    
    // MARK: - TextInput
    
    @objc private func editingDidBegin(notification: Notification) {
        if notification.object is UIResponder {
            if notification.object is UITextInput {
                textInput = notification.object as? (UIResponder & UITextInput)
                return
            }
        }
        textInput = nil
    }
    
    @objc private func editingDidEnd(notification: Notification) {
        textInput = nil
    }
    
    private func textInput(_ textInput: UITextInput?, replaceTextAt textRange: UITextRange?, with string: String?) {
        if textInput == nil && textRange == nil {
            return
        }
        
        let startPosition = textInput?.offset(from: (textInput?.beginningOfDocument)!, to: (textRange?.start)!)
        let length = textInput?.offset(from: (textRange?.start)!, to: (textRange?.end)!)
        let selectedRange = NSRange(location: startPosition ?? 0, length: length ?? 0)
        
        if self.textInput(textInput, shouldChangeCharactersIn: selectedRange, with: string ?? "") {
            if let textRange = textRange {
                textInput?.replace(textRange, withText: string ?? "")
            }
        }
    }
    
    private func textInput(_ textInput: UITextInput?, shouldChangeCharactersIn range: NSRange?, with string:String) -> Bool {
        let textField = textInput as? UITextField
        if let textField = textField {
            if textField.delegate?.textField?(textField, shouldChangeCharactersIn: range!, replacementString: string) ?? false {
                return true
            } else {
                // Delegate does not respond, so default to YES
                return true
            }
        }
        return false
    }
    
}
