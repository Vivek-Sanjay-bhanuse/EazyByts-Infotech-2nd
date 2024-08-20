document.getElementById('registerForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const email = document.getElementById('email').value;

    fetch('/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ username, password, email })
    })
    .then(response => {
        if (response.ok && response.redirected) {
            window.location.href = response.url;
        } else {
            response.text().then(text => alert(text || 'Registration failed'));
        }
    })
    .catch(error => console.error('Error:', error));
});
