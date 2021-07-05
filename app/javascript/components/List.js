import React from "react";

export default function List({ obj, currency }) {
  return (
    <ul className="list-group">
      <li className="list-group-item">
        PayPal Commission: {obj.paypal_commission}
      </li>
      <li className="list-group-item">
        Off-Shore Commission: {obj.offshore_commission}
      </li>
      <li className="list-group-item">
        Client Commission: {obj.client_commission}
      </li>
      <li className="list-group-item">
        Mpesa Transaction: {obj.mpesa_transaction_fee}
      </li>
      <li className="list-group-item">Bank Charges: {obj.bank_charges}</li>
      <li className="list-group-item">
        Amount Required({currency}): {obj.required_balance}
      </li>
    </ul>
  );
}
