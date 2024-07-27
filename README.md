# bms_cpp
This is a bank management system project written in C++.

## Installation and Running the Application

1. Clone the GitHub repository:
   ```bash
   git clone https://github.com/vickvey/bms_cpp.git
   ```

2. Go to the project root:
   ```bash
   cd bms_cpp/
   ```

3. Create and activate a new python virtual environment:
    ```bash
    python3 -m venv .venv
    source .venv/bin/activate
    ```

4. Install the necessary python dependencies:
    ```bash
    pip install -r requirements.txt
    ```

5. Give necessary permissions to `run.sh`:
    ```bash
    chmod +x run.sh
    ```
6. Create a new conan profile with default settings:
   ```bash
   conan profile detect
   ```

8. Run the script `run.sh` finally:
    ```bash
    ./run.sh
    ```
