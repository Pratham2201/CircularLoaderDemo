//
//  CircularLoaderView.swift
//  CircularLoaderDemo
//
//  Created by Pratham Gupta on 02/12/23.
//

import UIKit

protocol CircularLoaderViewDelegate {
    // function to draw object on the circumference of the loader
    func drawObject(circluarView: CircularLoaderView, index: Int, drawPoint: CGPoint)
}

class CircularLoaderView: UIView {

    // centre point of the circlar loader
    var circularProgressBarCentre: CGPoint?
    
    // radius of the circular loader
    var radius: CGFloat?
    
    //number of objects on the circumference of the circular loader
    var numberOfObjects: Int?
    
    //size of the object on the circumference of the circular loader
    var objectSize: CGFloat?
    
    // Angle in degrees between two objects in the circluar bar from the centre of the circle
    var arcRadian: CGFloat?
    
    var delegate: CircularLoaderViewDelegate?
    
    var percentageLayers: [CAShapeLayer] = []
    
    var completedPercentageIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(delegate: CircularLoaderViewDelegate,radius: CGFloat, numberOfObjects: Int, objectSize: CGFloat) {
        circularProgressBarCentre = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        self.radius = radius
        self.numberOfObjects = numberOfObjects
        self.objectSize = objectSize
        arcRadian = (2*CGFloat.pi)/CGFloat(numberOfObjects)
        self.delegate = delegate
        
        self.backgroundColor = .clear
        
        drawCircularProgressView()
        animateInfiniteCircularProgressView()
    }
    
    private func drawCircularProgressView() {
        for i in 0..<(numberOfObjects ?? 0) {
            if let radius = radius, let angle = arcRadian {
                let drawPoint = CGPoint(x: (circularProgressBarCentre?.x ?? 0) + radius*cos(angle*CGFloat(i)),
                                        y: (circularProgressBarCentre?.y ?? 0) + radius*sin(angle*CGFloat(i)))
                delegate?.drawObject(circluarView: self, index: i, drawPoint: drawPoint)
            }
        }
    }
    
    func animateInfiniteCircularProgressView(counter: Int = 0) {
        UIView.animate(withDuration: 0.0, delay: 0.034, animations: {[weak self] in
            self?.transform = CGAffineTransform(rotationAngle: (self?.arcRadian ?? 0)*CGFloat(counter))
        }, completion: { [weak self] (_) in
            if counter < (self?.numberOfObjects ?? 0)-1 {
                self?.animateInfiniteCircularProgressView(counter: counter+1)
            }
            else {
                self?.animateInfiniteCircularProgressView(counter: 0)
            }
        })
    }
}

extension CircularLoaderView {
    
    func drawCircle(index: Int, point: CGPoint) {
        let multiplier = CGFloat(index)/(CGFloat(numberOfObjects ?? 1)-1)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = CGColor(red: 1, green: 0, blue: 0, alpha: multiplier*1)
        self.layer.addSublayer(shapeLayer)
        
        let circle = UIBezierPath(arcCenter: point, radius: multiplier*(objectSize ?? 0)/2, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circle.cgPath
    }
    
    func drawArc(index: Int, point: CGPoint) {
        let multiplier = CGFloat(index)/(CGFloat(numberOfObjects ?? 1)-1)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.lineWidth = 5.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = CGColor(red: 1, green: 0, blue: 0, alpha: multiplier*1)
        self.layer.addSublayer(shapeLayer)
        
        let circle = UIBezierPath(arcCenter: circularProgressBarCentre ?? CGPoint(), radius: radius ?? 0, startAngle: CGFloat(index)*(arcRadian ?? 0)+0.02, endAngle: CGFloat(index + 1)*(arcRadian ?? 0)-0.02, clockwise: true)
        
        shapeLayer.path = circle.cgPath
    }
    
    // delay = 0, duration = 0.5, objects = 30+
    func drawContinuousCircle(index: Int, point: CGPoint) {
        let multiplier = CGFloat(index)/(CGFloat(numberOfObjects ?? 1)-1)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.lineWidth = 5.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = CGColor(red: 1, green: 0, blue: 0, alpha: multiplier*1)
        self.layer.addSublayer(shapeLayer)
        
        let circle = UIBezierPath(arcCenter: circularProgressBarCentre ?? CGPoint(), radius: radius ?? 0, startAngle: CGFloat(index)*(arcRadian ?? 0), endAngle: CGFloat(index + 1)*(arcRadian ?? 0), clockwise: true)
        
        shapeLayer.path = circle.cgPath
    }
}
