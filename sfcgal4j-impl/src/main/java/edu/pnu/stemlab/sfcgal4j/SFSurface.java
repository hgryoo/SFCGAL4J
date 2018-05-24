package edu.pnu.stemlab.sfcgal4j;

import org.bytedeco.javacpp.Loader;
import org.bytedeco.javacpp.Pointer;
import org.bytedeco.javacpp.annotation.Platform;

/**
 * @author Donguk Seo
 *
 */
@Platform(include = "cpp/SFSurface.cpp", link = {"SFCGAL"})
public class SFSurface extends SFGeometry {
        static {
                Loader.load();
        }

        public SFSurface() {
                allocate();
        }

        public SFSurface(Pointer p) {
                super(p);
        }

        private native void allocate();

        public native int dimension();

}
