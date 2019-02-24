require 'spec_helper'

RSpec.describe Era835Parser::Parser do

  describe '#parse' do
    before :all do
      @era = Era835Parser::Parser.new(file_path: "../era_835_parser/spec/test_era.txt").parse
    end

    # context 'Aggregate totals' do
    #   it 'returns the correct number of checks' do
    #     expect(@era[:checks].count).to eq(3)
    #   end
    #   it 'returns the correct number of adjustments' do
    #     expect(@era[:adjustments].count).to eq(3)
    #   end

    #   it 'returns the correct number of line items' do
    #     expect(@era[:checks]['201812215555555555'][:eras][0][:line_items].count).to eq(1)
    #   end
    #   it 'returns the correct number of line items' do
    #     expect(@era[:checks]['201812215555555556'][:eras][0][:line_items].count).to eq(2)
    #   end
    #   it 'returns the correct number of line items' do
    #     expect(@era[:checks]['201812215555555556'][:eras][1][:line_items].count).to eq(1)
    #   end
    #   it 'returns the correct number of line items' do
    #     expect(@era[:checks]['201812215555555557'][:eras][0][:line_items].count).to eq(1)
    #   end
    #   it 'returns the correct number of line items' do
    #     expect(@era[:checks]['201812215555555557'][:eras][1][:line_items].count).to eq(1)
    #   end

    #   it 'returns the correct number of adjustment groups' do
    #     expect(@era[:checks]['201812215555555555'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
    #   end
    #   it 'returns the correct number of adjustment groups' do
    #     expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
    #   end
    #   it 'returns the correct number of adjustment groups' do
    #     expect(@era[:checks]['201812215555555556'][:eras][0][:line_items][1][:adjustment_groups].count).to eq(1)
    #   end
    #   it 'returns the correct number of adjustment groups' do
    #     expect(@era[:checks]['201812215555555556'][:eras][1][:line_items][0][:adjustment_groups].count).to eq(0)
    #   end
    #   it 'returns the correct number of adjustment groups' do
    #     expect(@era[:checks]['201812215555555557'][:eras][0][:line_items][0][:adjustment_groups].count).to eq(1)
    #   end
    #   it 'returns the correct number of adjustment groups' do
    #     expect(@era[:checks]['201812215555555557'][:eras][1][:line_items][0][:adjustment_groups].count).to eq(2)
    #   end
    # end

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
      it 'returns the date' do
        expect(@era[:checks]['201812215555555555'][:date]).to eq('12/21/2018')
      end

      context 'ERA #0' do
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
        it 'returns the Payer name' do
          expect(@era[:checks]['201812215555555555'][:eras][0][:payer_name]).to eq('ABC HEALTHCARE EAST')
        end
        it 'returns the Payer address' do
          expect(@era[:checks]['201812215555555555'][:eras][0][:payer_address]).to eq('ONE CIRCLE RD')
        end
        it 'returns the Payer city' do
          expect(@era[:checks]['201812215555555555'][:eras][0][:payer_city]).to eq('SOMEWHERE')
        end
        it 'returns the Payer state' do
          expect(@era[:checks]['201812215555555555'][:eras][0][:payer_state]).to eq('GA')
        end
        it 'returns the Payer zip code' do
          expect(@era[:checks]['201812215555555555'][:eras][0][:payer_zip_code]).to eq('11111')
        end
        it 'returns the Payer tax id' do
          expect(@era[:checks]['201812215555555555'][:eras][0][:payer_tax_id]).to eq('11-1111110')
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
      it 'returns the date' do
        expect(@era[:checks]['201812215555555556'][:date]).to eq('12/22/2018')
      end

      context 'ERA #0' do
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
        it 'returns the Payer name' do
          expect(@era[:checks]['201812215555555556'][:eras][0][:payer_name]).to eq('ABC HEALTHCARE WEST')
        end
        it 'returns the Payer address' do
          expect(@era[:checks]['201812215555555556'][:eras][0][:payer_address]).to eq('50 EAST RD')
        end
        it 'returns the Payer city' do
          expect(@era[:checks]['201812215555555556'][:eras][0][:payer_city]).to eq('ANYWHERE')
        end
        it 'returns the Payer state' do
          expect(@era[:checks]['201812215555555556'][:eras][0][:payer_state]).to eq('TN')
        end
        it 'returns the Payer zip code' do
          expect(@era[:checks]['201812215555555556'][:eras][0][:payer_zip_code]).to eq('00002-1111')
        end
        it 'returns the Payer tax id' do
          expect(@era[:checks]['201812215555555556'][:eras][0][:payer_tax_id]).to eq('11-1111111')
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
        it 'returns the Payer name' do
          expect(@era[:checks]['201812215555555556'][:eras][1][:payer_name]).to eq('ABC HEALTHCARE WEST')
        end
        it 'returns the Payer address' do
          expect(@era[:checks]['201812215555555556'][:eras][1][:payer_address]).to eq('50 EAST RD')
        end
        it 'returns the Payer city' do
          expect(@era[:checks]['201812215555555556'][:eras][1][:payer_city]).to eq('ANYWHERE')
        end
        it 'returns the Payer state' do
          expect(@era[:checks]['201812215555555556'][:eras][1][:payer_state]).to eq('TN')
        end
        it 'returns the Payer zip code' do
          expect(@era[:checks]['201812215555555556'][:eras][1][:payer_zip_code]).to eq('00002')
        end
        it 'returns the Payer tax id' do
          expect(@era[:checks]['201812215555555556'][:eras][1][:payer_tax_id]).to eq('11-1111111')
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
      it 'returns the date' do
        expect(@era[:checks]['201812215555555557'][:date]).to eq('12/21/2018')
      end

      context 'ERA #0' do
        it 'returns the Patient ID' do
          expect(@era[:checks]['201812215555555557'][:eras][0][:patient_id]).to eq('ZECM11111112')
        end
        it 'returns the Patient name' do
          expect(@era[:checks]['201812215555555557'][:eras][0][:patient_name]).to eq('LASTNAME,FIRST')
        end
        it 'returns the Patient last name (titlized)' do
          expect(@era[:checks]['201812215555555557'][:eras][0][:patient_last_name]).to eq('Lastname')
        end
        it 'returns the Patient first name (titlized)' do
          expect(@era[:checks]['201812215555555557'][:eras][0][:patient_first_name]).to eq('First')
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
        it 'returns the Payer name' do
          expect(@era[:checks]['201812215555555557'][:eras][0][:payer_name]).to eq('ABC HEALTHCARE EAST')
        end
        it 'returns the Payer address' do
          expect(@era[:checks]['201812215555555557'][:eras][0][:payer_address]).to eq('ONE CIRCLE RD')
        end
        it 'returns the Payer city' do
          expect(@era[:checks]['201812215555555557'][:eras][0][:payer_city]).to eq('SOMEWHERE')
        end
        it 'returns the Payer state' do
          expect(@era[:checks]['201812215555555557'][:eras][0][:payer_state]).to eq('GA')
        end
        it 'returns the Payer zip code' do
          expect(@era[:checks]['201812215555555557'][:eras][0][:payer_zip_code]).to eq('11111')
        end
        it 'returns the Payer tax id' do
          expect(@era[:checks]['201812215555555557'][:eras][0][:payer_tax_id]).to eq('11-1111110')
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
        it 'returns the Payer name' do
          expect(@era[:checks]['201812215555555557'][:eras][1][:payer_name]).to eq('ABC HEALTHCARE EAST')
        end
        it 'returns the Payer address' do
          expect(@era[:checks]['201812215555555557'][:eras][1][:payer_address]).to eq('ONE CIRCLE RD')
        end
        it 'returns the Payer city' do
          expect(@era[:checks]['201812215555555557'][:eras][1][:payer_city]).to eq('SOMEWHERE')
        end
        it 'returns the Payer state' do
          expect(@era[:checks]['201812215555555557'][:eras][1][:payer_state]).to eq('GA')
        end
        it 'returns the Payer zip code' do
          expect(@era[:checks]['201812215555555557'][:eras][1][:payer_zip_code]).to eq('11111')
        end
        it 'returns the Payer tax id' do
          expect(@era[:checks]['201812215555555557'][:eras][1][:payer_tax_id]).to eq('11-1111110')
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
          expect(@era[:adjustments][1][:reference_id]).to eq('BBBBBBVP31M1')
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
end