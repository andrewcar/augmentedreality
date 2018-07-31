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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let plusButtonWidth = ScreenSize.width * 0.1
    lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        print("tap")
        addBox()
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
    }
    
    func addBox() {
        let boxNode = SCNNode()
        boxNode.geometry = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.0002)
        boxNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "wood")
        boxNode.position = SCNVector3(0,0,-0.3)
        arView.scene.rootNode.addChildNode(boxNode)
    }
}
