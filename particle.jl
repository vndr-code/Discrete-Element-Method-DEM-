mutable struct Particle
    position::SVector{3, Float64}
    velocity::SVector{3, Float64}
    radius::Float64
    mass::Float64
    forces::SVector{3, Float64}  # Include forces
end

