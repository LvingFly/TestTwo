

#import "UIImage+Additions.h"

#define kUIImageLongLineLimit 206
#define kUIImageShortLintLimit 68

#define kUIImageForUploadMaxLength 1080
#define kUIImageForUploadUnHandleLength 10800

#define kUIImageForUploadZoomRate 0.9

static void AddRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
								 float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
		CGContextAddRect(context, rect);
		return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

@implementation UIImage (Additions)
// 矩形图片截取成圆形
- (UIImage *)circleImage
{
    NSInteger inset = 0;
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, self.size.width - inset * 2.0f, self.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [self drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    newimg = [UIImage suitableScaleImage:newimg scaleToSize:CGSizeMake(self.size.width - inset * 2.0f, self.size.height - inset * 2.0f)];
    return newimg;
//    [self.layer setCornerRadius:CGRectGetHeight([self bounds]) / 2];  //修改半径，实现头像的圆形化
//    self.layer.masksToBounds = YES;
}
//
+ (BOOL)writeImage:(UIImage *)image toFileAtPath:(NSString *)aPath
{
    if ((image == nil) || (aPath == nil) || ([aPath isEqualToString:@""]))
        
        return NO;
    
//    @try {
    
        NSData *imageData = nil;
        NSString *ext = [aPath pathExtension];
        
//        if ([ext isEqualToString:@"png"]) {
//            
//            imageData = UIImagePNGRepresentation(image);
//            
//        } else {
//            
//            imageData = UIImageJPEGRepresentation(image, 0);
//            
//        }
        if (UIImagePNGRepresentation(image) == nil)
        {
            imageData = UIImageJPEGRepresentation(image, 1.0);
        }
        else{
            imageData = UIImagePNGRepresentation(image);
        }
        if ((imageData == nil) || ([imageData length] <= 0))
            
            return NO;
        
        [imageData writeToFile:aPath atomically:YES];
        
        return YES;
        
//    }
//    
//    @catch (NSException *e) {
//        
//        NSLog(@"create thumbnail exception.");
//    }
    return NO;
}
+ (UIImage *)scaleImage:(UIImage *)image scaleToSize:(CGSize)size {    
    // 创建一个bitmap的context    
    // 并把它设置成为当前正在使用的context    
    UIGraphicsBeginImageContext(size);    
    
    // 绘制改变大小的图片    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];    
    
    // 从当前context中创建一个改变大小后的图片    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();    
    
    // 使当前的context出堆栈    
    UIGraphicsEndImageContext();    
    
    // 返回新的改变大小后的图片    
    return scaledImage;
}

//截取部分图像  
+ (UIImage*)getSubImage:(UIImage *)img rect:(CGRect)rect  
{  
    CGImageRef subImageRef = CGImageCreateWithImageInRect(img.CGImage, rect);  
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));  
    
    UIGraphicsBeginImageContext(smallBounds.size);  
    CGContextRef context = UIGraphicsGetCurrentContext();  
    CGContextDrawImage(context, smallBounds, subImageRef);  
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];  
    UIGraphicsEndImageContext();  
    
    CGImageRelease(subImageRef);
    return smallImage;  
} 

//截取部分图像(区分高分屏或者低分屏)
+ (UIImage*)getSubImage:(UIImage *)img scale:(CGFloat)scale rect:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(img.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    // 此处有可能生成的图片比需要生成的图片大，故作以下判断  zhengzheng
    if(!CGSizeEqualToSize(smallBounds.size, rect.size))
    {
        CGImageRelease(subImageRef);
        subImageRef = nil;
        int wOffset = smallBounds.size.width - rect.size.width;
        int hOffset = smallBounds.size.height - rect.size.height;
        rect.size.width = rect.size.width - wOffset;
        rect.size.height = rect.size.height - hOffset;
        subImageRef = CGImageCreateWithImageInRect(img.CGImage, rect);
        smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    }
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
//    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    
    CGImageRelease(subImageRef);
    return smallImage;
}

