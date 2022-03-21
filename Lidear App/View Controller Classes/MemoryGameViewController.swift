//
//  MemoryGameViewController.swift
//  Lidear App
//
//  Created by 潘若淮 on 2022/3/21.
//

import UIKit
import SpriteKit
import GameplayKit

class MemoryGameViewController: UIViewController {
    
    override func viewDidLoad() {
            super.viewDidLoad()
            //         Load 'GameScene.sks' as a GKScene. This provides gameplay related content
            
//            self.view = SKView()
            if let scene = GKScene(fileNamed: "MemoryGameScene") {

               // Get the SKScene from the loaded GKScene
               if let sceneNode = scene.rootNode as! MemoryGameScene? {

                   // Copy gameplay related content over to the scene
            //                sceneNode.entities = scene.entities
            //                sceneNode.graphs = scene.graphs

                   // Set the scale mode to scale to fit the window
                   sceneNode.scaleMode = .aspectFill

                   // Present the scene
                   if let view = self.view as! SKView? {
                       view.presentScene(sceneNode)

                       view.ignoresSiblingOrder = true

                       view.showsFPS = true
                       view.showsNodeCount = true
                   }
               }
            }
    
    }
}
