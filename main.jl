using Pkg

# Activate environment
Pkg.activate(".")
Pkg.instantiate()
Pkg.add("Plots")
Pkg.add("StaticArrays")
Pkg.add("LinearAlgebra")

using Plots
using StaticArrays
using LinearAlgebra


include("particle.jl")
include("initialization.jl")
include("update.jl")
include("boundaries.jl")
include("visualization.jl")
include("contact_forces.jl")

const GRAVITY = SVector(0.0, 0.0, -9.8)
const TIME_STEP = 0.01
const TOTAL_FRAMES = 1000
const BOUNDARIES = ((-1.0, 1.0), (-1.0, 1.0), (0.0, 2.0))
const STIFFNESS = 10000.0
const FLOW_RATE = 50.0  # Particles per second
const NOZZLE_POSITION = SVector(0.0, 0.0, 1.8)  # Adjust as needed

particles = initialize_particles(0, BOUNDARIES)  # Start with an empty array

# Create animation
create_animation(
    particles,
    BOUNDARIES,
    TOTAL_FRAMES,
    TIME_STEP,
    GRAVITY,
    STIFFNESS
)

