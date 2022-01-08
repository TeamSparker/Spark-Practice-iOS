//
//  BaseViewController.swift
//  FloatingButton
//
//  Created by 양수빈 on 2022/01/07.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setUI()
    }
    
    // MARK: - Override Method
    func setLayout() {
        // Override Layout
    }
    
    func setUI() {
        view.backgroundColor = .black
    }
}
