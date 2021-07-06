import React from "react";
import List from "./List";

export default function Details({ cost, setCost }) {
  return (
    <div className="details">
      <button
        type="submit"
        className="btn btn-secondary my-2"
        onClick={() => setCost(null)}
      >
        Back
      </button>
      <div className="row">
        <div className="not-converted">
          <h3>Without Conversion</h3>
          <List obj={cost.ksh} currency="KSH" />
        </div>
        <div className="converted">
          <h3>With Conversion</h3>
          <List obj={cost.usd} currency="USD" />
        </div>
      </div>
    </div>
  );
}
