# Usage
```Bash
TG_API_KEY=<key> TG_CHAT_ID=<chat_id> ./proxy.sh /path/to/source /path/to/dest
```

To run in background:
```bash
TG_API_KEY=<key> TG_CHAT_ID=<chat_id> nohup ./proxy.sh /path/to/source /path/to/dest > out.log 2>&1 &
```

## Dependencies
- ffmpeg
- curl
- bash
