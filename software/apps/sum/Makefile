# SPDX-License-Identifier: Apache-2.0
# Copyright 2019 Western Digital Corporation or its affiliates.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

BSP_DIR=${SWERV_EH1_FPGA_PATH}/software/bsp
COMMON_DIR=${SWERV_EH1_FPGA_PATH}/software/common

all: sum.elf

sum.elf: ${BSP_DIR}/link.ld ${BSP_DIR}/startup.S ${COMMON_DIR}/printf.c sum.c
	riscv32-unknown-elf-gcc -march=rv32imc  -nostartfiles -Wl,--no-relax,-Bstatic,-T,${BSP_DIR}/link.ld -ffreestanding -nostdlib -g -o sum.elf ${BSP_DIR}/startup.S ${COMMON_DIR}/printf.c sum.c -I${COMMON_DIR} -I${BSP_DIR}

clean:
	rm -rf *.elf *.o 
