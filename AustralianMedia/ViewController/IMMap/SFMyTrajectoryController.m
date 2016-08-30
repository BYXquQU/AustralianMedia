//
//  SFMyTrajectoryController.m
//  AustralianMedia
//
//  Created by saifing on 16/8/22.
//  Copyright © 2016年 saifing. All rights reserved.
//

#import "SFMyTrajectoryController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <IndoorMapSDK/IndoorMapSDK.h>


@interface SFMyTrajectoryController ()<CBCentralManagerDelegate, CBPeripheralDelegate, OIMMapViewDelegate>


{
    //系统蓝牙设备管理对象,可以吧他理解为主设备,通过它可以去扫描和连接外设
    CBCentralManager *manager;
}


@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *buildingId;

//室内地图对象
@property(nonatomic, strong)OIMMapView* imMapView;

//室内地图数据管理对象
@property(nonatomic, strong)OIMDataManager* imDataManager;

//大头针标注数组
@property(nonatomic, strong)NSMutableArray* annotations;

//覆盖物数组
@property(nonatomic, strong)NSMutableArray* overlays;

//线对象
@property (nonatomic, strong) OIMPolyline *polyline;

@property (nonatomic, strong) NSMutableArray *coords;

@property (nonatomic, assign) int flootNo;
@property(nonatomic)BOOL enableOverlay;

@end

@implementation SFMyTrajectoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.annotations = [[NSMutableArray alloc]init];
    self.overlays = [[NSMutableArray alloc]init];
//    self.coords = [[NSMutableArray alloc]init];
     self.title = @"我的轨迹";
    [self initCBCentralManager];
    [self initIMMapView];
    
    
    
}


/**
 *  初始化系统蓝牙设备管理对象并设置委托和线程队列，最好一个线程的参数可以为nil，默认会就main线程
 */
- (void)initCBCentralManager {
    
    manager = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];
}

/**
 *  初始化室内地图
 */
- (void)initIMMapView {
    
    self.key = @"3c201829b85fffc594786801c7889265";
    self.buildingId = @"B000A856LJ";
    self.imMapView = [[OIMMapView alloc]initWithFrame:self.view.bounds];
    //设置KEY
    self.imMapView.key = self.key;
    //设置delegate
    self.imMapView.delegate = self;
    //设置建筑物ID
    self.imMapView.buildingId = self.buildingId;
    //显示室内地图
    [self.view addSubview:self.imMapView];
    
    UIButton *polylineBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    polylineBtn.frame = CGRectMake(200, 600, 80, 30);
    [polylineBtn setTitle:@"划线" forState:UIControlStateNormal];
    polylineBtn.backgroundColor = [UIColor grayColor];
    [polylineBtn addTarget:self action:@selector(clickPolyline) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:polylineBtn];
}

//点击划线添加Overlay
- (void)clickPolyline {
    
    OIMPoint points[8];
    
    
//    points[0] = OIMPointMake(116.518724, 116.518724, (double)_flootNo);
//    points[1] = OIMPointMake(116.518306, 39.925128, (double)_flootNo);
    
//    points[0] = {116.518724, 39.924296, _flootNo};
//    points[1] = {116.518306, 39.925128, _floorNo};
//    points[2] = {116.519349, 39.923934, _floorNo};
//    points[3] = {116.518146, 39.924120, _floorNo};
//    points[4] = {116.518812, 39.923693, _floorNo};
//    points[5] = {116.518862, 39.924518, _floorNo};
//    points[6] = {116.518862, 39.924518, _floorNo};
//    points[7] = {116.518862, 39.924518, _floorNo};
    
//    self.polyline = (OIMPolyline *)overlay;
    self.polyline = [OIMPolyline polylineWithPoints:points count:8];
    
    [self.imMapView addOverlay:self.polyline];
    
}

#pragma mark - OIMMapViewDelegate
//室内地图加载成功事件添加显示屏对应的标注
-(void)mapView:(OIMMapView *)mapView didFinishLoadingMap:(NSString *)buildingId floorNo:(int)floorNo
{
    
    self.flootNo = floorNo;
//    //初始化一个标注
    OIMPoint point = {116.518724, 39.924296, (double)floorNo};
    OIMPointAnnotation* annotation = [[OIMPointAnnotation alloc]init];

//    //测试设置标注位置
    annotation.coordinate = point;
    
//    //添加标注到数组中(以后会有多个点)
    [self.annotations addObject:annotation];
    
    [self.imMapView addAnnotations:self.annotations];
}

