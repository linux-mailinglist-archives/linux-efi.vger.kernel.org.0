Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0383A4C494
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2019 02:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfFTApU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Jun 2019 20:45:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:57779 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfFTApU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Jun 2019 20:45:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 17:45:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="160515150"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jun 2019 17:45:19 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 19 Jun 2019 17:45:19 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 19 Jun 2019 17:45:19 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.33]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.156]) with mapi id 14.03.0439.000;
 Thu, 20 Jun 2019 08:45:16 +0800
From:   "Tian, Baofeng" <baofeng.tian@intel.com>
To:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "Compostella, Jeremy" <jeremy.compostella@intel.com>,
        "Tan, Ming" <ming.tan@intel.com>,
        "Zhuang, Qihua" <qihua.zhuang@intel.com>
Subject: RE: [[efi boot control]] efibc: Replace variable set function in
 notifier call
Thread-Topic: [[efi boot control]] efibc: Replace variable set function in
 notifier call
Thread-Index: AQHVIPfA5NojxdavdEGXvLko2SSf76ajwJOA
Date:   Thu, 20 Jun 2019 00:45:15 +0000
Message-ID: <EEBA739CCF11FE49B73E1FB4690F5EE64E598E83@shsmsx102.ccr.corp.intel.com>
References: <20190612081810.26526-1-baofeng.tian@intel.com>
In-Reply-To: <20190612081810.26526-1-baofeng.tian@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDQ5NDc2OGQtMTQwNi00ZTBjLThiODgtMzUxNjIzNTcyNzI1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ0x4bGluaDVJV2tVUXNEMXF3enZ1RGJRK1VoRTN5NldHaHlSbmtXdDMzNHVHK1J3MklZZU5XUldGWmNEazkrRSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

