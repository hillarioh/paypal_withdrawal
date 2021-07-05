class Withdraw < ApplicationRecord
    validates :amount, presence: true
    validates :convert, presence: true

    PAYPAL_COMMISSION = 0.03
    CLIENT_COMMISSION = 0.02
    CONVERSION_RATE = 108
    MPESA_RATE_LOW = 22
    MPESA_RATE_MID = 55
    BANK_CHARGES = 40

    def self.with_convert(amount)
        local_transfer = amount + MPESA_RATE_LOW + BANK_CHARGES
        bank_transfer = local_transfer * (1/(1-CLIENT_COMMISSION))
        paypal_charges = bank_transfer * (1/(1-PAYPAL_COMMISSION))
        @with_outline = {
            "paypal_commission": paypal_charges - bank_transfer,
            "client_commission": bank_transfer - local_transfer,
            "mpesa_transaction_fee": MPESA_RATE_LOW ,
            "bank_charges": BANK_CHARGES,
            "required_balance": paypal_charges
        }
        @with_outline
    end

    def self.without_conversion(amount)
    end


end
