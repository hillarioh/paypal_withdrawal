import React, { useState, useEffect } from "react";
import Loader from "react-loader-spinner";
import "react-loader-spinner/dist/loader/css/react-spinner-loader.css";

export default function Home({ setCost }) {
  const [amount, setAmount] = useState(0);
  const [userDetails, setUserDetails] = useState(null);

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

  useEffect(() => {
    getInfo();
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
        setUserDetails(response.user_info[0]);
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
      <div className="user-info">
        {userDetails ? (
          <div className="user-details">
            <h3>User Details</h3>
            <p className="">
              <span>First Name</span>
              <span>{userDetails.firstName}</span>
            </p>
            <p className="">
              <span>Last Name</span>
              <span>{userDetails.lastName}</span>
            </p>
            <p>
              <span>Email</span>
              <span>{userDetails.email}</span>
            </p>
            <p>
              <span>Title</span>
              <span>{userDetails.title}</span>
            </p>
          </div>
        ) : (
          <div className="loader">
            <Loader type="Circles" color="#2196f7a6" height={100} width={100} />
          </div>
        )}
      </div>
    </div>
  );
}
