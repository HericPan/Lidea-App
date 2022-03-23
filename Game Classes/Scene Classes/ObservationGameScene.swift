//
//  ObservationGameScene.swift
//  Lidear App
//
//  Created by 潘若淮 on 2022/3/22.
//

import SpriteKit


struct observationBoxConfig {
    
    static let width: CGFloat = 161
    static let cornerRadius: CGFloat = 31
    static let color: UIColor = UIColor(red: 239/255, green: 156/255, blue: 72/255, alpha: 1)
    static let strokeColor: UIColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
    static let appleImage = "apple top@3x.png"
    static let bananaImage = "banana top@3x.png"
    static let leaveImage = "Leaves top@3x.png"
    static let questionMarkImage = "question@3x.png"
}

struct observationBoxPositions {
    static let p1 = CGPoint(x: -350, y: 157.5)
    static let p2 = CGPoint(x: 0, y: 157.5)
    static let p3 = CGPoint(x: 350, y: 157.5)
    
    static let p4 = CGPoint(x: -350, y: -20)
    static let p5 = CGPoint(x: 0, y: -20)
    static let p6 = CGPoint(x: 350, y: -20)
    
    static let p7 = CGPoint(x: -350, y: -197.5)
    static let p8 = CGPoint(x: 0, y: -197.5)
    static let p9 = CGPoint(x: 350, y: -197.5)
}

class ObservationGameScene: SKScene {
    
    var fruitImageList: [String] = [observationBoxConfig.appleImage, observationBoxConfig.bananaImage, observationBoxConfig.leaveImage].shuffled()
    
    var rotationArray: [CGFloat] = [0*CGFloat.pi/180, 90*CGFloat.pi/180, 180*CGFloat.pi/180, 270*CGFloat.pi/180].shuffled()
    
    var chosenRotation: CGFloat = 0
    
    var answerNum: Int?
    
    var isGameEnded: Bool = false
    
    let highlightMaskAnimation = SKAction.sequence([SKAction.fadeAlpha(to: 0.6, duration: TimeInterval(0.1)), SKAction.fadeAlpha(to: 0.001, duration: TimeInterval(0.1))])

    override func didMove(to view: SKView) {
        
        initializeVariables()
       
    }
    
    
    private func initializeVariables() {
        randomizedRotation()
        generateBackgroundPlate()
        generateLeftSideThreeRows()
        generateMiddleThreeRows()
        generateVerticleLineOnTheRight()
        generateRightSideThreeRows()
        generateNumberedIcons()
        
    }
    
    
    private func randomizedRotation() {
        self.chosenRotation = rotationArray.removeFirst()
    }
    
    private func generateHorizontalLineNode(length: CGFloat) -> SKShapeNode {
        var linePoints = [CGPoint(x: -length/2, y: 0), CGPoint(x: length/2, y: 0)]
        let linePointsPointer = UnsafeMutablePointer<CGPoint>.allocate(capacity: 2)
        linePointsPointer.initialize(from: &linePoints, count: 2)
        let line = SKShapeNode(points: linePointsPointer, count: 2)
        linePointsPointer.deallocate()
        line.strokeColor = .black
        return line
    }
    
