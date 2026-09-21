# 專案工程師考试备考

## 一、核心知識（適用於選擇題備考）

### 第一類：K01. Vue、React、Angular 等前端框架及 Java、Python、Node、.NET 等後端技術的開發原則與方法

#### React

* 函式元件中管理狀態的 Hook
* 類元件中在元件首次渲染後被呼叫的生命週期方法
* 用於執行副作用操作（如 API 呼叫）的 Hook
* 避免 prop drilling（多層傳遞 props）的模式
* useEffect Hook 的使用原則
* useEffect 清理函數（取消訂閱、清除計時器）
* useEffect 相依陣列（空陣列、有條件重新執行）
* 狀態管理原則（狀態提升、Redux、Zustand、useReducer、Context API）

#### Vue

* Vue 3 中用於在元件中建立響應式資料的 API
* 用於條件渲染區塊的指令
* DOM 更新完成後被呼叫的生命週期鉤子
* 元件間通訊方式（props、$emit、Event Bus、Vuex、provide/inject）
* 跨多層級深層元件通訊（provide / inject）
* 非父子元件通訊（Event Bus、Vuex）

#### Angular

* 用於定義元件的裝飾器
* 在元件之間傳遞資料且使用 @Input() 裝飾器的方法（父傳子）
* 用於在路由之間導航的服務
* 變更檢測（Change Detection）機制
* 變更檢測策略（Default、OnPush）
* 手動觸發變更檢測（ChangeDetectorRef.detectChanges、detach）

#### Python

* 實現物件導向程式設計封裝的方式（私有屬性）
* 將方法轉換為類別方法的裝飾器
* 表示「一個類別應該只有一個改變的原因」的原則（單一職責原則）

#### Node.js

* 建立非同步函數非阻塞版本的方法（async/await）
* 用於處理標準輸入輸出/錯誤的全域物件
* 用於建立 HTTP 伺服器的模組

#### .NET

* 定義非同步方法的關鍵字
* 設定 JSON 序列化時欄位名稱的屬性

#### Java

* 指導「類別對擴展開放，對修改關閉」的原則
* 標記方法為非同步執行的註解

#### 通用前端原則

* JavaScript 非同步處理原則（async/await、Promise.all、Promise.race、try...catch）

### 第二類：K02. Spring Boot、Spring Cloud、Gin、Go-Zero 等主流微服務框架的開發原則與方法

#### Spring Boot

* 將應用程式打包成可執行 JAR 並內嵌 Servlet 容器的註解
* 在應用程式啟動時執行特定初始化邏輯的註解
* 設定定時任務並支援 cron 表達式的註解
* 宣告 Restful 風格控制器且每個方法自動加上 @ResponseBody 的註解
* 將設定檔中的屬性值映射到 Java 類別的註解
* 事務管理使用原則（@Transactional）
* @Transactional 預設攔截範圍（RuntimeException、Error）
* 傳播行為（Propagation、REQUIRES_NEW）

#### Spring Cloud

* 實現分散式鏈路追蹤的組件
* 實現動態配置刷新而不重啟服務的組件
* 實現斷路器並提供降級回退機制的組件
* 實作客戶端側負載均衡的組件
* 啟用 Feign 客戶端的註解
* 實作分散式訊息傳遞（事件驅動架構）的組件
* 設定中心使用原則
* 不同環境設定檔分離管理
* 敏感資訊加密儲存
* Spring Cloud Bus 實現設定動態刷新
* 設定中心高可用架構
* Feign 聲明式服務呼叫優化
* 連線超時與讀取超時設定
* GZIP 壓縮
* Feign 與負載均衡整合（Ribbon、Spring Cloud LoadBalancer）

#### Gin

* 分組路由以統一管理相同前置詞路由的方法
* 設定中介軟體全域生效的方法
* 綁定 URL 查詢參數到結構體的方法
* 解析並綁定 URL 路徑參數（如 /user/:id 中的 id）的方法
* 處理 HTTP 404 錯誤的方法
* 中間件（Middleware）正確使用方法
* gin.HandlerFunc 類型
* c.Next() 調用後續處理函數
* c.Abort() 中止後續執行
* 預設中間件（Logger、Recovery）

