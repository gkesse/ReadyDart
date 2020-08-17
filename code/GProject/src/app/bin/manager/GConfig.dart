//===============================================
class GConfig {
    //===============================================
    GConfig._privateConstructor();
    static final GConfig m_instance = GConfig._privateConstructor();
    //===============================================
    var m_dataMap = {};
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
}
//===============================================
