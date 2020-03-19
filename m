Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F57718AECD
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 09:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCSIxl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 04:53:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:19176 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgCSIxl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Mar 2020 04:53:41 -0400
IronPort-SDR: 12Tcxq17SbC5MFoDNcjbtnr5tLlpi9qO1AzUJFS9DSHmb0WQr1TjyZEdo70pN7THQQlaToMQWG
 i++KHz+Hk16Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 01:53:40 -0700
IronPort-SDR: hmqkIZrkgxr7+bG82c3c0eEbgosmcrbnDD7ZTAbJMxtvUPPTjXrbUp+98kxxHm/86LxgPU/+hF
 v3NUDWqXYqlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,571,1574150400"; 
   d="scan'208";a="391736233"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga004.jf.intel.com with ESMTP; 19 Mar 2020 01:53:40 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Mar 2020 01:53:40 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Mar 2020 16:53:38 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Thu, 19 Mar 2020 16:53:38 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Gao, Liming" <liming.gao@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: RE: [PATCH v6 0/2] Add capsule-pstore backend support
Thread-Topic: [PATCH v6 0/2] Add capsule-pstore backend support
Thread-Index: AQHV+AtRt2A4QBRYMEWJgS/6qY3k5KhJLOAAgAGIUXCAA5msgIABV86w
Date:   Thu, 19 Mar 2020 08:53:38 +0000
Message-ID: <abd0a0d1095f4bc4a8fc2be420a2478a@intel.com>
References: <20200312011312.70653-1-qiuxu.zhuo@intel.com>
 <CAKv+Gu9BvqZavV6XjfuacXXpabNCXLYEw-f=81fwX8hdL6Fn-A@mail.gmail.com>
 <d0a09900ca0341029980d351bbe2aecc@intel.com>
 <CAKv+Gu82OFMJk-jQKdvA0_Sgp_CCmvC1a63QYrY+Cc4Qjx3+Yw@mail.gmail.com>
In-Reply-To: <CAKv+Gu82OFMJk-jQKdvA0_Sgp_CCmvC1a63QYrY+Cc4Qjx3+Yw@mail.gmail.com>
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
dmdlci5rZXJuZWwub3JnPiBPbj4gQmVoYWxmIE9mIEFyZCBCaWVzaGV1dmVsDQo+IC4uLg0KPiA+
IFRoZSBmb2xsb3dpbmcgY29tbWl0IG9uIHRoZSB0aXAgdHJlZSByZW1vdmVzIHRoZSB2YXJpYWJs
ZXMgJ2NvbmZpZ190YWJsZScgZnJvbSB0aGUgZWZpIHN0cnVjdHVyZS4NCj4gPg0KPiA+ICAgICA5
Y2Q0MzdhYzBlZjQgKCJlZmkveDg2OiBNYWtlIGZ3X3ZlbmRvciwgY29uZmlnX3RhYmxlIGFuZCBy
dW50aW1lIHN5c2ZzIG5vZGVzIHg4NiBzcGVjaWZpYyIpDQo+ID4NCj4gPiBCdXQgdGhlIGV4dGVy
bmFsIGRyaXZlciAiY2Fwc3VsZS1wc3RvcmUua28iIG5lZWRzIHRvIGFjY2VzcyAgJ2NvbmZpZ190
YWJsZScgYW5kICducl90YWJsZXMnIHRvIGdvIHRocm91Z2ggdGhlIGNvbmZpZ3VyYXRpb24gdGFi
bGUgdG8gZXh0cmFjdCAgY3Jhc2ggY2Fwc3VsZXMuDQo+ID4NCj4gPiBBZGRpbmcgJ2NvbmZpZ190
YWJsZScgYW5kICducl90YWJsZXMnIGJhY2sgdG8gdGhlIGVmaSBzdHJ1Y3R1cmUgbG9va3MgbGlr
ZSBub3QgYSBnb29kIHdheS4NCj4gPiBEbyB5b3UgaGF2ZSBhbnkgIHN1Z2dlc3Rpb24gb24gaG93
IHRvIGV4cG9ydCAnY29uZmlnX3RhYmxlJyBhbmQgJ25yX3RhYmxlcycgdmFyaWFibGVzIGZvciB0
aGUgZXh0ZXJuYWwgZHJpdmVyICJjYXBzdWxlLXBzdG9yZS5rbyI/DQo+ID4NCj4gDQo+IEkgd2ls
bCBnZXQgYmFjayB0byB5b3Ugb24gbW9uZGF5IGFib3V0IHRoaXMuIEluIGFueSBjYXNlLCB0aGlz
IHdpbGwgaGF2ZSB0byB3YWl0IHVudGlsIHY1LjgNCg0KT0suIFRoYW5rcyENCg0KLVFpdXh1DQoN
Cg0K
