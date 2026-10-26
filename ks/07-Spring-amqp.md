題目背景
你需開發一個「訂單處理系統」，使用 Spring Boot。訂單提交後需要執行以下操作：
使用 Redis 分散式鎖 扣減庫存（避免超賣）
將訂單訊息發送到 RabbitMQ 佇列，非同步處理後續流程
將訂單附件（例如發票圖片）上傳至 MinIO 物件儲存
發送訂單確認 郵件 給使用者（使用 JavaMail）
請在標示 ______（填空1） 至 ______（填空10） 處填入正確的程式碼片段。

一、專案依賴（pom.xml）
xml
<dependencies>
    <!-- Spring Boot Starter Web -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <!-- Spring Boot Starter Data Redis -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>______（填空1）</artifactId>
    </dependency>
    <!-- Spring Boot Starter AMQP (RabbitMQ) -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>______（填空2）</artifactId>
    </dependency>
    <!-- MinIO 用戶端 -->
    <dependency>
        <groupId>io.minio</groupId>
        <artifactId>minio</artifactId>
        <version>8.5.7</version>
    </dependency>
    <!-- Spring Boot Starter Mail -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>______（填空3）</artifactId>
    </dependency>
</dependencies>
二、Redis 分散式鎖（扣減庫存）

```JAVA
// service/InventoryService.java
@Service
public class InventoryService {
    @Autowired
    private StringRedisTemplate redisTemplate;
    
    // 填空4：使用 Redis 分散式鎖，鎖定 key = "lock:product:" + productId，過期時間 5 秒
    public boolean deductStock(Long productId, int quantity) {
        String lockKey = "lock:product:" + productId;
        String requestId = UUID.randomUUID().toString();
        // 嘗試取得鎖（SET NX EX）
        Boolean locked = redisTemplate.opsForValue()
            .setIfAbsent(lockKey, requestId, Duration.ofSeconds(5));
        if (Boolean.TRUE.equals(locked)) {
            try {
                // 扣減庫存邏輯...
                return true;
            } finally {
                // 釋放鎖（需驗證 requestId）
                String script = "if redis.call('get', KEYS[1]) == ARGV[1] then return redis.call('del', KEYS[1]) else return 0 end";
                redisTemplate.execute(new DefaultRedisScript<>(script, Long.class), 
                    Collections.singletonList(lockKey), requestId);
            }
        }
        return false;
    }
}
```

填空4 已給出程式碼，無需填空。改為要求補齊 setIfAbsent 的參數（過期時間）。此處填空4 改為：
```Java
Boolean locked = redisTemplate.opsForValue()
    .setIfAbsent(lockKey, requestId, ______（填空4）);
```
需填入 Duration.ofSeconds(5) 或 5, TimeUnit.SECONDS。

三、RabbitMQ 非同步訊息

```Java
// config/RabbitMQConfig.java
@Configuration
public class RabbitMQConfig {
    public static final String ORDER_QUEUE = "order.queue";
    public static final String ORDER_EXCHANGE = "order.exchange";
    
    @Bean
    public Queue orderQueue() {
        return new Queue(ORDER_QUEUE, true);
    }
    
    @Bean
    public DirectExchange orderExchange() {
        return new DirectExchange(ORDER_EXCHANGE);
    }
    
    @Bean
    public Binding binding() {
        return BindingBuilder.bind(orderQueue()).to(orderExchange()).with("order.created");
    }
}

// service/OrderMessageSender.java
@Service
public class OrderMessageSender {
    @Autowired
    private RabbitTemplate rabbitTemplate;
    
    public void sendOrderCreatedMessage(Long orderId) {
        // 填空5：發送訊息到交換器，路由鍵為 "order.created"，內容為 orderId
        rabbitTemplate.convertAndSend(
            RabbitMQConfig.ORDER_EXCHANGE, 
            ______（填空5a）, 
            ______（填空5b）
        );
    }
}
```
四、MinIO 物件儲存（上傳附件）
```yaml
# application.yml
minio:
  endpoint: http://localhost:9000
  accessKey: minioadmin
  secretKey: minioadmin
  bucket: order-attachments
```

```java
// config/MinioConfig.java
@Configuration
public class MinioConfig {
    @Value("${minio.endpoint}")
    private String endpoint;
    @Value("${minio.accessKey}")
    private String accessKey;
    @Value("${minio.secretKey}")
    private String secretKey;
    
    @Bean
    public MinioClient minioClient() {
        return MinioClient.builder()
            .endpoint(endpoint)
            .credentials(accessKey, secretKey)
            .build();
    }
}

// service/FileUploadService.java
@Service
public class FileUploadService {
    @Autowired
    private MinioClient minioClient;
    @Value("${minio.bucket}")
    private String bucketName;
    
    // 填空6：上傳檔案至 MinIO，並回傳檔案 URL
    public String uploadFile(MultipartFile file, String objectName) throws Exception {
        boolean bucketExists = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build());
        if (!bucketExists) {
            minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucketName).build());
        }
        minioClient.putObject(
            PutObjectArgs.builder()
                .bucket(bucketName)
                .object(objectName)
                .stream(file.getInputStream(), file.getSize(), -1)
                .contentType(file.getContentType())
                .build()
        );
        // 填空6：回傳檔案公開 URL
        return ______（填空6）;
    }
}
```
五、郵件服務（JavaMail）
```yaml
# application.yml
spring:
  mail:
    host: smtp.gmail.com
    port: 587
    username: your-email@gmail.com
    password: your-password
    properties:
      mail.smtp.auth: true
      mail.smtp.starttls.enable: true
```

