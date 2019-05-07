# FPGA Reference Design for the SweRV RISC-V Core<sup>TM</sup> from Western Digital

This repository contains design files for implementing a
Swerv<sup>TM</sup>-based processor complex in a commercially available
FPGA board, the Nexus4 DDR from Digilent Inc.   The repository also
contains example software and support files for loading the software
into the design, and debugging the software.  

## License

By contributing to this project, you agree that your contribution is
governed by the [Apache-2.0](LICENSE) license.  
Files under the [common](software/common) software  directory may be
available under a different license. Please review each individual
file for details.


## Directory Structure


    ├── hardware                # Hardware directory  
    │   ├── constraints         #  FPGA constraints files  
    │   ├── design_top          #  Reference design top   
    │   ├── peripherals         #  AXI peripherals, clock and reset modules  
    │   ├── project             #  Vivado tcl project script  
    │   └── swerv_eh1           #  Swerv_eh1 core  
    ├── README.md                                 
    ├── LICENSE                                   
    └── software                # Sofware directory              
        ├── apps                #  Example applications, Makefiles       
        ├── bsp                 #  Board support package    
        └── common              #  Common headers and printf utility   


## How to build swerv_eh1 based reference design and run applications on Nexys4 DDR board?

This readme assumes the user is building the swerv reference design
from a Linux development machine.

--------------------------------------------------------------------------------------


Prerequisites: 
--------------
 1. Xilinx Vivado 2018.2 toolchain
 2. Nexys4 DDR board 
 3. Digilent [Board Files](https://reference.digilentinc.com/vivado/installing-vivado/start)  
   Note: this document also gives advice on properly installing vivado.
   If you have already vivado installed, you can just skip to section 3)

4. riscv toolchain installation for 32 bit riscv
    Installation instructions are available from the [RISC-V consortium](https://riscv.org/software-tools/risc-v-gnu-compiler-toolchain/.):
        Please note that for Swerv we need to specify the architecture as
    **rv32imc**.  So the correct configuration command for building
    the cross-compiler is:  
    `$ ./configure --prefix=/opt/riscv --with-arch=rv32imc`  
    `$ make`

5. riscv openocd installation, for programming and debugging the core.
    This is available on [github](https://github.com/riscv/riscv-openocd)
    Note: The RISC-V consortium gnu-compiler-toolchain package also
    has a copy of openocd.   Make sure your path is set correctly to
    point to commit version: af3a034 from riscv-openocd    

6. Jtag probe (e.g., [Olimex](https://www.olimex.com) ARM-USB-Tiny-H)


Setup:
------
1. Set the SWERV_EH1_FPGA_PATH environment variable to repository path.
        
        $ cd /path/to/swerv_eh1_fpga 
        $ export SWERV_EH1_FPGA_PATH=`pwd`
        
2. Copy `swerv_eh1` folder to the hardware directory
    (path:`${SWERV_EH1_FPGA_PATH}/hardware`) and set RV_ROOT to point
    `swerv_eh1` folder:  
    `$ export RV_ROOT=$SWERV_EH1_FPGA_PATH/hardware/swerv_eh1` 

3. Configure `swerv_eh1` core for the Nexys4 DDR board. We use default
   settings with `reset_vec=0x0`.  
   Go to configs folder (path: `$RV_ROOT/configs`) and run the
   `swerv.config` script as below:  
    `$ ./swerv.config -set reset_vec=0x0`

4. Create FPGA project using the vivado tcl project script file
   `nexys4ddr_refprj.tcl` inside `project/script` folder.  
   
        $ cd $SWERV_EH1_FPGA_PATH/hardware/project/script
        $ vivado -source nexys4ddr_refprj.tcl
    
   Vivado will open and start building your project files.  (Note:
   this assumes that your path is correctly setup to launch vivado
   2018.2 by default.  You may need to supply an absolute path to
   lauch the correct vivado version).   The GUI will stay open to in
   the new project environment.
  
5. Now that you have the project directory, you synthesize and
   implement your design to obtain the FPGA .bit file, using the same
   flow you would use for any other Xilinx design:
   `Menu >> Flow >> Run` Implementation
  
   

6. Now we are ready to program the Nexys4 DDR board. Connect the board
   to the host using micro usb cable to download the bit file and UART
   printfs. 

7. Connect the Olimex GDB connector with the Nexys4 DDR board to
   download and debug software applcations. 

8. Now, switch on the board and download the bit file using the Vivado
   Hardware Manager.  
    
    **Congratulations! You now have Swerv running on your FPGA!**

9. Next, we need to an application to run on this system. Go to `software/apps` folder and build the application using `make` command. We provide a makefile to generate the executable (e.g., hello.elf).  
There are two applications:   
     1) `hello`: print `Hello world from SweRV on FPGA!`  
     2) `sum`: compute sum of the numbers from 3 to 9.   

    NOTE: The `bsp` folder has the startup file, linker loader and openocd script.  
    NOTE: The `common` folder has printf, uart device functions and memory map information.

10. Once we generate an application executable, we need to configure openocd+GDB and UART device.  
    a. OpenOCD+GDB   
	    1. Run openocd: `swerv_openocd.cfg` file inside `bsp` folder  
	    `$ sudo openocd -f swerv_openocd.cfg` (sudo may be required to access the Olimex device directly)  
  	    2. Use another terminal and run GDB. Then connect to openocd, 
		   load and debug.
		   
            $riscv32-unknown-elf-gdb hello.elf < 
			....		 
			(gdb) target remote localhost:3333
			....
			(gdb) load
		    ....
		

	b. UART: we can see the uart ouput using minicom  
           To do this we need to determine which serial port is
           currently associated with the Nexus board, which can be
           checked using dmesg.  e.g.,
           
           $ dmesg | grep ttyUSB
	        ...
	        [19023.576527] usb 3-6: FTDI USB Serial Device converter now attached to ttyUSB2
            ...
      Assuming there is only one USB serial device, this
           means we want to use `/dev/ttyUSB2`:

           $ sudo minicom -D /dev/ttyUSB2

10. If everything works fine, you can see a beautiful message on the UART terminal:

    **Hello world from SweRV on FPGA!** 

