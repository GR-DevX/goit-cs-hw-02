#!/bin/bash

# Список вебсайтів для перевірки
sites=("https://google.com" "https://facebook.com" "https://twitter.com")

# Файл для запису логів
logfile="website_status.log"

# Очищення файлу логів перед початком
> "$logfile"

# Перевірка кожного сайту
for site in "${sites[@]}"
do
  # Використання curl для отримання HTTP статус-коду
  # -o /dev/null: не виводити тіло відповіді
  # -s: тихий режим
  # -L: слідувати за переадресаціями
  # -w "%{http_code}": вивести тільки HTTP-код
  status_code=$(curl -o /dev/null -s -L -w "%{http_code}" "$site")

  # Перевірка статус-коду
  if [ "$status_code" -eq 200 ]; then
    echo "$site is UP" >> "$logfile"
  else
    echo "$site is DOWN" >> "$logfile"
  fi
done

echo "Результати записано у файл $logfile"