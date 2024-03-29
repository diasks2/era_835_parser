require 'spec_helper'

RSpec.describe Era835Parser::Parser do

  describe '#parse' do
    context 'Machine readable' do
      context 'example_1.835' do
        # https://www.bluecrossnc.com/sites/default/files/document/attachment/providers/public/pdfs/835_5010_v2.6%20Claim%20Payment%20Advice.pdf
        before :all do
          @era = Era835Parser::Parser.new(file_path: "../era_835_parser/spec/example_1.835").parse
        end

        context 'Aggregate totals' do
          it 'returns the addressed to' do
            expect(@era[:addressed_to]).to eq(nil)
          end
          it 'returns the correct number of checks' do
            expect(@era[:checks].count).to eq(1)
          end
          it 'returns the correct number of adjustments' do
            expect(@era[:adjustments]).to eq(nil)
          end
          it 'returns the correct number of eras' do
            expect(@era[:checks]['70408535'][:eras].count).to eq(1)
          end
          it 'returns the correct number of line items' do
            expect(@era[:checks]['70408535'][:eras][0][:line_items].count).to eq(1)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
          end
        end

        context 'Check #70408535' do
          it 'returns the check number' do
            expect(@era[:checks]['70408535'][:check_number]).to eq('70408535')
          end
          it 'returns the amount' do
            expect(@era[:checks]['70408535'][:amount]).to eq(1509646)
          end
          it 'returns the number of claims' do
            expect(@era[:checks]['70408535'][:number_of_claims]).to eq(1)
          end
          it 'returns the NPI or Tax ID of payee' do
            expect(@era[:checks]['70408535'][:npi_tax_id]).to eq('1234567890')
          end
          it 'returns the Check payee' do
            expect(@era[:checks]['70408535'][:payee]).to eq('ACME UNIV HLTH SYS INC')
          end
          it 'returns the Payer name' do
            expect(@era[:checks]['70408535'][:payer_name]).to eq('NC TEACHERS & STATE EMPLOYEES HEALTH PLAN & HEALTH CHOICE')
          end
          it 'returns the Payer address' do
            expect(@era[:checks]['70408535'][:payer_address]).to eq('P O BOX 30025')
          end
          it 'returns the Payer city' do
            expect(@era[:checks]['70408535'][:payer_city]).to eq('DURHAM')
          end
          it 'returns the Payer state' do
            expect(@era[:checks]['70408535'][:payer_state]).to eq('NC')
          end
          it 'returns the Payer zip code' do
            expect(@era[:checks]['70408535'][:payer_zip_code]).to eq('27702')
          end
          it 'returns the Payer tax id' do
            expect(@era[:checks]['70408535'][:payer_tax_id]).to eq('57-14001')
          end
          it 'returns the Payer EDI id' do
            expect(@era[:checks]['70408535'][:payer_edi_id]).to eq('11111')
          end
          it 'returns the Check date (string mm/dd/yyyy)' do
            expect(@era[:checks]['70408535'][:date]).to eq('09/23/2010')
          end
          context 'ERA #0' do
            it 'returns the Patient ID' do
              expect(@era[:checks]['70408535'][:eras][0][:patient_id]).to eq('RUN123456789')
            end
            it 'returns the Patient name' do
              expect(@era[:checks]['70408535'][:eras][0][:patient_name]).to eq('RABBIT,ROGER')
            end
            it 'returns the Patient last name (titlized)' do
              expect(@era[:checks]['70408535'][:eras][0][:patient_last_name]).to eq('Rabbit')
            end
            it 'returns the Patient first name (titlized)' do
              expect(@era[:checks]['70408535'][:eras][0][:patient_first_name]).to eq('Roger')
            end
            it 'returns the Total charge amount (integer)' do
              expect(@era[:checks]['70408535'][:eras][0][:charge_amount]).to eq(374060)
            end
            it 'returns the Total payment amount (integer)' do
              expect(@era[:checks]['70408535'][:eras][0][:payment_amount]).to eq(545104)
            end
            it 'returns the Account number' do
              expect(@era[:checks]['70408535'][:eras][0][:account_number]).to eq('474623UB001CW0321')
            end
            it 'returns the Cliam status code' do
              expect(@era[:checks]['70408535'][:eras][0][:claim_status_code]).to eq('1')
            end
            it 'returns the Claim status code description' do
              expect(@era[:checks]['70408535'][:eras][0][:status]).to eq("PROCESSED AS PRIMARY")
            end
            it 'returns the Payer claim control number' do
              expect(@era[:checks]['70408535'][:eras][0][:payer_claim_control_number]).to eq('80209000000')
            end
            it 'returns the Claim statement period start' do
              expect(@era[:checks]['70408535'][:eras][0][:claim_statement_period_start]).to eq("03/07/2010")
            end
            it 'returns the Claim statement period end' do
              expect(@era[:checks]['70408535'][:eras][0][:claim_statement_period_end]).to eq("03/10/2010")
            end

            context 'Line item #0' do
              it 'returns the Date of service (string mm/dd/yyyy)' do
                expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:service_date]).to eq("03/07/2010")
              end
              it 'returns the CPT code' do
                expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:cpt_code]).to eq(nil)
              end
              it 'returns the Charge amount (integer)' do
                expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:charge_amount]).to eq(nil)
              end
              it 'returns the Payment amount (integer)' do
                expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:payment_amount]).to eq(nil)
              end
              it 'returns the Total adjustment amount (integer)' do
                expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:total_adjustment_amount]).to eq(-171044)
              end
              it 'returns the Remark code' do
                expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:remark_code]).to eq(nil)
              end
              it 'returns the Remarks' do
                expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:remarks]).to eq(nil)
              end
              it 'returns the Reference number' do
                expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:reference_number]).to eq(nil)
              end
              context 'Adjustment group #0' do
                it 'returns the Adjustment group' do
                  expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_group]).to eq("Contractual Obligation")
                end
                it 'returns the Adjustment group code' do
                  expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_group_code]).to eq("CO")
                end
                it 'returns the Adjustment amount (integer)' do
                  expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_amount]).to eq(-171044)
                end
                it 'returns the Reason code' do
                  expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:adjustment_groups][0][:reason_code]).to eq('94')
                end
                it 'returns the Translated reason code' do
                  expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:adjustment_groups][0][:translated_reason_code]).to eq("Processed in Excess of charges.")
                end
              end
            end
          end
        end
      end

      context 'example_2.835' do
        before :all do
          @era = Era835Parser::Parser.new(file_path: "../era_835_parser/spec/example_2.835").parse
        end

        context 'Aggregate totals' do
          it 'returns the addressed to' do
            expect(@era[:addressed_to]).to eq(nil)
          end
          it 'returns the correct number of checks' do
            expect(@era[:checks].count).to eq(1)
          end
          it 'returns the correct number of adjustments' do
            expect(@era[:adjustments]).to eq(nil)
          end
          it 'returns the correct number of eras' do
            expect(@era[:checks]['02790758'][:eras].count).to eq(1)
          end
          it 'returns the correct number of line items' do
            expect(@era[:checks]['02790758'][:eras][0][:line_items].count).to eq(3)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(2)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:adjustment_groups].count).to eq(1)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:adjustment_groups]).to eq(nil)
          end
        end

        context 'Check #02790758' do
          it 'returns the check number' do
            expect(@era[:checks]['02790758'][:check_number]).to eq('02790758')
          end
          it 'returns the amount' do
            expect(@era[:checks]['02790758'][:amount]).to eq(192286)
          end
          it 'returns the number of claims' do
            expect(@era[:checks]['02790758'][:number_of_claims]).to eq(1)
          end
          it 'returns the NPI or Tax ID of payee' do
            expect(@era[:checks]['02790758'][:npi_tax_id]).to eq('0987654321')
          end
          it 'returns the Check payee' do
            expect(@era[:checks]['02790758'][:payee]).to eq('XYZ HEALTHCARE CORPORATION')
          end
          it 'returns the Payer name' do
            expect(@era[:checks]['02790758'][:payer_name]).to eq('BLUE CROSS AND BLUE SHIELD OF NORTH CAROLINA')
          end
          it 'returns the Payer address' do
            expect(@era[:checks]['02790758'][:payer_address]).to eq('P O BOX 2291')
          end
          it 'returns the Payer city' do
            expect(@era[:checks]['02790758'][:payer_city]).to eq('DURHAM')
          end
          it 'returns the Payer state' do
            expect(@era[:checks]['02790758'][:payer_state]).to eq('NC')
          end
          it 'returns the Payer zip code' do
            expect(@era[:checks]['02790758'][:payer_zip_code]).to eq('27702')
          end
          it 'returns the Payer tax id' do
            expect(@era[:checks]['02790758'][:payer_tax_id]).to eq('60-894904')
          end
          it 'returns the Payer EDI id' do
            expect(@era[:checks]['02790758'][:payer_edi_id]).to eq('22222')
          end
          it 'returns the Check date (string mm/dd/yyyy)' do
            expect(@era[:checks]['02790758'][:date]).to eq('01/08/2011')
          end
          context 'ERA #0' do
            it 'returns the Patient ID' do
              expect(@era[:checks]['02790758'][:eras][0][:patient_id]).to eq('YPB123456789001')
            end
            it 'returns the Patient name' do
              expect(@era[:checks]['02790758'][:eras][0][:patient_name]).to eq('DOUGH,MARY')
            end
            it 'returns the Patient last name (titlized)' do
              expect(@era[:checks]['02790758'][:eras][0][:patient_last_name]).to eq('Dough')
            end
            it 'returns the Patient first name (titlized)' do
              expect(@era[:checks]['02790758'][:eras][0][:patient_first_name]).to eq('Mary')
            end
            it 'returns the Total charge amount (integer)' do
              expect(@era[:checks]['02790758'][:eras][0][:charge_amount]).to eq(210000)
            end
            it 'returns the Total payment amount (integer)' do
              expect(@era[:checks]['02790758'][:eras][0][:payment_amount]).to eq(192286)
            end
            it 'returns the Account number' do
              expect(@era[:checks]['02790758'][:eras][0][:account_number]).to eq('200200964A52')
            end
            it 'returns the Cliam status code' do
              expect(@era[:checks]['02790758'][:eras][0][:claim_status_code]).to eq('1')
            end
            it 'returns the Claim status code description' do
              expect(@era[:checks]['02790758'][:eras][0][:status]).to eq("PROCESSED AS PRIMARY")
            end
            it 'returns the Payer claim control number' do
              expect(@era[:checks]['02790758'][:eras][0][:payer_claim_control_number]).to eq('94151100100')
            end
            it 'returns the Claim statement period start' do
              expect(@era[:checks]['02790758'][:eras][0][:claim_statement_period_start]).to eq(nil)
            end
            it 'returns the Claim statement period end' do
              expect(@era[:checks]['02790758'][:eras][0][:claim_statement_period_end]).to eq(nil)
            end

            context 'Line item #0' do
              it 'returns the Date of service (string mm/dd/yyyy)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:service_date]).to eq("12/31/2010")
              end
              it 'returns the CPT code' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:cpt_code]).to eq("59430")
              end
              it 'returns the Charge amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:charge_amount]).to eq(121000)
              end
              it 'returns the Payment amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:payment_amount]).to eq(105786)
              end
              it 'returns the Total adjustment amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:total_adjustment_amount]).to eq(15214)
              end
              it 'returns the Remark code' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:remark_code]).to eq(nil)
              end
              it 'returns the Remarks' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:remarks]).to eq(nil)
              end
              it 'returns the Reference number' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:reference_number]).to eq('0001')
              end
              context 'Adjustment group #0' do
                it 'returns the Adjustment group' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_group]).to eq("Contractual Obligation")
                end
                it 'returns the Adjustment group code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_group_code]).to eq("CO")
                end
                it 'returns the Adjustment amount (integer)' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_amount]).to eq(3460)
                end
                it 'returns the Reason code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][0][:reason_code]).to eq('42')
                end
                it 'returns the Translated reason code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][0][:translated_reason_code]).to eq("Charges exceed our fee schedule or maximum allowable amount. (Use CARC 45)")
                end
              end
              context 'Adjustment group #1' do
                it 'returns the Adjustment group' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][1][:adjustment_group]).to eq("Patient Responsibility")
                end
                it 'returns the Adjustment group code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][1][:adjustment_group_code]).to eq("PR")
                end
                it 'returns the Adjustment amount (integer)' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][1][:adjustment_amount]).to eq(11754)
                end
                it 'returns the Reason code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][1][:reason_code]).to eq('2')
                end
                it 'returns the Translated reason code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][1][:translated_reason_code]).to eq("Coinsurance Amount")
                end
              end
            end
            context 'Line item #1' do
              it 'returns the Date of service (string mm/dd/yyyy)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:service_date]).to eq("12/31/2010")
              end
              it 'returns the CPT code' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:cpt_code]).to eq("59440")
              end
              it 'returns the Charge amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:charge_amount]).to eq(89000)
              end
              it 'returns the Payment amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:payment_amount]).to eq(86500)
              end
              it 'returns the Total adjustment amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:total_adjustment_amount]).to eq(2500)
              end
              it 'returns the Remark code' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:remark_code]).to eq(nil)
              end
              it 'returns the Remarks' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:remarks]).to eq(nil)
              end
              it 'returns the Reference number' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:reference_number]).to eq('0002')
              end
              context 'Adjustment group #0' do
                it 'returns the Adjustment group' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:adjustment_groups][0][:adjustment_group]).to eq("Patient Responsibility")
                end
                it 'returns the Adjustment group code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:adjustment_groups][0][:adjustment_group_code]).to eq("PR")
                end
                it 'returns the Adjustment amount (integer)' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:adjustment_groups][0][:adjustment_amount]).to eq(2500)
                end
                it 'returns the Reason code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:adjustment_groups][0][:reason_code]).to eq('3')
                end
                it 'returns the Translated reason code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:adjustment_groups][0][:translated_reason_code]).to eq("Co-payment Amount")
                end
              end
            end
            context 'Line item #2' do
              it 'returns the Date of service (string mm/dd/yyyy)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:service_date]).to eq("12/31/2010")
              end
              it 'returns the CPT code' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:cpt_code]).to eq("59426")
              end
              it 'returns the Charge amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:charge_amount]).to eq(74200)
              end
              it 'returns the Payment amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:payment_amount]).to eq(74200)
              end
              it 'returns the Total adjustment amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:total_adjustment_amount]).to eq(nil)
              end
              it 'returns the Remark code' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:remark_code]).to eq(nil)
              end
              it 'returns the Remarks' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:remarks]).to eq(nil)
              end
              it 'returns the Reference number' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:reference_number]).to eq('0003')
              end
            end
          end
        end
      end

      context 'example_3.835' do
        before :all do
          @era = Era835Parser::Parser.new(file_path: "../era_835_parser/spec/example_3.835").parse
        end

        context 'Aggregate totals' do
          it 'returns the addressed to' do
            expect(@era[:addressed_to]).to eq(nil)
          end
          it 'returns the correct number of checks' do
            expect(@era[:checks].count).to eq(1)
          end
          it 'returns the correct number of adjustments' do
            expect(@era[:adjustments]).to eq(nil)
          end
          it 'returns the correct number of eras' do
            expect(@era[:checks]['02790758'][:eras].count).to eq(1)
          end
          it 'returns the correct number of line items' do
            expect(@era[:checks]['02790758'][:eras][0][:line_items].count).to eq(3)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(2)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:adjustment_groups].count).to eq(1)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:adjustment_groups]).to eq(nil)
          end
        end

        context 'Check #02790758' do
          it 'returns the check number' do
            expect(@era[:checks]['02790758'][:check_number]).to eq('02790758')
          end
          it 'returns the amount' do
            expect(@era[:checks]['02790758'][:amount]).to eq(192286)
          end
          it 'returns the number of claims' do
            expect(@era[:checks]['02790758'][:number_of_claims]).to eq(1)
          end
          it 'returns the NPI or Tax ID of payee' do
            expect(@era[:checks]['02790758'][:npi_tax_id]).to eq('0987654321')
          end
          it 'returns the Check payee' do
            expect(@era[:checks]['02790758'][:payee]).to eq('XYZ HEALTHCARE CORPORATION')
          end
          it 'returns the Payer name' do
            expect(@era[:checks]['02790758'][:payer_name]).to eq('BLUE CROSS AND BLUE SHIELD OF NORTH CAROLINA')
          end
          it 'returns the Payer address' do
            expect(@era[:checks]['02790758'][:payer_address]).to eq('P O BOX 2291')
          end
          it 'returns the Payer city' do
            expect(@era[:checks]['02790758'][:payer_city]).to eq('DURHAM')
          end
          it 'returns the Payer state' do
            expect(@era[:checks]['02790758'][:payer_state]).to eq('NC')
          end
          it 'returns the Payer zip code' do
            expect(@era[:checks]['02790758'][:payer_zip_code]).to eq('27702')
          end
          it 'returns the Payer tax id' do
            expect(@era[:checks]['02790758'][:payer_tax_id]).to eq('60-894904')
          end
          it 'returns the Payer EDI id' do
            expect(@era[:checks]['02790758'][:payer_edi_id]).to eq('33333')
          end
          it 'returns the Check date (string mm/dd/yyyy)' do
            expect(@era[:checks]['02790758'][:date]).to eq('01/08/2011')
          end
          context 'ERA #0' do
            it 'returns the Patient ID' do
              expect(@era[:checks]['02790758'][:eras][0][:patient_id]).to eq('YPB123456789001')
            end
            it 'returns the Patient name' do
              expect(@era[:checks]['02790758'][:eras][0][:patient_name]).to eq('DOUGH,MARY')
            end
            it 'returns the Patient last name (titlized)' do
              expect(@era[:checks]['02790758'][:eras][0][:patient_last_name]).to eq('Dough')
            end
            it 'returns the Patient first name (titlized)' do
              expect(@era[:checks]['02790758'][:eras][0][:patient_first_name]).to eq('Mary')
            end
            it 'returns the Total charge amount (integer)' do
              expect(@era[:checks]['02790758'][:eras][0][:charge_amount]).to eq(210000)
            end
            it 'returns the Total payment amount (integer)' do
              expect(@era[:checks]['02790758'][:eras][0][:payment_amount]).to eq(192286)
            end
            it 'returns the Account number' do
              expect(@era[:checks]['02790758'][:eras][0][:account_number]).to eq('200200964A52')
            end
            it 'returns the Cliam status code' do
              expect(@era[:checks]['02790758'][:eras][0][:claim_status_code]).to eq('1')
            end
            it 'returns the Claim status code description' do
              expect(@era[:checks]['02790758'][:eras][0][:status]).to eq("PROCESSED AS PRIMARY")
            end
            it 'returns the Payer claim control number' do
              expect(@era[:checks]['02790758'][:eras][0][:payer_claim_control_number]).to eq('94151100100')
            end
            it 'returns the Claim statement period start' do
              expect(@era[:checks]['02790758'][:eras][0][:claim_statement_period_start]).to eq(nil)
            end
            it 'returns the Claim statement period end' do
              expect(@era[:checks]['02790758'][:eras][0][:claim_statement_period_end]).to eq(nil)
            end

            context 'Line item #0' do
              it 'returns the Date of service (string mm/dd/yyyy)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:service_date]).to eq("12/31/2010")
              end
              it 'returns the CPT code' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:cpt_code]).to eq("59430")
              end
              it 'returns the Charge amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:charge_amount]).to eq(121000)
              end
              it 'returns the Payment amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:payment_amount]).to eq(105786)
              end
              it 'returns the Total adjustment amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:total_adjustment_amount]).to eq(15214)
              end
              it 'returns the Remark code' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:remark_code]).to eq(nil)
              end
              it 'returns the Remarks' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:remarks]).to eq(nil)
              end
              it 'returns the Reference number' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:reference_number]).to eq('0001')
              end
              context 'Adjustment group #0' do
                it 'returns the Adjustment group' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_group]).to eq("Contractual Obligation")
                end
                it 'returns the Adjustment group code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_group_code]).to eq("CO")
                end
                it 'returns the Adjustment amount (integer)' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_amount]).to eq(3460)
                end
                it 'returns the Reason code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][0][:reason_code]).to eq('42')
                end
                it 'returns the Translated reason code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][0][:translated_reason_code]).to eq("Charges exceed our fee schedule or maximum allowable amount. (Use CARC 45)")
                end
              end
              context 'Adjustment group #1' do
                it 'returns the Adjustment group' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][1][:adjustment_group]).to eq("Patient Responsibility")
                end
                it 'returns the Adjustment group code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][1][:adjustment_group_code]).to eq("PR")
                end
                it 'returns the Adjustment amount (integer)' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][1][:adjustment_amount]).to eq(11754)
                end
                it 'returns the Reason code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][1][:reason_code]).to eq('2')
                end
                it 'returns the Translated reason code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][0][:adjustment_groups][1][:translated_reason_code]).to eq("Coinsurance Amount")
                end
              end
            end
            context 'Line item #1' do
              it 'returns the Date of service (string mm/dd/yyyy)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:service_date]).to eq("12/31/2010")
              end
              it 'returns the CPT code' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:cpt_code]).to eq("59440")
              end
              it 'returns the Charge amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:charge_amount]).to eq(89000)
              end
              it 'returns the Payment amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:payment_amount]).to eq(86500)
              end
              it 'returns the Total adjustment amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:total_adjustment_amount]).to eq(2500)
              end
              it 'returns the Remark code' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:remark_code]).to eq(nil)
              end
              it 'returns the Remarks' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:remarks]).to eq(nil)
              end
              it 'returns the Reference number' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:reference_number]).to eq('0002')
              end
              context 'Adjustment group #0' do
                it 'returns the Adjustment group' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:adjustment_groups][0][:adjustment_group]).to eq("Patient Responsibility")
                end
                it 'returns the Adjustment group code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:adjustment_groups][0][:adjustment_group_code]).to eq("PR")
                end
                it 'returns the Adjustment amount (integer)' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:adjustment_groups][0][:adjustment_amount]).to eq(2500)
                end
                it 'returns the Reason code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:adjustment_groups][0][:reason_code]).to eq('3')
                end
                it 'returns the Translated reason code' do
                  expect(@era[:checks]['02790758'][:eras][0][:line_items][1][:adjustment_groups][0][:translated_reason_code]).to eq("Co-payment Amount")
                end
              end
            end
            context 'Line item #2' do
              it 'returns the Date of service (string mm/dd/yyyy)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:service_date]).to eq("12/31/2010")
              end
              it 'returns the CPT code' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:cpt_code]).to eq("59426")
              end
              it 'returns the Charge amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:charge_amount]).to eq(74200)
              end
              it 'returns the Payment amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:payment_amount]).to eq(74200)
              end
              it 'returns the Total adjustment amount (integer)' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:total_adjustment_amount]).to eq(nil)
              end
              it 'returns the Remark code' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:remark_code]).to eq(nil)
              end
              it 'returns the Remarks' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:remarks]).to eq(nil)
              end
              it 'returns the Reference number' do
                expect(@era[:checks]['02790758'][:eras][0][:line_items][2][:reference_number]).to eq('0003')
              end
            end
          end
        end
      end

      context 'example_4.835' do
        before :all do
          @era = Era835Parser::Parser.new(file_path: "../era_835_parser/spec/example_4.835").parse
        end

        context 'Aggregate totals' do
          it 'returns the addressed to' do
            expect(@era[:addressed_to]).to eq(nil)
          end
          it 'returns the correct number of checks' do
            expect(@era[:checks].count).to eq(1)
          end
          it 'returns the correct number of adjustments' do
            expect(@era[:adjustments]).to eq(nil)
          end
          it 'returns the correct number of eras' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras].count).to eq(1)
          end
          it 'returns the correct number of line items' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items].count).to eq(3)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(2)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:adjustment_groups].count).to eq(1)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][2][:adjustment_groups]).to eq(nil)
          end
        end

        context 'Check #70408535' do
          it 'returns the check number' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:check_number]).to eq('0123456789012345678901234567890123456789')
          end
          it 'returns the amount' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:amount]).to eq(192286)
          end
          it 'returns the number of claims' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:number_of_claims]).to eq(1)
          end
          it 'returns the NPI or Tax ID of payee' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:npi_tax_id]).to eq('0987654321')
          end
          it 'returns the Check payee' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:payee]).to eq('XYZ HEALTHCARE CORPORATION')
          end
          it 'returns the Payer name' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:payer_name]).to eq('BLUE CROSS AND BLUE SHIELD OF NORTH CAROLINA')
          end
          it 'returns the Payer address' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:payer_address]).to eq('P O BOX 2291')
          end
          it 'returns the Payer city' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:payer_city]).to eq('DURHAM')
          end
          it 'returns the Payer state' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:payer_state]).to eq('NC')
          end
          it 'returns the Payer zip code' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:payer_zip_code]).to eq('27702')
          end
          it 'returns the Payer tax id' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:payer_tax_id]).to eq('60-894904')
          end
          it 'returns the Payer EDI id' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:payer_edi_id]).to eq(nil)
          end
          it 'returns the Check date (string mm/dd/yyyy)' do
            expect(@era[:checks]['0123456789012345678901234567890123456789'][:date]).to eq('01/08/2011')
          end
          context 'ERA #0' do
            it 'returns the Patient ID' do
              expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:patient_id]).to eq('YPB123456789001')
            end
            it 'returns the Patient name' do
              expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:patient_name]).to eq('DOUGH,MARY')
            end
            it 'returns the Patient last name (titlized)' do
              expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:patient_last_name]).to eq('Dough')
            end
            it 'returns the Patient first name (titlized)' do
              expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:patient_first_name]).to eq('Mary')
            end
            it 'returns the Total charge amount (integer)' do
              expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:charge_amount]).to eq(210000)
            end
            it 'returns the Total payment amount (integer)' do
              expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:payment_amount]).to eq(192286)
            end
            it 'returns the Account number' do
              expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:account_number]).to eq('200200964A52')
            end
            it 'returns the Cliam status code' do
              expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:claim_status_code]).to eq('1')
            end
            it 'returns the Claim status code description' do
              expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:status]).to eq("PROCESSED AS PRIMARY")
            end
            it 'returns the Payer claim control number' do
              expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:payer_claim_control_number]).to eq('94151100100')
            end
            it 'returns the Claim statement period start' do
              expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:claim_statement_period_start]).to eq(nil)
            end
            it 'returns the Claim statement period end' do
              expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:claim_statement_period_end]).to eq(nil)
            end

            context 'Line item #0' do
              it 'returns the Date of service (string mm/dd/yyyy)' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:service_date]).to eq("12/31/2010")
              end
              it 'returns the CPT code' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:cpt_code]).to eq("59430")
              end
              it 'returns the Charge amount (integer)' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:charge_amount]).to eq(121000)
              end
              it 'returns the Payment amount (integer)' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:payment_amount]).to eq(105786)
              end
              it 'returns the Total adjustment amount (integer)' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:total_adjustment_amount]).to eq(15214)
              end
              it 'returns the Remark code' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:remark_code]).to eq(nil)
              end
              it 'returns the Remarks' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:remarks]).to eq(nil)
              end
              it 'returns the Reference number' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:reference_number]).to eq('0001')
              end
              context 'Adjustment group #0' do
                it 'returns the Adjustment group' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_group]).to eq("Contractual Obligation")
                end
                it 'returns the Adjustment group code' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_group_code]).to eq("CO")
                end
                it 'returns the Adjustment amount (integer)' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_amount]).to eq(3460)
                end
                it 'returns the Reason code' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:adjustment_groups][0][:reason_code]).to eq('42')
                end
                it 'returns the Translated reason code' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:adjustment_groups][0][:translated_reason_code]).to eq("Charges exceed our fee schedule or maximum allowable amount. (Use CARC 45)")
                end
              end
              context 'Adjustment group #1' do
                it 'returns the Adjustment group' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:adjustment_groups][1][:adjustment_group]).to eq("Patient Responsibility")
                end
                it 'returns the Adjustment group code' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:adjustment_groups][1][:adjustment_group_code]).to eq("PR")
                end
                it 'returns the Adjustment amount (integer)' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:adjustment_groups][1][:adjustment_amount]).to eq(11754)
                end
                it 'returns the Reason code' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:adjustment_groups][1][:reason_code]).to eq('2')
                end
                it 'returns the Translated reason code' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][0][:adjustment_groups][1][:translated_reason_code]).to eq("Coinsurance Amount")
                end
              end
            end
            context 'Line item #1' do
              it 'returns the Date of service (string mm/dd/yyyy)' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:service_date]).to eq("12/31/2010")
              end
              it 'returns the CPT code' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:cpt_code]).to eq("59440")
              end
              it 'returns the Charge amount (integer)' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:charge_amount]).to eq(89000)
              end
              it 'returns the Payment amount (integer)' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:payment_amount]).to eq(86500)
              end
              it 'returns the Total adjustment amount (integer)' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:total_adjustment_amount]).to eq(2500)
              end
              it 'returns the Remark code' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:remark_code]).to eq(nil)
              end
              it 'returns the Remarks' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:remarks]).to eq(nil)
              end
              it 'returns the Reference number' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:reference_number]).to eq('0002')
              end
              context 'Adjustment group #0' do
                it 'returns the Adjustment group' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:adjustment_groups][0][:adjustment_group]).to eq("Patient Responsibility")
                end
                it 'returns the Adjustment group code' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:adjustment_groups][0][:adjustment_group_code]).to eq("PR")
                end
                it 'returns the Adjustment amount (integer)' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:adjustment_groups][0][:adjustment_amount]).to eq(2500)
                end
                it 'returns the Reason code' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:adjustment_groups][0][:reason_code]).to eq('3')
                end
                it 'returns the Translated reason code' do
                  expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][1][:adjustment_groups][0][:translated_reason_code]).to eq("Co-payment Amount")
                end
              end
            end
            context 'Line item #2' do
              it 'returns the Date of service (string mm/dd/yyyy)' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][2][:service_date]).to eq("12/31/2010")
              end
              it 'returns the CPT code' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][2][:cpt_code]).to eq("59426")
              end
              it 'returns the Charge amount (integer)' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][2][:charge_amount]).to eq(74200)
              end
              it 'returns the Payment amount (integer)' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][2][:payment_amount]).to eq(74200)
              end
              it 'returns the Total adjustment amount (integer)' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][2][:total_adjustment_amount]).to eq(nil)
              end
              it 'returns the Remark code' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][2][:remark_code]).to eq(nil)
              end
              it 'returns the Remarks' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][2][:remarks]).to eq(nil)
              end
              it 'returns the Reference number' do
                expect(@era[:checks]['0123456789012345678901234567890123456789'][:eras][0][:line_items][2][:reference_number]).to eq('0003')
              end
            end
          end
        end
      end
    end

    context 'Human readable' do
      before :all do
        @era = Era835Parser::Parser.new(file_path: "../era_835_parser/spec/test_era.txt").parse
      end

      context 'Aggregate totals' do
        it 'returns the addressed to' do
          expect(@era[:addressed_to]).to eq('Jane Doe')
        end
        it 'returns the correct number of checks' do
          expect(@era[:checks].count).to eq(3)
        end
        it 'returns the correct number of adjustments' do
          expect(@era[:adjustments].count).to eq(3)
        end

        it 'returns the correct number of line items' do
          expect(@era[:checks]['201812215555555555'][:eras][0][:line_items].count).to eq(1)
        end
        it 'returns the correct number of line items' do
          expect(@era[:checks]['201812215555555556'][:eras][0][:line_items].count).to eq(2)
        end
        it 'returns the correct number of line items' do
          expect(@era[:checks]['201812215555555556'][:eras][1][:line_items].count).to eq(1)
        end
        it 'returns the correct number of line items' do
          expect(@era[:checks]['201812215555555557'][:eras][0][:line_items].count).to eq(1)
        end
        it 'returns the correct number of line items' do
          expect(@era[:checks]['201812215555555557'][:eras][1][:line_items].count).to eq(1)
        end

        it 'returns the correct number of adjustment groups' do
          expect(@era[:checks]['201812215555555555'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
        end
        it 'returns the correct number of adjustment groups' do
          expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
        end
        it 'returns the correct number of adjustment groups' do
          expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][1][:adjustment_groups].count).to eq(1)
        end
        it 'returns the correct number of adjustment groups' do
          expect(@era[:checks]['201812215555555556'][:eras][1][:line_items][0][:adjustment_groups]).to eq(nil)
        end
        it 'returns the correct number of adjustment groups' do
          expect(@era[:checks]['201812215555555557'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
        end
        it 'returns the correct number of adjustment groups' do
          expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:adjustment_groups].count).to eq(2)
        end
      end

      context 'Check #201812215555555555' do
        it 'returns the check number' do
          expect(@era[:checks]['201812215555555555'][:check_number]).to eq('201812215555555555')
        end
        it 'returns the amount' do
          expect(@era[:checks]['201812215555555555'][:amount]).to eq(4880)
        end
        it 'returns the number of claims' do
          expect(@era[:checks]['201812215555555555'][:number_of_claims]).to eq(1)
        end
        it 'returns the NPI or Tax ID' do
          expect(@era[:checks]['201812215555555555'][:npi_tax_id]).to eq('1212121212')
        end
        it 'returns the payee' do
          expect(@era[:checks]['201812215555555555'][:payee]).to eq('ABC COMPANY LLC')
        end
        it 'returns the Payer name' do
          expect(@era[:checks]['201812215555555555'][:payer_name]).to eq('ABC HEALTHCARE EAST')
        end
        it 'returns the Payer address' do
          expect(@era[:checks]['201812215555555555'][:payer_address]).to eq('SERVICE CENTER PO BOX 12234')
        end
        it 'returns the Payer city' do
          expect(@era[:checks]['201812215555555555'][:payer_city]).to eq('SOMEWHERE')
        end
        it 'returns the Payer state' do
          expect(@era[:checks]['201812215555555555'][:payer_state]).to eq('GA')
        end
        it 'returns the Payer zip code' do
          expect(@era[:checks]['201812215555555555'][:payer_zip_code]).to eq('11111')
        end
        it 'returns the Payer tax id' do
          expect(@era[:checks]['201812215555555555'][:payer_tax_id]).to eq('11-1111110')
        end
        it 'returns the date' do
          expect(@era[:checks]['201812215555555555'][:date]).to eq('12/21/2018')
        end

        context 'ERA #0' do
          it 'returns the ERA text' do
            text = <<-EOF
