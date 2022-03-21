//
//  MemoryGameScene.swift
//  Lidear App
//
//  Created by 潘若淮 on 2022/3/20.
//

import SpriteKit


private struct boxConfig {
    static let width: CGFloat = 161
    static let cornerRadius: CGFloat = 31
    static let coverColor = UIColor(red: 239/255, green: 156/255, blue: 72/255, alpha: 1)
    static let targetColor = UIColor(red: 252/255, green: 218/255, blue: 134/255, alpha: 1)
}


/**
    记忆力训练游戏场景 MemoryGameScene Class
 */
class MemoryGameScene: SKScene {
    
    var boxArray = ["box1", "box2", "box3", "box4", "box5", "box6"]
    var answerBoxArray: [String] = []
    let fadeOutThenFadeInAction = SKAction.sequence([SKAction.fadeOut(withDuration: TimeInterval(0.2)), SKAction.fadeAlpha(by: 1, duration: TimeInterval(0.2))])
    
    /**
        Generate a square SKShapeNode with a sets of parameters. The anchor point of the square generated is CGPoint(x: 0, y: 0), namely the center of the SKShapeNode.
     
        - Parameter width: The width and height of the square
     
        - Parameter color: The color of the SKShapeNode
        
        - Parameter cornerRadius: The corner radius of the square shape
     
        - Returns: An square SKShapeNode with parameters specified
     */
    private func generateSquare(width: CGFloat, color: UIColor, cornerRadius: CGFloat) -> SKShapeNode {
        let rectangle = CGRect(origin: CGPoint(x: -width/2, y: -width/2), size: CGSize(width: width, height: width))
        let roundedSKNode = SKShapeNode(rect: rectangle, cornerRadius: cornerRadius)
        roundedSKNode.fillColor = color
        roundedSKNode.strokeColor = color

        return roundedSKNode
    }
    
    
    
    override func didMove(to view: SKView) {
        
        
//        let b = SKCropNode()
//
//        b.zPosition = 3
//        let boxColor = UIColor(red: 239/255, green: 156/255, blue: 72/255, alpha: 1)
//        let boxWidth: CGFloat = 161
//        let a = SKSpriteNode(color: boxColor, size: CGSize(width: 161, height: 161))
//        let boxCornerRadius: CGFloat = 31
//        let box1 = generateSquare(width: boxWidth, color: boxColor, cornerRadius: boxCornerRadius)
//        b.maskNode = box1
//        b.addChild(a)
//        self.addChild(b)
        initializeVariables()
        demonstrateTheBoxOrder()
        
    }
    
    
    /**
        Initialize the elements in MemoryGameScene
     */
    private func initializeVariables() {
        
        placeSixSquares()
        randomizeBoxArray()
        
        
    }
    
    /**
        Place all six squares of the game
     */
    private func placeSixSquares() {
        
        // TODO: 1. Change of memory game difficulty by adding more boxes to the game
        
        struct SquarePositions {
            let squarePos1 = CGPoint(x: -290, y: 98)
            let squarePos2 = CGPoint(x: 0, y: 98)
            let squarePos3 = CGPoint(x: 290, y: 98)
            
            let squarePos4 = CGPoint(x: -290, y: -124)
            let squarePos5 = CGPoint(x: 0, y: -124)
            let squarePos6 = CGPoint(x: 290, y: -124)
        }
        
        let sp = SquarePositions()
        
        let boxColor = boxConfig.coverColor
        let boxWidth: CGFloat = boxConfig.width
        let boxCornerRadius: CGFloat = boxConfig.cornerRadius
        
        let box1 = generateSquare(width: boxWidth, color: boxColor, cornerRadius: boxCornerRadius)
        let box2 = generateSquare(width: boxWidth, color: boxColor, cornerRadius: boxCornerRadius)
        let box3 = generateSquare(width: boxWidth, color: boxColor, cornerRadius: boxCornerRadius)
        let box4 = generateSquare(width: boxWidth, color: boxColor, cornerRadius: boxCornerRadius)
        let box5 = generateSquare(width: boxWidth, color: boxColor, cornerRadius: boxCornerRadius)
        let box6 = generateSquare(width: boxWidth, color: boxColor, cornerRadius: boxCornerRadius)
        
        box1.position = sp.squarePos1
        box2.position = sp.squarePos2
        box3.position = sp.squarePos3
        box4.position = sp.squarePos4
        box5.position = sp.squarePos5
        box6.position = sp.squarePos6
        
        box1.zPosition = 5
        box2.zPosition = 5
        box3.zPosition = 5
        box4.zPosition = 5
        box5.zPosition = 5
        box6.zPosition = 5
        
        box1.name = "box1"
        box2.name = "box2"
        box3.name = "box3"
        box4.name = "box4"
        box5.name = "box5"
        box6.name = "box6"
        
        self.addChild(box1)
        self.addChild(box2)
        self.addChild(box3)
        self.addChild(box4)
        self.addChild(box5)
        self.addChild(box6)
    }
    