```java
// service/EmailService.java
@Service
public class EmailService {
    @Autowired
    private JavaMailSender mailSender;
    
    // 填空7：發送郵件
    public void sendOrderConfirmation(String to, String orderId) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject("訂單確認");
        message.setText("您的訂單 " + orderId + " 已建立成功。");
        ______（填空7）;
    }
}
```
六、訂單服務整合（完整流程）

```java
// service/OrderService.java
@Service
public class OrderService {
    @Autowired
    private InventoryService inventoryService;
    @Autowired
    private OrderMessageSender messageSender;
    @Autowired
    private FileUploadService fileUploadService;
    @Autowired
    private EmailService emailService;
    
    // 填空8：處理訂單提交（模擬 Controller 呼叫此方法）
    @Transactional
    public void createOrder(OrderRequest request, MultipartFile attachment) throws Exception {
        // 1. 扣減庫存（使用 Redis 分散式鎖）
        boolean deducted = inventoryService.deductStock(request.getProductId(), request.getQuantity());
        if (!deducted) {
            throw new RuntimeException("庫存不足或系統繁忙");
        }
        
        // 2. 儲存訂單至資料庫（略）
        Long orderId = 1001L;
        
        // 3. 上傳附件至 MinIO
        String fileUrl = ______（填空8a）(attachment, "order/" + orderId + "_receipt.jpg");
        
        // 4. 發送 RabbitMQ 非同步訊息
        ______（填空8b）.sendOrderCreatedMessage(orderId);
        
        // 5. 發送郵件
        emailService.sendOrderConfirmation(request.getEmail(), orderId.toString());
    }
}
```
七、額外考點：分散式鎖正確釋放（填空9）與非同步消費（填空10）
填空9：在 InventoryService 的釋放鎖程式碼中，為何要使用 Lua 腳本驗證 requestId？請簡要說明（限30字）。
填空10：請寫出 RabbitMQ 消費者監聽佇列 order.queue 的方法簽名（使用 @RabbitListener 註解）。

// 填空10：補齊消費者方法
@Component
public class OrderConsumer {
    @RabbitListener(queues = ______（填空10）)
    public void handleOrderCreated(Long orderId) {
        System.out.println("處理訂單：" + orderId);
    }
}

---

填空1：spring-boot-starter-data-redis
說明：Spring Boot 整合 Redis 的 starter。
填空2：spring-boot-starter-amqp
說明：整合 RabbitMQ 的 starter。
填空3：spring-boot-starter-mail
說明：整合 JavaMail 的 starter。
填空4：Duration.ofSeconds(5)
說明：設定鎖的自動過期時間為 5 秒，防止死鎖。
填空5a："order.created"
填空5b：orderId
說明：指定路由鍵與訊息內容。
填空6：minioClient.getObjectUrl(bucketName, objectName)
說明：取得上傳物件的公開存取 URL。
填空7：mailSender.send(message)
說明：呼叫 JavaMailSender 發送郵件。
填空8a：fileUploadService.uploadFile
填空8b：messageSender
說明：依賴注入並呼叫對應服務。
填空9：避免誤刪其他執行緒（或 JVM）持有的鎖，確保只有鎖的擁有者才能釋放。
說明：Lua 腳本先 GET 再 DEL，確保原子性與安全性。
填空10：RabbitMQConfig.ORDER_QUEUE（或直接寫 "order.queue"）
說明：指定監聽的佇列名稱。

首次作答：
1. spring-boot-starter-data-redis
2. spring-boot-starter-amqp
3. spring-boot-starter-mail
4. Duration.ofSeconds(5)
5.
6. minioClient.endpoint + "/" + bucketName + "/" + objectName
7. mailSender.send(message)
8. fileUploadService.uploadFile messageSender
9. 保证是当前订单创建的锁
10. order.queue

第二次作答

1. spring-boot-starter-data-redis
2. spring-boot-starter-amqp
3. spring-boot-starter-mail
4. Duration.ofSeconds(5)
5. "order.created" orderId
6. minioClient.getObjectUrl(buicketName, objectName)
7. mailSender.send(message)
8. fileUploadService.uploadFile messageSender
9. 防止错误释放了其他线程或者vm上创建的锁
10.RabbitMQConfig.ORDER_QUEUE