--------------------------------------------------------------------------------------------------------------------------------------------------------
Check#                         Patient ID         Last,First          Charge Amt  Payment Amt  Accnt#        Status                         Payer
201812215555555555             M11111110          DOE JR,DAVIS        65.00       48.80        1112          PROCESSED AS PRIMARY           ABC HEALTHCARE EAST
                                                                                                                                            SERVICE CENTER
                                                                                                                                            PO BOX 12234
                                                                                                                                            SOMEWHERE,GA 11111
                                                                                                                                            Tax ID: 11-1111110
                                                                                                Payer Claim Control Number: 111111111000

          Line Item:  Svc Date   CPT    Charge Amt   Payment Amt  Total Adj Amt  Remarks
                      10/25/2018 92507  65.00        48.80        16.20          NO REMARKS

                                Adjustment Group            Adj Amt Translated Reason Code
                                CONTRACTUAL OBLIGATIONS     16.20   CHARGES EXCEED YOUR CONTRACTED/LEGISLATED FEE ARRANGEMENT.
            EOF
            expect(@era[:checks]['201812215555555555'][:eras][0][:era_text]).to eq(text.strip)
          end
          it 'returns the Patient ID' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:patient_id]).to eq('M11111110')
          end
          it 'returns the Patient name' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:patient_name]).to eq('DOE JR,DAVIS')
          end
          it 'returns the Patient last name (titlized)' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:patient_last_name]).to eq('Doe Jr')
          end
          it 'returns the Patient first name (titlized)' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:patient_first_name]).to eq('Davis')
          end
          it 'returns the Total charge amount (integer)' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:charge_amount]).to eq(6500)
          end
          it 'returns the Total payment amount (integer)' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:payment_amount]).to eq(4880)
          end
          it 'returns the Account number' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:account_number]).to eq('1112')
          end
          it 'returns the Status' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:status]).to eq('PROCESSED AS PRIMARY')
          end
          it 'returns the Payer claim control number' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:payer_claim_control_number]).to eq('111111111000')
          end
          it 'returns the Claim statement period start' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:claim_statement_period_start]).to eq(nil)
          end
          it 'returns the Claim statement period end' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:claim_statement_period_end]).to eq(nil)
          end

          context 'Line item #0' do
            it 'returns the Date of service (string mm/dd/yyyy)' do
              expect(@era[:checks]['201812215555555555'][:eras][0][:line_items][0][:service_date]).to eq('10/25/2018')
            end
            it 'returns the CPT code' do
              expect(@era[:checks]['201812215555555555'][:eras][0][:line_items][0][:cpt_code]).to eq('92507')
            end
            it 'returns the Charge amount (integer)' do
              expect(@era[:checks]['201812215555555555'][:eras][0][:line_items][0][:charge_amount]).to eq(6500)
            end
            it 'returns the Payment amount (integer)' do
              expect(@era[:checks]['201812215555555555'][:eras][0][:line_items][0][:payment_amount]).to eq(4880)
            end
            it 'returns the Total adjustment amount (integer)' do
              expect(@era[:checks]['201812215555555555'][:eras][0][:line_items][0][:total_adjustment_amount]).to eq(1620)
            end
            it 'returns the Remarks' do
              expect(@era[:checks]['201812215555555555'][:eras][0][:line_items][0][:remarks]).to eq('NO REMARKS')
            end
            context 'Adjustment group #0' do
              it 'returns the Adjustment group' do
                expect(@era[:checks]['201812215555555555'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_group]).to eq('CONTRACTUAL OBLIGATIONS')
              end
              it 'returns the Adjustment amount (integer)' do
                expect(@era[:checks]['201812215555555555'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_amount]).to eq(1620)
              end
              it 'returns the Translated reason code' do
                expect(@era[:checks]['201812215555555555'][:eras][0][:line_items][0][:adjustment_groups][0][:translated_reason_code]).to eq('CHARGES EXCEED YOUR CONTRACTED/LEGISLATED FEE ARRANGEMENT.')
              end
            end
          end
        end
      end

      context 'Check #201812215555555556' do
        it 'returns the check number' do
          expect(@era[:checks]['201812215555555556'][:check_number]).to eq('201812215555555556')
        end
        it 'returns the amount' do
          expect(@era[:checks]['201812215555555556'][:amount]).to eq(5120)
        end
        it 'returns the number of claims' do
          expect(@era[:checks]['201812215555555556'][:number_of_claims]).to eq(2)
        end
        it 'returns the NPI or Tax ID' do
          expect(@era[:checks]['201812215555555556'][:npi_tax_id]).to eq('1212121213')
        end
        it 'returns the payee' do
          expect(@era[:checks]['201812215555555556'][:payee]).to eq('ABC COMPANY')
        end
        it 'returns the Payer name' do
          expect(@era[:checks]['201812215555555556'][:payer_name]).to eq('ABC HEALTHCARE WEST')
        end
        it 'returns the Payer address' do
          expect(@era[:checks]['201812215555555556'][:payer_address]).to eq('50 EAST RD')
        end
        it 'returns the Payer city' do
          expect(@era[:checks]['201812215555555556'][:payer_city]).to eq('ANYWHERE')
        end
        it 'returns the Payer state' do
          expect(@era[:checks]['201812215555555556'][:payer_state]).to eq('TN')
        end
        it 'returns the Payer zip code' do
          expect(@era[:checks]['201812215555555556'][:payer_zip_code]).to eq('00002-1111')
        end
        it 'returns the Payer tax id' do
          expect(@era[:checks]['201812215555555556'][:payer_tax_id]).to eq('11-1111111')
        end
        it 'returns the date' do
          expect(@era[:checks]['201812215555555556'][:date]).to eq('12/22/2018')
        end

        context 'ERA #0' do
          it 'returns the ERA text' do
            text = <<-EOF
