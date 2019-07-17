
#import <Foundation/Foundation.h>

// 定义了在缩放图片时，以哪条边作为参考边
typedef enum{
    EUIImageZommLineDefault,  // 默认值
    EUIImageZommLineWidth, // 宽作为参考边
    EUIImageZommLineHeight, // 高作为参考边
    EUIImageZommLineLonger, // 长边作为参考边
    EUIImageZommLineShorter, // 短边作为参考边
    EUIImageZommLineNone,     // 不区分边
} UIImageZommLine;

@interface UIImage (Additions)
// 缩放图片
+ (UIImage *)scaleImage:(UIImage *)image scaleToSize:(CGSize)size;
//截取部分图像  
+ (UIImage*)getSubImage:(UIImage *)img rect:(CGRect)rect;
//中间拉伸自动宽高
+ (UIImage*)middleStretchableImage:(UIImage*)image;
//中间拉伸图片
+ (UIImage *)middleStretchableImageWithOutSupportSkin:(NSString *)key;

+ (UIImage *) createRoundedRectImage:(UIImage*)image size:(CGSize)size cornerRadius:(CGFloat)radius;

// 缩放图片并且剧中截取
+ (UIImage *)middleScaleImage:(UIImage *)image scaleToSize:(CGSize)size;
//宽高取小缩放，取大居中截取
+ (UIImage *)suitableScaleImage:(UIImage *)image scaleToSize:(CGSize)size;
//等比缩放到多少倍
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
//等比例缩放  
+(UIImage*)scaleToSize:(UIImage*)image size:(CGSize)size;
// zhengzheng
//等比缩放
+ (UIImage *) scaleImageForImage:(UIImage *)image toScale:(float)scaleSize;
- (UIImage *)fixOrientation;

-(UIImage*)scaleWithMaxSize:(CGFloat)maxSize;
-(UIImage*)scaleWithMaxSize:(CGFloat)maxSize quality:(CGInterpolationQuality)quality;
// 矩形图片截取成圆形
- (UIImage *)circleImage;
//
+(BOOL)writeImage:(UIImage *)image toFileAtPath:(NSString *)aPath;
//截取部分图像(区分高分屏或者低分屏)
/* ++++++++++++++++++++++++++++++++++++++
 *
 * zhengzheng 
 
    @param img 需要被截取的图片
    @param scale  倍率（低分屏1.0 高分屏2.0）
    @param rect 截取的范围
    @return 返回截取后的图片
 */
+ (UIImage*)getSubImage:(UIImage *)img scale:(CGFloat)scale rect:(CGRect)rect;
/* ------------------------------------- */
+ (UIImage *)zoomListImageWithImage:(UIImage *)image;
+ (UIImage *)zoomUploadImageWith:(UIImage *)image rate:(CGFloat)rate maxLength:(CGFloat)length quality:(CGFloat)quality limitSize:(long long)spaceSize;
+ (UIImage *)zoomThumbnailWith:(UIImage *)image rate:(CGFloat)rate maxLength:(CGFloat)length;
+ (long long)check:(UIImage *)image;
@end
