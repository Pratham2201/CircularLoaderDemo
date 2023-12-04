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
        circluarLoaderView.configure(delegate: self, radius: 100, numberOfObjects: 12, objectSize: 50)
//        circluarLoaderView.animateInfiniteCircularProgressView()
    }

extension ViewController: CircularLoaderViewDelegate {
    func drawObject(circluarView: CircularLoaderView, index: Int, drawPoint: CGPoint) {
        circluarView.drawCircle(index: index, point: drawPoint)
    }
}

