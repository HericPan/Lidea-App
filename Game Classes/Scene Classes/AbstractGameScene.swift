//
//  AbstractGameScene.swift
//  Lidear App
//
//  Created by 潘若淮 on 2022/3/22.
//

import SpriteKit


class AbstractGameScene: SKScene {
    
    var nodeArray: [SKNode] = []
    
    var isGameEnded = 1 // if the counts less or equal than 0, the game finishes
    
    var currentSelectedNode: SKNode?
    var originalPositionOfCurrentSelectedNode: CGPoint?
    
    override func didMove(to view: SKView) {
        initializeVariables()
        randomizeThePositionOfSixBlocks()
    }
    
    func initializeVariables() {
        let rearWheels = self.childNode(withName: "Rear Wheels")
        let pedal = self.childNode(withName: "Pedal")
        let seatBack = self.childNode(withName: "Seat Back")
        let frontWheel = self.childNode(withName: "Front Wheel")
        let seatFront = self.childNode(withName: "Seat Front")
        let lights = self.childNode(withName: "Lights")
        
        
        
        nodeArray = [rearWheels!, pedal!, seatBack!, frontWheel!, seatFront!, lights!]
        isGameEnded = nodeArray.count
    }
    
    
    func randomizeThePositionOfSixBlocks() {
        
        
        let shuffleArray = nodeArray.map {$0.position}.shuffled()
        
        for i in 0..<nodeArray.count {
            nodeArray[i].position = shuffleArray[i]
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            guard isGameEnded > 0 else {
                SKSceneAlertManager.instance.gameHasOver(scene: self)
                return
            }
            let location = touch.location(in: self)
            
            if nodeArray.contains(atPoint(location)) {
                currentSelectedNode = atPoint(location)
                originalPositionOfCurrentSelectedNode = currentSelectedNode?.position
                currentSelectedNode?.position = location
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if (currentSelectedNode != nil){
                currentSelectedNode?.position = location
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {

            if currentSelectedNode != nil {
                let location = touch.location(in: self)
                let nodeUnderLocation = self.childNode(withName: "Abstract BG")?.atPoint(location)
                
                // if user did not drag the item to the designated location, place it back to the original location
                if nodeUnderLocation?.name == "Abstract BG" {
                    currentSelectedNode!.position = originalPositionOfCurrentSelectedNode!
                } else { // if user place in the designated location
                    // if user choose place the item to the right place
                    if nodeUnderLocation!.name!.starts(with: (currentSelectedNode?.name)!) {
                        isGameEnded -= 1
                        
                        currentSelectedNode?.run(SKAction.fadeOut(withDuration: TimeInterval(0.3)))
                        currentSelectedNode?.run(SKAction.scale(by: 2, duration: TimeInterval(0.3)))
                        
                        
                        // if the game is ended since all the item has been placed correctly, finish the game
                        if isGameEnded <= 0 {
                            SKSceneAlertManager.instance.gameSucceed(scene: self)
                        }
                    } else {
                        // if the user placed the item in a wrong location
                        // for now, this won't give rise to game over
                        currentSelectedNode!.position = originalPositionOfCurrentSelectedNode!
                        // isGameEnded = 0
                        // SKSceneAlertManager.instance.gameOver(scene: self)
                    }
                }
                
            }
            
            
            currentSelectedNode = nil
        }
    }
}
