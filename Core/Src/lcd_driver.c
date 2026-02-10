#include "lcd_driver.h"




uint8_t lcd_init(void)
{
	if(ssd1306_Init())
	{
		ssd1306_DisplayOn();
		ssd1306_FlipScreenVertically();
		return HAL_OK;
	}
	else
	{
		return HAL_ERROR;
	}
}

uint8_t lcd_puts(char *p)
{
	ssd1306_SetColor(White);
	ssd1306_WriteString(p,Font_7x10);
	lcd_update();

}

uint8_t lcd_puts_invert(char *p)
{
	ssd1306_SetColor(Black);
	ssd1306_WriteString(p,Font_7x10);
	lcd_update();
}

uint8_t lcd_puts_color(char *p, SSD1306_COLOR color)
{
	if(color == Black || color == White || color == Inverse)
	{
		ssd1306_SetColor(color);
		ssd1306_WriteString(p,Font_7x10);
		lcd_update();
		return HAL_OK;
	}
	else
	{
		return HAL_ERROR;
	}
}



uint8_t lcd_gotoxy(uint8_t x, uint8_t y)
{
	if( ( (LCD_HORIZONTAL_FACTOR * x) > LCD_WIDTH) || ((LCD_VERTICAL_FACTOR * y ) > LCD_HIGHT) )
	{
		//EEROR HANDLER
		return HAL_ERROR;
	}
	ssd1306_SetCursor(LCD_HORIZONTAL_FACTOR*x, LCD_VERTICAL_FACTOR*y);
	return HAL_OK;
}
uint8_t lcd_clear(void)
{
	ssd1306_Clear();
	return HAL_OK;
}



uint8_t lcd_update(void)
{
	ssd1306_UpdateScreen();
	return HAL_OK;
}
