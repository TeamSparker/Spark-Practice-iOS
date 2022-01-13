//
//  ViewController.swift
//  Stopwatch
//
//  Created by 양수빈 on 2022/01/07.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    let stopwatch: Stopwatch = Stopwatch()
    var timerLabel = UILabel()
    var resetButton = UIButton()
    var startButton = UIButton()
    var stopTimeLabel = UILabel() /// 멈췄을 때 시간 표시하는 라벨
    var isPlay: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setUI()
        setAddTarget()
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

    func setAddTarget() {
        startButton.addTarget(self, action: #selector(startPauseTimer(_:)), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetTimer(_:)), for: .touchUpInside)
    }
    
    /// start 버튼을 눌렀을 때 isPlay의 상태에 따라 버튼, 라벨 상태 변경
    @objc
    func startPauseTimer(_ sender: AnyObject) {
        /// 실행중 X, 스톱워치 시작 + 버튼 변경
        /// 실행중 O, 스톱워치
        if !isPlay {
            unowned let weakSelf = self
            
            /// 0.035초마다 updateMainTimer 함수 호출하는 타이머
            stopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: #selector(updateMainTimer), userInfo: nil, repeats: true)
            
            /// RunLoop에서 timer 객체를 추가해서 관리
            RunLoop.current.add(stopwatch.timer, forMode: .common)
            
            /// 실행X -> 실행O
            isPlay = true
            changeButton(startButton, title: "Stop", titleColor: .white)
        } else {
            /// 버튼 눌렀을 때의 timerLabel의 값을 stopTimeLabel에 넣음
            stopTimeLabel.text = timerLabel.text
            
            /// RunLoop 객체로부터 timer를 제거하기 위한 함수 (반복 타이머 중지)
            stopwatch.timer.invalidate()
            
            /// 실행O -> 실행X
            isPlay = false
            changeButton(startButton, title: "Start", titleColor: .white)
        }
    }
    
    @objc
    func resetTimer(_ sender: AnyObject) {
        /// 실행중 X (스톱워치가 멈춘 상태라면), reset
        /// 실행중 O (스톱워치가 돌아가는 상태라면), print
        if !isPlay {
            resetMainTimer()
        } else {
            print("먼저 멈추지?")
        }
    }
    
    @objc
    func updateMainTimer() {
        updateTimer(stopwatch, label: timerLabel)
    }
    
    func changeButton(_ button: UIButton, title: String, titleColor: UIColor) {
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(titleColor, for: UIControl.State())
    }
    
    func resetMainTimer() {
        resetTimer(stopwatch, label: timerLabel)
        stopTimeLabel.text = "-"
    }
    
    /// stopwatch를 멈추고, label을 reset하는 함수
    func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    /// timer를 증가시키면서 label의 값에 반영시키는 함수
    func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter = stopwatch.counter + 0.035
        
        var minutes: String = "\((Int)(stopwatch.counter / 60))"
        if (Int)(stopwatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        
        var seconds: String = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        
        label.text = minutes + ":" + seconds
    }
}

