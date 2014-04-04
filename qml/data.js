
.import QtQuick.LocalStorage 2.0 as LS

// Code derived from 'Noto' by leszek -- Thanks :)

// First, let's create a short helper function to get the database connection
function getDatabase() {
    return LS.LocalStorage.openDatabaseSync("UpNext", "1.0", "StorageDatabase", 10000);
}


// At the start of the application, we can initialize the tables we need if they haven't been created yet
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS channels(uid INTEGER UNIQUE, txt TEXT)');
                    tx.executeSql('CREATE TABLE IF NOT EXISTS cover(uid INTEGER UNIQUE, txt TEXT)');
                });
}

// This function is used to update channel settings
function setNote(uid,txt) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO channels VALUES (?,?);', [uid,txt]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            console.log ("Saved to database");
        } else {
            res = "Error";
            console.log ("Error saving to database");
        }
    }
    );
    return res;
}

// This function is used to update cover channel settings
function setCover(uid,txt) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO cover VALUES (?,?);', [uid,txt]);
        if (rs.rowsAffected > 0) {
            res = "OK";
            console.log ("Saved to database");
        } else {
            res = "Error";
            console.log ("Error saving to database");
        }
    }
    );
    return res;
}


// This function is used to retrieve channel settings form the database
function getText(uid) {
    var db = getDatabase();
    var notesText="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT txt FROM channels WHERE uid=?;', [uid]);
        if (rs.rows.length > 0) {
            notesText = rs.rows.item(0).txt
        } else {
            notesText = "Unknown"
        }
    })
    return notesText
}

// This function is used to retrieve cover channel settings form the database
function getCover(uid) {
    var db = getDatabase();
    var notesText="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT txt FROM cover WHERE uid=?;', [uid]);
        if (rs.rows.length > 0) {
            notesText = rs.rows.item(0).txt
        } else {
            notesText = "Unknown"
        }
    })
    return notesText
}