    private func randomizeBoxArray() {
        answerBoxArray = boxArray.shuffled()
        
        // prevent the answer box array becoming too retarted :)
        while answerBoxArray.elementsEqual(boxArray) || answerBoxArray.elementsEqual(boxArray.reversed()) {
            answerBoxArray.shuffle()
        }
        
    }
    
    private func generateTargetBox(withAnimalImageNamed animalImageName: String, scale: CGFloat) -> SKShapeNode {
        // create the animal+yellow box or so-called target box for to be shown
        let targetBox = generateSquare(width: boxConfig.width, color: boxConfig.targetColor, cornerRadius: boxConfig.cornerRadius)
        let animalNode = SKSpriteNode(imageNamed: animalImageName)
        targetBox.zPosition = 3
        animalNode.setScale(scale)
        // animalNode is positioned on the targetBox, which adds up animalNodes's zPositon to 3 + 1 = 4
        animalNode.zPosition = 1 // relatively higher than targetBox, which is 4
        targetBox.addChild(animalNode) // targetBox now has the animal image on top
        
        return targetBox
    }
    
    // show the order of the boxes for the gamer
    private func demonstrateTheBoxOrder() {
        self.isUserInteractionEnabled = false
        
        
        // this actionInterval is to delay each box's animation, making them play SKAction one by one
        var  actionInterval: Double = 1
        for boxName in answerBoxArray {
            
            
            // the demonstration animation on each box will be 2 seconds, 1s for fading out, 1s for fading in
            // TODO: 2. Change of memory game difficulty by shortening the animation time
            let demonstrateFadingIOAnimation = SKAction.sequence([SKAction.fadeOut(withDuration: TimeInterval(1)), SKAction.fadeAlpha(by: 1, duration: TimeInterval(1))])
            
            // create the animal+yellow box or so-called target box for to be shown
            let targetBox = generateTargetBox(withAnimalImageNamed: "Owl@3x.png", scale: 2.5)
            
            let currentBox = self.childNode(withName: boxName)
            let currentPosition = currentBox!.position
            targetBox.position = currentPosition

            // add the targetBox to the scene and play the animation
            Timer.scheduledTimer(withTimeInterval: TimeInterval(actionInterval), repeats: false) { Timer in
                self.addChild(targetBox)
                currentBox?.run(demonstrateFadingIOAnimation)
            }
            Timer.scheduledTimer(withTimeInterval: TimeInterval(actionInterval+2.1), repeats: false) { Timer in
                targetBox.removeFromParent()
            }
            
            // delay the next animation by 3s, since every box's animation is 2s (remaining 1s for interval)
            actionInterval += 3
            
            
        }
        
        // after all animations complete, the user can touch on the boxes to start the game
        Timer.scheduledTimer(withTimeInterval: TimeInterval(actionInterval), repeats: false) { Timer in
            self.isUserInteractionEnabled = true
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            // if user touches any box
            if let nodeName = atPoint(location).name, nodeName.starts(with: "box") {
                guard !answerBoxArray.isEmpty else {
                    let alert = UIAlertController(title: "游戏已经结束", message: "游戏已经结束了，请返回上级菜单", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "彳亍", style: .default)
                    alert.addAction(defaultAction)
                    self.view?.window?.rootViewController?.present(alert, animated: true)
                    return
                }
                
                // check if the box is the right box
                let currentBox = answerBoxArray.remove(at: 0)
                
                
                
                // the user has chosen the right answer
                if currentBox == nodeName {
                    let touchedBox = atPoint(location) as! SKShapeNode
                    let currentTargetBox = self.generateTargetBox(withAnimalImageNamed: "Owl@3x.png", scale: 2.5)
                    currentTargetBox.position = self.childNode(withName: currentBox)!.position
                    self.addChild(currentTargetBox)
                    
                    touchedBox.run(SKAction.fadeOut(withDuration: TimeInterval(0.2)))
                    Timer.scheduledTimer(withTimeInterval: TimeInterval(0.3), repeats: false) { Timer in
                        touchedBox.removeFromParent()
                        if self.answerBoxArray.isEmpty {
                            let alert = UIAlertController(title: "Success", message: "你赢了！你真是小天才（笑", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "好耶", style: .default)
                            alert.addAction(defaultAction)
                            self.view?.window?.rootViewController?.present(alert, animated: true)
                        }
                    }
                    
                    
                } else {
                    let alert = UIAlertController(title: "Game Over", message: "你选错了，游戏结束", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "彳亍", style: .default)
                    alert.addAction(defaultAction)
                    self.view?.window?.rootViewController?.present(alert, animated: true)
                    answerBoxArray.removeAll()
                }
                
            }
        }
    }
    
    
    
}
