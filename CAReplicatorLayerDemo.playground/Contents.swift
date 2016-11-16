//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


PlaygroundPage.current.needsIndefiniteExecution

// we want to have 20 squares in a circle, their color should be a gradient between red and blue, there should be an animation from a full circle to a specific value (1/4 of a circle in this case) and the gradient should animate with it so that the last visible square will always be red and the first one should always be blue


var str = "Hello, playground"

let bounds = CGRect(x: 0.0, y: 0.0, width: 200, height: 200)

let view = UIView(frame: bounds)
view.backgroundColor = UIColor.white
let bg = CAReplicatorLayer()

let r = CAReplicatorLayer()
r.bounds = bounds
r.position = CGPoint(x: bounds.width/2, y: bounds.height/2)

view.layer.addSublayer(r)

var nrSquares = 20

let initialColor = UIColor(red: 190.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0).cgColor
let finalColor = UIColor(red: 248.0 / 255.0, green: 68.0 / 255.0, blue: 22.0 / 255.0, alpha: 1.0).cgColor

let square = CALayer()
square.bounds = CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0)
square.position = CGPoint(x: 100, y: 20)
square.backgroundColor = initialColor

r.addSublayer(square)

r.instanceCount = nrSquares
let angle = CGFloat(2*M_PI) / CGFloat(nrSquares)
r.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)

let duration: CFTimeInterval = 3.5




r.instanceDelay = duration/Double(nrSquares)


func animateBackgroundColor() {
    let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
    colorAnimation.fromValue = initialColor
    colorAnimation.toValue = finalColor
    colorAnimation.duration = duration
    square.add(colorAnimation, forKey: nil)
}


func setColorOffsets() {
    r.instanceRedOffset = (Float(finalColor.components![0] - initialColor.components![0])) / Float(nrSquares)
    r.instanceGreenOffset = (Float(finalColor.components![1] - initialColor.components![1])) / Float(nrSquares)
    r.instanceBlueOffset = (Float(finalColor.components![2] - initialColor.components![2])) / Float(nrSquares)
}




func animateColorOffsets() {
    let instanceRedOffsetAnimation = CABasicAnimation(keyPath: "instanceRedOffset")
    instanceRedOffsetAnimation.fromValue = (Float(initialColor.components![0] - finalColor.components![0])) / Float(r.instanceCount)
    instanceRedOffsetAnimation.toValue =  (Float(initialColor.components![0] - finalColor.components![0])) / Float(r.instanceCount)
    instanceRedOffsetAnimation.duration = duration
    r.add(instanceRedOffsetAnimation, forKey: "instanceRedOffsetAnimation")
}


func animateInstanceCount() {
    let instanceCountAnimation = CABasicAnimation(keyPath: "instanceCount")
    instanceCountAnimation.fromValue = nrSquares
    instanceCountAnimation.toValue = Int(0.25 * Double(nrSquares))
    instanceCountAnimation.duration = duration
    r.add(instanceCountAnimation, forKey: "asfd")

}



// Initially, with all function calls commented out, the squares all have the initial color

//animateBackgroundColor()
setColorOffsets()
animateColorOffsets()
animateInstanceCount()







PlaygroundPage.current.liveView = view