include("particle.jl")

function handle_boundaries!(particles::Vector{Particle}, boundaries::Tuple{Tuple{Float64, Float64}, Tuple{Float64, Float64}, Tuple{Float64, Float64}})
    x_limits, y_limits, z_limits = boundaries

    for particle in particles
        # Reflect off X boundaries
        if particle.position[1] - particle.radius < x_limits[1]
            particle.velocity = SVector(-particle.velocity[1], particle.velocity[2], particle.velocity[3])
            particle.position = SVector(x_limits[1] + particle.radius, particle.position[2], particle.position[3])
        elseif particle.position[1] + particle.radius > x_limits[2]
            particle.velocity = SVector(-particle.velocity[1], particle.velocity[2], particle.velocity[3])
            particle.position = SVector(x_limits[2] - particle.radius, particle.position[2], particle.position[3])
        end

        # Reflect off Y boundaries
        if particle.position[2] - particle.radius < y_limits[1]
            particle.velocity = SVector(particle.velocity[1], -particle.velocity[2], particle.velocity[3])
            particle.position = SVector(particle.position[1], y_limits[1] + particle.radius, particle.position[3])
        elseif particle.position[2] + particle.radius > y_limits[2]
            particle.velocity = SVector(particle.velocity[1], -particle.velocity[2], particle.velocity[3])
            particle.position = SVector(particle.position[1], y_limits[2] - particle.radius, particle.position[3])
        end

        # Reflect off Z boundaries
        if particle.position[3] - particle.radius < z_limits[1]
            particle.velocity = SVector(particle.velocity[1], particle.velocity[2], -particle.velocity[3])
            particle.position = SVector(particle.position[1], particle.position[2], z_limits[1] + particle.radius)
        elseif particle.position[3] + particle.radius > z_limits[2]
            particle.velocity = SVector(particle.velocity[1], particle.velocity[2], -particle.velocity[3])
            particle.position = SVector(particle.position[1], particle.position[2], z_limits[2] - particle.radius)
        end
    end
end
