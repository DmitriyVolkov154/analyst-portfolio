# Работа с API

В этой папке собраны мои коллекции Postman для работы с REST API.

## 📁 Файлы

| Файл | Описание |
|------|----------|
| `auth-and-search.collection.json` | Авторизация (логин, 2FA) + поиск по судебным делам |
| `client-edit.collection.json` | Редактирование клиента (физлицо → юрлицо) |
| `authority.collection.json` | Создание и редактирование органов рассмотрения |
| `work-day.collection.json` | Настройка продолжительности рабочего дня |

## 🔧 Используемые технологии

- REST API
- JWT авторизация
- Bearer token
- Защита запросов (app-sec)
- Методы: GET, POST, PUT, PATCH

## 📌 Примеры

### Авторизация
```json
POST /api/v1/auth/login
{
  "email": "user@mail.ru",
  "password": "******"
}
Редактирование клиента
json
PUT /api/v1/customer/469
{
  "name": "Дима",
  "type": "legal",
  "phone": "+79101825629",
  "email": "dr321e@rambler.ru"
}
Создание органа рассмотрения
json
POST /api/v1/authority
{
  "authority": "Верховный суд",
  "judge": "Волков Д.С.",
  "cabinet": "132/1"
}
