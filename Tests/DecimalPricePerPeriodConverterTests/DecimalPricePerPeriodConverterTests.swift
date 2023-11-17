import XCTest
@testable import DecimalPricePerPeriodConverter

// TODO Refactore with different periods
final class DecimalPricePerPeriodConverterTests: XCTestCase {
    
    func testPricePerWeekWithNilValues() {
        let price: Decimal? = nil
        let period: Int? = nil
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period)
        XCTAssertEqual(result, "")
    }
    
    func testPricePerWeekWithNilPrice() {
        let price: Decimal? = nil
        let period: Int? = 5
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period)
        XCTAssertEqual(result, "")
    }
    
    func testPricePerWeekWithNilPeriod() {
        let price: Decimal? = 500
        let period: Int? = nil
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period)
        XCTAssertEqual(result, "")
    }
    
    func testPricePerWeekWithZeroPeriod() {
        let price: Decimal? = 500
        let period: Int? = 0
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period)
        XCTAssertEqual(result, "")
    }
    
    func testPricePerWeekWithValues() {
        let price: Decimal? = 500
        let period: Int? = 5
        let locale = Locale(identifier: "en_US")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "USD")
        XCTAssertEqual(result, "$100.00")
    }
    
    func testPricePerWeekWithFractionalValues() {
        let price: Decimal? = 500.50
        let period: Int? = 7
        let locale = Locale(identifier: "en_US")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "USD")
        XCTAssertEqual(result, "$71.50")
    }
    
    func testPricePerWeekWithRoundingValues() {
        let price: Decimal? = 500.33
        let period: Int? = 7
        let locale = Locale(identifier: "en_US")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "USD")
        XCTAssertEqual(result, "$71.48")
    }
    
    func testPricePerWeekWithUSLocale() {
        let price: Decimal? = 500.50
        let period: Int? = 5
        let locale = Locale(identifier: "en_US")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "USD")
        XCTAssertEqual(result, "$100.10")
    }
    
    func testPricePerWeekWithGermanLocale() {
        let price: Decimal? = 500.50
        let period: Int? = 5
        let locale = Locale(identifier: "de_DE")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "EUR")
        XCTAssertEqual(result, "100,10€")
    }
    
    func testPricePerWeekWithGermanLocaleOne() {
        let price: Decimal? = 2.00
        let period: Int? = 2
        let locale = Locale(identifier: "de_DE")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "EUR")
        XCTAssertEqual(result, "1,00€")
    }
    
    func testPricePerWeekWithGermanLocaleZeroPointNinetySix() {
        let price: Decimal? = 4.80
        let period: Int? = 5
        let locale = Locale(identifier: "de_DE")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "EUR")
        XCTAssertEqual(result, "0,96€")
    }
    
    func testPricePerWeekWithGermanLocaleZeroPointZeroTwo() {
        let price: Decimal? = 0.02
        let period: Int? = 1
        let locale = Locale(identifier: "de_DE")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "EUR")
        XCTAssertEqual(result, "0,02€")
    }
    
    func testPricePerWeekWithGermanLocaleOnePointZeroEight() {
        let price: Decimal? = 5.40
        let period: Int? = 5
        let locale = Locale(identifier: "de_DE")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "EUR")
        XCTAssertEqual(result, "1,08€")
    }
    
    func testPricePerWeekWithGermanLocaleZeroPointFourFive() {
        let price: Decimal? = 0.45
        let period: Int? = 1
        let locale = Locale(identifier: "de_DE")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "EUR")
        XCTAssertEqual(result, "0,45€")
    }
    
    func testPricePerWeekWithUSLocaleOne() {
        let price: Decimal? = 2.00
        let period: Int? = 2
        let locale = Locale(identifier: "en_US")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "USD")
        XCTAssertEqual(result, "$1.00")
    }
    
    func testPricePerWeekWithJapaneseLocaleOne() {
        let price: Decimal? = 2.00
        let period: Int? = 2
        let locale = Locale(identifier: "ja_JP")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "JPY")
        XCTAssertEqual(result, "¥1.00") // In Japan, there is no fractional part for integer values
    }
    
    func testPricePerWeekWithJapaneseLocaleOnePointZeroEight() {
        let price: Decimal? = 5.40
        let period: Int? = 5
        let locale = Locale(identifier: "ja_JP")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "JPY")
        XCTAssertEqual(result, "¥1.08")
    }
    
    func testPricePerWeekWithJapaneseLocaleZeroPointFourFive() {
        let price: Decimal? = 0.45
        let period: Int? = 1
        let locale = Locale(identifier: "ja_JP")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "JPY")
        XCTAssertEqual(result, "¥0.45")
    }
    
    func testPricePerWeekWithKoreanLocaleOne() {
        let price: Decimal? = 2.00
        let period: Int? = 2
        let locale = Locale(identifier: "ko_KR")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "KRW")
        XCTAssertEqual(result, "₩1.00") // In Korea, there is no fractional part for integer values
    }
    
    func testPricePerWeekWithKoreanLocaleOnePointZeroEight() {
        let price: Decimal? = 5.40
        let period: Int? = 5
        let locale = Locale(identifier: "ko_KR")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "KRW")
        XCTAssertEqual(result, "₩1.08")
    }
    
    func testPricePerWeekWithKoreanLocaleZeroPointFourFive() {
        let price: Decimal? = 0.45
        let period: Int? = 1
        let locale = Locale(identifier: "ko_KR")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "KRW")
        XCTAssertEqual(result, "₩0.45")
    }
    
    func testPricePerWeekWithCanadianLocaleOne() {
        let price: Decimal? = 2.00
        let period: Int? = 2
        let locale = Locale(identifier: "en_CA")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "CAD")
        XCTAssertEqual(result, "$1.00") // In Canada, the fractional part is included even for integer values
    }
    
    func testPricePerWeekWithCanadianLocaleOnePointZeroEight() {
        let price: Decimal? = 5.40
        let period: Int? = 5
        let locale = Locale(identifier: "en_CA")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "CAD")
        XCTAssertEqual(result, "$1.08")
    }
    
    func testPricePerWeekWithCanadianLocaleZeroPointFourFive() {
        let price: Decimal? = 0.45
        let period: Int? = 1
        let locale = Locale(identifier: "en_CA")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "CAD")
        XCTAssertEqual(result, "$0.45")
    }
    
    func testPricePerWeekWithSwissLocaleOne() {
        let price: Decimal? = 2.00
        let period: Int? = 2
        let locale = Locale(identifier: "de_CH")
        let result = DecimalPricePerPeriodConverter.pricePerPeriod(from: price, period: period, locale: locale, currencyCode: "CHF")
        XCTAssertEqual(result, "CHF 1.00")
    }
}
