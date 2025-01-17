const TrainModel = require("../models/trains.model");
const StationModel = require("../models/stations.model");
const RouteModel = require("../models/routes.model");
const StatusModel = require("../models/status.model");
const PassengerModel = require("../models/passengers.model");

class TrainDomain {
  //To get all trains
  async getAllTrains(req, res) {
    const trains = await TrainModel.find();
    res.send(trains);
  }
  //To get train
  async getTrain(req, res) {
    let id = req.params.trainId;
    const train = await TrainModel.findById(id);
    if (train) {
      res.send(train);
    } else {
      res.status(404).send("Status Not Found");
    }
  }
  //To insert train
  async insertTrain(req, res) {
    //getting user input
    let data = req.body;

    const train = new TrainModel(data);
    const { error, value } = train.joiValidate(data);
    if (error) {
      res.status(400).send(error.details[0].message);
    } else {
      try {
        const result = await train.save();
        res.send(result);
      } catch (e) {
        res.send(e.message);
      }
    }
  }
  //To delete a train
  async deleteTrain(req, res) {
    let id = req.params.trainId;
    const train = await TrainModel.findByIdAndDelete(id);
    if (train) {
      res.send("Train Record Deleted Successfully");
    } else {
      res.status(404).send("Train Not Found");
    }
  }
  //To update a train
  async updateTrain(req, res) {
    //getting user input
    let data = req.body;
    let id = req.params.userId;

    const train = new TrainModel(data);
    const { error, value } = train.joiValidate(data);
    if (error) {
      res.status(400).send(error.details[0].message);
    } else {
      try {
        const result = await TrainModel.findByIdAndUpdate(
          id,
          {
            $set: data,
          },
          { new: true }
        );
        if (result) {
          res.send(result);
        } else {
          res.status(404).send("Train Not Found");
        }
      } catch (e) {
        res.send(e.message);
      }
    }
  }
  //To search trains
  async searchTrains(req, res) {
    let journeyFrom = req.query.from.toUpperCase();
    let journeyTo = req.query.to.toUpperCase();

    const s1 = await StationModel.find({ station_name: journeyFrom });
    const s2 = await StationModel.find({ station_name: journeyTo });

    if (s1.length != 0 && s2.length != 0) {
      let from = s1[0];
      let to = s2[0];

      const train1 = await RouteModel.find({ station: from._id }).select(
        "-_id"
      );
      const train2 = await RouteModel.find({ station: to._id }).select("-_id");
      let trains = [];
      for (let i = 0; i < train1.length; i++) {
        for (let j = 0; j < train2.length; j++) {
          let a = train1[i].train.toString();
          let b = train2[j].train.toString();
          if (a == b) {
            let distance = train2[j].stop_no - train1[i].stop_no;
            let trainId = train1[i].train;
            if (distance > 0) {
              let t_name = await TrainModel.findById(trainId);
              let c = await StatusModel.find({ train: trainId }).select(
                "-train"
              );
              let trainObj = {
                train: t_name,
                distance: distance,
                from: {
                  name: journeyFrom,
                  arr_time: train1[i].arr_time,
                  depart_time: train1[i].depart_time,
                },
                to: {
                  name: journeyTo,
                  arr_time: train2[j].arr_time,
                  depart_time: train2[j].depart_time,
                },
                travel_class: c,
              };
              trains.push(trainObj);
            }
          }
        }
      }
      if (trains.length > 0) {
        res.send(trains);
      } else {
        res.send(`Train Not Available For ${journeyFrom} to ${journeyTo}`);
      }
    } else {
      res.send(`Train Not Available For ${journeyFrom} to ${journeyTo}`);
    }
  }
  //To book train
  async bookTrain(req, res) {
    let cId = req.params.classId;

    const status = await StatusModel.findById(cId);
    let seat = status.avail_seat;
    let booked = status.booked_seat;
    if (seat > 0) {
      seat = seat - 1;
      booked = booked + 1;
      const result = await StatusModel.findByIdAndUpdate(
        cId,
        { $set: { avail_seat: seat, booked_seat: booked } },
        { new: true }
      );
      res.send(result);
    } else {
      res.send("Train Is Full");
    }
  }
  //To get passengers
  async getPassengers(req, res) {
    let id = req.params.trainId;

    const passengers = await PassengerModel.find({ train: id })
      .populate("train", "train_name")
      .populate("from", "station_name")
      .populate("to", "station_name")
      .populate("travel_class", "class_type");
    if (passengers.length > 0) {
      res.send(passengers);
    } else {
      res.status(404).send("No Passengers");
    }
  }
}

module.exports = TrainDomain;
