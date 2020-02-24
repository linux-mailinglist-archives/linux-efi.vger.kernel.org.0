Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5040916B4F4
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 00:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgBXXP3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Feb 2020 18:15:29 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25637 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXXP3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Feb 2020 18:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582586129; x=1614122129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z1ytp/VwCy54k2v6zFlHCVyvAGIdb5/scIOxDdUBFw0=;
  b=QZ2G9Jx0GlazOoKGUcidceYXpkSbu1MlJzSPeKck6vK9G3R9w3sKAFEE
   1myiTXSdXWPzzsvrrbZDcPmcbpYlLa2uX9gVbJ62nL21H5fO6bOzzHQN8
   ksj1Odfdnn3Oo+kjP7HDkxowGlNLDOIy4yAyfJtKa0D+GcsmsUxN648Ef
   akx0f8g9g8LiRcZHh6nFw2btfCMTo6p7ahAr4ybyUU0FeIgj4LhLgBpyJ
   Ny9g3p9fdbyiPRbYhAARGiW9E9ZMnthTDQqeqziUNftt2yGjdPbL9QXKh
   g9YkDl6bGRCffqw4yP8eQlKYdsL0qlQZBt9MD6tA01AySxog6cRh/KInG
   w==;
IronPort-SDR: PXpVTuRpfczbpsG7OJUd+a/8pWwtzdlmwujLsDLmO4KD90isALIk0NsjX/Vsk7ndRJ+fNL1ZLM
 wvYCol8oVbF6TX/l7O2rg7obHPFf90PrFeW87LipIl+TbkH1mJ+w9owP7sfpS+n7db5fi307PR
 Cxv6zaZdugLBysLc5H6k7Eupt8uzVFxzCwMowT/czeSh4bNiJDCS0JWtfm2DNRKz7MXafUQ1Mq
 bOlQcbO845IfoQNk1ODACBkUjJtZKgByVr7JIStCj++jyFsgcFJuGzWIpf6lAV6X+8dVkeiCTr
 qR4=
X-IronPort-AV: E=Sophos;i="5.70,481,1574092800"; 
   d="scan'208";a="135009062"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 07:15:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVOLqMh3/NSgu5BKRUhqObjiikDXG7/3vIVO9nTpnleOXHBCGKoGLOPcfi4JFB3W/vnzwI+k5JqxKDyubTkyAhe24NhjWXfA8uo5bRMUa0S9HTnq8SmeYcWpuGjmsu6l74qkXzwqOjBEdzO+ijgT6Hc8Mc2RUGnHD9IBikBuhqTP9a0A2e9f7D/8DkNb/bQ3u9xpl/Sq6KJ+7fca9wRvqiILdS9l523PBnOaghYnfxqiLiPiKOdRwElFYj28JunWVVDMnNvru3imcpAnNtBoBCvL06IDTQmlnNM/CKjlxPOkj3EqaYfEiGAZpsZThzXhzuyQO0i2fFkovqgiD/nVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1ytp/VwCy54k2v6zFlHCVyvAGIdb5/scIOxDdUBFw0=;
 b=L7vuwuBMU4/AlEb4ZyFTj8DCVxjyMNSasZjaJ/CHaHnp16ZFz/SAG7/axqXo8Y2RPqqinur+DYQbH4b9qgTPSzuyc+z0TyqJyzp3MbrxvnuRYvgOwyokArU4Kn9zSWhobcPHcIuNar+jwqRV37jEa/9b3U80xkmqvGMVad8p7Gf7vfIiH47NKTzrZWmZKrgKmy9vij+fRaYLq1p0SdbtlgD8DVokAXbZRZA6CMXLmIw99+XpXmKYF/kGpadV+GIpMuHYID+thInKrhSmM4EJVKKHflGfHWRADkEX8ALEJf9fhCbxG5rXXU9mf9YGpXlNeKtQr7Ynf8/B9XDCTAXQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1ytp/VwCy54k2v6zFlHCVyvAGIdb5/scIOxDdUBFw0=;
 b=o2sgs9yXzea7JqeAOgiEQYL16E7C0xYG+yachnAPfTRimRsKmSro9f3cCmJz9yP4DBF8I9EASQocqksAjebkEm9vh7rhhpRnAh2hkrJW5H5vjYj9I/Cqw2oswYPRkIDyFfsGpJ7Twb+8Qg8pZphvQy0dTU5BVLBDFrINRoMuCXQ=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (2603:10b6:a02:ae::29)
 by BYAPR04MB3783.namprd04.prod.outlook.com (2603:10b6:a02:ae::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 23:15:27 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e%6]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 23:15:27 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "nivedita@alum.mit.edu" <nivedita@alum.mit.edu>,
        "lukas@wunner.de" <lukas@wunner.de>
