package edu.pnu.stemlab.sfcgal4j;

import org.bytedeco.javacpp.Loader;
import org.bytedeco.javacpp.annotation.ByRef;
import org.bytedeco.javacpp.annotation.Cast;
import org.bytedeco.javacpp.annotation.Platform;
import org.bytedeco.javacpp.annotation.StdString;

/**
 * @author Donguk Seo
 *
 */
@Platform(include = {"cpp/SFCAPI.cpp"}, link = {"SFCGAL"})
public class SFCAPI {
        static {
                Loader.load();
        }

        public static native @ByRef SFGeometry SFCGAL_io_read_wkt(@ByRef @StdString String str,
                        @Cast("size_t") int len);

        public static void SFCGAL_io_write_binary_prepared(SFPreparedGeometry geom, String buffer,
                        int len) {
                SFCGAL_io_write_binary_prepared(geom, buffer.toCharArray(), len);
        }

        public static native void SFCGAL_io_write_binary_prepared(SFPreparedGeometry geom,
                        @Cast("char *") char[] buffer, @Cast("size_t") int len);

        public static native @ByRef SFPreparedGeometry SFCGAL_io_read_binary_prepared(
                        @StdString String str, @Cast("size_t") int len);

        public static native @ByRef SFPreparedGeometry SFCGAL_io_read_ewkt(@StdString String str,
                        @Cast("size_t") int len);

        public static native @ByRef SFGeometry SFCGAL_geometry_force_lhr(@ByRef SFGeometry g);

        public static native @ByRef SFGeometry SFCGAL_geometry_force_rhr(@ByRef SFGeometry g);

        public static native @ByRef SFTriangulatedSurface SFCGAL_geometry_triangulate_2dz(
                        @ByRef SFGeometry g);

}
