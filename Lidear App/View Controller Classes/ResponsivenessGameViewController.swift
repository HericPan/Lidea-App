//
//  ResponsivenessGameViewController.swift
//  Lidear App
//
//  Created by 潘若淮 on 2022/3/22.
//

import UIKit
import SpriteKit
import GameplayKit

class ResponsivenessGameViewController: UIViewController {
    override func viewDidLoad() {
            super.viewDidLoad()
            
            if let scene = GKScene(fileNamed: "ResponsivenessGameScene") {

               // Get the SKScene from the loaded GKScene
               if let sceneNode = scene.rootNode as! ResponsivenessGameScene? {

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