Subject: Re: [PATCH 03/19] efi/libstub: Use hidden visiblity for all source
 files
Thread-Topic: [PATCH 03/19] efi/libstub: Use hidden visiblity for all source
 files
Thread-Index: AQHV4CuVi5Pe50PEP02TQgbPh7708qgrEEAA
Date:   Mon, 24 Feb 2020 23:15:26 +0000
Message-ID: <d3402c42836aca94d1a2ff385c088af605578068.camel@wdc.com>
References: <20200210160248.4889-1-ardb@kernel.org>
         <20200210160248.4889-4-ardb@kernel.org>
In-Reply-To: <20200210160248.4889-4-ardb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b29471ca-5119-4c61-d9a1-08d7b97f6f0b
x-ms-traffictypediagnostic: BYAPR04MB3783:
x-microsoft-antispam-prvs: <BYAPR04MB37833B33AEEE0F1BC1670F20FAEC0@BYAPR04MB3783.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(26005)(186003)(6506007)(478600001)(71200400001)(86362001)(6512007)(6486002)(66446008)(5660300002)(36756003)(66476007)(4326008)(76116006)(81156014)(8676002)(81166006)(66946007)(8936002)(64756008)(66556008)(54906003)(110136005)(316002)(2616005)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3783;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hW2sTwa8aqddIoeBKQK0/9mIiQFOB4RcyLKJkGWoJQVc/XB5ONjNa3WEWsyS/BE2+fbnTrwWbIPXGt7bHGlXq08XNwvbyPmmM8gGgEFNBBxIzXo3IjX90N4E2Ffks2ms4v7kCp06XKfiOunInMV9HPc5dNlt2aUHfpqnvCY1UM0ehakc4HF75Sx5wZu6Cft80h/P1vbk4ZXeXed1IEAMppIwmJTyzWuvPZB2dFIqPGmyTe63Dq/JOInqHw3z97qOuugQMCqiDcVxQt2usO2IcEjDHgxFhMeogbhzolDlxuwEFItpbF2IB+5Q3D4WWZGI7fwJ51WhTOH51u6qqVbClkMMK8E8zmRIFR6GWPS3keV4jqHlryfTaLcjqHTTRloQrAxuEEgg2HfYDoIC7JRmN2fnYAc5KXLKbYRIHVn8LbiQFiEUHb86LEKydw8yYOAs
x-ms-exchange-antispam-messagedata: 0f8bv7RWWyo8deiO4TZ+5oVZe0DWVPMdUJIiYFU2/338OpAdOnCgN3m90w/urfuBcE4s9bbAXxxNxoiJAIVeD7e6BKzh95c3/jkh5N9/PHhaa9vJRvlwr414ixFTFaTFESPNT1IL+ck3c+Myh9xujQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D246C8F65F93149A760B39BD5A6222E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29471ca-5119-4c61-d9a1-08d7b97f6f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 23:15:26.9358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F64I4Edm7o31ZUHkP8HR9+1WQSbiednvcBU4UaO0j/PMSlkvvGmjsNj/48jSjBrphNCl6c6r1BEt2errUDh6gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3783
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTEwIGF0IDE3OjAyICswMTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gSW5zdGVhZCBvZiBzZXR0aW5nIHRoZSB2aXNpYmlsaXR5IHByYWdtYSBmb3IgYSBzbWFsbCBz
ZXQgb2Ygc3ltYm9sDQo+IGRlY2xhcmF0aW9ucyB0aGF0IGNvdWxkIHJlc3VsdCBpbiBhYnNvbHV0
ZSByZWZlcmVuY2VzIHRoYXQgd2UgY2Fubm90DQo+IHN1cHBvcnQgaW4gdGhlIHN0dWIsIGRlY2xh
cmUgaGlkZGVuIHZpc2liaWxpdHkgZm9yIGFsbCBjb2RlIGluIHRoZQ0KPiBFRkkgc3R1Yiwgd2hp
Y2ggaXMgbW9yZSByb2J1c3QgYW5kIGZ1dHVyZSBwcm9vZi4NCj4gDQo+IFRvIGVuc3VyZSB0aGF0
IHRoZSAjcHJhZ21hIGlzIHRha2VuIGludG8gYWNjb3VudCBiZWZvcmUgYW55IG90aGVyDQo+IGlu
Y2x1ZGVzIGFyZSBwcm9jZXNzZWQsIHB1dCBpdCBpbiBhIGhlYWRlciBmaWxlIG9mIGl0cyBvd24g
YW5kDQo+IGluY2x1ZGUgaXQgdmlhIHRoZSBjb21waWxlciBjb21tYW5kIGxpbmUgdXNpbmcgdGhl
IC1pbmNsdWRlIG9wdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFyZCBCaWVzaGV1dmVsIDxh
cmRiQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9lZmkuaCAg
ICAgICAgICAgICAgfCAzIC0tLQ0KPiAgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9NYWtl
ZmlsZSAgICAgfCAyICstDQo+ICBkcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2FybTY0LXN0
dWIuYyB8IDggKy0tLS0tLS0NCj4gIGRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvaGlkZGVu
LmggICAgIHwgNiArKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAx
MSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNt
L2VmaS5oDQo+IGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9lZmkuaA0KPiBpbmRleCA0NDUzMWE2
OWQzMmIuLjU2YWU4NzQwMWEyNiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL2Fz
bS9lZmkuaA0KPiArKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2VmaS5oDQo+IEBAIC0xMDcs
OSArMTA3LDYgQEAgc3RhdGljIGlubGluZSB2b2lkIGZyZWVfc2NyZWVuX2luZm8oc3RydWN0DQo+
IHNjcmVlbl9pbmZvICpzaSkNCj4gIHsNCj4gIH0NCj4gIA0KPiAtLyogcmVkZWNsYXJlIGFzICdo
aWRkZW4nIHNvIHRoZSBjb21waWxlciB3aWxsIGdlbmVyYXRlIHJlbGF0aXZlDQo+IHJlZmVyZW5j
ZXMgKi8NCj4gLWV4dGVybiBzdHJ1Y3Qgc2NyZWVuX2luZm8gc2NyZWVuX2luZm8NCj4gX19hdHRy
aWJ1dGVfXygoX192aXNpYmlsaXR5X18oImhpZGRlbiIpKSk7DQo+IC0NCj4gIHN0YXRpYyBpbmxp
bmUgdm9pZCBlZmlmYl9zZXR1cF9mcm9tX2RtaShzdHJ1Y3Qgc2NyZWVuX2luZm8gKnNpLA0KPiBj
b25zdCBjaGFyICpvcHQpDQo+ICB7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13
YXJlL2VmaS9saWJzdHViL01ha2VmaWxlDQo+IGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1
Yi9NYWtlZmlsZQ0KPiBpbmRleCBmMTRiNzYzNjMyM2EuLjRlZmRiZDcxMWU4ZSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9NYWtlZmlsZQ0KPiArKysgYi9kcml2
ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL01ha2VmaWxlDQo+IEBAIC0yNSw3ICsyNSw3IEBAIGNm
bGFncy0kKENPTkZJR19BUk0pCQk6PSAkKHN1YnN0DQo+ICQoQ0NfRkxBR1NfRlRSQUNFKSwsJChL
QlVJTERfQ0ZMQUdTKSkgXA0KPiAgY2ZsYWdzLSQoQ09ORklHX0VGSV9BUk1TVFVCKQkrPSAtSSQo
c3JjdHJlZSkvc2NyaXB0cy9kdGMvbGliZmR0DQo+ICANCj4gIEtCVUlMRF9DRkxBR1MJCQk6PSAk
KGNmbGFncy15KQ0KPiAtRERJU0FCTEVfQlJBTkNIX1BST0ZJTElORyBcDQo+IC0JCQkJICAgLURf
X05PX0ZPUlRJRlkgXA0KPiArCQkJCSAgIC1pbmNsdWRlIGhpZGRlbi5oIC1EX19OT19GT1JUSUZZ
IFwNCj4gIAkJCQkgICAkKGNhbGwgY2Mtb3B0aW9uLC1mZnJlZXN0YW5kaW5nKSBcDQo+ICAJCQkJ
ICAgJChjYWxsIGNjLW9wdGlvbiwtZm5vLXN0YWNrLQ0KPiBwcm90ZWN0b3IpIFwNCj4gIAkJCQkg
ICAtRF9fRElTQUJMRV9FWFBPUlRTDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2Vm
aS9saWJzdHViL2FybTY0LXN0dWIuYw0KPiBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIv
YXJtNjQtc3R1Yi5jDQo+IGluZGV4IDI5MTViNDQxMzJlNi4uNzE5ZDAzYTY0MzI5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2FybTY0LXN0dWIuYw0KPiArKysg
Yi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2FybTY0LXN0dWIuYw0KPiBAQCAtNiwxNyAr
NiwxMSBAQA0KPiAgICogQWRhcHRlZCBmcm9tIEFSTSB2ZXJzaW9uIGJ5IE1hcmsgU2FsdGVyIDxt
c2FsdGVyQHJlZGhhdC5jb20+DQo+ICAgKi8NCj4gIA0KPiAtLyoNCj4gLSAqIFRvIHByZXZlbnQg
dGhlIGNvbXBpbGVyIGZyb20gZW1pdHRpbmcgR09ULWluZGlyZWN0ZWQgKGFuZCB0aHVzDQo+IGFi
c29sdXRlKQ0KPiAtICogcmVmZXJlbmNlcyB0byB0aGUgc2VjdGlvbiBtYXJrZXJzLCBvdmVycmlk
ZSB0aGVpciB2aXNpYmlsaXR5IGFzDQo+ICdoaWRkZW4nDQo+IC0gKi8NCj4gLSNwcmFnbWEgR0ND
IHZpc2liaWxpdHkgcHVzaChoaWRkZW4pDQo+IC0jaW5jbHVkZSA8YXNtL3NlY3Rpb25zLmg+DQo+
IC0jcHJhZ21hIEdDQyB2aXNpYmlsaXR5IHBvcA0KPiAgDQo+ICAjaW5jbHVkZSA8bGludXgvZWZp
Lmg+DQo+ICAjaW5jbHVkZSA8YXNtL2VmaS5oPg0KPiAgI2luY2x1ZGUgPGFzbS9tZW1vcnkuaD4N
Cj4gKyNpbmNsdWRlIDxhc20vc2VjdGlvbnMuaD4NCj4gICNpbmNsdWRlIDxhc20vc3lzcmVnLmg+
DQo+ICANCj4gICNpbmNsdWRlICJlZmlzdHViLmgiDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zp
cm13YXJlL2VmaS9saWJzdHViL2hpZGRlbi5oDQo+IGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGli
c3R1Yi9oaWRkZW4uaA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAw
MDAuLjM0OTNiMDQxZjQxOQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2RyaXZlcnMvZmlybXdh
cmUvZWZpL2xpYnN0dWIvaGlkZGVuLmgNCj4gQEAgLTAsMCArMSw2IEBADQo+ICsvKiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiArLyoNCj4gKyAqIFRvIHByZXZlbnQgdGhl
IGNvbXBpbGVyIGZyb20gZW1pdHRpbmcgR09ULWluZGlyZWN0ZWQgKGFuZCB0aHVzDQo+IGFic29s
dXRlKQ0KPiArICogcmVmZXJlbmNlcyB0byBhbnkgZ2xvYmFsIHN5bWJvbHMsIG92ZXJyaWRlIHRo
ZWlyIHZpc2liaWxpdHkgYXMNCj4gJ2hpZGRlbicNCj4gKyAqLw0KPiArI3ByYWdtYSBHQ0Mgdmlz
aWJpbGl0eSBwdXNoKGhpZGRlbikNCg0KSSBhbSBnZXR0aW5nIGZvbGxvd2luZyBjb21waWxlciBl
cnJvcnMgYmVjYXVzZSBvZiB0aGlzIHBhdGNoIHdoaWxlDQpjcm9zcyBjb21waWxpbmcgZm9yIEFS
TSwgQVJNNjQgYW5kIFJJU0MtVi4NCg0KY2MxOiBmYXRhbCBlcnJvcjogaGlkZGVuLmg6IE5vIHN1
Y2ggZmlsZSBvciBkaXJlY3RvcnkNCg0KQWRkaW5nIHRoZSBmb2xsb3dpbmcgbGluZSB0byBjZmxh
Z3Mgc29sdmVzIHRoZSBpc3N1ZSB3aGljaCBpbmRpY2F0ZXMNCnRoYXQgZ2NjIGlzIG5vdCBsb29r
aW5nIGF0IHRoZSBzb3VyY2UgZmlsZSBkaXJlY3RvcnkgZm9yIHRoaXMNCnBhcnRpY3VsYXJseSBp
bmNsdWRlIGZpbGUuDQoNCi1JJChzcmN0cmVlKS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHVi
DQoNCkkgbWlnaHQgaGF2ZSBzb21lIHRyaWNrIGluIG15IGJ1aWxkIHNldHVwLiBKdXN0IHBvc3Rp
bmcgaGVyZSB0byBzZWUgaWYNCmFueWJvZHkgZWxzZSBhbHNvIHNlZWluZyB0aGUgc2FtZSBwcm9i
bGVtLg0KDQoNCi0tIA0KUmVnYXJkcywNCkF0aXNoDQo=
