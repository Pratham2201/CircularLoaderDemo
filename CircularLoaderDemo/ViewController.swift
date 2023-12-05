//
//  ViewController.swift
//  CircularLoaderDemo
//
//  Created by Pratham Gupta on 02/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var circluarLoaderView: CircularLoaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circluarLoaderView.configure(delegate: self, radius: 100, numberOfObjects: 20, objectSize: 50)
        circluarLoaderView.animateInfiniteCircularProgressView(duration: 0.0, delay: 0.017)
    }
}

extension ViewController: CircularLoaderViewDelegate {
    func drawObject(circluarView: CircularLoaderView, index: Int, drawPoint: CGPoint) {
        circluarView.drawArc(index: index, point: drawPoint, increasingSize: true)
    }
}

