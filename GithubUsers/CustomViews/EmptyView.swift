//
//  EmptyView.swift
//  tenantapp
//
//  Created by Agus Cahyono on 12/05/20.
//  Copyright © 2020 RoomMe. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
}

//  MARK: - Set Components
extension EmptyView {
    func xibSetup() {
        contentView = loadNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}
