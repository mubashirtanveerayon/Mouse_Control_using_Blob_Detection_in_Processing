float distThreshold = 90;

class Blob{
	
	ArrayList<PVector> points;
	float minx,miny,maxx,maxy;

	Blob(float x,float y){
		minx = x;
		miny = y;
		maxx = x;
		maxy = y;
		points = new ArrayList<PVector>();
		points.add(new PVector(x,y));
	}

	boolean isNear(float x,float y){
		 float mx = max(min(x,maxx),minx);
     	float my = max(min(y,maxy),miny);
     	float d = dist(mx,my,x,y);
     	return d<distThreshold;
	}

	void add(float x,float y){
		minx = min(x,minx);
		miny = min(y,miny);
		maxx = max(x,maxx);
		maxy = max(y,maxy);
		points.add(new PVector(x,y));
	}

	void show(){
		rectMode(CORNERS);
		rect(minx,miny,maxx,maxy);
	}

	float getSize(){
		return (maxx-minx)*(maxy-miny);
	}


  PVector getCenter(){
    float x=0;
    float y=0;
     for(PVector v:points){
         x+=v.x;
         y+=v.y;
     }
     x = x/points.size();
     y = y/points.size();
     
     return new PVector(x,y);
  }

}
