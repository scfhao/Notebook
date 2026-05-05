您可以使用`property_getAttributes`函数来查看一个属性的名称、@encode 类型字符串和其他属性。

该字符串以一个T后面跟着 @encode 类型和一个逗号开头，以一个V后面跟着实例变量的名字结尾。中间是属性由以下描述符指定，用逗号分隔：


 Code  |  含义 
-------|---------
R | readonly 属性
C | Copy 属性
& | retain 属性
N | nonatomic 属性
G<name> | 这个属性定义了一个自定义的getter方法，G后面是方法名
S<name> | 这个属性定义了一个自定义的setter方法，S后面是方法名
D | @dynamic 属性
W | weak 属性
P | 该属性可以进行垃圾回收
t<encoding> | 使用旧编码的类型

Property declaration | Property description
---------------------|-------------------
@property char charDefault; | Tc,VcharDefault
@property double doubleDefault; | Td,VdoubleDefault
@property enum FooManChu enumDefault; | Ti,VenumDefault
@property float floatDefault; | Tf,VfloatDefault
@property int intDefault; | Ti,VintDefault
@property long longDefault; | Tl,VlongDefault
@property short shortDefault; | Ts,VshortDefault
@property signed signedDefault; | Ti,VsignedDefault
@property struct YorkshireTeaStruct structDefault; | T{YorkshireTeaStruct="pot"i"lady"c},VstructDefault
@property YorkshireTeaStructType typedefDefault; | T{YorkshireTeaStruct="pot"i"lady"c},VtypedefDefault
@property union MoneyUnion unionDefault; | T(MoneyUnion="alone"f"down"d),VunionDefault
@property unsigned unsignedDefault; | TI,VunsignedDefault
@property int (*functionPointerDefault)(char *); | T^?,VfunctionPointerDefault
@property id idDefault; Note: the compiler warns: "no 'assign', 'retain', or 'copy' attribute is specified - 'assign' is assumed" | T@,VidDefault
@property int *intPointer; | T^i,VintPointer
@property void *voidPointerDefault; | T^v,VvoidPointerDefault
@property int intSynthEquals;
In the implementation block:
@synthesize intSynthEquals=_intSynthEquals; | Ti,V_intSynthEquals
@property(getter=intGetFoo, setter=intSetFoo:) int intSetterGetter; | Ti,GintGetFoo,SintSetFoo:,VintSetterGetter
@property(readonly) int intReadonly; | Ti,R,VintReadonly
@property(getter=isIntReadOnlyGetter, readonly) int intReadonlyGetter; | Ti,R,GisIntReadOnlyGetter
@property(readwrite) int intReadwrite; | Ti,VintReadwrite
@property(assign) int intAssign; | Ti,VintAssign
@property(retain) id idRetain; | T@,&,VidRetain
@property(copy) id idCopy; | T@,C,VidCopy
@property(nonatomic) int intNonatomic; | Ti,VintNonatomic
@property(nonatomic, readonly, copy) id idReadonlyCopyNonatomic; | T@,R,C,VidReadonlyCopyNonatomic
@property(nonatomic, readonly, retain) id idReadonlyRetainNonatomic; | T@,R,&,VidReadonlyRetainNonatomic


-----------------------|-------------
class_copyPropertyList | 获取属性列表
property_getName 	    | 获取属性名称
property_getAttributes |

name:intProperty
attr:Ti,N,V_intProperty
name:shortProperty
attr:Ts,N,V_shortPropertyMJProperty 创建：
name:floatPorperty
attr:Tf,N,V_floatPorpertyMJProperty *property = [MJProperty name:doublePropertycachedPropertyWithProperty:properties[i]];
attr:Td,N,V_doubleProperty// 过滤掉Foundation框架类里面的属性
name:longPropertyif ([MJFoundation isClassFromFoundation:property.srcClass]) continue;
attr:Tq,N,V_longPropertyproperty.srcClass = c;
name:longlongProperty[property setOriginKey:[self propertyKey:property.name] attr:Tq,N,V_longlongPropertyforClass:self];
name:charProperty[property setObjectClassInArray:[self attr:Tc,N,V_charPropertypropertyObjectClassInArray:property.name] forClass:self];
name:BOOLProperty                
attr:TB,N,V_BOOLProperty                name:intPointerProperty
attr:T^i,N,V_intPointerProperty
name:idProperty
attr:T@,&,N,V_idProperty
name:NSObjectPointerProperty
attr:T@"NSObject",&,N,V_NSObjectPointerProperty