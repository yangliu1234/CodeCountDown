//
//  ViewController.swift
//  CodeBtnDemo
//
//  Created by yangliu on 2021/3/23.
//

import UIKit

class ViewController: UIViewController {

    //获取验证码按钮
    lazy var codeBtn: CodeButton = {
        () -> CodeButton in
        let codeBtn = CodeButton()
        codeBtn.sumTime = 20
        //初始状态属性
        codeBtn.setTitle("获取验证码", for: UIControl.State.normal)
        codeBtn.setTitleColor(UIColor.init(red: 220 / 255.0, green: 83 / 255.0, blue: 83 / 255.0, alpha: 1), for: UIControl.State.normal)
        codeBtn.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 10)
        codeBtn.layer.cornerRadius = 2.5
        codeBtn.layer.masksToBounds = true
        codeBtn.layer.borderWidth = 1
        codeBtn.layer.borderColor = UIColor.init(red: 220 / 255.0, green: 83 / 255.0, blue: 83 / 255.0, alpha: 1).cgColor
        codeBtn.addTarget(self, action: #selector(codeBtnClick), for: .touchUpInside)
        return codeBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(codeBtn)
        codeBtn.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
    }


    //MARK: 倒计时按钮的点击事件,按钮倒计时
    @objc func codeBtnClick() {
        codeBtn.startCountDown()
    }
    
}

