//
//  GameScene.swift
//  TaskGame
//
//  Created by Oleksandr Smakhtin on 14/11/2023.
//

import Foundation
import SpriteKit
import CoreMotion

protocol GameDelegate: AnyObject {
    func didLose()
}

class GameScene: SKScene {
    
    //MARK: - Delegate
    weak var gameDelegate: GameDelegate?
    
    //MARK: - Nodes
    private var ballNode: SKSpriteNode!
    private var motionManager: CMMotionManager!
    
    //MARK: - Prop
    private var isObstacleOnLeft = false
    
    //MARK: - didMove
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        // bg
        backgroundColor = .white
        // gravity
        physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        // nodes
        createBall()
        createObstacles()
        // motion
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        // delegates
        applyPhysicsDelegate()
    }
    
    //MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        limitBorder()
        accelUpdate()
    }
    
    //MARK: - Create ball
    private func createBall() {
        let ballRadius: CGFloat = 20.0
        ballNode = SKSpriteNode(imageNamed: "ball1")
        ballNode.name = "ball"
        ballNode.xScale = 0.5
        ballNode.yScale = 0.5
        ballNode.position = CGPoint(x: size.width/2, y: size.height/2 - 50)
        ballNode.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ballNode.physicsBody?.isDynamic = true
        ballNode.physicsBody?.categoryBitMask = 0
        ballNode.physicsBody?.contactTestBitMask = 1
        addChild(ballNode)
        // animation
        let textures: [SKTexture] = K.ballAnimations.map { title in
            return SKTexture(imageNamed: title)
        }
        let ballAnimation = SKAction.animate(with: textures, timePerFrame: 3)
        ballNode.run(SKAction.repeatForever(ballAnimation))
    }
    
    //MARK: - Obstacles
    func createObstacles() {
        let createAction = SKAction.sequence([SKAction.run(createObstacle), SKAction.wait(forDuration: 0.62)])
        run(SKAction.repeatForever(createAction))
    }
    
    //MARK: - Obstacle
    func createObstacle() {
        let obstacleWidth: CGFloat = CGFloat.random(in: 150...250)
        let obstacleHeight: CGFloat = 6.0
        let leftSpawnX: CGFloat = obstacleWidth/2 + CGFloat.random(in: 0...100)
        let rightSpawnX = frame.width - obstacleWidth/2 - CGFloat.random(in: 0...100)
        let deadlyObstacle = Int.random(in: 1...10)
        
        let obstacle = SKSpriteNode(color: SKColor.black, size: CGSize(width: obstacleWidth, height: obstacleHeight))
        
        // red obstacle check
        if deadlyObstacle == 1 {
            obstacle.name = "loseObstacle"
            obstacle.color = .red
            obstacle.size.width = CGFloat.random(in: 50...100)
        }
        
        // position side
        isObstacleOnLeft.toggle()
        if isObstacleOnLeft {
            obstacle.position = CGPoint(x: leftSpawnX, y: 0)
        } else {
            obstacle.position = CGPoint(x: rightSpawnX, y: 0)
        }
        //phy
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.isDynamic = false
        obstacle.physicsBody?.categoryBitMask = 1
        obstacle.physicsBody?.contactTestBitMask = 0
        
        // x moving
        let randomXVelocity = CGFloat.random(in: -70.0...70.0)
        obstacle.physicsBody?.velocity = CGVector(dx: randomXVelocity, dy: 50.0)
        
        addChild(obstacle)
        // actions
        let moveAction = SKAction.moveTo(y: size.height - 100, duration: 10.0)
        let removeAction = SKAction.removeFromParent()
        obstacle.run(SKAction.sequence([moveAction, removeAction]))
    }
    
    //MARK: - Accelerometr update
    private func accelUpdate() {
        guard let accelerometerData = motionManager.accelerometerData else { return }
        physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 10, dy: -5)
    }
    
    //MARK: - Limit border
    private func limitBorder() {
        // left
        if ballNode.position.x <= ballNode.frame.width / 2 {
            ballNode.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 0))
        }
        // right
        if ballNode.position.x >= size.width - ballNode.frame.width / 2 {
            ballNode.physicsBody?.applyImpulse(CGVector(dx: -3, dy: 0))
        }
        // bottom
        if ballNode.position.y <= ballNode.frame.height / 2 {
            ballNode.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
        }
        // top
        if ballNode.position.y >= size.height - ballNode.frame.height / 2 - 80 {
            gameDelegate?.didLose()
        }
    }
}

//MARK: - SKPhysicsContactDelegate
extension GameScene: SKPhysicsContactDelegate {
    // apply physics delegate
    private func applyPhysicsDelegate() {
        physicsWorld.contactDelegate = self
    }
    // did begin
    func didBegin(_ contact: SKPhysicsContact) {
        // check lose obstacle
        if (contact.bodyA.node?.name == "loseObstacle" || contact.bodyB.node?.name == "loseObstacle") && (contact.bodyA.node?.name == "ball" || contact.bodyB.node?.name == "ball") {
            gameDelegate?.didLose()
        }
    }
}
