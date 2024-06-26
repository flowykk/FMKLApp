//
//  PrimaryTableView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 16.05.2024.
//

import UIKit

final class PrimaryTableView: UITableView {
    weak var presenter: SettingsPresenter?
    
    enum DevInfoRow: String, CaseIterable {
        case viewInfo = "View developer info"
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PrimaryTableView {
    private func commonInit() {
        delegate = self
        dataSource = self
        register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        isScrollEnabled = false
        layer.cornerRadius = 20
        backgroundColor = .none
        rowHeight = 50
        setHeight(Double(50 * (DevInfoRow.allCases.count) - 1))
    }
}

// MARK: - UITableViewDelegate
extension PrimaryTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = DevInfoRow.allCases[indexPath.row]
        presenter?.devInfoRowSelected(selectedRow)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension PrimaryTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DevInfoRow.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let customCell = cell as? CustomTableViewCell else { return cell }
        let name = DevInfoRow.allCases[indexPath.row].rawValue
        let iconName = getIconName(fromRow: DevInfoRow.allCases[indexPath.row])
        customCell.configure(withName: name, imageName: iconName)
        
        return customCell
    }
}

// MARK: - Private funcs
extension PrimaryTableView {
    private func getIconName(fromRow row: DevInfoRow) -> String {
        switch row {
        case .viewInfo:
            return "info"
        }
    }
}
