import SwiftUI
import AppKit // Для доступа к NSColor

struct AppColors {
    static let background = Color.white // Белый фон окна
    static let cardBackground = Color(NSColor.controlBackgroundColor).opacity(0.8) // Более темный фон для блоков/карточек
    static let primaryText = Color.black // Основной цвет текста
    static let secondaryText = Color.gray // Второстепенный цвет текста
    static let accentBlue = Color.blue // Акцентный синий
    static let accentRed = Color.red // Акцентный красный (для кнопки выхода)
    static let border = Color.gray.opacity(0.3) // Цвет границы или разделителя
    static let resultFieldBackground = Color(NSColor.controlBackgroundColor).opacity(0.8) // Фон для полей с результатами
}

// Дополнительные расширения или компоненты дизайн-системы можно добавить здесь 