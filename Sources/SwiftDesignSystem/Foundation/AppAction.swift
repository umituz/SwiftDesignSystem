import SwiftUI

// MARK: - Action Style
public enum AppActionStyle {
    case `default`
    case destructive
    case cancel
}

// MARK: - Action
public struct AppAction: Identifiable {
    public let id: String
    public let title: String
    public let style: AppActionStyle
    public let action: () -> Void

    public init(
        id: String? = nil,
        title: String,
        style: AppActionStyle = .default,
        action: @escaping () -> Void = {}
    ) {
        self.id = id ?? title
        self.title = title
        self.style = style
        self.action = action
    }
}