//提示地图加载失败
-(void)mapView:(OIMMapView *)mapView didFailLoadingMap:(NSString *)buildingId floorNo:(int)floorNo withError:(NSError *)error
{
    //提示地图加载失败
    [self alert:@"室内地图加载失败" message:error.description];
}

/*!
 *  @brief  地图渲染完成
 *
 *  @param mapView       室内地图对象
 *  @param buildingId    渲染的建筑物Id
 *  @param floorNo       渲染的楼层
 *
 *  @since 2.0.0
 */
-(void)mapView:(OIMMapView*)mapView didFinishRenderingMap:(NSString*)buildingId floorNo:(int)floorNo {
    
}

/*!
 *  @brief  根据anntation生成对应的View
 *
 *  @param mapView    室内地图对象
 *  @param annotation 指定的标注
 *
 *  @return 生成的标注View
 *
 *  @since 2.1.0
 */
- (OIMAnnotationView *)mapView:(OIMMapView *)mapView viewForAnnotation:(id<OIMAnnotation>)annotation {
    OIMAnnotationView *oIMAnnotation = [[OIMAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotation"];
    oIMAnnotation.image = [UIImage imageNamed:@"indoor_am0007"];
    
    return oIMAnnotation;
}

/*!
 *  @brief  当选中一个annotation views时，调用此接口
 *
 *  @param mapView 室内地图对象
 *  @param view    选中的annotation view
 *
 *  @since 2.1.0
 */
- (void)mapView:(OIMMapView *)mapView didSelectAnnotationView:(OIMAnnotationView *)view {
    
}


/*!
 *  @brief  根据overlay生成对应的Renderer
 *
 *  @param mapView 室内地图对象
 *  @param overlay 指定的overlay
 *
 *  @return 生成的覆盖物Renderer
 *
 *  @since 2.1.0
 */
- (OIMOverlayRenderer *)mapView:(OIMMapView *)mapView rendererForOverlay:(OIMOverlay*)overlay {
    
    NSLog(@"就想知道你是否走这个方法");
    //longitude:116.518862, latitude:39.924518
    //longitude:116.518306, latitude:39.925128
    //longitude:116.519349, latitude:39.923934
    //longitude:116.518146, latitude:39.924120
    //longitude:116.518812, latitude:39.923693
    //longitude:116.518034, latitude:39.925155
    //longitude:116.518225, latitude:39.924495
    //longitude:116.518289, latitude:39.924902
    
//    OIMPoint points[8];
    
//    points[0] = {116.518862; 39.924518; (double)mapView.floorNo;};
//    points[1] = {116.518306, 39.925128, (double)mapView.floorNo;};
//    points[2] = {116.519349, 39.923934, (double)mapView.floorNo};
//    points[3] = {116.518146, 39.924120, (double)mapView.floorNo};
//    points[4] = {116.518812, 39.923693, (double)mapView.floorNo};
//    points[5] = {116.518862, 39.924518, (double)mapView.floorNo};
//    points[6] = {116.518862, 39.924518, (double)mapView.floorNo};
//    points[7] = {116.518862, 39.924518, (double)mapView.floorNo};
    
    
//    self.polyline = (OIMPolyline *)overlay;
//    self.polyline = [OIMPolyline polylineWithPoints:points count:8];
    
    OIMPolylineRenderer *renderer = [[OIMPolylineRenderer alloc]initWithPolyline:self.polyline];
    renderer.strokeColor = [UIColor redColor];
    renderer.lineWidth = 10;
    [self.overlays addObject:self.polyline];
    
//    OIMPolyline *polyline = (OIMPolyline*)overlay;
    
    //根据点对象绘制返回线对象覆盖物
    
//        polyline = [OIMPolyline polylineWithCoordinates:coords count:8];

        //将线转化为覆盖物并返回渲染效果
//        OIMPolylineRenderer *renderer = [[OIMPolylineRenderer alloc]initWithPolyline:polyline];
//        renderer.strokeColor = [UIColor redColor];
//        renderer.lineWidth = 10;
    
    return renderer;
}

-(void)mapView:(OIMMapView *)mapView willClickFeature:(double)longitude latitude:(double)latitude {
    //    OIMMapPoint point1 = OIMMapPointForCoordinate(CLLocationCoordinate2DMake(latitude, longitude));
    //    + (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count drawStyleIndexes:(NSArray*) drawStyleIndexes;
    //    CLLocationCoordinate2D coodr = CLLocationCoordinate2DMake(latitude, longitude);
    //
    //  OIMMultiPolyline *line = [OIMMultiPolyline polylineWithCoordinates:&coodr count:1 drawStyleIndexes:nil];
    //    self.polyline = line;
    //点击的坐标
    NSLog(@"longitude:%lf, latitude:%lf", longitude, latitude);
    
    
    //初始化一个标注
//    OIMPointAnnotation* annotation = [[OIMPointAnnotation alloc]init];
    //设置标注属性
//    annotation.coordinate = OIMPointMake(longitude, latitude, self.imMapView.floorNo);
    //添加标注
//    [self.imMapView addAnnotation:annotation];
//    [self.annotations addObject:annotation];

    
}

//提示信息
-(void)alert:(NSString*)title message:(NSString*)message
{
    //创建UIAlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //添加确定按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    //显示Alert对话框
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - CBCentralManagerDelegate

//2..扫描外设，扫描外设的方法我们放在centralManager成功打开的委托中，因为只有设备成功打开，才能开始扫描，否则会报错
/**
 *  主设备状态改变的委托，在初始化CBCentralManager的适合会打开设备，只有当设备正确打开后才能使用
 *
 *  @param central 管理对象
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");//蓝牙未打开
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@">>>CBCentralManagerStatePoweredOn");//蓝牙已经打开
            //开始扫描周围的外设
            /*
             第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入
             - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
             */
            [manager scanForPeripheralsWithServices:nil options:nil];//设置扫描的条件,nil代表扫描所有的设备(设置为CBUUID的数组集合表示允许添加设备的UUID)
            
            break;
        default:
            break;
    }
}

//3.连接外设(connect)


/**
 *  扫描到设备会进入方法
 *
 *  @param central           设备管理者
 *  @param peripheral        扫描到的外设
 *  @param advertisementData 扫描到的宣传data
 *  @param RSSI              信号强度
 */
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    //连接我们的测试设备
    //这里自己去设置下连接规则，我设置的是P开头的设备(还需判断信号强度以信号强度最优连接)
    if ([peripheral.name hasPrefix:@"P"]){//这个需要将设备的标识前缀提供来判断是否是显示屏内部的蓝牙.
        
        
        //获取外设的标识
        NSString *peripheralID = [NSString stringWithFormat:@"%@", peripheral.identifier];
        NSLog(@"外设的UUID---%@", peripheralID);
        //通过网络请求给服务器,服务器提供一个接口通过对应ID返回外设的经纬度给客户端,客户端通过经纬度绘制路线
        
        
        
        //连接设备
        //[manager connectPeripheral:peripheral options:nil];
        
    }
    
}













