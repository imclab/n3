/**
 * Display information about visible satellites.
 */

#ifndef N3_UI_SATELLITES_H
#define N3_UI_SATELLITES_H

#include "n3_ui.h"
#include "n3_gps.h"



class N3_UI_Satellites_Window : public N3_UI_Window {
	public:
		/**
		 * Indicates whether the window contains valid data. If false, it is only
		 * legal to call is_valid() and unfocus().
		 */
		virtual bool is_valid(void) { return true; }
		
		/**
		 * Attempt to give this window focus.
		 */
		virtual void focus(void);
		
		/**
		 * Update the screen. Called periodically while focused.
		 */
		virtual void update(void);
		
		/**
		 * The window is nolonger focused, update will nolonger be called.
		 */
		virtual void unfocus(void) { /* Nothing to do. */ }
		
		
		/**
		 * Returns a pointer to an array of 8 bytes containing the bitmap to display
		 * on the left of the splash screen like so for a given character position:
		 *
		 *   012
		 *   345
		 */
		virtual uint8 *get_splash_icon(int char_num);
		
		
		/**
		 * Return the text to display on the splash screen. Must return a string for
		 * the given line number.
		 */
		virtual const char *get_splash_text(int line_no);
	
	protected:
		int               last_num_sats;
		n3_gps_fix_type_t last_fix_type;
};

#endif



