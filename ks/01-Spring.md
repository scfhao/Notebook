前後端開發環境初始化（Spring Boot + Vite + Vue 3）
題目背景
你將開發一個「員工管理系統」。請完成以下前後端專案初始化工作：
後端：使用 Spring Initializr 生成 Maven 專案，選擇 Spring Web、Spring Data JPA、PostgreSQL Driver 依賴。配置多環境（dev / test / prod）的 application.yml，並設置不同資料庫連線。
前端：使用 Vite 建立 Vue 3 專案，安裝 Axios、Vue Router、Pinia。配置開發伺服器代理，解決前後端聯調時的跨域問題。
現有部分程式碼及設定檔，請根據註解提示在 _______ 處填入正確的內容。

後端部分（Spring Boot）
1. Maven 依賴配置（pom.xml）
在 <dependencies> 中補充 Spring Boot Starter Web、Spring Data JPA、PostgreSQL 的依賴座標（僅寫出 <groupId> 和 <artifactId>，版本由父專案管理）。

<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>_______</artifactId>   <!-- 填空1：Web 依賴 -->
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>_______</artifactId>   <!-- 填空2：JPA 依賴 -->
    </dependency>
    <dependency>
        <groupId>org.postgresql</groupId>
        <artifactId>_______</artifactId>   <!-- 填空3：PostgreSQL 驅動 -->
    </dependency>
</dependencies>
2. 多環境配置（application.yml 及 application-{profile}.yml）
在主設定檔 application.yml 中指定預設啟動的環境為 dev。

spring:
  profiles:
    active: _______   # 填空4：預設使用 dev 環境

在 application-dev.yml 中配置開發環境資料庫連線（使用 H2 記憶體資料庫，方便測試）。

spring:
  datasource:
    url: jdbc:h2:mem:testdb
    driver-class-name: org.h2.Driver
    username: sa
    password: 
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
 
在 application-prod.yml 中配置生產環境 PostgreSQL 連線。請補齊 URL 及連線池相關參數。

spring:
  datasource:
    url: jdbc:postgresql://_______/employee_db   # 填空5：資料庫主機與埠（預設 localhost:5432）
    username: prod_user
    password: ${DB_PASSWORD}            # 使用環境變數
    hikari:
      maximum-pool-size: 20
  jpa:
    hibernate:
      ddl-auto: validate
3. 啟動類（Application.java）
補齊啟動類的套件宣告與 @SpringBootApplication 註解。

package com.example.demo;

_______   // 填空6：導入 Spring Boot 啟動所需的註解
public class EmployeeApplication {
    public static void main(String[] args) {
        SpringApplication.run(EmployeeApplication.class, args);
    }
}
前端部分（Vite + Vue 3）
4. 專案初始化與依賴安裝
假設你已執行 npm create vue@latest，專案名為 employee-frontend。接下來需安裝額外依賴。
寫出安裝 Axios、Vue Router、Pinia 的 npm 命令（一行指令，用空格分隔套件）。

bash
npm install _______   # 填空7：安裝 axios vue-router pinia

5. 配置開發代理（vite.config.js）
為了在開發時呼叫後端 API（後端運行於 http://localhost:8080），需設定代理避免跨域。前端所有以 /api 開頭的請求應轉發至後端。
補齊 vite.config.js 中的 server.proxy 設定。

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  server: {
    proxy: {
      '/api': {
        target: '_______',     // 填空8：後端伺服器位址（含埠）
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, '')
      }
    }
  }
})
6. 引入路由與狀態管理（main.js）
在專案入口 main.js 中，引入並使用 router 和 pinia。

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import { createPinia } from 'pinia'

const app = createApp(App)
app.use(_______)   // 填空9：使用路由
app.use(pinia)   
app.mount('#app')
7. 配置 Axios 基礎路徑（utils/request.js）
為了讓所有 API 請求自動帶上 /api 前綴，需設定 Axios 的 baseURL。
建立 src/utils/request.js，設定 baseURL 為開發代理的前綴。

import axios from 'axios'

const request = axios.create({
  baseURL: '_______',   // 填空10：與 proxy 中的路徑對應
  timeout: 10000
})

export default request

---

填空1
<artifactId>spring-boot-starter-web</artifactId>
填空2
<artifactId>spring-boot-starter-data-jpa</artifactId>
填空3
<artifactId>postgresql</artifactId>
說明：Spring Boot Starter Web 提供 REST API 支援；JPA 提供 ORM；PostgreSQL 驅動連線資料庫。

填空4
dev
說明：預設啟動開發環境，可在執行時透過 --spring.profiles.active=prod 覆蓋。

填空5
localhost:5432
說明：標準 PostgreSQL 預設主機與埠，可依實際部署修改。

填空6
@SpringBootApplication
說明：該註解組合了 @Configuration、@EnableAutoConfiguration、@ComponentScan。

填空7
axios vue-router pinia
說明：三個套件分別用於 HTTP 請求、路由管理、狀態管理。

填空8
'http://localhost:8080'
說明：後端 Spring Boot 預設埠為 8080。

填空9
router
說明：將路由實例註冊到 Vue 應用。

填空10
'/api'
說明：所有 API 請求前綴設為 /api，與 proxy 中的路徑一致。

--- 首次作答答案
1. spring-boot-starter-web
2. spring-boot-starter-data-jpa
*3. Driver | postgresql
4. dev
5. localhost:5432
*6. @SpringApplication | @SpringBootApplication
7. axios vue-router pinia
8. http://localhost:8080
9. router
10./api
