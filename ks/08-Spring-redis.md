場景描述：你需要開發一個電商訂單系統的後端核心模組。該模組需要處理用戶下單請求，利用 Redis 分散式鎖防止重複下單，使用 JWT 進行身份驗證，並將訂單數據持久化到 PostgreSQL。請補充以下代碼中的 ____ 處：

1.統一 API 回應格式與錯誤碼定義：
```java
@Data
public class Result<T> {
    private Integer code;
    private String message;
    private T data;

    // 1. 定義統一的成功響應靜態方法
    public static <T> Result<T> success(T data) {
        Result<T> result = new Result<>();
        result.setCode(200);
        result.setMessage("操作成功");
        result.____(data);
        return result;
    }
}

public enum ErrorCode {
    SUCCESS(200, "成功"),
    // 2. 定義未授權的錯誤碼枚舉實例
    UNAUTHORIZED(401, "____");
    
    private final Integer code;
    private final String message;
    ErrorCode(Integer code, String message) {
        this.code = code;
        this.message = message;
    }
}
```

2.Spring Security 與 JWT 過濾器配置：

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
            .authorizeRequests()
            .antMatchers("/api/auth/login").permitAll()
            // 3. 其他所有請求都需要經過身份認證
            .anyRequest().____()
            .and()
            // 4. 配置前後端分離的無狀態會話策略
            .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.____);
    }
}

public class JwtAuthenticationFilter extends OncePerRequestFilter {
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) {
        String token = request.getHeader("Authorization");
        if (token != null && token.startsWith("Bearer ")) {
            String username = jwtUtil.parseToken(token.substring(7));
            // 5. 將解析出的用戶身份封裝並設置到 Spring Security 上下文中
            SecurityContextHolder.getContext().set____(authentication);
        }
        filterChain.doFilter(request, response);
    }
}
```
3.Redis 分散式鎖與快取整合：

```java
@Service
public class OrderService {
    @Autowired
    private StringRedisTemplate redisTemplate;
    @Autowired
    private OrderMapper orderMapper;

    @Transactional
    public Result<String> createOrder(Order order) {
        String lockKey = "order:lock:" + order.getUserId();
        // 6. 嘗試獲取 Redis 分散式鎖（SETNX），防止用戶重複點擊下單
        Boolean locked = redisTemplate.opsForValue().____(lockKey, "1", 10, TimeUnit.SECONDS);
        
        if (Boolean.TRUE.equals(locked)) {
            try {
                orderMapper.insert(order); // 保存訂單到 PostgreSQL
                return Result.success("下單成功");
            } finally {
                // 7. 業務執行完畢後釋放分散式鎖
                redisTemplate.____(lockKey);
            }
        }
        return Result.error("系統繁忙，請稍後再試");
    }

    // 8. 使用 Spring Cache 註解快取訂單詳情，減少數據庫查詢壓力
    @____(value = "orders", key = "#id")
    public Order getOrderDetail(Long id) {
        return orderMapper.selectById(id);
    }
}
```

4.JPA/MyBatis-Plus 實體與 Swagger 文件配置：

```java
@Entity
____// 9. JPA 註解：指定該實體類對應 PostgreSQL 中的表名
@Data
public class Order {
    @Id
    private Long id;
    private Long userId;
    private BigDecimal amount;
}

@Configuration
@____ // 10. 啟用 Swagger/Knife4j 自動生成 API 接口文件
public class SwaggerConfig {
    @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.SWAGGER_2).select().build();
    }
}
```
---

1. setData
2. "未授權"
3. authenticated()
4. STATELESS
5. Authentication
6. setIfAbsent
7. delete
8. @Cacheable
9. @Table
10. @EnableSwagger2WebMvc

首次作答：

1. setData
2. 未授權
3. process
4. None
5. User
6. setNx
7. delete
8. Cacheable
9. @Table("orders")
10. Swagger