//
//  RequestSheetViewModel.swift
//  Marie
//
//  Created by Gabriel Olbrisch on 14/04/23.
//

import UIKit

protocol RequestSheetViewModelDelegate: AnyObject {
    func didLogChange()
}

final class RequestSheetViewModel: Observer {
    
    weak var delegate: RequestSheetViewModelDelegate?
    
    override init() {
        super.init()
        LogManager.shared.attach(self)
    }
    
    override func update(log: URLLogModel?) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didLogChange()
        }
    }
    
}
