# 文件夹

MailCore中有3个与文件夹相关的类，分别是MCOIMAPFolder、MCOIMAPFolderInfo、MCOIMAPFolderStatus。

## MCOIMAPFolderInfo

- allowsNewPermanentFlags 标示这个文件夹或IMAP服务器是否允许添加新的永久flags（旗帜？）
- messageCount 该文件夹中消息的总数。
- modSequenceValue 服务器支持的情况下用来做快速同步，是一个变化的值，文件夹的MODSEQ值。
- uidNext 文件夹的IMAP UIDNEXT值。用来确定下一条要收的消息的uid。
- uidValidity 文件夹的IMAP UIDVALIDITY值。用来确定服务器是否重新分配了UIDs。

## MCOIMAPFolderStatus

- highestModSeqValue 这个文件夹最大的修改序列值。见RFC 4551 CONDSTORE。
- messageCount 文件夹中消息数量。
- recentCount 这个文件夹中最新收到的消息条数？
- uidNext 文件夹的IMAP UIDNEXT值。用来确定下一条要收的消息的uid。
- uidValidity 文件夹的IMAP UIDVALIDITY值。用来确定服务器是否重新分配了UIDs。
- unseenCount 文件夹中未读信息条数。

## MCOIMAPFolder

表示IMAP中的文件夹。

- path 文件夹的路径，例如INBOX.Archive
- flags 文件夹的旗帜。
- delimiter path属性的分隔符。如.或/