--------------------------------------------------------------------------------------------------------------------------------------------------------
Check#                         Patient ID         Last,First          Charge Amt  Payment Amt  Accnt#        Status                         Payer
201812215555555556             ZECM11111111       DOE,JANE            -65.00      -48.80       L111          OTHER                          ABC HEALTHCARE WEST
                                                                                                                                            50 EAST RD
                                                                                                                                            ANYWHERE,TN 00002-1111
                                                                                                                                            Tax ID: 11-1111111
                                                                                                Payer Claim Control Number: BTBBB1111100

          Line Item:  Svc Date   CPT    Charge Amt   Payment Amt  Total Adj Amt  Remarks
                      10/27/2017 92507  -65.00       -48.80       -16.20         NO REMARKS

                                Adjustment Group            Adj Amt Translated Reason Code
                                OTHER ADJUSTMENTS           -16.20  CHARGES EXCEED YOUR CONTRACTED/LEGISLATED FEE ARRANGEMENT.

          Line Item:  Svc Date   CPT    Charge Amt   Payment Amt  Total Adj Amt  Remarks
                      11/09/2017 92507  -5.00        0.00         -5.00          NO REMARKS

                                Adjustment Group            Adj Amt Translated Reason Code
                                OTHER ADJUSTMENTS           -5.00   PAYMENT ADJUSTED BECAUSE CHARGES HAVE BEEN PAID BY ANOTHER PAYER.
            EOF
            expect(@era[:checks]['201812215555555556'][:eras][0][:era_text]).to eq(text.strip)
          end
          it 'returns the Patient ID' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:patient_id]).to eq('ZECM11111111')
          end
          it 'returns the Patient name' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:patient_name]).to eq('DOE,JANE')
          end
          it 'returns the Patient last name (titlized)' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:patient_last_name]).to eq('Doe')
          end
          it 'returns the Patient first name (titlized)' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:patient_first_name]).to eq('Jane')
          end
          it 'returns the Total charge amount (integer)' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:charge_amount]).to eq(-6500)
          end
          it 'returns the Total payment amount (integer)' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:payment_amount]).to eq(-4880)
          end
          it 'returns the Account number' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:account_number]).to eq('L111')
          end
          it 'returns the Status' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:status]).to eq('OTHER')
          end
          it 'returns the Payer claim control number' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:payer_claim_control_number]).to eq('BTBBB1111100')
          end
          it 'returns the Claim statement period start' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:claim_statement_period_start]).to eq(nil)
          end
          it 'returns the Claim statement period end' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:claim_statement_period_end]).to eq(nil)
          end

          context 'Line item #0' do
            it 'returns the Date of service (string mm/dd/yyyy)' do
              expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][0][:service_date]).to eq('10/27/2017')
            end
            it 'returns the CPT code' do
              expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][0][:cpt_code]).to eq('92507')
            end
            it 'returns the Charge amount (integer)' do
              expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][0][:charge_amount]).to eq(-6500)
            end
            it 'returns the Payment amount (integer)' do
              expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][0][:payment_amount]).to eq(-4880)
            end
            it 'returns the Total adjustment amount (integer)' do
              expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][0][:total_adjustment_amount]).to eq(-1620)
            end
            it 'returns the Remarks' do
              expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][0][:remarks]).to eq('NO REMARKS')
            end
            context 'Adjustment group #0' do
              it 'returns the Adjustment group' do
                expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_group]).to eq('OTHER ADJUSTMENTS')
              end
              it 'returns the Adjustment amount (integer)' do
                expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_amount]).to eq(-1620)
              end
              it 'returns the Translated reason code' do
                expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][0][:adjustment_groups][0][:translated_reason_code]).to eq('CHARGES EXCEED YOUR CONTRACTED/LEGISLATED FEE ARRANGEMENT.')
              end
            end
          end

          context 'Line item #1' do
            it 'returns the Date of service (string mm/dd/yyyy)' do
              expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][1][:service_date]).to eq('11/09/2017')
            end
            it 'returns the CPT code' do
              expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][1][:cpt_code]).to eq('92507')
            end
            it 'returns the Charge amount (integer)' do
              expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][1][:charge_amount]).to eq(-500)
            end
            it 'returns the Payment amount (integer)' do
              expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][1][:payment_amount]).to eq(0)
            end
            it 'returns the Total adjustment amount (integer)' do
              expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][1][:total_adjustment_amount]).to eq(-500)
            end
            it 'returns the Remarks' do
              expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][1][:remarks]).to eq('NO REMARKS')
            end
            context 'Adjustment group #0' do
              it 'returns the Adjustment group' do
                expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][1][:adjustment_groups][0][:adjustment_group]).to eq('OTHER ADJUSTMENTS')
              end
              it 'returns the Adjustment amount (integer)' do
                expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][1][:adjustment_groups][0][:adjustment_amount]).to eq(-500)
              end
              it 'returns the Translated reason code' do
                expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][1][:adjustment_groups][0][:translated_reason_code]).to eq('PAYMENT ADJUSTED BECAUSE CHARGES HAVE BEEN PAID BY ANOTHER PAYER.')
              end
            end
          end
        end

        context 'ERA #1' do
          it 'returns the ERA text' do
            text = <<-EOF
