require 'test/unit'
require '/home/sammysatoro/RubyProjects/Ruby_Labs/App/Models/student.rb'

class StudentTest < Test::Unit::TestCase
  def setup
    @valid_name = 'Дмитрий'
    @invalid_name = '123'
  end

  def test_valid_name
    assert_true(Student.valid_name?(@valid_name))
    assert_false(Student.valid_name?(@invalid_name))
  end

  def test_from_string
    str = 'Кот, Дмитрий, Олегович, https://github.com/leslie, +79181513782, @kimavv, john@example.com'
    student = Student.from_string(1, str)

    assert_equal(1, student.id)
    assert_equal('Кот', student.last_name)
    assert_equal('Дмитрий', student.first_name)
    assert_equal('Олегович', student.patronymic)
    assert_equal('https://github.com/leslie', student.git)
    assert_equal('+79181513782', student.phone)
    assert_equal('@kimavv', student.telegram)
    assert_equal('john@example.com', student.email)
  end

  def test_last_name_validation
    student = Student.new(1, 'Doe', 'John', 'Smith')

    assert_nothing_raised(ArgumentError) { student.last_name = 'Doe' }
    assert_raise(ArgumentError) { student.last_name = nil }
    assert_raise(ArgumentError) { student.last_name = '123' }
  end

  def test_first_name_validation
    student = Student.new(1, 'Doe', 'John', 'Smith')

    assert_nothing_raised(ArgumentError) { student.first_name = 'John' }
    assert_raise(ArgumentError) { student.first_name = nil }
    assert_raise(ArgumentError) { student.first_name = '123' }
  end

  def test_patronymic_validation
    student = Student.new(1, 'Doe', 'John', 'Smith')

    assert_nothing_raised(ArgumentError) { student.patronymic = 'Smith' }
    assert_raise(ArgumentError) { student.patronymic = nil }
    assert_raise(ArgumentError) { student.patronymic = '123' }
  end

  def test_get_info
    student = Student.new(1, 'Doe', 'John', 'Smith', git: 'https://github.com/leslie', phone: '+79181513782')

    expected_info = 'Doe J. S., https://github.com/leslie, phone:+79181513782'
    assert_equal(expected_info, student.get_info)
  end

  def test_as_hash
    student = Student.new(1, 'Doe', 'John', 'Smith', git: 'https://github.com/leslie', phone: '+79181513782')
    expected_hash = {
      "id" => 1,
      "last_name" => 'Doe',
      "first_name" => 'John',
      "patronymic" => 'Smith',
      "git" => 'https://github.com/leslie',
      "phone" => '+79181513782',
      "telegram" => nil,
      "email" => nil
    }

    assert_equal(expected_hash, student.as_hash)
  end
end