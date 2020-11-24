Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A782C2B54
	for <lists+linux-efi@lfdr.de>; Tue, 24 Nov 2020 16:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389676AbgKXPaq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Nov 2020 10:30:46 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:25743 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389644AbgKXPaq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Nov 2020 10:30:46 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-117-FzTlDiKxMNmyd29DthU8XA-1; Tue, 24 Nov 2020 15:30:42 +0000
X-MC-Unique: FzTlDiKxMNmyd29DthU8XA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 24 Nov 2020 15:30:42 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 24 Nov 2020 15:30:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ard Biesheuvel' <ardb@kernel.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>
Subject: RE: Oops (probably) unmounting /oldroot/firmware/efi/efivars.
Thread-Topic: Oops (probably) unmounting /oldroot/firmware/efi/efivars.
Thread-Index: AdbCbM2Q6wdSIj4dRX6VFD+iYFiXewAAJveAAAEq0JAAACh8AAAA5OiA
Date:   Tue, 24 Nov 2020 15:30:42 +0000
Message-ID: <4bd4f6ca36334473bc55bf3b5704afa1@AcuMS.aculab.com>
References: <5f31cde519b941308412b3849197ee7c@AcuMS.aculab.com>
 <CAMj1kXHhetomAx4Kd5McnvZQev9j1d-C1Og7h+J7V009WTiwxA@mail.gmail.com>
 <3e96bbfe476b4b3d876e480ce6b20b58@AcuMS.aculab.com>
 <CAMj1kXE3xM__pA6eaXwWV=we4sWrnecH1f7oUbuyGeHc9TPmOg@mail.gmail.com>
In-Reply-To: <CAMj1kXE3xM__pA6eaXwWV=we4sWrnecH1f7oUbuyGeHc9TPmOg@mail.gmail.com>
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

RnJvbTogQXJkIEJpZXNoZXV2ZWwNCj4gU2VudDogMjQgTm92ZW1iZXIgMjAyMCAxNTowMg0KPiBP
biBUdWUsIDI0IE5vdiAyMDIwIGF0IDE1OjU4LCBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEFyZCBCaWVzaGV1dmVsDQo+ID4gPiBT
ZW50OiAyNCBOb3ZlbWJlciAyMDIwIDE0OjI0DQo+ID4gPg0KPiA+ID4gT24gVHVlLCAyNCBOb3Yg
MjAyMCBhdCAxNToyMiwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3Jv
dGU6DQo+ID4gPiA+DQo+ID4gPiA+IEkndmUganVzdCB1cGRhdGVkIHRvIHRoZSBoZWFkIG9mIExp
bnVzJ3MgdHJlZSAoNS4xMC1yYzUpIGFuZCBnb3QgdGhlIGZvbGxvd2luZw0KPiA+ID4gPiAnc3Bs
YXQnIGR1cmluZyBzaHV0ZG93bi4NCj4gPiA+ID4NCj4gPiA+ID4gVXNlcnNwYWNlIGlzIFVidW50
dSAyMC4wNC4NCj4gPiA+ID4NCj4gPiA+ID4gcmM0IHJlYm9vdGVkIGZpbmUuDQo+ID4gPiA+DQo+
ID4gPiA+IEknbGwgdHJ5IHRvIGJpc2VjdCAtIGJ1dCBpdCBpc24ndCBxdWljay4NCj4gPiA+ID4N
Cj4gPiA+DQo+ID4gPiBTdXJlbHkgY2F1c2VkIGJ5DQo+ID4gPg0KPiA+ID4NCj4gaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0
L2NvbW1pdC9mcy9lZml2YXJmcz9pZD1mZTUxODZjZjEyZTMwDQo+ID4gPiBmYWNmZTI2MWU5YmU2
Yzc5MDRhMTcwYmQ4MjINCj4gPg0KPiA+IFllcCwgcmVib290cyBmaW5lIHdpdGggdGhhdCBrZnJl
ZSgpIGNvbW1lbnRlZCBvdXQuDQo+ID4NCj4gDQo+IFRoYW5rcyBmb3IgY29uZmlybWluZy4NCj4g
DQo+IERvZXMgaXQgYWxzbyB3b3JrIHdoZW4ga2VlcGluZyB0aGUga2ZyZWUoKSBhbmQgc2V0dGlu
Zw0KPiBpbm9kZS0+aV9wcml2YXRlIHRvIE5VTEwgZXhwbGljaXRseSBhZnRlcndhcmRzPw0KDQpO
bywgdGhhdCBzdGlsbCBwYW5pY3MuDQpTZXR0aW5nIGlfcHJpdmF0ZSBOVUxMIChidXQgd2l0aG91
dCB0aGUga2ZyZWUoKSkgaXMgb2suDQoNCkknbSBzZWVpbmcgNDIgY2FsbHMgd2l0aCBhIG5vbi1O
VUxMIGlfcHJpdmF0ZS4NClRoZSBmaW5hbCBjYWxsIGhhcyBpX3ByaXZhdGUgTlVMTCBhbmQgaXNu
J3QgYSBkdXBsaWNhdGUuDQoNClRoZXJlIG11c3QgYmUgYW5vdGhlciBwb2ludGVyIGludG8gb25l
IG9mIHRoZSBzdHJ1Y3R1cmVzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

