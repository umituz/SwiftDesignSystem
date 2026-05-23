import SwiftUI

// MARK: - Avatar Size
public enum AppAvatarSize {
    case small
    case medium
    case large
    case xLarge

    var dimension: CGFloat {
        switch self {
        case .small: return DesignTokens.Sizing.badgeSmall
        case .medium: return DesignTokens.Sizing.badgeMedium
        case .large: return DesignTokens.Sizing.badgeLarge
        case .xLarge: return DesignTokens.Sizing.badgeXLarge
        }
    }

    var font: Font {
        switch self {
        case .small: return DesignTokens.Typography.caption2
        case .medium: return DesignTokens.Typography.caption
        case .large: return DesignTokens.Typography.footnote
        case .xLarge: return DesignTokens.Typography.headline
        }
    }
}

// MARK: - AppAvatar
public struct AppAvatar: View {
    let imageName: String?
    let initials: String?
    let size: AppAvatarSize
    let color: Color

    public init(
        imageName: String? = nil,
        initials: String? = nil,
        size: AppAvatarSize = .medium,
        color: Color = DesignTokens.Colors.primary
    ) {
        self.imageName = imageName
        self.initials = initials
        self.size = size
        self.color = color
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(color.gradient)
                .frame(width: size.dimension, height: size.dimension)

            if let imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.dimension, height: size.dimension)
                    .clipShape(Circle())
            } else if let initials {
                Text(initials)
                    .font(size.font)
                    .fontWeight(.semibold)
                    .foregroundColor(DesignTokens.Colors.textOnPrimary)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityDescription)
    }

    private var accessibilityDescription: String {
        if imageName != nil { return SystemStrings.Accessibility.avatarImage }
        if let initials { return SystemStrings.avatarWithInitials(initials) }
        return SystemStrings.Accessibility.avatar
    }
}
