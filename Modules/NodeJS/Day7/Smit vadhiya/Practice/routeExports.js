const express = require('express')
const app = express()

const employee = require('./router/employee')
const customer = require('./router/customer')

app.use(express.json())

app.use('/employee',employee)
app.use('/customer',customer)

app.listen(3000, () => {
    console.log("3000 is listning....");
})

 app.get('/',(req,res) => {
    res.send("hello root");
})
