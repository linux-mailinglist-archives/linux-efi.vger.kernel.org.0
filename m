Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A6D2C2A8C
	for <lists+linux-efi@lfdr.de>; Tue, 24 Nov 2020 15:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389273AbgKXO6D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Nov 2020 09:58:03 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:59282 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389257AbgKXO6C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Nov 2020 09:58:02 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-255-VP8lqU1sOG-3W9NXUVrPDQ-1; Tue, 24 Nov 2020 14:57:59 +0000
X-MC-Unique: VP8lqU1sOG-3W9NXUVrPDQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 24 Nov 2020 14:57:58 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 24 Nov 2020 14:57:58 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ard Biesheuvel' <ardb@kernel.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "jk@ozlabs.org" <jk@ozlabs.org>
Subject: RE: Oops (probably) unmounting /oldroot/firmware/efi/efivars.
Thread-Topic: Oops (probably) unmounting /oldroot/firmware/efi/efivars.
Thread-Index: AdbCbM2Q6wdSIj4dRX6VFD+iYFiXewAAJveAAAEq0JA=
Date:   Tue, 24 Nov 2020 14:57:58 +0000
Message-ID: <3e96bbfe476b4b3d876e480ce6b20b58@AcuMS.aculab.com>
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
MjAuMDQuDQo+ID4NCj4gPiByYzQgcmVib290ZWQgZmluZS4NCj4gPg0KPiA+IEknbGwgdHJ5IHRv
IGJpc2VjdCAtIGJ1dCBpdCBpc24ndCBxdWljay4NCj4gPg0KPiANCj4gU3VyZWx5IGNhdXNlZCBi
eQ0KPiANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC9mcy9lZml2YXJmcz9pZD1mZTUxODZjZjEyZTMwDQo+
IGZhY2ZlMjYxZTliZTZjNzkwNGExNzBiZDgyMg0KDQpZZXAsIHJlYm9vdHMgZmluZSB3aXRoIHRo
YXQga2ZyZWUoKSBjb21tZW50ZWQgb3V0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

