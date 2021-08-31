import 'dart:convert';

import 'package:openfoodfacts/model/KnowledgePanel.dart';
import 'package:openfoodfacts/model/KnowledgePanels.dart';
import 'package:test/test.dart';

void main() {
  // Verify that we can successfully load the Knowledge panel from a JSON string
  test('Load KP from JSON', () async {
    Map<String, dynamic> panels = {
      'doyouknow_brands_nutella_423': {
        'parent_panel_id': 'root',
        'type': 'doyouknow',
        'level': 'trivia',
        'topics': ['ingredients'],
        'title': 'Do you know why Nutella contains hazelnuts?',
        'subtitle': 'It all started after the second world war...',
        'elements': [
          {
            'element_type': 'text',
            'element': {
              'text_type': 'default',
              'html':
                  'Cocoa beans were expensive and hard to come by after the second world war, so in Piedmont (Italy) where Pietro Ferrero created Nutella, they were replaced with hazelnuts to make <em>gianduja</em>, a mix of hazelnut paste and chocolate.'
            }
          },
          {
            'element_type': 'image',
            'element': {
              'url':
                  'https://static.openfoodfacts.org/images/attributes/contains-nuts.png',
              'width': 192,
              'height': 192
            }
          }
        ]
      },
      'ecoscore': {
        'parent_panel_id': 'root',
        'type': 'ecoscore',
        'level': 'info',
        'topics': ['environment'],
        'title': 'Eco-Score D',
        'subtitle': 'High environmental impact',
        'grade': 'd',
        'icon_url':
            'https://static.openfoodfacts.org/images/attributes/ecoscore-d.svg',
        'elements': [
          {
            'element_type': 'text',
            'element': {
              'text_type': 'summary',
              'html':
                  'The <a href=\'https://world.openfoodfacts.org/eco-score-the-environmental-impact-of-food-products\'>Eco-Score</a> is an experimental score that summarizes the environmental impacts of food products.'
            }
          },
          {
            'element_type': 'text',
            'element': {
              'text_type': 'note',
              'html':
                  'The Eco-Score was initially developped for France and it is being extended to other European countries. The Eco-Score formula is subject to change as it is regularly improved to make it more precise and better suited to each country.'
            }
          },
          {
            'element_type': 'panel',
            'element': {'panel_id': 'ecoscore_lca'}
          },
          {
            'element_type': 'text',
            'element': {
              'text_type': 'warning',
              'html':
                  '<strong>Warning: some information necessary to calculate the Eco-Score with precision is not provided (see the details of the calculation below). You can edit the product to add the missing information.<br><br>If you are the manufacturer of this product, you can send us the information with our <a href=\'https://world.pro.openfoodfacts.org\'>free platform for producers</a>.'
            }
          }
        ]
      },
      'ecoscore_lca': {
        'parent_panel_id': 'ecoscore',
        'type': 'ecoscore_lca',
        'level': 'info',
        'topics': ['environment'],
        'title': 'Lifecyle Analysis (LCA) for the product category',
        'subtitle': 'Score: 40/100',
        'grade': 'b',
        'elements': [
          {
            'element_type': 'text',
            'element': {
              'text_type': 'summary',
              'html':
                  '<p>Agribalyse category: <a href=\'https://www.agribalyse.fr/app/aliments/31032\' title=\'Exact match with the product category\'>Chocolate spread with hazelnuts</a></p><ul><li>PEF environmental score: 0.74 (the lower the score, the lower the impact)</li><li>- including impact on climate change: 9.87 kg CO2 eq/kg of product</li></ul>'
            }
          },
          {
            'element_type': 'table',
            'element': {
              'table_id': 'ecoscore_lca_impacts_by_stages',
              'table_type': 'percents',
              'title': 'Details of the impacts by stages of the life cycle',
              'headers': ['Steps', 'Impact'],
              'rows': [
                {
                  'id': 'agriculture',
                  'icon_url':
                      'https://static.openfoodfacts.org/images/icons/dist/agriculture.svg',
                  'values': ['Agriculture', '82.7%'],
                  'percent': 82.7
                },
                {
                  'id': 'processing',
                  'values': ['Processing', '11.5%'],
                  'percent': 11.5
                },
                {
                  'id': 'packaging',
                  'values': ['Packaging', '2.8%'],
                  'percent': 2.8
                },
                {
                  'id': 'transportation',
                  'values': ['Transportation', '2.4%'],
                  'percent': 2.4
                },
                {
                  'id': 'distribution',
                  'values': ['Distribution', '0.6%'],
                  'percent': 0.6
                },
                {
                  'id': 'consumption',
                  'values': ['Consumption', '0.0%'],
                  'percent': 0
                }
              ]
            }
          }
        ]
      }
    };
    KnowledgePanels kp = KnowledgePanels.fromJson(panels);
    expect(kp.panelIdToPanelMap.length, equals(3));
  });

  // Verify that one KnowledgePanelElement must have a known KP element.
  test('Unknown Element in JSON', () async {
    Map<String, dynamic> panels = {
      'doyouknow_brands_nutella_423': {
        'parent_panel_id': 'root',
        'type': 'doyouknow',
        'level': 'trivia',
        'topics': ['ingredients'],
        'title': 'Do you know why Nutella contains hazelnuts?',
        'subtitle': 'It all started after the second world war...',
        'elements': [
          {
            'element_type': 'unknown',
            'element': {
              'text_type': 'summary',
              'html':
                  'Cocoa beans were expensive and hard to come by after the second world war, so in Piedmont (Italy) where Pietro Ferrero created Nutella, they were replaced with hazelnuts to make <em>gianduja</em>, a mix of hazelnut paste and chocolate.'
            }
          }
        ]
      },
    };
    expect(() => KnowledgePanels.fromJson(panels), throwsArgumentError);
  });
}