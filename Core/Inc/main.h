/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2026 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f4xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define LED1_Pin GPIO_PIN_0
#define LED1_GPIO_Port GPIOC
#define LED2_Pin GPIO_PIN_1
#define LED2_GPIO_Port GPIOC
#define A0_Pin GPIO_PIN_0
#define A0_GPIO_Port GPIOB
#define A1_Pin GPIO_PIN_1
#define A1_GPIO_Port GPIOB
#define A2_Pin GPIO_PIN_2
#define A2_GPIO_Port GPIOB
#define A10_Pin GPIO_PIN_10
#define A10_GPIO_Port GPIOB
#define A11_Pin GPIO_PIN_11
#define A11_GPIO_Port GPIOB
#define A12_Pin GPIO_PIN_12
#define A12_GPIO_Port GPIOB
#define A13_Pin GPIO_PIN_13
#define A13_GPIO_Port GPIOB
#define A14_Pin GPIO_PIN_14
#define A14_GPIO_Port GPIOB
#define A15_Pin GPIO_PIN_15
#define A15_GPIO_Port GPIOB
#define ENTER_Pin GPIO_PIN_8
#define ENTER_GPIO_Port GPIOC
#define ENTER_EXTI_IRQn EXTI9_5_IRQn
#define UP_Pin GPIO_PIN_15
#define UP_GPIO_Port GPIOA
#define UP_EXTI_IRQn EXTI15_10_IRQn
#define DOWN_Pin GPIO_PIN_10
#define DOWN_GPIO_Port GPIOC
#define DOWN_EXTI_IRQn EXTI15_10_IRQn
#define LEFT_Pin GPIO_PIN_11
#define LEFT_GPIO_Port GPIOC
#define LEFT_EXTI_IRQn EXTI15_10_IRQn
#define RIGHT_Pin GPIO_PIN_12
#define RIGHT_GPIO_Port GPIOC
#define RIGHT_EXTI_IRQn EXTI15_10_IRQn
#define SPARE_Pin GPIO_PIN_2
#define SPARE_GPIO_Port GPIOD
#define SPARE_EXTI_IRQn EXTI2_IRQn
#define A3_Pin GPIO_PIN_3
#define A3_GPIO_Port GPIOB
#define A4_Pin GPIO_PIN_4
#define A4_GPIO_Port GPIOB
#define A5_Pin GPIO_PIN_5
#define A5_GPIO_Port GPIOB
#define A6_Pin GPIO_PIN_6
#define A6_GPIO_Port GPIOB
#define A7_Pin GPIO_PIN_7
#define A7_GPIO_Port GPIOB
#define A8_Pin GPIO_PIN_8
#define A8_GPIO_Port GPIOB
#define A9_Pin GPIO_PIN_9
#define A9_GPIO_Port GPIOB

/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */
