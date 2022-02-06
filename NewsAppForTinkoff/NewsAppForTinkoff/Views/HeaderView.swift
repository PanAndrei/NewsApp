//
//  HeaderView.swift
//  NewsAppForTinkoff
//
//  Created by Andrei Panasenko on 05.02.2022.
//

import UIKit

final class HeaderView: UIView {
    
    // подумать про изменение шрифта
    private var fontSize: CGFloat
    
    private lazy var headingLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        // придумать заголовок
        v.text = "News"
        v.font = UIFont.boldSystemFont(ofSize: fontSize)
        return v
    }()
    
    private lazy var globeImage: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
        v.image = UIImage(systemName: "globe.europe.africa", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
        return v
    }()
    
   //
    //
    //
//    private lazy var buttonRefresh: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
//        button.setImage(UIImage(systemName: "goforward", withConfiguration: config)?.withRenderingMode(.alwaysOriginal), for: .normal)
//        button.contentMode = .scaleAspectFit
////
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        
//        return button
//    }()
//    
   
    
    private lazy var subheadlineLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = v.font.withSize(fontSize)
        // change this name
        // news category
        v.text = "Aps name"
        v.textColor = .gray
        return v
    }()
    
    private lazy var headerStackView: UIStackView = {
        // plusimage
        let v = UIStackView(arrangedSubviews: [globeImage, headingLabel])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        //
        //
        v.setCustomSpacing(200, after: headingLabel)
        return v
    }()
    
    
    init(fontSize: CGFloat) {
        self.fontSize = fontSize
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(headerStackView)
        addSubview(subheadlineLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // newsheader
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        // subheadline
        NSLayoutConstraint.activate([
            subheadlineLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subheadlineLabel.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 8),
            subheadlineLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    ///
//    @objc func buttonAction(_ sender: UIButton!) {
//         print("button pressed")
//     }
    
}
