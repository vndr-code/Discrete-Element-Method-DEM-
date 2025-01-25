include("particle.jl")

include("boundaries.jl")

function update_particles!(particles::Vector{Particle}, 
    time_step::Float64, 
    gravity::SVector{3, Float64}, 
    boundaries::Tuple{Tuple{Float64, Float64}, 
    Tuple{Float64, Float64}, 
    Tuple{Float64, Float64}}, 
    stiffness::Float64)

    # Reset forces for all particles
    for particle in particles
        particle.forces = SVector(0.0, 0.0, 0.0)
    end
    
    # Compute contact forces first                restitution, friction
    compute_contact_forces!(particles, stiffness, 0.0, 100.99)

    # Apply forces to update velocities and positions
    for particle in particles
        # Apply gravity
        particle.forces += particle.mass * gravity

        # Compute acceleration
        acceleration = particle.forces / particle.mass

        # Update velocity
        particle.velocity += acceleration * time_step

        # Update position
        particle.position += particle.velocity * time_step
    end

    # Enforce boundary conditions
    handle_boundaries!(particles, boundaries)
end
