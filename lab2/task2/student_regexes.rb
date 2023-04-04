module StudentRegexes
  ID_REGEX = /^[0-9]+$/
  PHONE_REGEX = /^(\+7|8)?[\s.-]?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{2}[\s.-]?\d{2}$/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  GIT_REGEX = /^https?:\/\/github\.com\/([a-zA-Z_\d]([a-zA-Z_\d]|-([a-zA-Z_\d])){0,38})\/?$/
  TELEGRAM_REGEX = /^@[a-zA-Z0-9_]{5,32}$/
  NAME_PART_REGEX = /^([A-Z][a-z]*|[А-Я][а-я]*)/
  FROM_STRING_REGEX = /[ ,]+/

end
