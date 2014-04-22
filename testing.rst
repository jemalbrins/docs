Browser & device testing
========================

Prior to publishing a new project or major changes to an existing project, make sure your changes
look good on the supported browsers and devices below. Test these on a staging server
before publishing to production.

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

A note on Internet Explorer 8
-----------------------------

We support Internet Explorer back to version 8. In IE8, things should be functional and should
not look broken, even if some visuals (such as those done with CSS3) are not fully or properly rendered. 
You should include fallback rules for those items rendered with CSS3 or within media queries. 
(A particularly common issue is logo disappearing in Bootstrap's navbar.)

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

Be sure to check both portrait and landscape mode.
