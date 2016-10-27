# generic nmake Makefile (without dependencies)

all:	subprojects checkdirs output_binary output_library

clean:
	@if exist $(BUILD_DIR) rmdir /S /Q $(BUILD_DIR)
! ifdef SUBPRJS
	@echo off && for %%x in ($(SUBPRJS)) do cd $(SUBPRJS) && $(MAKE) /NOLOGO clean
! endif

checkdirs:
	@if NOT EXIST $(BUILD_DIR) mkdir $(BUILD_DIR)

{$(SRC_DIR)}.cpp{$(BUILD_DIR)}.obj::
	$(CC) -nologo $(INCLUDES) -c /W4 /EHsc /Fo$(BUILD_DIR)/ $<

subprojects:
! ifdef SUBPRJS
	@echo off && for %%x in ($(SUBPRJS)) do cd $(SUBPRJS) && $(MAKE) /NOLOGO
! endif

output_binary: $(PATH_BIN)
! ifdef PATH_BIN
$(PATH_BIN): $(BUILD_DIR)/*.obj
	LINK /NOLOGO /OUT:$(PATH_BIN) $(BUILD_DIR)/*.obj $(LIBS)
! endif

output_library: $(OUT_LIB)
! ifdef OUT_LIB
$(OUT_LIB): $(BUILD_DIR)/*.obj
	LIB /NOLOGO /VERBOSE /OUT:$(BUILD_DIR)/$(OUT_LIB) $(BUILD_DIR)/*.obj
! endif
