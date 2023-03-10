//
//  ViewModel.swift
//  ReorderableTableView
//
//  Created by Jinwoo Kim on 2/15/23.
//

import UIKit

actor ViewModel {
  private let dataSource: MovableTableViewDiffableDataSource

  init(dataSource: MovableTableViewDiffableDataSource) {
    self.dataSource = dataSource
  }

  func loadDataSource() async {
    var snapshot = NSDiffableDataSourceSnapshot<Int, String>()

    snapshot.appendSections([.zero])
    snapshot.appendItems(["🙋🏻‍♀️", "🤦🏻‍♀️", "🤷🏻‍♀️", "🙆🏻‍♀️", "💁🏻‍♀️"], toSection: .zero)

    await dataSource.apply(snapshot, animatingDifferences: true)
  }
}
