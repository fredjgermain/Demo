using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class VecGeo
{
    /* --- LinePlaneIntersect ---
     * Math note: http://geomalgorithms.com/a05-_intersect-1.html
    Vectors l0, l1 form a line
    Vectors p0, p2, p3 form a plane
    return Vector corresponding to the intersect, otherwise return null
    */
    public static Vector3? LinePlaneIntersect(Vector3 l0, Vector3 l1, Vector3 p0, Vector3 p1, Vector3 p2)
    {
        Vector3 u = l1 - l0;
        Vector3 w = p0 - l0;
        Vector3 v1 = p1 - p0;
        Vector3 v2 = p2 - p0;
        Vector3 n = Vector3.Cross(v1, v2);
        if (Vector3.Dot(n, u) == 0.0)
            return null;
        double s = Vector3.Dot(-n, w) / Vector3.Dot(n, u);
        return w + (float)s * u;
    }
}
