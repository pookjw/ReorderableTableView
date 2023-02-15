//
//  ViewController.swift
//  ReorderableTableView
//
//  Created by Jinwoo Kim on 2/15/23.
//

import UIKit

@MainActor
final class ViewController: UIViewController {
  private var tableView: UITableView!
  private var viewModel: ViewModel!
  private var loadingDataSourceTask: Task<Void, Never>?

  deinit {
    loadingDataSourceTask?.cancel()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    configureViewModel()

    loadingDataSourceTask = .init { [viewModel] in
      await viewModel?.loadDataSource()
    }
  }

  private func configureTableView() {
    let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
    tableView.dragDelegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    self.tableView = tableView
  }

  private func configureViewModel() {
    let dataSource = createDataSource()
    let viewModel = ViewModel(dataSource: dataSource)
    self.viewModel = viewModel
  }

  private func createDataSource() -> MovableTableViewDiffableDataSource {
    .init (tableView: tableView) { tableView, indexPath, itemIdentifier in
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

      var contentConfiguration = UIListContentConfiguration.cell()
      contentConfiguration.text = itemIdentifier

      cell.contentConfiguration = contentConfiguration

      return cell
    }
  }
}

extension ViewController: UITableViewDragDelegate {
  func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    let itemProvider = NSItemProvider(item: indexPath as NSIndexPath, typeIdentifier: "Test")
    let dragItem = UIDragItem(itemProvider: itemProvider)
    return [dragItem]
  }
}
