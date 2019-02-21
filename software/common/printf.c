// SPDX-License-Identifier: Apache-2.0
// Copyright 2019 Western Digital Corporation or its affiliates.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//
// Based on a public domain version of printf
// Web link: http://www.rte.se/sites/default/files/Blog/Modesty/ee_printf.c 
//


#include <stdarg.h>
#include "mem_map.h"
#include "printf.h"


/*---------------------------------------------------*/
/* Define											 */ 
/*---------------------------------------------------*/
#define UART_RX_DATA	(*((volatile unsigned int*)(UART_BASE_ADDRESS + 0x0)))
#define UART_TX_DATA	(*((volatile unsigned int*)(UART_BASE_ADDRESS + 0x4)))
#define UART_STAT		(*((volatile unsigned int*)(UART_BASE_ADDRESS + 0x8)))
#define UART_CTRL 		(*((volatile unsigned int*)(UART_BASE_ADDRESS + 0xC)))

#define UART_TX_BUSY	(1<<3)
#define UART_RX_AVAIL	(1<<0)


/*---------------------------------------------------*/
/* strlen											 */
/*---------------------------------------------------*/
int strlen(const char *s)
{
    if(!s) return 0;
    const char *it = s;

	while(*it){
		++it;
	}
    return it - s;
}


/*---------------------------------------------------*/
/* uart_putchar: Write character to UART			 */
/*---------------------------------------------------*/
int uart_putchar(char ch)   
{   
    if (ch == '\n')
        uart_putchar('\r');

	//check status
    while (UART_STAT & UART_TX_BUSY);
	//write char
    UART_TX_DATA = ch;

    return 0;
}

/*----------------------------------------------------*/
/* Use the following parameter passing structure to   */
/* make printf re-entrant.                         */
/*----------------------------------------------------*/
typedef struct params_s 
{
    int len;
    long num1;
    long num2;
    char pad_character;
    int do_padding;
    int left_flag;
	int upper_hex_digit_flag; //added hexdigit uppercase [A-F]
	int maxium_length; // max_length
} params_t;


/*----------------------------------------------------*/
/* puts: print string								  */	
/*----------------------------------------------------*/

int puts( const char * str )
{
	while (*str)
		uart_putchar(*str++);

	return uart_putchar('\n');
}

/*----------------------------------------------------*/
/* putchar: print character							  */
/*----------------------------------------------------*/
int putchar( int c )
{
	uart_putchar((char)c);
	return c;
}


/*---------------------------------------------------*/
/*                                                   */
/* This routine puts pad characters into the output  */
/* buffer.                                           */
/*                                                   */
/*---------------------------------------------------*/
static void padding( const int l_flag, params_t *par)
{
    int i;

    if (par->do_padding && l_flag && (par->len < par->num1))
        for (i=par->len; i<par->num1; i++)
            uart_putchar( par->pad_character);
}

/*---------------------------------------------------*/
/*                                                   */
/* This routine moves a string to the output buffer  */
/* as directed by the padding and positioning flags. */
/*                                                   */
/*---------------------------------------------------*/
static void outs(  char* lp, params_t *par)
{
    /* pad on left if needed                         */
    par->len = strlen( lp);
    padding( !(par->left_flag), par);

    /* Move string to the buffer                     */
    while (*lp && (par->num2)--)
        uart_putchar( *lp++);

    /* Pad on right if needed                        */
    par->len = strlen( lp);                      
    padding( par->left_flag, par);
}

/*---------------------------------------------------*/
/*                                                   */
/* This routine moves a number to the output buffer  */
/* as directed by the padding and positioning flags. */
/*                                                   */
/*---------------------------------------------------*/

static void outnum( const int n, const long base, params_t *par)
{
    char* cp;
    int negative;
    char outbuf[32];
	const char uphexdigits[] = "0123456789ABCDEF";
	const char lohexdigits[] = "0123456789abcdef";
	const char *digits;
    unsigned long num;
	int i;

    /* Check if number is negative                   */
    if (base == 10 && n < 0L) {
        negative = 1;
        num = -(n);
    }
    else{
        num = (n);
        negative = 0;
    }

	if (par->upper_hex_digit_flag)
		digits = uphexdigits;
	else
		digits = lohexdigits;
   
    /* Build number (backwards) in outbuf            */
	cp = outbuf;
	// only for 10 and 16 
	// avoid complex divide
	if (base == 10)
	{    
		do {
			*cp++ = digits[(int)(num % 10)];
		} while ((num /= 10) > 0);
	}
	else
	{
		do {
			*cp++ = digits[(int)(num % 16)];
		} while ((num /= 16) > 0);
	}

    if (negative)
        *cp++ = '-';
    *cp-- = 0;

    /* Move the converted number to the buffer and   */
    /* add in the padding where needed.              */
    par->len = strlen(outbuf);
    padding( !(par->left_flag), par);
	i = 0;
    while (cp >= outbuf && i++ < par->maxium_length)
        uart_putchar( *cp--);
    padding( par->left_flag, par);
}

