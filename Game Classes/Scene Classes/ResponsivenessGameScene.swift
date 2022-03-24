//
//  ResponsivenessGameScene.swift
//  Lidear App
//
//  Created by 潘若淮 on 2022/3/22.
//

import SpriteKit

struct largeBoxConfig {
    
    static let width: CGFloat = 221
    static let cornerRadius: CGFloat = 46
    static let hiddenColor: UIColor = UIColor(red: 237/255, green: 199/255, blue: 132/255, alpha: 1)
    static let shownColor: UIColor = UIColor(red: 239/255, green: 156/255, blue: 72/255, alpha: 1)
    static let largeOctopus = "Octopus Big@3x.png"
    static let largeButterfly = "Butterfly@3x.png"
}

struct smallBoxConfig {
    static let width: CGFloat = 124
    static let cornerRadius: CGFloat = 31
    static let color: UIColor = UIColor(red: 239/255, green: 156/255, blue: 72/255, alpha: 1)
    static let smallOctopus = "Octopus Small@3x.png"
    static let smallButterfly = "Butterfly@2x.png"
}

class ResponsivenessGameScene: SKScene {
    
    var currentType: UInt? // 1 for octopus, 2 for butterfly
    var clickable: Bool = false // if the icon shows up, then the buttons are clickable
    var isGameOver: Bool = false
    var userHasClickedThisRound = false
    
    var userWins = false
    var score = 0
    let totalRounds = 8
    
    
    var fallableRoundsCounter = 3
    let totalFallableRounds = 3
    
    let iconInterval = 0.2 // 0.2s interval between swapping icons
    let iconRetention = 1.0 // 1s to show the icon
    
    
    let highlightMaskAnimation = SKAction.sequence([SKAction.fadeAlpha(to: 0.6, duration: TimeInterval(0.1)), SKAction.fadeOut(withDuration: TimeInterval(0.1))])
    
    override func didMove(to view: SKView) {
        initializeVariables()
        
        var currentStartTime = 1.0
        let startTimeDelay = iconRetention + iconInterval
        
        // start main loop for 8 times
        for _ in 0..<totalRounds {
            
            
            // randomly chooose the 1 of two types and 1 of 3 spots
            let chosenType = UInt(arc4random() % 2 + 1)
            let chosenSpot = UInt(arc4random() % 3 + 1)
            
            
            // 1. box appears
            Timer.scheduledTimer(withTimeInterval: TimeInterval(currentStartTime), repeats: false) { timer in
                self.boxWillBeShown(chosenType: chosenType, chosenSpot: chosenSpot) // takes 0.2s
            }
            
            // 2. After 0.8s, box takes 0.2s to disappear
            Timer.scheduledTimer(withTimeInterval: TimeInterval(currentStartTime + 0.8), repeats: false) { timer in
                self.boxWillDisappear(chosenSpot: chosenSpot)
            }
            
            // 3. after 1s, shownBox behind the hiddenBox should be removed
            Timer.scheduledTimer(withTimeInterval: TimeInterval(currentStartTime + 1.0), repeats: false) { timer in
                self.boxDidDisapear()
            }
            
            
            currentStartTime += startTimeDelay
            
        }
        Timer.scheduledTimer(withTimeInterval: TimeInterval(currentStartTime), repeats: false) { timer in
            self.isGameOver = true
            // if the user wins, this executes, since the score is
            if self.score > (self.totalRounds - self.totalFallableRounds) {
                SKSceneAlertManager.instance.gameSucceed(scene: self)
            }
            
        }
    }
    
    private func initializeVariables() {
        generateBackgroundPlate()
        generateThreeLargeHiddenBoxes()
        generateTwoSmallTouchableBoxes()
    }
    
