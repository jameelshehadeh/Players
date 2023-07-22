//
//  PlayerTableViewCell.swift
//  Players
//
//  Created by Jameel Shehadeh on 22/07/2023.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    private lazy var hStackView : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [playerImage,playerInfoVStackView,ratingVStackView])
        stackView.backgroundColor = .white
        stackView.addShadow()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        stackView.layer.cornerRadius = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var playerImage : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "CR")
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var playerInfoVStackView : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [playerNameLabel,clubPositionHStackView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    let playerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.text = "Cristiano Ronado"
        return label
    }()
    
    private lazy var clubPositionHStackView : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [clubNameLabel,spacerView,playerPositionLabel,UIView()])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()
    
    let clubNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.primary
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "Manchester"
        return label
    }()
    
    let spacerView : UIView = {
       let view = UIView()
        view.backgroundColor = AppColors.gray01
        view.snp.makeConstraints { make in
            make.width.equalTo(1)
        }
        return view
    }()

    let playerPositionLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.gray7
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "Goal keeper"
        return label
    }()
    
    private lazy var ratingVStackView : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [ratingValueLabel,ratingLabel])
        stackView.axis = .vertical
        stackView.backgroundColor = AppColors.gary0
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layer.cornerRadius = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        stackView.snp.makeConstraints { make in
            make.width.equalTo(55)
        }
        return stackView
    }()
    
    let ratingValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColors.primary
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.text = "98"
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = AppColors.gray3
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.text = "Rating"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        updateUI()
    }

    func updateUI(){
        
        contentView.addSubview(hStackView)
        contentView.backgroundColor = AppColors.gary0
        hStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