+ (UIImage*)middleStretchableImage:(UIImage*)image {
    return [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}

//中间拉伸图片,不支持换肤
+ (UIImage *)middleStretchableImageWithOutSupportSkin:(NSString *)key {
    UIImage *image = [UIImage imageNamed:key];
    return [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}

/*create round rect UIImage with the specific size*/
+ (UIImage *) createRoundedRectImage:(UIImage*)image size:(CGSize)size cornerRadius:(CGFloat)radius
{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    AddRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *imageMask = [UIImage imageWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    return imageMask;
	
}
//等比缩放
+ (UIImage *) scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));  
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();  
    UIGraphicsEndImageContext();  
    return scaledImage;  
}  

// zhengzheng
//等比缩放
+ (UIImage *) scaleImageForImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

// 缩放图片并且剧中截取
+ (UIImage *)middleScaleImage:(UIImage *)image scaleToSize:(CGSize)size{
    float scaleSize = 0.0;
    float screenScale = [UIScreen mainScreen].scale;
    CGSize imagesize = [image size];
    if (imagesize.width >= imagesize.height) {
        scaleSize = size.height/imagesize.height * screenScale;
    }else{
        scaleSize = size.width/imagesize.width * screenScale;
    }
    UIImage *currentimage = [UIImage scaleImage:image toScale:scaleSize];
    CGRect currentfram = CGRectMake((currentimage.size.width - size.width)/2, (currentimage.size.height - size.height)/2, size.width, size.height);

    // 返回新的改变大小后的图片    
    return [UIImage getSubImage:currentimage rect:currentfram];
}
#pragma mark -

//宽高取小缩放，取大居中截取
+ (UIImage *)suitableScaleImage:(UIImage *)image scaleToSize:(CGSize)size
{
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGSize imageSize = image.size;
    CGFloat realScale = 0.0f;
    UIImage *tmpImage = nil;
    CGFloat imageSizeMax = MAX(imageSize.width, imageSize.height);
    CGFloat imageSizeMin = MIN(imageSize.width, imageSize.height);
    
    //短边大于定长
    if ( imageSizeMin >= size.width/* * screenScale*/ ) {
        if ( imageSize.width <= imageSize.height ) {
            realScale = size.width / imageSize.width * screenScale;
            UIImage *currentImage = [UIImage scaleImage:image toScale:realScale];
            tmpImage = [UIImage getSubImage:currentImage scale:screenScale rect:CGRectMake(0, ( currentImage.size.height - size.height * screenScale ) / 2.0f, size.width * screenScale, size.height *screenScale)];
        }
        else
        {
            realScale = size.height / imageSize.height * screenScale;
            UIImage *currentImage = [UIImage scaleImage:image toScale:realScale];
            tmpImage = [UIImage getSubImage:currentImage scale:screenScale rect:CGRectMake( ( currentImage.size.width - size.width * screenScale ) / 2.0f, 0, size.width * screenScale, size.height * screenScale)];
        }
    }
    else
    {   //短边小于定长，长边大于定长
        if ( imageSizeMax > size.width/* * screenScale*/ ) {
            if ( imageSize.width < imageSize.height ) {
                tmpImage = [UIImage getSubImage:image scale:screenScale rect:CGRectMake(0, ( imageSize.height - size.height * screenScale ) / 2.0f, size.width * screenScale, size.height *screenScale)];
            }
            else
            {
                tmpImage = [UIImage getSubImage:image scale:screenScale rect:CGRectMake( ( imageSize.width - size.width * screenScale ) / 2.0f, 0, size.width * screenScale, size.height * screenScale)];
            }
        }
        else //长短边都小于定长
        {
            tmpImage = image;
        }
    }
    
    return tmpImage;
}

