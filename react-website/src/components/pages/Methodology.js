import React from 'react';
import '../../App.css';
import './SimplePage.css';

export default function Methodology() {
  return (
    <div className="page">
      <div className="page__container">
        <h1>Methodology</h1>
        <p className="page__muted">
          Simple and transparent calculations: Emissions = Activity Data × Emission Factor.
        </p>

        <div className="page__card">
          <h3>Examples</h3>
          <ul>
            <li><b>Materials:</b> mass × material EF</li>
            <li><b>Transport:</b> mass × distance × EF</li>
            <li><b>Electricity:</b> power × time × grid intensity</li>
          </ul>
        </div>
      </div>
    </div>
  );
}
