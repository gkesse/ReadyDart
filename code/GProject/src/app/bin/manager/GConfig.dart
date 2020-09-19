//===============================================
import 'GSQLiteMgr.dart';
//===============================================
class GConfig {
    //===============================================
    static final GConfig m_instance = GConfig._privateConstructor();
    //===============================================
    var m_dataMap = {};
    //===============================================
    GConfig._privateConstructor() {

    }
    //===============================================
    factory GConfig() {
        return m_instance;
    }
    //===============================================
    void setData(String keyIn, String valueIn) {
        m_dataMap[keyIn] = valueIn;
    }
    //===============================================
    String getData(String keyIn) {
        return m_dataMap[keyIn];
    }
    //===============================================
    void saveData(String keyIn, {String valueIn = ""}) {
        if(valueIn == "") valueIn = m_dataMap[keyIn];
        if(checkData(keyIn) == 0) {insertData(keyIn, valueIn:valueIn);}
        else {updateData(keyIn, valueIn:valueIn);}
    }
    //===============================================
    String loadData(String keyIn) {
        var lQuery = '''
        select CONFIG_VALUE
        from CONFIG_DATA
        where CONFIG_KEY="${keyIn}"
        ''';
        var lValue = GSQLiteMgr().queryValue(lQuery);
        m_dataMap[keyIn] = lValue;
        return lValue;
    }
    //===============================================
    int checkData(String keyIn) {
        var lQuery = '''
        select count(*) iCOUNT
        from CONFIG_DATA
        where CONFIG_KEY="${keyIn}"
        ''';
        var lCount = GSQLiteMgr().queryValue(lQuery);
        return int.parse(lCount);
    }
    //===============================================
    void insertData(String keyIn, {String valueIn = ""}) {
        if(valueIn == "") valueIn = m_dataMap[keyIn];
        var lQuery = '''
        insert into CONFIG_DATA (CONFIG_KEY, CONFIG_VALUE)
        values ("${keyIn}", "${valueIn}")
        ''';
        GSQLiteMgr().queryWrite(lQuery);
    }
    //===============================================
    void updateData(String keyIn, {String valueIn = ""}) {
        if(valueIn == "") valueIn = m_dataMap[keyIn];
        var lQuery = '''
        update CONFIG_DATA 
        set CONFIG_VALUE="${valueIn}"
        where CONFIG_KEY="${keyIn}"
        ''';
        GSQLiteMgr().queryWrite(lQuery);
    }
    //===============================================
}
//===============================================
