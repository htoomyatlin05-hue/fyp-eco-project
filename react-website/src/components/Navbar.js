import React, { useState, useEffect } from 'react';
import './Navbar.css';
import { Link } from 'react-router-dom';

function Navbar() {
  const [click, setClick] = useState(false);
  const [button, setButton] = useState(true);

  // dropdown states
  const [openTools, setOpenTools] = useState(false);
  const [openAbout, setOpenAbout] = useState(false);

  const handleClick = () => setClick(!click);

  const closeMobileMenu = () => {
    setClick(false);
    setOpenTools(false);
    setOpenAbout(false);
  };

  const showButton = () => {
    if (window.innerWidth <= 960) setButton(false);
    else setButton(true);
  };

  useEffect(() => {
    showButton();
  }, []);

  useEffect(() => {
    const onResize = () => showButton();
    window.addEventListener('resize', onResize);
    return () => window.removeEventListener('resize', onResize);
  }, []);

  // close dropdowns when clicking outside
  useEffect(() => {
    const onDocClick = () => {
      setOpenTools(false);
      setOpenAbout(false);
    };
    document.addEventListener('click', onDocClick);
    return () => document.removeEventListener('click', onDocClick);
  }, []);

  const toggleTools = (e) => {
    e.stopPropagation();
    setOpenTools((v) => !v);
    setOpenAbout(false);
  };

  const toggleAbout = (e) => {
    e.stopPropagation();
    setOpenAbout((v) => !v);
    setOpenTools(false);
  };

  return (
    <>
      <nav className="navbar">
        <div className="navbar-container">
          <Link to="/" className="navbar-logo" onClick={closeMobileMenu}>
            <div className="logo-wrapper">
              <span className="logo-text">ECO-Pi</span>
              <img
                src="/images/App_logo.svg"
                alt="ECO-Pi logo"
                className="navbar-logo-img"
              />
            </div>
          </Link>

          <div className="menu-icon" onClick={handleClick}>
            <i className={click ? 'fas fa-times' : 'fas fa-bars'} />
          </div>

          <ul className={click ? 'nav-menu active' : 'nav-menu'}>
            <li className="nav-item">
              <Link to="/" className="nav-links" onClick={closeMobileMenu}>
                Home
              </Link>
            </li>

            {/* DROPDOWN 1: Tools */}
            <li className="nav-item dropdown">
              <button
                type="button"
                className="nav-links nav-dropbtn"
                onClick={(e) => {
                  e.stopPropagation();
                  toggleTools(e);
                }}
              >
                Tools <i className="fas fa-caret-down" />
              </button>

              <ul
                className={openTools ? 'dropdown-menu show' : 'dropdown-menu'}
                onClick={(e) => e.stopPropagation()}
              >
                <li>
                  <Link
                    to="/calculator"
                    className="dropdown-link"
                    onClick={closeMobileMenu}
                  >
                    Calculator
                  </Link>
                </li>
                <li>
                  <Link
                    to="/methodology"
                    className="dropdown-link"
                    onClick={closeMobileMenu}
                  >
                    Methodology
                  </Link>
                </li>
              </ul>
            </li>

            {/* DROPDOWN 2: About */}
            <li className="nav-item dropdown">
              <button
                type="button"
                className="nav-links nav-dropbtn"
                onClick={(e) => {
                  e.stopPropagation();
                  toggleAbout(e);
                }}
              >
                About <i className="fas fa-caret-down" />
              </button>


              <ul
                className={openAbout ? 'dropdown-menu show' : 'dropdown-menu'}
                onClick={(e) => e.stopPropagation()}
              >
                <li>
                  <Link to="/about" className="dropdown-link" onClick={closeMobileMenu}>
                    About Us
                  </Link>
                </li>
                <li>
                  <Link to="/services" className="dropdown-link" onClick={closeMobileMenu}>
                    Services
                  </Link>
                </li>
                <li>
                  <Link to="/contact" className="dropdown-link" onClick={closeMobileMenu}>
                    Contact
                  </Link>
                </li>
              </ul>
            </li>

            <li className="nav-item">
              <Link to="/sign-up" className="nav-links-mobile" onClick={closeMobileMenu}>
                Sign In
              </Link>
            </li>
          </ul>

          {button && (
            <div className="nav-actions">
              <button className="icon-btn" type="button" aria-label="Search">
                <i className="fas fa-search" />
              </button>

              <Link to="/contact" className="nav-outline-btn" onClick={closeMobileMenu}>
                Contact us
              </Link>

              <Link to="/sign-up" className="nav-primary-btn" onClick={closeMobileMenu}>
                Download
              </Link>

              <Link to="/sign-up" className="nav-signin" onClick={closeMobileMenu}>
                Sign in
              </Link>
            </div>
          )}
        </div>
      </nav>
    </>
  );
}

export default Navbar;
