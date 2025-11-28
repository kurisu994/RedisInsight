---
alwaysApply: true
---

# 代码质量标准

## 关键规则

- **每次改动后都运行 Linter**：`yarn lint`
- 在提交前必须通过 Linter
- 生产代码中不允许 `console.log`（仅允许 `console.warn/error`）

## TypeScript 规范

### 基本规则

- 所有新代码使用 TypeScript
- **避免使用 `any`** —— 使用正确类型或 `unknown`
- **对象结构优先使用 interface**
- 联合、交叉、基础类型优先使用 **type**
- 非显而易见的函数添加显式返回类型
- 在明确情况下使用类型推断

## 导入组织

### 必需顺序（由 ESLint 强制）

1. 外部库（`react`、`lodash` 等）
2. Node 内置模块（`path`、`fs` —— 仅后端）
3. 使用别名的内部模块（`uiSrc/*`、`apiSrc/*`）
4. 同级/父级相对导入
5. 样式导入（始终最后）

### 模块别名

- `uiSrc/*` → `redisinsight/ui/src/*`
- `apiSrc/*` → `redisinsight/api/src/*`
- `desktopSrc/*` → `redisinsight/desktop/src/*`

✅ **使用别名**：`import { Button } from 'uiSrc/components/Button'`  
❌ **避免相对路径层层上跳**：`import { Button } from '../../../ui/src/components/Button'`

## 命名约定

- **组件**：`PascalCase` —— `UserProfile`
- **函数/变量**：`camelCase` —— `fetchUserProfile`
- **常量**：`UPPER_SNAKE_CASE` —— `MAX_RETRY_ATTEMPTS`
- **布尔值**：使用 `is/has/should` 前缀 —— `isLoading`、`hasError`

## SonarJS 规则

- 降低认知复杂度（重构复杂函数）
- 将重复字符串提取为常量
- 遵循 DRY 原则 —— 不要重复代码
- 使用即时返回（避免不必要的中间变量）

## 最佳实践

- 对对象与数组使用解构
- 使用模板字符串而非拼接
- 默认使用 `const`，仅在需要重赋值时使用 `let`
- 使用具描述性的变量名
- 正确处理错误
- 清理订阅与定时器
- 使用常量替代魔法数字

## 提交前检查清单

- [ ] `yarn lint` 通过
- [ ] 无 TypeScript 错误
- [ ] 导入顺序正确
- [ ] 无无故使用 `any`
- [ ] 无 `console.log`
- [ ] 无魔法数字
- [ ] 变量命名具可读性
- [ ] 认知复杂度低
- [ ] 无重复代码
