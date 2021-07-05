import React from "react";
import List from "./List";

export default function Details({ cost, setCost }) {
  return (
    <div className="container mt-5">
      <button
        type="submit"
        className="btn btn-secondary my-2"
        onClick={() => setCost(null)}
      >
        Back
      </button>
      <div className="row">
        <div className="col-6 not-converted">
          <h5>Without Conversion</h5>
          <List obj={cost.ksh} currency="KSH" />
        </div>
        <div className="col-6 converted">
          <h5>With Conversion</h5>
          <List obj={cost.usd} currency="USD" />
        </div>
      </div>
    </div>
  );
}
