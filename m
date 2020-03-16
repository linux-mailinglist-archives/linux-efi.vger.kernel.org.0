Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 873971864AB
	for <lists+linux-efi@lfdr.de>; Mon, 16 Mar 2020 06:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgCPFdM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Mar 2020 01:33:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:26380 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgCPFdM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 16 Mar 2020 01:33:12 -0400
IronPort-SDR: +ybyiTjTmx5mkRnUa3xz/qeKUGShyA4PD+ADjS6zOCXuZqeYGBTwOusoruFUN8wtFFgrjkFmh7
 ptvdB8v6YP8w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 22:33:11 -0700
IronPort-SDR: Q12YfgGBkaN5GdjX8vNhB9Y9BEEPy23gK4ICDAinqBAYA/TM4thCnOyLlxDCamAOS8vvSukxvn
 HyLyqu32NXfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,559,1574150400"; 
   d="scan'208";a="235927298"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga007.fm.intel.com with ESMTP; 15 Mar 2020 22:33:11 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 15 Mar 2020 22:33:11 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Mar 2020 13:32:41 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Mon, 16 Mar 2020 13:32:41 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Gao, Liming" <liming.gao@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: RE: [PATCH v6 0/2] Add capsule-pstore backend support
Thread-Topic: [PATCH v6 0/2] Add capsule-pstore backend support
Thread-Index: AQHV+AtRt2A4QBRYMEWJgS/6qY3k5KhJLOAAgAGIUXA=
Date:   Mon, 16 Mar 2020 05:32:41 +0000
Message-ID: <d0a09900ca0341029980d351bbe2aecc@intel.com>
References: <20200312011312.70653-1-qiuxu.zhuo@intel.com>
 <CAKv+Gu9BvqZavV6XjfuacXXpabNCXLYEw-f=81fwX8hdL6Fn-A@mail.gmail.com>
In-Reply-To: <CAKv+Gu9BvqZavV6XjfuacXXpabNCXLYEw-f=81fwX8hdL6Fn-A@mail.gmail.com>
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
dmdlci5rZXJuZWwub3JnPiBPbg0KPi4uLg0KPiBPbiBXZWQsIDExIE1hciAyMDIwIGF0IDIxOjEy
LCBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBDaGFu
Z2UgTG9nIHY1LT52NjoNCj4gPiAgIFBhcnQxOiBObyBjaGFuZ2VzLg0KPiA+ICAgUGFydDI6IFVw
ZGF0ZSBjYXBzdWxlLXBzdG9yZS5jIGZpbGUgaGVhZGVyLg0KPiA+ICAgICAgICAgIE1vdmUgdGhl
IHZhcmlhYmxlICdlZmlfY2Fwc3VsZV9wc3RvcmVfaW5mbycgYmFja3dhcmQgKGZvciByZW1vdmlu
Zw0KPiBzb21lIGZ1bmN0aW9uIGRlY2xhcmF0aW9ucykuDQo+ID4NCj4gDQo+IFRoaXMgY29uZmxp
Y3RzIGJhZGx5IHdpdGggdGhlIGVmaS9jb3JlIGNoYW5nZXMgcXVldWVkIHVwIGluIHRoZSB0aXAg
dHJlZSAoYW5kIGhlbmNlIGxpbnV4LW5leHQpIFBsZWFzZSByZWJhc2UgYW5kIHJlcG9zdA0KDQpI
aSBBcmQsDQoNClRoZSBmb2xsb3dpbmcgY29tbWl0IG9uIHRoZSB0aXAgdHJlZSByZW1vdmVzIHRo
ZSB2YXJpYWJsZXMgJ2NvbmZpZ190YWJsZScgZnJvbSB0aGUgZWZpIHN0cnVjdHVyZS4NCg0KICAg
IDljZDQzN2FjMGVmNCAoImVmaS94ODY6IE1ha2UgZndfdmVuZG9yLCBjb25maWdfdGFibGUgYW5k
IHJ1bnRpbWUgc3lzZnMgbm9kZXMgeDg2IHNwZWNpZmljIikNCg0KQnV0IHRoZSBleHRlcm5hbCBk
cml2ZXIgImNhcHN1bGUtcHN0b3JlLmtvIiBuZWVkcyB0byBhY2Nlc3MgJ2NvbmZpZ190YWJsZScg
YW5kICducl90YWJsZXMnIHRvIGdvIHRocm91Z2gNCnRoZSBjb25maWd1cmF0aW9uIHRhYmxlIHRv
IGV4dHJhY3QgY3Jhc2ggY2Fwc3VsZXMuDQoNCkFkZGluZyAnY29uZmlnX3RhYmxlJyBhbmQgJ25y
X3RhYmxlcycgYmFjayB0byB0aGUgZWZpIHN0cnVjdHVyZSBsb29rcyBsaWtlIG5vdCBhIGdvb2Qg
d2F5LiANCkRvIHlvdSBoYXZlIGFueSAgc3VnZ2VzdGlvbiBvbiBob3cgdG8gZXhwb3J0ICdjb25m
aWdfdGFibGUnIGFuZCAnbnJfdGFibGVzJyB2YXJpYWJsZXMgZm9yIHRoZSBleHRlcm5hbCBkcml2
ZXIgImNhcHN1bGUtcHN0b3JlLmtvIj8NCg0KVGhhbmtzIQ0KLVFpdXh1DQoNCg0KDQo=
