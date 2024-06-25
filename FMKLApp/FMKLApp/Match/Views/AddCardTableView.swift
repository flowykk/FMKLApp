//
//  AddCardTableView.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 19.06.2024.
//

import UIKit

class AddCardTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    private var playersCards: [PlayerCard] = []
    
    enum CellType {
        case addCell
        case playersCard(PlayerCard)
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
        register(AddCardCell.self, forCellReuseIdentifier: "AddCardCell")
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
    
    func deleteRow(rowIndex: Int) {
        playersCards.remove(at: rowIndex)
        
        reloadData()
    }
    
    func addRow(rowIndex: Int) {
        playersCards.append(PlayerCard(player: "Filatov K.", team: "BUSUS", minute: 54, isCardRed: true))
        
        reloadData()
    }
}

extension AddCardTableView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersCards.count + 1
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
        case .playersCard(let card):
            let cell = dequeueReusableCell(withIdentifier: "AddCardCell") as! AddCardCell
            
            cell.set(card: card)
            
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
            return .playersCard(playersCards[indexPath.row])
        }
    }
}

extension AddCardTableView {
    func fetchData() {
        self.playersCards = [
            PlayerCard(player: "Filatov K.", team: "BUSUS", minute: 1, isCardRed: true),
            PlayerCard(player: "Prostoryadin N.", team: "MEMPH", minute: 65, isCardRed: false)
        ]
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