#### Go-Zero

* 定義服務 API 路徑、請求與回應結構的檔案
* 生成 RPC 服務 gRPC 程式碼的命令
* 包含業務邏輯具體實作的檔案
* 定義服務設定結構（如資料庫連線、監聽埠）的檔案
* 產生可部署 Docker 映像檔的命令
* 程式碼生成工具（goctl）
* 根據 API 描述檔案生成服務程式碼結構
* 產生資料庫存取模型程式碼
* 從 DDL 語句反向生成 CRUD 程式碼
* 統一團隊專案結構和程式碼風格

#### Python Django

* 資料庫查詢最佳實踐（select_related、prefetch_related）
* 限制查詢欄位（values、only）
* 迭代大量資料（iterator）
* 避免迴圈中執行資料庫查詢
* 批次處理

#### Node.js Express

* 錯誤處理原則與方法
* 四個參數的錯誤處理中間件
* process.on('unhandledRejection') 捕獲 Promise 錯誤
* 同步程式碼 try...catch
* 回呼函數中檢查 err 參數

#### ASP.NET Core

* 依賴注入（DI）使用原則
* 服務生命週期（Singleton、Scoped、Transient）
* 建構子注入
* 避免 Transient 服務參考 Singleton 服務
* 服務定位器模式（IServiceProvider）

#### API 閘道

* 閘道層統一處理的功能
* 身份認證與授權校驗
* 存取日誌與效能監控
* 跨域請求（CORS）配置
* 動態路由

#### 分散式追蹤系統

* 主要作用與功能
* 還原完整呼叫鏈路
* 分析服務間依賴關係與拓撲結構
* 定位慢查詢或慢請求
* 統計請求量、成功率與延遲

#### Docker 容器化部署

* 最佳實踐
* 輕量化映像檔（多階段建置）
* 單一容器單一服務行程（單一職責原則）
* 設定檔透過環境變數或 ConfigMap 掛載
* 定期掃描基礎映像檔安全漏洞

#### Kubernetes

* 服務發現與負載均衡機制
* Service 資源（虛擬 IP、DNS 名稱）
* Service 類型（ClusterIP、NodePort）
* Ingress 路由外部請求
* kube-proxy 自動負載均衡

#### 服務熔斷與服務降級

* 服務熔斷目的（防止錯誤連鎖反應、避免雪崩效應）
* 服務降級目的（壓力過大或熔斷觸發時提供有損回應）
* 熔斷器狀態（關閉、開啟、半開）
* 降級需要業務邏輯配合

#### 資料庫與資料儲存策略

* 設計原則
* 資料庫每服務模式
* 最終一致性與事件驅動架構
* 混合持久化（不同服務選擇不同資料庫類型）
* CDC（Change Data Capture）技術

### 第三類：K03. 消息隊列（MQ）、NoSQL 資料庫及 JDBC 等主流中介軟體的開發流程與使用方法

#### 消息隊列（MQ）

* 確保訊息不會因消費者崩潰而永久遺失的機制（訊息確認機制 ACK）
* 用於防止消息重複消費的機制（冪等性設計）
* 專門存放無法被正常消費消息的隊列（死信隊列）
* 訊息冪等性設計原則
* 消費端設計（處理多次與一次效果相同）
* 資料庫唯一約束防止重複寫入
* 唯一訊息識別碼（Message ID）
* Redis 記錄已處理訊息 ID
* 順序訊息實作方案
* Kafka（同一個 Partition、單一 Consumer 執行緒）
* RocketMQ（MessageQueueSelector）
* 消費端單執行緒消費
* 為有序訊息群組分配獨立佇列或主題

#### RabbitMQ