    // showing animation time is 0.2s, returns the number of chosenspot
    private func boxWillBeShown(chosenType: UInt, chosenSpot: UInt) {
        
        currentType = chosenType
        
        userHasClickedThisRound = false // reajust this to false to count this round whether user has typed
        
        let largeShownBox = self.generateSquare(width: largeBoxConfig.width, color: largeBoxConfig.shownColor, cornerRadius: largeBoxConfig.cornerRadius)
        largeShownBox.zPosition = 3
        
        
        let imageNode = chosenType == 1 ? SKSpriteNode(imageNamed: largeBoxConfig.largeOctopus) : SKSpriteNode(imageNamed: largeBoxConfig.largeButterfly)
        
        imageNode.setScale(2.5)
        
        imageNode.zPosition = 1
        
        largeShownBox.addChild(imageNode)
        
        let chosenLargeHiddenBox = self.childNode(withName: "largeHiddenBox\(chosenSpot)")
        largeShownBox.position = (chosenLargeHiddenBox?.position)!
        
        largeShownBox.name = "currentLargeShownBox"
        
        // enable game button checking
        self.clickable = true
        
        self.addChild(largeShownBox)
        chosenLargeHiddenBox?.run(SKAction.fadeOut(withDuration: TimeInterval(0.05)))
        
    }
    
    
    // disappearing animation time is 0.2
    private func boxWillDisappear(chosenSpot: UInt) {
        
        let chosenLargeHiddenBox = self.childNode(withName: "largeHiddenBox\(chosenSpot)")
        chosenLargeHiddenBox?.run(SKAction.fadeIn(withDuration: TimeInterval(0.05)))
        
    }
    
    
    // removing the shown box, disable the clickable
    private func boxDidDisapear() {
        
        if !userHasClickedThisRound {
            self.fallableRoundsCounter -= 1
        } else {
            score += 1
        }
        
        
        // remove current shown box
        let currentShownBox = self.childNode(withName: "currentLargeShownBox")
        currentShownBox?.removeFromParent()
        
        self.clickable = false
            
        
        
        
        
    }
    
    
    private func gameplayButtonCheck(chosenButtonNum: UInt) {
        if self.clickable {
            // if self.clickable is true, means the box has been shown, and the choice of user is recognizable
            if self.currentType == chosenButtonNum {
                // the user chosen the right number, continue the game
            } else {
                fallableRoundsCounter -= 1
                
            }
        } else { // if the user taps on the button too early or too late
            fallableRoundsCounter -= 1
        }
        
    }
    
