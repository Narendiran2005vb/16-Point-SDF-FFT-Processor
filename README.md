# 8-Point Pipelined Radix-2 DIT FFT Hardware Accelerator

![FFT Architecture Placeholder](docs/Schematic.jpeg)

## Overview
This repository contains a synthesizable, high-performance 8-point Fast Fourier Transform (FFT) hardware accelerator written in Verilog. It implements a **Radix-2 Decimation-in-Time (DIT)** algorithm using a **Single Delay Feedback (SDF)** pipeline architecture. 

Designed for real-time Digital Signal Processing (DSP) applications, this core features 100% hardware utilization and can process continuous, back-to-back data frames with zero dead clock cycles.

## Key Architecture Features
* **Pipelined SDF Architecture:** Achieves continuous streaming throughput after initial pipeline latency.
* **Fixed-Point Arithmetic:** Optimized for hardware with carefully managed bit-growth (1 bit per stage) to prevent overflow without the overhead of floating-point logic.
* **Trivial Rotators:** Stages 1 and 2 utilize trivial multiplexer-based rotators (multiplying by $1$ and $-j$) to save silicon area, avoiding expensive DSP multiplier slices.
* **Twiddle Factor ROM:** Pre-computed, scaled sine/cosine values for Stage 3, complete with combinational truncation logic to maintain datapath widths.

## Pipeline Stages & Data Flow
* **Input:** 16-bit signed complex numbers. (Requires bit-reversed input order for DIT).
* **Stage 1 (L=1):** 2-Point Combiner. Output grows to 17 bits.
* **Stage 2 (L=2):** 4-Point Combiner with Trivial Rotator. Output grows to 18 bits.
* **Stage 3 (L=4):** 8-Point Combiner with Complex Multiplier & Twiddle ROM. Output grows to 19 bits.

## Simulation & Verification
Verified using Icarus Verilog (`iverilog`). The testbench feeds an impulse signal and checks against the mathematical expected DC frequency bins, accurately modeling fixed-point quantization noise.

![Simulation Waveform Placeholder](docs/Waveform.jpeg)

## ASIC Synthesis & Physical Design (Cadence)
This design was synthesized using **Cadence Genus** and taken through physical implementation using **Cadence Innovus**.

### Logical Synthesis Results (Genus)
* **Technology Node:** [45nm]
* **Target Clock Frequency:** [10 MHz]
* **Total Cell Area:** [13873.572] $\mu m^2$
* **Total Power:** [205012.224] nW

### Physical Design (Innovus)
![Innovus Layout Placeholder](docs/innovus_layout.png)
* **Core Utilization:** [65.207%]
* **Setup/Hold Slack:** [1.033/0.009] ns
<!-- * **Critical Path:** [Briefly describe the critical path, e.g., Stage 3 Complex Multiplier] -->

## How to Run the RTL Simulation
```bash
# Compile the Verilog files
iverilog -o mydesign tb_fft_8point.v fft_8point.v fft_stage3.v fft_stage2.v fft_2point.v butterfly.v trivial_rotator.v

# Run the simulation
vvp .\mydesign

---

# Author

**Narendiran**
ECE Student
Interest Areas:

* Processor Architecture
* Digital Design
* Radar Systems
* FPGA and SDR Systems

---