Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAD71B4CDD
	for <lists+linux-efi@lfdr.de>; Wed, 22 Apr 2020 20:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgDVSuU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Apr 2020 14:50:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4684 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgDVSuT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Apr 2020 14:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587581418; x=1619117418;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OmwtvO4luEPNqsyee2cplGR8BqF71SRCHvPRo0z1JwA=;
  b=hcysLcS9HvERQzyvrQPOK8hMnmyThCeYtJUPa9zgrFETEDR3WWLfLRik
   8ZPvdVCfDV2sopwtiH9LAAEeMPm9mGJsxzKaVbfH1QxhTl9O6V9fBZFQJ
   lUF15gVC5muMTxlH7EoTuL9LOQKWkhTaKr1o0jT+3crywRKCVLotul+NP
   AzAXZLhHPEa5HKOQtY1TjlCujESOMr7QVTmpSsmv3geQRb+7FgQAeqA4R
   dPgm28BYQN/Yc0Tv5jPR+aI6dQXfnynG+6MCd2bv/dYIsRVgu6MHdxIAi
   LsgNZg6BhuSGY3B69k7Qo/4ZuTY69izrnobEoGd3QdFKbTH5vr7uAts76
   w==;
IronPort-SDR: Ynml9VY8JB9oX/W82ui5/HDnM5E/A+TntykF9/Mac9lz/fN0chXtmQij4zQ9XMVRhF97EN/B6T
 EOWz4c0OpMmmU1MXgcbwwTD/KN3seLVuVkTzdaUUDLyy9k+nYBXgaqasme4wEw8sKafDirKFTJ
 0refyZzJGgfqvB4UxdCUXXW5wCLSFxn/t1Ukva0gLk9CH0o6EiB7wChm3iQTLPVxXJGpQFAHSq
 tSUu8LZg89I684f0HaeaadggRe78RYaUZxkEw83GURPBXYZpd6lVjkB2I566yd2pMfTv/Re1ON
 M6w=
X-IronPort-AV: E=Sophos;i="5.73,304,1583164800"; 
   d="scan'208";a="135908006"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 02:50:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwN2Q4NwljS0gR5HoilmkKALG7VxBlyOqHPtDdnyNZ7zYGqkl3eSq3LZyLmETj2Ax5RaMSdFwa/0WhJlw+W5Emn6rfK19HGFA7TS9U3agKinTckSX/y54RkQUSZENEx4bva5AoBxKo5OddvtPH1JSN7mUbtCyslkQY2av9x/0KtMVmuw8kZzzJrPYYQBWmHOb7k9TIyLHcVr7DjRGxTVA9NbySdzfwvHqDDktpj7QbpTpRhCexjkvb6D7lvMmHek+ccO84WaBYUDRFVrXJcausaGEGgkv0wxjjEZY7hyK9fxZAEKy1lU1FFtaGFyFDibTrK8r4rNXCygiQslM2UNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmwtvO4luEPNqsyee2cplGR8BqF71SRCHvPRo0z1JwA=;
 b=YPE0zRms5e5Espagjez2zE5tWp2CwmXaiiplLzeNP6eiKw+6gDTaLKmtLltilA5iLT4m+6FdC7s0zYGXJmP2nY19Tgro2pwKhmzza0gjC9XujiqlJt8vv+qL4jKXCbU0GHDWtxObElG3QIjC6QAZNbmdPt1Ch7WWRv2PiwV2PkxfyMmeRxQ2DSo5USvnw3JS2NsQqFHreCNaZtOWu8qt5rjkyLWeyKSUxfR5KgfGOVKdjjWf065x1tTMh32F8Z20UNW6PCpElu/CBJzyax3YGjIOHmreWgqX+zPQGOnSeCsPnfhxhTPNq5jphv/uO5HCDfeCHoR0s5m+791t/WWhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmwtvO4luEPNqsyee2cplGR8BqF71SRCHvPRo0z1JwA=;
 b=OsdnCcIx8sQxhTQyAtkRlxhyBxDJsspwK2NPSf6/jVRB6WUVKDnQkF+CInEmVnaW6sAj1c1QW5flU/nwUV75ajKQW/41GLpBglm4g90FZx6XDHmil3ASyRw+Doc6DTuYK6yw3NvtuT7FKU3fwCffC9Bveu12R+Ncn+OwIxZt1Zo=
