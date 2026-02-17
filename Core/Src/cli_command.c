#include "cli_command.h"

struct CLI_PARAM cli_command_param[MAX_NUMBER_OF_CLI_COMMANDS];


CliCommandBinding LEDS = {"led", "LEDX will turn on and off", false, NULL, led_cli_function};

CliCommandBinding DIAG = {"diag", "LEDX will turn on and off", false, NULL, diag_cli_function};


void cli_param_init(void)
{
	uint8_t i=0;
	for(i=0;i<MAX_NUMBER_OF_CLI_COMMANDS;i++)
	{
		cli_command_param[i].command_num = -1;
		//cli_command_param[i].p = NULL;
	}
}

void cli_command_init(void)
{
	cli_command_param[0].command_num=0;
	cli_command_param[0].p = LEDS;
	cli_command_param[1].command_num=1;
	cli_command_param[1].p = DIAG;
}


void led_cli_function(EmbeddedCli *cli, char *args, void *context)
{
	uint8_t count=0;
	const char *arg1;
	const char *arg2;
	embeddedCliTokenizeArgs(args);
	count = embeddedCliGetTokenCount(args);
	arg1 = embeddedCliGetToken(args,1);
	arg2 = embeddedCliGetToken(args,2);
	if(strcmp(arg1,"1")==0)
	{
		if(strcmp(arg2,"on")==0)
		{
			HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, SET);
		}
		else if(strcmp(arg2,"off")==0)
		{
			HAL_GPIO_WritePin(LED1_GPIO_Port, LED1_Pin, RESET);
		}
	}
	else if(strcmp(arg1,"2")==0)
	{
		if(strcmp(arg2,"on")==0)
		{
			HAL_GPIO_WritePin(LED2_GPIO_Port, LED2_Pin, SET);
		}
		else if(strcmp(arg2,"off")==0)
		{
			HAL_GPIO_WritePin(LED2_GPIO_Port, LED2_Pin, RESET);
		}
	}


}



void diag_cli_function(EmbeddedCli *cli, char *args, void *context)
{

}