SGksIFJldmlld2VycyBhbmQgYWxsDQoNCkNvdWxkIHlvdSBoZWxwIHJldmlldyBiZWxvdyBjaGFu
Z2VzPyBhbmQgbGV0IG1lIGtub3cgeW91ciBvcGluaW9uLg0KDQpKZXJlbXksIGNvdWxkIHlvdSBo
ZWxwIGFkZCBNYXR0IEZsZW1pbmcgaW50byB0aGUgbG9vcCB0byByZXZpZXcgdGhpcyBjaGFuZ2U/
DQoNClRoYW5rcw0KVGltDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBUaWFu
LCBCYW9mZW5nIA0KU2VudDogV2VkbmVzZGF5LCBKdW5lIDEyLCAyMDE5IDQ6MTggUE0NClRvOiBh
cmQuYmllc2hldXZlbEBsaW5hcm8ub3JnOyBsaW51eC1lZmlAdmdlci5rZXJuZWwub3JnOyBDb21w
b3N0ZWxsYSwgSmVyZW15IDxqZXJlbXkuY29tcG9zdGVsbGFAaW50ZWwuY29tPjsgVGFuLCBNaW5n
IDxtaW5nLnRhbkBpbnRlbC5jb20+OyBaaHVhbmcsIFFpaHVhIDxxaWh1YS56aHVhbmdAaW50ZWwu
Y29tPg0KQ2M6IFRpYW4sIEJhb2ZlbmcgPGJhb2ZlbmcudGlhbkBpbnRlbC5jb20+OyBMdW8sIFhp
bmFuWCA8eGluYW54Lmx1b0BpbnRlbC5jb20+DQpTdWJqZWN0OiBbW2VmaSBib290IGNvbnRyb2xd
XSBlZmliYzogUmVwbGFjZSB2YXJpYWJsZSBzZXQgZnVuY3Rpb24gaW4gbm90aWZpZXIgY2FsbA0K
DQpGcm9tOiBUaWFuIEJhb2ZlbmcgPGJhb2ZlbmcudGlhbkBpbnRlbC5jb20+DQoNClJlcGxhY2Ug
dGhlIHZhcmlhYmxlIHNldCBmdW5jdGlvbiBmcm9tICJlZml2YXJfZW50cnlfc2V0IiB0byAiZWZp
dmFyX2VudHJ5X3NldF9zYWZlIiBpbiBlZmliYyBwYW5pYyBub3RpZmllci4NCkluIHNhZmUgZnVu
Y3Rpb24gcGFyYW1ldGVyICJibG9jayIgd2lsbCBzZXQgdG8gZmFsc2UgYW5kIHdpbGwgY2FsbCAi
ZWZpdmFyX2VudHJ5X3NldF9ub25ibG9ja2luZyJ0byBzZXQgZWZpIHZhcmlhYmxlcy4NCmVmaXZh
cl9lbnRyeV9zZXRfbm9uYmxvY2tpbmcgaXMgZ3VhcmFudGVlZCB0byBub3QgYmxvY2sgYW5kIGlz
IHN1aXRhYmxlIGZvciBjYWxsaW5nIGZyb20gY3Jhc2gvcGFuaWMgaGFuZGxlcnMuDQpJbiBVRUZJ
IGFuZHJvaWQgcGxhdGZvcm0sIHdoZW4gd2FybSByZXNldCBoYXBwZW5zLCB3aXRoIHRoaXMgY2hh
bmdlLCBlZmliYyB3aWxsIG5vdCBibG9jayB0aGUgcmVib290IHByb2Nlc3MuDQpPdGhlcndpc2Us
IHNldCB2YXJpYWJsZSB3aWxsIGNhbGwgcXVldWUgd29yayBhbmQgc2VuZCB0byBvdGhlciBvZmZs
aW5lZCBjcHVzIHRoZW4gY2F1c2UgYW5vdGhlciBwYW5pYywgZmluYWxseSB3aWxsIGNhdXNlIHJl
Ym9vdCBmYWlsdXJlLg0KDQpTaWduZWQtb2ZmLWJ5OiBUaWFuIEJhb2ZlbmcgPGJhb2ZlbmcudGlh
bkBpbnRlbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBMdW8gWGluYW5YIDx4aW5hbngubHVvQGludGVs
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZmlybXdhcmUvZWZpL2VmaWJjLmMgfCAxMiArKysrKysrLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpYmMuYyBiL2RyaXZlcnMvZmlybXdh
cmUvZWZpL2VmaWJjLmMgaW5kZXggNjFlMDk5ODI2Y2JiLi4zNWRjY2M4OGFjMGEgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9lZmliYy5jDQorKysgYi9kcml2ZXJzL2Zpcm13YXJl
L2VmaS9lZmliYy5jDQpAQCAtNDMsMTEgKzQzLDEzIEBAIHN0YXRpYyBpbnQgZWZpYmNfc2V0X3Zh
cmlhYmxlKGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIgKnZhbHVlKQ0KIAllZmliY19zdHJf
dG9fc3RyMTYodmFsdWUsIChlZmlfY2hhcjE2X3QgKillbnRyeS0+dmFyLkRhdGEpOw0KIAltZW1j
cHkoJmVudHJ5LT52YXIuVmVuZG9yR3VpZCwgJmd1aWQsIHNpemVvZihndWlkKSk7DQogDQotCXJl
dCA9IGVmaXZhcl9lbnRyeV9zZXQoZW50cnksDQotCQkJICAgICAgIEVGSV9WQVJJQUJMRV9OT05f
Vk9MQVRJTEUNCi0JCQkgICAgICAgfCBFRklfVkFSSUFCTEVfQk9PVFNFUlZJQ0VfQUNDRVNTDQot
CQkJICAgICAgIHwgRUZJX1ZBUklBQkxFX1JVTlRJTUVfQUNDRVNTLA0KLQkJCSAgICAgICBzaXpl
LCBlbnRyeS0+dmFyLkRhdGEsIE5VTEwpOw0KKwlyZXQgPSBlZml2YXJfZW50cnlfc2V0X3NhZmUo
ZW50cnktPnZhci5WYXJpYWJsZU5hbWUsDQorCQkJCSAgICBlbnRyeS0+dmFyLlZlbmRvckd1aWQs
DQorCQkJCSAgICBFRklfVkFSSUFCTEVfTk9OX1ZPTEFUSUxFDQorCQkJCSAgICB8IEVGSV9WQVJJ
QUJMRV9CT09UU0VSVklDRV9BQ0NFU1MNCisJCQkJICAgIHwgRUZJX1ZBUklBQkxFX1JVTlRJTUVf
QUNDRVNTLA0KKwkJCQkgICAgZmFsc2UsIHNpemUsIGVudHJ5LT52YXIuRGF0YSk7DQorDQogCWlm
IChyZXQpDQogCQlwcl9lcnIoImZhaWxlZCB0byBzZXQgJXMgRUZJIHZhcmlhYmxlOiAweCV4XG4i
LA0KIAkJICAgICAgIG5hbWUsIHJldCk7DQotLQ0KMi4yMS4wDQoNCg==
