//
//  ViewController.swift
//  Blurra
//
//  Created by Makwan BK on 2021-02-02.
//

import UIKit

class ViewController: UIViewController {
    
    var movableView : UIView!
    let panGestureRecognizer = UIPanGestureRecognizer()
    
    var blurView = UIBlurEffect()
    var blurEffect = UIVisualEffectView()
    
    var segmentController = UISegmentedControl()
    let segmentItems = ["Light", "Extra Light", "Regular", "Dark", "Prominent"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainConfiguration()
        
    }
    
    func mainConfiguration() {
        
        //set the background image
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "bc")!
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        view.insertSubview(backgroundImage, at: 0)
        
        //the movable view
        movableView = UIView()
        movableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 200, height: UIScreen.main.bounds.height / 3)
        movableView.center = view.center
        movableView.isUserInteractionEnabled = true
        movableView.backgroundColor = .clear
        movableView.layer.masksToBounds = true
        movableView.layer.cornerRadius = 25
        
        view.addSubview(movableView)
        
        //add a blur effect to the movable view.
        blurView = UIBlurEffect(style: .regular)
        
        blurEffect = UIVisualEffectView(effect: blurView)
        blurEffect.frame = movableView.bounds
        blurEffect.isUserInteractionEnabled = true
        blurEffect.addGestureRecognizer(panGestureRecognizer)
        
        //insert the blur effert as subview to movable view.
        movableView.insertSubview(blurEffect, at: 0)
        
        //add target to PanGestureRecognizer
        panGestureRecognizer.addTarget(self, action: #selector(panTapped))
        
        //add segment controller:
        segmentController = UISegmentedControl(items: segmentItems)
        segmentController.selectedSegmentIndex = 2
        segmentController.backgroundColor = .systemGray
        segmentController.frame = CGRect(x: 0, y: 0, width: 250, height: 20)
        segmentController.apportionsSegmentWidthsByContent = true
        segmentController.addTarget(self, action: #selector(segmentTapped), for: .allEvents)
        
        view.addSubview(segmentController)
        
        //set segmentController/views constrains
        segmentController.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            segmentController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentController.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentController.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        
    }
    
    @objc func panTapped(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        movableView.center = CGPoint(x: movableView.center.x + translation.x, y: movableView.center.y + translation.y)
        
        sender.setTranslation(.zero, in: view)
        
        
    }

    @objc func segmentTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            blurView = UIBlurEffect(style: .light)
        case 1:
            blurView = UIBlurEffect(style: .extraLight)
        case 2:
            blurView = UIBlurEffect(style: .regular)
        case 3:
            blurView = UIBlurEffect(style: .dark)
        case 4:
            blurView = UIBlurEffect(style: .prominent)
        default:
            break
        }
                
    
        DispatchQueue.main.async { [self] in
            blurEffect.removeFromSuperview()
            
            blurEffect = UIVisualEffectView(effect: blurView)
            blurEffect.frame = movableView.bounds
            blurEffect.isUserInteractionEnabled = true
            blurEffect.addGestureRecognizer(panGestureRecognizer)
            
            movableView.insertSubview(blurEffect, at: 0)
            
        }

        
    }

}

