//===============================================
import 'GInclude.dart';
//===============================================
class GSQLiteMgr {
    //===============================================
    GSQLiteMgr._privateConstructor();
    static final GSQLiteMgr m_instance = GSQLiteMgr._privateConstructor();
    //===============================================
    var m_dbPath;
    var m_db;
    //===============================================
    factory GSQLiteMgr() {
        if(Platform.isWindows) {
            m_instance.dbPathSet('C:\\Users\\Admin\\Downloads\\Programs\\ReadyBin\\win\\.config.dat');
        }
        return m_instance;
    }
    //===============================================
    void dbPathSet(String dbPathIn) {
        m_dbPath = dbPathIn;
    }
    //===============================================
    void versionShow() {
        var lVersion = sqlite3.version;
        stdout.write(sprintf("Version :\n%s\n", [lVersion]));
    }
    //===============================================
    void databaseOpen() {
        m_db = sqlite3.open(m_dbPath);
    }
    //===============================================
    void queryWrite(String sqlIn) {
        databaseOpen();
        m_db.execute(sqlIn);
        databaseClose();
    }
    //===============================================
    void queryShow(String sqlIn, int onHeaderIn) {
        databaseOpen();
        ResultSet lResult = m_db.select(sqlIn);
        for (Row lRow in lResult) {
            if(onHeaderIn == 1) {
                onHeaderIn = 0;
                var lData = lRow.keys.toList();
                for(var i = 0; i < lData.length; i++) {
                    if(i != 0) {stdout.write(sprintf(" | ", []));}
                    stdout.write(sprintf("%-*s", [20, lData[i]]));
                }
                stdout.write(sprintf("\n", []));
            }
            var lData = lRow.values.toList();
            for(var i = 0; i < lData.length; i++) {
                if(i != 0) {stdout.write(sprintf(" | ", []));}
                stdout.write(sprintf("%-*s", [20, lData[i]]));
            }
            stdout.write(sprintf("\n", []));
        }
        databaseClose();
    }
    //===============================================
    String queryValue(String sqlIn) {
        databaseOpen();
        ResultSet lResult = m_db.select(sqlIn);
        databaseClose();
        var lData = "";
        for (Row lRow in lResult) {
            var lValues = lRow.values.toList();
            lData = lValues[0].toString();
            break;
        }
        return lData;
    }
    //===============================================
    List queryRow(String sqlIn) {
        databaseOpen();
        ResultSet lResult = m_db.select(sqlIn);
        databaseClose();
        var lData = "";
        var lDataMap = [];
        for (Row lRow in lResult) {
            var lValues = lRow.values.toList();
            for(var i = 0; i < lValues.length; i++) {
                lData = lValues[i].toString();
                lDataMap.add(lData);
            }
            break;
        }
        return lDataMap;
    }
    //===============================================
    List queryCol(String sqlIn) {
        databaseOpen();
        ResultSet lResult = m_db.select(sqlIn);
        databaseClose();
        var lData = "";
        var lDataMap = [];
        for (Row lRow in lResult) {
            var lValues = lRow.values.toList();
            lData = lValues[0].toString();
            lDataMap.add(lData);
        }
        return lDataMap;
    }
    //===============================================
    void databaseClose() {
        m_db.dispose();
    }
    //===============================================
}
//===============================================