* 設定隊列為排他性（連線關閉後自動刪除）的參數
* 根據 routing key 模式匹配（使用 * 和 #）路由訊息的交換器類型（Topic）
* 將無法路由的訊息回傳給生產者的機制（傳回監聽器）
* 設定訊息在多久未被消費後自動移至死信隊列的參數
* 死信佇列（DLX）典型使用場景
* 訊息被消費者明確拒絕且 requeue = false
* 訊息存活時間超過 TTL
* 佇列長度達最大限制

#### Redis

* 適合實作先進先出（FIFO）隊列的資料結構
* 將元素加入有序集合（Sorted Set）並指定分數的命令
* 同時設定多個欄位值到一個雜湊（Hash）的命令
* 持久化機制選擇與配置
* RDB（緊湊單一檔案、適合備份、fork 子行程可能短暫停頓）
* AOF（記錄所有寫入操作、資料安全性較高、檔案體積較大）
* 同時開啟時優先載入 AOF
* fsync 策略效能考量

#### JDBC

* 設定連線池最大連線數的方法
* 交易處理中還原交易到某個儲存點（Savepoint）的方法
* 可能發生幻讀（Phantom Read）的隔離級別
* 預編譯 SQL 語句以防止 SQL 注入的方法
* 來自 PostgreSQL 的常見連線池實作
* 批次處理大量資料效能提升做法
* addBatch 與 executeBatch
* 適當批次大小設定
* PreparedStatement 搭配批次處理
* 資料庫原生 LOAD DATA 工具
* 連線池參數配置
* maximumPoolSize、connectionTimeout、idleTimeout、maxLifetime、minimumIdle
* 交易隔離層級特性與選擇
* READ UNCOMMITTED（可能髒讀、效能最高）
* READ COMMITTED（防止髒讀）
* REPEATABLE READ（防止髒讀與不可重複讀）
* SERIALIZABLE（防止髒讀、不可重複讀與幻讀、並發效能最差）

#### Kafka

* 控制生產者傳送訊息時壓縮類型的參數
* 負責管理消費者群組偏移量的組件（Consumer Coordinator）
* 決定訊息在多久內未收到確認而重新傳送的設定
* 消費者群組設計與使用
* 同群組多消費者分擔主題分區消費
* 一個分區只能被同一群組中的一個消費者消費
* 消費者數量超過分區數量時閒置
* 不同群組消費進度彼此獨立

#### MongoDB

* 建立唯一性約束的索引類型
* 執行彙總操作（如分組、統計）的方法
* 更新時將欄位增加指定數值的修飾符（$inc）
* 索引設計與使用原則
* 為排序欄位建立索引
* 複合索引欄位順序（等值查詢在前，排序範圍在後）
* 索引數量與寫入效能關係
* explain() 分析查詢計劃

#### HBase

* 大數據場景資料模型設計原則
* Row Key 設計（考量存取模式、負載分佈避免熱點）
* Column Family 數量建議
* 經常一起查詢的欄位放在同一 Column Family
* 版本數設定避免儲存膨脹

### 第四類：K04. 程式代碼審查的流程與規則

#### 變數命名

* 符合駝峰式命名規範（camelCase）的命名方式
* 物件導向原則
* 提倡「組合優於繼承」的原則
* 要求「抽象不應依賴於細節，細節應依賴於抽象」的原則（依賴倒置原則）
* 封裝的優點（隱藏內部實作細節，降低耦合）
* 指導「將介面設計得越小越好」的原則（介面隔離原則）
* 表示「has-a」關係的設計方式（組合）

#### 異常處理

* 可能導致資源洩漏的做法（不關閉資源，依賴 GC）
* finally 區塊的執行特性（無論是否發生異常都會被執行）
* 正確的異常捕獲做法（捕獲具體的異常類型）
* 自定義異常的繼承選擇（取決於是否需要編譯時檢查）
* 拋出異常的正確方式（拋出具體且有意義的異常類型）

#### 函數設計

