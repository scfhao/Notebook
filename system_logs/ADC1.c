//ADC1.c
#include "stm32f10x_adc.h"
#include "stm32f10x_dma.h"
#include "ADC1.h"

// 下面这两行都是保存电压的
__IO uint16_t ADC_ConvertedValue[ADC_Sensor_Cnt];

// 配置传感器引脚
void configADCGPIO(void) {
	GPIO_InitTypeDef GPIO_InitStructure;
	// 打开 ADC IO端口时钟
	
	// 配置 ADC IO 引脚模式
	GPIO_InitStructure.GPIO_Pin = GPIO_PIN_Light|GPIO_PIN_PH;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AIN;
	
	// 初始化 ADC IO
	GPIO_Init(GPIOA, &GPIO_InitStructure);
}

// 配置DMA和ADC
void configADCMode(void) {
	ADC_InitTypeDef ADC_InitStructure;
	DMA_InitTypeDef DMA_InitStructure;

	// 打开DMA时钟
	RCC_AHBPeriphClockCmd(RCC_AHBPeriph_DMA1, ENABLE);
	// 打开ADC时钟
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA|RCC_APB2Periph_ADC1, ENABLE);
	// 复位DMA控制器
	DMA_DeInit(ADC_DMA_CHANNEL);
	// 外设基址为：ADC 数据寄存器地址
	DMA_InitStructure.DMA_PeripheralBaseAddr = ADC1_DR_Address;
	// 存储器地址，实际上就是一个内部SRAM的变量
	DMA_InitStructure.DMA_MemoryBaseAddr = (uint32_t)&ADC_ConvertedValue; 
	DMA_InitStructure.DMA_MemoryBaseAddr = (uint32_t)&RegularConvData_Tab; //光照
	// 数据源来自外设
	DMA_InitStructure.DMA_DIR = DMA_DIR_PeripheralSRC;
	// 缓冲区大小为1，缓冲区的大小应该等于存储器的大小
	DMA_InitStructure.DMA_BufferSize = 1;
	// 外设寄存器只有一个，地址不用递增
	DMA_InitStructure.DMA_PeripheralInc = DMA_PeripheralInc_Disable;
	// 存储器地址固定
	DMA_InitStructure.DMA_MemoryInc = DMA_MemoryInc_Enable; 
	// 外设数据大小为半字，即两个字节
	DMA_InitStructure.DMA_PeripheralDataSize = DMA_PeripheralDataSize_HalfWord;
	// 存储器数据大小也为半字，跟外设数据大小相同
	DMA_InitStructure.DMA_MemoryDataSize = DMA_MemoryDataSize_HalfWord;
	// 循环传输模式
	DMA_InitStructure.DMA_Mode = DMA_Mode_Circular;
	// DMA 传输通道优先级为高，当使用一个DMA通道时，优先级设置不影响
	DMA_InitStructure.DMA_Priority = DMA_Priority_High;
	// 禁止存储器到存储器模式，因为是从外设到存储器
	DMA_InitStructure.DMA_M2M = DMA_M2M_Disable;
	// 初始化DMA
	DMA_Init(DMA1_Channel1, &DMA_InitStructure);
	// 使能 DMA 通道
	DMA_Cmd(DMA1_Channel1 , ENABLE);

	// ADC 模式配置
	// 只使用一个ADC，属于单模式
	ADC_InitStructure.ADC_Mode = ADC_Mode_Independent;
	// 禁止扫描模式，多通道才要，单通道不需要
	ADC_InitStructure.ADC_ScanConvMode = ENABLE;
	// 连续转换模式
	ADC_InitStructure.ADC_ContinuousConvMode = ENABLE;
	// 不用外部触发转换，软件开启即可
	ADC_InitStructure.ADC_ExternalTrigConv = ADC_ExternalTrigConv_None;
	// 转换结果右对齐
	ADC_InitStructure.ADC_DataAlign = ADC_DataAlign_Right;
	// 转换通道1个
	ADC_InitStructure.ADC_NbrOfChannel = 1;	
	// 初始化ADC
	ADC_Init(ADC1, &ADC_InitStructure);
	// 配置ADC时钟为PCLK2的8分频，即9MHz
	RCC_ADCCLKConfig(RCC_PCLK2_Div8); 
	// 配置 ADC 通道转换顺序为1，第一个转换，采样时间为55.5个时钟周期
	// TODO: 光照Channel1，phchannel2 多通道通过这里配置采样顺序
	ADC_RegularChannelConfig(ADC1, ADC_Channel_2, 1, ADC_SampleTime_55Cycles5);
	ADC_RegularChannelConfig(ADC1, ADC_Channel_4,1, ADC_SampleTime_71Cycles5);
	ADC_RegularChannelConfig(ADC1, ADC_Channel_5,2, ADC_SampleTime_71Cycles5);
	// 使能ADC DMA 请求
	ADC_DMACmd(ADC1, ENABLE);
	// 开启ADC ，并开始转换
	ADC_Cmd(ADC1, ENABLE);
	// 初始化ADC 校准寄存器  
	ADC_ResetCalibration(ADC1);
	// 等待校准寄存器初始化完成
	while(ADC_GetResetCalibrationStatus(ADC1));
	// ADC开始校准
	ADC_StartCalibration(ADC1);
	// 等待校准完成
	while(ADC_GetCalibrationStatus(ADC1));
	// 由于没有采用外部触发，所以使用软件触发ADC转换 
	ADC_SoftwareStartConvCmd(ADC1, ENABLE);
}

void InitADC1ForSensor(void) {
	configADCGPIO();
	configADCMode();
}

/**
电压采集：STM32F103的ADC是12位的，12位二进制可表示0-4095，ADC引脚电压为0-3.3V，
12位的ADC就会把3.3V切割成4096份。假设转换器采集到的ADC值为x，实际所求电压为y。
那么公式为y=x/4096*3.3V

引脚说明，比如PC0标注的是ADC123_IN10，说明该引脚可以作为ADC引脚，而123说明该引脚可以
被ADC1、ADC2、ADC3三个转化器共用，10对应18个通道中的10通道。
*/
// 读取光照强度
float Get_VREFINT(void) {
     /* Test DMA1 TC flag */
    if((DMA_GetFlagStatus(DMA1_FLAG_TC1)) )
    {
    	/* Clear DMA TC flag */
    	DMA_ClearFlag(DMA1_FLAG_TC1);
    } 
    uint16_t VREFINT_DATA=RegularConvData_Tab[0];//获取到ADC值
    float Vbat_value =((3.3*VREFINT_DATA)/4096.0);//等待返回 电阻分压的
    return Vbat_value;//返回当前值  
    // PH
	ADC_ConvertedValueLocal =(float) ADC_ConvertedValue/4096*3.3; // 读取转换的AD值
	PH_Value=-5.7541*ADC_ConvertedValueLocal+16.654;
	if(PH_Value<=0.0){PH_Value=0.0;}
	if(PH_Value>=14.0){PH_Value=14.0;}
}
