# Single cycle CPU - running on FPGA
Implement all instructions for RISC-V including Branch instructions. This repository will provide the automation flow for running the design into hardware.

## Steps to run:
1. Clone this repository:
```
git clone https://gitlab.com/BalaDhinesh/riscv_myth_fpga
cd riscv_myth_fpga
```

2. Run the python file. This will take care of creating a block design on Vivado and generate bitstream.
```
python harness.py
```
Check the entire set of printed messages for any "ERROR" lines. If you see "ERROR" anywhere, that means the implementation failed.

3. Once the bitstream has been generated successfully, following outputs are generated.

- ```harness_axi_ip```   - IP generation. Leave this for now.

- ```harness_axi_proj``` - Vivado project file. 

- ```PYNQ_cpu.tar```       - PYNQ Overlay(bitstream related) files.

4. Open the FPGA Remote Jupyter server. 
- Upload the ```PYNQ_cpu.tar``` tar file 
- Open terminal in server and untar using 
```
cd /home/xilinx/jupyter_notebooks
tar -xvf PYNQ_cpu.tar
```
- Now run the ```cpu.ipynb``` file.
