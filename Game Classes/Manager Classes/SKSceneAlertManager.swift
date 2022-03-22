//
//  AlertManager.swift
//  Lidear App
//
//  Created by 潘若淮 on 2022/3/22.
//

import Foundation
import SpriteKit

class SKSceneAlertManager {
    static let instance = SKSceneAlertManager()
    
    func gameSucceed(scene: SKScene) {
        let alert = UIAlertController(title: "Success", message: "你赢了！你真是小天才（笑", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "好耶", style: .default)
        alert.addAction(defaultAction)
        scene.view?.window?.rootViewController?.present(alert, animated: true)
    }
    
    func gameOver(scene: SKScene) {
        let alert = UIAlertController(title: "Game Over", message: "你选错了，游戏结束", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "彳亍", style: .default)
        alert.addAction(defaultAction)
        scene.view?.window?.rootViewController?.present(alert, animated: true)
    }
    
    func gameHasOver(scene: SKScene) {
        let alert = UIAlertController(title: "游戏已经结束", message: "游戏已经结束了，请返回上级菜单", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "彳亍", style: .default)
        alert.addAction(defaultAction)
        scene.view?.window?.rootViewController?.present(alert, animated: true)
        
    }
}
