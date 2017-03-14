CREATE TABLE Component(
  password TEXT PRIMARY KEY,
  description TEXT,
  cost NUMERIC,
  stock INTEGER,
  min INTEGER
);

CREATE TABLE Brand(
  name TEXT PRIMARY KEY
);

CREATE TABLE Building(
  name TEXT PRIMARY KEY
);

CREATE TABLE Zone(
  name TEXT PRIMARY KEY
);

CREATE TABLE TypeUser(
  description TEXT PRIMARY KEY
);

CREATE TABLE TypeReport(
  description TEXT PRIMARY KEY
);

CREATE TABLE TypeDevice(
  description TEXT PRIMARY KEY
);

CREATE TABLE Device(
  password TEXT PRIMARY KEY,
  description TEXT,
  stock INTEGER,
  brandName TEXT,
  typeDeviceDescription TEXT,
  buildingZoneBuildingName TEXT,
  buildingZoneZoneName TEXT,
  FOREIGN KEY(brandName) REFERENCES Brand(name),
  FOREIGN KEY(typeDeviceDescription) REFERENCES TypeDevice(description)
  FOREIGN KEY(buildingZoneBuildingName) REFERENCES BuildingZone(buildingName)
  FOREIGN KEY(buildingZoneZoneName) REFERENCES BuildingZone(zoneName)
);

CREATE TABLE User(
  password INTEGER PRIMARY KEY,
  name TEXT,
  typeUserDescription TEXT,
  FOREIGN KEY(typeUserDescription) REFERENCES TypeUser(description)
);

CREATE TABLE BuildingZone(
  buildingName TEXT,
  zoneName TEXT,
  PRIMARY KEY(buildingName, zoneName)
  FOREIGN KEY(buildingName) REFERENCES Building(name),
  FOREIGN KEY(zoneName) REFERENCES Zone(name)

);

CREATE TABLE Arrive(
  year INTEGER,
  month INTEGER,
  day INTEGER,
  numberControl INTEGER,
  labUser TEXT,
  plantUser TEXT,
  PRIMARY KEY(year, month, day, numberControl),
  FOREIGN KEY(labUser, plantUser) REFERENCES User(password, password)
);

CREATE TABLE Out(
  year INTEGER,
  month INTEGER,
  day INTEGER,
  numberControl INTEGER,
  labUser TEXT,
  plantUser TEXT,
  PRIMARY KEY(year, month, day, numberControl),
  FOREIGN KEY(labUser, plantUser) REFERENCES User(password, password)
);

CREATE TABLE Report(
  password TEXT PRIMARY KEY,
  observation TEXT,
  process TEXT,
  typeReportDescription TEXT,
  arriveDate TEXT,
  outDate TEXT,
  devicePassword TEXT,
  FOREIGN KEY(typeReportDescription) REFERENCES TypeReport(description),
  FOREIGN KEY(arriveDate) REFERENCES Arrive(dateArrive),
  FOREIGN KEY(outDate) REFERENCES Out(dataOut),
  FOREIGN KEY(devicePassword) REFERENCES Device(password)
);

CREATE TABLE DoBy(
  reportPassword TEXT,
  userPassword TEXT,
  PRIMARY KEY(reportPassword, userPassword),
  FOREIGN KEY(reportPassword) REFERENCES Report(password),
  FOREIGN KEY(userPassword) REFERENCES User(password)
);

CREATE TABLE UsedComponent(
  reportPassword TEXT,
  componentPassword TEXT,
  quantity INTEGER,
  PRIMARY KEY(reportPassword, componentPassword),
  FOREIGN KEY(reportPassword) REFERENCES Report(password),
  FOREIGN KEY(componentPassword) REFERENCES Component(password)
);

CREATE TABLE UsedDevice(
  reportPassword TEXT,
  devicePassword TEXT,
  quantity INTEGER,
  PRIMARY KEY(reportPassword, devicePassword),
  FOREIGN KEY(reportPassword) REFERENCES Report(password),
  FOREIGN KEY(devicePassword) REFERENCES Device(password)
);
