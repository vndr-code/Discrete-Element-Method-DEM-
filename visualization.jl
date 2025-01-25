using Plots

include("particle.jl")

function create_animation(
    particles::Vector{Particle},
    boundaries::Tuple{Tuple{Float64, Float64}, Tuple{Float64, Float64}, Tuple{Float64, Float64}},
    total_frames::Int,
    time_step::Float64,
    gravity::SVector{3, Float64},
    stiffness::Float64
)
    x_limits, y_limits, z_limits = boundaries

    anim = @animate for frame in 1:total_frames
        # Add new particles continuously
        add_particles_continuously!(particles, SVector(0.0, 0.0, 1.8), 50.0, time_step)
        #println("Total particles: $(length(particles))")
        # Update particles
        update_particles!(particles, time_step, gravity, boundaries, stiffness)

        # Plot particles
        scatter3d(
            [p.position[1] for p in particles],
            [p.position[2] for p in particles],
            [p.position[3] for p in particles],
            markersize=5,
            xlims=(x_limits[1], x_limits[2]),
            ylims=(y_limits[1], y_limits[2]),
            zlims=(z_limits[1], z_limits[2]),
            title="Frame $frame",
            label=false  # Remove legend
        )
    end

    gif(anim, "simulation.gif", fps=30)
end


