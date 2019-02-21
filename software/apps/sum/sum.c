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


/*--------------------------------------------------------------*/
/*Program that computes the sum of the numbers from 3 to 9.     */
/*--------------------------------------------------------------*/

/* Header files */
#include "printf.h"

/*--------------------------------------------------------------*/
/* Simple sum function that takes two arguments start number  	*/ 
/*(start) and end number(end) and compute the sum of the numbers*/ 
/* from start to end.  											*/
/*--------------------------------------------------------------*/

int sum(int start, int end){
	int  sum = 0;
	for(int i = start; i <= end; i++){
		sum += i;
	}
	return sum;
}

/*--------------------------------------------------------------*/
/* main function: call sum(3, 9) and printf to result to UART   */
/*--------------------------------------------------------------*/
int main(){
	int x = sum(3, 9);
	printf("Result: %d\n", x);
	return 0;
}
