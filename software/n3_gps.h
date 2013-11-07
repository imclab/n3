/**
 * A high-level interface to the GPS receiver.
 */

#ifndef N3_GPS_H
#define N3_GPS_H

#include "TinyGPS/TinyGPS.h"
#include "os_coord/os_coord.h"

/**
 * The maximum number of milliseconds ago the last GPS fix was read before it is
 * considered stale and thus invalid.
 */
#define GPS_MAX_AGE 10000

typedef enum n3_gps_fix_type {
	N3_GPS_NO_FIX = 1,
	N3_GPS_2D_FIX = 2,
	N3_GPS_3D_FIX = 3,
} n3_gps_fix_type_t;


class N3_GPS {
	public:
		/**
		 * Set everything up. Sets the given serial port's baudrate.
		 */
		N3_GPS( HardwareSerial *serial
		      , uint32          baudrate
		      );
		
		void begin(void);
		
		
		/**
		 * Read and parse any new input from the serial port.
		 */
		void update(void);
		
		
		/**
		 * Have we got a GPS fix?
		 */
		bool is_fixed(void);
		
		
		/**
		 * What type of fix do we have?
		 */
		n3_gps_fix_type_t fix_type(void);
		
		
		/**
		 * How many satellites are being tracked?
		 */
		int get_num_satellites(void);
		
		
		/**
		 * Get the WGS84 coordinates currently reported by the GPS receiver.
		 */
		os_lat_lon_t get_coordinates(void);
		
		
		/**
		 * Get the GPS receiver's average-MSL corrected altitude.
		 */
		double get_altitude(void);
		
		
		/**
		 * Get the current course (in degrees).
		 */
		double get_course(void);
		
		
		/**
		 * Get the current speed (in km/h)
		 */
		double get_speed(void);
		
		
		/**
		 * Get the current GPS date/time.
		 */
		void get_datetime(int *yr, int *mo, int *dy, int *hr, int *mi, int *se);
	
	protected:
		HardwareSerial *serial;
		uint32 baudrate;
		TinyGPS gps;
		
		/**
		 * Given a nema sentence which starts with $ and ends with *xx\r\n\0 where "xx"
		 * means any two bytes, modifies the string to contain the checksum where xx
		 * were.
		 */
		void add_checksum(char *nema_string);
};


#endif
