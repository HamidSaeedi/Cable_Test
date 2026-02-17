#include "cli_init.h"

uint8_t buf=0;
EmbeddedCliConfig *config;
EmbeddedCli *cli;


uint8_t cli_init(void)
{
	config = embeddedCliDefaultConfig();
	if(config == NULL)
	{
		return HAL_ERROR;
	}
	cli = embeddedCliNew(config);
	if(cli == NULL)
	{
		return HAL_ERROR;
	}
	cli->writeChar = writeChar;
	HAL_UART_Receive_IT(&huart1,&buf,1);
	return HAL_OK;
}


void writeChar(EmbeddedCli *embeddedCli, char c)
{
    //usart_transmit(&c);
	HAL_UART_Transmit(&huart1,&c,1,1);

}
