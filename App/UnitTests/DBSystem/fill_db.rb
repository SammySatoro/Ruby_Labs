  require 'sqlite3'
  require 'faker'

  # Connect to the database (or create if it doesn't exist)
  db = SQLite3::Database.new('local_db_for_test.db')

  # Create the "Студенты" table
  db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS "Студенты" (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      last_name TEXT NOT NULL,
      first_name TEXT NOT NULL,
      patronymic TEXT NOT NULL,
      git TEXT,
      phone TEXT,
      telegram TEXT,
      email TEXT
    );
  SQL

  # Generate a random value for git field
  def generate_git
    Faker::Internet.url(host: 'github.com', scheme: 'https')
  end

  # Generate a Russian phone number
  def generate_russian_phone_number
    "+7#{rand(900..999)}#{rand(1000000..9999999)}"
  end

  # Generate a random contact field
  def generate_contact_field
    %w[phone telegram email].sample
  end

  # Generate a random contact value
  def generate_contact_value(field)
    case field
    when 'phone'
      generate_russian_phone_number
    when 'telegram'
      "@#{Faker::Internet.username(specifier: 3..20)}"
    when 'email'
      Faker::Internet.email
    end
  end

  # Generate a random Russian name
  def generate_russian_name
    Faker::Name.first_name
  end

  # Insert records into the "Студенты" table
  1000.times do
    last_name = generate_russian_name
    first_name = generate_russian_name
    patronymic = generate_russian_name
    git = Faker::Boolean.boolean ? generate_git : nil
    contact_field = generate_contact_field
    contact_value = generate_contact_value(contact_field)

    db.execute('INSERT INTO "Студенты" (last_name, first_name, patronymic, git, phone, telegram, email)
                VALUES (?, ?, ?, ?, ?, ?, ?)',
               [last_name, first_name, patronymic, git,
                contact_field == 'phone' ? contact_value : nil,
                contact_field == 'telegram' ? contact_value : nil,
                contact_field == 'email' ? contact_value : nil])
  end

  # Close the database connection
  db.close