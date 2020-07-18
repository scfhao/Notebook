IAP

SKPaymentQueue、SKPayment

SKPayment 支付请求，设置好product id，大于0的数量，就可以添加到 SKPaymentQueue中了。

对SKPaymentQueue做任何操作前都应该先给它设置一个Observer，这个Observer建议用单例实现。

将SKPayment添加到SKPaymentQueue中后，SKPaymentQueue就会负责后面的支付流程，直到支付成功或者产生错误，这时SKPaymentQueue向observer发送一个SKPaymentTransaction对象概括本次交易。

应用处理这个这个transaction对象，例如解锁关卡，完成后调用SKPaymentQueue的finishTransaction:方法将这个交易从队列中移除。如果交易对象处于支付中，调用这个方法时会有异常。

Observer要随时准备好接受支付回调。

Once the transaction is finished, Store Kit can not tell you that this item is already purchased. It is important that applications process the transaction completely before calling finishTransaction:.

## 恢复购买

已经购买过的内容，在换了新设备后可以通过恢复购买来解锁功能。开发者在创建出售的商品时可以选择是否允许恢复购买。

相关方法：

- restoreCompletedTransactions

验证支付收据“Receipt Validation Programming Guide”