Received: from BY5PR04MB6724.namprd04.prod.outlook.com (2603:10b6:a03:219::15)
 by BY5PR04MB6850.namprd04.prod.outlook.com (2603:10b6:a03:21a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 22 Apr
 2020 18:50:16 +0000
Received: from BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::5591:a2e7:4fad:6b0c]) by BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::5591:a2e7:4fad:6b0c%6]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 18:50:16 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v5 0/7] Add UEFI support for RISC-V
Thread-Topic: [PATCH v5 0/7] Add UEFI support for RISC-V
Thread-Index: AQHWGMrn9ZdKlaq/Ok+3rminiCbba6iFfCKA
Date:   Wed, 22 Apr 2020 18:50:15 +0000
Message-ID: <533a6e58dce4dd8ccdac9e14b59327a25517a392.camel@wdc.com>
References: <20200422172414.6662-1-ardb@kernel.org>
In-Reply-To: <20200422172414.6662-1-ardb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [98.248.240.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80f05b3a-d072-4992-41b6-08d7e6edff51
x-ms-traffictypediagnostic: BY5PR04MB6850:
x-microsoft-antispam-prvs: <BY5PR04MB6850CB083B54D869E3DFC5B4FAD20@BY5PR04MB6850.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6724.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(71200400001)(36756003)(6512007)(8676002)(26005)(186003)(54906003)(86362001)(6486002)(5660300002)(110136005)(2616005)(4326008)(6506007)(76116006)(2906002)(81156014)(8936002)(66476007)(498600001)(66946007)(66446008)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /zzEozdDvK34FufxkIo+GBPjwm5yb+kFiJJDl4hfkP4aDbim+vbejand43/oNlfwbnde0CCeVTi2TqNC/QOpvnl3Kk5dm07m8zdRD1l6GsTCBEP6bGW4UrNcVRRdr+kShz1Qp5UtC3Bk5yZxMsi07bZWh2IBrGwkSJHl/XU0AXinww9W9AZmS1t8DMADUtgBhVaDRv47pmRYCv4B/oUxY2UlWW8MADlg/PW63M1Vh+JgnT4wwZCXDxSzhCguxtvETnKdtf/GAmEYfYdNP3SlCwaqyCBzs3w2P35FXdxjnbmvzlLkHynhGyH+00SCQy4oOH08PMLeQfe2AjNICmEILW/bvWMb7d8YZHjHaSydJNyuc6RNxkct13tz7tjOubKxA4pNHFNa7s7dMM23wfWRq4I6PdYflwv9N6mY66l+AyZ/LeXav5w+xuh665h4ZpEm
x-ms-exchange-antispam-messagedata: 3GcHGfd7O8G3t7rJUifym5eH/VxB7mAdsPCqnodl6MePqH8rxt/8x0vfx4k5At/ia5GGSXkaJLTkq4uTAVM/MOwMWRe09nEaoSifrgps+jdYHgAJ0Idq0/Vt537Ccr/7L30vaUoRXnuvbvs7knYoXw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <211E0C7EB483E04BA3082378CC0D5E63@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f05b3a-d072-4992-41b6-08d7e6edff51
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 18:50:15.9833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MecBnpON+eWy0K6jlwHVkSH5Mpv4ytwBvx36fEFscQ216BRD0i7nMiI9qa+E5bBj61YNeUpW1DmGtKEUAlwhFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6850
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTIyIGF0IDE5OjI0ICswMjAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gVGhpcyBpcyBhIHJld29yayBvZiBBdGlzaCdzIHNlcmllcyBbMF0gdG8gYWRkIEVGSSBzdHVi
IGxvYWRlciBzdXBwb3J0DQo+IHRvIHRoZSBSSVNDLVYgcG9ydC4gVGhlIHB1cnBvc2UgaXMgdG8g
c3BsaXQgdGhlIGNvZGUgaW4gYSB3YXkgdGhhdA0KPiBtYWtlcw0KPiBpdCBhbWVuYWJsZSB0byBi
ZWluZyBtZXJnZWQgdmlhIGRpZmZlcmVudCB0cmVlcyBkdXJpbmcgdGhlIHNhbWUNCj4gY3ljbGUu
DQo+IFdoaWxlIGF0IGl0LCBJIGFkZGVkIGEgcGF0Y2ggdG8gZGlzYWJsZSBpbml0cmQ9IGxvYWRp
bmcgZm9yIG5ldw0KPiBwb3J0cywNCj4gZ2l2ZW4gdGhhdCBpdCBpcyBkZXByZWNhdGVkIGFuZCBy
ZXBsYWNlZCB3aXRoIGEgbWV0aG9kIGJhc2VkIG9uIGEgDQo+IHNwZWNpYWwgVUVGSSBkZXZpY2Ug
cGF0aC4NCj4gDQoNClRoYW5rcyBmb3IgcmVmYWN0b3JpbmcgdGhlIHNlcmllcy4gSSBkaWQgbm90
IHNlZSB0aGlzIG9uZSBhbmQgcmVwbGllZA0KdG8gdGhlIG9yaWdpbmFsIGNvbW1lbnRzIDooLiBF
dmVyeXRoaW5nIGxvb2tzIGdvb2QgdG8gbWUgZXhjZXB0IHRoZQ0Kc2VsZWN0aW5nIHRoZSBSSVND
Vl9JU0FfQyBiaXQuDQoNCj4gTXkgY2hhbmdlcyBhcmUgbG9nZ2VkIGluIHRoZSBpbmRpdmlkdWFs
IHBhdGNoZXMuDQo+IA0KPiBJIHByb3Bvc2UgdG8gdGFrZSB0aGUgZmlyc3QgZm91ciBwYXRjaGVz
IHZpYSB0aGUgRUZJIHRyZWUsIGFuZCBleHBvc2UNCj4gdGhlbSB2aWEgYSBzdGFibGUgdGFnIHNv
IHRoYXQgdGhlIFJJU0MtViBtYWludGFpbmVycyBjYW4gbWVyZ2UgaXQNCj4gYmVmb3JlDQo+IGFw
cGx5aW5nIHRoZSByZW1haW5pbmcgcGF0Y2hlcy4gVGhhdCB3aWxsIGVuc3VyZSB0aGF0IGJvdGgg
dHJlZXMNCj4gcmVtYWluDQo+IGluIGEgYnVpbGRhYmxlIHN0YXRlLCB3aXRoIHdvcmtpbmcgRUZJ
IHN0dWIgc3VwcG9ydCBvbiB0aGUgcmlzY3YNCj4gYnJhbmNoLg0KPiANCg0KR3JlYXQuDQoNCj4g
Q2M6IEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3ZGMuY29tPg0KPiBDYzogUGFsbWVyIERhYmJl
bHQgPHBhbG1lckBkYWJiZWx0LmNvbT4NCj4gQ2M6IFBhdWwgV2FsbXNsZXkgPHBhdWwud2FsbXNs
ZXlAc2lmaXZlLmNvbT4NCj4gQ2M6IEFsYmVydCBPdSA8YW91QGVlY3MuYmVya2VsZXkuZWR1Pg0K
PiBDYzogbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiANCj4gQXJkIEJpZXNoZXV2
ZWwgKDEpOg0KPiAgIGVmaS9saWJzdHViOiBNYWtlIGluaXRyZCBmaWxlIGxvYWRlciBjb25maWd1
cmFibGUNCj4gDQo+IEF0aXNoIFBhdHJhICg2KToNCj4gICBlZmkvbGlic3R1YjogTW92ZSBhcm0t
c3R1YiB0byBhIGNvbW1vbiBmaWxlDQo+ICAgZWZpL2xpYnN0dWIvcmlzY3Y6IGFkZCBhcmNoIHNw
ZWNpZmljIGVmaS5oIGhlYWRlciBmaWxlDQo+ICAgaW5jbHVkZTogcGUuaDogQWRkIFJJU0MtViBy
ZWxhdGVkIFBFIGRlZmluaXRpb24NCj4gICBSSVNDLVY6IERlZmluZSBmaXhtYXAgYmluZGluZ3Mg
Zm9yIGdlbmVyaWMgZWFybHkgaW9yZW1hcCBzdXBwb3J0DQo+ICAgUklTQy1WOiBBZGQgUEUvQ09G
RiBoZWFkZXIgZm9yIEVGSSBzdHViDQo+ICAgUklTQy1WOiBBZGQgRUZJIHN0dWIgc3VwcG9ydC4N
Cj4gDQo+ICBhcmNoL2FybS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDIgKy0NCj4gIGFyY2gvYXJtNjQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMiArLQ0KPiAgYXJjaC9yaXNjdi9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDIxICsrKysNCj4gIGFyY2gvcmlzY3YvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMSArDQo+ICBhcmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgICAg
ICAgICAgfCAgIDEgKw0KPiAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9LYnVpbGQgICAgICAgICAg
ICAgICAgIHwgICAxICsNCj4gIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vZWZpLmggICAgICAgICAg
ICAgICAgICB8ICA0MSArKysrKysrDQo+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2ZpeG1hcC5o
ICAgICAgICAgICAgICAgfCAgMTggKysrDQo+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2lvLmgg
ICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zZWN0
aW9ucy5oICAgICAgICAgICAgIHwgIDEzICsrKw0KPiAgYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZp
bGUgICAgICAgICAgICAgICAgICAgIHwgICA0ICsNCj4gIGFyY2gvcmlzY3Yva2VybmVsL2VmaS1o
ZWFkZXIuUyAgICAgICAgICAgICAgICB8IDEwMCArKysrKysrKysrKysrKysrDQo+ICBhcmNoL3Jp
c2N2L2tlcm5lbC9oZWFkLlMgICAgICAgICAgICAgICAgICAgICAgfCAgMTYgKysrDQo+ICBhcmNo
L3Jpc2N2L2tlcm5lbC9pbWFnZS12YXJzLmggICAgICAgICAgICAgICAgfCAgNTMgKysrKysrKysr
DQo+ICBhcmNoL3Jpc2N2L2tlcm5lbC92bWxpbnV4Lmxkcy5TICAgICAgICAgICAgICAgfCAgMjIg
KysrLQ0KPiAgZHJpdmVycy9maXJtd2FyZS9lZmkvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwg
IDE1ICsrLQ0KPiAgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9NYWtlZmlsZSAgICAgICAg
IHwgIDIyICsrKy0NCj4gIC4uLi9lZmkvbGlic3R1Yi97YXJtLXN0dWIuYyA9PiBlZmktc3R1Yi5j
fSAgICB8ICAgMA0KPiAgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9maWxlLmMgICAgICAg
ICAgIHwgICAzICsNCj4gIGRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvcmlzY3Ytc3R1Yi5j
ICAgICB8IDEwOQ0KPiArKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvcGUuaCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArDQo+ICAyMSBmaWxlcyBjaGFuZ2VkLCA0
MzYgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9lZmkuaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gv
cmlzY3YvaW5jbHVkZS9hc20vc2VjdGlvbnMuaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gv
cmlzY3Yva2VybmVsL2VmaS1oZWFkZXIuUw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlz
Y3Yva2VybmVsL2ltYWdlLXZhcnMuaA0KPiAgcmVuYW1lIGRyaXZlcnMvZmlybXdhcmUvZWZpL2xp
YnN0dWIve2FybS1zdHViLmMgPT4gZWZpLXN0dWIuY30NCj4gKDEwMCUpDQo+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9yaXNjdi1zdHViLmMNCj4gDQoN
Ci0tIA0KUmVnYXJkcywNCkF0aXNoDQo=
