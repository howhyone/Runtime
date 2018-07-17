//
//  ViewController.m
//  Runtime
//
//  Created by mob on 2018/6/26.
//  Copyright © 2018年 mob. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "FirstView.h"
#import "Lender.h"

#define addTapRecognizer(p_tapMethodName,p_delegate,p_target,p_view_Container)\
{\
SEL selector1 = NSSelectorFromString(p_tapMethodName);\
UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]\ initWithTarget:p_target action:selector1];\
tapRecognizer.cancelsTouchesInView = NO;\
tapRecognizer.delegate = p_delegate;\
[p_View_Container addGestureRecognizer:tapRecognizer];\
}\


// 消除警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
}while(0)


@interface ViewController ()

typedef struct objc_property * Property;
@property(nonatomic, strong)FirstView *firstView;
@property(nonatomic, strong)Lender *lender;
@property(nonatomic, strong) NSMutableArray *selectorMuArr;

@end

@implementation ViewController

typedef struct objc_method *Method;
struct objc_method{
    SEL method_name   OBJC2_UNAVAILABLE; // fangfaming
    char *method_type OBJC2_UNAVAILABLE;
    IMP method_imp    OBJC2_UNAVAILABLE; // fangfa shixian
};

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _firstView = [[FirstView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:_firstView];
    _lender = [[Lender alloc] init];
    _selectorMuArr = [NSMutableArray arrayWithCapacity:1];
//    addTapRecognizer(@"handleBackgroundtap:", self, self, self.view);
}

-(void)runtimeFunction
{
    objc_property_t class_getProperty(Class cls, const char *name); // 获取一个类中指定的一个名字
    objc_property_t protocol_getProperty(Protocol *proto, const char *name, BOOL isRequiredProperty,BOOL isInstancePropety); //获取一个协议中注定的一个名字
    const char *property_getAttributes(objc_property_t property); // 获得属性的名字和编码字符串,字符串以T打头后面跟着编码类型和逗号，结束是以V打头加上返回实例变量的名字。在两者中间以逗号隔开   Tf,V_alone
    
    
    Class firstViewClass = object_getClass([FirstView class]); // 获取类
//    SEL oriSEL = @selector(test1);
//    Method oriMethod = Method class_getClassMethod(Class cls , SEL name);
//    Method class_getInstanceMthod(Class cls, SEL name);
}



- (IBAction)setRuntime:(id)sender {
    
    //      通过runtime 库函数直接调用
    
    Class lenderClass = object_getClass([Lender class]);
    SEL endSEL = @selector(lenderEnd);
    Method startMethod = class_getInstanceMethod([_lender class], @selector(lenderStart));  //获取实例方法
    Method endMethod =  class_getClassMethod([Lender class] , @selector(lenderEnd)); //获取类方法
    Method studyMethod = class_getClassMethod([FirstView class], @selector(studyChinese));
    Method runFastMethod = class_getInstanceMethod([self class], @selector(runFast));
    Method runMethod = class_getInstanceMethod([FirstView class], @selector(run));
    id LenderClass = objc_getClass("Lender");
    unsigned int outCount ;
//获得类的属性列表
    objc_property_t *properties = class_copyPropertyList(NSClassFromString(@"FirstView"), &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        fprintf(stdout, "%s %s\n",property_getName(property),property_getAttributes(property));
//        fprintf(<#FILE *restrict#>, <#const char *restrict, ...#>)
    }
    u_int methodCount;
    //获取类的方法列表（返回一个数组）
    Method *methodList = class_copyMethodList([FirstView class], &methodCount);
    for (int i = 0; i < methodCount; i++) {
        Method temp = methodList[i];
        IMP imp = method_getImplementation(temp);
        SEL name_f = method_getName(temp);
        const char *name_s = sel_getName(name_f);
        int arguments = method_getNumberOfArguments(temp);
        const char *encoding = method_getTypeEncoding(temp);
        NSLog(@"方法名：%@，参数个数：%d，编码方法：%@", [NSString stringWithUTF8String:name_s],arguments,[NSString stringWithUTF8String:encoding]);
        free(methodList);
        
    }
    
//    动态处理方法
    SEL startSEL = @selector(lenderStart);
    // 判断_lender是否有lenderStart方法
    if ([_lender respondsToSelector:startSEL]) {
//        self 调用 lender对象的startSEL选择器对应的方法
//        未真正消除警告
//        SuppressPerformSelectorLeakWarning(
//         [_lender performSelector:startSEL withObject:self]
//                                           );
//       获取选择器指向的方法
        IMP imp = [_lender methodForSelector:startSEL];
        void(*func)(id, SEL) = (void *)imp;
        func(_lender, startSEL);
        
    }
    
    
     [_selectorMuArr class];
       BOOL canll = [_selectorMuArr isKindOfClass:[NSArray class]];  //方法检查对象是否存在于指定的类的继承体系中(是否是其子类或者父类或者当前类的成员变量)；
       BOOL canl =  [_firstView isMemberOfClass:[UIView class]];
    BOOL canlll = [[FirstView class] isSubclassOfClass:[UIView class]];
//    [_lender conformsToProtocol:];
//    [_lender methodForSelector:];


//    [_lender lenderStart];
//    [Lender lenderEnd];
    //交换方法,方法名不变，但是方法中的内容交换了
//    method_exchangeImplementations(startMethod, endMethod);
    
    //添加新方法
//    class_addMethod([FirstView class], startSEL, method_getImplementation(startMethod), method_getTypeEncoding(startMethod));
//    替换方法
    class_replaceMethod([FirstView class],@selector(run) , method_getImplementation(runFastMethod), method_getTypeEncoding(runMethod));
    
    [_firstView performSelector:@selector(studyEngilsh)];
    [_firstView performSelector:@selector(studyChinese)];
//    [_firstView performSelector:@selector(lenderStart)];
    
//    [_lender lenderStart];
//    [Lender lenderEnd];


}



-(BOOL)resolveInstanceMethod:(SEL)aSEL Class:(Class)cls
{
//    SEL oriSEL = @selector(aSEL);
//    Method oriMethod = Method class_getClassMethod(Class cls, SEL aSEL);
    
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ![touch.view isKindOfClass:[UIButton class]];
}

-(void)runFast
{
    NSLog(@"runFast -------- ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
