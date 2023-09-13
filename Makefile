KA=java -jar /opt/KickAssembler/KickAss.jar
KAOUTDIR=./../build/
KAOPTS=-cfgfile ./KickAss.cfg -odir ${KAOUTDIR}

SRCDIR=./src/

lib:
	${KA} ${KAOPTS} ${SRCDIR}lib.asm

setmem:
	${KA} ${KAOPTS} ${SRCDIR}setmem.asm

bmpswitch:
	${KA} ${KAOPTS} ${SRCDIR}bmpswitch.asm

drawpt:
	${KA} ${KAOPTS} ${SRCDIR}drawpt.asm

clean:
	rm -rf ./build/
