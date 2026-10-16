#!/bin/bash

echo "=== 1. Loo katsefail (demo.txt) ==="
echo "hello world" > demo.txt
echo "Fail luua: demo.txt"
echo ""

echo "=== 2. Arvuta SHA-256 kontrollsumma ja salvesta see ==="
sha256sum demo.txt > demo.txt.sha256
echo "Loodud kontrollsumma faili sisu:"
cat demo.txt.sha256
echo ""

echo "=== 3. Kontrolli faili terviklust (oodatav: OK) ==="
sha256sum -c demo.txt.sha256
echo ""

echo "=== 4. Riku faili sisu (lisame ühe tähemärgi) ==="
echo "x" >> demo.txt
echo "Faili demo.txt sisu on nüüd muudetud."
echo ""

echo "=== 5. Kontrolli uuesti (oodatav: FAILED) ==="
sha256sum -c demo.txt.sha256

