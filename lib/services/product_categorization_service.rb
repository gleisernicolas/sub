class ProductCategorizationService
  FOODS_LIST = %w[chocolate chocolates rice].freeze
  MEDICINES_LIST = ["headache pill", "headache pills", "insulin"].freeze
  BOOKS_LIST = %w[book books].freeze
  PRESENTATIONS = %w[bar box bottle packet bag can jar tube pack carton].freeze

  def self.category(product_name)
    clean_name = strip_to_product_name(product_name)
    return 'food' if FOODS_LIST.include?(clean_name)
    return 'medicine' if MEDICINES_LIST.include?(clean_name)
    return 'book' if BOOKS_LIST.include?(clean_name)
    'others'
  end

  private

  def self.extract_presentation(product_name)
    name = strip_imported(product_name)

    if name.include?(" of ")
      before_of = name.split(" of ", 2).first
      word = before_of.split.last
      
      return word if PRESENTATIONS.include?(word)
    end

    last_word = name.split.last
    return last_word if PRESENTATIONS.include?(last_word)

    nil
  end

  def self.strip_to_product_name(product_name)
    name = strip_imported(product_name)

    if name.include?(" of ")
      return name.split(" of ", 2).last
    end

    words = name.split
    if words.length > 1 && PRESENTATIONS.include?(words.last)
      return words[0...-1].join(" ")
    end

    name
  end

  def self.strip_imported(product_name)
    product_name.sub(/^imported\s+/, '')
  end
end