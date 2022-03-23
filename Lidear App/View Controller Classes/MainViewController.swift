//
//  GameViewController.swift
//  Lidear App
//
//  Created by 潘若淮 on 2022/3/20.
//

import UIKit
import SpriteKit
import GameplayKit



class MainViewController: UIViewController {
    
    let debugMode = true
    
    let boxColor = UIColor(red: 241/255, green: 174/255, blue: 101/255, alpha: 0.7)
    
    let difficultyBoxColor = UIColor(red: 241/255, green: 174/255, blue: 101/255, alpha: 1)
    
    var selectedGameMode = 0 // 1 for memory game, 2 for obeservation game, 3 for responsiveness, 4 for abstract game, default is zero
    
    var selectedDifficulty = 0 // 1 for low, 2 for medium, 3 for high
    
    @IBOutlet weak var startGameButton: UIButton!
    
    @objc func onMemorySelected() {
        memoryGameButton.backgroundColor = boxColor
        observationGameButton.backgroundColor = .clear
        responsivenessGameButton.backgroundColor = .clear
        abstractGameButton.backgroundColor = .clear
        selectedGameMode = 1
    }
    
    @objc func onObservationSelected() {
        memoryGameButton.backgroundColor = .clear
        observationGameButton.backgroundColor = boxColor
        responsivenessGameButton.backgroundColor = .clear
        abstractGameButton.backgroundColor = .clear
        selectedGameMode = 2
    }
    
    @objc func onResponsivenesssSelected() {
        memoryGameButton.backgroundColor = .clear
        observationGameButton.backgroundColor = .clear
        responsivenessGameButton.backgroundColor = boxColor
        abstractGameButton.backgroundColor = .clear
        selectedGameMode = 3
    }
    
    @objc func onAbstractSelected() {
        memoryGameButton.backgroundColor = .clear
        observationGameButton.backgroundColor = .clear
        responsivenessGameButton.backgroundColor = .clear
        abstractGameButton.backgroundColor = boxColor
        selectedGameMode = 4
    }
    
    @IBOutlet weak var memoryGameButton: UIView!
    @IBOutlet weak var observationGameButton: UIView!
    @IBOutlet weak var responsivenessGameButton: UIView!
    @IBOutlet weak var abstractGameButton: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoryGameButton.layer.cornerRadius = 31
        observationGameButton.layer.cornerRadius = 31
        responsivenessGameButton.layer.cornerRadius = 31
        abstractGameButton.layer.cornerRadius = 31
        
