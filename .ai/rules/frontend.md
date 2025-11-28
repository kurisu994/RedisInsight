---
alwaysApply: true
---

# 前端开发（React/Redux）

## 组件结构

### 函数组件

- 使用**函数组件与 Hooks**（不使用类组件）
- **优先使用具名导出**，避免默认导出
- 保持组件聚焦、单一职责
- 将复杂逻辑提取为自定义 Hooks

### 组件目录结构

每个组件位于其自身目录 `**/ComponentName` 下：

```
ComponentName/
  ComponentName.tsx          # 主组件
  ComponentName.styles.ts    # styled-components 样式（PascalCase）
  ComponentName.types.ts     # TypeScript 接口
  ComponentName.spec.tsx     # 测试
  ComponentName.constants.ts # 常量
  ComponentName.story.tsx    # Storybook 示例
  hooks/                     # 自定义 Hooks
  components/                # 子组件
  utils/                     # 工具函数
```

### Props 接口

- 命名为 `ComponentNameProps`
- 复杂的 props 对象拆分为独立接口
- 始终使用正确的 TS 类型，避免 `any`

### 组件中的导入顺序

1. 外部依赖（`react`、`redux` 等）
2. 内部模块（别名）
3. 本地导入（types、constants、hooks）
4. 样式（始终最后：`import { Container } from './Component.styles'`）

### Barrel 文件

仅在导出**≥3 个**条目时使用 Barrel 文件（`index.ts`）。确保导出只出现在一个 Barrel 文件中，不要逐层上卷导出。

## styled-components

**我们正在迁移到 styled-components**（弃用 SCSS Modules）。

### 将样式封装到 .styles.ts

使用 styled-components，将所有组件样式放在专用 `.styles.ts` 文件中。文件名使用 PascalCase 与组件名保持一致：

```
ComponentName/
  ComponentName.tsx
  ComponentName.styles.ts  # ✅ PascalCase
  # 不要使用 component-name.styles.ts ❌
```

### 导入模式

```typescript
import { Container, Title, Content } from './Component.styles'

return (
  <Container>
    <Title>Title</Title>
    <Content>Content</Content>
  </Container>
)
```

### 使用布局组件替代 div

在创建 flex 容器时，**优先使用 `FlexGroup`** 而非 `div`：

```typescript
// ✅ GOOD：使用 FlexGroup
import { FlexGroup } from 'uiSrc/components/base/layout/flex'

export const Wrapper = styled(FlexGroup)`
  user-select: none;
`

// 用法：以组件 props 传递布局属性
<Wrapper align="center" justify="end">
  {children}
</Wrapper>

// ❌ BAD：在 div 中硬编码 flex 属性
export const Wrapper = styled.div`
  display: flex;
  align-items: center;
  justify-content: flex-end;
`
```

### 以组件 Props 传递布局属性

在使用布局组件（如 `FlexGroup`）时，**不要在 styled 组件中硬编码布局属性**，应通过 props 传递：

```typescript
// ✅ GOOD：在 JSX 中传递 props
export const Wrapper = styled(FlexGroup)`
  user-select: none;
`

<Wrapper align="center" justify="end">
  {children}
</Wrapper>

// ❌ BAD：在 styled 组件中硬编码
export const Wrapper = styled(FlexGroup)`
  align-items: center;
  justify-content: flex-end;
  user-select: none;
`
```

### 条件样式

对不应透传到 DOM 的瞬态 props 使用 `$` 前缀：

```typescript
export const Button = styled.button<{ $isActive?: boolean }>`
  background-color: ${({ $isActive }) => ($isActive ? '#007bff' : '#6c757d')};
`;
```

### 避免使用 !important

**不要在 styled-components 中使用 `!important`**。styled-components 通过组件层级处理 CSS 特指度；如需覆盖样式，请使用更具体的选择器或调整组件结构：

```typescript
// ✅ GOOD：依赖 CSS 特指度
export const IconButton = styled(IconButton)<{ isOpen: boolean }>`
  ${({ isOpen }) =>
    isOpen &&
    css`
      background-color: ${({ theme }) =>
        theme.semantic.color.background.primary200};
    `}
`;

// ❌ BAD：使用 !important
export const IconButton = styled(IconButton)`
  background-color: ${({ theme }) =>
    theme.semantic.color.background.primary200} !important;
`;
```

### 校验类型系统兼容性

在使用布局组件或其他带类型的组件时，确保你的 props 值符合类型系统定义：

```typescript
// 查看组件的类型定义
// FlexGroup 接受：align?: 'center' | 'stretch' | 'baseline' | 'start' | 'end'
// 使用类型系统中的有效值
```

## 状态管理（Redux）

### 何时使用哪种状态

