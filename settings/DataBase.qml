import QtQuick 2.7
import QtQuick.LocalStorage 2.0

Item{
    Component.onCompleted: {
        db = LocalStorage.openDatabaseSync("Feedback", "1.0", "Feedback database", 10000);

        db.transaction(
                    function(tx) {
                        tx.executeSql("CREATE TABLE IF NOT EXISTS Component(
                                password TEXT NOT NULL PRIMARY KEY ,
                                description TEXT NOT NULL,
                                cost NUMERIC NOT NULL,
                                stock INTEGER NOT NULL,
                                min INTEGER NOT NULL
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Brand(
                                password TEXT NOT NULL PRIMARY KEY,
                                name TEXT NOT NULL
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Category(
                                password TEXT NOT NULL PRIMARY KEY,
                                description TEXT NOT NULL
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Map(
                                name TEXT NOT NULL PRIMARY KEY
                             );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Building(
                                      name TEXT NOT NULL,
                                      mapName TEXT NOT NULL,
                                      FOREIGN KEY(mapName) REFERENCES Map(name)
                                      PRIMARY KEY(name, mapName)
                                    );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Zone(
                                      name TEXT NOT NULL,
                                      buildingName TEXT NOT NULL,
                                      mapName TEXT NOT NULL,
                                      FOREIGN KEY(buildingName, mapName) REFERENCES Building(name, mapName)
                                      PRIMARY KEY(name, buildingName, mapName)
                                    );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS ReportType(
                                description TEXT NOT NULL PRIMARY KEY
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS DeviceType(
                                description TEXT NOT NULL PRIMARY KEY
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Device(
                                      password TEXT NOT NULL PRIMARY KEY,
                                      description TEXT NOT NULL,
                                      stock INTEGER NOT NULL,
                                      brandName TEXT,
                                      deviceTypeDescription TEXT,
                                      zoneName TEXT,
                                      buildingName TEXT,
                                      FOREIGN KEY(brandName) REFERENCES Brand(name),
                                      FOREIGN KEY(deviceTypeDescription) REFERENCES DeviceType(description)
                                      FOREIGN KEY(zoneName) REFERENCES Zone(name)
                                      FOREIGN KEY(buildingName) REFERENCES Building(name)
                                    );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS User(
                                password INTEGER NOT NULL PRIMARY KEY,
                                name TEXT NOT NULL,
                                zoneName TEXT NOT NULL,
                                buildingName TEXT NOT NULL,
                                mapName TEXT NOT NULL,
                                FOREIGN KEY(zoneName, buildingName, mapName) REFERENCES Zone
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS BuildingZone(
                                buildingName TEXT,
                                zoneName TEXT,
                                PRIMARY KEY(buildingName, zoneName)
                                FOREIGN KEY(buildingName) REFERENCES Building(name),
                                FOREIGN KEY(zoneName) REFERENCES Zone(name)

                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Arrive(
                                year INTEGER NOT NULL,
                                month INTEGER NOT NULL,
                                day INTEGER NOT NULL,
                                numberControl INTEGER NOT NULL,
                                labUser TEXT,
                                plantUser TEXT,
                                PRIMARY KEY(year, month, day, numberControl),
                                FOREIGN KEY(labUser, plantUser) REFERENCES User(password, password)
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Out(
                                year INTEGER NOT NULL,
                                month INTEGER NOT NULL,
                                day INTEGER NOT NULL,
                                numberControl INTEGER NOT NULL,
                                labUser TEXT,
                                plantUser TEXT,
                                PRIMARY KEY(year, month, day, numberControl),
                                FOREIGN KEY(labUser, plantUser) REFERENCES User(password, password)
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Report(
                                password TEXT PRIMARY KEY NOT NULL,
                                observation TEXT NOT NULL,
                                process TEXT NOT NULL,
                                reportTypeDescription TEXT,
                                arriveDate TEXT,
                                outDate TEXT,
                                devicePassword TEXT,
                                FOREIGN KEY(reportTypeDescription) REFERENCES ReportType(description),
                                FOREIGN KEY(arriveDate) REFERENCES Arrive(dateArrive),
                                FOREIGN KEY(outDate) REFERENCES Out(dataOut),
                                FOREIGN KEY(devicePassword) REFERENCES Device(password)
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS DoBy(
                                reportPassword TEXT,
                                userPassword TEXT,
                                PRIMARY KEY(reportPassword, userPassword),
                                FOREIGN KEY(reportPassword) REFERENCES Report(password),
                                FOREIGN KEY(userPassword) REFERENCES User(password)
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS UsedComponent(
                                reportPassword TEXT,
                                componentPassword TEXT,
                                quantity INTEGER NOT NULL,
                                PRIMARY KEY(reportPassword, componentPassword),
                                FOREIGN KEY(reportPassword) REFERENCES Report(password),
                                FOREIGN KEY(componentPassword) REFERENCES Component(password)
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS UsedDevice(
                                reportPassword TEXT,
                                devicePassword TEXT,
                                quantity INTEGER NOT NULL,
                                PRIMARY KEY(reportPassword, devicePassword),
                                FOREIGN KEY(reportPassword) REFERENCES Report(password),
                                FOREIGN KEY(devicePassword) REFERENCES Device(password)
                              );")

                        //tx.executeSql("PRAGMA foreign_keys = ON;")
                    }
                    )

        console.log("Loading data base...")
    }

}
