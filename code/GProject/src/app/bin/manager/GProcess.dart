//===============================================
import 'dart:io';
import 'package:sprintf/sprintf.dart';
import 'GConfig.dart';
//===============================================
class GProcess {
    //===============================================
    GProcess._privateConstructor();
    static final GProcess m_instance = GProcess._privateConstructor();
    //===============================================
    var G_STATE;
    //===============================================
    factory GProcess() {
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
            else if(G_STATE == "S_TASK") {run_TASK(args);}
            else if(G_STATE == "S_SAVE") {run_SAVE(args);}
            else if(G_STATE == "S_LOAD") {run_LOAD(args);}
            else if(G_STATE == "S_QUIT") {run_QUIT(args);}
            else break; 
        } 
    }
    //===============================================
    void run_ADMIN(List<String> args) {
        stdout.write("run_ADMIN\n");
        G_STATE = "S_END";
    }
    //===============================================
    void run_INIT(List<String> args) {
        stdout.write(sprintf("DART_ADMIN !!!\n", []));
        stdout.write(sprintf("\t%-2s : %s\n", ["-q", "quitter l'application"]));
        stdout.write(sprintf("\n", []));
        G_STATE = "S_LOAD";
    }
    //===============================================
    void run_METHOD(List<String> args) {
        stdout.write(sprintf("DART_ADMIN :\n", []));
        stdout.write(sprintf("\t%-2s : %s\n", ["1", "S_SQLITE"]));
        stdout.write(sprintf("\n", []));
        G_STATE = "S_CHOICE";
    }
    //===============================================
    void run_CHOICE(List<String> args) {
        var lLast = GConfig().getData("DART_CHOICE_ID");
        if(lLast == null) {lLast = "";}
        stdout.write(sprintf("DART_CHOICE_ID (%s) ? ", [lLast]));
        var lAnswer = stdin.readLineSync();
        if(lAnswer == "") {lAnswer = lLast;}
        if(lAnswer == "-q") {G_STATE = "S_END";}
        else if(lAnswer == "1") {G_STATE = "S_SQLITE"; GConfig().setData("DART_CHOICE_ID", lAnswer);}
    }
    //===============================================
    void run_TASK(List<String> args) {
        G_STATE = "S_SAVE";
    }
    //===============================================
    void run_SAVE(List<String> args) {
        G_STATE = "S_QUIT";
    }
    //===============================================
    void run_LOAD(List<String> args) {
        G_STATE = "S_METHOD";
    }
    //===============================================
    void run_QUIT(List<String> args) {
        G_STATE = "S_END";
    }
    //===============================================
}
//===============================================
