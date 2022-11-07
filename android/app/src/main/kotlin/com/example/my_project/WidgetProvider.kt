package com.appwidgetflutter

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider


class AppWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { 
// Open App on Widget Click


val counter = widgetData.getInt("ff_initialtotalwater", 0)

var counterText = "Your counter value is: $counter"



// Pending intent to update counter on button click
val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context,
Uri.parse("watetlo://main_fixed_widget"))

            
        }
    }
}