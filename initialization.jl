include("particle.jl")

function initialize_particles(num_particles::Int, boundaries::Tuple{Tuple{Float64, Float64}, Tuple{Float64, Float64}, Tuple{Float64, Float64}})
    x_limits, y_limits, z_limits = boundaries
    particles = Particle[]
    for _ in 1:num_particles
        position = SVector(
            rand(x_limits[1]:0.01:x_limits[2]),
            rand(y_limits[1]:0.01:x_limits[2]),
            rand(z_limits[1]:0.01:x_limits[2])
        )
        velocity = SVector(0.0, 0.0, 0.0)
        radius = 0.1
        mass = 100.0#(4 / 3) * π * radius^3  # Assuming uniform density
        forces = SVector(0.0, 0.0, 0.0)
        push!(particles, Particle(position, velocity, radius, mass, forces))
    end
    return particles
end


# Continuous particle generation
function add_particles_continuously!(particles::Vector{Particle}, 
    nozzle_position::SVector{3, Float64}, 
    flow_rate::Float64, 
    time_step::Float64)
    """
    Adds new particles at a given flow rate and position over time.

    Arguments:
        - particles: Existing particle array.
        - nozzle_position: Position from which particles are released.
        - flow_rate: Number of particles to release per second.
        - time_step: Time interval for particle addition.
    """
    num_new_particles = round(Int, flow_rate * time_step)
    num_new_particles = 1
    release_radius = 0.3
    for _ in 1:num_new_particles
        # Random angle and radius for circular distribution
        angle = 2π * rand()
        radius = release_radius * sqrt(rand())  # sqrt(rand()) ensures uniform distribution in the circle

        # Offset within the circle
        offset = SVector(
            radius * cos(angle),
            radius * sin(angle),
            0.0  # No offset in the Z direction
        )

        # Position is nozzle position + offset
        position = nozzle_position + offset
        velocity = SVector(0.0, 0.0, 0.0)
        radius = 0.1
        mass = 100.0  # Adjust mass if needed
        forces = SVector(0.0, 0.0, 0.0)
        push!(particles, Particle(position, velocity, radius, mass, forces))
    end
end