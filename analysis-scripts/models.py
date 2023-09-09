
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


class LaserPower:

    def __init__(self, *, pulse_length, powers, absorbances):
        self.pulse_length = pulse_length
        self.powers = powers
        self.absorbances = absorbances
        self.S0 = np.array([1.0, 0.0, 0.0])
        return

    @staticmethod
    def dS(S, power, sigma_1, sigma_n):
        """
        returns dS/dt at p
        """

        dS0 = power * sigma_1 * S[1] - power * sigma_1 * S[0]
        dS1 = power * sigma_1 * S[0] - power * sigma_1 * S[1] - power * sigma_n * S[1] # + power * sigma_n * S[2]
        dS2 = power * sigma_n * S[1] # - power * sigma_n * S[2]

        dSdt = np.array([dS0, dS1, dS2])

        return dSdt

    def estimate(self, sigma_1, sigma_n, return_all_states=False):
        result = []
        for power in self.powers:
            dS_closure = lambda S, t: self.dS(S, power, sigma_1, sigma_n)
            power_est = integrate.odeint(dS_closure, self.S0, [0, self.pulse_length])
            if return_all_states:
                result.append(power_est[1,:])
            else:
                result.append(power_est[1,1])  # only (second time point, S1)
        return np.array(result)

    def residual(self, params):
        r = self.absorbances - params[:-2,None] * self.estimate(*params[-2:])
        return r.flatten()

    def fit(self, *, params0):
        """ params : amplitudes, sigma_1, sigma_n """

        p_opt, status = optimize.leastsq(self.residual, np.array(params0))
        final_residual = np.sum(np.square(self.residual(p_opt)))

        print('residual:', final_residual)

        return p_opt
    

if __name__ == '__main__':

    # k = 1.5
    # t = np.logspace(-3, 1, 100)
    # p_obs = np.array([ np.exp(-k * t), 1 - np.exp(-k * t) ])

    # lk = LinearKinetic(n_states=2, times=t, populations=p_obs.T)
    # results = lk.fit(k0=[0.5])
    # print(results)

    powers = np.linspace(5, 500, 10)
    obs_abs = np.log(powers)
    #obs_abs /= obs_abs.max() * 2.0
    pulse_len = 0.001

    lp = LaserPower(pulse_length=pulse_len, powers=powers, s1_population=obs_abs)
    # print(lp.dS([0.9, 0.1, 0.0], 10.0, 1.0, 1.0))
    print(lp.estimate(1.0, 0.5, return_all_states=True))
    print(lp.fit(params0=[2.0, 1.0, 1.0]))
