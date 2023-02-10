# 1
puts('Hello World')

# 2
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

# 3
puts 'Enter any ruby code:'
input_1 = gets.chop
eval input_1

puts 'Enter any Linux command:'
input2 = `#{gets.chop}`
puts input2
