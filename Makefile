KA=java -jar /opt/KickAssembler/KickAss.jar
KAOUTDIR=./build/
KAOPTS=-cfgfile ./KickAss.cfg -odir ${KAOUTDIR}

lib: lib.asm
	${KA} ${KAOPTS} lib.asm

setmem:
	${KA} ${KAOPTS} setmem.asm

bmpswitch:
	${KA} ${KAOPTS} bmpswitch.asm

drawpt:
	${KA} ${KAOPTS} drawpt.asm

clean:
	rm -rf ./build/
