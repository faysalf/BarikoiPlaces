//
//  CustomTableViewCell.swift
//
//
//  Created by Md. Faysal Ahmed on 5/12/23.
//

import UIKit

public class CustomTableViewCell: UITableViewCell {

    public var textContent: Place? {
        didSet {
            guard let textContent = textContent else { return }
            titleLabel.text = textContent.address
            subTitleLabel.text = textContent.area
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .black
        lbl.backgroundColor = .clear
        return lbl
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 11)
        lbl.textColor = .black
        lbl.backgroundColor = .clear
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),

            subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0),
            subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
