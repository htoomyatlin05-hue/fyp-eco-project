import React from "react";
import "../../App.css";
import "./About_us.css";

export default function HowItWorks() {
  return (
    <div
      className="about"
      style={{ backgroundImage: `url(${process.env.PUBLIC_URL}/images/img-1.jpg)` }}
    >
      <div className="about__overlay">
        <div className="about__container">
          <header className="about__header">
            <h1 className="about__title">App tutorial</h1>
            <p className="about__subtitle">
              Watch the walkthrough to learn how to use the app.
            </p>
          </header>

          <section className="about__videoWrap">
            <video className="about__video" controls>
              <source
                src={`${process.env.PUBLIC_URL}/videos/app-tutorial.mp4`}
                type="video/mp4"
              />
              Your browser does not support the video tag.
            </video>
          </section>
        </div>
      </div>
    </div>
  );
}
