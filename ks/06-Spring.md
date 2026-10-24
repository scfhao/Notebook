題目背景
你正在開發一個「用戶管理系統」，使用 Spring Boot 3.x，需整合以下技術：
Spring Data JPA：操作 PostgreSQL 資料庫中的 users 表。
Spring Security + JWT：實現登入認證與授權（只有 ADMIN 角色可刪除用戶）。
Spring Cache（Redis）：將使用者查詢結果快取至 Redis，減少資料庫壓力。
請在程式碼中的 ______（填空1） 至 ______（填空10） 處填入正確的程式碼片段。

一、專案依賴配置（pom.xml）
<dependencies>
    <!-- Spring Boot Starter Web -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <!-- Spring Boot Starter Data JPA -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>______（填空1）</artifactId>
    </dependency>
    <!-- PostgreSQL Driver -->
    <dependency>
        <groupId>org.postgresql</groupId>
        <artifactId>postgresql</artifactId>
    </dependency>
    <!-- Spring Security -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-security</artifactId>
    </dependency>
    <!-- Spring Cache + Redis -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>______（填空2）</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-redis</artifactId>
    </dependency>
</dependencies>
二、實體與 Repository
// entity/User.java
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String username;
    private String password;
    private String role;
    private String email;
    // getters/setters 省略
}

// repository/UserRepository.java
public interface UserRepository extends JpaRepository<User, Long> {
    // 填空3：根據 username 查詢使用者（JPA 方法命名規則）
    Optional<User> findBy______（填空3）(String username);
}
三、JWT 工具類（解析 Token）
// utils/JwtUtil.java
@Component
public class JwtUtil {
    @Value("${jwt.secret}")
    private String secret;
    
    public String generateToken(String username) { ... }
    
    // 填空4：從請求中提取 JWT Token（去除 "Bearer " 前綴）
    public String resolveToken(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            return ______（填空4）;
        }
        return null;
    }
}
四、Spring Cache 整合（Redis）
// service/UserService.java
@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    
    // 填空5：使用 Spring Cache 快取 getUserById 的結果，快取名稱為 "users"
    @Cacheable(value = "______（填空5）", key = "#id")
    public User getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }
    
    // 填空6：當更新使用者時，清除快取中對應的用戶資料
    @______（填空6）(value = "users", key = "#user.id")
    public User updateUser(User user) {
        return userRepository.save(user);
    }
}
五、認證控制器
// controller/AuthController.java
@RestController
@RequestMapping("/api/auth")
public class AuthController {
    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private JwtUtil jwtUtil;
    
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        // 填空7：使用 AuthenticationManager 進行認證
        Authentication authentication = authenticationManager.authenticate(
            new UsernamePasswordAuthenticationToken(request.getUsername(), ______（填空7）)
        );
        String token = jwtUtil.generateToken(request.getUsername());
        return ResponseEntity.ok(new JwtResponse(token));
    }
}
六、使用者控制器
// controller/UserController.java
@RestController
@RequestMapping("/api/users")
public class UserController {
    @Autowired
    private UserService userService;
    
    @GetMapping("/{id}")
    public User getUser(@PathVariable Long id) {
        // 填空8：呼叫 userService 的 getUserById 方法
        return ______（填空8）;
    }
}
七、MyBatis-Plus 替代方案（選答）
若專案不使用 JPA 而改用 MyBatis-Plus，需要更換依賴。請寫出 MyBatis-Plus 的依賴座標。

xml
<dependency>
    <groupId>______（填空9）</groupId>
    <artifactId>mybatis-plus-boot-starter</artifactId>
    <version>3.5.5</version>
</dependency>
八、Redis 連線配置
在 application.yml 中配置 Redis 連線：

yaml
spring:
  redis:
    host: localhost
    port: ______（填空10）

---

填空1：spring-boot-starter-data-jpa
填空2：spring-boot-starter-cache
填空3：Username
填空4：bearerToken.substring(7)
填空5："users"
填空6：@CacheEvict
填空7：request.getPassword()
填空8：userService.getUserById(id)
填空9：com.baomidou
填空10：6379

首次作答：
1. spring-boot-starter-data-jpa
2. spring-boot-starter-cache
3. Username
4. bearerToken.substring(7, bearerToken.length())
5. users
6. 
7. 
8. userService.getUserById(id)
9. 
10.5432

@CacheEvict
request.getPassword()
com.baomidou
6379