/**
 *  以下是蓝牙通讯相关的代理方法.
 *  如果需要通讯则需要连接外设.如果只是获取UUID则不需要连接外设,扫描到设备即可获得UUID,一个主设备最多能连7个外设，每个外设最多只能给一个主设备连接,连接成功，失败，断开会进入各自的委托
 */

//连接到Peripherals-成功
//- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
//{
//    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
//}
//
////连接到Peripherals-失败
//-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
//{
//    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
//}
//
////Peripherals断开连接
//- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
//    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
//
//}
//
////4. 扫描外设中的服务和特征(discover)
////设备连接成功后，就可以扫描设备的服务了，同样是通过委托形式，扫描到结果后会进入委托方法。但是这个委托已经不再是主设备的委托（CBCentralManagerDelegate），而是外设的委托（CBPeripheralDelegate）,这个委托包含了主设备与外设交互的许多 回叫方法，包括获取services，获取characteristics，获取characteristics的值，获取characteristics的Descriptor，和Descriptor的值，写数据，读rssi，用通知的方式订阅数据等等。
//
////4.1获取外设的services
////连接到Peripherals-成功
//- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral NS_AVAILABLE(NA, 6_0) {
//    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
//    //设置的peripheral委托CBPeripheralDelegate
//    //@interface ViewController : UIViewController
//    [peripheral setDelegate:self];
//    //扫描外设Services，成功后会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
//    [peripheral discoverServices:nil];
//
//}
//
////扫描到Services
//-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
//    //  NSLog(@">>>扫描到服务：%@",peripheral.services);
//    if (error)
//    {
//        NSLog(@">>>Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
//        return;
//    }
//
//    for (CBService *service in peripheral.services) {
//        NSLog(@"%@",service.UUID);
//        //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
//        [peripheral discoverCharacteristics:nil forService:service];
//    }
//
//}
//
////4.2 获取外设的Characteristics,获取Characteristics的值，获取Characteristics的Descriptor和Descriptor的值
////扫描到Characteristics
//-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
//    if (error)
//    {
//        NSLog(@"error Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
//        return;
//    }
//
//    for (CBCharacteristic *characteristic in service.characteristics)
//    {
//        NSLog(@"service:%@ 的 Characteristic: %@",service.UUID,characteristic.UUID);
//    }
//
//    //获取Characteristic的值，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
//    for (CBCharacteristic *characteristic in service.characteristics){
//        {
//            [peripheral readValueForCharacteristic:characteristic];
//        }
//    }
//
//    //搜索Characteristic的Descriptors，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
//    for (CBCharacteristic *characteristic in service.characteristics){
//        [peripheral discoverDescriptorsForCharacteristic:characteristic];
//    }
//
//
//}
//
////获取的charateristic的值
//-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
//    //打印出characteristic的UUID和值
//    //!注意，value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
//    NSLog(@"characteristic uuid:%@  value:%@",characteristic.UUID,characteristic.value);
//
//}
//
////搜索到Characteristic的Descriptors
//-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
//
//    //打印出Characteristic和他的Descriptors
//    NSLog(@"characteristic uuid:%@",characteristic.UUID);
//    for (CBDescriptor *d in characteristic.descriptors) {
//        NSLog(@"Descriptor uuid:%@",d.UUID);
//    }
//
//}
////获取到Descriptors的值
//-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
//    //打印出DescriptorsUUID 和value
//    //这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
//    NSLog(@"characteristic uuid:%@  value:%@",[NSString stringWithFormat:@"%@",descriptor.UUID],descriptor.value);
//}
//
////5.把数据写到Characteristic中
//
////写数据
//-(void)writeCharacteristic:(CBPeripheral *)peripheral
//            characteristic:(CBCharacteristic *)characteristic
//                     value:(NSData *)value{
//
//    //打印出 characteristic 的权限，可以看到有很多种，这是一个NS_OPTIONS，就是可以同时用于好几个值，常见的有read，write，notify，indicate，知知道这几个基本就够用了，前连个是读写权限，后两个都是通知，两种不同的通知方式。
//    /*
//     typedef NS_OPTIONS(NSUInteger, CBCharacteristicProperties) {
//     CBCharacteristicPropertyBroadcast                                              = 0x01,
//     CBCharacteristicPropertyRead                                                   = 0x02,
//     CBCharacteristicPropertyWriteWithoutResponse                                   = 0x04,
//     CBCharacteristicPropertyWrite                                                  = 0x08,
//     CBCharacteristicPropertyNotify                                                 = 0x10,
//     CBCharacteristicPropertyIndicate                                               = 0x20,
//     CBCharacteristicPropertyAuthenticatedSignedWrites                              = 0x40,
//     CBCharacteristicPropertyExtendedProperties                                     = 0x80,
//     CBCharacteristicPropertyNotifyEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)        = 0x100,
//     CBCharacteristicPropertyIndicateEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)  = 0x200
//     };
//
//     */
//    NSLog(@"%lu", (unsigned long)characteristic.properties);
//
//
//    //只有 characteristic.properties 有write的权限才可以写
//    if(characteristic.properties & CBCharacteristicPropertyWrite){
//        /*
//         最好一个type参数可以为CBCharacteristicWriteWithResponse或type:CBCharacteristicWriteWithResponse,区别是是否会有反馈
//         */
//        [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
//    }else{
//        NSLog(@"该字段不可写！");
//    }
//
//
//}
//
////6. 订阅Characteristic的通知
//
////设置通知
//-(void)notifyCharacteristic:(CBPeripheral *)peripheral
//             characteristic:(CBCharacteristic *)characteristic{
//    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
//    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
//
//}
//
////取消通知
//-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
//                   characteristic:(CBCharacteristic *)characteristic{
//
//    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
//}
////7 断开连接(disconnect)
//
////停止扫描并断开连接
//-(void)disconnectPeripheral:(CBCentralManager *)centralManager
//                 peripheral:(CBPeripheral *)peripheral{
//    //停止扫描
//    [centralManager stopScan];
//    //断开连接
//    [centralManager cancelPeripheralConnection:peripheral];
//}

@end
