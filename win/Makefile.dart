GSRC = ..\code\GProject\src
GBIN = bin
GBUILD = build
GTARGET = $(GBIN)\gp_dart.exe

GAPP = app
GPACK = $(GSRC)\$(GAPP)
GMAIN = $(GPACK)\bin\$(GAPP).dart
    
all: clean compile run
app: pub_console
pub: pub_get
ins: pub_global
cmd: pub_stagehand

compile: $(GMAIN)
	@if not exist $(GBIN) ( mkdir $(GBIN) )
	dart2native $(GMAIN) -o $(GTARGET)
pub_get:
	@cd $(GPACK) && pub get
pub_global:
	@pub global activate stagehand
pub_stagehand:
	@stagehand
pub_console:
	@if not exist $(GPACK) ( mkdir $(GPACK) )
	@cd $(GPACK) && stagehand console-full
run:
	@$(GTARGET)
clean: 
	del /q $(GBIN)\*
