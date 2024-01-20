// https://github.com/RealDawnStudio/unity-tutorial-boids

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoidController : MonoBehaviour
{
    public int SwarmIndex { get; set; }
    public float NoClumpingRadius { get; set; }
    public float LocalAreaRadius { get; set; }
    public float Speed { get; set; }
    public float SteeringSpeed { get; set; }

    public void SimulateMovement(List<BoidController> other, float time)
    {
        //default vars
        var steering = Vector3.zero;

        var separationDirection = Vector3.zero;
        var separationCount = 0;
        var alignmentDirection = Vector3.zero;
        var alignmentCount = 0;
        var cohesionDirection = Vector3.zero;
        var cohesionCount = 0;

        var leaderBoid = other[0];
        var leaderAngle = 180f;

        foreach (BoidController boid in other)
        {
            //skip self
            if (boid == this)
                continue;

            var distance = Vector3.Distance(boid.transform.position, this.transform.position);

            //identify local neighbour
            if (distance < NoClumpingRadius)
            {
                separationDirection += new Vector3(leaderBoid.transform.position.x - transform.position.x, 0 , leaderBoid.transform.position.z - transform.position.z);
                separationDirection.y = 0;
                separationCount++;
            }

            //identify local neighbour
            if (distance < LocalAreaRadius && boid.SwarmIndex == this.SwarmIndex)
            {
                alignmentDirection += boid.transform.forward;
                alignmentCount++;

                cohesionDirection += new Vector3(leaderBoid.transform.position.x - transform.position.x, 0 , leaderBoid.transform.position.z - transform.position.z);
                cohesionDirection.y=0;
                cohesionCount++;

                //identify leader
                var angle = Vector3.Angle(new Vector3(leaderBoid.transform.position.x - transform.position.x, 0 , leaderBoid.transform.position.z - transform.position.z), transform.forward);
                if (angle < leaderAngle && angle < 90f)
                {
                    leaderBoid = boid;
                    leaderAngle = angle;
                }
            }
        }

        if (separationCount > 0)
            separationDirection /= separationCount;

        //flip
        separationDirection = -separationDirection;

        if (alignmentCount > 0)
            alignmentDirection /= alignmentCount;

        if (cohesionCount > 0)
            cohesionDirection /= cohesionCount;

        //get direction to center of mass
        cohesionDirection -= transform.position;
        cohesionDirection.y=0;

        // transform.position.y = 10;
        // separationDirection.y = 10;
        // alignmentDirection.y = 10;
        // cohesionDirection.y = 10;


        //weighted rules
        steering += separationDirection.normalized;
        steering += alignmentDirection.normalized;
        steering += cohesionDirection.normalized;

        steering.y=0;

        //local leader
        if (leaderBoid != null)
            steering += new Vector3(leaderBoid.transform.position.x - transform.position.x, 0 , leaderBoid.transform.position.z - transform.position.z).normalized;
            // steering += (leaderBoid.transform.position - transform.position).normalized;

        //obstacle avoidance
        RaycastHit hitInfo;
        if (Physics.Raycast(transform.position, transform.forward, out hitInfo, LocalAreaRadius, LayerMask.GetMask("Default")))
            steering = ((hitInfo.point + hitInfo.normal) - transform.position).normalized;

        //apply steering
        if (steering != Vector3.zero)
            transform.rotation = Quaternion.RotateTowards(transform.rotation, Quaternion.LookRotation(steering), SteeringSpeed * time);

        //move 
        transform.position += transform.TransformDirection(new Vector3(0, 0, Speed)) * time;
    }
}