https://blog.csdn.net/dingyc_ee/article/details/100787671
//ADC1.h
#ifndef __ADC1_H
#define __ADC1_H

#include <stm32f10x.h>

/**
 * 本项目中使用ADC1读取光照/PH/流速/水深等传感器模拟数据，各传感器都连接GPIOA组引脚。
 */

// 光照传感器引脚及對應ADC通道
#define GPIO_PIN_Light		GPIO_Pin_1
#define ADC_Channel_Light 	ADC_Channel_1
// PH传感器引脚及對應ADC通道
#define GPIO_PIN_PH 		GPIO_Pin_2
#define ADC_Channel_PH		ADC_Channel_2
// 水深引脚及對應ADC通道
#define GPIO_PIN_Deep		GPIO_Pin_3
#define ADC_Channel_Deep	ADC_Channel_3
// 流速引脚及對應ADC通道
#define GPIO_PIN_Speed		GPIO_Pin_4
#define ADC_Channel_Speed	ADC_Channel_4

// 当前连接的传感器数量
#define ADC_Sensor_Cnt		2

/// 初始化STM32F1中的ADC1以及DMA
void InitADC1ForSensor(void);

#endif /* __ADC1_H */