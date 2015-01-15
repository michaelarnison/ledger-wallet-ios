//
//  VisualTheme.swift
//  ledger-wallet-ios
//
//  Created by Nicolas Bigot on 12/01/2015.
//  Copyright (c) 2015 Ledger. All rights reserved.
//

import UIKit

struct VisualTheme {
    
    typealias ViewAllure = (UIView) -> ()
    typealias LabelAllure = (Label) -> ()
    typealias ButtonAllure = (Button) -> ()

    //MARK: View allures
    
    static let viewAllures: [String: ViewAllure] = [
        "view.background": { view in
            view.backgroundColor = VisualFactory.Colors.backgroundColor
        },
        "view.nightBlue": { view in
            view.backgroundColor = VisualFactory.Colors.nightBlue
        },
        "actionBar.grey": { view in
            let actionBar = view as ActionBarView
            actionBar.backgroundColor = VisualFactory.Colors.extraLightGrey
            actionBar.borderColor = VisualFactory.Colors.veryLightGrey
        },
        "tableView.transparent": { view in
            let tableView = view as TableView
            tableView.backgroundColor = VisualFactory.Colors.transparent
        },
        "navigationBar.nightBlue": { view in
            let navigationBar = view as NavigationBar
            navigationBar.translucent = false
            navigationBar.shadowImage = UIImage()
            navigationBar.barTintColor = VisualFactory.Colors.nightBlue
            navigationBar.barHeight = VisualFactory.Metrics.mediumNavigationBarHeight
            navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        }
    ]
    
    //MARK: Label allures
    
    static let labelAllures: [String: LabelAllure] = [
        "navigationBar.title": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.pageTitle)
        },
        "navigationBar.largeTitle": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.largePageTitle)
        },
        "navigationBar.text": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.navigationBarText)
        },
        "medium": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.medium)
        },
        "medium.grey": { label in
            label.attributedText = NSAttributedString(string: label.readableText(), attributes: VisualFactory.TextAttributes.mediumGrey)
        }
    ]
    
    //MARK: Button allures
    
    static let buttonAllures: [String: ButtonAllure] = [
        "navigationBar.button": { button in
            var hightlightedStyle = VisualFactory.TextAttributes.navigationBarText
            hightlightedStyle.updateValue((hightlightedStyle[NSForegroundColorAttributeName] as UIColor).darkerColor(), forKey: NSForegroundColorAttributeName)
            button.setAttributedTitle(NSAttributedString(string: button.readableTitleForState(UIControlState.Normal), attributes: VisualFactory.TextAttributes.navigationBarText), forState: UIControlState.Normal)
            button.setAttributedTitle(NSAttributedString(string: button.readableTitleForState(UIControlState.Normal), attributes: hightlightedStyle), forState: UIControlState.Highlighted)
        },
        "rounded": { button in
            let roundedButton = button as RoundedButton
            roundedButton.borderRadius = VisualFactory.Metrics.mediumBorderRadius
            roundedButton.tintColor = VisualFactory.Colors.white
            roundedButton.adjustsImageWhenHighlighted = false
            roundedButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: VisualFactory.Metrics.verySmallPadding)
            roundedButton.setAttributedTitle(NSAttributedString(string: button.readableTitleForState(UIControlState.Normal), attributes: VisualFactory.TextAttributes.roundedButtonText), forState: UIControlState.Normal)
            roundedButton.contentEdgeInsets = UIEdgeInsets(top: VisualFactory.Metrics.verySmallPadding, left: VisualFactory.Metrics.smallPadding, bottom: VisualFactory.Metrics.verySmallPadding, right: VisualFactory.Metrics.smallPadding)
        },
        "rounded.green": { button in
            VisualTheme.buttonAllures["rounded"]?(button)
            let roundedButton = button as RoundedButton
            roundedButton.setFillColor(VisualFactory.Colors.actionGreen, forState: UIControlState.Normal)
            roundedButton.setFillColor(VisualFactory.Colors.actionGreen.darkerColor(factor: VisualFactory.Metrics.strongDarkenFactor), forState: UIControlState.Highlighted)
        }
    ]
    
}
