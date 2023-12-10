// mongo-init.js
 
db.createUser(
        {
            user: "captura",
            pwd: "captura123",
            roles: [
                {
                    role: "readWrite",
                    db: "mobileforms"
                }
            ]
        }
);
