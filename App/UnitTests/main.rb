require 'glimmer-dsl-libui'
include Glimmer

boxes = vertical_box {
  button('first')
  button('second')
}
window('My App', 400, 200) { |window|
  vertical_box { |box|
    print window.methods
  }
}.show