import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  addScrapeRule(event) {
    event.preventDefault();

    const template = document.getElementById('scrapeRuleTemplate');
    const scrapeRule = document.importNode(template.content, true);

    const ruleGroups = document.getElementById('scrapeRules');
    ruleGroups.appendChild(scrapeRule);
  }

  deleteScrapeRule(event) {
    event.preventDefault();
    const rule = event.target.closest('.scrapeRule');
    rule.remove();
  }
}
