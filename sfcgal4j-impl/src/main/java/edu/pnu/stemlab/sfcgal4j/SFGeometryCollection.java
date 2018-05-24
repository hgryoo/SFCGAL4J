package edu.pnu.stemlab.sfcgal4j;

import org.bytedeco.javacpp.Loader;
import org.bytedeco.javacpp.Pointer;
import org.bytedeco.javacpp.annotation.ByRef;
import org.bytedeco.javacpp.annotation.Cast;
import org.bytedeco.javacpp.annotation.Name;
import org.bytedeco.javacpp.annotation.Platform;
import org.bytedeco.javacpp.annotation.StdString;

/**
 * @author Donguk Seo
 *
 */
@Platform(include = "cpp/SFGeometryCollection.cpp", link = {"SFCGAL"})
public class SFGeometryCollection extends SFGeometry {
        static {
                Loader.load();
        }

        /**
         * Default constructor
         */
        public SFGeometryCollection() {
                allocate();
        }

        /**
         * Copy constructor
         * @param p
         */
        public SFGeometryCollection(Pointer p) {
                super(p);
        }

        /**
         * Call the native empty GeometryCollection constructor
         */
        private native void allocate();

        /**
         * Assign operator
         * @param other
         * @return Instance of SFGeometryCollection
         */
        @Name("operator=")
        public native @ByRef SFGeometryCollection assign(@ByRef SFGeometryCollection other);

        /**
         * @return Returns the clone of the GeometryCollection
         */
        public native SFGeometryCollection clone();

        /**
         * @return Returns the type of the GeometryCollection as string
         */
        public native @StdString String geometryType();

        /**
         * @return Returns the type of the GeometryCollection as integer
         */
        public native int geometryTypeId();

        /**
         * @return Returns the dimension of the GeometryCollection
         */
        public native int dimension();

        /**
         * @return Returns the coordinate dimension of the GeometryCollection
         */
        public native int coordinateDimension();

        /**
         * @return True, if the GeometryCollection is empty
         */
        public native @Cast("bool") boolean isEmpty();

        /**
         * @return True, if the GeometryCollectin is 3D
         */
        public native @Cast("bool") boolean is3D();

        /**
         * @return True, if the GeometryCollection is measured
         */
        public native @Cast("bool") boolean isMeasured();

        /**
         * @return Returns the number of the geometries in a GeometryCollection
         */
        public native @Cast("size_t") int numGeometries();

        /**
         * @return Returns the n-th geometry
         */
        public native @ByRef SFGeometry geometryN(@Cast("size_t") int n);

        /**
         * Add geometry to GeometryCollection
         * @param geometry SFGeometry Instance
         */
        public native void addGeometry(@ByRef SFGeometry geometry);

}