--------------------------------------------------------------------------------------------------------------------------------------------------------
Check#                         Patient ID         Last,First          Charge Amt  Payment Amt  Accnt#        Status                         Payer
201812215555555556             ZECM11111112       SMITH,JOSEPH        100.00      100.00       M111          PROCESSED AS SECONDARY         ABC HEALTHCARE WEST
                                                                                                                                            50 EAST RD
                                                                                                                                            ANYWHERE,TN 00002-1111
                                                                                                                                            Tax ID: 11-1111111
                                                                                                Payer Claim Control Number: BT1111111141

          Line Item:  Svc Date   CPT    Charge Amt   Payment Amt  Total Adj Amt  Remarks
                      10/25/2017 92507  100.00       100.00       0.00           NO REMARKS
            EOF
            expect(@era[:checks]['201812215555555556'][:eras][1][:era_text]).to eq(text.strip)
          end
          it 'returns the Patient ID' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:patient_id]).to eq('ZECM11111112')
          end
          it 'returns the Patient name' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:patient_name]).to eq('SMITH,JOSEPH')
          end
          it 'returns the Patient last name (titlized)' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:patient_last_name]).to eq('Smith')
          end
          it 'returns the Patient first name (titlized)' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:patient_first_name]).to eq('Joseph')
          end
          it 'returns the Total charge amount (integer)' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:charge_amount]).to eq(10000)
          end
          it 'returns the Total payment amount (integer)' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:payment_amount]).to eq(10000)
          end
          it 'returns the Account number' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:account_number]).to eq('M111')
          end
          it 'returns the Status' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:status]).to eq('PROCESSED AS SECONDARY')
          end
          it 'returns the Payer claim control number' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:payer_claim_control_number]).to eq('BT1111111141')
          end
          it 'returns the Claim statement period start' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:claim_statement_period_start]).to eq(nil)
          end
          it 'returns the Claim statement period end' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:claim_statement_period_end]).to eq(nil)
          end

          context 'Line item #0' do
            it 'returns the Date of service (string mm/dd/yyyy)' do
              expect(@era[:checks]['201812215555555556'][:eras][1][:line_items][0][:service_date]).to eq('10/25/2017')
            end
            it 'returns the CPT code' do
              expect(@era[:checks]['201812215555555556'][:eras][1][:line_items][0][:cpt_code]).to eq('92507')
            end
            it 'returns the Charge amount (integer)' do
              expect(@era[:checks]['201812215555555556'][:eras][1][:line_items][0][:charge_amount]).to eq(10000)
            end
            it 'returns the Payment amount (integer)' do
              expect(@era[:checks]['201812215555555556'][:eras][1][:line_items][0][:payment_amount]).to eq(10000)
            end
            it 'returns the Total adjustment amount (integer)' do
              expect(@era[:checks]['201812215555555556'][:eras][1][:line_items][0][:total_adjustment_amount]).to eq(0)
            end
            it 'returns the Remarks' do
              expect(@era[:checks]['201812215555555556'][:eras][1][:line_items][0][:remarks]).to eq('NO REMARKS')
            end
          end
        end
      end

      context 'Check #201812215555555557' do
        it 'returns the check number' do
          expect(@era[:checks]['201812215555555557'][:check_number]).to eq('201812215555555557')
        end
        it 'returns the amount' do
          expect(@era[:checks]['201812215555555557'][:amount]).to eq(500)
        end
        it 'returns the number of claims' do
          expect(@era[:checks]['201812215555555557'][:number_of_claims]).to eq(2)
        end
        it 'returns the NPI or Tax ID' do
          expect(@era[:checks]['201812215555555557'][:npi_tax_id]).to eq('1212121212')
        end
        it 'returns the payee' do
          expect(@era[:checks]['201812215555555557'][:payee]).to eq('ABC COMPANY LLC')
        end
        it 'returns the Payer name' do
          expect(@era[:checks]['201812215555555557'][:payer_name]).to eq('ABC HEALTHCARE EAST')
        end
        it 'returns the Payer address' do
          expect(@era[:checks]['201812215555555557'][:payer_address]).to eq('ONE CIRCLE RD')
        end
        it 'returns the Payer city' do
          expect(@era[:checks]['201812215555555557'][:payer_city]).to eq('SOMEWHERE')
        end
        it 'returns the Payer state' do
          expect(@era[:checks]['201812215555555557'][:payer_state]).to eq('GA')
        end
        it 'returns the Payer zip code' do
          expect(@era[:checks]['201812215555555557'][:payer_zip_code]).to eq('11111')
        end
        it 'returns the Payer tax id' do
          expect(@era[:checks]['201812215555555557'][:payer_tax_id]).to eq('11-1111110')
        end
        it 'returns the date' do
          expect(@era[:checks]['201812215555555557'][:date]).to eq('12/21/2018')
        end

        context 'ERA #0' do
          it 'returns the ERA text' do
            text = <<-EOF
