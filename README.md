# Combine Files Action

This action combines two input files into a single output file.

## Inputs

- `token`: the token received from Bot Father during registration
- `chat_id`: the chat ID
- `message`: The message to telegram

## Usage

```yaml
steps:
- name: Send Telegram messsage
  uses: stellarhub/telegram-message-action@v1
  with:
    chat_id: ${{ vars.TELEGRAM_CHAT_ID }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    message: "Your message"
```
