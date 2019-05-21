Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C54A24EDC
	for <lists+linux-efi@lfdr.de>; Tue, 21 May 2019 14:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfEUMUL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 May 2019 08:20:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:10151 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfEUMUL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 21 May 2019 08:20:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 05:20:10 -0700
X-ExtLoop1: 1
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by fmsmga001.fm.intel.com with ESMTP; 21 May 2019 05:20:09 -0700
Received: from irsmsx112.ger.corp.intel.com ([169.254.1.197]) by
 irsmsx110.ger.corp.intel.com ([169.254.15.227]) with mapi id 14.03.0415.000;
 Tue, 21 May 2019 13:20:08 +0100
From:   "Bradford, Robert" <robert.bradford@intel.com>
To:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v2] efi: Check the number of EFI configuration tables
 entries
Thread-Topic: [PATCH v2] efi: Check the number of EFI configuration tables
 entries
Thread-Index: AQHU9DtCE7HpNgUsu0GgcWIIqYr/B6Z1pdQA
Date:   Tue, 21 May 2019 12:20:08 +0000
Message-ID: <145f1fac860402629bc8a9c67cc23be39f201e80.camel@intel.com>
References: <20190416095958.26163-1-robert.bradford@intel.com>
In-Reply-To: <20190416095958.26163-1-robert.bradford@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.20.192]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D49C702C001E246A258C6E06BE5CEC2@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gVHVlLCAyMDE5LTA0LTE2IGF0IDEwOjU5ICswMTAwLCBSb2IgQnJhZGZvcmQgd3JvdGU6DQo+
IE9ubHkgdHJ5IGFuZCBhY2Nlc3MgdGhlIEVGSSBjb25maWd1cmF0aW9uIHRhYmxlcyBpZiB0aGVy
ZSB0aGVyZSBhcmUNCj4gYW55DQo+IHJlcG9ydGVkLiBUaGlzIGFsbG93cyBFRkkgdG8gYmUgY29u
dGludWVkIHRvIHVzZWQgb24gc3lzdGVtcyB3aGVyZQ0KPiB0aGVyZQ0KPiBhcmUgbm8gY29uZmln
dXJhdGlvbiB0YWJsZSBlbnRyaWVzLg0KPiANCj4gdjI6IE1vdmUgcmV0dXJuIG9uIG5yX3RhYmxl
cz09MCBlYXJsaWVyDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2IgQnJhZGZvcmQgPHJvYmVydC5i
cmFkZm9yZEBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgYXJjaC94ODYvcGxhdGZvcm0vZWZpL3F1aXJr
cy5jIHwgMyArKysNCj4gIGRyaXZlcnMvZmlybXdhcmUvZWZpL2VmaS5jICAgICB8IDMgKysrDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L3BsYXRmb3JtL2VmaS9xdWlya3MuYw0KPiBiL2FyY2gveDg2L3BsYXRmb3JtL2VmaS9x
dWlya3MuYw0KPiBpbmRleCA5NWU3N2E2NjdiYTUuLjZiOWE0NzkyMjQyYiAxMDA2NDQNCj4gLS0t
IGEvYXJjaC94ODYvcGxhdGZvcm0vZWZpL3F1aXJrcy5jDQo+ICsrKyBiL2FyY2gveDg2L3BsYXRm
b3JtL2VmaS9xdWlya3MuYw0KPiBAQCAtNDcxLDYgKzQ3MSw5IEBAIGludCBfX2luaXQgZWZpX3Jl
dXNlX2NvbmZpZyh1NjQgdGFibGVzLCBpbnQNCj4gbnJfdGFibGVzKQ0KPiAgCXZvaWQgKnAsICp0
YWJsZXA7DQo+ICAJc3RydWN0IGVmaV9zZXR1cF9kYXRhICpkYXRhOw0KPiAgDQo+ICsJaWYgKG5y
X3RhYmxlcyA9PSAwKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiAgCWlmICghZWZpX3NldHVwKQ0K
PiAgCQlyZXR1cm4gMDsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9lZmkv
ZWZpLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9lZmkuYw0KPiBpbmRleCA0MTU4NDliYWIyMzMu
LjE4NTQyNGE4Yjg3OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLmMN
Cj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLmMNCj4gQEAgLTYyOCw2ICs2MjgsOSBA
QCBpbnQgX19pbml0DQo+IGVmaV9jb25maWdfaW5pdChlZmlfY29uZmlnX3RhYmxlX3R5cGVfdCAq
YXJjaF90YWJsZXMpDQo+ICAJdm9pZCAqY29uZmlnX3RhYmxlczsNCj4gIAlpbnQgc3osIHJldDsN
Cj4gIA0KPiArCWlmIChlZmkuc3lzdGFiLT5ucl90YWJsZXMgPT0gMCkNCj4gKwkJcmV0dXJuIDA7
DQo+ICsNCj4gIAlpZiAoZWZpX2VuYWJsZWQoRUZJXzY0QklUKSkNCj4gIAkJc3ogPSBzaXplb2Yo
ZWZpX2NvbmZpZ190YWJsZV82NF90KTsNCj4gIAllbHNlDQoNCkFueSBjaGFuY2Ugb2YgZ2V0dGlu
ZyB0aGlzIGludG8gdGhlIHRyZWU/IFdpdGhvdXQgdGhpcyB3ZSBjYW4ndCBib290DQp0aGUga2Vy
bmVsIGluIEVGSSBtb2RlIG9uIG91ciBLVk0gYmFzZWQgaHlwZXJ2aXNvclsxXSAmIGZpcm13YXJl
WzJdIGFzDQppdCBkb2VzIG5vdCBwcm92aWRlIGFueSB0YWJsZXMsIG5vciBkb2VzIGl0IG5lZWQg
dG8uDQoNClJvYg0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2Nsb3VkLWh5cGVydmlz
b3INClsyXSBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwvcnVzdC1oeXBlcnZpc29yLWZpcm13YXJl
DQoNCg0KDQo=
