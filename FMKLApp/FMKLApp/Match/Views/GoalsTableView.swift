//
//  GoalsTableView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 19.06.2024.
//

import UIKit

class GoalsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
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
    
    private func configure() {
        backgroundColor = Constants.backgroundColor
        delegate = self
        dataSource = self
        register(GoalCell.self, forCellReuseIdentifier: "GoalCell")
        register(AddCell.self, forCellReuseIdentifier: "AddCell")
        rowHeight = 50
        
        separatorStyle = .none
        isScrollEnabled = false
        
        updateHeight(mode: .equal)
    }
    
    private func updateHeight(mode: ConstraintMode = .grOE) {
        let height = rowHeight * CGFloat(goals.count)
        setHeight(mode: mode, height)
    }
    
    func deleteRow(rowIndex: Int) {
        goals.remove(at: rowIndex)
        
        updateHeight()
        reloadData()
    }
    
    func addRow(rowIndex: Int) {
        goals.append(Goal(scoredTeamName: "NEW", scoredPlayer: "NEW", assistedPlayer: "NEW", minute: 0))
        
        updateHeight(mode: .grOE)
        reloadData()
    }
}

extension GoalsTableView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
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

extension GoalsTableView {
    func fetchData() {
        self.goals = [
            Goal(scoredTeamName: "BUSUS", scoredPlayer: "Rakhimov A.", assistedPlayer: "Filatov K.", minute: 14),
            Goal(scoredTeamName: "MEMPH", scoredPlayer: "Prostoyadin N.", assistedPlayer: "Smirnov I.", minute: 44)
        ]
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

