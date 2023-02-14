def ex_1
  # 1.1
  puts('Hello World')

  # 1.2
  puts 'What\'s your name?'
  name = gets.chop
  puts "Hello, #{name} \nWhat is your favorite programming language?"
  answer = gets.chop.downcase
  case answer
  when 'ruby'
    puts 'Ma boy!'
  when 'php'
    puts "Did I ever tell you what the definition of insanity is?'
  Insanity is doing the exact... same f**king thing... over and over again expecting... shit to change...
  That. Is. Crazy. The first time somebody told me that, I dunno, I thought they were bullshitting me, so, I shot him.
  The thing is... He was right. And then I started seeing, everywhere I looked, everywhere I looked all these f**king pricks,
  everywhere I looked, doing the exact same f**king thing... over and over and over and over again thinking
  'this time is gonna be different' no, no, no please... This time is gonna be different, I'm sorry, I don't like... The way...
  you are looking at me... Okay, Do you have a fu**ing problem in your head, do you think I am bullshitting you, do you think I am lying?
  F**k you! Okay? F**k you!... It's okay, man. I'm gonna chill, hermano. I'm gonna chill... The thing is...
  Alright, the thing is I killed you once already... and it's not like I am f**king crazy. It's okay...
  It's like water under the bridge. Did I ever tell you that ruby will be your favorite soon?"
  when 'python'
    puts "Ligma balls before you can comprehend ruby."
  when 'c++'
    puts "All of these voices inside of my head
  Blinding my sight in a curtain of red
  Frustration is getting bigger
  Bang, bang, bang, pull my Devil Trigger
  ...
  You're up to ruby upgrade, didn't you?"
  else
    puts 'It will be ruby soon'
  end

  # 1.3
  puts 'Enter any ruby code:'
  input_1 = gets.chop
  eval input_1

  puts 'Enter any Linux command:'
  input2 = `#{gets.chop}`
  puts input2
end

# 2
# Вариант № 4
# Метод 1 Найти количество четных чисел, не взаимно простых с данным
# Метод 2 Найти максимальную цифры числа, не делящуюся на 3
# Метод 3 Найти произведение максимального числа, не взаимно простого
# с данным, не делящегося на наименьший делитель исходно числа, и
# суммы цифр числа, меньших 5

def gcd(a, b)
  if a == 0 or b == 0 then
    a + b
  else
    next_a = a > b ? a % b : a
    next_b = a <= b ? b % a : b
    gcd(next_a, next_b)
  end
end

def ex_2_1

  def count_of_non_coprime(value, arr)
    counter = 0
    arr.each do |i|
      counter += (gcd(value, i) != 1 && i % 2 == 0) ? 1 : 0
    end
    counter
  end

  puts count_of_non_coprime(16, [*1..16])
end

def ex_2_2
  def max_value_dividing_by_3(value)
    max = -1
    value.digits.each { |i|
      max = max < i && i % 3 != 0 ? i : max
    }
    max
  end
  puts max_value_dividing_by_3(6732753)
end

def least_divisor(value)
  least_div = value
  (2..value).each { |i|
    if value % i == 0
      least_div = i
      break
    end
  }
  least_div
end

def ex_2_3
  def max_value(value, arr)
    max = arr[0]
    arr.each { |i|
      max = max < i && gcd(value, i) != 0 && i % least_divisor(value) != 0 ? i : max
    }
    max
  end
  def sum_least_than_5(value)
    sum = 0
    value.digits.each { |i|
      sum += i < 5 ? i : 0
    }
    sum
  end
  puts max_value(127, [*1..16]) * sum_least_than_5(127)
end

  #Задание 3 Массивы.
# Задачи.
  
# 1 Написать методы, которые находят минимальный,
# элементы, номер первого положительного элемента. Каждая
# операция в отдельном методе. Решить задачу с помощью
# циклов(for и while).


def find_min_for(arr)
  min = arr[0]
  for i in arr
    min = min > i ? i : min
  end
  min
end

def find_min_while(arr)
  min = arr[0]
  i = 0
  while i < arr.length
    min = min > arr[i] ? arr[i] : min
    i += 1
  end
  min
end

def find_first_positive_for(arr)
  first_pos = 0
  for i in arr
    if i > 0 then return i end
  end
  first_pos
end

def find_first_positive_while(arr)
  first_pos = 0
  i = 0
  while i < arr.length
    if arr[i] > 0 then return arr[i] end
    i += 1
  end
  first_pos
end 
 
# 2 Написать программу, которая принимает как аргумент два
# значения. Первое значение говорит, какой из методов задачи
# 1 выполнить, второй говорит о том, откуда читать список
# аргументом должен быть написан адрес файла. Далее
# необходимо прочитать массив и выполнить метод.

def do_stuff(func, data_source_path)
  data = File.open(data_source_path)
  arr = data.readline.split(' ').map(&:to_i)
  self.send(func, arr)
end
puts do_stuff(:find_first_positive_for, 'source.txt')
