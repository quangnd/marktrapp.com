/**
 * Javascript for the Wormtrails banner.
 */

function updateBanner(content, color) {
    var div = document.getElementById('wormtrails-banner');
    div.style.backgroundColor = color;
    div.innerHTML = content;
}
