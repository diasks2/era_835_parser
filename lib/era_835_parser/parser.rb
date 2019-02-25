require 'open-uri'

# Era835Parser::Parser.new(file_path: "../era_835_parser/spec/test_era.txt").parse
module Era835Parser
  class Parser
    attr_reader :file_path
    def initialize(file_path:)
      @file_path = file_path
    end

    def parse
      # hash initialization
      era = Hash.new
      checks = Hash.new
      line_items = Hash.new
      adjustment_groups = Hash.new
      adjustments = Hash.new
      individual_era = Hash.new
      individual_line_item = Hash.new
      check_number = ''
      era_text = "--------------------------------------------------------------------------------------------------------------------------------------------------------\n"

      # counters
      adjustment_counter = 0

      # trigger variables
      adjustments_start = false
      checks_start = false
      eras_start = false
      next_line_check_number = false
      next_line_address = false
      next_line_city = false
      next_line_tax_id = false
      next_line_payer_claim_control = false
      next_line_claim_statement_period = false
      next_line_line_item = false
      next_line_adjustment_group = false

      open(file_path).readlines.each do |line|
        era_text += line if eras_start && line !~ /-{10,}/i

        if line.include?("Dear:")
          era[:addressed_to] = line.gsub("Dear:", "").strip
        end

        if line !~ /={10,}/i && adjustments_start == true
          adjustment = Hash.new
          adjustment[:adjustment_date] = /\d+\/\d+\/\d+/.match(line)[0].strip if !/\d+\/\d+\/\d+/.match(line).nil?
          adjustment[:provider_id] = /\d+\/\d+\/\d+\s+\d+\s+[^\s]+/.match(line)[0].split(" ")[1].strip if !/\d+\/\d+\/\d+\s+\d+\s+[^\s]+/.match(line).nil?
          adjustment[:reference_id] = /\d+\/\d+\/\d+\s+\d+\s+[^\s]+/.match(line)[0].split(" ")[2].strip if !/\d+\/\d+\/\d+\s+\d+\s+[^\s]+/.match(line).nil?
          adjustment[:adjustment_amount] = (/\d+\/\d+\/\d+\s+\d+\s+[^\s]+\s+[\-\d\.]+/.match(line)[0].split(" ")[3].strip.to_f * 100).to_i if !/\d+\/\d+\/\d+\s+\d+\s+[^\s]+\s+[\-\d\.]+/.match(line).nil?
          adjustment[:reason] = line.gsub(/\d+\/\d+\/\d+\s+\d+\s+[^\s]+\s+[\-\d\.]+/, "").strip
          adjustments[adjustment_counter] = adjustment
          adjustment_counter += 1
        end

        if line !~ /={10,}/i && checks_start == true && line !~ /^\s+$/ && line !~ /-{10,}/i
          check = Hash.new
          check[:check_number] = /^[^\s]+(?=\s)/.match(line)[0] if !/^[^\s]+(?=\s)/.match(line).nil?
          check[:amount] = (/^[^\s]+\s+\d+\.\d+(?=\s)/.match(line)[0].split(" ")[1].strip.to_f * 100).to_i if !/^[^\s]+\s+\d+\.\d+(?=\s)/.match(line).nil?
          check[:number_of_claims] = /^[^\s]+\s+\d+\.\d+\s+\d+(?=\s)/.match(line)[0].split(" ")[2].strip.to_i if !/^[^\s]+\s+\d+\.\d+\s+\d+(?=\s)/.match(line).nil?
          check[:npi_tax_id] = /^[^\s]+\s+\d+\.\d+\s+\d+\s+[^\s]+/.match(line)[0].split(" ")[3].strip if !/^[^\s]+\s+\d+\.\d+\s+\d+\s+[^\s]+/.match(line).nil?
          check[:date] = /\d+\/\d+\/\d+/.match(line)[0] if !/\d+\/\d+\/\d+/.match(line).nil?
          check[:payee] = line.gsub(check[:check_number].to_s, "").gsub(check[:npi_tax_id].to_s, "").gsub(check[:amount].to_s, "").gsub(/\d/, "").gsub(/\./, "").gsub(/\//, "").strip
          checks[check[:check_number]] = check
        end

        if next_line_line_item
          individual_line_item = Hash.new
          adjustment_groups = Hash.new
        end

        if line.include?("Line Item:") || line =~ /-{10,}/i || line =~ /^\s+$/
          next_line_adjustment_group = false
        end

        if next_line_adjustment_group &&
          individual_adjustment_group_item = Hash.new
          individual_adjustment_group_item[:adjustment_group] = /.+\s+\-?\d+\.\d+/.match(line)[0].strip.split(/\s+\-?\d+/)[0].strip if !/.+\s+\-?\d+\.\d+/.match(line).nil?
          individual_adjustment_group_item[:adjustment_amount] = (/\-?\d+\.\d+/.match(line)[0].strip.to_f * 100).to_i if !/\-?\d+\.\d+/.match(line).nil?
          individual_adjustment_group_item[:translated_reason_code] = /\-?\d+\.\d+\s+.+/.match(line)[0].strip.split(/(?:\d)\s/)[1].strip if !/\-?\d+\.\d+\s+.+/.match(line).nil?
          if adjustment_groups.nil?
            adjustment_groups[0] = individual_adjustment_group_item
          else
            adjustment_groups[adjustment_groups.count] = individual_adjustment_group_item
          end
          individual_line_item[:adjustment_groups] = adjustment_groups
        end

        if line.include?("Adjustment Group")
          next_line_adjustment_group = true
        end

        if next_line_line_item
          individual_line_item[:service_date] = /\d+\/\d+\/\d+/.match(line)[0].strip if !/\d+\/\d+\/\d+/.match(line).nil?
          individual_line_item[:cpt_code] = /\d+\/\d+\/\d+\s\d+/.match(line)[0].strip.split(" ")[1] if !/\d+\/\d+\/\d+\s\d+/.match(line).nil?
          individual_line_item[:charge_amount] = (/\d+\/\d+\/\d+\s\d+\s+\-?\d+\.\d+/.match(line)[0].strip.split(" ")[2].to_f * 100).to_i if !/\d+\/\d+\/\d+\s\d+\s+\-?\d+\.\d+/.match(line).nil?
          individual_line_item[:payment_amount] = (/\d+\/\d+\/\d+\s\d+\s+\-?\d+\.\d+\s+\-?\d+\.\d+/.match(line)[0].strip.split(" ")[3].to_f * 100).to_i if !/\d+\/\d+\/\d+\s\d+\s+\-?\d+\.\d+\s+\-?\d+\.\d+/.match(line).nil?
          individual_line_item[:total_adjustment_amount] = (/\d+\/\d+\/\d+\s\d+\s+\-?\d+\.\d+\s+\-?\d+\.\d+\s+\-?\d+\.\d+/.match(line)[0].strip.split(" ")[4].to_f * 100).to_i if !/\d+\/\d+\/\d+\s\d+\s+\-?\d+\.\d+\s+\-?\d+\.\d+\s+\-?\d+\.\d+/.match(line).nil?
          individual_line_item[:remarks] = line.gsub(/\d+\/\d+\/\d+\s\d+\s+\-?\d+\.\d+\s+\-?\d+\.\d+\s+\-?\d+\.\d+/, "").strip if !/\d+\/\d+\/\d+\s\d+\s+\-?\d+\.\d+\s+\-?\d+\.\d+\s+\-?\d+\.\d+/.match(line).nil?
          if line_items.nil?
            line_items[0] = individual_line_item
          else
            line_items[line_items.count] = individual_line_item
          end
          next_line_line_item = false
        end

        if line.include?("Line Item:")
          next_line_line_item = true
        end

        if next_line_claim_statement_period && line.include?("Claim Statement Period")
          individual_era[:claim_statement_period_start] = line.gsub("Claim Statement Period:", "").strip.split("-")[0].strip
          individual_era[:claim_statement_period_end] = line.gsub("Claim Statement Period:", "").strip.split("-")[1].strip
          next_line_claim_statement_period = false
        elsif next_line_claim_statement_period
          next_line_claim_statement_period = false
        end

        if next_line_payer_claim_control && line.include?("Payer Claim Control Number")
          individual_era[:payer_claim_control_number] = line.gsub("Payer Claim Control Number:", "").strip
          next_line_payer_claim_control = false
          next_line_claim_statement_period = true
        elsif next_line_payer_claim_control
          next_line_payer_claim_control = false
          next_line_claim_statement_period = true
        end

        if next_line_tax_id && line.include?("Tax ID")
          individual_era[:payer_tax_id] = line.gsub("Tax ID:", "").strip
          next_line_tax_id = false
          next_line_payer_claim_control = true
        elsif next_line_tax_id
          next_line_tax_id = false
          next_line_payer_claim_control = true
        end

        if next_line_city
          individual_era[:payer_city] = line.strip.split(",")[0].strip
          individual_era[:payer_state] = line.strip.split(",")[1].split(" ")[0].strip
          individual_era[:payer_zip_code] = line.strip.split(",")[1].split(" ")[1].strip
          next_line_city = false
          next_line_tax_id = true
        end

        if next_line_address
          individual_era[:payer_address] = line.strip
          next_line_address = false
          next_line_city = true
        end

        if next_line_check_number
          check_number = /^[^\s]+(?=\s)/.match(line)[0].strip if !/^[^\s]+(?=\s)/.match(line).nil?
          next_line_check_number = false
          individual_era[:patient_id] = /^[^\s]+(?=\s)\s+[^\s]+/.match(line)[0].strip.split(" ")[1] if !/^[^\s]+(?=\s)\s+[^\s]+/.match(line).nil?
          individual_era[:patient_name] = /\s\D*,\D*\s/.match(line)[0].strip if !/\s\D*,\D*\s/.match(line).nil?
          individual_era[:patient_last_name] = individual_era[:patient_name].split(",")[0].downcase.split(" ").map { |word| word.capitalize }.join(" ")
          individual_era[:patient_first_name] = individual_era[:patient_name].split(",")[1].downcase.split(" ").map { |word| word.capitalize }.join(" ")
          individual_era[:charge_amount] = (/,\D+\d+\.\d+\s/.match(line)[0].gsub(/[a-zA-Z,]/, "").strip.to_f * 100).to_i if !/,\D+\d+\.\d+\s/.match(line).nil?
          individual_era[:payment_amount] = (/\.\d+\s+\-?\d+\.\d+\s/.match(line)[0].strip.split(" ")[1].strip.to_f * 100).to_i if !/\.\d+\s+\-?\d+\.\d+\s/.match(line).nil?
          individual_era[:account_number] = /\.\d+\s+\-?\d+\.\d+\s+[A-Z\d]+\s/.match(line)[0].strip.split(" ")[2] if !/\.\d+\s+\-?\d+\.\d+\s+[A-Z\d]+\s/.match(line).nil?
          if !/PROCESSED AS PRIMARY\s+.+$/.match(line).nil? && !/^[^\s]+(?=\s)/.match(line).nil?
            individual_era[:status] = "PROCESSED AS PRIMARY"
            individual_era[:payer_name] = /PROCESSED AS PRIMARY\s+.+$/.match(line)[0].gsub("PROCESSED AS PRIMARY", "").strip
          elsif !/PROCESSED AS PRIMARY,\sFWDED\s+.+$/.match(line).nil? && !/^[^\s]+(?=\s)/.match(line).nil?
            individual_era[:status] = "PROCESSED AS PRIMARY, FWDED"
            individual_era[:payer_name] = /PROCESSED AS PRIMARY,\sFWDED\s+.+$/.match(line)[0].gsub("PROCESSED AS PRIMARY, FWDED", "").strip
          elsif !/PROCESSED AS SECONDARY\s+.+$/.match(line).nil? && !/^[^\s]+(?=\s)/.match(line).nil?
            individual_era[:status] = "PROCESSED AS SECONDARY"
            individual_era[:payer_name] = /PROCESSED AS SECONDARY\s+.+$/.match(line)[0].gsub("PROCESSED AS SECONDARY", "").strip
          elsif !/DENIED\s+.+$/.match(line).nil? && !/^[^\s]+(?=\s)/.match(line).nil?
            individual_era[:status] = "DENIED"
            individual_era[:payer_name] = /DENIED\s+.+$/.match(line)[0].gsub("DENIED", "").strip
          elsif !/OTHER\s+.+$/.match(line).nil? && !/^[^\s]+(?=\s)/.match(line).nil?
            individual_era[:status] = "OTHER"
            individual_era[:payer_name] = /OTHER\s+.+$/.match(line)[0].gsub("OTHER", "").strip
          end
          next_line_address = true
        end

        if line.include?("Check#") && line.include?("Patient ID")
          next_line_check_number = true
          individual_era = Hash.new
          line_items = Hash.new
        end

        if eras_start == true && !line.include?("Check#")
          if line =~ /-{10,}/i
            if era[:checks][check_number][:eras].nil?
              era_counter = 0
              eras = Hash.new
              individual_era[:line_items] = line_items
              individual_era[:era_text] = era_text.strip.gsub(/\r/, "")
              eras[era_counter] = individual_era
              era[:checks][check_number][:eras] = eras
            else
              era_counter = era[:checks][check_number][:eras].count
              eras = Hash.new
              individual_era[:line_items] = line_items
              individual_era[:era_text] = era_text.strip.gsub(/\r/, "")
              eras[era_counter] = individual_era
              era[:checks][check_number][:eras] = era[:checks][check_number][:eras].merge(eras)
            end
            era_text = "--------------------------------------------------------------------------------------------------------------------------------------------------------\n"
          end
        end

        if line.include?("Adjustment Date")
          adjustments_start = true
        end

        if line.include?("Check#") && line.include?("# Claims")
          checks_start = true
        end

        if line =~ /={10,}/i && adjustments_start == true && adjustments != {}
          adjustments_start = false
        end

        if line =~ /-{10,}/i && checks_start == true && checks != {}
          checks_start = false
          era[:adjustments] = adjustments
          era[:checks] = checks
          eras_start = true
        end
      end

      if era[:checks][check_number][:eras].nil?
        era_counter = 0
        eras = Hash.new
        individual_era[:line_items] = line_items
        individual_era[:era_text] = era_text.strip.gsub(/\r/, "")
        eras[era_counter] = individual_era
        era[:checks][check_number][:eras] = eras
      else
        era_counter = era[:checks][check_number][:eras].count
        eras = Hash.new
        individual_era[:line_items] = line_items
        individual_era[:era_text] = era_text.strip.gsub(/\r/, "")
        eras[era_counter] = individual_era
        era[:checks][check_number][:eras] = era[:checks][check_number][:eras].merge(eras)
      end
      return era
    end
  end
end