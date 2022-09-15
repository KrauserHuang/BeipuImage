//
//  LabelFactory.swift
//  Beipu
//
//  Created by Tai Chin Huang on 2022/9/1.
//

import UIKit

func makeLabel(withTitle title: String,
               font: UIFont,
               textColor: UIColor) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = title
    label.font = font
    label.textAlignment = .center
    label.textColor = textColor
    label.numberOfLines = 0
    label.backgroundColor = .clear
    label.adjustsFontSizeToFitWidth = true
    return label
}
