# N76E003 Real-Time Temperature Sensor & MATLAB Strip Chart

A dual-component embedded systems project featuring low-level 8051 Assembly firmware for the N76E003 microcontroller and a companion MATLAB script for real-time serial data acquisition, unit conversion, and live strip-chart plotting.

## Features
### Microcontroller Firmware (8051 Assembly)
- Analog-to-Digital Conversion: Configures the N76E003 internal ADC to read temperature sensor inputs on channel 7 (P1.1).
- 32-Bit Assembly Math: Implements custom math and BCD conversion libraries (math32.inc) to translate raw ADC counts into precise voltages and temperature values.
- Interactive Unit Selection: Features a debounced mode-switching button connected to MODE (P1.0) that lets users cycle through temperature units (Celsius, Fahrenheit, and Kelvin) on the fly.
- LCD Interface: Drives a 16x2 character LCD display using a custom 4-bit interface library (LCD_4bit.inc) to show real-time voltage and temperature readouts.
- UART Serial Streaming: Transmits formatted BCD temperature data packets and active units over UART at 115200 baud.
-
### Data Visualization (MATLAB)
- Live Serial Communication: Establishes a serial connection (COM5 at 115200 baud) to listen to the microcontroller data stream.
- Real-Time Strip Chart: Plots incoming temperature readings dynamically using custom chart helper functions.
- Dynamic Unit-Change Handling: Automatically detects when the user changes units on the hardware, recalculates historical plot data, adjusts axis limits (ylim), and updates axis labels seamlessly mid-stream.

## Hardware implementation 
- Microcontroller: N76E003 development board.
- Sensor: Analog temperature sensor.
- Input: Pushbutton wired for unit toggling.
- Display: 16x2 character LCD wired to designated port pins.
-  Communication: USB-to-UART bridge for PC serial connectivity. 
