//
//  ViewController.swift
//  Frame and Bounds
//
//  Created by Ilya Andreev on 17.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let imageContainerView = UIView()
    private let imageView = UIImageView(image: UIImage(named: "picture2"))
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let stackView = UIStackView()
    
    private let centerXLabel = UILabel()
    private let centerYLabel = UILabel()
    private let frameXLabel = UILabel()
    private let frameYLabel = UILabel()
    private let frameWidthLabel = UILabel()
    private let frameHeightLabel = UILabel()
    private let boundsXLabel = UILabel()
    private let boundsYLabel = UILabel()
    private let boundsWidthLabel = UILabel()
    private let boundsHeightLabel = UILabel()
    private let rotationLabel = UILabel()
    
    private let centerXSlider = UISlider()
    private let centerYSlider = UISlider()
    private let frameXSlider = UISlider()
    private let frameYSlider = UISlider()
    private let frameWidthSlider = UISlider()
    private let frameHeightSlider = UISlider()
    private let boundsXSlider = UISlider()
    private let boundsYSlider = UISlider()
    private let boundsWidthSlider = UISlider()
    private let boundsHeightSlider = UISlider()
    private let rotationSlider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureImageContainerView()
        configureScrollView()
        
        initializeSliders()
        updateLabels()
    }
    
    private func configureImageContainerView() {
        view.addSubview(imageContainerView)
        imageContainerView.layer.cornerRadius = 10
        imageContainerView.clipsToBounds = true
        
        imageContainerView.frame.size.height = view.bounds.size.width - 100
        imageContainerView.frame.size.width = imageContainerView.frame.size.height
        imageContainerView.frame.origin.x = (view.bounds.size.width - imageContainerView.frame.size.width) / 2
        imageContainerView.frame.origin.y = imageContainerView.frame.origin.x
        
        imageContainerView.addSubview(imageView)
        imageView.contentMode = .center
        imageView.frame.origin.x = imageContainerView.bounds.origin.x + imageContainerView.bounds.size.width / 2 - imageView.frame.size.width / 2
        imageView.frame.origin.y = imageContainerView.bounds.origin.y + imageContainerView.bounds.size.height / 2 - imageView.frame.size.height / 2
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.cornerRadius = 10
        scrollView.isScrollEnabled = true
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2)
        ])
        
        scrollView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])

        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0

        let labels = [centerXLabel, centerYLabel, frameXLabel, frameYLabel, frameWidthLabel, frameHeightLabel, boundsXLabel, boundsYLabel, boundsWidthLabel, boundsHeightLabel, rotationLabel]
        let sliders = [centerXSlider, centerYSlider, frameXSlider, frameYSlider, frameWidthSlider, frameHeightSlider, boundsXSlider, boundsYSlider, boundsWidthSlider, boundsHeightSlider,  rotationSlider]
        
        for (index, _) in labels.enumerated() {
            stackView.addArrangedSubview(labels[index])
            stackView.addArrangedSubview(sliders[index])
            labels[index].configure()
            sliders[index].addTarget(self, action: #selector(sliderValueWasChanged), for: .valueChanged)
        }
    }
    
    private func initializeSliders() {
        centerXSlider.minimumValue = Float(-imageContainerView.center.x)
        centerXSlider.maximumValue = Float(3 * imageContainerView.center.x)
        centerXSlider.value = Float(imageContainerView.center.x)
        
        centerYSlider.minimumValue = Float(-imageContainerView.center.y)
        centerYSlider.maximumValue = Float(3 * imageContainerView.center.y)
        centerYSlider.value = Float(imageContainerView.center.y)
        
        frameXSlider.minimumValue = Float(-imageContainerView.frame.origin.x)
        frameXSlider.maximumValue = Float(3 * imageContainerView.frame.origin.x)
        frameXSlider.value = Float(imageContainerView.frame.origin.x)
        
        frameYSlider.minimumValue = Float(-imageContainerView.frame.origin.y)
        frameYSlider.maximumValue = Float(3 * imageContainerView.frame.origin.y)
        frameYSlider.value = Float(imageContainerView.frame.origin.y)
        
        frameWidthSlider.minimumValue = 0
        frameWidthSlider.maximumValue = Float(3 * imageContainerView.frame.size.width)
        frameWidthSlider.value = Float(imageContainerView.frame.size.width)
        
        frameHeightSlider.minimumValue = 0
        frameHeightSlider.maximumValue = Float(3 * imageContainerView.frame.size.height)
        frameHeightSlider.value = Float(imageContainerView.frame.size.height)
        
        boundsXSlider.minimumValue = Float(-imageView.frame.size.width / 2)
        boundsXSlider.maximumValue = Float(imageView.frame.size.width / 2)
        boundsXSlider.value = Float(imageContainerView.bounds.origin.x)
        
        boundsYSlider.minimumValue = Float(-imageView.frame.size.height / 2)
        boundsYSlider.maximumValue = Float(imageView.frame.size.height / 2)
        boundsYSlider.value = Float(imageContainerView.bounds.origin.y)
        
        boundsWidthSlider.minimumValue = 0
        boundsWidthSlider.maximumValue = Float(3 * imageContainerView.bounds.size.width)
        boundsWidthSlider.value = Float(imageContainerView.bounds.size.width)
        
        boundsHeightSlider.minimumValue = 0
        boundsHeightSlider.maximumValue = Float(3 * imageContainerView.bounds.size.height)
        boundsHeightSlider.value = Float(imageContainerView.bounds.size.height)
        
        rotationSlider.minimumValue = 0
        rotationSlider.maximumValue = 100
        rotationSlider.value = 0
    }
    
    private func updateLabels() {
        centerXLabel.text = "center x = \(Int(imageContainerView.center.x))"
        centerYLabel.text = "center y = \(Int(imageContainerView.center.y))"
        frameXLabel.text = "frame x = \(Int(imageContainerView.frame.origin.x))"
        frameYLabel.text = "frame y = \(Int(imageContainerView.frame.origin.y))"
        frameWidthLabel.text = "frame width = \(Int(imageContainerView.frame.width))"
        frameHeightLabel.text = "frame height = \(Int(imageContainerView.frame.height))"
        boundsXLabel.text = "bounds x = \(Int(imageContainerView.bounds.origin.x))"
        boundsYLabel.text = "bounds y = \(Int(imageContainerView.bounds.origin.y))"
        boundsWidthLabel.text = "bounds width = \(Int(imageContainerView.bounds.width))"
        boundsHeightLabel.text = "bounds height = \(Int(imageContainerView.bounds.height))"
        rotationLabel.text = "rotation = \((rotationSlider.value))"
    }
    
    @objc private func sliderValueWasChanged(sender: UISlider!)
    {
        switch sender {
        case centerXSlider:
            imageContainerView.center.x = CGFloat(centerXSlider.value)
        case centerYSlider:
            imageContainerView.center.y = CGFloat(centerYSlider.value)
        case frameXSlider:
            imageContainerView.frame.origin.x = CGFloat(frameXSlider.value)
        case frameYSlider:
            imageContainerView.frame.origin.y = CGFloat(frameYSlider.value)
        case frameWidthSlider:
            imageContainerView.frame.size.width = CGFloat(frameWidthSlider.value)
        case frameHeightSlider:
            imageContainerView.frame.size.height = CGFloat(frameHeightSlider.value)
        case boundsXSlider:
            imageContainerView.bounds.origin.x = CGFloat(boundsXSlider.value)
        case boundsYSlider:
            imageContainerView.bounds.origin.y = CGFloat(boundsYSlider.value)
        case boundsWidthSlider:
            imageContainerView.bounds.size.width = CGFloat(boundsWidthSlider.value)
        case boundsHeightSlider:
            imageContainerView.bounds.size.height = CGFloat(boundsHeightSlider.value)
        case rotationSlider:
            imageContainerView.transform = CGAffineTransform(rotationAngle: CGFloat(rotationSlider.value))
        default:
            fatalError()
        }
        updateLabels()
    }
}


extension UILabel {
    func configure() {
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
    }
}
