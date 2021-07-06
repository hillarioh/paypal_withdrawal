import React, { useState } from "react";

export default function Home({ setCost }) {
  const [amount, setAmount] = useState(0);

  const withdraw = async () => {
    const token = document.querySelector('meta[name="csrf-token"]').content;

    await fetch("/withdraw", {
      method: "POST",
      redirect: "follow",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ amount }),
    })
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((response) => {
        setCost(response);
      })
      .catch((error) => console.log(error));
  };

  const handleAmount = (e) => {
    setAmount(parseInt(e.target.value));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    withdraw();
  };

  return (
    <div className="container">
      <h3>Withdraw cash from Paypal</h3>
      <form>
        <div className="form-group">
          <label className="my-2">Enter Amount To Withdraw </label>
          <input
            type="text"
            className="form-control"
            name="amount"
            value={amount}
            onChange={handleAmount}
            placeholder="Enter amount to withdraw"
          />
        </div>
        <button type="submit" className="btn" onClick={handleSubmit}>
          Submit
        </button>
      </form>
    </div>
  );
}
