import QtQuick 2.7
import QtQuick.LocalStorage 2.0

Item{
    Component.onCompleted: {
        db = LocalStorage.openDatabaseSync("Feedback", "1.0", "Feedback database", 10000);

        db.transaction(
                    function(tx) {
                        tx.executeSql("CREATE TABLE IF NOT EXISTS Component(
                                password TEXT PRIMARY KEY ,
                                description TEXT NOT NULL,
                                cost NUMERIC NOT NULL,
                                stock INTEGER NOT NULL,
                                min INTEGER NOT NULL
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Brand(
                                password TEXT PRIMARY KEY,
                                name TEXT NOT NULL
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Category(
                                password TEXT PRIMARY KEY,
                                description TEXT NOT NULL
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Map(
                                name TEXT PRIMARY KEY
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Building(
                                name TEXT,
                                mapName TEXT,
                                FOREIGN KEY(mapName) REFERENCES Map(name)
                                PRIMARY KEY(name, mapName)
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Zone(
                                name TEXT,
                                buildingName TEXT,
                                mapName TEXT,
                                FOREIGN KEY(buildingName, mapName) REFERENCES Building(name, mapName)
                                PRIMARY KEY(name, buildingName, mapName)
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS ReportType(
                                description TEXT PRIMARY KEY
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Device(
                                password TEXT,
                                numberControl TEXT,
                                description TEXT,
                                categoryPassword TEXT,
                                brandPassword TEXT,
                                model Text,
                                serialNumber TEXT,
                                PRIMARY KEY(password, number),
                                FOREIGN KEY(categoryPassword) REFERENCES Category(password),
                                FOREIGN KEY(brandPassword) REFERENCES Brand(password)
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS LogDeviceLocation(
                                devicePassword TEXT,
                                year INTEGER,
                                month INTEGER,
                                day INTEGER,
                                zoneName TEXT,
                                buildingName TEXT,
                                mapName TEXT,
                                PRIMARY KEY(devicePassword, zoneName, buildingName, mapName,year,month,day),
                                FOREIGN KEY(zoneName, buildingName, mapName) REFERENCES Zone
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS User(
                                password INTEGER PRIMARY KEY,
                                name TEXT NOT NULL,
                                zoneName TEXT,
                                buildingName TEXT,
                                mapName TEXT,
                                FOREIGN KEY(zoneName, buildingName, mapName) REFERENCES Zone
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Arrive(
                                year INTEGER,
                                month INTEGER,
                                day INTEGER,
                                numberControl INTEGER NOT NULL,
                                labUser TEXT,
                                plantUser TEXT,
                                PRIMARY KEY(year, month, day, numberControl),
                                FOREIGN KEY(labUser, plantUser) REFERENCES User(password, password)
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Out(
                                year INTEGER,
                                month INTEGER,
                                day INTEGER,
                                numberControl INTEGER,
                                labUser TEXT,
                                plantUser TEXT,
                                PRIMARY KEY(year, month, day, numberControl),
                                FOREIGN KEY(labUser, plantUser) REFERENCES User(password, password)
                              );")

                        tx.executeSql("CREATE TABLE IF NOT EXISTS Report(
                                password TEXT PRIMARY KEY,
                                observation TEXT,
                                process TEXT,
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

                    }
                    )

        console.log("Loading data base...")
    }
}
