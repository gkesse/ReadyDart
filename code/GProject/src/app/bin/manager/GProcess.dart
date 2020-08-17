//===============================================
import 'dart:io';
import 'package:sprintf/sprintf.dart';
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
        stdout.write(sprintf("run_INIT\n", []));
        G_STATE = "S_LOAD";
    }
    //===============================================
    void run_METHOD(List<String> args) {
        stdout.write("run_METHOD\n");
        G_STATE = "S_CHOICE";
    }
    //===============================================
    void run_CHOICE(List<String> args) {
        stdout.write("run_CHOICE\n");
        G_STATE = "S_TASK";
    }
    //===============================================
    void run_TASK(List<String> args) {
        stdout.write("run_TASK\n");
        G_STATE = "S_SAVE";
    }
    //===============================================
    void run_SAVE(List<String> args) {
        stdout.write("run_SAVE\n");
        G_STATE = "S_QUIT";
    }
    //===============================================
    void run_LOAD(List<String> args) {
        stdout.write("run_LOAD\n");
        G_STATE = "S_METHOD";
    }
    //===============================================
    void run_QUIT(List<String> args) {
        stdout.write("run_QUIT\n");
        G_STATE = "S_END";
    }
    //===============================================
}
//===============================================