--------------------------------------------------------------------------------------------------------------------------------------------------------
Check#                         Patient ID         Last,First          Charge Amt  Payment Amt  Accnt#        Status                         Payer
201812215555555557             ZECM11111112       LASTNAME,           45.00       0.00         M111          DENIED                         ABC HEALTHCARE EAST
                                                                                                                                            ONE CIRCLE RD
                                                                                                                                            SOMEWHERE,GA 11111
                                                                                                                                            Tax ID: 11-1111110
                                                                                                Payer Claim Control Number: BT1111111131
                                                                                                Claim Statement Period:     01/30/2019 - 01/30/2019

          Line Item:  Svc Date   CPT    Charge Amt   Payment Amt  Total Adj Amt  Remarks
                      10/28/2017 92507  45.00        0.00         45.00          NO REMARKS

                                Adjustment Group            Adj Amt Translated Reason Code
                                CONTRACTUAL OBLIGATIONS     45.00   CHARGES EXCEED YOUR CONTRACTED/LEGISLATED FEE ARRANGEMENT.
            EOF
            expect(@era[:checks]['201812215555555557'][:eras][0][:era_text]).to eq(text.strip)
          end
          it 'returns the Patient ID' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:patient_id]).to eq('ZECM11111112')
          end
          it 'returns the Patient name' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:patient_name]).to eq('LASTNAME,')
          end
          it 'returns the Patient last name (titlized)' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:patient_last_name]).to eq('Lastname')
          end
          it 'returns the Patient first name (titlized)' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:patient_first_name]).to eq(nil)
          end
          it 'returns the Total charge amount (integer)' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:charge_amount]).to eq(4500)
          end
          it 'returns the Total payment amount (integer)' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:payment_amount]).to eq(0)
          end
          it 'returns the Account number' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:account_number]).to eq('M111')
          end
          it 'returns the Status' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:status]).to eq('DENIED')
          end
          it 'returns the Payer claim control number' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:payer_claim_control_number]).to eq('BT1111111131')
          end
          it 'returns the Claim statement period start' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:claim_statement_period_start]).to eq('01/30/2019')
          end
          it 'returns the Claim statement period end' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:claim_statement_period_end]).to eq('01/30/2019')
          end

          context 'Line item #0' do
            it 'returns the Date of service (string mm/dd/yyyy)' do
              expect(@era[:checks]['201812215555555557'][:eras][0][:line_items][0][:service_date]).to eq('10/28/2017')
            end
            it 'returns the CPT code' do
              expect(@era[:checks]['201812215555555557'][:eras][0][:line_items][0][:cpt_code]).to eq('92507')
            end
            it 'returns the Charge amount (integer)' do
              expect(@era[:checks]['201812215555555557'][:eras][0][:line_items][0][:charge_amount]).to eq(4500)
            end
            it 'returns the Payment amount (integer)' do
              expect(@era[:checks]['201812215555555557'][:eras][0][:line_items][0][:payment_amount]).to eq(0)
            end
            it 'returns the Total adjustment amount (integer)' do
              expect(@era[:checks]['201812215555555557'][:eras][0][:line_items][0][:total_adjustment_amount]).to eq(4500)
            end
            it 'returns the Remarks' do
              expect(@era[:checks]['201812215555555557'][:eras][0][:line_items][0][:remarks]).to eq('NO REMARKS')
            end
            context 'Adjustment group #0' do
              it 'returns the Adjustment group' do
                expect(@era[:checks]['201812215555555557'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_group]).to eq('CONTRACTUAL OBLIGATIONS')
              end
              it 'returns the Adjustment amount (integer)' do
                expect(@era[:checks]['201812215555555557'][:eras][0][:line_items][0][:adjustment_groups][0][:adjustment_amount]).to eq(4500)
              end
              it 'returns the Translated reason code' do
                expect(@era[:checks]['201812215555555557'][:eras][0][:line_items][0][:adjustment_groups][0][:translated_reason_code]).to eq('CHARGES EXCEED YOUR CONTRACTED/LEGISLATED FEE ARRANGEMENT.')
              end
            end
          end
        end

        context 'ERA #1' do
          it 'returns the ERA text' do
            text = <<-EOF
