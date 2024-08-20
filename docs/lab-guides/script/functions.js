/**
 * Recreate a link with a new hostname. This allows something like this:
 *   <a href="http://127.0.0.1:8080/">127.0.0.1:8080</a>
 * to become this:
 *   <a href="http://192.168.1.100:8080/">192.168.1.100:8080</a>
 * where the 192.168.1.100 part comes from what JavaScript determines is
 * the host portion of the URL, and http, 8080, and / all come from
 * function parameters.
 * This is useful for web server hosts with changing IP addresses. 
 * @param {string} id 
 * @param {string} protocol 
 * @param {integer} port 
 * @param {string} path 
 */
function updateLink(id, protocol, port, path) {
    path = (path) ? path : "/"
    host = (window.location.host) ? window.location.host : "localhost"
    let url = protocol + '://' + host + ':' + port + path
    console.log("New URL for", id, "is", url)
    document.getElementById(id).href = url
    document.getElementById(id).innerHTML = url
}
