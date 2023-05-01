//
//  MarieWindow.swift
//  Marie
//
//  Created by Gabriel Olbrisch on 15/04/23.
//

import UIKit

open class MarieWindow: UIWindow {
    
    public let requestSheetviewController: RequestSheetViewController = .init()
    
    @available(iOS 13.0, *)
    public override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        setupGesture()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupGesture()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGesture() {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        longGesture.numberOfTapsRequired = 2
        longGesture.minimumPressDuration = 1
        addGestureRecognizer(longGesture)
    }
    
    @objc private func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        if let rootViewController = rootViewController, gesture.state == .began {
            ImpactController.shared.doTactilFeedback(.light)
            let navigationController = UINavigationController(rootViewController: requestSheetviewController)
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.barTintColor = nil
            navigationController.navigationBar.isTranslucent = true
            rootViewController.present(navigationController, animated: true, completion: nil)
        }
    }
}
