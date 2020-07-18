# MCOIMAPSession

这是一个主要的类，所有的IMAP操作都是从这个类创建。

调用方法得到一个操作对象后，你必须调用其start:方法来启动操作。

## 属性列表

* OAuth2Token OAuth2令牌
* allowFolderConcurrentAccessEnabled 是否允许同时对同一个文件夹打开多个连接，老的服务器不支持。
* authType : MCOAuthType 连接的验证类型，默认是MCOAuthTypeSASLNone代表使用clear-text(明文？)。如果使用加密连接如TLS，密码仍是安全的。
* checkCertificateEnabled 为YES时，当证书无效时连接失败。
* clientIdentify IMAP客户端的标识。
* connectionLogger 网络传输回调。
* connectionType : MCOConnectionType 使用的加密类型。
* defaultNamespace : MCOIMAPNamespace 默认的命名空间。
* dispatchQueue : dispatch_queue_t 操作回调运行的队列，默认为主队列，出于性能的考虑可以使用别的队列。
* gmailUserDisplayName Gmail用户的显示用户名，非Gmail服务器时为nil。
* hostname 连接的IMAP服务器的主机名。
* maximumConnections 允许向服务器创建的最大连接数。
* operationQueueRunning 有异步操作执行时为YES，否则为NO。
* operationQueueRunningChangeBlock : MCOOperationQueueRunningChangeBlock 当操作开始或结束时调用的回调。
* password 帐户密码。
* port 要连接的IMAP服务器的端口号。
* serverIdentity : MCOIMAPIdentity IMAP服务器的标识。
* timeout 连接超时时间。
* username 帐户用户名。
* voIPEnabled 设置为YES时，IMAP连接上的VoIP功能。

## 实例方法

### 订阅文件夹

- `fetchSubscribedFoldersOperation` 返回获取订阅的文件夹列表的操作。
- `subscribeFolderOperation:` 返回一个订阅一个文件夹的操作。
- `unsubscribeFolderOperation:` 返回一个取消订阅文件夹的操作。




- `appendMessageOperationWithFolder:messageData:flags:` 返回一个操作用来向一个文件夹增加消息。
- `appendMessageOperationWithFolder:messageData:flags:customFlags:` 返回一个操作用来向一个文件夹增加消息。
- `cancelAllOperations` 取消所有的操作。
- `capabilityOperation` 返回一个用于请求服务器功能的操作。
- `checkAccountOperation` 返回一个检查帐户是否有效的操作。
- `connectOperation` 返回的操作可以向给定的IMAP服务器创建一个没有验证信息的连接。检查初始服务器功能时有用。
- `copyMessagesOperationWithFolder:uids:destFolder:` 返回复制消息到其他文件夹的操作。
- `createFolderOperation:` 返回创建新文件夹的操作。
- `deleteFolderOperation:` 返回删除文件夹的操作。
- `disconnectOperation` 返回一个断开会话的操作，可以断开会话创建的所有sockets。
- `expungeOperation:` 返回一个清空文件夹的操作。
- `fetchAllFoldersOperation` 返回一个获取所有文件夹的操作。
- `fetchMessageAttachmentByUIDOperationWithFolder:uid:partID:encoding:` 返回获取附件的操作。
- `fetchMessageAttachmentByUIDOperationWithFolder:uid:partID:encoding:urgent:` 返回获取附件的操作，如果urgent为YES，可能会向同一个文件夹再创建一个连接来获取内容。
- `fetchMessageAttachmentOperationWithFolder:number:partID:encoding:` 返回获取附件的操作。
- `fetchMessageAttachmentOperationWithFolder:number:partID:encoding:urgent:` 返回获取附件的操作，如果urgent为YES，可能会向同一个文件夹再创建一个连接来获取内容。
- `fetchMessageAttachmentOperationWithFolder:uid:partID:encoding:` 返回获取附件的操作。
- `fetchMessageAttachmentOperationWithFolder:uid:partID:encoding:urgent:` 返回获取附件的操作，如果urgent为YES，可能会向同一个文件夹再创建一个连接来获取内容。
- `fetchMessageByUIDOperationWithFolder:uid:` 返回一个获取消息内容的操作。
- `fetchMessageByUIDOperationWithFolder:uid:urgent:` 返回一个获取消息内容的操作，如果urgent为YES，可能会向同一个文件夹再创建一个连接来获取内容。
- `fetchMessageOperationWithFolder:number:` 返回一个获取消息内容的操作，参数为IMAP序列号（sequence number）
- `fetchMessageOperationWithFolder:number:urgent:` 返回一个获取消息内容的操作，参数为IMAP序列号（sequence number），如果urgent为YES，可能会向同一个文件夹再创建一个连接来获取内容。
- `fetchMessageOperationWithFolder:uid:` 返回获取一个消息内容的操作。
- `fetchMessageOperationWithFolder:uid:urgent:` 返回一个获取消息内容的操作，如果urgent为YES，可能会向同一个文件夹再创建一个连接来获取内容。
- `fetchMessagesByNumberOperationWithFolder:requestKind:numbers:` 返回通过序列号获取消息的操作。例如：展示最近的50个uids。

