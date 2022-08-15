//
//  TimeSelectView.swift
//
//  Created by 陳Mike on 2021/7/8.
//

import UIKit
//可以選擇時間區間的CustomView
protocol TimeSelectViewDelegate {
//    三個按鈕的interface
    func leftAction(_ timeSelectView: TimeSelectView, button: UIButton, fromTextField: UITextField, toTextField: UITextField)
    func rightAction(_ timeSelectView: TimeSelectView,button: UIButton, fromTextField: UITextField, toTextField: UITextField)
    func okAction(_ timeSelectView: TimeSelectView,from: String, to: String)
}

class TimeSelectView: UIView, NibOwnerLoadable {
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var fromTimeTextField: UITextField!
    @IBOutlet weak var toTimeTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBAction func leftAction(_ sender: UIButton) {
        delegate?.leftAction(self, button: leftButton, fromTextField: fromTimeTextField, toTextField: toTimeTextField)
    }
    @IBAction func rightAction(_ sender: UIButton) {
        delegate?.rightAction(self, button: rightButton, fromTextField: fromTimeTextField, toTextField: toTimeTextField)
    }
    @IBAction func cancelAction(_ sender: UIButton) {
        self.removeView()
    }
    @IBAction func okAction(_ sender: UIButton) {
        if fromTimeTextField.isEditing || toTimeTextField.isEditing {return}
        delegate?.okAction(self, from: fromTimeTextField.text!, to: toTimeTextField.text!)
    }
//    可供改邊框的顏色
    var borderColor: UIColor? {
        didSet{
            setAllBorder()
        }
    }
    private let datePicker = UIDatePicker()
//    擋住背景的View
    let backView = UIView()
    var delegate: TimeSelectViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit() {
        loadNibContent()
        setView()
    }
    
    private func setView(){
        backView.backgroundColor = .black
        backView.alpha = 0.6
        setCorner(leftButton)
        setCorner(rightButton)
        setCorner(fromTimeTextField)
        setCorner(toTimeTextField)
        setCorner(cancelButton)
        setCorner(okButton)
        setAllBorder()
        setTimeField()
    }
    private func setAllBorder(){
        setBorder(leftButton)
        setBorder(rightButton)
        setBorder(fromTimeTextField)
        setBorder(toTimeTextField)
    }
    private func setBorder(_ view: UIView){
        view.layer.borderWidth = 1
        view.layer.borderColor = borderColor?.cgColor
    }
    private func setCorner(_ view: UIView){
        view.layer.cornerRadius = 5
    }
    private func setTimeField(){
        let formate = DateFormatter()
        formate.dateFormat = "yyyy/MM"
        let defaultDate = formate.string(from: Date())
        fromTimeTextField.text = defaultDate + "/01"
        let lastDat = Date().countOfDaysInMonth()
        toTimeTextField.text = "\(defaultDate)/\(lastDat)"
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier:"zh_TW")
        datePicker.maximumDate = Date()
        datePicker.date = Date()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        let dateDone = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(datePickerDone))
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(datePickerCancel))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let dateTool = UIToolbar()
        dateTool.items = [cancel, space, dateDone]
        dateTool.sizeToFit()
        
        fromTimeTextField.inputView = datePicker
        fromTimeTextField.inputAccessoryView = dateTool
        fromTimeTextField.delegate = self
        toTimeTextField.inputView = datePicker
        toTimeTextField.inputAccessoryView = dateTool
        toTimeTextField.delegate = self
    }
    @objc private func datePickerDone(){
        let formate = DateFormatter()
        formate.dateFormat = "yyyy/MM/dd"
        if fromTimeTextField.isEditing {
            fromTimeTextField.text = formate.string(from: datePicker.date)
            fromTimeTextField.resignFirstResponder()
        }else if toTimeTextField.isEditing {
            toTimeTextField.text = formate.string(from: datePicker.date)
            toTimeTextField.resignFirstResponder()
        }
    }
    @objc private func datePickerCancel(){
        fromTimeTextField.resignFirstResponder()
        toTimeTextField.resignFirstResponder()
    }
//    設定左邊按鈕的標題
    func setLeftButtonTitle(_ str: String) {
        leftButton.setTitle(str, for: .normal)
    }
//    設定右邊按鈕的標題
    func setRightButtonTitle(_ str: String) {
        rightButton.setTitle(str, for: .normal)
    }
//    將此CustomView加入畫面view
    func setup(to view: UIView) {
        let xPoint = (view.frame.width - self.frame.width) / 2
        let yPoint = (view.frame.height - self.frame.height) / 3
        self.frame = CGRect(origin: CGPoint(x: xPoint, y: yPoint), size: self.frame.size)
        backView.frame = view.bounds
        view.addSubview(backView)
        view.addSubview(self)
    }
//    將此CustomView移出畫面
    func removeView() {
        backView.removeFromSuperview()
        self.removeFromSuperview()
    }
}

extension TimeSelectView: UITextFieldDelegate {
//    設定datePicker預設的時間為textfield上的時間
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let formate = DateFormatter()
        formate.dateFormat = "yyyy/MM/dd"
        datePicker.date = formate.date(from: textField.text!) ?? Date()
        if textField == fromTimeTextField {
            datePicker.minimumDate = nil
            datePicker.maximumDate = formate.date(from: toTimeTextField.text ?? "")
        }else if textField == toTimeTextField {
            datePicker.minimumDate = formate.date(from: fromTimeTextField.text ?? "")
            datePicker.maximumDate = Date()
        }
        return true
    }
}
