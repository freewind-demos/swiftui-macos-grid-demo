# SwiftUI macOS Grid 网格布局

## 简介

这个 Demo 演示 SwiftUI 的 **`Grid`**：用 **`GridRow`** 组成行，列方向自动对齐，适合键值列表、简易参数表，以及需要 **`gridCellColumns`** 合并列效果的布局。

## 快速开始

### 环境要求

macOS 14 及以上，**Xcode** 与 **XcodeGen**（`brew install xcodegen`）。建议：

```bash
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

或：

```bash
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
```

### 运行

```bash
xcodegen generate
open SwiftUIGridDemo.xcodeproj
```

命令行构建：

```bash
./scripts/build.sh
```

Release 输出到 `dist/`：

```bash
./scripts/build.sh release
```

## 概念讲解

### 第一部分：Grid 与 GridRow

`Grid` 包裹多行，每一行是一个 `GridRow`，行内多个视图会按列对齐到同一网格里。

```swift
Grid(horizontalSpacing: 16, verticalSpacing: 10) {
    GridRow {
        Text("姓名")
        Text("张三")
    }
}
```

### 第二部分：列对齐

可对单个单元格使用 **`gridColumnAlignment`**，例如标签列右对齐：

```swift
GridRow {
    Text("角色").gridColumnAlignment(.trailing)
    Text("管理员")
}
```

### 第三部分：跨列

某一格需要占多列时，对视图使用 **`gridCellColumns(_:)`**（本 Demo 中占满三列）：

```swift
GridRow {
    Text("说明文字……")
        .gridCellColumns(3)
}
```

## 完整示例

应用入口：

```swift
import SwiftUI

@main
struct GridDemoApp: App {
    var body: some Scene {
        Window("Grid 网格布局", id: "main") {
            ContentView()
        }
        .defaultSize(width: 520, height: 440)
    }
}
```

具体布局与两行示例（基础表、跨列说明）见 `Sources/ContentView.swift`。

## 注意事项

列数由各行中「格子」数量隐式决定；跨列会减少该行视觉上的列数，用 `gridCellColumns` 时确保不超过 `Grid` 隐式总列宽。复杂表格仍可优先考虑 `Table`（macOS 13+）或 `List`；`Grid` 更适合中等复杂度的静态表单排版。

## 完整讲解（中文）

以前用 `HStack` 拼表格，最难的是**上下行文字歪来歪去**，因为每一行的宽度都由内容撑开，没有对齐参考。`Grid` 的作用就是给出隐式列：**同一列里的视图共享一条竖直对齐线**，读起来像真正的表。需要「小标题列右对齐、数值列左对齐」时，用 `gridColumnAlignment` 比手写 `Spacer` 稳定得多。

跨列常见于「一行说明占满宽度」：不必再包一层全宽 `VStack` 打断网格，只要在那一格上声明占几列。若你的数据行列数不一致，要注意每一行逻辑上是否仍满足网格假设，否则会出现空白或挤在一侧的现象；这时可以适当插入空 `Color.clear.frame(width:height:)` 占位，或退回 `Table`/`LazyVGrid` 等更贴数据场景的容器。
