import 'GInclude.dart';
import 'GSQLiteMgr.dart';
import 'GConfig.dart';
import 'GProcess.dart';
import 'GManager.dart';
//===============================================
class GSQLite {
    //===============================================
    GSQLite._privateConstructor();
    static final GSQLite m_instance = GSQLite._privateConstructor();
    //===============================================
    var G_STATE;
    //===============================================
    factory GSQLite() {
        return m_instance;
    }
    //===============================================
    void run(List<String> args) {
        G_STATE = "S_INIT";
        while(true) { 
            if(G_STATE == "S_ADMIN") {run_ADMIN(args);}
            else if(G_STATE == "S_INIT") {run_INIT(args);}
            else if(G_STATE == "S_METHOD") {run_METHOD(args);}
            else if(G_STATE == "S_CHOICE") {run_CHOICE(args);}
            //
            else if(G_STATE == "S_VERSION_SHOW") {run_VERSION_SHOW(args);}
            else if(G_STATE == "S_CONFIG_SHOW") {run_CONFIG_SHOW(args);}
            //
            else if(G_STATE == "S_CONFIG_GET_CONFIG_KEY") {run_CONFIG_GET_CONFIG_KEY(args);}
            else if(G_STATE == "S_CONFIG_GET") {run_CONFIG_GET(args);}
            //
            else if(G_STATE == "S_CONFIG_ROW_CONFIG_KEY") {run_CONFIG_ROW_CONFIG_KEY(args);}
            else if(G_STATE == "S_CONFIG_ROW") {run_CONFIG_ROW(args);}
            //
            else if(G_STATE == "S_CONFIG_COL") {run_CONFIG_COL(args);}
            //
            else if(G_STATE == "S_SAVE") {run_SAVE(args);}
            else if(G_STATE == "S_LOAD") {run_LOAD(args);}
            else if(G_STATE == "S_QUIT") {run_QUIT(args);}
            else break; 
        } 
    }
    //===============================================
    void run_ADMIN(List<String> args) {
        GProcess().run(args);
        G_STATE = "S_END";
    }
    //===============================================
    void run_INIT(List<String> args) {
        stdout.write(sprintf("DART_SQLITE !!!\n", []));
        stdout.write(sprintf("\t%-2s : %s\n", ["-q", "quitter l'application"]));
        stdout.write(sprintf("\t%-2s : %s\n", ["-i", "reinitialiser l'application"]));
        stdout.write(sprintf("\t%-2s : %s\n", ["-a", "redemarrer l'application"]));
        stdout.write(sprintf("\t%-2s : %s\n", ["-v", "valider les configurations"]));
        stdout.write(sprintf("\n", []));
        G_STATE = "S_LOAD";
    }
    //===============================================
    void run_METHOD(List<String> args) {
        stdout.write(sprintf("DART_SQLITE :\n", []));
        stdout.write(sprintf("\t%-2s : %s\n", ["1", "S_CONFIG_SHOW"]));
        stdout.write(sprintf("\t%-2s : %s\n", ["2", "S_VERSION_SHOW"]));
        stdout.write(sprintf("\t%-2s : %s\n", ["3", "S_CONFIG_GET"]));
        stdout.write(sprintf("\t%-2s : %s\n", ["4", "S_CONFIG_ROW"]));
        stdout.write(sprintf("\t%-2s : %s\n", ["5", "S_CONFIG_COL"]));
        stdout.write(sprintf("\n", []));
        G_STATE = "S_CHOICE";
    }
    //===============================================
    void run_CHOICE(List<String> args) {
        var lLast = GConfig().getData("DART_SQLITE_ID");
        if(lLast == null) {lLast = "";}
        stdout.write(sprintf("DART_SQLITE (%s) ? ", [lLast]));
        var lAnswer = stdin.readLineSync();
        if(lAnswer == "") {lAnswer = lLast;}
        if(lAnswer == "-q") {G_STATE = "S_END";}
        else if(lAnswer == "-i") {G_STATE = "S_INIT";}
        else if(lAnswer == "-a") {G_STATE = "S_ADMIN";}
        else if(lAnswer == "1") {G_STATE = "S_CONFIG_SHOW"; GConfig().setData("DART_SQLITE_ID", lAnswer);}
        else if(lAnswer == "2") {G_STATE = "S_VERSION_SHOW"; GConfig().setData("DART_SQLITE_ID", lAnswer);}
        else if(lAnswer == "3") {G_STATE = "S_CONFIG_GET_CONFIG_KEY"; GConfig().setData("DART_SQLITE_ID", lAnswer);}
        else if(lAnswer == "4") {G_STATE = "S_CONFIG_ROW_CONFIG_KEY"; GConfig().setData("DART_SQLITE_ID", lAnswer);}
        else if(lAnswer == "5") {G_STATE = "S_CONFIG_COL"; GConfig().setData("DART_SQLITE_ID", lAnswer);}
    }
    //===============================================
    void run_CONFIG_ROW_CONFIG_KEY(List<String> args) {
        var lLast = GConfig().getData("DART_CONFIG_KEY");
        if(lLast == null) {lLast = "";}
        stdout.write(sprintf("DART_CONFIG_KEY (%s) ? ", [lLast]));
        var lAnswer = stdin.readLineSync();
        if(lAnswer == "") {lAnswer = lLast;}
        if(lAnswer == "-q") {G_STATE = "S_END";}
        else if(lAnswer == "-i") {G_STATE = "S_INIT";}
        else if(lAnswer == "-a") {G_STATE = "S_ADMIN";}
        else if(lAnswer != "") {G_STATE = "S_CONFIG_ROW"; GConfig().setData("DART_CONFIG_KEY", lAnswer);}
    }
    //===============================================
    void run_CONFIG_ROW(List<String> args) {
        stdout.write(sprintf("\n", []));
        var DART_CONFIG_KEY = GConfig().getData("DART_CONFIG_KEY");
        var lQuery = '''
        select *
        from CONFIG_DATA
        where CONFIG_KEY="${DART_CONFIG_KEY}"
        ''';
        var lDataMap = GSQLiteMgr().queryRow(lQuery);
        GManager().listPrint(lDataMap);
        G_STATE = "S_SAVE";
        stdout.write(sprintf("\n", []));
    }
    //===============================================
    void run_CONFIG_COL(List<String> args) {
        stdout.write(sprintf("\n", []));
        var DART_CONFIG_KEY = GConfig().getData("DART_CONFIG_KEY");
        var lQuery = '''
        select CONFIG_KEY
        from CONFIG_DATA
        ''';
        var lDataMap = GSQLiteMgr().queryCol(lQuery);
        GManager().listPrint(lDataMap);
        G_STATE = "S_SAVE";
        stdout.write(sprintf("\n", []));
    }
    //===============================================
    void run_CONFIG_GET_CONFIG_KEY(List<String> args) {
        var lLast = GConfig().getData("DART_CONFIG_KEY");
        if(lLast == null) {lLast = "";}
        stdout.write(sprintf("DART_CONFIG_KEY (%s) ? ", [lLast]));
        var lAnswer = stdin.readLineSync();
        if(lAnswer == "") {lAnswer = lLast;}
        if(lAnswer == "-q") {G_STATE = "S_END";}
        else if(lAnswer == "-i") {G_STATE = "S_INIT";}
        else if(lAnswer == "-a") {G_STATE = "S_ADMIN";}
        else if(lAnswer != "") {G_STATE = "S_CONFIG_GET"; GConfig().setData("DART_CONFIG_KEY", lAnswer);}
    }
    //===============================================
    void run_CONFIG_GET(List<String> args) {
        stdout.write(sprintf("\n", []));
        var DART_CONFIG_KEY = GConfig().getData("DART_CONFIG_KEY");
        var lQuery = '''
        select CONFIG_VALUE
        from CONFIG_DATA
        where CONFIG_KEY="${DART_CONFIG_KEY}"
        ''';
        var lValue = GSQLiteMgr().queryValue(lQuery);
        stdout.write(sprintf("%s\n", [lValue]));
        G_STATE = "S_SAVE";
        stdout.write(sprintf("\n", []));
    }
    //===============================================
    void run_VERSION_SHOW(List<String> args) {
        stdout.write(sprintf("\n", []));
        GSQLiteMgr().versionShow();
        G_STATE = "S_SAVE";
        stdout.write(sprintf("\n", []));
    }
    //===============================================
    void run_CONFIG_SHOW(List<String> args) {
        stdout.write(sprintf("\n", []));
        GSQLiteMgr().queryShow('''
        select * from CONFIG_DATA
        ''', 1);
        G_STATE = "S_SAVE";
        stdout.write(sprintf("\n", []));
    }
    //===============================================
    void run_SAVE(List<String> args) {
        GConfig().saveData("DART_SQLITE_ID");
        GConfig().saveData("DART_CONFIG_KEY");
        G_STATE = "S_QUIT";
    }
    //===============================================
    void run_LOAD(List<String> args) {
        GConfig().loadData("DART_SQLITE_ID");
        GConfig().loadData("DART_CONFIG_KEY");
        G_STATE = "S_METHOD";
    }
    //===============================================
    void run_QUIT(List<String> args) {
        stdout.write(sprintf("DART_QUIT (Oui/[N]on) ? ", []));
        var lAnswer = stdin.readLineSync();
        if(lAnswer == "-q") {G_STATE = "S_END";}
        else if(lAnswer == "-i") {G_STATE = "S_INIT";}
        else if(lAnswer == "-a") {G_STATE = "S_ADMIN";}
        else if(lAnswer == "o") {G_STATE = "S_END";}
        else if(lAnswer == "n") {G_STATE = "S_INIT";}
        else if(lAnswer == "") {G_STATE = "S_INIT";}
    }
    //===============================================
}
//===============================================
