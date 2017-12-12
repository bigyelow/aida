//
//  BaseConfiguration.swift
//  aida
//
//  Created by bigyelow on 12/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

import UIKit

class BaseConfiguration: NSObject {
  static let baseAPIURLStr = "http://aida.com"
  static let appVersion = "0.1.0"
  static let bundleID = Bundle.main.bundleIdentifier ?? ""
  static let apiUserAgent = "iOS \(BaseConfiguration.bundleID)/\(BaseConfiguration.appVersion)"
}
