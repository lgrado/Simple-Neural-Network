#include <stdio.h>
#include "hocdec.h"
#define IMPORT extern __declspec(dllimport)
IMPORT int nrnmpi_myid, nrn_nobanner_;

extern void _IntervalFire_reg();
extern void _gsyn_reg();

modl_reg(){
	//nrn_mswindll_stdio(stdin, stdout, stderr);
    if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
	fprintf(stderr, "Additional mechanisms from files\n");

fprintf(stderr," IntervalFire.mod");
fprintf(stderr," gsyn.mod");
fprintf(stderr, "\n");
    }
_IntervalFire_reg();
_gsyn_reg();
}
