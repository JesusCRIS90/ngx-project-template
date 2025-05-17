import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

import { ModalWindowHostComponent } from "@beexy/ngx-modals"

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, ModalWindowHostComponent],
  templateUrl: './app.component.html',
})
export class AppComponent {
  title = 'ngx-template';
}
