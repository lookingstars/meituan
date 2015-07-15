//
//  MAOverlayView.h
//  MAMapKit
//
//
//  Copyright (c) 2011年 Autonavi Inc. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MAGeometry.h"
#import "MAOverlay.h"
#import "MALineDrawType.h"

#define kMAOverlayViewDefaultStrokeColor [UIColor colorWithRed:0.3 green:0.63 blue:0.89 alpha:0.8]
#define kMAOverlayViewDefaultFillColor [UIColor colorWithRed:0.77 green:0.88 blue:0.94 alpha:0.8]

/*!
 @brief 该类是地图覆盖物View的基类, 提供绘制overlay的接口但并无实际的实现
 */
@interface MAOverlayView : UIView

/*!
 @brief 初始化并返回一个overlay view
 @param overlay 关联的overlay对象
 @return 初始化成功则返回overlay view,否则返回nil
 */
- (id)initWithOverlay:(id <MAOverlay>)overlay;

/*!
 @brief 关联的overlay对象
 */
@property (nonatomic, readonly, retain) id <MAOverlay> overlay;

/*!
 @brief 将MAMapPoint转化为相对于receiver的本地坐标
 @param mapPoint 要转化的MAMapPoint
 @return 相对于receiver的本地坐标
 */
- (CGPoint)pointForMapPoint:(MAMapPoint)mapPoint;

/*!
 @brief 将相对于receiver的本地坐标转化为MAMapPoint
 @param point 要转化的相对于receiver的本地坐标
 @return MAMapPoint
 */
- (MAMapPoint)mapPointForPoint:(CGPoint)point;

/*!
 @brief 将MAMapRect转化为相对于receiver的本地rect
 @param mapRect 要转化的MAMapRect
 @return 相对于receiver的本地rect
 */
- (CGRect)rectForMapRect:(MAMapRect)mapRect;

/*!
 @brief 将相对于receiver的本地rect转化为MAMapRect
 @param rect 要转化的相对于receiver的本地rect
 @return MAMapRect
 */
- (MAMapRect)mapRectForRect:(CGRect)rect;

/*!
 @brief 绘制overlay view的内容
 @param mapRect 该MAMapRect范围内需要更新
 @param zoomScale 当前的缩放比例值
 @param context 绘制操作的graphics context
 */
- (void)drawMapRect:(MAMapRect)mapRect
          zoomScale:(CGFloat)zoomScale
          inContext:(CGContextRef)context;

/*!
 @brief 缓存的OpenGLES坐标
 */
@property (nonatomic) CGPoint *glPoints;

/*!
 @brief 缓存的OpenGLES坐标 个数
 */
@property (nonatomic) NSUInteger glPointCount;

/*!
 @brief 将MAMapPoint转换为opengles可以直接使用的坐标
 @param mapPoint MAMapPoint坐标
 @return opengles 直接支持的坐标
 */
- (CGPoint)glPointForMapPoint:(MAMapPoint)mapPoint;

/*!
 @brief 批量将MAMapPoint转换为opengles可以直接使用的坐标
 @param mapPoint MAMapPoint坐标数据指针
 @param count 个数
 @return opengles 直接支持的坐标数据指针(需要调用者手动释放)
 */
- (CGPoint *)glPointsForMapPoints:(MAMapPoint *)mapPoints count:(NSUInteger)count;

/*!
 @brief 将屏幕尺寸转换为OpenGLES尺寸
 @param windowWidth 屏幕尺寸
 @return OpenGLES尺寸
 */
- (CGFloat)glWidthForWindowWidth:(CGFloat)windowWidth;

/*!
 @brief OpenGLES坐标系发生改变, 重新计算缓存的OpenGLES坐标
 */
- (void)referenceDidChange;

