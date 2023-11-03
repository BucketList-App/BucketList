import UIKit

public extension UITextView {
    func height(forNumberOfLines numberOfLines: Int) -> CGFloat {
        guard let font else { return .zero }

        let lineHeight = font.lineHeight // Получаем высоту одной строки для заданного шрифта
        let vertivalInsets = textContainerInset.top + textContainerInset.bottom

        return (lineHeight * CGFloat(numberOfLines)) + vertivalInsets
    }
}
