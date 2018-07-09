//
//  CustomNumberPad.swift
//  CustomNumberPad
//
//  Created by Mickey on 2018/6/26.
//  Copyright © 2018年 Mickey. All rights reserved.
//

import UIKit

public protocol CustomNumberPadDelegate {
    func numberButtonClicked(numberPad: CustomNumberPad, number: Int)
    func deleteButtonClicked(numberPad: CustomNumberPad)
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
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViewFromXib()
    }
    
    deinit {
        delegate = nil
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
    
    // MARK: - Public Methods
    
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
        let number = Int((sendor.titleLabel?.text)!)
        delegate?.numberButtonClicked(numberPad: self, number: number!)
    }
    
    @IBAction func deleteButtonClicked(_ sendor: UIButton) {
        delegate?.deleteButtonClicked(numberPad: self)
    }
    
    @IBAction func touchIDButtonClicked(_ sendor: UIButton) {
        delegate?.touchIDButtonClicked(numberPad: self)
    }
    
}