--------------------------------------------------------------------------------------------------------------------------------------------------------
Check#                         Patient ID         Last,First          Charge Amt  Payment Amt  Accnt#        Status                         Payer
201812215555555557             ZECM11111112       WORLD,HELLO         65.00       5.00         M111          PROCESSED AS PRIMARY, FWDED    ABC HEALTHCARE EAST
                                                                                                                                            ONE CIRCLE RD
                                                                                                                                            SOMEWHERE,GA 11111
                                                                                                                                            Tax ID: 11-1111110
                                                                                                Payer Claim Control Number: BT1111111121

          Line Item:  Svc Date   CPT    Charge Amt   Payment Amt  Total Adj Amt  Remarks
                      10/30/2017 92507  65.00        5.00         60.00          NO REMARKS

                                Adjustment Group            Adj Amt Translated Reason Code
                                CONTRACTUAL OBLIGATIONS     16.20   CHARGES EXCEED YOUR CONTRACTED/LEGISLATED FEE ARRANGEMENT.
                                OTHER ADJUSTMENTS           43.80   PAYMENT ADJUSTED BECAUSE CHARGES HAVE BEEN PAID BY ANOTHER PAYER.
            EOF
            expect(@era[:checks]['201812215555555557'][:eras][1][:era_text]).to eq(text.strip)
          end
          it 'returns the Patient ID' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:patient_id]).to eq('ZECM11111112')
          end
          it 'returns the Patient name' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:patient_name]).to eq('WORLD,HELLO')
          end
          it 'returns the Patient last name (titlized)' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:patient_last_name]).to eq('World')
          end
          it 'returns the Patient first name (titlized)' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:patient_first_name]).to eq('Hello')
          end
          it 'returns the Total charge amount (integer)' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:charge_amount]).to eq(6500)
          end
          it 'returns the Total payment amount (integer)' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:payment_amount]).to eq(500)
          end
          it 'returns the Account number' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:account_number]).to eq('M111')
          end
          it 'returns the Status' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:status]).to eq('PROCESSED AS PRIMARY, FWDED')
          end
          it 'returns the Payer claim control number' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:payer_claim_control_number]).to eq('BT1111111121')
          end
          it 'returns the Claim statement period start' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:claim_statement_period_start]).to eq(nil)
          end
          it 'returns the Claim statement period end' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:claim_statement_period_end]).to eq(nil)
          end

          context 'Line item #0' do
            it 'returns the Date of service (string mm/dd/yyyy)' do
              expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:service_date]).to eq('10/30/2017')
            end
            it 'returns the CPT code' do
              expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:cpt_code]).to eq('92507')
            end
            it 'returns the Charge amount (integer)' do
              expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:charge_amount]).to eq(6500)
            end
            it 'returns the Payment amount (integer)' do
              expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:payment_amount]).to eq(500)
            end
            it 'returns the Total adjustment amount (integer)' do
              expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:total_adjustment_amount]).to eq(6000)
            end
            it 'returns the Remarks' do
              expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:remarks]).to eq('NO REMARKS')
            end
            context 'Adjustment group #0' do
              it 'returns the Adjustment group' do
                expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:adjustment_groups][0][:adjustment_group]).to eq('CONTRACTUAL OBLIGATIONS')
              end
              it 'returns the Adjustment amount (integer)' do
                expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:adjustment_groups][0][:adjustment_amount]).to eq(1620)
              end
              it 'returns the Translated reason code' do
                expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:adjustment_groups][0][:translated_reason_code]).to eq('CHARGES EXCEED YOUR CONTRACTED/LEGISLATED FEE ARRANGEMENT.')
              end
            end
            context 'Adjustment group #1' do
              it 'returns the Adjustment group' do
                expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:adjustment_groups][1][:adjustment_group]).to eq('OTHER ADJUSTMENTS')
              end
              it 'returns the Adjustment amount (integer)' do
                expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:adjustment_groups][1][:adjustment_amount]).to eq(4380)
              end
              it 'returns the Translated reason code' do
                expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:adjustment_groups][1][:translated_reason_code]).to eq('PAYMENT ADJUSTED BECAUSE CHARGES HAVE BEEN PAID BY ANOTHER PAYER.')
              end
            end
          end
        end
      end

      context 'Adjustments' do
        context 'Adjustment #0' do
          it 'returns Adjustment date (string mm/dd/yyyy)' do
            expect(@era[:adjustments][0][:adjustment_date]).to eq('12/30/2018')
          end
          it 'returns Provider ID' do
            expect(@era[:adjustments][0][:provider_id]).to eq('1111111111')
          end
          it 'returns Reference ID' do
            expect(@era[:adjustments][0][:reference_id]).to eq('BBBBBBVP31M0')
          end
          it 'returns Adjustment amount (integer)' do
            expect(@era[:adjustments][0][:adjustment_amount]).to eq(-4281)
          end
          it 'returns reason' do
            expect(@era[:adjustments][0][:reason]).to eq('Overpayment Recover')
          end
        end
        context 'Adjustment #1' do
          it 'returns Adjustment date (string mm/dd/yyyy)' do
            expect(@era[:adjustments][1][:adjustment_date]).to eq('12/31/2018')
          end
          it 'returns Provider ID' do
            expect(@era[:adjustments][1][:provider_id]).to eq('1111111112')
          end
          it 'returns Reference ID' do
            expect(@era[:adjustments][1][:reference_id]).to eq('20170514 1710101112 06')
          end
          it 'returns Adjustment amount (integer)' do
            expect(@era[:adjustments][1][:adjustment_amount]).to eq(-3344)
          end
          it 'returns reason' do
            expect(@era[:adjustments][1][:reason]).to eq('Overpayment Recover')
          end
        end
        context 'Adjustment #2' do
          it 'returns Adjustment date (string mm/dd/yyyy)' do
            expect(@era[:adjustments][2][:adjustment_date]).to eq('12/30/2018')
          end
          it 'returns Provider ID' do
            expect(@era[:adjustments][2][:provider_id]).to eq('1111111113')
          end
          it 'returns Reference ID' do
            expect(@era[:adjustments][2][:reference_id]).to eq('BBBBBBVP31M2')
          end
          it 'returns Adjustment amount (integer)' do
            expect(@era[:adjustments][2][:adjustment_amount]).to eq(3345)
          end
          it 'returns reason' do
            expect(@era[:adjustments][2][:reason]).to eq('Overpayment Recover')
          end
        end
      end
    end

    context 'opened File' do
      context 'Machine readable' do
        context 'example_1.835' do
          before :all do
            @era = Era835Parser::Parser.new(file: File.open("../era_835_parser/spec/example_1.835")).parse
          end

          context 'Aggregate totals' do
            it 'returns the addressed to' do
              expect(@era[:addressed_to]).to eq(nil)
            end
            it 'returns the correct number of checks' do
              expect(@era[:checks].count).to eq(1)
            end
            it 'returns the correct number of adjustments' do
              expect(@era[:adjustments]).to eq(nil)
            end
            it 'returns the correct number of eras' do
              expect(@era[:checks]['70408535'][:eras].count).to eq(1)
            end
            it 'returns the correct number of line items' do
              expect(@era[:checks]['70408535'][:eras][0][:line_items].count).to eq(1)
            end
            it 'returns the correct number of adjustment groups' do
              expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
            end
          end
        end
      end

      context 'Human readable' do
        before :all do
          @era = Era835Parser::Parser.new(file: File.open("../era_835_parser/spec/test_era.txt")).parse
        end

        context 'Aggregate totals' do
          it 'returns the addressed to' do
            expect(@era[:addressed_to]).to eq('Jane Doe')
          end
          it 'returns the correct number of checks' do
            expect(@era[:checks].count).to eq(3)
          end
          it 'returns the correct number of adjustments' do
            expect(@era[:adjustments].count).to eq(3)
          end

          it 'returns the correct number of line items' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:line_items].count).to eq(1)
          end
          it 'returns the correct number of line items' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:line_items].count).to eq(2)
          end
          it 'returns the correct number of line items' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:line_items].count).to eq(1)
          end
          it 'returns the correct number of line items' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:line_items].count).to eq(1)
          end
          it 'returns the correct number of line items' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:line_items].count).to eq(1)
          end

          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][1][:adjustment_groups].count).to eq(1)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:line_items][0][:adjustment_groups]).to eq(nil)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:adjustment_groups].count).to eq(2)
          end
        end
      end
    end

    context 'StringIO' do
      context 'Machine readable' do
        context 'example_1.835' do
          before :all do
            file_string = File.open("../era_835_parser/spec/example_1.835").read
            string_io = StringIO.new(file_string)
            @era = Era835Parser::Parser.new(file: string_io).parse
          end

          context 'Aggregate totals' do
            it 'returns the addressed to' do
              expect(@era[:addressed_to]).to eq(nil)
            end
            it 'returns the correct number of checks' do
              expect(@era[:checks].count).to eq(1)
            end
            it 'returns the correct number of adjustments' do
              expect(@era[:adjustments]).to eq(nil)
            end
            it 'returns the correct number of eras' do
              expect(@era[:checks]['70408535'][:eras].count).to eq(1)
            end
            it 'returns the correct number of line items' do
              expect(@era[:checks]['70408535'][:eras][0][:line_items].count).to eq(1)
            end
            it 'returns the correct number of adjustment groups' do
              expect(@era[:checks]['70408535'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
            end
          end
        end
      end

      context 'Human readable' do
        before :all do
          file_string = File.open("../era_835_parser/spec/test_era.txt").read
          string_io = StringIO.new(file_string)
          @era = Era835Parser::Parser.new(file: string_io).parse
        end

        context 'Aggregate totals' do
          it 'returns the addressed to' do
            expect(@era[:addressed_to]).to eq('Jane Doe')
          end
          it 'returns the correct number of checks' do
            expect(@era[:checks].count).to eq(3)
          end
          it 'returns the correct number of adjustments' do
            expect(@era[:adjustments].count).to eq(3)
          end

          it 'returns the correct number of line items' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:line_items].count).to eq(1)
          end
          it 'returns the correct number of line items' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:line_items].count).to eq(2)
          end
          it 'returns the correct number of line items' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:line_items].count).to eq(1)
          end
          it 'returns the correct number of line items' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:line_items].count).to eq(1)
          end
          it 'returns the correct number of line items' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:line_items].count).to eq(1)
          end

          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['201812215555555555'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][1][:adjustment_groups].count).to eq(1)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['201812215555555556'][:eras][1][:line_items][0][:adjustment_groups]).to eq(nil)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['201812215555555557'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
          end
          it 'returns the correct number of adjustment groups' do
            expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:adjustment_groups].count).to eq(2)
          end
        end
      end
    end
  end
end
