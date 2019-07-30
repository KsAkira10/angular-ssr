import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class LayoutService {

  get url(): string {
    return environment.wordPress.url;
  }

  constructor(private http: HttpClient) { }

  getPageBySlug(slug: string) {
    return this.http.get(`${this.url}/wp/v2/pages/?slug=${slug}`);
  }
}