    private func generateVerticalLineNode(length: CGFloat) -> SKShapeNode {
        var linePoints = [CGPoint(x: 0, y: -length/2), CGPoint(x: 0, y: length/2)]
        let linePointsPointer = UnsafeMutablePointer<CGPoint>.allocate(capacity: 2)
        linePointsPointer.initialize(from: &linePoints, count: 2)
        let line = SKShapeNode(points: linePointsPointer, count: 2)
        linePointsPointer.deallocate()
        return line
    }

    
    private func generateLeftSideThreeRows() {
        
        let leftBox1 = generateSquare(width: observationBoxConfig.width, color: observationBoxConfig.color, cornerRadius: observationBoxConfig.cornerRadius)
        let leftBox2 = generateSquare(width: observationBoxConfig.width, color: observationBoxConfig.color, cornerRadius: observationBoxConfig.cornerRadius)
        let leftBox3 = generateSquare(width: observationBoxConfig.width, color: observationBoxConfig.color, cornerRadius: observationBoxConfig.cornerRadius)
        
        leftBox1.zPosition = 3
        leftBox2.zPosition = 3
        leftBox3.zPosition = 3
        
        leftBox1.name = "leftBox1"
        leftBox2.name = "leftBox2"
        leftBox3.name = "leftBox3"
        
        leftBox1.lineWidth = 5
        leftBox2.lineWidth = 5
        leftBox3.lineWidth = 5
        
        leftBox1.position = observationBoxPositions.p1
        leftBox2.position = observationBoxPositions.p4
        leftBox3.position = observationBoxPositions.p7
        
        let fruit1 = SKSpriteNode(imageNamed: fruitImageList[0])
        let fruit2 = SKSpriteNode(imageNamed: fruitImageList[1])
        let fruit3 = SKSpriteNode(imageNamed: fruitImageList[2])
        
        fruit1.setScale(2.5)
        fruit2.setScale(2.5)
        fruit3.setScale(2.5)
        
        fruit1.zPosition = 1
        fruit2.zPosition = 1
        fruit3.zPosition = 1
        
        leftBox1.addChild(fruit1)
        leftBox2.addChild(fruit2)
        leftBox3.addChild(fruit3)
        
        self.addChild(leftBox1)
        self.addChild(leftBox2)
        self.addChild(leftBox3)
        
        let leftLine1 = generateHorizontalLineNode(length: 166)
        let leftLine2 = generateHorizontalLineNode(length: 166)
        let leftLine3 = generateHorizontalLineNode(length: 166)
        
        leftLine1.zPosition = 5
        leftLine2.zPosition = 5
        leftLine3.zPosition = 5
        
        leftLine1.strokeColor = .gray
        leftLine2.strokeColor = .gray
        leftLine3.strokeColor = .gray
        
        
        leftLine1.lineWidth = 3
        leftLine2.lineWidth = 3
        leftLine3.lineWidth = 3
        
        
        leftLine1.position = CGPoint(x: (observationBoxPositions.p1.x + observationBoxPositions.p2.x) / 2, y: observationBoxPositions.p1.y)
        leftLine2.position = CGPoint(x: (observationBoxPositions.p4.x + observationBoxPositions.p5.x) / 2, y: observationBoxPositions.p4.y)
        leftLine3.position = CGPoint(x: (observationBoxPositions.p7.x + observationBoxPositions.p8.x) / 2, y: observationBoxPositions.p7.y)
        
        self.addChild(leftLine1)
        self.addChild(leftLine2)
        self.addChild(leftLine3)
        
        
    }
    
    
    private func generateMiddleThreeRows() {
        
        let middleBox1 = generateSquareStroke(width: observationBoxConfig.width, color: observationBoxConfig.strokeColor, cornerRadius: observationBoxConfig.cornerRadius)
        let middleBox2 = generateSquareStroke(width: observationBoxConfig.width, color: observationBoxConfig.strokeColor, cornerRadius: observationBoxConfig.cornerRadius)
        let middleBox3 = generateSquareStroke(width: observationBoxConfig.width, color: observationBoxConfig.strokeColor, cornerRadius: observationBoxConfig.cornerRadius)
        
        middleBox1.zPosition = 5
        middleBox2.zPosition = 5
        middleBox3.zPosition = 5
        
        middleBox1.name = "middleBox1"
        middleBox2.name = "middleBox2"
        middleBox3.name = "middleBox3"
        
        middleBox1.lineWidth = 5
        middleBox2.lineWidth = 5
        middleBox3.lineWidth = 5
        
        middleBox1.position = observationBoxPositions.p2
        middleBox2.position = observationBoxPositions.p5
        middleBox3.position = observationBoxPositions.p8
        
        let fruit1 = SKSpriteNode(imageNamed: fruitImageList[0])
        let fruit2 = SKSpriteNode(imageNamed: fruitImageList[1])
        let fruit3 = SKSpriteNode(imageNamed: observationBoxConfig.questionMarkImage)
        
        fruit1.zPosition = 1
        fruit2.zPosition = 1
        fruit3.zPosition = 1
        
        fruit3.position = CGPoint(x: 25, y: 0)
        
        fruit1.setScale(2.5)
        fruit2.setScale(2.5)
        fruit3.setScale(2.5)
        
        fruit1.zRotation = chosenRotation
        fruit2.zRotation = chosenRotation
        
        middleBox1.addChild(fruit1)
        middleBox2.addChild(fruit2)
        middleBox3.addChild(fruit3)
        
        self.addChild(middleBox1)
        self.addChild(middleBox2)
        self.addChild(middleBox3)

        
    }
    
    
    private func generateVerticleLineOnTheRight() {
        
        let verticleLine = generateVerticalLineNode(length: 500)
        verticleLine.lineWidth = 2
        verticleLine.strokeColor = .gray
        verticleLine.position = CGPoint(x: (observationBoxPositions.p5.x + observationBoxPositions.p6.x) / 2, y: observationBoxPositions.p5.y)
        verticleLine.zPosition = 5
        self.addChild(verticleLine)
        
    }
    
    
    private func generateRightSideThreeRows() {
        
        let rightBox1 = generateSquare(width: observationBoxConfig.width, color: .white, cornerRadius: observationBoxConfig.cornerRadius)
        let rightBox2 = generateSquare(width: observationBoxConfig.width, color: .white, cornerRadius: observationBoxConfig.cornerRadius)
        let rightBox3 = generateSquare(width: observationBoxConfig.width, color: .white, cornerRadius: observationBoxConfig.cornerRadius)
        
        rightBox1.zPosition = 5
        rightBox2.zPosition = 5
        rightBox3.zPosition = 5
        
        rightBox1.name = "rightBox1"
        rightBox2.name = "rightBox2"
        rightBox3.name = "rightBox3"
        
        rightBox1.position = observationBoxPositions.p3
        rightBox2.position = observationBoxPositions.p6
        rightBox3.position = observationBoxPositions.p9
        
        let fruit1 = SKSpriteNode(imageNamed: fruitImageList[2])
        let fruit2 = SKSpriteNode(imageNamed: fruitImageList[2])
        let fruit3 = SKSpriteNode(imageNamed: fruitImageList[2])
        
        fruit1.setScale(2.5)
        fruit2.setScale(2.5)
        fruit3.setScale(2.5)
        
        fruit1.zPosition = 1
        fruit2.zPosition = 1
        fruit3.zPosition = 1
        
        var threeRotationArray = [chosenRotation]
        threeRotationArray.append(rotationArray.removeFirst())
        threeRotationArray.append(rotationArray.removeFirst())
        threeRotationArray.shuffle()
        
        self.answerNum = threeRotationArray.firstIndex(of: chosenRotation)! + 1
        
        fruit1.zRotation = threeRotationArray[0]
        fruit2.zRotation = threeRotationArray[1]
        fruit3.zRotation = threeRotationArray[2]
        
        rightBox1.addChild(fruit1)
        rightBox2.addChild(fruit2)
        rightBox3.addChild(fruit3)
        
        self.addChild(rightBox1)
        self.addChild(rightBox2)
        self.addChild(rightBox3)
        
        
        
    }
    
