import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("SwiftUI Grid：按列对齐的表格状布局，适合键值行、简易数据表。")
                    .font(.caption)
                    .foregroundColor(.secondary)

                GroupBox("基础：多行 GridRow，同列自动对齐") {
                    Grid(horizontalSpacing: 16, verticalSpacing: 10) {
                        GridRow {
                            Text("姓名").gridColumnAlignment(.trailing)
                            Text("张三").bold()
                        }
                        GridRow {
                            Text("角色").gridColumnAlignment(.trailing)
                            Text("管理员")
                        }
                        GridRow {
                            Text("状态").gridColumnAlignment(.trailing)
                            Label("在线", systemImage: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }

                GroupBox("跨列：GridCell + columnSpan") {
                    Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 8) {
                        GridRow {
                            Text("标题")
                            Text("数值")
                            Text("说明")
                        }
                        .font(.headline)

                        GridRow {
                            Text("CPU")
                            Text("68 %")
                            Text("当前负载")
                        }
                        GridRow {
                            Text("本行占满三列，适合做分隔说明或合并单元格效果。")
                                .gridCellColumns(3)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.vertical, 4)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
