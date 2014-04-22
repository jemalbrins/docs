Browser & device testing
========================

Prior to publishing a new project or major changes to an existing project, make sure your changes
look good on the supported browsers and devices below. Test these on a staging server
before publishing to production.

First steps
-----------

Validation
~~~~~~~~~~

- Is your HTML valid and correct? Use the `W3C HTML validator <http://validator.w3.org/>`_.
- Is your CSS valid and correct? Use the `W3C CSS validator <http://jigsaw.w3.org/css-validator/>`_.
- Is your Javascript console free of errors? Note that advertisements may trigger console errors. If you
  are sure errors are not in your code and not interrupting page functionality, these may be safely ignored.

Linting
~~~~~~~

Linting refers to cleaning up your code for syntax and style mistakes as well as minor issues like
repeated CSS rules or Javascript variable declarations.

- `Lint Javascript <http://www.jslint.com/>`_
- `Lint CSS <http://csslint.net/>`_

Browser testing
---------------

We currently support the following browsers:

- Internet Explorer 8, 9 & 10
- Chrome
- Safari
- Firefox

Check your site in each of these browsers to ensure that the display and functionality is the same 
across browsers. This includes such things as:

- Font size and rendering
- Padding and margins
- Positioning
- JavaScript functionality (especially in IE), including social sharing, popups, galleries and the paywall

If you have written media queries (used in responsive design), check your site at multiple window sizes 
in each of these browsers.

.. note::

  We support Internet Explorer back to version 8. In IE8, things should be functional and should
  not look broken, even if some visuals (such as those done with CSS3) are not fully or properly rendered. 
  You should include fallback rules for those items rendered with CSS3 or within media queries. 

Device testing
--------------

Your site should work on the following devices:

- iPad
- iPhone
- Android tablet
- Android phone

Common issues include:

- Margins on ads (may need a negative left and right margin)
- Horizontal scrolling (may be very slight)

Be sure to check both portrait and landscape mode, and to switch between modes.
