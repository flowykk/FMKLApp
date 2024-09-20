//
//  GoalsTableView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 19.06.2024.
//

import UIKit

final class GoalsTableView: UITableView {
    weak var presenter: MatchPresenter?
    
    private var goals: [Goal] = []
    
    enum CellType {
        case addCell
        case goal(Goal)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        self.autoresizingMask = [.flexibleHeight]
        fetchData()
        configure()
    }
}

// MARK: - Class functions
extension GoalsTableView {
    func deleteRow(rowIndex: Int) {
        goals.remove(at: rowIndex)
        
        reloadData()
    }
    
    func addRow(withGoal goal: Goal) {
        goals.append(goal)
        
        reloadData()
    }
    
    private func configure() {
        backgroundColor = Constants.backgroundColor
        delegate = self
        dataSource = self
        register(GoalCell.self, forCellReuseIdentifier: "GoalCell")
        register(AddCell.self, forCellReuseIdentifier: "AddCell")
        rowHeight = 50
        
        separatorStyle = .none
        isScrollEnabled = false
        
        updateHeight()
    }
    
    private func updateHeight() {
        let height = rowHeight * 3
        setHeight(mode: .equal, height)
    }
    
    private func addRow(rowIndex: Int) {
        let num = Int(arc4random_uniform(2) + 1)
        if num == 1 {
            let goal = Goal(
                scoredTeamName: "BUSUS",
                scoredPlayer: "Filatov K.",
                assistedPlayer: "Rakhimov A.",
                minute: 10
            )
            presenter?.addGoalToTable(withGoal: goal)
            presenter?.updateTrackingMatchTeamScores(withGoal: goal)
        } else if num == 2 {
            let goal = Goal(
                scoredTeamName: "KUBN",
                scoredPlayer: "Nachinkin I.",
                assistedPlayer: "Martynov D.",
                minute: 10
            )
            presenter?.addGoalToTable(withGoal: goal)
            presenter?.updateTrackingMatchTeamScores(withGoal: goal)
        }
        
        //presenter?.addGoalButtonTapped()
    }
}

// MARK: - GoalsTableViewDelegate + GoalsTableViewDataSource
extension GoalsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = determineCellType(self, for: indexPath)
                
        switch cellType {
        case .addCell:
            let cell = dequeueReusableCell(withIdentifier: "AddCell", for: indexPath)
            guard let addButtonCell = cell as? AddCell else { return cell }
            
            addButtonCell.addButtonTapAction = { [weak self] in
                self?.addRow(rowIndex: indexPath.row)
                self?.isScrollEnabled = true
            }
            
            return addButtonCell
        case .goal(let goal):
            let cell = dequeueReusableCell(withIdentifier: "GoalCell") as! GoalCell
            
            cell.set(goal: goal)
            cell.deleteButtonTapAction = { [weak self] in
                self?.deleteRow(rowIndex: indexPath.row)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
        
    private func determineCellType(_ tableView: UITableView, for indexPath: IndexPath) -> CellType {
        if indexPath.row == self.numberOfRows(inSection: 0) - 1 {
            return .addCell
        } else {
            return .goal(goals[indexPath.row])
        }
    }
}

// MARK: - Fetching Data for GoalsTableView
extension GoalsTableView {
    func fetchData() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

