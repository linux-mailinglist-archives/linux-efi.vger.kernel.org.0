Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FA82C29EA
	for <lists+linux-efi@lfdr.de>; Tue, 24 Nov 2020 15:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389159AbgKXOnF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Nov 2020 09:43:05 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:29784 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388784AbgKXOnF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Nov 2020 09:43:05 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-256-sjOgxl-7M5qNyQiFRe9n-Q-1; Tue, 24 Nov 2020 14:43:01 +0000
X-MC-Unique: sjOgxl-7M5qNyQiFRe9n-Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 24 Nov 2020 14:42:58 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 24 Nov 2020 14:42:58 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ard Biesheuvel' <ardb@kernel.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>
Subject: RE: Oops (probably) unmounting /oldroot/firmware/efi/efivars.
Thread-Topic: Oops (probably) unmounting /oldroot/firmware/efi/efivars.
Thread-Index: AdbCbM2Q6wdSIj4dRX6VFD+iYFiXewAAJveAAAB+INA=
Date:   Tue, 24 Nov 2020 14:42:58 +0000
Message-ID: <8aea350dd7714d0ab95e9b2fb7cd013d@AcuMS.aculab.com>
References: <5f31cde519b941308412b3849197ee7c@AcuMS.aculab.com>
 <CAMj1kXHhetomAx4Kd5McnvZQev9j1d-C1Og7h+J7V009WTiwxA@mail.gmail.com>
In-Reply-To: <CAMj1kXHhetomAx4Kd5McnvZQev9j1d-C1Og7h+J7V009WTiwxA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

RnJvbTogQXJkIEJpZXNoZXV2ZWwNCj4gU2VudDogMjQgTm92ZW1iZXIgMjAyMCAxNDoyNA0KPiAN
Cj4gT24gVHVlLCAyNCBOb3YgMjAyMCBhdCAxNToyMiwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJJ3ZlIGp1c3QgdXBkYXRlZCB0byB0aGUg
aGVhZCBvZiBMaW51cydzIHRyZWUgKDUuMTAtcmM1KSBhbmQgZ290IHRoZSBmb2xsb3dpbmcNCj4g
PiAnc3BsYXQnIGR1cmluZyBzaHV0ZG93bi4NCj4gPg0KPiA+IFVzZXJzcGFjZSBpcyBVYnVudHUg
MjAuMDQuDQoNCkFueW9uZSBmcm9tIHVidW50dSBrbm93IGhvdyB0byBnZXQgdGhlIGtlcm5lbCBz
dGFjayB0cmFjZWJhY2sNCndpdGhvdXQgc2V0dGluZyB1cCBhIHNlcmlhbCBjb25zb2xlPw0KSXQg
c2VlbXMgdG8gYmUgY29tcGxldGVseSBicm9rZW4gYnkgcnVubmluZyB0aGUgZ3JhcGhpY2FsIGxv
Z2luDQpvbiB0dHkwLg0KDQo+ID4NCj4gPiByYzQgcmVib290ZWQgZmluZS4NCj4gPg0KPiA+IEkn
bGwgdHJ5IHRvIGJpc2VjdCAtIGJ1dCBpdCBpc24ndCBxdWljay4NCj4gPg0KPiANCj4gU3VyZWx5
IGNhdXNlZCBieQ0KPiANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC9mcy9lZml2YXJmcz9pZD1mZTUxODZj
ZjEyZTMwDQo+IGZhY2ZlMjYxZTliZTZjNzkwNGExNzBiZDgyMg0KDQpZZXMsIEknbSBidWlsZGlu
ZyB3aXRoIHRoYXQgY29tbWVudGVkIG91dC4NCg0KQnV0IHRoZSBzeXN0ZW0gaGFzIGRlY2lkZWQg
dG8gZG8gYSBmdWxsIGJ1aWxkLg0KDQpJIHN1c3BlY3QgaXQgbWlnaHQgbmVlZCBpbm9kZS0+aV9w
cml2YXRlID0gTlVMTDsNCkJ1dCB0aGF0IG1pZ2h0IGxlYWQgdG8gYSBOVUxMIHBvaW50ZXIgZGVy
ZWYgZWxzZXdoZXJlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

