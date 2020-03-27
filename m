Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D281950D6
	for <lists+linux-efi@lfdr.de>; Fri, 27 Mar 2020 07:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgC0GIC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Mar 2020 02:08:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:14489 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgC0GIC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Mar 2020 02:08:02 -0400
IronPort-SDR: 4cwkcxQDe1sQG+xsSQtLzp77BIkMUBIQF55gITnfP6+hIWRJR2KEN+N4MhWgvoJmM/p75P8Slc
 pFqlYrQdd2lQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 23:08:01 -0700
IronPort-SDR: ef9pexk/PfrUgZQed/88flWNksjYG9nnf1eCCpl5orFgqXLwbD6AyRQ8+VIAZWPm4xfJS7ljIG
 /8kLurbuQURg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="240881480"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2020 23:08:01 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 23:08:01 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 27 Mar 2020 14:07:59 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Fri, 27 Mar 2020 14:07:59 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Gao, Liming" <liming.gao@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] eif/capsule-pstore: Add capsule pstore backend
Thread-Topic: [PATCH v6 2/2] eif/capsule-pstore: Add capsule pstore backend
Thread-Index: AQHV+AtfIE8BGbnd7EuNivMeMNK86qhZJGkAgAEryQCAAYGSMA==
Date:   Fri, 27 Mar 2020 06:07:59 +0000
Message-ID: <dad4cdef71cf415f8ee6f0987b467b01@intel.com>
References: <20200312011335.70750-1-qiuxu.zhuo@intel.com>
 <CAKv+Gu_FSMM77WyNPKQDsA3wa6xLFUYe9kXpLEeR72t6q7t4jw@mail.gmail.com>
 <CAKv+Gu_4J7ebMuj9xJ31BOCvxahU_mkLa9RTr8d2DXRC8tFTnQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_4J7ebMuj9xJ31BOCvxahU_mkLa9RTr8d2DXRC8tFTnQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