//等比例缩放
+(UIImage*)scaleToSize:(UIImage*)image size:(CGSize)size   
{  
    CGFloat width = CGImageGetWidth(image.CGImage);  
    CGFloat height = CGImageGetHeight(image.CGImage);  
    
    float verticalRadio = size.height*1.0/height;   
    float horizontalRadio = size.width*1.0/width;  
    
    float radio = 1;  
    if(verticalRadio>1 && horizontalRadio>1)  
    {  
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;     
    }  
    else  
    {  
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;     
    }  
    
    width = width*radio;  
    height = height*radio;  
    
    int xPos = (size.width - width)/2;  
    int yPos = (size.height-height)/2;  
    
    // 创建一个bitmap的context    
    // 并把它设置成为当前正在使用的context    
    UIGraphicsBeginImageContext(size);    
    
    // 绘制改变大小的图片    
    [image drawInRect:CGRectMake(xPos, yPos, width, height)];    
    
    // 从当前context中创建一个改变大小后的图片    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();    
    
    // 使当前的context出堆栈    
    UIGraphicsEndImageContext();    
    
    // 返回新的改变大小后的图片    
    return scaledImage;  
} 

- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

-(UIImage*)scaleWithMaxSize:(CGFloat)maxSize
{
    return [self scaleWithMaxSize:maxSize quality:kCGInterpolationHigh];
}

-(UIImage*)scaleWithMaxSize:(CGFloat)maxSize
                    quality:(CGInterpolationQuality)quality
{
    CGRect        bnds = CGRectZero;
    UIImage*      copy = nil;
    CGContextRef  ctxt = nil;
    CGRect        orig = CGRectZero;
    CGFloat       rtio = 0.0;
    CGFloat       scal = 1.0;

    bnds.size = self.size;
    orig.size = self.size;
    rtio = orig.size.width / orig.size.height;

    if ((orig.size.width <= maxSize) && (orig.size.height <= maxSize))
    {
        return self;
    }

    if (rtio > 1.0)
    {
        bnds.size.width  = maxSize;
        bnds.size.height = maxSize / rtio;
    }
    else
    {
        bnds.size.width  = maxSize * rtio;
        bnds.size.height = maxSize;
    }

    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();

    scal = bnds.size.width / orig.size.width;
    CGContextSetInterpolationQuality(ctxt, quality);
    CGContextScaleCTM(ctxt, scal, -scal);
    CGContextTranslateCTM(ctxt, 0.0, -orig.size.height);
    CGContextDrawImage(ctxt, orig, self.CGImage);

    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return copy;
}



+ (UIImage *) zoomListImageWithImage:(UIImage *)image
{
    if(!image)
    {
        return image;
    }
    CGSize imageSize = image.size;
    CGFloat imageHeight = imageSize.height;
    CGFloat imageWidth = imageSize.width;
    CGFloat scale = 1.0;
    CGRect realRect = CGRectZero;
    CGFloat determin = 0.0;
    if(imageWidth > imageHeight)
    {
        if(imageWidth <= imageHeight * 1.7)
        {
            // 获取长边最后展示出来时的长度
            determin = [UIScreen mainScreen].scale * kUIImageLongLineLimit;
            if(imageWidth <= determin)
            {
                // 如果图像的长边小于需要显示的长度。直接返回
                return image ;
            }
            // 获取缩小的比例
            scale = determin / imageWidth;
            //不需要裁剪
            realRect = CGRectZero;
        }
        else
        {
            float tempWidth = imageHeight * 1.7;
            // 获取长边最后展示出来时的长度
            determin = [UIScreen mainScreen].scale * kUIImageLongLineLimit;
            // 计算缩小的比例
            scale = tempWidth > determin ? determin / tempWidth : 1.0;
            // 计算要截取的图像的大小
            realRect.origin.x = (imageWidth - tempWidth) / 2;
            realRect.origin.y = 0;
            realRect.size.width = tempWidth;
            realRect.size.height = imageHeight;
        }
    }
    else
    {
        if(imageHeight <= imageWidth * 1.7)
        {
            determin = [UIScreen mainScreen].scale * kUIImageLongLineLimit;
            if(imageHeight <= determin)
            {
                return image;
            }
            scale = determin / imageHeight;
            realRect = CGRectZero;
        }
        else
        {
            float tempHeight= imageWidth * 1.7;
            determin = [UIScreen mainScreen].scale * kUIImageLongLineLimit;
            scale = tempHeight > determin ? determin / tempHeight : 1.0;
            realRect.origin.x = 0;
            realRect.origin.y = (imageHeight - tempHeight) / 2;
            realRect.size.width = imageWidth;
            realRect.size.height = tempHeight;
            
        }
    }
    //先裁剪，后压缩
    UIImage *tempImage = nil;
    if (!CGRectIsEmpty(realRect)) {
        tempImage = [UIImage getSubImage:image scale:[[UIScreen mainScreen] scale] rect:realRect];
    }
    else
    {
        tempImage = image;
    }
    
    if(scale < 1.0)
    {
        // 需要压缩
        return [UIImage scaleImageForImage:tempImage toScale:scale];
    }
    else
    {
        return tempImage;
    }
}

