//
//  InputField.swift
//  BasicQRApp
//
//  Created by Ananth Desai on 29/12/24.
//

import Foundation

class InputFieldView: UIView {
  private weak var textFieldRef: UITextField? = nil
  
  @objc public var onReturn: RCTDirectEventBlock?
  @objc public var initialValue: NSString? {
    didSet {
      textFieldRef?.text = initialValue?.description
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let constraints = setupTextfield()
    NSLayoutConstraint.activate(constraints)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupTextfield() -> [NSLayoutConstraint] {
    let textField = UITextField()
    textFieldRef = textField
    textField.delegate = self
    textField.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.addSubview(textField)
    
    return [
    ]
  }
  
  @objc
  func getValue() -> String? {
    print("textFieldRef?.text")
    return textFieldRef?.text
  }
}

extension InputFieldView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    if textField.text != nil {
      onReturn!(["item" : textField.text])
    }
    return true
  }
}