/*!
 @brief 使用OpenGLES 绘制线
 @param points OpenGLES坐标系点指针, 参考- (CGPoint)glPointForMapPoint:(MAMapPoint)mapPoint, - (CGPoint *)glPointsForMapPoints:(MAMapPoint *)mapPoints count:(NSUInteger)count
 @param pointCount 点个数
 @param strokeColor 线颜色
 @param lineWidth OpenGLES支持线宽尺寸, 参考 - (CGFloat)glWidthForWindowWidth:(CGFloat)windowWidth
 @param looped 是否闭合, 如polyline会设置NO, polygon会设置YES.
 */
- (void)renderLinesWithPoints:(CGPoint *)points
                   pointCount:(NSUInteger)pointCount
                  strokeColor:(UIColor *)strokeColor
                    lineWidth:(CGFloat)lineWidth
                       looped:(BOOL)looped;

/*!
 使用OpenGLES 绘制线
 @param points       OpenGLES坐标系点指针, 参考- (CGPoint)glPointForMapPoint:(MAMapPoint)mapPoint, - (CGPoint *)glPointsForMapPoints:(MAMapPoint *)mapPoints count:(NSUInteger)count
 @param pointCount   点个数
 @param strokeColor  线颜色
 @param lineWidth    OpenGLES支持线宽尺寸, 参考 - (CGFloat)glWidthForWindowWidth:(CGFloat)windowWidth
 @param looped       是否闭合, 如polyline会设置NO, polygon会设置YES.
 @param lineJoinType 线连接点样式
 @param lineCapType  线端点样式
 @param lineDash     是否是虚线
 */
- (void)renderLinesWithPoints:(CGPoint *)points
                   pointCount:(NSUInteger)pointCount
                  strokeColor:(UIColor *)strokeColor
                    lineWidth:(CGFloat)lineWidth
                       looped:(BOOL)looped
                 LineJoinType:(MALineJoinType)lineJoinType
                  LineCapType:(MALineCapType)lineCapType
                     lineDash:(BOOL)lineDash;

/*!
 使用OpenGLES 按指定纹理绘制线
 @param points     OpenGLES坐标系点指针, 参考- (CGPoint)glPointForMapPoint:(MAMapPoint)mapPoint, - (CGPoint *)glPointsForMapPoints:(MAMapPoint *)mapPoints count:(NSUInteger)count
 @param pointCount 点个数
 @param lineWidth  线OpenGLES支持线宽尺寸, 参考 - (CGFloat)glWidthForWindowWidth:(CGFloat)windowWidth
 @param textureID  指定的纹理 使用- (void)loadStrokeTextureImage:(UIImage *)textureImage;加载
 @param looped     是否闭合, 如polyline会设置NO, polygon会设置YES.
 */
- (void)renderTexturedLinesWithPoints:(CGPoint *)points
                           pointCount:(NSUInteger)pointCount
                            lineWidth:(CGFloat)lineWidth
                            textureID:(GLuint)textureID
                               looped:(BOOL)looped;

/*!
 @brief 使用OpenGLES 绘制区域
 @param points OpenGLES坐标系点指针, 参考- (CGPoint)glPointForMapPoint:(MAMapPoint)mapPoint, - (CGPoint *)glPointsForMapPoints:(MAMapPoint *)mapPoints count:(NSUInteger)count
 @param pointCount 点个数
 @param fillColor 填充颜色
 @param usingTriangleFan YES对应GL_TRIANGLE_FAN, NO对应GL_TRIANGLES
 */
- (void)renderRegionWithPoints:(CGPoint *)points
                    pointCount:(NSUInteger)pointCount
                     fillColor:(UIColor *)fillColor
              usingTriangleFan:(BOOL)usingTriangleFan;

/*!
 @brief 使用OpenGLES 绘制区域
 @param points OpenGLES坐标系点指针, 参考- (CGPoint)glPointForMapPoint:(MAMapPoint)mapPoint, - (CGPoint *)glPointsForMapPoints:(MAMapPoint *)mapPoints count:(NSUInteger)count
 @param pointCount 点个数
 @param fillColor 填充颜色
 @param strokeLineWidth 边缘宽度
 @param usingTriangleFan YES对应GL_TRIANGLE_FAN, NO对应GL_TRIANGLES
 */