/*---------------------------------------------------*/
/*                                                   */
/* This routine gets a number from the format        */
/* string.                                           */
/*                                                   */
/*---------------------------------------------------*/

static long getnum( char** linep)
{
    long n;
    char* cp;

    n = 0;
    cp = *linep;
    while (((*cp) >= '0' && (*cp) <= '9'))
        n = n*10 + ((*cp++) - '0');
    *linep = cp;
    return(n);
}

/*---------------------------------------------------*/
/*                                                   */
/* This routine operates just like a printf/sprintf  */
/* routine. It outputs a set of data under the       */
/* control of a formatting string. Not all of the    */
/* standard C format control are supported. The ones */
/* provided are primarily those needed for embedded  */
/* systems work. Primarily the floaing point         */
/* routines are omitted. Other formats could be      */
/* added easily by following the examples shown for  */
/* the supported formats.                            */
/*                                                   */
/*---------------------------------------------------*/
int uart_printf(const char* ctrl1, va_list argp)
{
    int long_flag;
    int dot_flag;
	int res = 0;

    params_t par;

    char ch;
    char* ctrl = (char*)ctrl1;
    for ( ; *ctrl; ctrl++) 
	{
        /* move format string chars to buffer until a  */
        /* format control is found.                    */
        if ( *ctrl != '%') 
		{
			uart_putchar( *ctrl);
            continue;
        }

        /* initialize all the flags for this format.   */
        dot_flag  = long_flag = par.left_flag = par.do_padding = 0;
        par.pad_character = ' ';
        par.num2=32767;
		par.maxium_length = 10;

 try_next:
        ch = *(++ctrl);
        if ((ch >= '0' && ch <= '9')) 
		{
            if (dot_flag)
                par.num2 = getnum(&ctrl);
            else {
                if (ch == '0')
                    par.pad_character = '0';

                par.num1 = getnum(&ctrl);
                par.do_padding = 1;
            }
            ctrl--;
            goto try_next;
        }

		par.upper_hex_digit_flag = (ch >= 'A' && ch <= 'Z') ? 1 : 0;

        switch ((par.upper_hex_digit_flag ? ch + 32: ch)) 
		{
            case '%':
				uart_putchar( '%');
                continue;

            case '-':
                par.left_flag = 1;
                break;

            case '.':
                dot_flag = 1;
                break;

            case 'l':
                long_flag = 1;
                break;

            case 'd':
			case 'u':
                if (long_flag || ch == 'D') 
				{
                    outnum( va_arg(argp, long), 10L, &par);
                    continue;
                }
                else {
                    outnum( va_arg(argp, int), 10L, &par);
                    continue;
                }
            
			case 'x':
			case 'p':
				if (long_flag || ch == 'D') 
				{
					par.maxium_length = sizeof(long) * 2;
					outnum( (long)va_arg(argp, long), 16L, &par);
				}
				else
				{
					par.maxium_length = sizeof(int) * 2;
					outnum( (long)va_arg(argp, int), 16L, &par);
				}
                continue;
            case 's':
                outs( va_arg( argp, char*), &par);
                continue;
            case 'c':
			uart_putchar( va_arg( argp, int));
                continue;
            case '\\':
                switch (*ctrl) {
                    case 'a':
                        uart_putchar( 0x07);
                        break;
                    case 'h':
                        uart_putchar( 0x08);
                        break;
                    case 'r':
                        uart_putchar( 0x0D);
                        break;
                    case 'n':
                        uart_putchar( 0x0A);
                        break;
                    default:
                        uart_putchar( *ctrl);
                        break;
                }
                ctrl++;
                break;

            default:
                continue;
        }
        goto try_next;
    }
	return res;
}


/*---------------------------------------------------*/
/* printf: Console based printf 					 */
/*---------------------------------------------------*/
int printf( const char* format, ... )
{
	int res = 0;
	va_list argp;
	if (format)
	{
		va_start( argp, format);
		// Setup target to be stdout function
		res = uart_printf( format, argp);

		va_end( argp);
	}

	return res;
}



