//
//  DisplayAlert.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 11/10/21.
//

import Foundation
import UIKit

extension UIViewController {
    func displayAlert() {
        let alert = UIAlertController(title: "Erro", message: "Algo errado aconteceu. Tente novamente mais tarde.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true)
    }
}
