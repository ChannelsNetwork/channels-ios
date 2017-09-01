//
//  AButton.swift
//  channels
//
//  Created by Preet Shihn on 8/30/17.
//  Copyright © 2017 Hivepoint, Inc. All rights reserved.
//

import UIKit

class AButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
}
