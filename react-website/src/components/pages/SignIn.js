import React from "react";
import "./SignIn.css";

function SignIn() {
  return (
    <div className="signin-page">
      {/* LEFT PANEL */}
      <div className="signin-left">
        <div className="signin-form-wrap">
          <h1>Sign in</h1>

          <form className="signin-form">
            <input type="text" placeholder="Username or email address" />
            <input type="password" placeholder="Password" />
            <button type="submit">Sign in</button>
          </form>

          <div className="signin-footer">
            <a href="/">Forgotten password?</a>
            <a href="/">Create account</a>
          </div>
        </div>
      </div>

      {/* CURVED DIVIDER */}
      <div className="signin-curve">
        <svg viewBox="0 0 120 1000" preserveAspectRatio="none">
          <path
            d="M120,0 C20,250 20,750 120,1000 L0,1000 L0,0 Z"
            fill="#ffffff"
          />
        </svg>
      </div>

      {/* RIGHT IMAGE */}
      <div
        className="signin-right"
        style={{ backgroundImage: "url(/images/Leaves.png)" }}
      />
    </div>
  );
}

export default SignIn;
