//
//  ForgotPasswordViewController.swift
//  healthypay
//
//  Created by 陳Mike on 2021/9/9.
//

import UIKit
protocol ForgotPasswordViewControllerDelegate: AnyObject {
    func getVerifyAction(_ viewController: ForgotPasswordViewController, phone: String)
    func verifyAction(_ viewController: ForgotPasswordViewController, newUser: User, verifyCode: String)
}

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var verifyTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var comfirmTextField: UITextField!
    @IBOutlet weak var visibleButton: UIButton!
    @IBOutlet weak var visible2Button: UIButton!
    @IBOutlet weak var getVerifyButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func getVerifyAction(_ sender: UIButton) {
        view.endEditing(true)
        let predicate = NSPredicate(format: "SELF MATCHES %@", "^09[0-9]{8}$")
        guard let phone = phoneTextField.text, predicate.evaluate(with: phone) else{
            let alert = UIAlertController.simpleOKAlert(title: "電話格式錯誤", message: "", buttonTitle: "確認", action: nil)
            present(alert, animated: true, completion: nil)
            return}
        phoneNumber = phone
        delegate?.getVerifyAction(self, phone: phone)
        getVerifyButton.setTitle("Waiting..", for: .disabled)
        getVerifyButton.isEnabled = false
        countDount = 120
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setCountdown), userInfo: nil, repeats: true)
    }
    @IBAction func visibleAction(_ sender: Any) {
        if passwordTextField.isSecureTextEntry {
            visibleButton.setImage(UIImage(named: "iconInvisible"), for: .normal)
            passwordTextField.isSecureTextEntry = false
        }else{
            visibleButton.setImage(UIImage(named: "iconVisible"), for: .normal)
            passwordTextField.isSecureTextEntry = true
        }
    }
    @IBAction func visible2Action(_ sender: Any) {
        if comfirmTextField.isSecureTextEntry {
            visible2Button.setImage(UIImage(named: "iconInvisible"), for: .normal)
            comfirmTextField.isSecureTextEntry = false
        }else{
            visible2Button.setImage(UIImage(named: "iconVisible"), for: .normal)
            comfirmTextField.isSecureTextEntry = true
        }
    }
    @IBAction func submitAction(_ sender: Any) {
        view.endEditing(true)
        guard let code = verifyTextField.text, let pwd = passwordTextField.text, let confirmPwd = comfirmTextField.text else {return}
        guard code != "", phoneNumber != "", pwd != "", confirmPwd == pwd else {
            let alert = UIAlertController.simpleOKAlert(title: "欄位不能空白", message: "", buttonTitle: "確認", action: nil)
            present(alert, animated: true, completion: nil)
            return}
        let user = User()
        user.member_id = phoneNumber
        user.member_pwd = pwd
        delegate?.verifyAction(self, newUser: user, verifyCode: code)
    }
    
    weak var delegate: ForgotPasswordViewControllerDelegate?
    weak var timer: Timer?
    var countDount = 0
    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyBoard()
        setBtnView()
        phoneTextField.delegate = self
        verifyTextField.delegate = self
        passwordTextField.delegate = self
        comfirmTextField.delegate = self
        setBorderView()
    }
    
    func setBorderView(){
        borderView.layer.borderWidth = 0.5
        borderView.layer.borderColor = UIColor.lightGray.cgColor
        borderView.layer.cornerRadius = 10
        phoneTextField.setBottomBorder()
        verifyTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        comfirmTextField.setBottomBorder()
    }

    func hideKeyBoard(){
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(cancelFocus))
        tapGes.cancelsTouchesInView = false
        self.scrollView.addGestureRecognizer(tapGes)
    }
    @objc func cancelFocus(){
        self.view.endEditing(true)
    }
    func setBtnView(){
        //外框線
        sendButton.layer.borderWidth = 1
        getVerifyButton.layer.borderWidth = 1
        //systemBlue
//        sendButton.layer.borderColor = CGColor(red: 0, green: 122/255, blue: 255/255, alpha: 0.7)
        sendButton.layer.borderColor = UIColor(red: 78/255, green: 171/255, blue: 173/255, alpha: 0.7).cgColor
        sendButton.layer.cornerRadius = 5
//        getVerifyButton.layer.borderColor = CGColor(red: 0, green: 122/255, blue: 255/255, alpha: 0.7)
        getVerifyButton.layer.borderColor = UIColor(red: 78/255, green: 171/255, blue: 173/255, alpha: 0.7).cgColor
        getVerifyButton.layer.cornerRadius = 5
    }
    @objc func setCountdown(){
        if countDount < 1 {
            getVerifyButton.isEnabled = true
            timer?.invalidate()
        }else{
            getVerifyButton.setTitle("\(String(format: "%02d", countDount/60))：\(String(format: "%02d", countDount%60))", for: .disabled)
            countDount -= 1
        }
    }
    
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

