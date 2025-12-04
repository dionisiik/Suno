# Паттерны и решения для SwiftUI

## Проблема: Один экран для двух состояний с разными элементами дизайна

### Описание проблемы

Когда нужно создать один экран, который должен отображать разные UI элементы в зависимости от состояния (например, Pro vs Free пользователь), возникает несколько проблем:

1. **Дублирование кода** - создание двух отдельных файлов (`CreatingMusicView` и `CreatingMusicViewFree`) приводит к дублированию большого количества кода
2. **Сложность поддержки** - изменения нужно вносить в двух местах
3. **Несоответствие типов** - при использовании тернарных операторов (`? :`) могут возникать ошибки компиляции, если типы не совпадают (например, `LinearGradient` vs `Color`)
4. **Отсутствие реактивности** - при изменении состояния экран не обновляется автоматически

### Решение

#### 1. Использование computed property для определения состояния

```swift
struct CreatingMusicView: View {
    @EnvironmentObject var appState: AppState
    
    // Computed property для удобного доступа к статусу
    private var isPro: Bool {
        appState.user.isPro
    }
    
    var body: some View {
        // UI код
    }
}
```

**Преимущества:**
- Единая точка доступа к статусу
- Автоматическое обновление при изменении `appState.user.isPro`
- Чистый и читаемый код

#### 2. Условное отображение секций с помощью `if`

```swift
ScrollView {
    VStack(spacing: 24) {
        // Общие секции
        animationSection
        titleSection
        yourPromptSection
        
        // Условные секции
        if isPro {
            activeProBenefitsSection  // Только для Pro
        }
        
        queuePositionSection
        generationProgressSection
        
        // Еще условные секции
        if !isPro {
            watermarkNoticeSection    // Только для Free
            proVsFreeSection
            skipTheWaitSection
        }
    }
}
```

**Преимущества:**
- Четкое разделение логики
- Легко добавлять/удалять секции
- Нет дублирования кода

#### 3. Условные значения в секциях

```swift
private var queuePositionSection: some View {
    VStack(spacing: 12) {
        HStack {
            // ...
            Text(isPro ? "Instant processing" : "Free tier processing")
                .font(.system(size: 12))
            
            // Условное отображение элементов
            if !isPro {
                VStack {
                    Text("#\(queuePosition)")
                    Text("of \(queueTotal)")
                }
            }
        }
        
        // Условный прогресс-бар
        if !isPro {
            GeometryReader { geometry in
                // Прогресс-бар
            }
        }
    }
}
```

#### 4. Решение проблемы несоответствия типов

**Проблема:**
```swift
// ❌ Ошибка: Result values in '? :' expression have mismatching types 'LinearGradient' and 'Color'
.fill(isPro ? AppGradients.redOrange : Color(red: 0.820, green: 0.835, blue: 0.859))
```

**Решение 1: Обернуть Color в LinearGradient**
```swift
// ✅ Оба значения имеют тип LinearGradient
.fill(
    isPro 
    ? AppGradients.redOrange 
    : LinearGradient(
        colors: [Color(red: 0.820, green: 0.835, blue: 0.859)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
)
```

**Решение 2: Использовать AnyShapeStyle (если поддерживается)**
```swift
.fill(
    isPro 
    ? AnyShapeStyle(AppGradients.redOrange) 
    : AnyShapeStyle(Color(red: 0.820, green: 0.835, blue: 0.859))
)
```

#### 5. Управление таймерами и побочными эффектами

```swift
Button(action: {
    // Переключаем статус
    appState.user.isPro.toggle()
    
    // Управляем таймерами в зависимости от нового статуса
    if appState.user.isPro {
        stopQueueTimer()  // Pro не нужен таймер очереди
    } else {
        startQueueTimer() // Free нужен таймер очереди
    }
}) {
    Text(isPro ? "PRO" : "Upgrade")
}
```

**Важно:** Всегда управляйте таймерами, анимациями и другими побочными эффектами при изменении состояния.

#### 6. Структура файла

```swift
struct CreatingMusicView: View {
    // MARK: - Properties
    @EnvironmentObject var appState: AppState
    @State private var someState: SomeType
    
    // MARK: - Computed Properties
    private var isPro: Bool {
        appState.user.isPro
    }
    
    // MARK: - Body
    var body: some View {
        // Основной UI с условной логикой
    }
    
    // MARK: - Sections
    private var commonSection: some View {
        // Общие секции
    }
    
    private var proOnlySection: some View {
        // Только для Pro
    }
    
    private var freeOnlySection: some View {
        // Только для Free
    }
    
    // MARK: - Helper Functions
    private func someHelperFunction() {
        // Вспомогательные функции
    }
}
```

### Лучшие практики

1. **Используйте computed properties** для определения состояния вместо прямого доступа к `appState.user.isPro` в каждом месте
2. **Группируйте условную логику** - лучше один большой `if` блок, чем множество маленьких
3. **Документируйте условные секции** комментариями для ясности
4. **Тестируйте оба состояния** - убедитесь, что UI корректно работает в обоих случаях
5. **Управляйте ресурсами** - останавливайте таймеры, анимации при изменении состояния
6. **Избегайте дублирования** - выносите общие части в отдельные функции/секции

### Пример из проекта

**До (два файла):**
- `CreatingMusicView.swift` - 973 строки
- `CreatingMusicViewFree.swift` - 1199 строк
- **Итого:** 2172 строки с большим дублированием

**После (один файл):**
- `CreatingMusicView.swift` - 1331 строка
- **Экономия:** ~841 строка кода
- **Преимущества:** единая точка поддержки, автоматическое обновление UI, меньше ошибок

### Типичные ошибки и их решения

#### Ошибка 1: Несоответствие типов в тернарном операторе
```swift
// ❌ Ошибка
.background(isPro ? AppGradients.redOrange : Color.white)

// ✅ Решение
.background(
    isPro 
    ? AppGradients.redOrange 
    : LinearGradient(colors: [Color.white], startPoint: .top, endPoint: .bottom)
)
```

#### Ошибка 2: Забыли управлять таймерами
```swift
// ❌ Проблема: таймер продолжает работать после изменения статуса
Button(action: {
    appState.user.isPro.toggle()
}) { ... }

// ✅ Решение: управляем таймерами
Button(action: {
    appState.user.isPro.toggle()
    if appState.user.isPro {
        stopQueueTimer()
    } else {
        startQueueTimer()
    }
}) { ... }
```

#### Ошибка 3: Прямой доступ к appState вместо computed property
```swift
// ❌ Менее читаемо
if appState.user.isPro { ... }

// ✅ Лучше
private var isPro: Bool {
    appState.user.isPro
}
// Использование
if isPro { ... }
```

### Заключение

Использование одного экрана для двух состояний с условной логикой - это мощный паттерн, который:
- Уменьшает дублирование кода
- Упрощает поддержку
- Обеспечивает автоматическое обновление UI
- Делает код более читаемым и структурированным

Ключевые моменты:
1. Используйте `@EnvironmentObject` для доступа к состоянию
2. Создавайте computed properties для удобного доступа
3. Используйте условные блоки `if` для отображения разных секций
4. Решайте проблемы с типами, оборачивая значения в общий тип
5. Управляйте побочными эффектами (таймеры, анимации) при изменении состояния

