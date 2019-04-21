//
//  HistoryTableViewCell.swift
//  Trivia
//
//  Created by admin on 20/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    // MARK: - Cell Methods -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK:- Defined Views -
    fileprivate lazy var userNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Heavyitalic", size: 20)
        label.text = "Muneer Ahmed"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate lazy var dateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Medium", size: 18)
        label.text = "12-mon-1878 Am"
        label.textColor = UIColor(white: 1, alpha: 0.8)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate lazy var backgroundSelectdView:UIView = {
        let background = UIView()
        background.backgroundColor = UIColor(red: 40/255, green: 60/255, blue: 88/255, alpha: 1)
        background.layer.cornerRadius = 25
        background.clipsToBounds = true
        return background
    }()
    
    // MARK: - Adding SubViews -
    private func addSubviews(){
        self.backgroundColor = .clear
        let stackView = stackViews(stackViews: [userNameLabel,dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 46/255, green: 66/255, blue: 91/255, alpha: 1)
        backgroundView.layer.cornerRadius = 25
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backgroundView)
        backgroundView.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: -10, paddingRight: 10)
        
        backgroundView.addSubview(stackView)
        stackView.setAnchor(top: backgroundView.topAnchor, left: backgroundView.leftAnchor, bottom: backgroundView.bottomAnchor, right: backgroundView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: -10, paddingRight: 0)
        
        self.selectedBackgroundView = backgroundSelectdView
        self.selectedBackgroundView?.clipsToBounds = true
        
        
    }
    
    // MARK: - Update Cell Views -
    func updateTableCell(history:History){
        userNameLabel.text = history.name
        
        let date = history.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd-MMMM, hh:mm a"
        
        dateLabel.text = dateFormater.string(from: date!)
    }
}
