import {Controller} from "@hotwired/stimulus"
import hljs from 'highlight.js/lib/core';
import json from 'highlight.js/lib/languages/json';

export default class extends Controller {
  connect() {
    hljs.registerLanguage('json', json);
    const resultData = this.element.querySelector('.scrapeResult');
    hljs.highlightElement(resultData);
  }

}