    private func checkGameOver() {
        if fallableRoundsCounter <= 0 {
            self.isGameOver = true
            fullyStopAnimation()
            SKSceneAlertManager.instance.gameOver(scene: self, withMessage: "游戏结束，您点错或未点三次了")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if !isGameOver {
            checkGameOver()
        }
        
        if isGameOver {
            fullyStopAnimation()
            
        }
    }
    
    
    private func fullyStopAnimation() {

        let node1 = self.childNode(withName: "largeHiddenBox1")
        let node2 = self.childNode(withName: "largeHiddenBox2")
        let node3 = self.childNode(withName: "largeHiddenBox3")
        
        
        
   
        node1?.removeAllActions()
        node2?.removeAllActions()
        node3?.removeAllActions()
        node1?.alpha = 1
        node2?.alpha = 1
        node3?.alpha = 1
    
        
        
    }
    
    
    
    private func generateBackgroundPlate() {
        let bgPlate = SKShapeNode(rect: CGRect(origin: CGPoint(x: -900/2, y: -550/2), size: CGSize(width: 900, height: 550)), cornerRadius: 65)
        bgPlate.fillColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
        bgPlate.zPosition = 1
        bgPlate.position = CGPoint(x: 0, y: -20)
        self.addChild(bgPlate)
    }
    
    
    private func generateSquare(width: CGFloat, color: UIColor, cornerRadius: CGFloat) -> SKShapeNode {
        let rectangle = CGRect(origin: CGPoint(x: -width/2, y: -width/2), size: CGSize(width: width, height: width))
        let roundedSKNode = SKShapeNode(rect: rectangle, cornerRadius: cornerRadius)
        roundedSKNode.fillColor = color
        roundedSKNode.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

        return roundedSKNode
    }
    
    
    private func generateThreeLargeHiddenBoxes() {
        let largeHiddenBox1 = generateSquare(width: largeBoxConfig.width, color: largeBoxConfig.hiddenColor, cornerRadius: largeBoxConfig.cornerRadius)
        let largeHiddenBox2 = generateSquare(width: largeBoxConfig.width, color: largeBoxConfig.hiddenColor, cornerRadius: largeBoxConfig.cornerRadius)
        let largeHiddenBox3 = generateSquare(width: largeBoxConfig.width, color: largeBoxConfig.hiddenColor, cornerRadius: largeBoxConfig.cornerRadius)
        
        largeHiddenBox1.zPosition = 5
        largeHiddenBox2.zPosition = 5
        largeHiddenBox3.zPosition = 5
        
        largeHiddenBox1.name = "largeHiddenBox1"
        largeHiddenBox2.name = "largeHiddenBox2"
        largeHiddenBox3.name = "largeHiddenBox3"
        
        largeHiddenBox1.position = CGPoint(x: -270, y: 70)
        largeHiddenBox2.position = CGPoint(x: 0, y: 70)
        largeHiddenBox3.position = CGPoint(x: 270, y: 70)
        
        self.addChild(largeHiddenBox1)
        self.addChild(largeHiddenBox2)
        self.addChild(largeHiddenBox3)
        
    }
    
    
    private func generateTwoSmallTouchableBoxes() {
        let smallTouchableBox1 = generateSquare(width: smallBoxConfig.width, color: smallBoxConfig.color, cornerRadius: smallBoxConfig.cornerRadius)
        let smallTouchableBox2 = generateSquare(width: smallBoxConfig.width, color: smallBoxConfig.color, cornerRadius: smallBoxConfig.cornerRadius)
        let highlightMask1 = generateSquare(width: smallBoxConfig.width, color: UIColor(red: 1, green: 1, blue: 1, alpha: 1), cornerRadius: smallBoxConfig.cornerRadius)
        let highlightMask2 = generateSquare(width: smallBoxConfig.width, color: UIColor(red: 1, green: 1, blue: 1, alpha: 1), cornerRadius: smallBoxConfig.cornerRadius)
        
        let octopusNode = SKSpriteNode(imageNamed: smallBoxConfig.smallOctopus)
        let butterflyNode = SKSpriteNode(imageNamed: smallBoxConfig.smallButterfly)
        
        octopusNode.zPosition = 1
        butterflyNode.zPosition = 1
        
        octopusNode.name = "smallTouchableBox1"
        butterflyNode.name = "smallTouchableBox2"
        
        octopusNode.scale(to: CGSize(width: 82, height: 74))
        butterflyNode.scale(to: CGSize(width: 82, height: 67))
        
        smallTouchableBox1.addChild(octopusNode)
        smallTouchableBox2.addChild(butterflyNode)
        
        
        
        smallTouchableBox1.position = CGPoint(x: -270, y: -160)
        smallTouchableBox2.position = CGPoint(x: 270, y: -160)
        
        highlightMask1.position = smallTouchableBox1.position
        highlightMask2.position = smallTouchableBox2.position
        
        highlightMask1.alpha = 0
        highlightMask2.alpha = 0
        
        smallTouchableBox1.zPosition = 6
        smallTouchableBox2.zPosition = 6
        
        highlightMask1.zPosition = 8
        highlightMask2.zPosition = 8
        
        smallTouchableBox1.name = "smallTouchableBox1"
        smallTouchableBox2.name = "smallTouchableBox2"
        
        highlightMask1.name = "highlightMask1"
        highlightMask2.name = "highlightMask2"
        
        self.addChild(smallTouchableBox1)
        self.addChild(smallTouchableBox2)
        
        self.addChild(highlightMask1)
        self.addChild(highlightMask2)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if isGameOver {
                SKSceneAlertManager.instance.gameHasOver(scene: self)
                return
            }
            let location = touch.location(in: self)
            if let nodeName = atPoint(location).name, nodeName.starts(with: "smallTouchableBox") || nodeName.starts(with: "highlightMask"){
                let node = atPoint(location)
                let highlightMask = self.childNode(withName: ("highlightMask" + String((node.name)!.last!)))
                highlightMask?.run(highlightMaskAnimation)
                
                let nString = String((node.name)!.last!)
                let buttonNum = UInt(nString)!
                
                userHasClickedThisRound = true
                
                gameplayButtonCheck(chosenButtonNum: buttonNum)
            }
        }
    }
    
    
}
