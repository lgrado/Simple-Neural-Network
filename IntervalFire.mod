NEURON {
    ARTIFICIAL_CELL IntervalFire
    RANGE tau, m, invl
}

PARAMETER {
    tau = 5 (ms) <1e-9,1e9>
    invl = 10 (ms) <1e-9,1e9>
}

ASSIGNED {
    m
    minf
    t0(ms)
}

INITIAL {
    minf = 1/(1 - exp(-invl/tau)) : so ISI is invl
    m = 0
    t0 = t
    net_send(firetime(), 1)
}

NET_RECEIVE (w) {
    m = M()
    t0 = t
    if (flag == 0) {
	m = m + w
	if (m > 1) {
	    m = 0
	    net_event(t)
	}
	net_move(t+firetime())
    }
    else {
	net_event(t)
	m = 0
	net_send(firetime(), 1)
    }
}

FUNCTION firetime() (ms) { : m < 1 and minf > 1
    firetime = tau*log((minf-m)/(minf - 1))
}

FUNCTION M() {
    M = minf + (m - minf)*exp(-(t-t0)/tau)
}
    