PiBGcm9tOiBsaW51eC1lZmktb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1lZmktb3duZXJA
dmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgQXJkIEJpZXNoZXV2ZWwNCj4+IC4uLg0KPiAN
Cj4gT0ssIHNvIEkgc2VlIG9uZSBjb21wbGljYXRpb24gd2l0aCB0aGlzLiBUaGUgRUZJIFVwZGF0
ZUNhcHN1bGUoKSBydW50aW1lDQo+IHNlcnZpY2UgZXhwZWN0cyB0aGUgT1MgdG8gdXNlIHRoZSBF
RkkgUmVzZXRTeXN0ZW0oKSBydW50aW1lIHNlcnZpY2UgdG8NCj4gcGVyZm9ybSB0aGUgcmVib290
LiBwc3RvcmUgaXMgZGVzaWduZWQgdG8gcmVjb3JkIHdoYXRldmVyIGl0IGNhbiB3aGlsZSB0aGUN
Cj4gc3lzdGVtIGlzIGNyYXNoaW5nLCBhbmQgc28gaXQgdGhpcyB3b3VsZCBuZWVkIHJlYm9vdF9v
bl9wYW5pYyBhdCB0aGUgdmVyeQ0KPiBsZWFzdCwgYnV0IGV2ZW4gdGhlbiwgaXQgaXMgbm90IHZl
cnkgbGlrZWx5IHRoYXQgeW91IHdvdWxkIGJlIGFibGUgdG8gZG8gYQ0KPiBjbGVhbiBzb2Z0IHJl
Ym9vdCBmcm9tIHRoYXQgc3RhdGUgaW4gdGhlIGdlbmVyYWwgY2FzZS4NCj4gDQo+IFNvIHVubGVz
cyB0aGVyZSBpcyBhIHdheSB0byBwZXJmb3JtIHRoZSB0ZXN0IHN0ZXBzIC93aXRob3V0LyByZWx5
aW5nIG9uDQo+IG1hZ2ljIFN5c1JxIHRvIGRvIGEgc29mdCByZWJvb3QgYWZ0ZXIgdGhlIHN5c3Rl
bSBoYXMgcGFuaWNrZWQsIEknbSBub3QgY29udmluY2VkIHRoaXMgaXMgd29ydGh3aGlsZS4NCg0K
SGkgQXJkLA0KDQpZb3VyIGNvbmNlcm4gaXMgcmVhc29uYWJsZSEgVGhhbmtzIQ0KDQpZZXMsIHRo
ZSBjYXBzdWxlLXBzdG9yZSBkcml2ZXIgZGVwZW5kcyBvbiB0aGUgRUZJIFJlc2V0U3lzdGVtKCkg
cnVudGltZSBzZXJ2aWNlIHRvIHBlcmZvcm0gdGhlIHJlYm9vdCB0byBzYXZlIHRoZSBjYXBzdWxl
cyBvZiBjcmFzaGluZyBkdW1wIGFjcm9zcyBhIHdhcm0gcmVzZXQuICBJbnZlc3RpZ2F0aW9uIG9u
IGN1cnJlbnQgTGludXgga2VybmVsIHJlYm9vdCBjb2RlIChzZWUgdGhlIGNvbW1pdHMgYmVsb3cp
IG9mIGFybTY0IGFuZCB4ODYgc2hvd3MgdGhhdCBpZiB0aGUgc3lzdGVtIGlzIFVFRkkgUnVudGlt
ZSBTZXJ2aWNlcyBhdmFpbGFibGUgb3IgaWYgYW4gRUZJIGNhcHN1bGUgaGFzIGJlZW4gc2VudCB0
byB0aGUgZmlybXdhcmUgdGhlbiB0aGUgc3lzdGVtIGlzIGZvcmNlZCB0byB1c2UgRUZJIFJlc2V0
U3lzdGVtKCkuIEkuZS4sIHRoZSBFRkkgUmVzZXRTeXN0ZW0oKSB3aWxsIGJlIHRoZSBwcmVmZXJy
ZWQgcmVib290IHBhdGggaWYgd2UgaGF2ZSBFRkkgY2Fwc3VsZXMuIA0KDQogICAgICBhcm02NDog
NjBjMGQ0NWE3ZjdhICgiZWZpL2FybTY0OiB1c2UgVUVGSSBmb3Igc3lzdGVtIHJlc2V0IGFuZCBw
b3dlcm9mZiIpIA0KICAgICAgICAgICB4ODY6IDg3NjE1YTM0ZDU2MSAoIng4Ni9lZmk6IEZvcmNl
IEVGSSByZWJvb3QgdG8gcHJvY2VzcyBwZW5kaW5nIGNhcHN1bGVzIikNCg0KU28gdGhlIGNhcHN1
bGUtcHN0b3JlIHNpbXBseSBkZXBlbmRzIG9uIHJlYm9vdF9vbl9wYW5pYy4gVGhlIGRlcGVuZGVu
Y3kgbWF5IG1ha2UgaXQgc2VlbSB0byBiZSBkaWZmZXJlbnQgZnJvbSBzb21lIG90aGVyIHBzdG9y
ZSBiYWNrZW5kIGRyaXZlcnMgdGhhdCBzYXZlIHRoZSBkdW1wIHRvIHNvbWUgcGVyc2lzdGVudCBt
ZW1vcnksIHNvIHRoZXkgZG9u4oCZdCBjYXJlIGhvdyB0aGUgc3lzdGVtIGlzIHJlc2V0IChjb3Vs
ZCBldmVuIGJlIHBvd2VyLWN5Y2xlZCkuIFdoZXRoZXIgcmVib290aW5nIHRoZSBrZXJuZWwgb3Ig
cGlubmluZyBpdCBpbiBhIGxvb3Agb24gcGFuaWMgaXMgY29udHJvbGxlZCBieSAicGFuaWNfdGlt
ZW91dCIgd2hpY2ggaXMgZXhwb3J0ZWQgZm9yIGV4dGVybmFsIG1vZHVsZXMuIFRoZSBjYXBzdWxl
LXBzdG9yZSBkcml2ZXIgbWF5IGNoZWNrIGl0IGFuZCBwcmludCBhIHdhcm5pbmcgbWVzc2FnZSBp
ZiBpdCBpc24ndCBzZXQgdG8gdHJpZ2dlciBhIHJlYm9vdCAocGFuaWNfdGltZW91dD0wKS4gDQoN
Ck9uZSBtb3JlIGV4YW1wbGUgb2YgcHN0b3JlIHN1Y2Nlc3NmdWxseSB1c2luZyB0aGUgY2Fwc3Vs
ZS1wc3RvcmUgZHJpdmVyIGlzIHNob3dlZCBhcyBiZWxvdyAodGhlIHBhbmljX3RpbWVvdXQ9MSB3
YXMgcHJlLXNldCwgc28gdGhlIGtlcm5lbCBnb3QgcmVib290IG9uIHBhbmljKS4gSXQgZGlkbid0
IHJlbHlpbmcgb24gbWFnaWMgU3lzUnEgdG8gcmVib290IHRoZSBzeXN0ZW0uIFRlc3RlZCB0aGUg
Y2Fwc3VsZS1wc3RvcmUgZHJpdmVyIHRoYXQgaXQgc3RpbGwgd29ya2VkIHdlbGwuIA0KDQpTdW1t
YXJ5OiBUaGUgY2Fwc3VsZS1wc3RvcmUgb25seSBkZXBlbmRzIG9uIHBhbmljX3RpbWVvdXQgIT0w
LiBJZiBwYW5pY190aW1lb3V0ICE9MCwgdGhlbiB0aGUgY2Fwc3VsZS1wc3RvcmUgY2FuIHdvcmsg
KGNlcnRhaW5seSwgdGhlIHN5c3RlbSBzaG91bGQgaGF2ZSBFRkkgUnVudGltZSBTZXJ2aWNlcyku
IEhvcGUgdGhlIGNhcHN1bGUtcHN0b3JlIGlzIHN0aWxsIGEgd29ydGh3aGlsZSBwc3RvcmUgYmFj
a2VuZC4gIDotKQ0KDQogICAgICAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KICAgICAgICNp
bmNsdWRlIDxsaW51eC9pcnFfd29yay5oPg0KDQogICAgICAgc3RhdGljIHN0cnVjdCBpcnFfd29y
ayBteV9pcnFfd29yazsNCg0KICAgICAgIHN0YXRpYyB2b2lkIG15X2lycV93b3JrX2NiKHN0cnVj
dCBpcnFfd29yayAqaXJxX3dvcmspDQogICAgICAgew0KICAgICAgICAgICAgICAgKigoaW50ICop
MCkgPSAweGRlYWRiZWFmOw0KICAgICAgIH0NCg0KICAgICAgIHN0YXRpYyBpbnQgX19pbml0IG15
X2luaXQodm9pZCkNCiAgICAgICB7DQogICAgICAgICAgICAgICBpbml0X2lycV93b3JrKCZteV9p
cnFfd29yaywgbXlfaXJxX3dvcmtfY2IpOw0KICAgICAgICAgICAgICAgaXJxX3dvcmtfcXVldWUo
Jm15X2lycV93b3JrKTsNCiAgICAgICAgICAgICAgIHJldHVybiAwOw0KICAgICAgIH0NCg0KICAg
ICAgIHN0YXRpYyB2b2lkIF9fZXhpdCBteV9leGl0KHZvaWQpIHt9DQoNCiAgICAgICBtb2R1bGVf
aW5pdChteV9pbml0KTsNCiAgICAgICBtb2R1bGVfZXhpdChteV9leGl0KTsNCg0KLVFpdXh1DQoN
Cg0KDQo=
