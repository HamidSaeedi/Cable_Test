#ifndef _CLI_COMMAND_H_
#define _CLI_COMMAND_H_



#include "cli_init.h"
#include <string.h>
#include <math.h>

#define MAX_NUMBER_OF_CLI_COMMANDS 25 //it could not exceed 100

struct CLI_PARAM
{
	int8_t command_num;
	CliCommandBinding p;
};


void led_cli_function(EmbeddedCli *cli, char *args, void *context);
void diag_cli_function(EmbeddedCli *cli, char *args, void *context);
#endif