        let touchOnMemory = UITapGestureRecognizer(target: self, action: #selector(onMemorySelected))
        let touchOnObservation = UITapGestureRecognizer(target: self, action: #selector(onObservationSelected))
        let touchOnResponsiveness = UITapGestureRecognizer(target: self, action: #selector(onResponsivenesssSelected))
        let touchOnAbstract = UITapGestureRecognizer(target: self, action: #selector(onAbstractSelected))
        
        memoryGameButton.addGestureRecognizer(touchOnMemory)
        observationGameButton.addGestureRecognizer(touchOnObservation)
        responsivenessGameButton.addGestureRecognizer(touchOnResponsiveness)
        abstractGameButton.addGestureRecognizer(touchOnAbstract)
        
        startGameButton.layer.cornerRadius = 20
        
        initializeBGPanelView()
        
        initializeDifficultyOptionPanel()
        
        initializeDifficultyChosenButtons()
        
        
    }
    @IBOutlet weak var backgroundPanelView: UIView!
    

    func initializeBGPanelView() {
        backgroundPanelView.layer.cornerRadius = 24

        backgroundPanelView.layer.shadowOpacity = 0.7
        backgroundPanelView.layer.shadowOffset = CGSize(width: 3, height: 3)
        backgroundPanelView.layer.shadowRadius = 5.0
        backgroundPanelView.layer.shadowColor = UIColor.darkGray.cgColor

    }
    
    @IBOutlet weak var dificultyOptionsView: UIView!
    func initializeDifficultyOptionPanel() {
        dificultyOptionsView.layer.cornerRadius = 40

        dificultyOptionsView.layer.shadowOpacity = 0.3
        dificultyOptionsView.layer.shadowOffset = CGSize(width: 0, height:2.57)
        dificultyOptionsView.layer.shadowRadius = 5.15
        dificultyOptionsView.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    @IBOutlet weak var lowDifficultyButton: UIView!
    @IBOutlet weak var mediumDifficultyButton: UIView!
    @IBOutlet weak var highDifficultyButton: UIView!
    
    func initializeDifficultyChosenButtons() {
        lowDifficultyButton.layer.cornerRadius = dificultyOptionsView.frame.height / 2
        mediumDifficultyButton.layer.cornerRadius = dificultyOptionsView.frame.height / 2
        highDifficultyButton.layer.cornerRadius = dificultyOptionsView.frame.height / 2
        
        let touchOnLow = UITapGestureRecognizer(target: self, action: #selector(onLowDifficultySelected))
        let touchOnMedium = UITapGestureRecognizer(target: self, action: #selector(onMediumDifficultySelected))
        let touchOnHigh = UITapGestureRecognizer(target: self, action: #selector(onHighDifficultySelected))
        
        lowDifficultyButton.addGestureRecognizer(touchOnLow)
        mediumDifficultyButton.addGestureRecognizer(touchOnMedium)
        highDifficultyButton.addGestureRecognizer(touchOnHigh)
        
        // starts with low difficulty selected
        onLowDifficultySelected()
        
    }
    
    @objc func onLowDifficultySelected() {
        lowDifficultyButton.backgroundColor = difficultyBoxColor
        mediumDifficultyButton.backgroundColor = .clear
        highDifficultyButton.backgroundColor = .clear
        selectedDifficulty = 1
        
        lowDifficultyButton.layer.cornerRadius = 40
        lowDifficultyButton.layer.shadowOpacity = 0.3
        lowDifficultyButton.layer.shadowOffset = CGSize(width: 0, height:2.57)
        lowDifficultyButton.layer.shadowRadius = 5.15
        lowDifficultyButton.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    @objc func onMediumDifficultySelected() {
        
        if debugMode {
            UIControllerAlertManager.instance.debugNotification(view: mediumDifficultyButton)
            return
        }
        
        lowDifficultyButton.backgroundColor = .clear
        mediumDifficultyButton.backgroundColor = difficultyBoxColor
        highDifficultyButton.backgroundColor = .clear
        selectedDifficulty = 2
        
        mediumDifficultyButton.layer.cornerRadius = 40
        mediumDifficultyButton.layer.shadowOpacity = 0.3
        mediumDifficultyButton.layer.shadowOffset = CGSize(width: 0, height:2.57)
        mediumDifficultyButton.layer.shadowRadius = 5.15
        mediumDifficultyButton.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    @objc func onHighDifficultySelected() {
        
        if debugMode {
            UIControllerAlertManager.instance.debugNotification(view: highDifficultyButton)
            return
        }
        
        lowDifficultyButton.backgroundColor = .clear
        mediumDifficultyButton.backgroundColor = .clear
        highDifficultyButton.backgroundColor = difficultyBoxColor
        selectedDifficulty = 3
        
        highDifficultyButton.layer.cornerRadius = 40
        highDifficultyButton.layer.shadowOpacity = 0.3
        highDifficultyButton.layer.shadowOffset = CGSize(width: 0, height:2.57)
        highDifficultyButton.layer.shadowRadius = 5.15
        highDifficultyButton.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    @IBAction func startGame(_ sender: Any) {
        
        switch selectedGameMode {
        case 1:
            self.performSegue(withIdentifier: "toMemoryGameSegue", sender: self)
            break
        case 2:
            self.performSegue(withIdentifier: "toObservationGameSegue", sender: self)
            break
        case 3:
            self.performSegue(withIdentifier: "toResponsivenessGameSegue", sender: self)
            break
        case 4:
            self.performSegue(withIdentifier: "toAbstractGameSegue", sender: self)
            break
        default:
            UIControllerAlertManager.instance.customAlert(view: startGameButton, title: "未选择游戏类型", message: "请点击相应的训练游戏后，再开始游戏（比如记忆力训练）。", buttonTitle: "确认")
        }
        
        // TODO: the building of difficulty variation is still in process
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
}
