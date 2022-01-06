//
//  ComplicationController.swift
//  Extrasensory WatchKit Extension
//
//  Created by Faraz Abidi on 12/30/21.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        let template = self.placeholderTemplate(family: complication.family)
        let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
        handler(entry)
    }
    
    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "Extrasensory", supportedFamilies: CLKComplicationFamily.allCases)
        ]

        handler(descriptors)
    }
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
            let template = self.placeholderTemplate(family: complication.family)
            handler(template)
        }
    
    func placeholderTemplate(family: CLKComplicationFamily) -> CLKComplicationTemplate {
            let appNameTextProvider = CLKSimpleTextProvider(text: NSLocalizedString("Extrasensory", comment: "Extrasensory"))
            let simpleTextProvider = CLKSimpleTextProvider(text: "🔮")
            let purpleColor = UIColor(red: 66/255, green: 38/255, blue: 128/255, alpha: 1)
            let gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: purpleColor, fillFraction: 1.0)
            let tintColor = purpleColor

            switch family {
            case .circularSmall:
                let template = CLKComplicationTemplateCircularSmallSimpleText()
                template.textProvider = simpleTextProvider
                template.tintColor = tintColor
                return template

            case .extraLarge:
                let template = CLKComplicationTemplateExtraLargeSimpleText()
                template.textProvider = simpleTextProvider
                template.tintColor = tintColor
                return template

            case .modularSmall:
                let template = CLKComplicationTemplateModularSmallSimpleText()
                template.textProvider = simpleTextProvider
                template.tintColor = tintColor
                return template

            case .modularLarge:
                let template = CLKComplicationTemplateModularLargeTallBody()
                template.headerTextProvider = appNameTextProvider
                template.bodyTextProvider = simpleTextProvider
                template.tintColor = tintColor
                return template

            case .utilitarianSmall:
                let template = CLKComplicationTemplateUtilitarianSmallFlat()
                template.textProvider = simpleTextProvider
                template.tintColor = tintColor
                return template

            case .utilitarianSmallFlat:
                let template = CLKComplicationTemplateUtilitarianSmallFlat()
                template.textProvider = simpleTextProvider
                template.tintColor = tintColor
                return template

            case .utilitarianLarge:
                let template = CLKComplicationTemplateUtilitarianLargeFlat()
                template.textProvider = appNameTextProvider
                template.tintColor = tintColor
                return template

            case .graphicCorner:
                let template = CLKComplicationTemplateGraphicCornerGaugeText()
                template.outerTextProvider = simpleTextProvider
                template.leadingTextProvider = CLKSimpleTextProvider(text: "")
                template.trailingTextProvider = CLKSimpleTextProvider(text: "")
                template.gaugeProvider = gaugeProvider
                return template

            case .graphicCircular:
                let template = CLKComplicationTemplateGraphicCircularOpenGaugeRangeText()
                template.centerTextProvider = simpleTextProvider
                template.leadingTextProvider = CLKSimpleTextProvider(text: "")
                template.trailingTextProvider = CLKSimpleTextProvider(text: "")
                template.gaugeProvider = gaugeProvider
                return template

            case .graphicBezel:
                let template = CLKComplicationTemplateGraphicBezelCircularText()
                let circularTemplate = self.placeholderTemplate(family: .graphicCircular)
                template.circularTemplate = circularTemplate as! CLKComplicationTemplateGraphicCircular
                template.textProvider = simpleTextProvider
                return template

            case .graphicRectangular:
                let template = CLKComplicationTemplateGraphicRectangularTextGauge()
                template.headerTextProvider = appNameTextProvider
                template.body1TextProvider = CLKSimpleTextProvider(text: NSLocalizedString("Build a habit", comment: ""))
                
                template.gaugeProvider = gaugeProvider
                return template

            case .graphicExtraLarge:
                    let template = CLKComplicationTemplateGraphicExtraLargeCircularOpenGaugeRangeText()
                    template.centerTextProvider = simpleTextProvider
                    template.leadingTextProvider = CLKSimpleTextProvider(text: "")
                    template.trailingTextProvider = CLKSimpleTextProvider(text: "")
                    template.gaugeProvider = gaugeProvider
                    template.tintColor = tintColor
                
                return template
            }
        }
}


