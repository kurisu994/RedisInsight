---
alwaysApply: true
---

# 测试标准与实践

## 核心原则

- **为所有新特性编写测试**
- 遵循 **AAA 模式**：Arrange、Act、Assert
- 使用**具描述性的测试名**：例如 “should do X when Y”
- **关键**：不要使用固定时间等待——测试必须可重复且确定性
- **关键**：使用 faker 库（@faker-js/faker）生成测试数据

## 测试组织

```typescript
describe('FeatureService', () => {
  describe('findById', () => {
    it('should return entity when found', () => {});
    it('should throw NotFoundException when not found', () => {});
  });

  describe('create', () => {
    it('should create entity with valid data', () => {});
    it('should throw error with invalid data', () => {});
  });
});
```

## 前端测试（Jest + Testing Library）

### 关键：始终使用共享的 `renderComponent` 助手

**为每个组件测试文件创建一个 `renderComponent` 助手**：

```typescript
import { faker } from '@faker-js/faker';

describe('MyComponent', () => {
  // 使用 faker 定义默认 props
  const defaultProps: MyComponentProps = {
    id: faker.string.uuid(),
    name: faker.person.fullName(),
    email: faker.internet.email(),
    onComplete: jest.fn(),
  };

  // 共享的渲染助手
  const renderComponent = (propsOverride?: Partial<MyComponentProps>) => {
    const props = { ...defaultProps, ...propsOverride };

    return render(
      <Provider store={store}>
        <MyComponent {...props} />
      </Provider>
    );
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('should render component', () => {
    renderComponent();
    expect(screen.getByText(defaultProps.name)).toBeInTheDocument();
  });

  it('should handle click', async () => {
    const mockOnComplete = jest.fn();
    renderComponent({ onComplete: mockOnComplete });

    fireEvent.click(screen.getByRole('button'));

    await waitFor(() => {
      expect(mockOnComplete).toHaveBeenCalledTimes(1);
    });
  });
});
```

**好处**：

- 集中化设置（providers、路由、主题）
- 默认 props 仅定义一次
- 每个测试可轻松覆盖 props
- 无重复的设置代码

### 复杂组件的设置

对需要 Router、ThemeProvider 等的组件，将它们包含在 `renderComponent` 中：

```typescript
const renderComponent = (propsOverride?: Partial<Props>) => {
  const props = { ...defaultProps, ...propsOverride }

  return render(
    <Provider store={store}>
      <BrowserRouter>
        <ThemeProvider theme={theme}>
          <Component {...props} />
        </ThemeProvider>
      </BrowserRouter>
    </Provider>
  )
}
```

### Redux 相关的测试

对连接 Redux 的组件，使用 `configureStore` 创建测试 store：

```typescript
const createTestStore = (initialState = {}) => {
  return configureStore({
    reducer: { user: userSlice.reducer },
    preloadedState: initialState,
  });
};

const renderComponent = (propsOverride?: Partial<Props>, storeState = {}) => {
  const testStore = createTestStore(storeState);
  // 使用 testStore 渲染
};
```

### 查询优先级（Testing Library）

**优先使用可访问性查询**（与用户交互方式一致）：

```typescript
// ✅ 推荐
screen.getByRole('button', { name: /submit/i });
screen.getByLabelText('Email');
screen.getByPlaceholderText('Enter name');

// ⚠️ 最后手段
screen.getByTestId('user-profile');

// ❌ 避免
wrapper.find('.button-class');
```

### 测试异步行为

```typescript
// ✅ GOOD：使用 waitFor 与正确的查询
await waitFor(() => {
  expect(screen.getByText('Data loaded')).toBeInTheDocument();
});

// ✅ GOOD：使用 waitForElementToBeRemoved
await waitForElementToBeRemoved(() => screen.queryByText('Loading...'));

// ✅ GOOD：使用 findBy 查询（内置等待）
const element = await screen.findByText('Async content');

// ❌ BAD：固定超时（测试不稳定）
await new Promise((resolve) => setTimeout(resolve, 1000));
```

### 模拟 API 调用（MSW）

使用 Mock Service Worker 进行 API 模拟：

```typescript
import { rest } from 'msw';
import { setupServer } from 'msw/node';

const server = setupServer(
  rest.get('/api/users/:id', (req, res, ctx) => {
    return res(
      ctx.json({
        id: req.params.id,
        name: faker.person.fullName(),
      }),
    );
  }),
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());
```

## 后端测试（NestJS/Jest）

### Service 测试模式

```typescript
import { Factory } from 'fishery';
import { faker } from '@faker-js/faker';

// 为 User 实体定义工厂
const userFactory = Factory.define<User>(() => ({
  id: faker.string.uuid(),
  name: faker.person.fullName(),
  email: faker.internet.email(),
}));

describe('UserService', () => {
  let service: UserService;
  let repository: Repository<User>;

  const mockRepository = {
    find: jest.fn(),
    findOne: jest.fn(),
    save: jest.fn(),
    update: jest.fn(),
    delete: jest.fn(),
  };

  beforeEach(async () => {
    const module = await Test.createTestingModule({
      providers: [
        UserService,
        {
          provide: getRepositoryToken(User),
          useValue: mockRepository,
        },
      ],
    }).compile();

    service = module.get<UserService>(UserService);
    repository = module.get<Repository<User>>(getRepositoryToken(User));
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should return user when found', async () => {
    const mockUser = userFactory.build();
    mockRepository.findOne.mockResolvedValue(mockUser);

    const result = await service.findById(mockUser.id);

    expect(result).toEqual(mockUser);
  });
});
```