- (void)renderRegionWithPoints:(CGPoint *)points
                    pointCount:(NSUInteger)pointCount
                     fillColor:(UIColor *)fillColor
               strokeLineWidth:(CGFloat)strokeLineWidth
              usingTriangleFan:(BOOL)usingTriangleFan;

/*!
 @brief 使用OpenGLES 绘制图片
 @param textureID OpenGLES纹理ID
 @param points OpenGLES坐标系点指针,纹理矩形的四个顶点坐标,其第一个坐标为图片左上角，依次顺时针传入其他顶点 ,参考- (CGPoint)glPointForMapPoint:(MAMapPoint)mapPoint, - (CGPoint *)glPointsForMapPoints:(MAMapPoint *)mapPoints count:(NSUInteger)count ，
 */
- (void)renderIconWithTextureID:(GLuint)textureID points:(CGPoint *)points;

/*!
 @brief 使用OpenGLES 绘制图片
 @param textureID OpenGLES纹理ID
 @param points OpenGLES坐标系点指针,纹理矩形的四个顶点坐标,其第一个坐标为图片左上角，依次顺时针传入其他顶点 ,参考- (CGPoint)glPointForMapPoint:(MAMapPoint)mapPoint, - (CGPoint *)glPointsForMapPoints:(MAMapPoint *)mapPoints count:(NSUInteger)count ，
 @param modulateColor 调节颜色值, 最终颜色 = 纹理色 * modulateColor. 如只需要调节alpha的话就设置为[red=1, green=1, blue=1, alpha=0.5].
 */
- (void)renderIconWithTextureID:(GLuint)textureID points:(CGPoint *)points modulateColor:(UIColor *)modulateColor;


/*!
 @brief 绘制函数(子类需要重载来实现)
 */
- (void)glRender;


#pragma mark - draw property

/*!
 @brief 笔触纹理id
 修改纹理id参考 - (GLuint)loadStrokeTextureImage:(UIImage *)textureImage;
 */
@property (nonatomic, readonly) GLuint strokeTextureID;

/*!
 加载纹理图片，纹理ID存储在成员strokeTextureID中。纹理图片为nil时，清空原有纹理。
 @param textureImage 纹理图片（需满足：长宽相等，且宽度值为2的次幂）。若为nil，则清空原有纹理。
 @return openGL纹理ID, 若纹理加载失败返回0。
 */
- (GLuint)loadStrokeTextureImage:(UIImage *)textureImage;

@end

@interface MAOverlayView(Deprecated)

/*!
 @brief 使用OpenGLES 绘制线
 @param points OpenGLES坐标系点指针, 参考- (CGPoint)glPointForMapPoint:(MAMapPoint)mapPoint, - (CGPoint *)glPointsForMapPoints:(MAMapPoint *)mapPoints count:(NSUInteger)count
 @param pointCount 点个数
 @param strokeColor 线颜色
 @param lineWidth OpenGLES支持线宽尺寸, 参考 - (CGFloat)glWidthForWindowWidth:(CGFloat)windowWidth
 @param looped 是否闭合, 如polyline会设置NO, polygon会设置YES.
 @param lineDash 是否是虚线.
 */
- (void)renderLinesWithPoints:(CGPoint *)points pointCount:(NSUInteger)pointCount strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth looped:(BOOL)looped lineDash:(BOOL)lineDash __attribute__ ((deprecated("use - (void)renderLinesWithPoints:(CGPoint *)points pointCount:(NSUInteger)pointCount strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth looped:(BOOL)looped LineJoinType:(MALineJoinType)lineJoinType LineCapType:(MALineCapType)lineCapType lineDash:(BOOL)lineDash; instead")));

@end
