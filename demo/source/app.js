const express = require("express");
const app = express();

app.get("/user", (req, res) => {
    const user = req.query.name;
    res.send("<h1>" + user + "</h1>");
});

eval("console.log('danger')");
