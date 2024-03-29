# Electronic Remittance Advice (ERA) 835 parser

[![Gem Version](https://badge.fury.io/rb/era_835_parser.svg)](http://badge.fury.io/rb/era_835_parser) [![License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](https://github.com/diasks2/era_835_parser/blob/master/LICENSE.txt)

This is a gem to parse ERAs (both the machine readable and human readable versions), the electronic equivalent of a paper Explanation of Benefits (EOB). An electronic remittance advice (ERA) is an electronic data interchange (EDI) version of a medical insurance payment explanation. It provides details about providers' claims payment, and if the claims are denied, it would then contain the required explanations.

## Install

**Ruby**
```
gem install era_835_parser
```

**Ruby on Rails**
Add this line to your application’s Gemfile:
```ruby
gem 'era_835_parser'
```

## Usage

```ruby
era = Era835Parser::Parser.new(file_path: '/Desktop/era.txt').parse

puts era[:addressed_to] # The person/name the ERA is addressed to

# The output is grouped by check number with each claim grouped under its respective check
if !era[:checks].nil?
  era[:checks].each do |check_number, check|
    puts check[:check_number] # Check number
    puts check[:amount] # Check amount
    puts check[:number_of_claims] # Number of claims this check covers (integer)
    puts check[:npi_tax_id] # NPI or Tax ID of payee
    puts check[:payee] # Check payee
    puts check[:payer_name] # Payer name
    puts check[:payer_address] # Payer address
    puts check[:payer_city] # Payer city
    puts check[:payer_state] # Payer state
    puts check[:payer_zip_code] # Payer zip code
    puts check[:payer_tax_id] # Payer tax id
    puts check[:payer_edi_id] # Payer EDI id
    puts check[:date] # Check date (string mm/dd/yyyy)
    if !check[:eras].nil?
      check[:eras].each do |era_counter, individual_era|
        puts individual_era[:era_text] # ERA text
        puts individual_era[:patient_id] # Patient ID
        puts individual_era[:patient_name] # Patient name
        puts individual_era[:patient_last_name] # Patient last name (titlized)
        puts individual_era[:patient_first_name] # Patient first name (titlized)
        puts individual_era[:rendering_provider_name] # Rendering provider name
        puts individual_era[:rendering_provider_last_name] # Rendering provider last name (titlized)
        puts individual_era[:rendering_provider_first_name] # Rendering provider first name (titlized)
        puts individual_era[:charge_amount] # Total charge amount (integer)
        puts individual_era[:payment_amount] # Total payment amount (integer)
        puts individual_era[:account_number] # Account number
        puts individual_era[:claim_status_code] # Claim status code
        puts individual_era[:status] # Claim status code description
        puts individual_era[:payer_claim_control_number] # Payer claim control number
        puts individual_era[:claim_statement_period_start] # Claim statement period start
        puts individual_era[:claim_statement_period_end] # Claim statement period end
        if !individual_era[:line_items].nil?
          individual_era[:line_items].each do |line_item_counter, line_item|
            puts line_item[:service_date] # Date of service (string mm/dd/yyyy)
            puts line_item[:cpt_code] # CPT code
            puts line_item[:charge_amount] # Charge amount (integer)
            puts line_item[:payment_amount] # Payment amount (integer)
            puts line_item[:total_adjustment_amount] # Total adjustment amount (integer)
            puts line_item[:remark_code] # Remark code
            puts line_item[:remarks] # Remarks
            puts line_item[:reference_number] # Reference number
            if !line_item[:adjustment_groups].nil?
              line_item[:adjustment_groups].each do |adjustment_group_counter, adjustment_group|
                puts adjustment_group[:adjustment_group] # Adjustment group
                puts adjustment_group[:adjustment_group_code] # Adjustment group code
                puts adjustment_group[:adjustment_amount] # Adjustment amount (integer)
                puts adjustment_group[:reason_code] # Reason code
                puts adjustment_group[:translated_reason_code] # Translated reason code
              end
            end
          end
        end
      end
    end
  end
end

# View any adjustments
if !era[:adjustments].nil?
  era[:adjustments].each do |adjustment_counter, adjustment|
    puts adjustment[:adjustment_date] # Adjustment date (string mm/dd/yyyy)
    puts adjustment[:provider_id] # Provider ID
    puts adjustment[:reference_id] # Reference ID
    puts adjustment[:adjustment_amount] # Adjustment amount (integer)
    puts adjustment[:reason] # reason
    puts adjustment[:reason_code] # reason
  end
end

```

### Parser options
`file_path` - A string identifying the location of the local or remote file.
```ruby
# String
era = Era835Parser::Parser.new(file_path: '/Desktop/era.txt').parse
```
`file` - An `IO` object to process.
```ruby
# File object
era = Era835Parser::Parser.new(file: File.open('/Desktop/era.txt')).parse

# StringIO
string_io = StringIO.new('Example 835 text')
era = Era835Parser::Parser.new(file: string_io).parse
```

## Contributing

1. Fork it ( https://github.com/diasks2/era_835_parser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Publishing

1. gem build era_835_parser.gemspec
2. gem push era_835_parser-x.x.x.gem

## License

The MIT License (MIT)

Copyright (c) 2019 Kevin S. Dias

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.