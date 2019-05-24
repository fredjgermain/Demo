using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

/*public class KeyInput : MonoBehaviour
{

}*/

public class Clicksv0
{
    public static List<Clicksv0> clicks = new List<Clicksv0>();

    public float time;
    public Vector3 position;
    public int button;
    public bool isUp;

    public Clicksv0(int button, float time, Vector3 position, bool isUp = false)
    {
        this.button = button;
        this.time = time;
        this.position = position;
        this.isUp = isUp;

        clicks.Add(this);
        while(clicks.Count() > 10)
            clicks.RemoveAt(0);
    }

    public static bool HasDoubleLeftClick()
    {
        if (clicks.Count() < 3)
            return false;
        Clicksv0 a = clicks.ElementAtOrDefault(clicks.Count() - 3);
        Clicksv0 b = clicks.ElementAtOrDefault(clicks.Count() - 1);

        //Debug.Log($"Dclick: {b.time} {a.time} {b.time - a.time}" );
        return (a.isUp && b.isUp &&
            a.button == 0 && b.button == 0 &&
            b.time - a.time < 0.4f);
    }

    public static Clicksv0 lastClick
        => clicks.LastOrDefault();
}

public class CamTest : MonoBehaviour
{
    public GameObject camPivot;
    public Camera cam;
    public GameObject camPointer;
    float camSpeed;

    // Start is called before the first frame update
    void Start()
    {
        camPivot.transform.position = new Vector3(0.0f, 0.0f, 0.0f);
        camPointer.transform.position = new Vector3(0.0f, 0.0f, 0.0f);
        cam.transform.position = new Vector3(0.0f, 10.0f, -10.0f);

        camSpeed = Time.deltaTime * 30;
        RaycastHit hit;
        Physics.Raycast(camPivot.transform.position, new Vector3(0,-1,0), out hit);
        cam.transform.LookAt(hit.point);
    }

    // Update is called once per frame
    void Update()
    {
        LeftClick();
        ReCenterCam();
        ZoomCam();
        PivotCam();
        PanCam();
    }

    void LeftClick()
    {
        if (Input.GetMouseButtonDown(0))
            new Clicksv0(0, Time.time, ClickOnGround(), false);
        else if(Input.GetMouseButtonUp(0))
            new Clicksv0(0, Time.time, ClickOnGround(), true);
    }

    Vector3 ClickOnGround()
    {
        RaycastHit hit;
        Ray ray = cam.ScreenPointToRay(Input.mousePosition);
        ;
        /*int layerMask = 1 << 10;
        if (Physics.Raycast(ray, out hit, layerMask))
            return hit.point;*/

        // Test Geometry ------------------------
        Vector3 e0 = new Vector3(0, 0, 0);
        Vector3 e1 = new Vector3(1, 0, 0);
        Vector3 e2 = new Vector3(0, 0, 1);
        Vector3 l0 = ray.origin;
        Vector3 l1 = ray.direction;
        Vector3? intersect = VecGeo.LinePlaneIntersect(l0, l1, e0, e1, e2);
        //Debug.Log(intersect);
        // --------------------------------------

        return new Vector3(0.0f, 0.0f, 0.0f);
    }

    void ReCenterCam()
    {
        if (!Input.GetMouseButtonUp(0) || !Clicksv0.HasDoubleLeftClick())
            return;
        Clicksv0 dClick = Clicksv0.lastClick;
        if (dClick == null)
            return;
        camPivot.transform.position = dClick.position;
    }

    void ZoomCam()
    {
        Vector2 wheel = Input.mouseScrollDelta;
        if (wheel.x == 0.0f && wheel.y == 0.0f)
            return;
        cam.transform.Translate(Vector3.forward * camSpeed * 10 * wheel.y);
    }

    void PivotCam()
    {
        IEnumerable<KeyCode> keys = new KeyCode[] { KeyCode.Q, KeyCode.E };
        if (!keys.Any(k => Input.GetKey(k)))
            return;
        if (Input.GetKey(KeyCode.Q))
            camPivot.transform.Rotate(0.0f, 5.0f, 0.0f);
        if (Input.GetKey(KeyCode.E))
            camPivot.transform.Rotate(0.0f, -5.0f, 0.0f);
    }

    void PanCam()
    {
        IEnumerable<KeyCode> keys = new KeyCode[] { KeyCode.W, KeyCode.A, KeyCode.S, KeyCode.D };
        if (!keys.Any(k => Input.GetKey(k)))
            return;
        if (Input.GetKey(KeyCode.W))
            camPivot.transform.Translate(Vector3.forward * camSpeed);
        if (Input.GetKey(KeyCode.A))
            camPivot.transform.Translate(Vector3.left * camSpeed);
        if (Input.GetKey(KeyCode.D))
            camPivot.transform.Translate(Vector3.right * camSpeed);
        if (Input.GetKey(KeyCode.S))
            camPivot.transform.Translate(Vector3.back * camSpeed);
    }

    /*Vector3 CamRayCenter()
    {
        int layerMask = 1 << 10;
        print(layerMask);
        layerMask = ~layerMask;

        Ray ray = cam.ViewportPointToRay(new Vector3(0.5F, 0.5F, 0));
        RaycastHit hit;

        if (Physics.Raycast(ray, out hit, Mathf.Infinity, layerMask))
        {
            print("Looking at " + hit.point);
            //camRayPoint.transform.position = hit.point;
        }
        return hit.point;
    }*/


}
