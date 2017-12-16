//
//  ReusableIdentifier.swift
//  aida
//
//  Created by bigyelow on 16/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

import UIKit

/**
 *  重用视图标识。
 */
public struct ReusableIdentifier <T: UIView> {
  public let identifier: String
  public let kind: String?

  public var viewType: AnyClass {
    return T.self
  }

  public init() {
    self.init(identifier: NSStringFromClass(T.self), kind: nil)
  }

  public init(identifier: String) {
    self.init(identifier: identifier, kind: nil)
  }

  public init(kind: String) {
    self.init(identifier: NSStringFromClass(T.self), kind: kind)
  }

  public init(identifier: String, kind: String?) {
    self.identifier = identifier
    self.kind = kind
  }

}

// MARK: - UITableView Extension

public extension UITableView {

  // MARK: Cell

  func register<T: UITableViewCell>(_ rid: ReusableIdentifier<T>) {
    self.register(T.self, forCellReuseIdentifier: rid.identifier)
  }

  func dequeue<T: UITableViewCell>(_ rid: ReusableIdentifier<T>, indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: rid.identifier, for: indexPath) as? T else {
      assertionFailure("No identifier(\(rid.identifier)) found for \(T.self)")
      return T.init()
    }
    return cell
  }

  func register<T: UITableViewCell>(_: T.Type) {
    register(ReusableIdentifier<T>())
  }

  func dequeue<T: UITableViewCell>(_ indexPath: IndexPath) -> T {
    return dequeue(ReusableIdentifier<T>(), indexPath: indexPath)
  }

  // MARK: Header & Footer View

  func register<T: UITableViewHeaderFooterView>(_ rid: ReusableIdentifier<T>) {
    self.register(T.self, forHeaderFooterViewReuseIdentifier: rid.identifier)
  }

  func dequeue<T: UITableViewHeaderFooterView>(_ rid: ReusableIdentifier<T>) -> T {
    guard let view = dequeueReusableHeaderFooterView(withIdentifier: rid.identifier) as? T else {
      assertionFailure("No identifier(\(rid.identifier)) found for \(T.self).")
      return T.init()
    }
    return view
  }

  func register<T: UITableViewHeaderFooterView>(_: T.Type) {
    register(ReusableIdentifier<T>())
  }

  func dequeue<T: UITableViewHeaderFooterView>() -> T {
    return dequeue(ReusableIdentifier<T>())
  }

}

// MARK: - UICollectionView Extension

public extension UICollectionView {

  // MARK: Cell

  func register<T: UICollectionViewCell>(_ rid: ReusableIdentifier<T>) {
    self.register(T.self, forCellWithReuseIdentifier: rid.identifier)
  }

  func dequeue<T: UICollectionViewCell>(_ rid: ReusableIdentifier<T>, indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: rid.identifier, for: indexPath) as? T else {
      assertionFailure("No identifier(\(rid.identifier)) found for \(T.self)")
      return T.init()
    }
    return cell
  }

  func register<T: UICollectionViewCell>(_: T.Type) {
    register(ReusableIdentifier<T>())
  }

  func dequeue<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
    return dequeue(ReusableIdentifier<T>(), indexPath: indexPath)
  }

  // MARK: Supplementary View

  func register<T: UICollectionReusableView>(_ rid: ReusableIdentifier<T>) {
    guard let kind = rid.kind else { assertionFailure(); return }
    self.register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: rid.identifier)
  }

  func dequeue<T: UICollectionReusableView>(_ rid: ReusableIdentifier<T>, indexPath: IndexPath) -> T {
    guard let kind = rid.kind else { assertionFailure(); return T.init() }
    guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: rid.identifier, for: indexPath) as? T else {
      assertionFailure("No identifier(\(rid)) found for \(T.self).")
      return T.init()
    }
    return view
  }

  func register<T: UICollectionReusableView>(_: T.Type, kind: String) {
    register(ReusableIdentifier<T>(kind: kind))
  }

  func dequeue<T: UICollectionReusableView>(_: T.Type, kind: String, indexPath: IndexPath) -> T {
    return dequeue(ReusableIdentifier<T>(kind: kind), indexPath: indexPath)
  }

}


