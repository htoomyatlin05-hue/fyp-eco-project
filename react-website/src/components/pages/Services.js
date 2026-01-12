import React from "react";
import "./Services.css";
import { Link } from "react-router-dom";

export default function Services() {
  return (
    <div className="services-page">
      <div className="services-hero">
        <h1>Services</h1>
        <p>Tools to measure and reduce environmental impact — clearly and transparently.</p>
      </div>

      <div className="services-grid">
        <div className="services-card">
          <h3>Carbon Calculator</h3>
          <p>Estimate CO₂e across materials, transport, energy, machining, packaging, and end-of-life.</p>
        </div>

        <div className="services-card">
          <h3>Transport Emissions</h3>
          <p>Road, sea, and air options with distance + mass inputs for consistent comparisons.</p>
        </div>

        <div className="services-card">
          <h3>Manufacturing & Machining</h3>
          <p>Energy-based emissions using power draw × grid intensity × time operated.</p>
        </div>

        <div className="services-card">
          <h3>Methodology & Reporting</h3>
          <p>Transparent assumptions and factors so results are explainable and reproducible.</p>
        </div>
      </div>

      <div className="services-wide">
        <div className="services-card wide">
          <h3>Who it’s for</h3>
          <ul>
            <li>Students & researchers</li>
            <li>SMEs & startups</li>
            <li>Engineers & sustainability teams</li>
          </ul>
        </div>

        <div className="services-card wide">
          <h3>What makes ECO-Pi different</h3>
          <ul>
            <li>No black-box outputs — clear breakdowns</li>
            <li>Category-based approach (materials, transport, energy, etc.)</li>
            <li>Designed to be extended as your data grows</li>
          </ul>
        </div>
      </div>

      <div className="services-cta">
        <Link to="/calculator" className="cta-btn primary">Try the Calculator</Link>
        <Link to="/methodology" className="cta-btn ghost">View Methodology</Link>
      </div>
    </div>
  );
}
