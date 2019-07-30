import { CommonModule } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';

import { LayoutComponent } from './layout.component';
import { LayoutService } from './layout.service';
import { RouterModule } from '@angular/router';

@NgModule({
  declarations: [LayoutComponent],
  imports: [
    CommonModule,
    HttpClientModule,
    RouterModule
  ],
  exports: [LayoutComponent],
  bootstrap: [LayoutComponent],
  providers: [LayoutService]
})
export class LayoutModule {}
