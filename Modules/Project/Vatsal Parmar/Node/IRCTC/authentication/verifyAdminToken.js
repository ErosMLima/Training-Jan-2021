let jwt = require("jsonwebtoken");
const config = require("./global.config");
function verifyAdminToken(req, res, next) {
  //getting token from headers
  var token = req.headers["x-access-token"];
  //console.log(token);
  // verifying token
  jwt.verify(
    token,
    config.secretKey,
    {
      algorithm: config.algorithm,
    },
    function (err, decoded) {
      if (err) {
        let errordata = {
          message: err.message,
          expiredAt: err.expiredAt,
        };
        console.log(errordata);
        return res.status(401).json({
          message: "Unauthorized Access",
        });
      }
      req.decoded = decoded;
      console.log(decoded);
      if (decoded.email == "admin@irctc.com" && decoded.password == "admin") {
        next();
      } else {
        return res.status(401).json({
          message: "Unauthorized Access",
        });
      }
    }
  );
}

module.exports = verifyAdminToken;
