### Hexlet tests and linter status:

[![Actions Status](https://github.com/usernaimandrey/rails-project-66/workflows/hexlet-check/badge.svg)](https://github.com/usernaimandrey/rails-project-66/actions)

## Test and Linter check

[![Test and Linter Check](https://github.com/usernaimandrey/rails-project-66/actions/workflows/CI.yml/badge.svg)](https://github.com/usernaimandrey/rails-project-66/actions/workflows/CI.yml)

## Code quality

[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

[Demo on Heroku](https://github-repository-quality-sh.herokuapp.com/)

Приложение для проверки качества кода репозитория

*Можно проверять репозитории языков JavaScript и Ruby*

Как развернуть приложение локально:

- склонируйте репозиторий
  ```
  $ git clone https://github.com/usernaimandrey/rails-project-66.git
  ```
- перейдите в дирректорию с приложением
  ```
  $ cd rails-project-66/
  ```
- установите зависимости
  ```
  $ make setup
  ```
- запустите приложение
  ```
  $ make start
  ```
- запустите тесты
  ```
  $ make test
- создайте приложение в [GitHUb](https://github.com/settings/developers)
- задайте в файле .env переменные окружения для работы с GitHub

  GITHUB_CLIENT_ID=

  GITHUB_CLIENT_SECRET=
- задайте переменную DIR_REPO= - дирректория где будут хранится склонированные репозитории
- воспользуйтесь утилитой [Ngrok](https://ngrok.com/) чтобы локально-запущеное приложение работало с хуками GitHub
- задайте переменной окружения BASE_URL= адрес ссылки которую сгенерирует Ngrok