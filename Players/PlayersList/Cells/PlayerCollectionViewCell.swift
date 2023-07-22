//
//  PlayerCollectionViewCell.swift
//  Players
//
//  Created by Jameel Shehadeh on 22/07/2023.
//

import UIKit
import SnapKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
    lazy var containerView : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15
        return containerView
    }()

    private lazy var labelsVStackView : UIStackView = {
        let stackView = UIStackView.init(arrangedSubviews: [playerNameLabel,clubNameLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var playerImage : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "CR")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        imageView.layer.cornerRadius = 12
        imageView.snp.makeConstraints { make in
            make.size.equalTo(136)
        }
        return imageView
    }()
    
    let playerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "Cristiano Ronado"
        return label
    }()
    
    let clubNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = AppColors.primaryMid
        label.adjustsFontSizeToFitWidth = true
        label.text = "Manchester"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
       
    }
    
    func updateUI(){
        contentView.clipsToBounds = false
        contentView.addShadow(shadowColor: .black, shadowOffset: CGSize(width: 3, height: 3), shadowOpacity: 0.1, shadowRadius: 3)
        
        contentView.addSubview(containerView)
        containerView.addSubview(playerImage)
        containerView.addSubview(labelsVStackView)
    
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(136)
        }
        
        playerImage.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
    
        labelsVStackView.snp.makeConstraints { make in
            make.top.equalTo(playerImage.snp_bottomMargin).offset(15)
            make.left.right.equalToSuperview().inset(8)
        }
    }
    
    func setupCell(model: Player) {
        playerNameLabel.text = model.name
        clubNameLabel.text = model.teamName
        playerImage.sd_setImage(with: URL(string: model.photo ?? "" ), placeholderImage: nil, context: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
