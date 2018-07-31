//
//  GameViewController.swift
//  augmentedreality
//
//  Created by Andrew Carvajal on 7/30/18.
//  Copyright © 2018 Hoods. All rights reserved.
//

import ARKit
import LBTAComponents

class GameViewController: UIViewController {
    
    let arView: ARSCNView = {
        let view = ARSCNView()
        return view
    }()
    
    let plusButtonWidth = ScreenSize.width * 0.1
    lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(red: 230, green: 145, blue: 31)
        button.layer.cornerRadius = plusButtonWidth * 0.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handlePlusButtonTapped), for: .touchUpInside)
        button.layer.zPosition = 1
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    @objc func handlePlusButtonTapped() {
        addNode()
    }
    
    let minusButtonWidth = ScreenSize.width * 0.1
    lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "minus").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(red: 230, green: 145, blue: 31)
        button.layer.cornerRadius = minusButtonWidth * 0.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleMinusButtonTapped), for: .touchUpInside)
        button.layer.zPosition = 1
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    @objc func handleMinusButtonTapped() {
        removeAllBoxes()
    }
    
    let resetButtonWidth = ScreenSize.width * 0.1
    lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "reset").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(red: 230, green: 145, blue: 31)
        button.layer.cornerRadius = resetButtonWidth * 0.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleResetButtonTapped), for: .touchUpInside)
        button.layer.zPosition = 1
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    @objc func handleResetButtonTapped() {
        resetScene()
    }
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        arView.session.run(configuration, options: [])
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,
                               ARSCNDebugOptions.showWorldOrigin]
        arView.autoenablesDefaultLighting = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupViews() {
        view.addSubview(arView)
        arView.fillSuperview()
        
        view.addSubview(plusButton)
        plusButton.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 24, bottomConstant: 12, rightConstant: 0, widthConstant: plusButtonWidth, heightConstant: plusButtonWidth)
        
        view.addSubview(minusButton)
        minusButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 12, rightConstant: 24, widthConstant: minusButtonWidth, heightConstant: minusButtonWidth * 0.7)
        
        view.addSubview(resetButton)
        resetButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 12, rightConstant: 24, widthConstant: resetButtonWidth, heightConstant: resetButtonWidth)
        resetButton.anchorCenterXToSuperview()
    }
    
    func addNode() {
        let shapeNode = SCNNode()
//        shapeNode.geometry = SCNCone(topRadius: 0.05, bottomRadius: 0.1, height: 0.15)
//        boxNode.geometry = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.0002)
        shapeNode.geometry = SCNTorus(ringRadius: 0.1, pipeRadius: 0.02)
        shapeNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "wood")
        shapeNode.position = SCNVector3(0.0, 0.0, -0.3)
        shapeNode.name = "node"
        arView.scene.rootNode.addChildNode(shapeNode)
    }
    
    func removeAllBoxes() {
        arView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "node" {
                node.removeFromParentNode()
            }
        }
    }
    
    func resetScene() {
        arView.session.pause()
        arView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "node" {
                node.removeFromParentNode()
            }
        }
        arView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
}
