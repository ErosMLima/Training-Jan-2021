const { Customer, validateCustomer } = require('../models/customer.model');
const Joi = require('joi');
const bcrypt = require('bcrypt');
const _ = require('lodash');

class CustomerDomain {

    // add customer
    async addCustomer(req, res) {

        const { error } = validateCustomer(req.body);

        if (error) {
            return res.send(error.details[0].message);
        }

        try {

            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(req.body.password, salt);

            const customer = new Customer({
                customerName: req.body.customerName,
                email: req.body.email,
                contactNumber: req.body.contactNumber,
                dob: req.body.dob,
                gender: req.body.gender,
                password: hashedPassword,
                address: {
                    addressLine1: req.body.address.addressLine1,
                    addressLine2: req.body.address.addressLine2,
                    pincode: req.body.address.pincode,
                    city: req.body.address.city
                }
            });

            await customer.save();

            res.send(_.pick(customer, ['_id', 'customerName', 'email', 'contactNumber', 'dob', 'gender', 'address']));
        }
        catch (e) {
            res.status(500).send(e);
        }
    }

    // get all customers
    async getAllCustomers(req, res, next) {
        try {
            const customers = await Customer.find();
            res.send(customers);
        }
        catch (e) {
            next(e);
        }

    }

    // get customer by id
    async getCustomerById(req, res) {

        const customerId = req.params.customerId;

        const { error } = Joi.validate(customerId, Joi.objectId().required());

        if (error) {
            return res.status(404).send(error.details[0].message);
        }

        const customer = await Customer.findById(customerId);

        if (!customer) {
            return res.status(500).send('Customer not found');
        }

        res.send(_.pick(customer, ['_id', 'customerName', 'email', 'contactNumber', 'dob', 'gender', 'address']));
    }

    // update customer
    async updateCustomer(req, res) {

        const customerId = req.params.customerId;

        var { error } = Joi.validate(customerId, Joi.objectId().required());

        if (error) {
            return res.status(404).send(error.details[0].message);
        }

        var { error } = validateCustomer(req.body);

        if (error) {
            return res.send(error.details[0].message);
        }

        const customer = await Customer.findById(customerId);

        if (!customer) {
            return res.status(500).send('Customer not found');
        }

        try {

            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(req.body.password, salt);

            customer.set({
                customerName: req.body.customerName,
                email: req.body.email,
                contactNumber: req.body.contactNumber,
                dob: req.body.dob,
                gender: req.body.gender,
                password: hashedPassword,
                address: {
                    addressLine1: req.body.address.addressLine1,
                    addressLine2: req.body.address.addressLine2,
                    pincode: req.body.address.pincode,
                    city: req.body.address.city
                }
            });

            await customer.save();

            res.send(_.pick(customer, ['_id', 'customerName', 'email', 'contactNumber', 'dob', 'gender', 'address']));
        }
        catch (e) {
            res.status(500).send(e);
        }
    }

    // delete customer
    async deleteCustomer(req, res) {

        const customerId = req.params.customerId;

        var { error } = Joi.validate(customerId, Joi.objectId().required());

        if (error) {
            return res.status(404).send(error.details[0].message);
        }

        const result = await Customer.deleteOne({ _id: customerId });

        if (result.deletedCount == 0) {
            return res.status(404).send('Customer not found');
        }
        else {
            return res.send('Customer deleted successfully');
        }

    }

}

module.exports = CustomerDomain;