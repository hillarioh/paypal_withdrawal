class Withdraw < ApplicationRecord
    validates :amount, presence: true
    validates :convert, presence: true

    PAYPAL_COMMISSION = 0.03
    OFFSHORE_COMMISSION = 0.02
    CLIENT_COMMISSION = 0.02
    CONVERSION_RATE = 108
    MPESA_RATE_LOW = 22
    MPESA_RATE_MID = 55
    BANK_CHARGES = 40

    def self.with_conversion(amount)
        customer_mpesa = amount
        client_mpesa_wallet = customer_mpesa + 22
        local_bank_balance_after_commission = client_mpesa_wallet + BANK_CHARGES
        local_bank_balance_before_commission = local_bank_balance_after_commission  * (1/(1-CLIENT_COMMISSION))
        offshore_bank_balance = local_bank_balance_before_commission * (1/(1-OFFSHORE_COMMISSION))
        usd_value = offshore_bank_balance / CONVERSION_RATE
        customer_paypal_balance = usd_value * (1/(1-PAYPAL_COMMISSION))
        
        with_outline = {
            "paypal_commission": customer_paypal_balance - usd_value,
            "offshore_commission": offshore_bank_balance - local_bank_balance_before_commission,
            "client_commission": local_bank_balance_before_commission - local_bank_balance_after_commission,
            "mpesa_transaction_fee": MPESA_RATE_LOW,
            "bank_charges": BANK_CHARGES,
            "required_balance": customer_paypal_balance
        }
        with_outline      
    end

    def self.without_conversion(amount)
        customer_mpesa = amount
        client_mpesa_wallet = customer_mpesa + 22
        local_bank_balance_after_commission = client_mpesa_wallet + BANK_CHARGES
        local_bank_balance_before_commission = local_bank_balance_after_commission  * (1/(1-CLIENT_COMMISSION))
        offshore_bank_balance = local_bank_balance_before_commission * (1/(1-OFFSHORE_COMMISSION))
        customer_paypal_balance = offshore_bank_balance * (1/(1-PAYPAL_COMMISSION))
        
        with_outline = {
            "paypal_commission": customer_paypal_balance - offshore_bank_balance,
            "offshore_commission": offshore_bank_balance - local_bank_balance_before_commission,
            "client_commission": local_bank_balance_before_commission - local_bank_balance_after_commission,
            "mpesa_transaction_fee": MPESA_RATE_LOW,
            "bank_charges": BANK_CHARGES,
            "required_balance": customer_paypal_balance
        }
        with_outline
    end


end
