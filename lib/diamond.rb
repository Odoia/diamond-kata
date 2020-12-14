require 'utils/string_utils'

class Diamond

  def initialize
    @first_letter = 'A'
    @result = ''
  end

  def build(input)
    return '' unless valid_input?(input)

    @count = (first_letter..input.upcase).count
    make_diamound
  end

  private

  attr_reader :first_letter, :count, :result

  def make_diamound
    if count > 1
      build_first_letter
      build_remaining_letters(edges_quantity: count - 2, middle_quantity: 1,
                              current_letter: first_letter.next, index: 1, increase: true)
    end

    build_first_letter
  end

  def build_first_letter
    edges = '_' * (count - 1)
    result.concat(edges, first_letter, edges, "\n")
  end

  def build_remaining_letters(edges_quantity:, middle_quantity:, current_letter:, index:, increase:)
    return if index.zero?

    edges = '_' * edges_quantity
    middle = '_' * middle_quantity
    result.concat(edges, current_letter, middle, current_letter, edges, "\n")

    if increase == true && index < (count - 1)
      build_remaining_letters(edges_quantity: edges_quantity - 1, middle_quantity: middle_quantity + 2,
                              current_letter: current_letter.next, index: index + 1, increase: true)
      return
    end

    build_remaining_letters(edges_quantity: edges_quantity + 1, middle_quantity: middle_quantity - 2,
                            current_letter: current_letter.previous, index: index - 1, increase: false)
  end

  def valid_input?(input)
    regex = /[a-zA-Z\u00C0-\u00FF ]+/i
    input.length == 1 && input.match(regex).to_s.length == 1
  end
end
