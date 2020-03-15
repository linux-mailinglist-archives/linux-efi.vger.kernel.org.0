Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 641C0185D9F
	for <lists+linux-efi@lfdr.de>; Sun, 15 Mar 2020 15:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCOOpL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 15 Mar 2020 10:45:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:36579 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbgCOOpL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 15 Mar 2020 10:45:11 -0400
IronPort-SDR: +ElAhoB6iAdhIPJ6xXg94L2LMymuEV8+QU3gNuMOvfpWSdu5n6Oe5pMOvbeH9AjCGs4sFLgGsc
 4NqsCPSaTlfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 07:45:10 -0700
IronPort-SDR: b4J+JjTVoVZIpDpmBg3QYk5aH5zORAjiDLT3ewi+2OTktSPUnSzUnqCdiIeJd0mUQlm4vPs/jz
 BD9mMvKzhbIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,556,1574150400"; 
   d="scan'208";a="390431201"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2020 07:45:10 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 15 Mar 2020 07:45:10 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 15 Mar 2020 22:45:08 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Sun, 15 Mar 2020 22:45:08 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Gao, Liming" <liming.gao@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: RE: [PATCH v6 0/2] Add capsule-pstore backend support
Thread-Topic: [PATCH v6 0/2] Add capsule-pstore backend support
Thread-Index: AQHV+AtRt2A4QBRYMEWJgS/6qY3k5KhJLOAAgACQGXA=
Date:   Sun, 15 Mar 2020 14:45:08 +0000
Message-ID: <9a7788232b1a4cdead7c216ce9f024f3@intel.com>
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
dmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgQXJkIEJpZXNoZXV2ZWwNCj4+IC4uLg0KPiA+
ICAgICAgICAgIE1vdmUgdGhlIHZhcmlhYmxlICdlZmlfY2Fwc3VsZV9wc3RvcmVfaW5mbycgYmFj
a3dhcmQgKGZvciByZW1vdmluZyBzb21lIGZ1bmN0aW9uIGRlY2xhcmF0aW9ucykuDQo+IA0KPiBU
aGlzIGNvbmZsaWN0cyBiYWRseSB3aXRoIHRoZSBlZmkvY29yZSBjaGFuZ2VzIHF1ZXVlZCB1cCBp
biB0aGUgdGlwIHRyZWUgKGFuZCBoZW5jZSBsaW51eC1uZXh0KSBQbGVhc2UgcmViYXNlIGFuZCBy
ZXBvc3QNCg0KT0suIFdpbGwgcmViYXNlIHRoZSBwYXRjaGVzIG9uIHRvcCBvZiB0aXAgdHJlZSBh
bmQgcmVwb3N0Lg0KDQotUWl1eHUNCg0K
