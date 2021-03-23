//
//  CodeButton.swift
//  FSDK
//
//  Created by yangliu on 2020/6/2.
//  Copyright © 2020 founq. All rights reserved.
//

import UIKit

// MARK: 获取验证码倒计时按钮

class CodeButton: UIButton {
    // 创建Timer计时器
    var countdownTimer: Timer?
    // 倒计时时长
    var sumTime: Int = 10 {
        didSet {
            tempDurationOfCountDown = sumTime
        }
    }

    // 倒计时结束文字颜色
    var finishBtnTitleColor = UIColor(red: 220 / 255.0, green: 83 / 255.0, blue: 83 / 255.0, alpha: 1)
    // 倒计时结束边框颜色
    var finishBtnBorderColor = UIColor(red: 220 / 255.0, green: 83 / 255.0, blue: 83 / 255.0, alpha: 1)
    // 倒计时结束文案
    var finishBtnTitle: String = "重新获取"

    // 倒计时中文字颜色
    var selectBtnTitleColor = UIColor(red: 102 / 255.0, green: 102 / 255.0, blue: 102 / 255.0, alpha: 1)
    // 倒计时中边框颜色
    var selectBtnBorderColor = UIColor(red: 102 / 255.0, green: 102 / 255.0, blue: 102 / 255.0, alpha: 1)

    // 剩余时间
    private var tempDurationOfCountDown: Int = 0

    // 用来控制用户进后台，倒计时继续走
    // 进入后台时的时间
    private var backDate: Date?
    // 重新进入前台的时间
    private var frontDate: Date?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startCountDown() {
        self.isEnabled = false
        countdownTimer = Timer(timeInterval: 1, target: self, selector: #selector(updateCountDownButtonTitle), userInfo: nil, repeats: true)
        guard let timer = countdownTimer else {
            return
        }
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        backDate = Date()
    }

    @objc func updateCountDownButtonTitle() {
        frontDate = Date()
        guard let front = backDate else {
            return
        }
        // 从后台进入前台 需要减去时间差，否则倒计时与进入后台时间一样
        let interval: Double? = frontDate?.timeIntervalSince(front)
        let time = Int(interval ?? 0)
        if time > sumTime - tempDurationOfCountDown {
            tempDurationOfCountDown = sumTime - time
        }
        if tempDurationOfCountDown <= 0 {
            self.isEnabled = true
            self.setTitle(finishBtnTitle, for: UIControl.State.normal)
            self.setTitleColor(finishBtnTitleColor, for: UIControl.State.normal)
            self.layer.borderColor = finishBtnBorderColor.cgColor
            tempDurationOfCountDown = sumTime
            self.cleanTimer()
        } else {
            let timeStr = String(format: "%d秒后重发", tempDurationOfCountDown)
            self.setTitle(timeStr, for: UIControl.State.normal)
            self.setTitleColor(selectBtnTitleColor, for: UIControl.State.normal)
            self.layer.borderColor = selectBtnBorderColor.cgColor
            tempDurationOfCountDown = tempDurationOfCountDown - 1
        }
    }

    deinit {
        self.cleanTimer()
    }

    public func cleanTimer() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
}
