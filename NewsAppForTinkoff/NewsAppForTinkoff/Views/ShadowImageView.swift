//
//  ShadowImageView.swift
//  NewsAppForTinkoff
//
//  Created by Andrei Panasenko on 05.02.2022.
//

import UIKit

final class ShadowImageView: UIView {
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    private lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = 20
        v.clipsToBounds = true
        
        return v
    }()
    
    private lazy var baseView: UIView = {
        let v = UIView()
        
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        let image = UIImage(named: "hotNews")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 10, width: 350, height: 130)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        v.addSubview(imageView)        
        return v
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(baseView)
        baseView.addSubview(imageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        [baseView, imageView].forEach { (v) in
            NSLayoutConstraint.activate([
                v.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                v.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                v.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                v.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseView.layer.shadowPath = UIBezierPath(roundedRect: baseView.bounds, cornerRadius: 10).cgPath
        baseView.layer.shouldRasterize = true
        baseView.layer.rasterizationScale = UIScreen.main.scale
    }
}
