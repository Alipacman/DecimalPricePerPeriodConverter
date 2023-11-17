//
//  DecimalPricePerWeekConverterTest.swift
//  SchmusisHomeTests
//
//  Created by xo on 14.05.23.
//  Copyright © 2023 Ali Ebrahimi Pourasad. All rights reserved.
//

import Foundation

struct DecimalPricePerPeriodConverter {
    // E.g. for price per week for a month -> period = 4
    static func pricePerPeriod(from price: Decimal?, period: Int?,
                               locale: Locale = .current,
                               currencyCode: String? = nil) -> String {
        guard let price = price,
              let period = period,
              period != 0 else { return "" }
        
        let weeklyPrice = CGFloat(truncating: NSDecimalNumber(decimal: price)) / CGFloat(period)
        let roundedPrice = ceil(weeklyPrice * 100) / 100  // Rounded to two decimal places
        return formatPrice(roundedPrice, locale: locale, currencyCode: currencyCode)
    }
    
    private static func formatPrice(_ price: CGFloat, locale: Locale, currencyCode: String?) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = locale.hasDecimalsInCurrency ? 2 : 0 // Adjusting the fraction digits based on the locale
        numberFormatter.locale = locale
        
        if let currencyCode = currencyCode {
            numberFormatter.currencyCode = currencyCode
        }

        let isCurrencySymbolOnLeft = locale.currencySymbolOnLeft
        let isSpaceNeeded = locale.isSpaceNeededBetweenCurrencySymbolAndValue
        
        if isCurrencySymbolOnLeft {
            numberFormatter.positiveFormat = isSpaceNeeded ? "¤ #,##0.00" : "¤#,##0.00"
            numberFormatter.negativeFormat = isSpaceNeeded ? "-¤ #,##0.00" : "-¤#,##0.00"
        } else {
            numberFormatter.positiveFormat = isSpaceNeeded ? "#,##0.00 ¤" : "#,##0.00¤"
            numberFormatter.negativeFormat = isSpaceNeeded ? "-#,##0.00 ¤" : "-#,##0.00¤"
        }
        
        if let formattedPrice = numberFormatter.string(from: price as NSNumber) {
            return formattedPrice
        } else {
            return "\(price)"
        }
    }
}

private extension Locale {
    var currencySymbolOnLeft: Bool {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self
        let currencySymbol = formatter.currencySymbol ?? ""
        let currencyCode = formatter.currencyCode ?? ""
        let sampleString = formatter.string(from: 123 as NSNumber) ?? ""
        return sampleString.hasPrefix(currencySymbol) || sampleString.hasPrefix(currencyCode)
    }

    var isSpaceNeededBetweenCurrencySymbolAndValue: Bool {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self
        let sampleString = formatter.string(from: 123 as NSNumber) ?? ""
        let currencySymbol = formatter.currencySymbol ?? ""
        return sampleString.contains(" \(currencySymbol)") || sampleString.contains("\(currencySymbol) ")
    }
    
    // New computed property to check if the locale uses decimal places in its currency
     var hasDecimalsInCurrency: Bool {
         switch currencyCode {
         case "JPY", "KRW", "BYN", "DJF", "IDR", "GNF", "KMF", "MGA", "PYG", "RWF", "VND", "VUV", "XAF", "XOF", "XPF":
             return false
         default:
             return true
         }
     }
}
