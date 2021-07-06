import React from "react";

export default function List({ obj, currency }) {
  return (
    <ul className="list-group">
      <li className="list-group-item">
        <span>PayPal Commission:</span>
        <span>
          {currency}. {obj.paypal_commission}
        </span>
      </li>
      <li className="list-group-item">
        <span>Off-Shore Commission:</span>
        <span> Ksh. {obj.offshore_commission}</span>
      </li>
      <li className="list-group-item">
        <span>Client Commission:</span>
        <span>Ksh. {obj.client_commission}</span>
      </li>
      <li className="list-group-item">
        <span>Mpesa Transaction:</span>
        <span>Ksh. {obj.mpesa_transaction_fee}</span>
      </li>
      <li className="list-group-item">
        <span>Bank Charges:</span>
        <span>{obj.bank_charges}</span>
      </li>
      <li className="list-group-item">
        <span>Amount Required({currency}): </span>
        <span>{obj.required_balance}</span>
      </li>
    </ul>
  );
}
