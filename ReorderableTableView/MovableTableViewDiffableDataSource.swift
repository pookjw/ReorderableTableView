//
//  MovableTableViewDiffableDataSource.swift
//  ReorderableTableView
//
//  Created by Jinwoo Kim on 2/15/23.
//

import UIKit

@MainActor
final class MovableTableViewDiffableDataSource: UITableViewDiffableDataSource<Int, String> {
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    super.tableView(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)

    guard
      let sourceItemModel = itemIdentifier(for: sourceIndexPath),
      let destinationItemModel = itemIdentifier(for: destinationIndexPath)
    else {
      return
    }

    var snapshot = snapshot()
    snapshot.moveItem(sourceItemModel, afterItem: destinationItemModel)
    apply(snapshot, animatingDifferences: true)
  }
}
