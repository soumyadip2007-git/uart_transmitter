
import serial
import time

PORT = "COM6"
BAUD_RATE = 9600

try:
    with serial.Serial(PORT, BAUD_RATE, timeout=1) as ser:
        time.sleep(2)
        print("Connected to Basys3 on COM6")
        print("Press the center button to transmit characters.")

        while True:
            data = ser.read(1)
            if data:
                print(data.decode("ascii", errors="replace"), end="", flush=True)

except serial.SerialException as e:
    print(f"Serial error: {e}")
except KeyboardInterrupt:
    print("\nStopped.")