    func generateNumberedIcons() {
        let circle1 = generateCircle(radius: 25, strokeColor: .gray)
        let circle2 = generateCircle(radius: 25, strokeColor: .gray)
        let circle3 = generateCircle(radius: 25, strokeColor: .gray)
        
        circle1.zPosition = 5
        circle2.zPosition = 5
        circle3.zPosition = 5
        
        let numLabel1 = SKLabelNode(fontNamed: "SF Pro")
        let numLabel2 = SKLabelNode(fontNamed: "SF Pro")
        let numLabel3 = SKLabelNode(fontNamed: "SF Pro")
        
        numLabel1.fontColor = .black
        numLabel2.fontColor = .black
        numLabel3.fontColor = .black
        
        numLabel1.fontSize = 28
        numLabel2.fontSize = 28
        numLabel3.fontSize = 28
        
        numLabel1.text = "1"
        numLabel2.text = "2"
        numLabel3.text = "3"
        
        numLabel1.zPosition = 1
        numLabel2.zPosition = 1
        numLabel3.zPosition = 1
        
        numLabel1.position = CGPoint(x: 0, y: -10)
        numLabel2.position = CGPoint(x: 0, y: -10)
        numLabel3.position = CGPoint(x: 0, y: -10)
        
        circle1.addChild(numLabel1)
        circle2.addChild(numLabel2)
        circle3.addChild(numLabel3)
        
        self.addChild(circle1)
        self.addChild(circle2)
        self.addChild(circle3)
        
        circle1.position = CGPoint(x: 260, y: 210)
        circle2.position = CGPoint(x: 260, y: 32.5)
        circle3.position = CGPoint(x: 260, y: -145)
    }
    
    
    private func generateCircle(radius: CGFloat, strokeColor: UIColor) -> SKShapeNode {
        let circleNode = SKShapeNode(circleOfRadius: radius)
        circleNode.strokeColor = strokeColor
        return circleNode
    }
    
    
    private func generateSquare(width: CGFloat, color: UIColor, cornerRadius: CGFloat) -> SKShapeNode {
        let rectangle = CGRect(origin: CGPoint(x: -width/2, y: -width/2), size: CGSize(width: width, height: width))
        let roundedSKNode = SKShapeNode(rect: rectangle, cornerRadius: cornerRadius)
        roundedSKNode.fillColor = color
        roundedSKNode.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

        return roundedSKNode
    }
    
    
    private func generateSquareStroke(width: CGFloat, color: UIColor, cornerRadius: CGFloat) -> SKShapeNode {
        let rectangle = CGRect(origin: CGPoint(x: -width/2, y: -width/2), size: CGSize(width: width, height: width))
        let roundedSKNode = SKShapeNode(rect: rectangle, cornerRadius: cornerRadius)
        roundedSKNode.fillColor = .clear
        roundedSKNode.strokeColor = color

        return roundedSKNode
    }
    
    
    private func generateBackgroundPlate() {
        let bgPlate = SKShapeNode(rect: CGRect(origin: CGPoint(x: -900/2, y: -555/2), size: CGSize(width: 900, height: 550)), cornerRadius: 65)
        bgPlate.fillColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
        bgPlate.zPosition = 1
        bgPlate.position = CGPoint(x: 0, y: -20)
        self.addChild(bgPlate)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            guard !isGameEnded else {
                SKSceneAlertManager.instance.gameHasOver(scene: self)
                return
            }
            let location = touch.location(in: self)
            if let nodeName = atPoint(location).name, nodeName.starts(with: "whiteMask") {
                let currentWhiteMask = atPoint(location)
                currentWhiteMask.run(highlightMaskAnimation)
                
                // if user's answer matches the real answer, the user wins. otherwise the user loses
                if let userAnswer = Int(String(nodeName.last!)), userAnswer == answerNum {
                    self.isGameEnded = true
                    SKSceneAlertManager.instance.gameSucceed(scene: self)
                } else {
                    self.isGameEnded = true
                    SKSceneAlertManager.instance.gameOver(scene: self)
                }
            }
        }
    }
    
}
