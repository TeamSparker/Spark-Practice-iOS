//
//  ViewController.swift
//  Stopwatch
//
//  Created by 양수빈 on 2022/01/07.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    var timerLabel = UILabel()
    var resetButton = UIButton()
    var startButton = UIButton()
    var stopTimeLabel = UILabel() /// 멈췄을 때 시간 표시하는 라벨

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setUI()
    }

    func setLayout() {
        view.addSubview(timerLabel)
        view.addSubview(resetButton)
        view.addSubview(startButton)
        view.addSubview(stopTimeLabel)
        
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(300)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(80)
            make.width.height.equalTo(100)
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(40)
            make.trailing.equalToSuperview().inset(80)
            make.width.height.equalTo(100)
        }
        
        stopTimeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(resetButton.snp.bottom).offset(40)
        }
    }
    
    func setUI() {
        timerLabel.text = "00:00:00"
        timerLabel.font = .systemFont(ofSize: 40)
        
        stopTimeLabel.text = "-"
        
        startButton.setTitle("start", for: .normal)
        resetButton.setTitle("reset", for: .normal)
        
        startButton.backgroundColor = .blue
        resetButton.backgroundColor = .red
        
        startButton.layer.cornerRadius = 50
        resetButton.layer.cornerRadius = 50
    }

}

