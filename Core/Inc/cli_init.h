#ifndef _CLI_INIT_H_
#define _CLI_INIT_H_

#include "usart.h"
#include "embedded_cli.h"
void writeChar(EmbeddedCli *embeddedCli, char c);

extern EmbeddedCli *cli;
#endif
