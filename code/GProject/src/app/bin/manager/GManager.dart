//===============================================
import 'GInclude.dart';
//===============================================
class GManager {
    //===============================================
    GManager._privateConstructor();
    static final GManager m_instance = GManager._privateConstructor();
    //===============================================
    factory GManager() {
        return m_instance;
    }
    //===============================================
    void listPrint(List dataIn) {
        for(var i = 0; i < dataIn.length; i++) {
            stdout.write(sprintf("%-2d : %s\n", [i, dataIn[i]]));
        }
    }
    //===============================================
}
//===============================================
