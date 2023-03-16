//
//  ViewController.swift
//  SparrowMarathonTask6
//
//  Created by Dmitriy Shrayber on 16.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let box: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemBlue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureConstraints()
        self.title = "Task 6"
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveView(_:))))

    }
    
    private var dynamicAnimator: UIDynamicAnimator!
    private var snapBehavior: UISnapBehavior!
    
    private func setupViews() {
        self.view.addSubview(box)
        self.view.backgroundColor = .white
    }
    
    private func configureConstraints() {
        box.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            box.widthAnchor.constraint(equalToConstant: 100),
            box.heightAnchor.constraint(equalToConstant: 100),
            box.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            box.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.layoutIfNeeded()
        configureDynamics()
    }

    func configureDynamics() {
      dynamicAnimator = UIDynamicAnimator(referenceView: view)
      snapBehavior = UISnapBehavior(item: box, snapTo: view.center)
      dynamicAnimator.addBehavior(snapBehavior)
    }
    
    @objc
    func moveView(_ gestureRecogniser: UITapGestureRecognizer) {
        dynamicAnimator.removeBehavior(snapBehavior)
        let coordinates = gestureRecogniser.location(in: self.view)
        snapBehavior = UISnapBehavior(item: box, snapTo: coordinates)
        snapBehavior.damping = 2
        dynamicAnimator.addBehavior(snapBehavior)
        self.box.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
}
