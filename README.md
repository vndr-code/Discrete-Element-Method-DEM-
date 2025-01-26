# Discrete Element Method (DEM) Particle Simulation

This repository contains a basic implementation of a **Discrete Element Method (DEM)** simulation in Julia. The program models the dynamics of particles as they interact and stack within a confined boundary. The simulation features continuous particle generation from a nozzle and captures physical phenomena such as elastic collisions, friction, and boundary reflections.

---

## Features
- **Particle Interaction**:
  - Elastic collisions between particles using Hookean contact forces.
  - Damping and friction forces to simulate energy dissipation and tangential interactions.
- **Continuous Particle Generation**:
  - Particles are released from a specified nozzle position at a controllable flow rate.
  - Particles stack and fill a box over time.
- **Boundary Handling**:
  - Reflection of particles when they hit the walls, ensuring they remain within the simulation domain.
- **Visualization**:
  - Real-time 3D scatter plot animation.
  - Output saved as a `.gif` for easy sharing.

---
