// Get references to DOM elements
const signInBtn = document.getElementById('signInBtn');
const signUpBtn = document.getElementById('signUpBtn');
const signInForm = document.getElementById('signInForm');
const signUpForm = document.getElementById('signUpForm');

// Toggle between Sign In and Sign Up forms
signInBtn.addEventListener('click', () => {
  signInForm.classList.add('active');
  signUpForm.classList.remove('active');
  signInBtn.classList.add('active');
  signUpBtn.classList.remove('active');
});

signUpBtn.addEventListener('click', () => {
  signUpForm.classList.add('active');
  signInForm.classList.remove('active');
  signUpBtn.classList.add('active');
  signInBtn.classList.remove('active');
});

// Google Sign-In callback function
function handleCredentialResponse(response) {
  const googleToken = response.credential;

  // Send the token to your backend for verification and user authentication
  fetch('http://localhost:8080/CineRealm/verify-google-token', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ token: googleToken }),
  })
    .then((res) => res.json())
    .then((data) => {
      if (data.message === 'User verified') {
        window.location.href = '/dashboard'; // Redirect to dashboard after successful login
      } else {
        alert('Verification failed. Please try again.');
      }
    })
    .catch((error) => console.error('Error:', error));
}

// Initialize Google Sign-In button
window.onload = () => {
  google.accounts.id.initialize({
    client_id: "421031032894-s4v8meueteefcfnjo71u2e3buups5h0p.apps.googleusercontent.com", // Your Google Client ID
    callback: handleCredentialResponse,
  });

  // Render the Google Sign-In button
  google.accounts.id.renderButton(
    document.getElementById("g_id_signin"),
    {
      theme: "outline",
      size: "large",
      text: "continue_with",
    }
  );
};
