
BAUPROJEKTE = ../mapping

MACROS = ./macros

FIRST_ID_CLASS_VEHICLES = 260

all: bauprojekte Lampen_einschalten mission.sqm mission_vanilla.sqm

clean:
	rm -rf tmp
	rm -rf tmp2

bauprojekte:
	cat bin/slice.sh | tr -d '\r' | tee bin/.slice_CRLF_sucks.sh
	chmod 0755 bin/.slice_CRLF_sucks.sh
	mkdir -p tmp
	find $(BAUPROJEKTE) -type f -ipath '*/mission_*.sqm' | \
		xargs -n1 --no-run-if-empty ./bin/.slice_CRLF_sucks.sh | \
			tee tmp/mission.txt

Lampen_einschalten:
	cat bin/lamps.sh | tr -d '\r' | tee bin/.lamps_CRLF_sucks.sh
	chmod 0755 bin/.lamps_CRLF_sucks.sh
	mkdir -p tmp2
	./bin/.lamps_CRLF_sucks.sh tmp/mission.txt | tee tmp2/mission.txt

mission.sqm:
	@chmod 0755 bin/glue.py
	@bin/glue.py \
		"configs/mission.sqm.skel.txt" \
		"configs/addOns.skel.txt" \
		"configs/addOnsAuto.skel.txt" \
		"configs/classgroups.skel.txt" \
		"configs/classmarkers.skel.txt" \
		"configs/classvehicles.skel.txt tmp2/mission.txt" \
		"$(FIRST_ID_CLASS_VEHICLES)" "$(MACROS)" | \
	tee ../Altis/Altis_Life.Altis/$(@)

mission_vanilla.sqm:
	@chmod 0755 bin/glue.py
	@bin/glue.py \
		"configs/mission.sqm.skel.txt" \
		"configs/addOns.skel.txt" \
		"configs/addOnsAuto.skel.txt" \
		"configs/classgroups.skel.txt" \
		"configs/classmarkers.skel.txt" \
		"configs/classvehicles.skel.txt" \
		"$(FIRST_ID_CLASS_VEHICLES)" "$(MACROS)" | \
	tee ../Altis/Altis_Life.Altis/$(@)

