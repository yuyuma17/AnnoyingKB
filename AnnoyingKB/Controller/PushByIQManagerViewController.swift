//
//  PushByIQManagerViewController.swift
//  AnnoyingKB
//
//  Created by 黃士軒 on 2020/1/9.
//  Copyright © 2020 Lacie. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class PushByIQManagerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapGesture()
        IQKeyboardManager.shared.enable = true
    }
}

extension PushByIQManagerViewController {
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
