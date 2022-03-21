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
    
    
    @IBAction func touchOnMemoryGameButton(_ sender: Any) {
        self.performSegue(withIdentifier: "ToMemoryGameSegue", sender: self)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
}