### Controller 测试模式

```typescript
import { Factory } from 'fishery';
import { faker } from '@faker-js/faker';

const userFactory = Factory.define<User>(() => ({
  id: faker.string.uuid(),
  name: faker.person.fullName(),
  email: faker.internet.email(),
}));

describe('UserController', () => {
  let controller: UserController;
  let service: UserService;

  const mockService = {
    findAll: jest.fn(),
    findById: jest.fn(),
    create: jest.fn(),
  };

  beforeEach(async () => {
    const module = await Test.createTestingModule({
      controllers: [UserController],
      providers: [{ provide: UserService, useValue: mockService }],
    }).compile();

    controller = module.get<UserController>(UserController);
  });

  it('should return user from service', async () => {
    const mockUser = userFactory.build();
    mockService.findById.mockResolvedValue(mockUser);

    const result = await controller.findById(mockUser.id);

    expect(result).toEqual(mockUser);
  });
});
```

### 集成测试（E2E）

```typescript
describe('UserController (e2e)', () => {
  let app: INestApplication;

  beforeAll(async () => {
    const module = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = module.createNestApplication();
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  it('/users (GET)', () => {
    return request(app.getHttpServer())
      .get('/users')
      .expect(200)
      .expect((res) => {
        expect(Array.isArray(res.body)).toBe(true);
      });
  });
});
```

## 端到端测试（Playwright）

```typescript
import { Factory } from 'fishery';
import { faker } from '@faker-js/faker';

const userDataFactory = Factory.define(() => ({
  name: faker.person.fullName(),
  email: faker.internet.email(),
}));

test.describe('User Management', () => {
  test('should create new user', async ({ page }) => {
    const userData = userDataFactory.build();

    await page.goto('/users');
    await page.click('text=Add User');
    await page.fill('[name="name"]', userData.name);
    await page.fill('[name="email"]', userData.email);
    await page.click('text=Submit');

    // ✅ 使用合理的等待
    await expect(page.locator(`text=${userData.name}`)).toBeVisible();
  });
});
```

## 最佳实践

### 始终使用 Faker 生成测试数据

```typescript
// ✅ GOOD：使用 faker
const user = {
  id: faker.string.uuid(),
  name: faker.person.fullName(),
  email: faker.internet.email(),
  age: faker.number.int({ min: 18, max: 100 }),
};

// ❌ BAD：硬编码数据
const user = { id: '123', name: 'Test User' };
```

### 使用工厂替代静态 Mock

**使用 Fishery** 创建具备合理默认值且易覆盖的测试数据工厂：

```typescript
// ✅ GOOD：Fishery 工厂
import { Factory } from 'fishery';
import { faker } from '@faker-js/faker';

const userFactory = Factory.define<User>(({ sequence }) => ({
  id: faker.string.uuid(),
  name: faker.person.fullName(),
  email: faker.internet.email(),
  age: faker.number.int({ min: 18, max: 100 }),
}));

// 用法 —— 灵活且可复用
const user1 = userFactory.build();
const user2 = userFactory.build({ age: 25 });
const user3 = userFactory.build({ name: 'Specific Name' });
const users = userFactory.buildList(5); // 批量创建

// ❌ BAD：静态 Mock 对象
const mockUser1 = {
  id: '123',
  name: 'User 1',
  email: 'user1@test.com',
  age: 30,
};
```

Fishery 工厂的好处：

- 每个测试轻松覆盖特定属性
- 测试之间默认值一致
- Mock 结构的单一可信来源
- 类型变更时更易维护
- 内置序列与特征支持

### 切勿使用固定超时

```typescript
// ❌ BAD：固定超时
await new Promise((resolve) => setTimeout(resolve, 1000));
await page.waitForTimeout(2000);

// ✅ GOOD：等待条件满足
await waitFor(() => {
  expect(element).toBeInTheDocument();
});

await page.waitForSelector('[data-test="result"]');
```

### 模拟外部依赖

```typescript
// ✅ GOOD：模拟服务
jest.mock('uiSrc/services/api', () => ({
  apiService: {
    get: jest.fn(),
    post: jest.fn(),
  },
}));
```

### 测试边界情况

始终测试：

- 空数组/对象
- Null/undefined 值
- 错误场景
- 边界条件
- 加载状态

## 测试检查清单

- [ ] 所有新特性均有测试
- [ ] 测试使用 faker 生成数据
- [ ] 不使用固定超时（使用 waitFor）
- [ ] 测试遵循 AAA 模式
- [ ] 测试名称具描述性
- [ ] 使用共享的 `renderComponent` 助手
- [ ] 默认 props 已定义
- [ ] 边界用例已覆盖
- [ ] 错误场景已测试
- [ ] 模拟在测试间正确清理
- [ ] API 端点有集成测试
- [ ] 关键流程有 E2E 测试
- [ ] 覆盖率达到阈值（80%+）
