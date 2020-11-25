Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B8E2C3D8C
	for <lists+linux-efi@lfdr.de>; Wed, 25 Nov 2020 11:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgKYKSL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Nov 2020 05:18:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:41942 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbgKYKSL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 25 Nov 2020 05:18:11 -0500
IronPort-SDR: YQz9Fu+ZYuh0WobzYa7tAC926AVqyWRSDpSpLiZha2vf+AMxxdPpAoO+HBHCZyLAbhckvtBulI
 C/zuTYZIACCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="190243536"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="190243536"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 02:18:10 -0800
IronPort-SDR: W/i4NbF5ocQe80xIq5poJW1+3vwD/cpqDETWGTnl0l9mhaA3OjVGP0Ko7DaYqJCyeq2lpRFS3d
 BmMsES/vjebg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="432910852"
Received: from irsmsx606.ger.corp.intel.com ([163.33.146.139])
  by fmsmga001.fm.intel.com with ESMTP; 25 Nov 2020 02:18:09 -0800
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 IRSMSX606.ger.corp.intel.com (163.33.146.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Nov 2020 10:18:09 +0000
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Wed, 25 Nov 2020 10:18:09 +0000
From:   "Rojewski, Cezary" <cezary.rojewski@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        =?utf-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: RE: [PATCH] efi/efivars: Set generic ops before loading SSDT
Thread-Topic: [PATCH] efi/efivars: Set generic ops before loading SSDT
Thread-Index: AQHWwar76Ck8rjZFGk+4rxJ9QUEbBKnWU6IAgAJQkeA=
Date:   Wed, 25 Nov 2020 10:18:09 +0000
Message-ID: <e20e4ae680184d808a48312233415b0d@intel.com>
References: <20201123172817.124146-1-amadeuszx.slawinski@linux.intel.com>
 <CAMj1kXEY14MWoCnMHTzGpyC7V8=dF3fxT44tDqzRXZtXRRf87w@mail.gmail.com>
In-Reply-To: <CAMj1kXEY14MWoCnMHTzGpyC7V8=dF3fxT44tDqzRXZtXRRf87w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gMjAyMC0xMS0yMyAxMTo1MyBQTSwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6DQo+IE9uIE1vbiwg
MjMgTm92IDIwMjAgYXQgMTY6MTEsIEFtYWRldXN6IFPFgmF3acWEc2tpDQo+IDxhbWFkZXVzengu
c2xhd2luc2tpQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gRWZpdmFyIGFsbG93cyBm
b3Igb3ZlcnJpZGluZyBvZiBTU0RUIHRhYmxlcywgaG93ZXZlciBzdGFydGluZyB3aXRoDQo+PiBj
b21taXQgYmY2N2ZhZDE5ZTQ5M2IgKCJlZmk6IFVzZSBtb3JlIGdyYW51bGFyIGNoZWNrIGZvciBh
dmFpbGFiaWxpdHkgZm9yIHZhcmlhYmxlIHNlcnZpY2VzIikNCj4+IHRoaXMgdXNlIGNhc2UgaXMg
YnJva2VuLiBXaGVuIGxvYWRpbmcgU1NEVCBnZW5lcmljIG9wcyBzaG91bGQgYmUgc2V0DQo+PiBm
aXJzdCwgaG93ZXZlciBtZW50aW9uZWQgY29tbWl0IHJldmVyc2VkIG9yZGVyIG9mIG9wZXJhdGlv
bnMuIEZpeCB0aGlzDQo+PiBieSByZXN0b3Jpbmcgb3JpZ2luYWwgb3JkZXIgb2Ygb3BlcmF0aW9u
cy4NCj4+DQo+PiBGaXhlczogYmY2N2ZhZDE5ZTQ5M2IgKCJlZmk6IFVzZSBtb3JlIGdyYW51bGFy
IGNoZWNrIGZvciBhdmFpbGFiaWxpdHkgZm9yIHZhcmlhYmxlIHNlcnZpY2VzIikNCj4+IFNpZ25l
ZC1vZmYtYnk6IEFtYWRldXN6IFPFgmF3acWEc2tpIDxhbWFkZXVzenguc2xhd2luc2tpQGxpbnV4
LmludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2Zpcm13YXJlL2VmaS9lZmkuYyB8IDIg
Ky0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2VmaS5jIGIvZHJpdmVycy9m
aXJtd2FyZS9lZmkvZWZpLmMNCj4+IGluZGV4IDVlNTQ4MGEwYTMyZC4uNmM2ZWVjMDQ0YTk3IDEw
MDY0NA0KPj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLmMNCj4+ICsrKyBiL2RyaXZl
cnMvZmlybXdhcmUvZWZpL2VmaS5jDQo+PiBAQCAtMzkwLDEwICszOTAsMTAgQEAgc3RhdGljIGlu
dCBfX2luaXQgZWZpc3Vic3lzX2luaXQodm9pZCkNCj4+DQo+PiAgICAgICAgICBpZiAoZWZpX3J0
X3NlcnZpY2VzX3N1cHBvcnRlZChFRklfUlRfU1VQUE9SVEVEX0dFVF9WQVJJQUJMRSB8DQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFRklfUlRfU1VQUE9SVEVEX0dF
VF9ORVhUX1ZBUklBQkxFX05BTUUpKSB7DQo+PiAtICAgICAgICAgICAgICAgZWZpdmFyX3NzZHRf
bG9hZCgpOw0KPj4gICAgICAgICAgICAgICAgICBlcnJvciA9IGdlbmVyaWNfb3BzX3JlZ2lzdGVy
KCk7DQo+PiAgICAgICAgICAgICAgICAgIGlmIChlcnJvcikNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIGVycl9wdXQ7DQo+PiArICAgICAgICAgICAgICAgZWZpdmFyX3NzZHRfbG9h
ZCgpOw0KPj4gICAgICAgICAgICAgICAgICBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfc2ltcGxl
KCJlZml2YXJzIiwgMCwgTlVMTCwgMCk7DQo+PiAgICAgICAgICB9DQo+Pg0KPiANCj4gVGhhbmtz
LiBRdWV1ZWQgYXMgYSBmaXguDQo+IA0KDQpTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuIFRoaXMg
aXMgYSBnb29kIGZpbmRpbmcgYnkgQW1hZGVvLiBJZiBpbiBhbnkNCmNhc2UgeW91IG5lZWQgbW9y
ZSBjcmVkaWJpbGl0eSwgZmVlbCBmcmVlIHRvIGFwcGx5IG15Og0KDQpUZXN0ZWQtYnk6IENlemFy
eSBSb2pld3NraSA8Y2V6YXJ5LnJvamV3c2tpQGludGVsLmNvbT4NCg0KQ3phcmVrDQoNCg==
