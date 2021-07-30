import React, { useState, useEffect } from "react";
import { Base64 } from "js-base64";

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

  const getUserDetails = async (id) => {
    const token = document.querySelector('meta[name="csrf-token"]').content;
    const hash = Base64.encode("okerio.hilarry:WorkTrial1");
    let url = `https://finplus.sandbox.mambu.com/api/users?userId=?${id}&detailsLevel=BASIC`;
    await fetch(url, {
      method: "GET",
      redirect: "follow",
      headers: {
        "X-CSRF-Token": token,
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        Authorization: `Basic ${hash}`,
      },
    })
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((response) => {
        console.log(response);
      })
      .catch((error) => console.log(error));
  };

  useEffect(() => {
    // getInfo();
    getUserDetails("8a8586957adcca11017ae2ca66fd0bf5");
  }, []);

  const getInfo = async () => {
    const token = document.querySelector('meta[name="csrf-token"]').content;

    await fetch("/user-info", {
      method: "GET",
      redirect: "follow",
      headers: {
        "X-CSRF-Token": token,
        "Content-Type": "application/json",
      },
    })
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then((response) => {
        getUserDetails("8a8586957adcca11017ae2ca66fd0bf5");
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