/*
 * 获取图片缩略图
 * image: 原始图片
 * rate: 长短边的临界比例
 * length: 长边最大长度
 */
+ (UIImage *)zoomThumbnailWith:(UIImage *)image rate:(CGFloat)rate maxLength:(CGFloat)length
{
    if(image == nil || rate <= 1)
    {
        return image;
    }
    
    CGSize imageSize = image.size;
    
    if(imageSize.width <= length && imageSize.height <= length)
    {
        return image;
    }
    
    if((imageSize.height >= imageSize.width && imageSize.height <= rate * imageSize.width) || (imageSize.width > imageSize.height && imageSize.width <= rate * imageSize.height))
    {
        return [UIImage zoomImageWith:image line:EUIImageZommLineLonger toLength:length isNeedStrench:NO adjustScreenScale:YES];
    }
    else if(imageSize.height > rate * imageSize.width || imageSize.width > rate * imageSize.height)
    {
        // 按rate截取中间部分
        BOOL isWidth = (imageSize.height > rate * imageSize.width) ? NO : YES;
        CGRect newRect = CGRectZero;
        if(isWidth)
        {
            newRect.origin.x = (imageSize.width - imageSize.height * rate) / 2;
            newRect.origin.y = 0;
            newRect.size.width = imageSize.height * rate;
            newRect.size.height = imageSize.height;
        }
        else
        {
            newRect.origin.x = 0;
            newRect.origin.y = (imageSize.height - imageSize.width * rate) / 2;
            newRect.size.width = imageSize.width;
            newRect.size.height = imageSize.width * rate;
        }
        
        UIImage *tempImage = [UIImage getSubImage:image rect:newRect];
        return [UIImage zoomImageWith:tempImage line:EUIImageZommLineLonger toLength:length isNeedStrench:NO adjustScreenScale:YES];
    }
    return image;
}

/*
 * 缩放上传的图片 
 * image: 需要缩放的图片
 * rate: 给定的比例（跟具体业务逻辑相关, 需要大于1）
 * length: 最大长度
 * quality: 图片质量 0～1
 * spaceSize: 最大空间大小，单位byte
 */
+ (UIImage *)zoomUploadImageWith:(UIImage *)image rate:(CGFloat)rate maxLength:(CGFloat)length quality:(CGFloat)quality limitSize:(long long)spaceSize
{
    if(image == nil || rate <= 1 || spaceSize == 0)
    {
        return image;
    }
    
    if(quality <= 0 || quality > 1.0)
    {
        return image;
    }
    
    CGSize imageSize = image.size;
    UIImage *returnImage = nil;
    
    if((imageSize.height >= imageSize.width && imageSize.height <= rate * imageSize.width) || (imageSize.width >= imageSize.height && imageSize.width <= rate * imageSize.height))
    {
        // 如果长宽的比例小于rate，则以长边为参考边尽心压缩
        returnImage = [UIImage zoomImageWith:image line:EUIImageZommLineLonger toLength:length isNeedStrench:NO adjustScreenScale:NO];
    }
    else if(imageSize.width > rate * imageSize.height || imageSize.height > rate * imageSize.width)
    {
        // 如果长宽的比例大于rate，则以短边作为参考边进行压缩
        returnImage = [UIImage zoomImageWith:image line:EUIImageZommLineShorter toLength:length isNeedStrench:NO adjustScreenScale:NO];
    }
    
    if(quality < 1.0)
    {
        // 根据传进来的图片质量来重新生成image
        NSData *imageData = UIImageJPEGRepresentation(returnImage, quality);
        returnImage = [UIImage imageWithData:imageData];
    }
    
    if([UIImage check:returnImage] > spaceSize)
    {
        return [UIImage zoomUploadImageWith:returnImage rate:rate maxLength:length * kUIImageForUploadZoomRate quality:1.0 limitSize:spaceSize];
    }
    else
    {
        return returnImage;
    }
}

