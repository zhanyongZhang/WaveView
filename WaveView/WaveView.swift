//
//  WaveView.swift
//  WaveView
//
//  Created by allen_zhang on 2019/3/28.
//  Copyright © 2019 com.mljr. All rights reserved.
//

import UIKit

class WaveView: UIView {

    var waveHeight: CGFloat = 7
    var waveRate: CGFloat = 0.01
    var waveSpeed: CGFloat = 0.05
    var realWaveColor: UIColor = UIColor(55, 153, 249)
    var maskWaveColor: UIColor = UIColor(55, 153, 249, 0.3)
    var waveOnBottom: Bool = true
    var closure:((_ centerY: CGFloat) -> ())?
    private var displayLink: CADisplayLink?
    private var realWaveLayer: CAShapeLayer?
    private var maskWaveLayer: CAShapeLayer?
    private var offset: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWaveParame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWaveParame()
    }
    func initWaveParame() {
        
        realWaveLayer = CAShapeLayer()
        var frame = bounds
        realWaveLayer?.frame.origin.y = frame.size.height - waveHeight
        frame.size.height = waveHeight
        realWaveLayer?.frame = frame
        
        maskWaveLayer = CAShapeLayer()
        maskWaveLayer?.frame.origin.y = frame.size.height - waveHeight
        frame.size.height = waveHeight
        maskWaveLayer?.frame = frame
        
        layer.addSublayer(maskWaveLayer!)
        layer.addSublayer(realWaveLayer!)
    }
    
    func  startWave() {
        displayLink = CADisplayLink(target: self, selector: #selector(wave))
        displayLink?.add(to: RunLoop.current, forMode: .common)
    }
    
    func endWave() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc func wave() {
        
        offset += waveSpeed
        let startY = waveOnBottom ? 0 : frame.size.height
        let realPath = UIBezierPath()
        realPath.move(to: CGPoint(x: 0, y: startY))
        
        let maskPath = UIBezierPath()
        maskPath.move(to: CGPoint(x: 0, y: startY))
        
        var x = CGFloat(0)
        var y = CGFloat(0)
        
        while x <= bounds.size.width {
            
            y = waveHeight*sin(x*waveRate + offset)
            let realY = y + (self.waveOnBottom ? frame.size.height : 0)
            let maskY = -y + (self.waveOnBottom ? frame.size.height : 0)
            
            realPath.addLine(to: CGPoint(x: x, y: realY))
            maskPath.addLine(to: CGPoint(x: x, y: maskY))
            x += 0.01
        }
        
        let midX = bounds.size.width * 0.5
        let midY = waveHeight * sin(midX * waveRate + offset)
        
        if let closureBack = closure {
            closureBack(midY)
        }
        
        realPath.addLine(to: CGPoint(x: frame.size.width, y: startY))
        maskPath.addLine(to: CGPoint(x: frame.size.width, y: startY))
    
        maskPath.close()
        maskWaveLayer?.path = maskPath.cgPath
        maskWaveLayer?.fillColor = maskWaveColor.cgColor
        
        realPath.close()
        realWaveLayer?.path = realPath.cgPath
        realWaveLayer?.fillColor = realWaveColor.cgColor
    }
}
