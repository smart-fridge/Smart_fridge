//
//  BarEntry.swift
//  SmartFridgeFinal
//
//  Created by Mannan Mendiratta on 1/27/19.
//  Copyright © 2019 Mannan Mendiratta. All rights reserved.
//

import Foundation
import UIKit

struct BarEntry {
    let color: UIColor
    
    /// Ranged from 0.0 to 1.0
    let height: Float
    
    /// To be shown on top of the bar
    let textValue: String
    
    /// To be shown at the bottom of the bar
    let title: String
}
