// 逐步下载图片

// The following code is from http://www.cocoaintheshell.com/2011/05/progressive-images-download-imageio/
// Thanks to the author @Nyx0uf

// Get the total bytes downloaded
const NSInteger totalSize = self.imageData.length;

// Update the data source, we must pass ALL the data, not just the new bytes
CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)self.imageData, NULL);

if (width + height == 0) {
    CFDictionaryRef properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, NULL);
    if (properties) {
        NSInteger orientationValue = -1;
        CFTypeRef val = CFDictionaryGetValue(properties, kCGImagePropertyPixelHeight);
        if (val) CFNumberGetValue(val, kCFNumberLongType, &height);
        val = CFDictionaryGetValue(properties, kCGImagePropertyPixelWidth);
        if (val) CFNumberGetValue(val, kCFNumberLongType, &width);
        val = CFDictionaryGetValue(properties, kCGImagePropertyOrientation);
        if (val) CFNumberGetValue(val, kCFNumberNSIntegerType, &orientationValue);
        CFRelease(properties);
        
        // When we draw to Core Graphics, we lose orientation information,
        // which means the image below born of initWithCGIImage will be
        // oriented incorrectly sometimes. (Unlike the image born of initWithData
        // in didCompleteWithError.) So save it here and pass it on later.
#if SD_UIKIT || SD_WATCH
        orientation = [[self class] orientationFromPropertyValue:(orientationValue == -1 ? 1 : orientationValue)];
#endif
    }
}

if (width + height > 0 && totalSize < self.expectedSize) {
    // Create the image
    CGImageRef partialImageRef = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
    
#if SD_UIKIT || SD_WATCH
    // Workaround for iOS anamorphic image
    if (partialImageRef) {
        const size_t partialHeight = CGImageGetHeight(partialImageRef);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, width * 4, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
        CGColorSpaceRelease(colorSpace);
        if (bmContext) {
            CGContextDrawImage(bmContext, (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = partialHeight}, partialImageRef);
            CGImageRelease(partialImageRef);
            partialImageRef = CGBitmapContextCreateImage(bmContext);
            CGContextRelease(bmContext);
        }
        else {
            CGImageRelease(partialImageRef);
            partialImageRef = nil;
        }
    }
#endif
    
    if (partialImageRef) {
#if SD_UIKIT || SD_WATCH
        UIImage *image = [UIImage imageWithCGImage:partialImageRef scale:1 orientation:orientation];
#elif SD_MAC
        UIImage *image = [[UIImage alloc] initWithCGImage:partialImageRef size:NSZeroSize];
#endif
        NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:self.request.URL];
        UIImage *scaledImage = [self scaledImageForKey:key image:image];
        if (self.shouldDecompressImages) {
            image = [UIImage decodedImageWithImage:scaledImage];
        }
        else {
            image = scaledImage;
        }
        CGImageRelease(partialImageRef);
        
        [self callCompletionBlocksWithImage:image imageData:nil error:nil finished:NO];
    }
}

CFRelease(imageSource);
