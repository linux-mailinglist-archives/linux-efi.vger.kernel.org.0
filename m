Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBD13D5899
	for <lists+linux-efi@lfdr.de>; Mon, 26 Jul 2021 13:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhGZK6W (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Jul 2021 06:58:22 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:28831 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbhGZK6W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Jul 2021 06:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1627299531; x=1658835531;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=JAoV+loOGayoN3P+8B7pfMuTTZBhby5BKgUEHBwql6o=;
  b=azj6SxvChoVL78HosyYRhAcIIIlcvzXbkNRncPqNSyX/FX0XZhsOQ779
   YGFsvEVyYahWIFyauE2fiFqNXzcq8Nh/Wnmfnh7LjNPHD4cIns3XGTEoZ
   +8DzJ8IPuDEDe2vE5FqStvB3inE8H5s9nivkjtwqSHp/ING4KQ6w7kKE/
   Y=;
X-IronPort-AV: E=Sophos;i="5.84,270,1620691200"; 
   d="scan'208";a="124836492"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 26 Jul 2021 11:38:43 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 318B6A20CE;
        Mon, 26 Jul 2021 11:38:42 +0000 (UTC)
Received: from EX13D21UWB002.ant.amazon.com (10.43.161.177) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 26 Jul 2021 11:38:41 +0000
Received: from EX13D21UWB003.ant.amazon.com (10.43.161.212) by
 EX13D21UWB002.ant.amazon.com (10.43.161.177) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 26 Jul 2021 11:38:41 +0000
Received: from EX13D21UWB003.ant.amazon.com ([10.43.161.212]) by
 EX13D21UWB003.ant.amazon.com ([10.43.161.212]) with mapi id 15.00.1497.023;
 Mon, 26 Jul 2021 11:38:41 +0000
From:   "Herrenschmidt, Benjamin" <benh@amazon.com>
To:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>
Subject: Re: [PATCH v2 1/2] efi/libstub: arm64: Force Image reallocation if
 BSS was not reserved
Thread-Topic: [PATCH v2 1/2] efi/libstub: arm64: Force Image reallocation if
 BSS was not reserved
Thread-Index: AQHXghLImLvGeWgFTkKbayqTIQJlrw==
Date:   Mon, 26 Jul 2021 11:38:40 +0000
Message-ID: <623320927a63fb11f9bfb8f6771037052b3680f6.camel@amazon.com>
References: <20210726100922.120029-1-ardb@kernel.org>
         <20210726100922.120029-2-ardb@kernel.org>
In-Reply-To: <20210726100922.120029-2-ardb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.216]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC248CF2E7EE664794348C0FC0CE6EC5@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

