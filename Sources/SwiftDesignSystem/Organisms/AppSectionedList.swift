import SwiftUI

// MARK: - List Section Data
public struct AppListSectionData: Identifiable {
    public let id: String
    public let title: String
    public let items: [AppListItemData]

    public init(id: String? = nil, title: String, items: [AppListItemData]) {
        self.id = id ?? title
        self.title = title
        self.items = items
    }
}

// MARK: - List Item Data
public struct AppListItemData: Identifiable {
    public let id: String
    public let icon: String?
    public let title: String
    public let subtitle: String?
    public let trailing: String?

    public init(
        id: String? = nil,
        icon: String? = nil,
        title: String,
        subtitle: String? = nil,
        trailing: String? = nil
    ) {
        self.id = id ?? title
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.trailing = trailing
    }
}

// MARK: - AppSectionedList
public struct AppSectionedList: View {
    let sections: [AppListSectionData]
    let onItemTap: ((AppListSectionData, AppListItemData) -> Void)?

    public init(
        sections: [AppListSectionData],
        onItemTap: ((AppListSectionData, AppListItemData) -> Void)? = nil
    ) {
        self.sections = sections
        self.onItemTap = onItemTap
    }

    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: DesignTokens.Sizing.formSectionSpacing) {
                ForEach(sections) { section in
                    sectionView(section)
                }
            }
            .padding(.vertical, DesignTokens.Spacing.md)
        }
    }

    private func sectionView(_ section: AppListSectionData) -> some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
            AppSectionHeader(title: section.title)

            VStack(spacing: 0) {
                ForEach(Array(section.items.enumerated()), id: \.element.id) { index, item in
                    itemView(section: section, item: item)

                    if index < section.items.count - 1 {
                        AppDivider(isFullWidth: false)
                    }
                }
            }
            .background(DesignTokens.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.lg, style: .continuous))
        }
    }

    private func itemView(section: AppListSectionData, item: AppListItemData) -> some View {
        AppListItem(
            icon: item.icon,
            title: item.title,
            subtitle: item.subtitle,
            trailing: item.trailing,
            showChevron: onItemTap != nil
        ) {
            onItemTap?(section, item)
        }
    }
}
