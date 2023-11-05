import CoreUI
import UIKit

enum DreamInfoComponentsFactory {

    static func makeTitleTextView() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.font = .boldSystemFont(ofSize: 16)
        textView.textAlignment = .natural
        textView.isScrollEnabled = false

        // TODO: Dynamic height (?)
        let titleHeight = textView.height(forNumberOfLines: 2)
        textView.layer.cornerRadius = titleHeight / 4

        return textView
    }

    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        return imageView
    }

    static func makeDescriptionTextView() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .natural
        textView.isScrollEnabled = false
        return textView
    }

}
