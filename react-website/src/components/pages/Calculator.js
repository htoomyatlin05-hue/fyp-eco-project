import React, { useEffect, useState } from 'react';
import '../../App.css';
import './SimplePage.css';

const API_BASE = 'http://127.0.0.1:8000';

export default function Calculator() {
  const [loading, setLoading] = useState(true);
  const [err, setErr] = useState('');

  // options from /meta/options
  const [countries, setCountries] = useState([]);
  const [materials, setMaterials] = useState([]);
  const [transportTypes, setTransportTypes] = useState([]);

  // user inputs
  const [country, setCountry] = useState('');
  const [material, setMaterial] = useState('');
  const [massKg, setMassKg] = useState('100');
  const [distanceKm, setDistanceKm] = useState('100');
  const [transportType, setTransportType] = useState('');

  // output
  const [result, setResult] = useState(null);

  useEffect(() => {
    const loadOptions = async () => {
      try {
        setLoading(true);
        setErr('');

        const res = await fetch(`${API_BASE}/meta/options`);
        if (!res.ok) throw new Error(`meta/options failed (${res.status})`);
        const data = await res.json();

        // These keys match what you showed earlier in FastAPI
        const c = data.countries || [];
        const m = data.materials || [];
        const t = data.transport_types || data.transportTypes || [];

        setCountries(c);
        setMaterials(m);
        setTransportTypes(t);

        setCountry(c[0] || '');
        setMaterial(m[0] || '');
        setTransportType(t[0] || '');
      } catch (e) {
        setErr(e.message || 'Failed to load options');
      } finally {
        setLoading(false);
      }
    };

    loadOptions();
  }, []);

  // IMPORTANT:
  // Change this endpoint to one you already have, for example:
  // /calculate/truck , /calculate/van , /calculate/air_freight , etc.
  // The payload keys must match your FastAPI model.
  const calculate = async () => {
    try {
      setErr('');
      setResult(null);

      // Example payload (edit to match your endpoint)
      const payload = {
        transport_type: transportType,
        distance_km: Number(distanceKm),
        mass_kg: Number(massKg),
      };

      const res = await fetch(`${API_BASE}/calculate/truck`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });

      if (!res.ok) {
        const text = await res.text();
        throw new Error(`Calculate failed (${res.status}): ${text}`);
      }

      const data = await res.json();
      setResult(data);
    } catch (e) {
      setErr(e.message || 'Calculation failed');
    }
  };

  return (
    <div className="page">
      <div className="page__container">
        <h1>Calculator</h1>
        <p className="page__muted">
          This page pulls dropdowns from your FastAPI <b>/meta/options</b> and can call a calculate endpoint.
        </p>

        <div className="page__card">
          {loading ? (
            <p className="page__muted">Loading options…</p>
          ) : (
            <>
              <div className="page__row">
                <div>
                  <label className="page__label">Country</label>
                  <select className="page__select" value={country} onChange={(e) => setCountry(e.target.value)}>
                    {countries.map((c) => (
                      <option key={c} value={c}>{c}</option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className="page__label">Material</label>
                  <select className="page__select" value={material} onChange={(e) => setMaterial(e.target.value)}>
                    {materials.map((m) => (
                      <option key={m} value={m}>{m}</option>
                    ))}
                  </select>
                </div>
              </div>

              <div className="page__row" style={{ marginTop: 12 }}>
                <div>
                  <label className="page__label">Transport type</label>
                  <select className="page__select" value={transportType} onChange={(e) => setTransportType(e.target.value)}>
                    {transportTypes.map((t) => (
                      <option key={t} value={t}>{t}</option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className="page__label">Mass (kg)</label>
                  <input className="page__input" value={massKg} onChange={(e) => setMassKg(e.target.value)} />
                </div>
              </div>

              <div className="page__row" style={{ marginTop: 12 }}>
                <div>
                  <label className="page__label">Distance (km)</label>
                  <input className="page__input" value={distanceKm} onChange={(e) => setDistanceKm(e.target.value)} />
                </div>

                <div>
                  <label className="page__label">Action</label>
                  <button className="page__btn" type="button" onClick={calculate}>
                    Calculate (Transport)
                  </button>
                </div>
              </div>

              {err && (
                <div className="page__result" style={{ marginTop: 12 }}>
                  <b>Error:</b> <span className="page__muted">{err}</span>
                  <div className="page__muted" style={{ marginTop: 8 }}>
                    If you don’t have <b>/calculate/truck</b>, change it in <code>Calculator.js</code> to the endpoint you do have.
                  </div>
                </div>
              )}

              {result && (
                <div className="page__result">
                  <b>Result:</b>
                  <pre style={{ whiteSpace: 'pre-wrap', marginTop: 10 }}>
{JSON.stringify(result, null, 2)}
                  </pre>
                </div>
              )}
            </>
          )}
        </div>

        <div className="page__card" style={{ marginTop: 18 }}>
          <h3>Next upgrade</h3>
          <p className="page__muted">
            Tell me which calculate endpoints you already have (names + required fields), and I’ll convert this page into:
            material + transport + machining + packaging + recycling tabs with a final total CO₂e breakdown.
          </p>
        </div>
      </div>
    </div>
  );
}