* 被視為「程式碼壞味道」的特徵（參數過多）
* 建議函數只做一件事的原則（單一職責原則）
* 關於布林參數的正確描述（應避免使用，可拆分為兩個函數）
* 有助於降低圈複雜度的做法（提取條件判斷為獨立函數）
* 建議「不要重複你自己」的原則（DRY）

#### 程式碼審查

* 常數定義的正確做法（使用 #define 或 final 宣告具名常數）
* 被認為是多餘的註解類型（重複程式碼內容的註解）
* 全域變數的影響（增加耦合度與維護難度）
* 比較字串的正確方法（使用 equals() 方法）

#### 註釋規範

* 解釋「為什麼」而非「做了什麼」
* 複雜邏輯添加說明性註釋
* 註釋與程式碼同步更新
* TODO 註釋標記未來改進

#### 物件導向設計原則

* 依賴反轉原則（DIP）
* 依賴抽象介面
* 依賴注入（DI）
* 工廠模式

#### 圈複雜度

* 應關注的面向
* 避免過深巢狀條件判斷（超過 3 層）
* 避免過多邏輯運算子
* 複雜邏輯拆分為多個小函數
* 圈複雜度越低越容易測試

#### 程式碼審查效率

* 每次審查程式碼改動量適中
* 提出具體、有建設性回饋
* 作者提交前自行檢查並通過單元測試
* 審查重點放在設計邏輯與規範遵循

#### 技術債處理

* 重複程式碼提取為共用函數
* 過時第三方函式庫升級
* 架構缺陷記錄與重構
* 撰寫單元測試保護關鍵邏輯

#### 靜態程式碼分析工具

* 在不執行程式碼情況下發現潛在錯誤
* 檢查程式碼風格違規
* 配置檢查規則偵測空指針異常、資源洩漏
* 整合到 CI 流程

#### 元件設計審查關注點

* 單一職責原則
* props 型別驗證（PropTypes、TypeScript）
* 效能問題（render 中定義函數）
* 元件銷毀時清理副作用（取消訂閱、清除計時器）

### 第五類：K05+K06. 單元測試用例設計方法與測試框架

#### 邏輯覆蓋法

* 要求最嚴格、覆蓋率最高的覆蓋標準（路徑覆蓋）
* 判定覆蓋的正確描述（每個判定的真偽結果至少取一次）
* 條件覆蓋的正確描述（每個條件內的所有可能結果至少出現一次）
* 可檢查判定中多個條件對結果影響的覆蓋標準（條件組合覆蓋）
* 迴圈結構可能導致路徑數量爆炸的覆蓋法（路徑覆蓋）
* 語句覆蓋的正確描述（每行程式碼至少執行一次）
* 條件判定覆蓋（CDC）
* 要求每個條件的所有可能取值至少出現一次
* 要求每個判定的所有可能結果至少出現一次
* 滿足 CDC 一定滿足條件覆蓋
* 滿足 CDC 一定滿足判定覆蓋
* 修正條件判定覆蓋（MCDC）
* 每個條件能獨立影響判定結果
* 常用於高安全性系統（航空、汽車）
* 能檢測條件短路行為相關錯誤
* 測試用例數量通常等於條件數量加一
* 語句覆蓋
* 又稱線性覆蓋
* 邏輯覆蓋法中最弱的覆蓋標準
* 無法檢測遺漏路徑
* 無法判斷判定條件內部錯誤
* 路徑覆蓋
* 測試挑戰與因應策略
* 迴圈程式簡化（零次執行、一次執行、多次執行）
* 靜態程式碼分析工具計算環路複雜度
* 優先針對高風險核心邏輯
* 覆蓋率工具檢查執行路徑

#### JUnit 5

* 在所有測試方法執行完畢後運行一次的註解（@AfterAll）
* 檢查預期結果與實際結果不相等的斷言方法
* 標記測試方法並可自訂顯示名稱的註解（@DisplayName）
* 用於巢狀測試以組織相關測試類別的註解（@Nested）
* 檢查所有提供的條件均為 true 的斷言方法（assertAll）
* 斷言庫常用方法
* assertEquals、assertNotEquals
* assertThrows
* assertAll
* assertTimeout