- **全局状态（Redux）**：

  - 在多个组件之间共享的数据
  - 跨路由持久的数据
  - 服务器状态（API 数据）
  - 用户偏好/设置

- **本地状态（useState）**：

  - UI 状态（模态框、下拉、选项卡）
  - 提交前的表单输入
  - 组件特有的临时数据

- **派生状态（Selectors）**：
  - 来自 Redux 状态的计算值
  - 过滤/排序后的列表
  - 聚合数据

### Redux Toolkit 模式

#### Slice 结构

- 使用 Redux Toolkit 的 `createSlice`
- 为 state 定义合适的 TypeScript 类型
- 使用 `PayloadAction<T>` 进行 action 类型标注
- 通过 `extraReducers` 与 thunks 处理异步

#### Thunk

- 使用 `createAsyncThunk` 处理异步操作
- 正确处理 pending/fulfilled/rejected 状态
- 使用 `rejectWithValue` 进行错误处理

#### Selector

- 创建基础选择器以直接访问状态
- 使用 `reselect` 的 `createSelector` 获取 memo 化/计算值
- 将选择器放在独立的 `selectors.ts` 文件中

## React 最佳实践

### 性能

- 对作为 props 传递的函数使用 `useCallback`
- 对开销较大的计算使用 `useMemo`
- 对开销较大的组件使用 `React.memo`
- 避免在 JSX props 中使用内联箭头函数

### Effect 清理

始终在 `useEffect` 的返回函数中清理订阅、定时器与事件监听。

### 列表中的 Key

- 使用唯一且稳定的 ID（不要使用数组索引）
- 仅在列表永不重排且项没有 ID 时使用索引

### 条件渲染

- 针对加载/错误状态使用早返回
- 避免深度嵌套三元表达式——提取为函数

## 自定义 Hooks

### 提取可复用逻辑

为可复用的有状态逻辑创建自定义 Hooks。将组件特有的 Hooks 存放在组件的 `/hooks` 目录。

## 表单处理

使用 Formik + Yup 进行校验。复杂表单将逻辑封装在自定义 Hooks 中。

## UI 组件

**⚠️ 重要**：

- 我们正在**弃用 Elastic UI** 组件
- 迁移到 **Redis UI**（`@redis-ui/*`）
- **使用内部封装**（`uiSrc/components/ui`）
- **不要直接从** `@redis-ui/*` **导入**

### 组件使用

```typescript
// ✅ GOOD：从内部封装导入
import { Button, Input, FlexGroup } from 'uiSrc/components/ui';

// ❌ BAD：不要直接从 @redis-ui 导入
import { Button } from '@redis-ui/components';

// ❌ DEPRECATED：新代码不要使用 Elastic UI
import { EuiButton } from '@elastic/eui';
```

### 迁移指南

- ✅ 新功能全部使用 `uiSrc/components/ui` 的内部封装
- ✅ 按需为 Redis UI 组件创建内部封装
- ✅ 修改既有代码时替换 Elastic UI
- ❌ 不要直接从 `@redis-ui/*` 导入
- ❌ 不要新增 Elastic UI 导入

## 组件测试

### 始终使用共享的 `renderComponent` 助手

**关键**：每个组件测试文件创建一个 `renderComponent` 助手函数：

```typescript
describe('MyComponent', () => {
  const defaultProps: MyComponentProps = {
    id: faker.string.uuid(),
    name: faker.person.fullName(),
    onComplete: jest.fn(),
  }

  const renderComponent = (propsOverride?: Partial<MyComponentProps>) => {
    const props = { ...defaultProps, ...propsOverride }

    return render(
      <Provider store={store}>
        <MyComponent {...props} />
      </Provider>
    )
  }

  it('should render', () => {
    renderComponent()
    // 断言
  })
})
```

好处：

- 集中化的设置与 Providers
- 默认 props 统一定义
- 每个测试轻松覆盖 props
- 无重复的渲染逻辑

### 测试 Redux

对连接 Redux 的组件，使用 `configureStore` 创建测试 store。

## 关键原则

1. **关注点分离**：样式、类型、常量、逻辑分离
2. **就近放置相关代码**：子组件与 Hooks 靠近使用处
3. **命名一致**：在所有组件中遵循统一约定
4. **类型安全**：始终定义正确类型，避免 `any`
5. **可测试性**：结构化以便使用 `renderComponent` 辅助测试
6. **styled-components**：优先使用 styled-components，弃用 SCSS Modules
7. **布局组件**：使用 FlexGroup 替代 div 构建 flex 容器，并以组件 props 传递布局属性
8. **类型安全**：校验 props 值与组件类型定义一致（如 FlexGroup 的 align/justify）
