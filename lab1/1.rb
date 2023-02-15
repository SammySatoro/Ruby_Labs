def ex_1
  # 1.1
  puts('Hello World')

  # 1.2
  username = ARGV[0]
 
  puts "What\'s your name?"
  puts "Hello, #{username} \nWhat is your favorite programming language?"
  answer = STDIN.gets.chop.downcase
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
  input_1 = STDIN.gets.chop
  eval input_1

  puts 'Enter any Linux command:'
  input2 = `#{STDIN.gets.chop}`
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

def do_3_2
  args = ARGV
  def do_stuff(func, data_source_path)
    puts func.class
    data = File.open(data_source_path)
    arr = data.readline.split(' ').map(&:to_i)
    self.send(func, arr)
  end
  puts do_stuff( "#{args[0]}".to_sym, args[1])
end
#do_3_2

#Задание 4 Методы, принимающие блок как аргумент
# Задачи.
# Решить предложенные задачи по вариантам. Задание в отдельную
# программу. Каждая задача отдельный метод БЕЗ ИСПОЛЬЗОВАНИЯ
# ЦИКЛОВ. Реализовать выбор пользователя какую задачу решать.
# Чтение из файла или с клавиатуры. Каждый метод отдельный коммит.
# Итоговая задача – отдельный коммит.
# Вариант4. Задачи 4, 16, 28, 40, 52

# 4
# 5 7 3 1 2 3 7
# 0 1 2 3 4 5 6
# 1 6 0 2 5 4 3
def decreasing_sequence(arr)
  (0..arr.size - 1).sort_by { |a| -arr[a] }
end

#puts decreasing_sequence([5, 7, 3, 1, 2, 3, 7]) 

def items_between_maxes_f_s(arr)
  max = arr.max
  max_indices = arr.each_index.select {|i| arr[i] == max}
  arr[max_indices[0] + 1..max_indices[1] - 1]
end
#puts items_between_maxes_f_s([7, 6, 6, 1, 2, 7, 7])

def items_between_maxes_f_l(arr)
  max = arr.max
  max_indices = arr.each_index.select {|i| arr[i] == max}
  arr[max_indices[0] + 1..max_indices[-1] - 1]
end
#puts items_between_maxes_f_l([7, 6, 7, 3, 1, 2, 7, 7])

def find_min_even(arr)
  arr.filter {|a| a % 2 == 0}.min || 'no even numbers'
end
#puts find_min_even [1, 4, 5, -6, 1, -2]

def prime?(value)
  (2..value - 1).filter {|d| value % d == 0}.length == 0 &&
    !(0..1).include?(value)
end

def create_list_prime_divisors(value, alpha)
  (2..value - 1).filter {|d| prime?(d) && value % d == 0}.
    map {|x| value % (x ** alpha) != 0 ? x : [x] * alpha}
end
#puts create_list_prime_divisors 1125, 3

def method_selection
  methods = %w[decreasing_sequence items_between_maxes_f_s items_between_maxes_f_l find_min_even create_list_prime_divisors]
  puts "Select method by index:
    0. exit selection
    1. decreasing_sequence (array)
    2. items_between_maxes_f_s (array)
    3. items_between_maxes_f_l (array)
    4. find_min_even (array)
    5. create_list_prime_divisors (value, alpha)"
  method_index = STDIN.gets.chop.to_i
  if method_index > 0 && method_index <= 4
    puts 'Array: '
    arr = STDIN.gets.chop.split(' ').map(&:to_i)
    eval "puts #{methods[method_index - 1]} #{arr}"
  elsif method_index == 5
    puts 'Value: '
    value = STDIN.gets.chop.to_i
    puts 'Alpha: '
    alpha = STDIN.gets.chop.to_i
    eval "puts #{methods[method_index - 1]} #{value}, #{alpha}"
  else
    puts 'Bye!'
  end
end
#method_selection
