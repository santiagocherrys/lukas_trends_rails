import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['toggle', 'sidebar', 'openIcon', 'closeIcon'];

  #openedClasses = 'w-72'.split(' ');
  #closedClasses = 'w-0 overflow-hidden border-none'.split(' ');

  connect() {}

  toggle() {
    const isOpen = this.toggleTarget.getAttribute('aria-expanded') === 'true';
    console.log({ isOpen });
    isOpen ? this._close() : this._open();
  }

  _open() {
    this.toggleTarget.setAttribute('aria-expanded', 'true');
    // Hide open icon
    this.openIconTarget.classList.add('hidden');
    // Show close icon
    this.closeIconTarget.classList.remove('hidden');
    // Show sidebar element
    this.sidebarTarget.classList.remove(...this.#closedClasses);
    this.sidebarTarget.classList.add(...this.#openedClasses);
  }

  _close() {
    this.toggleTarget.setAttribute('aria-expanded', 'false');
    // Show open icon
    this.openIconTarget.classList.remove('hidden');
    // Hide close icon
    this.closeIconTarget.classList.add('hidden');
    // Hide sidebar element
    this.sidebarTarget.classList.remove(...this.#openedClasses);
    this.sidebarTarget.classList.add(...this.#closedClasses);
  }
}
