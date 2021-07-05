import React, { useState } from "react";

export default function Home() {
  const [details, setDetails] = useState({
    amount: 0,
    convert: false,
  });

  const withdraw = async () => {
    const token = document.querySelector('meta[name="csrf-token"]').content;

    await fetch("/withdraw", {
      method: "POST",
      redirect: "follow",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json",
      },
      body: JSON.stringify(details),
    })
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((response) => console.log(response))
      .catch((error) => console.log(error));
  };

  const handleAmount = (e) => {
    setDetails({ ...details, amount: parseInt(e.target.value) });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // console.log(details);
    withdraw();
  };

  return (
    <div className="container mt-4">
      <h3>Withdraw cash from Paypal</h3>
      <form>
        <div className="form-group">
          <label className="my-2">Enter Amount To Withdraw </label>
          <input
            type="text"
            className="form-control"
            name="amount"
            value={details.amount}
            onChange={handleAmount}
            placeholder="Enter amount to withdraw"
          />
        </div>
        <button
          type="submit"
          className="btn btn-primary my-2"
          onClick={handleSubmit}
        >
          Submit
        </button>
      </form>
      <div className="d-flex">
        <div className="flex-1 not-converted">
          <h5>Without Conversion</h5>
        </div>
        <div className="flex-1 converted">
          <h5>With Conversion</h5>
        </div>
      </div>
    </div>
  );
}
