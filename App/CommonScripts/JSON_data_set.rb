require 'json'


def json_data_set(quan)
# Генерация случайной строки заданной длины
  def random_string(length)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a
    Array.new(length) { chars.sample }.join
  end

  # Список имен, фамилий и отчеств
  last_names = %w[Семенов
                  Иванов
                  Голованов
                  Мельников
                  Давыдов
                  Карпов
                  Демьянов
                  Ильин
                  Белоусов
                  Архипов
                  Барсуков
                  Макаров
                  Кошелев
                  Савицкий
                  Козлов
                  Головин
                  Федоров
                  Игнатьев
                  Герасимов
                  Сергеев
                  Туманов
                  Басов
                  Савельев
                  Устинов
                  Столяров
                  Кузнецов
                  Калинин
                  Жуков
                  Лазарев
                  Ананьев
                  Круглов
                  Яшин
                  Артамонов
                  Александров
                  Лапшин
                  Егоров
                  Лукин
                  Смирнов
                  Воронин
                  Аникин
                  Чижов
                  Абрамов
                  Романов
                  Грачев
                  Богданов
                  Громов
                  Балашов
                  Коновалов
                  Прохоров
                  Николаев
                  Соболев
                  Ковалев
                  Нестеров
                  Пономарев
                  Калугин
                  Воробьев
                  Крючков
                  Лебедев
                  Поляков
                  Крылов
                  Ларин
                  Булатов
                  Соловьев
                  Беликов
                  Павлов
                  Калашников
                  Колесников
                  Андреев
                  Никифоров
                  Митрофанов
                  Андрианов
                  Корчагин
                  Ефимов
                  Данилов
                  Яковлев
                  Маркин
                  Никулин
                  Соколов
                  Коршунов
                  Симонов
                  Бессонов
                  Савин
                  Мартынов
]

  first_names = %w[Евгений
                  Максим
                  Степан
                  Тимофей
                  Лев
                  Никита
                  Алексей
                  Кирилл
                  Даниил
                  Александр
                  Богдан
                  Дмитрий
                  Мирон
                  Артем
                  Святослав
                  Роман
                  Марк
                  Демид
                  Константин
                  Матвей
                  Иван
                  Филипп
                  Илья
                  Егор
                  Георгий
                  Макар
                  Андрей
                  Тимур
                  Михаил
                  Арсений
                  Николай
                  Руслан
                  Захар
                  Артемий
                  Семен
                  Антон
                  Савва
                  Эмиль
                  Игорь
                  Станислав
                  Вадим
                  Глеб
                  Григорий
                  Федор
]

  middle_names = %w[Олегович
                    Кириллович
                    Глебович
                    Максимович
                    Даниилович
                    Семенович
                    Федорович
                    Дмитриевич
                    Павлович
                    Артурович
                    Николаевич
                    Васильевич
                    Русланович
                    Львович
                    Михайлович
                    Ярославович
                    Иванович
                    Леонидович
                    Ильич
                    Серафимович
                    Всеволодович
                    Андреевич
                    Эмирович
                    Артемович
                    Данилович
                    Никитич
                    Тимурович
                    Евгеньевич
                    Владиславович
                    Алексеевич
                    Степанович
                    Владимирович
                    Макарович
                    Саввич
                    Давидович
                    Александрович
                    Тимофеевич
                    Артемьевич
                    Егорович
                    Эмильевич
                    Георгиевич
                    Миронович
                    Богданович
                    Лукич
                    Дамирович
                    Петрович
]

  # Список гитхаб-аккаунтов
#gits = ["https://github.com/user1", "https://github.com/user2", "https://github.com/user3", "https://github.com/user4", "https://github.com/user5"]
  gits = Array.new(quan) { |i| "https://github.com/user#{i}" }

  # Список номеров телефонов, телеграм-аккаунтов и email-адресов
  contacts = ["Номер телефона", "Telegram", "Email"]

  # Генерация случайного объекта JSON
  def generate_object(first_names, last_names, middle_names, gits, contacts)
    first_name = first_names.sample
    last_name = last_names.sample
    middle_name = middle_names.sample
    git = gits.sample
    contact = contacts.sample

    # Определение случайного контакта
    if contact == "Номер телефона"
      phone_number = "+7#{rand(1000..9999)}#{rand(100000..999999)}"
      telegram = nil
      email = nil
    elsif contact == "Telegram"
      phone_number = nil
      telegram = "@#{random_string(8)}"
      email = nil
    else
      phone_number = nil
      telegram = nil
      email = "#{random_string(10)}@#{random_string(5)}.com"
    end

    # Создание объекта JSON
    {
      "last_name": last_name,
      "first_name": first_name,
      "patronymic": middle_name,
      "git": [git, nil].sample,
      "phone": phone_number,
      "telegram": telegram,
      "email": email
    }
  end

  # Генерация массива объектов JSON
  dataset = []
  quan.times do
    dataset.push(generate_object(first_names, last_names, middle_names, gits, contacts))
  end

  # Сохранение массива в файл
  File.write('dataset.json', JSON.pretty_generate(dataset))
end

json_data_set(100)