# Unittest action
1. Setup your ESP32 firmware runs unit tests and `esp_restart()` (to stop QEMU);
2. Action builds firmware;
3. Action runs firmware ar QEMU;
4. Action writes QEMU log output to file;
5. Action converts Unity output to JUnit report.xml;
6. You can feed report.xml to another action to publish test resuls;

## Example workflow with results publishing
```
name: Test
on:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v2
      - name: Build and show result
        uses: batov/esp32_qemu_runner@v4.3
      - name: Publish Unit Test Results
        uses: EnricoMi/publish-unit-test-result-action@v1
        if: always()
        with:
            files: report.xml
```
## Versions
* `uses: batov/esp32_qemu_runner@v4.3` - It will use ESP-IDF v4.3
* `uses: batov/esp32_qemu_runner@v4.4` - It will use ESP-IDF v4.4

## Example project
https://github.com/Batov/esp32_unittest
