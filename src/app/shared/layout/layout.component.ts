import { Component, OnInit, Inject, PLATFORM_ID } from '@angular/core';
import { LayoutService } from './layout.service';
import { ActivatedRoute } from '@angular/router';
import { isPlatformBrowser } from '@angular/common';

@Component({
  selector: 'app-layout',
  templateUrl: './layout.component.html',
  styleUrls: ['./layout.component.scss']
})
export class LayoutComponent implements OnInit {
  constructor(
    private layoutService: LayoutService,
    private activatedRoute: ActivatedRoute,
    @Inject(PLATFORM_ID) private platformId: object
  ) {
    if (isPlatformBrowser(this.platformId)) {
      this.activatedRoute.params.subscribe(next => {
        console.log('next ==>', next);
      });
    }
  }

  ngOnInit() {
    if (isPlatformBrowser(this.platformId)) {
      this.pageInitialize();
    }
  }

  pageInitialize() {
    this.layoutService.getPageBySlug('home').subscribe((data: any[]) => {
      console.log(data);
    });
  }
}
