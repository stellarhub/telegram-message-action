# Combine Files Action

This action combines two input files into a single output file.

## Inputs

- `token`: the token received from Bot Father during registration
- `chat_id`: the chat ID
- `message`: The message to telegram

## Usage

```yaml
steps:
- uses: stellarhub/telegram-message-action@v1
  with:
    token: 'the token you received from Bot Father'
    chat_id: '-11111111111'
    message: 'The message to telegram'

