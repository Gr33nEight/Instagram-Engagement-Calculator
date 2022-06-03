//
//  GlobalStuff.swift
//  Instagram Engagement Rate Calculator
//
//  Created by Natanael  on 31/12/2021.
//

import Foundation
import SwiftUI
import UIKit
import StoreKit

let screenW = UIScreen.main.bounds.width
let screenH = UIScreen.main.bounds.height

extension Color {
    static let primaryColor = Color("primaryColor")
    static let secondaryColor = Color("secondaryColor")
    static let thirdColor = Color("thirdColor")
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}

extension String {
    func parseToInt() -> Int? {
        return Int(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}

public struct AbbreviatedNumberFormatter {
    private let formatter: NumberFormatter

    public init(locale: Locale? = nil) {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.numberStyle = .decimal

        if let locale = locale {
            formatter.locale = locale
        }

        self.formatter = formatter
    }
}


public extension AbbreviatedNumberFormatter {
    func string(from value: Int) -> String {
        let divisor: Double
        let suffix: String

        switch abs(value) {
        case ..<1000:
            return "\(value)"
        case ..<1_000_000:
            divisor = 1000
            suffix = "K"
        case ..<1_000_000_000:
            divisor = 1_000_000
            suffix = "M"
        case ..<1_000_000_000_000:
            divisor = 1_000_000_000
            suffix = "B"
        default:
            divisor = 1_000_000_000_000
            suffix = "T"
        }

        let number = NSNumber(value: Double(value) / divisor)

        guard let formatted = formatter.string(from: number) else {
            return "\(value)"
        }

        return formatted + suffix
    }
}
