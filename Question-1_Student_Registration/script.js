const form = document.getElementById("registrationForm");

form.addEventListener("submit", function(event) {
    event.preventDefault();

    // Reset previous errors
    document.querySelectorAll(".error").forEach(function(error) {
        error.textContent = "";
    });

    const successBox = document.getElementById("successMessage");
    successBox.textContent = "";
    successBox.classList.remove("show");

    let valid = true;

    const name = document.getElementById("name").value.trim();
    const roll = document.getElementById("roll").value.trim();
    const email = document.getElementById("email").value.trim();
    const course = document.getElementById("course").value;
    const password = document.getElementById("password").value;
    const fileInput = document.getElementById("file");
    const file = fileInput.files[0];

    // Name validation
    if (name === "") {
        document.getElementById("nameError").textContent = "Full name is required";
        valid = false;
    }

    // Roll number validation
    if (roll === "") {
        document.getElementById("rollError").textContent = "Roll number is required";
        valid = false;
    }

    // Email validation
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (email === "") {
        document.getElementById("emailError").textContent = "Email address is required";
        valid = false;
    } else if (!emailPattern.test(email)) {
        document.getElementById("emailError").textContent = "Please enter a valid email address";
        valid = false;
    }

    // Course selection validation
    if (course === "") {
        document.getElementById("courseError").textContent = "Please select a degree course";
        valid = false;
    }

    // Password strength validation (min 8 chars, uppercase, lowercase, digit, special char)
    const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;
    if (password === "") {
        document.getElementById("passwordError").textContent = "Password is required";
        valid = false;
    } else if (!passwordPattern.test(password)) {
        document.getElementById("passwordError").textContent =
            "Password must be 8+ characters with uppercase, lowercase, number and symbol (@$!%*?&)";
        valid = false;
    }

    // Document file upload validation
    if (!file) {
        document.getElementById("fileError").textContent = "Please upload a document (PDF, JPG, or PNG)";
        valid = false;
    } else if (file.size > 2 * 1024 * 1024) {
        document.getElementById("fileError").textContent = "File size must not exceed 2 MB";
        valid = false;
    } else if (!/\.(pdf|jpg|jpeg|png)$/i.test(file.name)) {
        document.getElementById("fileError").textContent = "Only PDF, JPG, JPEG, and PNG files are accepted";
        valid = false;
    }

    if (valid) {
        successBox.textContent = "Registration form validated successfully!";
        successBox.classList.add("show");
        form.reset();
    }
});
