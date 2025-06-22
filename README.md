# SPI Master-Slave Verification System (SystemVerilog + Vivado)

This project implements and verifies a **Serial Peripheral Interface (SPI)** Master-Slave communication protocol using SystemVerilog and Vivado.

## Project Structure

├── rtl/ # RTL design files
│ ├── spi_master.sv
│ ├── spi_slave.sv
│ └── top.sv
│
├── pkg/ # SystemVerilog package
│ └── spi_pkg.sv
│
├── classes/ # UVM-style components
│ ├── transaction.sv
│ ├── generator.sv
│ ├── driver.sv
│ ├── monitor.sv
│ ├── scoreboard.sv
│ └── environment.sv
│
├── sim/ # Interface definition
│ └── waveform
│
├── tb/
│   ├── tb_top.sv
│   └── spi_if.sv 
│
├── .gitignore
└── README.md

## ---

## 🚀 Features

- ✔️ SPI Master-Slave full-duplex data communication
- ✔️ Modular UVM-style testbench (lightweight, no UVM library)
- ✔️ Self-checking scoreboard for data validation
- ✔️ Fully synthesizable and testable RTL

---

## 🛠️ Tools Used

- **Vivado (Xilinx)**
- **SystemVerilog (IEEE 1800)**
- **GTKWave** (for viewing VCD if needed)

---

## ▶️ Running the Simulation in Vivado

> ⚠️ **Follow this exactly to avoid simulation errors.**

### Step-by-Step Vivado Setup

1. Create a **new RTL project** in Vivado (don't add sources yet).
2. In **Sources → Add Files**:
   - **Design Sources**:
     - `rtl/top.sv`, `rtl/spi_master.sv`, `rtl/spi_slave.sv`
   - **Simulation Sources**:
     - `pkg/spi_pkg.sv`
     - `sim/spi_if.sv`
     - `tb/tb_top.sv`
     - All `classes/*.sv` files

3. Ensure `spi_pkg.sv` is added *after* all the `classes/*.sv` files.

4. Set include path:
   - Go to `Tools → Settings → Simulation → Verilog Options`
   - Add this under "Other Verilog options":
     ```
     +incdir+./classes
     ```

5. **Run Behavioral Simulation** from `tb_top.sv`.
## Author

Shubhamjeet Singh – M.Eng – Electrical & Computer Engineering, Concordia University, Canada

---

