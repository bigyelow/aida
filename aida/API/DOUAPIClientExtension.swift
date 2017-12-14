//
//  DOUAPIClientExtension.swift
//  aida
//
//  Created by bigyelow on 12/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

import DoubanObjCClient

extension DOUAPIClient {
  static let client: DOUAPIClient = {
    let client = DOUAPIClient(baseURL: BaseConfiguration.baseAPIURLStr, userAgent: BaseConfiguration.apiUserAgent)
    return client!
  }()
}