TG9va3MgZ29vZCBidXQgSSdsbCB0cnkgdG8gYWN0dWFsbHkgdGVzdCBpdCBvbiBteSByZXByby1z
ZXR1cCB0b21vcnJvdy4NCg0KQ2hlZXJzLA0KQmVuLg0KDQo+IE9uIE1vbiwgMjAyMS0wNy0yNiBh
dCAxMjowOSArMDIwMCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6DQo+IERpc3RybyB2ZXJzaW9ucyBv
ZiBHUlVCIHJlcGxhY2UgdGhlIHVzdWFsIExvYWRJbWFnZS9TdGFydEltYWdlIGNhbGxzDQo+IHVz
ZWQgdG8gbG9hZCB0aGUga2VybmVsIGltYWdlIHdpdGggc29tZSBsb2NhbCBjb2RlIHRoYXQgZmFp
bHMgdG8NCj4gaG9ub3INCj4gdGhlIGFsbG9jYXRpb24gcmVxdWlyZW1lbnRzIGRlc2NyaWJlZCBp
biB0aGUgUEUvQ09GRiBoZWFkZXIsIGFzIGl0DQo+IGRvZXMgbm90IGFjY291bnQgZm9yIHRoZSBp
bWFnZSdzIEJTUyBzZWN0aW9uIGF0IGFsbDogaXQgZmFpbHMgdG8NCj4gYWxsb2NhdGUgc3BhY2Ug
Zm9yIGl0LCBhbmQgZmFpbHMgdG8gemVybyBpbml0aWFsaXplIGl0Lg0KPiANCj4gU2luY2UgdGhl
IEVGSSBzdHViIGl0c2VsZiBpcyBhbGxvY2F0ZWQgaW4gdGhlIC5pbml0IHNlZ21lbnQsIHdoaWNo
IGlzDQo+IGluIHRoZSBtaWRkbGUgb2YgdGhlIGltYWdlLCBpdHMgQlNTIHNlY3Rpb24gaXMgbm90
IGltcGFjdGVkIGJ5IHRoaXMsDQo+IGFuZCB0aGUgbWFpbiBjb25zZXF1ZW5jZSBvZiB0aGlzIG9t
aXNzaW9uIGlzIHRoYXQgdGhlIEJTUyBzZWN0aW9uIG1heQ0KPiBvdmVybGFwIHdpdGggbWVtb3J5
IHJlZ2lvbnMgdGhhdCBhcmUgYWxyZWFkeSB1c2VkIGJ5IHRoZSBmaXJtd2FyZS4NCj4gDQo+IFNv
IGxldCdzIHdhcm4gYWJvdXQgdGhpcyBjb25kaXRpb24sIGFuZCBmb3JjZSBpbWFnZSByZWFsbG9j
YXRpb24gdG8NCj4gb2NjdXIgaW4gdGhpcyBjYXNlLCB3aGljaCB3b3JrcyBhcm91bmQgdGhlIHBy
b2JsZW0uDQo+IA0KPiBGaXhlczogODIwNDY3MDJlMjg4ICgiZWZpL2xpYnN0dWIvYXJtNjQ6IFJl
cGxhY2UgJ3ByZWZlcnJlZCcgb2Zmc2V0DQo+IHdpdGggYWxpZ25tZW50IGNoZWNrIikNCj4gU2ln
bmVkLW9mZi1ieTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBk
cml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2FybTY0LXN0dWIuYyB8IDQ5ICsrKysrKysrKysr
KysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvYXJt
NjQtc3R1Yi5jDQo+IGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9hcm02NC1zdHViLmMN
Cj4gaW5kZXggN2JmMGE3YWNhZTVlLi4zNjk4YzFjZTI5NDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvYXJtNjQtc3R1Yi5jDQo+ICsrKyBiL2RyaXZlcnMvZmly
bXdhcmUvZWZpL2xpYnN0dWIvYXJtNjQtc3R1Yi5jDQo+IEBAIC0zNCw2ICszNCw1MSBAQCBlZmlf
c3RhdHVzX3QgY2hlY2tfcGxhdGZvcm1fZmVhdHVyZXModm9pZCkNCj4gIAlyZXR1cm4gRUZJX1NV
Q0NFU1M7DQo+ICB9DQo+ICANCj4gKy8qDQo+ICsgKiBEaXN0cm8gdmVyc2lvbnMgb2YgR1JVQiBt
YXkgaWdub3JlIHRoZSBCU1MgYWxsb2NhdGlvbiBlbnRpcmVseQ0KPiAoaS5lLiwgZmFpbA0KPiAr
ICogdG8gcHJvdmlkZSBzcGFjZSwgYW5kIGZhaWwgdG8gemVybyBpdCkuIENoZWNrIGZvciB0aGlz
IGNvbmRpdGlvbg0KPiBieSBkb3VibGUNCj4gKyAqIGNoZWNraW5nIHRoYXQgdGhlIGZpcnN0IGFu
ZCB0aGUgbGFzdCBieXRlIG9mIHRoZSBpbWFnZSBhcmUNCj4gY292ZXJlZCBieSB0aGUNCj4gKyAq
IHNhbWUgRUZJIG1lbW9yeSBtYXAgZW50cnkuDQo+ICsgKi8NCj4gK3N0YXRpYyBib29sIGNoZWNr
X2ltYWdlX3JlZ2lvbih1NjQgYmFzZSwgdTY0IHNpemUpDQo+ICt7DQo+ICsJdW5zaWduZWQgbG9u
ZyBtYXBfc2l6ZSwgZGVzY19zaXplLCBidWZmX3NpemU7DQo+ICsJZWZpX21lbW9yeV9kZXNjX3Qg
Km1lbW9yeV9tYXA7DQo+ICsJc3RydWN0IGVmaV9ib290X21lbW1hcCBtYXA7DQo+ICsJZWZpX3N0
YXR1c190IHN0YXR1czsNCj4gKwlib29sIHJldCA9IGZhbHNlOw0KPiArCWludCBtYXBfb2Zmc2V0
Ow0KPiArDQo+ICsJbWFwLm1hcCA9CSZtZW1vcnlfbWFwOw0KPiArCW1hcC5tYXBfc2l6ZSA9CSZt
YXBfc2l6ZTsNCj4gKwltYXAuZGVzY19zaXplID0JJmRlc2Nfc2l6ZTsNCj4gKwltYXAuZGVzY192
ZXIgPQlOVUxMOw0KPiArCW1hcC5rZXlfcHRyID0JTlVMTDsNCj4gKwltYXAuYnVmZl9zaXplID0J
JmJ1ZmZfc2l6ZTsNCj4gKw0KPiArCXN0YXR1cyA9IGVmaV9nZXRfbWVtb3J5X21hcCgmbWFwKTsN
Cj4gKwlpZiAoc3RhdHVzICE9IEVGSV9TVUNDRVNTKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsN
Cj4gKwlmb3IgKG1hcF9vZmZzZXQgPSAwOyBtYXBfb2Zmc2V0IDwgbWFwX3NpemU7IG1hcF9vZmZz
ZXQgKz0NCj4gZGVzY19zaXplKSB7DQo+ICsJCWVmaV9tZW1vcnlfZGVzY190ICptZCA9ICh2b2lk
ICopbWVtb3J5X21hcCArDQo+IG1hcF9vZmZzZXQ7DQo+ICsJCXU2NCBlbmQgPSBtZC0+cGh5c19h
ZGRyICsgbWQtPm51bV9wYWdlcyAqDQo+IEVGSV9QQUdFX1NJWkU7DQo+ICsNCj4gKwkJLyoNCj4g
KwkJICogRmluZCB0aGUgcmVnaW9uIHRoYXQgY292ZXJzIGJhc2UsIGFuZCByZXR1cm4gd2hldGhl
cg0KPiArCQkgKiBpdCBjb3ZlcnMgYmFzZStzaXplIGJ5dGVzLg0KPiArCQkgKi8NCj4gKwkJaWYg
KGJhc2UgPj0gbWQtPnBoeXNfYWRkciAmJiBiYXNlIDwgZW5kKSB7DQo+ICsJCQlyZXQgPSAoYmFz
ZSArIHNpemUpIDw9IGVuZDsNCj4gKwkJCWJyZWFrOw0KPiArCQl9DQo+ICsJfQ0KPiArDQo+ICsJ
ZWZpX2JzX2NhbGwoZnJlZV9wb29sLCBtZW1vcnlfbWFwKTsNCj4gKw0KPiArCXJldHVybiByZXQ7
DQo+ICt9DQo+ICsNCj4gIC8qDQo+ICAgKiBBbHRob3VnaCByZWxvY2F0YWJsZSBrZXJuZWxzIGNh
biBmaXggdXAgdGhlIG1pc2FsaWdubWVudCB3aXRoDQo+IHJlc3BlY3QgdG8NCj4gICAqIE1JTl9L
SU1HX0FMSUdOLCB0aGUgcmVzdWx0aW5nIHZpcnR1YWwgdGV4dCBhZGRyZXNzZXMgYXJlIHN1YnRs
eQ0KPiBvdXQgb2YNCj4gQEAgLTkyLDcgKzEzNyw5IEBAIGVmaV9zdGF0dXNfdCBoYW5kbGVfa2Vy
bmVsX2ltYWdlKHVuc2lnbmVkIGxvbmcNCj4gKmltYWdlX2FkZHIsDQo+ICAJfQ0KPiAgDQo+ICAJ
aWYgKHN0YXR1cyAhPSBFRklfU1VDQ0VTUykgew0KPiAtCQlpZiAoSVNfQUxJR05FRCgodTY0KV90
ZXh0LCBtaW5fa2ltZ19hbGlnbigpKSkgew0KPiArCQlpZiAoIWNoZWNrX2ltYWdlX3JlZ2lvbigo
dTY0KV90ZXh0LCBrZXJuZWxfbWVtc2l6ZSkpIHsNCj4gKwkJCWVmaV9lcnIoIkZJUk1XQVJFIEJV
RzogSW1hZ2UgQlNTIG92ZXJsYXBzDQo+IGFkamFjZW50IEVGSSBtZW1vcnkgcmVnaW9uXG4iKTsN
Cj4gKwkJfSBlbHNlIGlmIChJU19BTElHTkVEKCh1NjQpX3RleHQsIG1pbl9raW1nX2FsaWduKCkp
KSB7DQo+ICAJCQkvKg0KPiAgCQkJICogSnVzdCBleGVjdXRlIGZyb20gd2hlcmV2ZXIgd2Ugd2Vy
ZSBsb2FkZWQgYnkNCj4gdGhlDQo+ICAJCQkgKiBVRUZJIFBFL0NPRkYgbG9hZGVyIGlmIHRoZSBh
bGlnbm1lbnQgaXMNCj4gc3VpdGFibGUuDQo=