#### Spock

* 執行測試前準備工作（如初始化資料）的區塊（setup）
* 定義資料驅動測試中資料表格的關鍵字（where）
* 定義測試中預期拋出異常行為的區塊（thrown）
* 結合 when 和 then 功能、適用於簡單測試場景的區塊（expect）
* 資料驅動測試
* where 區塊定義測試資料
* << 運算子提供資料流
* @Unroll 註解
* where 區塊中變數組合計算預期結果

#### Mockito

* 驗證模擬物件方法被呼叫指定次數的方法
* 模擬方法呼叫後連續回傳多個值的方式
* 驗證模擬物件在測試過程中沒有任何互動發生的方法
* 捕獲模擬物件方法呼叫時傳入參數的方法（ArgumentCaptor）
* 模擬 final 類別或靜態方法的方案（需額外引入 mockito-inline）
* 驗證 Mock 物件互動行為
* verify(mock).method()（呼叫一次）
* verify(mock, times(n)).method()（呼叫 n 次）
* verify(mock, never()).method()（從未被呼叫）
* verifyNoMoreInteractions(mock)（驗證無後續互動）
* doReturn() 與 when().thenReturn() 差異
* doReturn() 適合 Mock Spy 物件
* doReturn() 避免呼叫真正實體方法
* void 方法使用 doNothing() 或 doThrow()

#### 測試替身

* Mock 物件（驗證互動行為）
* Stub 物件（預先定義回應）
* Spy 物件（部分模擬、追蹤呼叫）
* Fake 物件（簡化可運作實作）
* Dummy 物件（填充參數）

#### 邊界值分析

* 設計單元測試用例應用原則
* 優先測試有效邊界值兩側（最小值-1、最小值、最大值、最大值+1）
* 等價類劃分法的補充
* 集合型態邊界（空集合、單一元素、滿集合）

#### 防禦技術與安全措施

* SQL Injection 防範：最有效的措施為使用參數化查詢或預處理敘述，而非限制伺服器對外頻寬、定期重啟資料庫服務或僅將資料庫密碼改為複雜字串。
* WPA3 安全強化：與 WPA2 相比，WPA3 的主要強化項目為強化個別連線的加密與防暴力破解，並非取消無線網路加密、使用更弱的密碼長度限制，也不是只支援 Windows 作業系統連線。
* 密碼複雜度原則：合理的要求為密碼需混用大小寫字母、數字與特殊符號，而非密碼只能是數字且長度固定為 4 碼、一律使用空白字元當作密碼，或密碼必須與帳號完全相同。

#### 攻擊手法與威脅類型

* 字典攻擊：此攻擊方式為使用預先建立的密碼詞彙表進行猜測，並非只能用來破解 ZIP 壓縮檔、一定比暴力破解耗費更長時間，也並非無法在網路服務上進行。
* 中間人攻擊：攻擊者可在雙方通訊中竊聽或篡改內容，不必然需要在目標電腦植入木馬程式、不僅限於攻擊有線網路（亦可攻擊 Wi-Fi），且此類攻擊並非完全無法被偵測或防範。

## 二、學習資料（適用於案例題備考）

### 一、 考核技能點

S01-2-能夠按照系統架構及功能設計方案，搭建並配置完整的整體開發環境，能夠按照系統架構
及功能設計方案，搭建並優化數據庫開發環境。

S02-能夠按照規範進行代碼審查，輸出專業、詳盡的代碼審查意見與建議。

S03-1-能夠依據功能需求編寫規範、完整的單元測試用例，能夠對各模塊功能進行全面、系統的
測試驗證，能夠分析及修復系統存在的各類問題與缺陷。

### 二、 內部資料

1. 《iPEG2025 年技術職/專業職 考核崗位題庫編撰大綱

### 三、 外部資料

#### 1.《软件设计师教程》（第五版）：

