//
//  ComplicationController.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/30/21.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        handler(nil)
        /*let entry: CLKComplicationTimelineEntry
     
       switch complication.family {
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallStackText()
            template.line1TextProvider = CLKSimpleTextProvider(text: "PM10")
            template.line2TextProvider = CLKSimpleTextProvider(text: "75")
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
     
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallStackText()
            template.line1TextProvider = CLKSimpleTextProvider(text: "PM")
            template.line2TextProvider = CLKSimpleTextProvider(text: "75")
            entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
     
        default:
            preconditionFailure("Complication family not supported")
        }
     
        handler(entry) */
    }
}
