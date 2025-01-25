function compute_contact_forces!(particles::Vector{Particle}, 
    stiffness::Float64, 
    restitution::Float64, 
    friction_coefficient::Float64)
    """
    Computes elastic repulsion, damping, and friction forces between particles.

    Arguments:
        - particles: Vector of Particle structs.
        - stiffness: Elastic stiffness constant for Hookean repulsion.
        - restitution: Restitution coefficient (energy dissipation).
        - friction_coefficient: Coefficient of friction for tangential forces.
    """
    num_particles = length(particles)

    for i in 1:num_particles
        for j in (i + 1):num_particles
            p1 = particles[i]
            p2 = particles[j]

            # Vector from p1 to p2
            displacement = p2.position - p1.position
            distance = norm(displacement)

            # Check for overlap
            overlap = p1.radius + p2.radius - distance
            if overlap > 0
                # Compute normalized direction vector (from p1 to p2)
                normal = displacement / distance

                # Hookean normal force (repulsion)
                normal_force = stiffness * overlap * normal

                # Relative velocity
                relative_velocity = p2.velocity - p1.velocity

                # Compute normal velocity component
                normal_velocity = dot(relative_velocity, normal)
                
                # Damping force (based on restitution)
                damping_force = -restitution * normal_velocity * normal
                
                # Total normal force (elastic + damping)
                total_normal_force = normal_force + damping_force

                # Tangential velocity component
                tangential_velocity = relative_velocity - normal_velocity * normal
                
                # Tangential (frictional) force
                tangential_force = -friction_coefficient * tangential_velocity

                # Total contact force
                total_force = total_normal_force + tangential_force

                # Apply equal and opposite forces
                p1.forces -= total_force
                p2.forces += total_force

                # Optional: Correct positions to resolve overlap
                correction_factor = 0.1  # Prevent particles from sinking into each other
                correction = correction_factor * overlap * normal
                p1.position -= correction / 2
                p2.position += correction / 2
            end
        end
    end
end

