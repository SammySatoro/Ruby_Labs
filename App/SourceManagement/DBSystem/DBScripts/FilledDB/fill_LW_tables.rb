require 'sqlite3'

# Подключение к базе данных SQLite3
db = SQLite3::Database.new('D:\RubyProject\DoneApp\SourceManagement\DBSystem\my_base.db')

# Создание таблицы "LaboratoryWork"
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS LaboratoryWork (
    number INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    themes TEXT,
    list_of_tasks TEXT,
    date_of_issue TEXT NOT NULL
  );
SQL

# Массив произвольных значений для themes
themes = ["Тема 1", "Тема 2", "Тема 3", "Тема 4", "Тема 5"]

# Массив произвольных значений для list_of_tasks
tasks = ["Задача 1", "Задача 2", "Задача 3", "Задача 4", "Задача 5"]

# Генерация случайных значений и вставка записей в таблицу
10.times do |i|
  number = i + 1
  name = "Лабораторная работа #{number}"
  date_of_issue = Time.at(rand(Time.new(2000, 1, 1)..Time.new(2023, 12, 31))).strftime("%d.%m.%Y")
  themes_value = rand(0..1) == 1 ? themes.sample : nil
  list_of_tasks_value = rand(0..1) == 1 ? tasks.sample : nil

  db.execute("INSERT INTO LaboratoryWork (number, name, date_of_issue, themes, list_of_tasks) VALUES (?, ?, ?, ?, ?)", [number, name, date_of_issue, themes_value, list_of_tasks_value])
end

# Закрытие соединения с базой данных
db.close
