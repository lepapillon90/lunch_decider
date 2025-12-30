
try:
    with open('signing_output.txt', 'r', encoding='utf-16') as f:
        for line in f:
            if 'SHA1' in line:
                print(line.strip())
except Exception as e:
    print(f"Error: {e}")
