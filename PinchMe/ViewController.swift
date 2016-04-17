//
//  ViewController.swift
//  PinchMe
//
//  Created by Steve D'Amico on 4/16/16.
//  Copyright © 2016 Steve D'Amico. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    /* Define four instance variables for the current and previous scale and rotation - UIPinchGestureRecognizer and UIRotationGestureRecognizer will always start at positions odf scale 1.0  scale and 0.0 rotation */
    private var imageView:UIImageView!
    private var scale = CGFloat(1)
    private var previousScale = CGFloat(1)
    private var rotation = CGFloat(0)
    private var previousRotation = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* UIImageView to pinch and rotate, load image, and center image - enable UIImageView which is one of the few UIKit classes tha has user interaction disabled by default */
        let image = UIImage(named: "yosemite-meadows")
        imageView = UIImageView(image: image)
        imageView.userInteractionEnabled = true
        imageView.center = view.center
        view.addSubview(imageView)
        
        /* Sets up pinch and rotation gesture recognizers - tell them to notify when gesture recognized */
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "doPinch:")
        pinchGesture.delegate = self
        imageView.addGestureRecognizer(pinchGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: "doRotate:")
        rotationGesture.delegate = self
        imageView.addGestureRecognizer(rotationGesture)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    /* Helper method for transforming image view according to current scaling and rotation */
    func transformImageView() {
        var t = CGAffineTransformMakeScale(scale * previousScale, scale * previousScale)
        t = CGAffineTransformRotate(t, rotation + previousRotation)
        imageView.transform = t
    }
    
    /* Action methods that take input and update transformation of the imageView */
    func doPinch(gesture:UIPinchGestureRecognizer) {
        scale = gesture.scale
        transformImageView()
        if gesture.state == .Ended {
            previousScale = scale * previousScale
            scale = 1
        }
    }
    
    func doRotate(gesture:UIRotationGestureRecognizer) {
        rotation = gesture.rotation
        transformImageView()
        if gesture.state == .Ended {
            previousRotation = rotation + previousRotation
            rotation = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

