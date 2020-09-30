//
//  TableViewCell.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/8/10.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var titleLabel = UILabel()
    
    var leftTag = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        titleLabel.frame = CGRect(x: 15, y: 0, width: 60, height: 55)
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor(74, 74, 74)
        titleLabel.highlightedTextColor = UIColor(236, 112, 67)
        contentView.addSubview(titleLabel)
        
        leftTag.frame = CGRect(x: 0, y: 20, width: 5, height: 15)
        leftTag.backgroundColor = UIColor(236, 112, 67)
        contentView.addSubview(leftTag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let lineWidth = 1 / UIScreen.main.scale
        let lineAdjustOffset = 1 / UIScreen.main.scale / 2
        let drawingRect = self.bounds.insetBy(dx: lineAdjustOffset, dy: lineAdjustOffset)
        
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 0, y: drawingRect.maxY))
        path.addLine(to: CGPoint(x: self.bounds.width, y: drawingRect.maxY))
        context.addPath(path)
        context.setStrokeColor(UIColor(255, 255, 255).cgColor)
        context.setLineWidth(lineWidth)
        context.strokePath()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
