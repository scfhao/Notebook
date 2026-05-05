
# AVAssetResourceLoaderDelegate 

## 处理资源请求

- `resourceLoader:shouldWaitForLoadingOfRequestedResource:`

Asks the delegate if it wants to load the requested resource.

Return value:

YES if your delegate can load the resource specified by the loadingRequest parameter or NO if it cannot.

Discussion:

The resource loader object calls this method when assistance is required of your code to load the specified resource. For example, the resource loader might call this method to load decryption keys that have been specified using a custom URL scheme.

Returning YES from this method, implies only that the receiver will load, or at least attempt to load, the resource. In some implementations, the actual work of loading the resource might be initiated on another thread, running asynchronously to the resource loading delegate; whether the work begins immediately or merely soon is an implementation detail of the client application.

You can load the resource synchronously or asynchronously. In both cases, you must indicate success or failure of the operation by calling the finishLoadingWithResponse:data:redirect: or finishLoadingWithError: method of the request object when you finish. If you load the resource asynchronously, you must also store a strong reference to the object in the loadingRequest parameter before returning from this method.

If you return NO from this method, the resource loader treats the loading of the resource as having failed.

- `resourceLoader:didCancelLoadingRequest:`

Invoked to inform the delegate that a prior loading request has been cancelled

Discussion:

Previously issued loading requests can be cancelled when data from the resource is no longer required or when a loading request is superseded by new requests for data from the same resource.

For example, if to complete a seek operation it becomes necessary to load a range of bytes that's different from a range previously requested, the prior request may be cancelled while the delegate is still handling it.

- `resourceLoader:shouldWaitForRenewalOfRequestedResource:`

Invoked when assistance is required of the application to renew a resource.

Return value:

YES if the delegate can renew the resource; otherwise NO.

Discussion:

Delegates receive this message when assistance is required to renew a resource previously loaded by resourceLoader:shouldWaitForLoadingOfRequestedResource:. For example, this method is invoked to for decryption keys that require renewal, as indicated in a response to a prior invocation of resourceLoader:shouldWaitForLoadingOfRequestedResource:.

If the result is YES, the resource loader expects invocation, either subsequently or immediately, of either the AVAssetResourceRenewalRequest method finishLoading or finishLoadingWithError:. If you intend to finish loading the resource after your handling of this message returns, you must retain the renewalRequest until after loading is finished.

If the result is NO, the resource loader treats the loading of the resource as having failed.

> Note
> If the delegate's implementation of -resourceLoader:shouldWaitForLoadingOfRequestedResource: returns YES without finishing the loading request immediately, it may be invoked again with another loading request before the prior request is finished; therefore in such cases the delegate should be prepared to manage multiple loading requests.

## 处理验证问题

- `resourceLoader:didCancelAuthenticationChallenge:`

Informs the delegate that a prior authentication challenge has been cancelled.

- `resourceLoader:shouldWaitForResponseToAuthenticationChallenge:`

Invoked when assistance is required of the application to respond to an authentication challenge.

Return Value:

YES if the resource loader should wait for a response to the authentication challenge; otherwise NO.

Discussion:

Delegates receive this message when assistance is required of the application to respond to an authentication challenge.

Return YES if you expect a response either subsequently or immediately to the authenticationChallenger object’s sender.

If you intend to respond to the authentication challenge after your handling of resourceLoader:shouldWaitForResponseToAuthenticationChallenge: returns, you must retain the authenticationChallenge until after your response has been made.