/*
 * 根据指定边作为参考边来等比的缩放图片
 * image:需要缩放的图片
 * line:参考边
 * length:参考边最后需要的长度
 * isNeedStrench:是否支持拉伸
 * adjustScreenScale: 是否需要适应高低分屏
 */
+ (UIImage *)zoomImageWith:(UIImage *)image line:(UIImageZommLine)line toLength:(CGFloat)length isNeedStrench:(BOOL)isNeedStrench adjustScreenScale:(BOOL)adjustScreenScale
{
    if(image == nil || length <= 0)
    {
        return image;
    }
    
    CGSize imageSize = image.size;
    CGFloat lineLength = 0;
    CGSize newSize = CGSizeZero;
    BOOL isWidth = NO;
    
    switch (line)
    {
        case EUIImageZommLineDefault:
//            break;
        case EUIImageZommLineWidth:
            lineLength = imageSize.width;
            isWidth = YES;
            break;
        case EUIImageZommLineHeight:
            lineLength = imageSize.height;
            isWidth = NO;
            break;
        case EUIImageZommLineLonger:
            lineLength = (imageSize.width > imageSize.height) ? imageSize.width : imageSize.height;
            isWidth = (imageSize.width > imageSize.height) ? YES : NO;
            break;
        case EUIImageZommLineShorter:
            lineLength = (imageSize.width < imageSize.height) ? imageSize.width : imageSize.height;
            isWidth = (imageSize.width < imageSize.height) ? YES : NO;
            break;
        case EUIImageZommLineNone:
            break;
        default:
            break;
    }
    
    if(!isNeedStrench)
    {
        // 如果不需要拉伸，则当参考边大于给定长度时才进行压缩，否则不作处理
        
        if(lineLength <= length || lineLength <= 0)
        {
            return image;
        }
    }
    else
    {
        // 如果需要拉伸，则当参考边小于给定长度时才进行拉伸，否则不作处理
        if(lineLength >= length || lineLength <= 0)
        {
            return image;
        }
    }
    
    if(isWidth)
    {
        newSize = CGSizeMake(length, length / lineLength * imageSize.height);
    }
    else
    {
        newSize = CGSizeMake(length / lineLength * imageSize.width, length);
    }
    
//    return [UIImage zoomImageWithImage:image size:newSize andQuality:kCGInterpolationLow adjustScreenScale:adjustScreenScale];
    return [UIImage scaleImage:image scaleToSize:newSize];
    
}

/*
 * 获取图片的大小
 */
+ (long long)check:(UIImage *)image
{
    if(image == nil)
    {
        return 0;
    }
    @autoreleasepool
    {
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        
        if(imageData == nil)
        {
            imageData = UIImagePNGRepresentation(image);
        }
        
        return (imageData == nil) ? 0 : (long long)[imageData length];
    }
}


/*
 * 图片缩放方法
 * prama image:需要被缩放的图片
 * prama newSize:缩放后的大小
 * prama quality:图片缩放后的质量
 * prama adjustScreenScale: 缩放的图片是否要适应屏幕（高清屏）
 */
+ (UIImage *)zoomImageWithImage:(UIImage *)image size:(CGSize)newSize andQuality:(CGInterpolationQuality)quality adjustScreenScale:(BOOL)adjustScreenScale
{
    if(image == nil)
    {
        return image;
    }
    
    CGRect newRect = CGRectMake(0, 0, newSize.width, newSize.height);
    
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            newRect = CGRectMake(0, 0, newSize.height, newSize.width);
            break;
        default:
            break;
    }
    
    CGImageRef imageRef = image.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    // Set the quality level to use when rescaling
//    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    float scale = adjustScreenScale ? [[UIScreen mainScreen] scale] : 1.0;
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:scale orientation:image.imageOrientation];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

@end