I. 第 4 章 系统开发与运行
II. 第 6 章 面向对象技术
III. 第 11 章 软件工程标准化与文档编写

#### 2.《代码大全》（第二版）：

I. 第 5 章 代码构造
II. 第 22 章 调试与错误处理
III. 第 24 章 代码审查与质量保证

#### 3.《软件设计师考试辅导—测试与质量篇》：

I. 第 3 章 单元测试设计与实施
II. 第 5 章 系统测试与维护

#### 4.《重构：改善既有代码的设计》（第二版）：

I. 第 1 章 重构原则
II. 第 6 章 重构方法
III. 第 10 章 测试驱动开发

## 三、學習資料（適用於實操題備考）

### 一、 考核技能點

S01-1-能夠按照系統架構及功能設計方案，搭建並配置完整的整體開發環境，能夠按照系統架構及功能設計
方案，搭建並優化數據庫開發環境

* 後端開發程序初始化：使用 Spring Initializr 生成 Maven/Gradle 專案，選擇 Web、JPA、PostgreSQL 依賴；配置 application.yml 分環境（dev/test/prod）。
* 前端開發程序搭建：使用 Vite 或 Create React App 建立專案；安裝 Axios、路由、狀態管理；配置開發伺服器代理（proxy）解決聯調跨域。
* 版本控制與協作：初始化 Git 倉庫，撰寫 .gitignore（排除 target/、node_modules/、.env）；採用 Git Flow 分支策略（main/develop/feature）。
* 基礎查詢語法：熟練使用 SELECT、JOIN（INNER/LEFT/RIGHT/FULL）、GROUP BY、HAVING、ORDER BY、LIMIT/OFFSET；掌握子查詢（標量、行、表子查詢）與 EXISTS。
* 窗口函數：使用 ROW_NUMBER()、RANK()、DENSE_RANK() 實現分組排序；使用 LAG()/LEAD()進行前後行計算；使用 SUM() OVER() 計算累積總和。
* 查詢執行計畫分析：執行 EXPLAIN (ANALYZE, BUFFERS, VERBOSE) 解讀順序掃描、索引掃描、雜湊連接；辨識成本最高的節點。
* 查詢改寫技巧：避免 SELECT *；用 UNION ALL 代替 UNION（無需去重）；用 NOT EXISTS 代替 NOT IN（處理 NULL）；用 = ANY 代替多個 OR。

S03-2-能夠獨立搭建並配置符合要求的測試環境

* HTML 語義化與結構：使用 header、nav、main、section、article、aside、footer；確保表單 label 與 input 關聯；添加 ARIA 屬性提升無障礙。
* CSS 佈局與響應式：熟練使用 Flexbox（flex、justify-content、align-items）與 Grid（grid-template-columns、grid-area）；媒體查詢實現手機／平板／桌面響應式。
* CSS 預處理器：使用 SCSS 管理變量（$primary-color）、巢狀規則、Mixins（例如 @mixin respond-to）；組織檔案為 base/、components/、layout/。
* JavaScript 核心：掌握閉包、原型鏈、事件循環、Promise/async-await、ES6 模組；熟練陣列方法（map、filter、reduce、some、every）；解構賦值與展開運算符。
* DOM 操作與事件：使用 querySelector、addEventListener；事件委託（例如動態列表點擊）；表單取值、驗證與重置；動態建立/刪除元素。
* 前端框架（Vue）：組合式 API（ref、reactive、computed、watch）、生命週期 hooks、元件 props/emit、v-model、<script setup> 語法。
* HTTP 請求與非同步處理：使用 fetch 或 Axios 封裝請求與回應攔截器；統一錯誤處理（彈窗提示）；使用 async/await 避免回調地獄。
* 表單驗證與提交：前端即時校驗（正則表達式、自定義規則）；防止重複提交（按鈕 disabled + 防抖）；檔案上傳（FormData）與進度條。
* 前端路由與守衛：配置 Vue Router 或 React Router（歷史模式、動態路由）；導航守衛實現未登入跳轉、權限檢查；路由傳參（params/query）。
* 前端效能最佳化：圖片懶加載（IntersectionObserver）；路由懶加載（defineAsyncComponent / React.lazy）；使用 v-once、useMemo/useCallback 減少重繪。

