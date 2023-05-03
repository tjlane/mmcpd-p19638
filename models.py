
import numpy as np
from scipy import integrate
from scipy import optimize


class LinearKinetic:

    def __init__(self, *, n_states, times, populations):
        self.n_states = n_states
        self.times = times
        self.populations = populations
        return

    @staticmethod
    def dp(p, k):
        """
        returns dp/dt at p
        note: dp_n / dt = k_{n-1} p_{n-1} - k_n p_n
        """

        forward_flux = np.concatenate([[0.0], k * p[:-1]])
        backward_flux = np.concatenate([k * p[:-1], [0.0]])

        dpdt = forward_flux - backward_flux
        #print(p, k, dpdt)

        return dpdt

    def estimate(self, t, k):
        """ generate the predictions of a model with params `k_fit` at time `t` """
        # closure that skips t, as our eqns are homogenous
        dp_with_k = lambda p, t: self.dp(p, k)
        return integrate.odeint(dp_with_k, self.p0, t)

    def residual(self, k):
        return (self.populations - self.estimate(self.times, k)).flatten()

    def fit(self, *, k0, p0=None):

        assert len(k0) == self.n_states - 1

        if p0 is None:
            p0 = np.zeros(self.n_states)
            p0[0] = 1.0

        self.p0 = p0

        k_opt, status = optimize.leastsq(self.residual, np.array(k0))
        final_residual = np.sum(np.square(self.residual(k_opt)))

        print('residual:', final_residual)

        return k_opt


if __name__ == '__main__':

    k = 1.5
    t = np.logspace(-3, 1, 100)
    p_obs = np.array([ np.exp(-k * t), 1 - np.exp(-k * t) ])

    lk = LinearKinetic(n_states=2, times=t, populations=p_obs.T)
    results = lk.fit(k0=[0.5])
    print(results)
