---
alwaysApply: true
---

# 后端开发（NestJS/API）

## 模块结构

### NestJS 架构

- 遵循**模块化架构**（按特性拆分模块）
- 全面使用**依赖注入**
- **关注点分离**：Controller、Service、Repository
- 使用 **DTO** 进行校验与数据传输
- 使用 NestJS 异常进行**规范的错误处理**

### 模块目录结构

每个特性模块放在 `api/src/` 下独立目录：

```
feature/
├── feature.module.ts           # 模块定义
├── feature.controller.ts       # REST 端点
├── feature.service.ts          # 业务逻辑
├── feature.service.spec.ts     # Service 测试
├── feature.controller.spec.ts  # Controller 测试
├── feature.types.ts            # 与特性相关的接口与类型
├── dto/                        # 数据传输对象
│   ├── create-feature.dto.ts
│   ├── update-feature.dto.ts
│   └── feature.dto.ts
├── entities/                   # TypeORM 实体
├── repositories/               # 自定义仓库
├── exceptions/                 # 自定义异常
├── guards/                     # 特性相关的守卫
├── decorators/                 # 自定义装饰器
└── constants/                  # 特性常量
```

### 文件命名

- **模块**：`feature.module.ts`
- **控制器**：`feature.controller.ts`
- **服务**：`feature.service.ts`
- **DTO**：`create-feature.dto.ts`、`update-feature.dto.ts`
- **实体**：`feature.entity.ts`
- **接口与类型**：`feature.types.ts`
- **测试**：`feature.service.spec.ts`
- **常量**：`feature.constants.ts`
- **异常**：`feature-not-found.exception.ts`

### 常量组织

将特性相关常量存放在专用的常量文件中：

```typescript
export const FEATURE_CONSTANTS = {
  MAX_NAME_LENGTH: 100,
  DEFAULT_PAGE_SIZE: 20,
} as const;

export const FEATURE_ERROR_MESSAGES = {
  NOT_FOUND: 'Feature not found',
  INVALID_INPUT: 'Invalid feature data',
} as const;
```

### 导入顺序

1. Node.js 内置模块
2. 外部依赖（`@nestjs/*` 等）
3. 内部模块（使用 `apiSrc/*` 别名）
4. 本地相对导入

## 服务层

### 服务模式

- 通过构造函数注入依赖
- 使用 TypeORM 仓库
- 使用 NestJS 异常处理错误
- 对关键操作使用 Logger
- 将业务逻辑放在服务层（不要放在控制器）

### 依赖注入

通过构造函数并使用正确装饰器进行依赖注入：

```typescript
@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    private readonly emailService: EmailService,
  ) {}
}
```

## 控制器层

### 控制器模式

- 控制器保持“瘦身”（委托给服务）
- 使用正确的 HTTP 装饰器（`@Get`、`@Post` 等）
- 输入使用 `@Body`、`@Param`、`@Query`
- 通过 `@UseGuards()` 应用守卫
- 使用 Swagger 装饰器进行文档化

### HTTP 状态码

- 对非标准状态码使用 `@HttpCode()` 装饰器
- 返回恰当的状态码（200、201、204、400、404 等）

## 数据传输对象（DTO）

### 校验

使用 `class-validator` 装饰器进行校验：

- `@IsString()`、`@IsNumber()`、`@IsEmail()`
- `@IsNotEmpty()`、`@IsOptional()`
- `@MinLength()`、`@MaxLength()`
- `@Min()`、`@Max()`

### Swagger 文档

使用 `@ApiProperty()` 与 `@ApiPropertyOptional()` 进行 Swagger 文档编制。

## 错误处理

### NestJS 异常

使用合适的异常类型：

- `NotFoundException` - 404
- `BadRequestException` - 400
- `UnauthorizedException` - 401
- `ForbiddenException` - 403
- `ConflictException` - 409
- `InternalServerErrorException` - 500

### 错误日志

```typescript
private readonly logger = new Logger(ServiceName.name)

this.logger.error('Error message', error.stack, { context })
```

## Redis 集成

### Redis 服务模式

- 使用 `apiSrc/modules/redis` 中的 RedisClient
- 优雅地处理错误
- 记录 Redis 操作日志
- 使用 try-catch 进行错误处理

## 代码质量

### 认知复杂度（≤ 15）

- 使用早返回减少嵌套
- 将复杂逻辑提取为独立函数
- 避免深度嵌套条件

### 避免重复字符串

将重复字符串提取到常量文件。

## API 文档（Swagger）

### 必需装饰器

- `@ApiTags()` —— 分组端点
- `@ApiOperation()` —— 描述操作
- `@ApiResponse()` —— 文档化响应
- `@ApiParam()` —— 文档化路径参数
- `@ApiQuery()` —— 文档化查询参数
- `@ApiBearerAuth()` —— 鉴权要求

## 清单

- [ ] 服务层使用依赖注入
- [ ] DTO 配有校验装饰器
- [ ] 控制器具备 Swagger 文档
- [ ] 正确使用 HTTP 状态码
- [ ] 使用合适的异常进行错误处理
- [ ] 对重要操作进行日志记录
- [ ] 相关数据库操作使用事务
- [ ] 通过 ConfigService 进行配置
- [ ] 为认证/鉴权使用守卫
- [ ] 认知复杂度 ≤ 15
