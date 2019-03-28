//
//  ViewController.swift
//  WaveView
//
//  Created by allen_zhang on 2019/3/28.
//  Copyright © 2019 com.mljr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lable = UILabel()
        lable.text = "正在加载中......"
        lable.textColor = .white
        lable.textAlignment = .center
        lable.frame = CGRect(x: screenWidth()*0.5 - 100, y: 0, width: 200, height: 50)
        
        let waveView = WaveView(frame: CGRect(x: 0, y: 0, width: screenWidth(),
                                            height: 130))
        waveView.closure = {centerY in
            lable.frame.origin.y = waveView.frame.height + centerY - 55
        }
        
        self.view.addSubview(waveView)
        self.view.addSubview(lable)
        
        waveView.startWave()
    }

    func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
}

