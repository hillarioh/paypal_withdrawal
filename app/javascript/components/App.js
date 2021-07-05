import React, { useState } from "react";
import Home from "./Home";
import Details from "./Details";

export default function App() {
  const [cost, setCost] = useState();

  if (cost) {
    return <Details cost={cost} setCost={setCost} />;
  } else {
    return <Home setCost={setCost} />;
  }
}
