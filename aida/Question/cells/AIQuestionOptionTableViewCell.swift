//
//  AIQuestionOptionTableViewCell.swift
//  aida
//
//  Created by bigyelow on 16/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

import UIKit

private let leftMargin: CGFloat = 20
private let descLeftMargin: CGFloat = 10
private let topMargin: CGFloat = 10
private let bottomMargin: CGFloat = 10
private let imageWidth: CGFloat = 15
private let imageHeight: CGFloat = 21

class AIQuestionOptionTableViewCell: UITableViewCell {
  private let descLabel = UILabel()
  private let checkImageView = UIImageView(image: UIImage(named: "uncheck"))

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    selectionStyle = .none

    contentView.addSubview(descLabel)
    contentView.addSubview(checkImageView)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    descLabel.sizeToFit()
    checkImageView.bounds.size = CGSize(width: imageWidth, height: imageHeight)

    checkImageView.frame.origin.x = leftMargin
    descLabel.frame.origin.x = checkImageView.frame.maxX + descLeftMargin

    let centerY = contentView.bounds.size.height / 2
    checkImageView.center.y = centerY
    descLabel.center.y = centerY
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    descLabel.sizeToFit()

    return CGSize(width: size.width,
                  height: max(descLabel.bounds.size.height, imageHeight) + topMargin + bottomMargin)
  }

  func update(with questionOption: AIQuestionOption, index: Int, toCheck: Bool) {
    guard let text = questionOption.text else { return }
    descLabel.text = "\(index + 1). \(text)"
    checkImageView.image = UIImage(named: toCheck ? "check" : "uncheck")

    setNeedsLayout()
  }
}
