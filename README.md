## Requirements

- Ruby 3.4.7

## Setup

```bash
gem install bundler
bundle install
```

## Usage

```bash
ruby main.rb <input_file>
```

Example:

```bash
ruby main.rb fixtures/input-1.txt
```

Output:

```
2 book: 24.98
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 42.32
```

Input files follow the format `<quantity> <product name> at <unit price>`, one item per line. See `fixtures/` for examples.

## Tests

```bash
bundle exec rspec
```

## Design decisions

**Class responsibilities** -- Each class has a single job:
- `Parser` -- parses and validates input lines into structured data
- `Product` / `LineItem` -- data objects representing items in a basket
- `Purchase` -- orchestrates parsing a list of input lines into line items
- `ProductCategorizationService` -- determines if a product is food, medicine, book, or other (drives tax exemption)
- `TaxCalculator` -- applies tax rates and the rounding-up-to-0.05 rule
- `Receipt` -- formats the final output with line items, sales taxes, and total

**Product categorization** -- I assumed a known list of product keywords for classification. In production this could come from a database or external service, but for this exercise constants in `ProductCategorizationService` keep it simple and testable. The service strips presentation words ("box of", "bottle of", "bar") to match the core product name against these lists.

**No external dependencies** -- Only RSpec is used (for testing). All business logic is pure Ruby with no frameworks.
