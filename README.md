# Muller's ratchet

Simulating one click of Muller's ratchet in the slow clicking regime using three different models:

- _Haigh-WF_: the [Haigh (1978)](https://doi.org/10.1016/0040-5809(78)90027-8) original model based on Wright-Fisher sampling for the frequencies of each mutation class. 
- _Haigh-agents_: an agent-based version of the same model
- _Waxman_: a truncation of Haigh's model down to two mutation due to [Waxman and Loewe (2010)](https://doi.org/10.1016/j.jtbi.2010.03.014)

This problem is a good test case for non-standard diffusion approximations of the Wright-Fisher model of population genetics:

[Bräutigam, Smerlak, Diffusion approximations in population genetics and the rate of Muller’s ratchet](https://doi.org/10.1101/2021.11.25.469985)