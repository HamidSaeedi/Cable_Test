#ifndef _LCD_DRIVER_H_
#define _LCD_DRIVER_H_
#include "ssd1306.h"
#include "fonts.h"
#define  LCD_HORIZONTAL_FACTOR 7
#define  LCD_FONT_X_SIZE 7
#define  LCD_FONT_Y_SIZE 10
#define  LCD_VERTICAL_FACTOR 10
#define  LCD_WIDTH  127
#define  LCD_HIGHT  63


uint8_t lcd_init(void);
uint8_t lcd_puts(char *p);
uint8_t lcd_puts_invert(char *p);
uint8_t lcd_puts_color(char *p, SSD1306_COLOR color);
uint8_t lcd_gotoxy(uint8_t x, uint8_t y);
uint8_t lcd_clear(void);
uint8_t lcd_update(void);

#endif