S04-能夠編寫詳細、規範的系統聯調方案，能夠嚴格執行系統聯調測試，輸出完整的聯調結果報告

* 後端框架整合（Spring Boot）：整合 Spring Data JPA / MyBatis-Plus 操作 PostgreSQL；整合 Spring Security + JWT 實現認證授權；整合 Spring Cache（Redis）提升效能。
* ORM 框架整合：使用 Hibernate 二級快取；MyBatis 整合分頁外掛（PageHelper）與自定義攔截器（SQL 審計、資料脫敏）；使用 Flyway 管理資料庫遷移。
* 前端框架整合（Vue/React）：整合路由（Vue Router / React Router）；整合狀態管理（Pinia / Redux Toolkit）；整合 HTTP 客戶端（Axios）統一攔截；整合 UI 元件庫（Element Plus / Ant Design）。
* 整合協定規範：定義統一 API 回應格式（{code, message, data}）；定義錯誤碼字典；使用 JWT 攜帶用戶身份；透過 Swagger UI / Knife4j 自動產生文件。
* 第三方服務整合：整合 Redis（快取、分散式鎖）、RabbitMQ/Kafka（非同步）、MinIO/OSS（物件儲存）、郵件服務（JavaMail 或 Nodemailer）。
* 框架整合攔截機制：Spring 攔截器（HandlerInterceptor）實現日誌、權限；過濾器（Filter）處理 CORS；前端路由守衛控制頁面存取；Axios 請求/回應攔截器。
* 整合測試策略：使用 @SpringBootTest 啟動完整上下文；Testcontainers 啟動 Docker 依賴（PostgreSQL、Redis）；前端使用 Cypress 或 Playwright 進行整合測試；CI 中執行整合測試。

### 二、外部资料

1. 【《JavaScript 高級程式設計（第 4 版）》作者：Nicholas C. Zakas 人民邮电出版社】

I. 第 8 章 對象與類
II. 10 章 函數
III. 第 11 章 Promise
IV. 第 17 章 事件

2. 【《CSS 權威指南（第 4 版）》作者：Eric Meyer 中国电力出版社】

I. 第 9 章 Flexbox
II. 第 10 章 Grid
III. 第 13 章 響應式設計

3. 【《前端測試實戰》作者：王仕軍 电子工业出版社】

I. 第 3 章 元件測試（Vue/React）
II. 第 5 章 表單與非同步測試

4. 【《PostgreSQL 14 從入門到實戰》作者：張利民 清华大学出版社】

I. 第 5 章 進階查詢（CTE、窗口函數）
II. 第 9 章 索引最佳化
III. 第 10 章 查詢效能調校

5. 【《前端工程化：核心原理與實踐》作者：王伟 电子工业出版社】

I. 第 2 章 開發伺服器與代理
II. 第 3 章 環境變數與建構模式

6. 【《Spring Boot 核心技術與實戰》作者：柳偉衛 电子工业出版社】

I. 第 5 章 資料存取整合（JPA、MyBatis）
II. 第 6 章 快取整合（Redis）；
III. 第 8 章 安全整合（Spring Security + JWT）；
IV. 第 12 章 Actuator 監控

7. 【《Vue/React 全家桶實戰》與《前端架構：從入門到微前端》作者：黃峰達 电子工业出版社】

I. 第 5 章 前端框架整合策略（路由、狀態、HTTP）
II. 第 8 章 前後端分離整合方案

8. 【《API 設計與框架整合》作者：James Higginbotham 人民邮电出版社】

I. 第 4 章 RESTful API 設計
II. 第 6 章 使用 OpenAPI 整合文檔與測試
III. 第 9 章 整合監控與日誌