```

NSString *folder = @"INBOX";
MCOIMAPFolderInfoOperation folderInfo = [session folderInfoOperation:folder];
[folderInfo start:^(NSString *error, MCOIMAPFolderInfo *info) {
	int numberOfMessage = 50;
	numberOfMessages -= 1;
	MCOIndexSet *numbers = [MCOIndexSet indexSetWithRange:MCORangeMake([info messageCount] - numberOfMessage, numberOfMessages)];
	MCOIMAPFetchMessagesOperation *fetchOperation = [session fetchMessagesByNumberOperationWithFolder:folder requestKind:MCOIMAPMessagesRequestKindUid numbers:numbers];
	[fetchOperation start:^(NSError *error, NSArray *messages, MCOIndexSet *vanishedMessages) {
		for (MCOIMAPMessage *message in messages) {
			NSLog(@"%u", [message uid]);
		}
	}];
}];


```

- `fetchMessagesByUIDOperationWithFolder:requestKind:uids:` 返回通过UID获取消息的操作。

```

MCOIMAPFetchMessagesOperation *op = [session fetchMessagesByUIDOperationWithFolder:@"INBOX" requestKind:MCOIMAPMessagesRequestKindHeaders | MCOIMAPMessagesRequestKindStructure uids:MCORangeMake(1, UINT64_MAX)];
[op start:^(NSError *error, NSArray *message, MCOIndexSet *vanishedMessage) {
	for (MCOIMAPMessage *msg in messages) {
		NSLog(@"%lu: %@", [msg uid], [msg header]);
	}
}];

```

- `fetchMessagesOperationWithFolder:requestKind:uids:` 返回一个根据UID获取消息的操作。
- `fetchNamespaceOperation` 返回获取命名空间列表的操作。
- `fetchParsedMessageOperationWithFolder:number:` 返回通过IMAP序列号获取消息的已解析内容的操作。
- `fetchParsedMessageOperationWithFolder:number:urgent:` 返回通过IMAP序列号获取消息的已解析内容的操作，如果urgent为YES，可能会向同一个文件夹再创建一个连接来获取内容。
- `fetchParsedMessageOperationWithFolder:uid:` 返回获取消息已解析的内容的操作。
- `fetchParsedMessageOperationWithFolder:uid:urgent:` 返回获取消息已解析的内容的操作，如果urgent为YES，可能会向同一个文件夹再创建一个连接来获取内容。
- `folderInfoOperation:` 返回获取文件夹元数据（如UIDNext）的操作。
- `folderStatusOperation:` 返回获取文件夹状态（如UIDNext - Unseen -）的操作。
- `htmlBodyRenderingOperationWithMessage:folder:` 返回渲染一个消息用来在网页中展示的HTML体的操作。
- `htmlRenderingOperationWithMessage:folder:` 返回一个操作渲染一个消息在网页中展示的HTML版本。
- `identityOperationWithClientIdentity:` 返回一个操作发送客户端身份或获取服务器身份。
- `idleOperationWithFolder:lastKnownUID:` 返回一个操作等待指定文件夹中的事件。
- `noopOperation` 返回一个操作将要在给定的IMAP服务器上执行No-Op操作。
- `plainTextBodyRenderingOperationWithMessage:folder:` 返回一个渲染消息的纯文本体的操作。所有的行结束符和空白将被清理，可以用这个方法获取消息的摘要。
- `plainTextBodyRenderingOperationWithMessage:folder:stripWhitespace:` 返回一个渲染消息的纯文本体的操作。所有的行结束符和空白将被清理，可以用这个方法获取消息的摘要。
- `plainTextRenderingOperationWithMessage:folder:` 返回渲染消息的纯文本版本的操作。
- `renameFolderOperation:otherName:` 创建一个重命名文件夹的操作。
- `searchExpressionOperationWithFolder:expression:` 返回一个搜索消息的操作。

```

MCOIMAPSearchExpression *expr = [MCOIMAPSearchExpression searchFrom:@"laura@etpan.org"];
MCOIMAPSearchOperation *op = [session searchExpressionOperationWithFolder:@"INBOX" expression:expr];
[op start:^(NSError *error, MCOIndexSet *searchResult) {
}];

``` 

- `searchOperationWithFolder:kind:searchString:` 返回一个通过简单匹配搜索消息的操作。
- `storeFlagsOperationWithFolder:numbers:kind:flags:` 返回一个改变消息标志的操作，使用IMAP序列号。
- `storeFlagsOperationWithFolder:numbers:kind:customFlags:` 返回一个改变消息标志和自定义标准的操作，使用IMAP序列号。
- `storeFlagsOperationWithFolder:uids:kind:flags:` 返回修改消息标志的操作。
- `storeFlagsOperationWithFolder:uids:kind:flags:customFlags:` 返回一个修改消息标志和自定义标志的操作。
- `storeLabelsOperationWithFolder:numbers:kind:labels:` 返回一个修改消息标签的操作，用于Gmail。
- `storeLabelsOperationWithFolder:uids:kind:labels:` 返回一个修改消息标签的操作，用于Gmail。
- `syncMessagesByUIDWithFolder:requestKind:uids:modSeq:` 创建操作用于同步给定的消息列表相对于给定的修改序列的修改，这只可以用于支持条件存储的服务器。vanishedMessages只对支持QRESYNC的服务器才被设置。

```
MCOIMAPFetchMessagesOperation *op = [session syncMessagesByUIDWithFolder:@"INBOX" requestKind:MCOIMAPMessagesRequestKindUID uids:MCORangeMake(1, UINT64_MAX) modSeq:lastModSeq];
[op start:^(NSError *error, NSArray *message, MCOIndexSet *vanishedMessage) {
	NSLog(@"added or modified messages: %@", message);
	NSLog(@"deleted message:%@", vanishedMessage);
	
}];

``` 

- `syncMessagesWithFolder:requestKind:uids:modSeq:` 创建操作用于同步给定的消息列表相对于给定的修改序列的修改。