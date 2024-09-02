using QEDFeynman
using GraphComputing

prop = GraphProperties()

@test prop.data == 0.0
@test prop.computeEffort == 0.0
@test prop.computeIntensity == 0.0
@test prop.noNodes == 0.0
@test prop.noEdges == 0.0

prop2 = (
    data=5.0, computeEffort=6.0, computeIntensity=6.0 / 5.0, noNodes=2, noEdges=3
)::GraphProperties

@test prop + prop2 == prop2
@test prop2 - prop == prop2

negProp = -prop2
@test negProp.data == -5.0
@test negProp.computeEffort == -6.0
@test negProp.computeIntensity == 6.0 / 5.0
@test negProp.noNodes == -2
@test negProp.noEdges == -3

@test negProp + prop2 == GraphProperties()

prop3 = (
    data=7.0, computeEffort=3.0, computeIntensity=7.0 / 3.0, noNodes=-3, noEdges=2
)::GraphProperties

propSum = prop2 + prop3

@test propSum.data == 12.0
@test propSum.computeEffort == 9.0
@test propSum.computeIntensity == 9.0 / 12.0
@test propSum.noNodes == -1
@test propSum.noEdges == 5
