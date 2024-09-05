// mongo-init.js
// Create a user named "captura" with appropriate roles
db.createUser({
    user: "captura",
    pwd: "captura123", // Remember to use a password hashing mechanism!
    roles: [
        {
            role: "readWrite",
            db: "mobileforms"
        }
    ]
});

// Insert a user document into the "user" collection (optional)
db.dummy.insert({
    name: "captura",
    desc: "Form server"
});

