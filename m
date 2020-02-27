Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506CC1711AA
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 08:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgB0Hsd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 02:48:33 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8493 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbgB0Hsd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Feb 2020 02:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582789713; x=1614325713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=80ns6M8r6GDdQwVIuoZDihwetic+WV0809Z37tVXVZU=;
  b=F8to0A3LiAuUVZcyup1BsLUR3WFJgx+QCt54X+mtkTo8dcP1KrBGtYsV
   Rsq2s+P4nan54Qp+rtRGjfIqPH+YClPI4Vsr7hel/aEXj91PC8q/JlyGr
   ZXCgGaLveU6nVn8pToiIkT0bn0nW0JvmbG8c9RgEpyj8ZbCLODexOZVJK
   cTIydRtT2BCrCMR8w3bwEw36hK+9/JFs8RATlMsS+5SoXs3ye8OtU78lR
   Yjso1OdHMKtkrejEf5EvXA0Cm73KlmU1e4DZqOeDPDJ11nPCY9zJc4iB6
   PElkXzgftAqVUcQ2iM0qamByqiclzUIstjOUvSb60S05EzAtHBS40cr8K
   Q==;
IronPort-SDR: 2LfJYd0zmbD4j8pP0YxJCLoMT2fS0bT+FQ7W7+DFxZmq7v7Vf7x4ZfKQ8LYv6HEEqrClbcpu4W
 VnpO+Tl0vPVJIfOEGPn06HqXyx23TRP4G3qbYjypD5ySQAveWcF80TLOpm1JYtYrs5HHdq/q12
 u1+VH2Mpyx4vUYqUEYMr02qh69XUglAQSo7p3p8dGPFWPd/T9DwFJV3Ct7ahYLPBDZyBKNh5/j
 o9VO0NE/eNjTR1/heGj9Gm5NoHd8Ksp1JDZmn8qpsKlwQpgU28UGwcsXVnN8I/qP/vUZA7NWNi
 b5E=
X-IronPort-AV: E=Sophos;i="5.70,491,1574092800"; 
   d="scan'208";a="131381207"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 15:48:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJ7J8sfLJlMhoE1G3d4H1Tr/fet5o3k0svYetCPiAAw/+LmYpJluHqVsvq74Pn+rQgvC1hmHHCLmbbC/Ebk/mRWkskY5TROWBvcBl+BoV74rtZ+VR6Bjhjt4PrC/zpgNFjIj4gPPLx5e9iGqoWp0FfBW/8zQno8xulI2zVtbL+8DqQPSmiDjFLqsAIf6PGtGR2ibkUm8N68b3k3VrCtqxSltDhgAR8DOrr7QmH1C92f9tQv6zZTY8/dMVhWEYCX1Q+Rf5h9mWiQWzRZ9S7q3beXtg59wRsjUUHxvKQ4GWbu1B5CX1Nq0eYrCEQw9+EpasqoIwx18L9Q9zCnziWoZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80ns6M8r6GDdQwVIuoZDihwetic+WV0809Z37tVXVZU=;
 b=V7Y0T2jnfsrVq2J2aTNNM0n6M8mJrgdLfcAMlNUUzs7I6UVPYpe5rCfUQyzk10CSxDMDhxUxwvGwxBM8ZcoPVJLN7NqaCiMbOqe9bM+J7et6Dan7/VnyWeQmvedyx9vFbyIScsu32CNdhLGBSFB0VU9p1gGjrwNi6SCovb67oWWtx0843+MhvPvjBCO7pEglT8cZg/YRr6/YhUto++j8zT9gX26ltXX6JEZm40jmWKRF6ceTQN7RqyEUS0czfRnvBu2lpt7FRzDCtomBiI0uPOqSkoRlur5LDGf8zhwcv0cI742aw3qfW1lv5QJUvY504vGKy5QoM/ickDXE9ZY83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80ns6M8r6GDdQwVIuoZDihwetic+WV0809Z37tVXVZU=;
 b=g2HEMdmRJP8ofZFp2ebowbAal57WKs7ES8BLMmdelqn11QX3qcZPspcjH6tr+xIhjM6dzkfei+xiZ5P5cLa6rhAmffdOE/F8xBZdR9XjtXmWz8Hfz2QXEINFcCEyK8YDCWBoryEEc+JN4kwLrh9+6OzV3c9J4fWLcaVNHQqQKcA=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (2603:10b6:a02:ae::29)
 by BYAPR04MB4613.namprd04.prod.outlook.com (2603:10b6:a03:13::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 07:48:30 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e%6]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 07:48:29 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "ardb@kernel.org" <ardb@kernel.org>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "nivedita@alum.mit.edu" <nivedita@alum.mit.edu>,
        "lukas@wunner.de" <lukas@wunner.de>
Subject: Re: [PATCH 13/19] efi/libstub: Move get_dram_base() into arm-stub.c
Thread-Topic: [PATCH 13/19] efi/libstub: Move get_dram_base() into arm-stub.c
Thread-Index: AQHV4CugasGk9YRM9UekC9cWCfOkeKgen7IAgAB66gCADx+9gIAAhvsAgAAC7QA=
Date:   Thu, 27 Feb 2020 07:48:29 +0000
Message-ID: <be1a9d0f835bf4c47a6902181ce23bf1d2c85826.camel@wdc.com>
References: <20200210160248.4889-1-ardb@kernel.org>
         <20200210160248.4889-14-ardb@kernel.org>
         <952796db5423caf21c411c6f5629f32882f55b29.camel@wdc.com>
         <CAKv+Gu_eJvZn8a45t5Hr23+QQySJOBaBwSsxW7dkYCoVPO4RPw@mail.gmail.com>
         <00a157796e420dbc8dee08ae2592daecde8bb07b.camel@wdc.com>
         <CAKv+Gu_NZA8u4QU=KjwNgseWh4=hHWpxDwgn79S1ortj+cSB9g@mail.gmail.com>
In-Reply-To: <CAKv+Gu_NZA8u4QU=KjwNgseWh4=hHWpxDwgn79S1ortj+cSB9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aabbc4e9-0fc4-43a3-7a8e-08d7bb596fc2
x-ms-traffictypediagnostic: BYAPR04MB4613:
x-microsoft-antispam-prvs: <BYAPR04MB46132EEFF56B497FFFCAF866FAEB0@BYAPR04MB4613.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(199004)(189003)(478600001)(2906002)(8676002)(81156014)(81166006)(8936002)(54906003)(4326008)(6486002)(6512007)(966005)(6916009)(66946007)(71200400001)(66446008)(64756008)(66556008)(66476007)(186003)(26005)(36756003)(316002)(86362001)(6506007)(2616005)(5660300002)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4613;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dS6RIrGP9XAgRgjRhTaYLiWR8BNXdDTon03tuOolBUYileWKLDOslhRXRsIHaft3zJUSav9ihIZ+ZQvUBgaWD3dhy1mAh4u2nTxdVpwaVCYY40l61pa9AGM53h07vDrnuT8TZBQgyn+R4WJzgpi4FR7l8V/AmOU4zt+eL13jJlHA33/tx1wfiZexEw+D9ycV6tjm7MhG2Bd+P6vgdZNQPrRkb75Hs7aGfryMPLA5WTnyqPIBOJY98KdSGttFm5M7zF/hpXOI2N9rlEp9JCEPdxnR+7VV6uxc5yea5w7KNy85S5Seb3UCL5Iq2knP1cjSIx6L0JRPsKBmB7+v3kATbxKJwODW5C1SBqVy2syeZ2YbJvR7+MptYq3eSEsZ+IYkrn/4bEs6IuwfL/8m41HauwvLcrtUN45LDpjHc9B3W0FJwuBXnpo7w//pCjqewq2Rhia3z495RYZS5RfyHrmhr+mC+pHfp1/XHwbJhsfdLPWjA7FnPeLOaRnrdmzZu2CLqBa4U3FLXxYvHLu8rs5K1w==
x-ms-exchange-antispam-messagedata: FBuqQNYWQhub/ACvblPVfQj8aNKWeB3rf5/kPikPo1zXWMNGqKxYf1cTSxSzr9GtgGSXIJQC015cbqC1wI2RHssGzySPs8QoV+6Llfps0ibwo74X6yb7Qx49a87Lbta+bc97CU9aTnA9hwLVFvsucg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED449481737FD448A189772E5DCAE383@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabbc4e9-0fc4-43a3-7a8e-08d7bb596fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 07:48:29.5505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUlE2SLubMUZp06TGVL6WiDbKDwJF5Qfc7qOZ+03rKluInQLw4ea2VLPzsGy4Exc9bQwzVPDxOSLDo7omYdDbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4613
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTI3IGF0IDA4OjM4ICswMTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gT24gVGh1LCAyNyBGZWIgMjAyMCBhdCAwMDozNSwgQXRpc2ggUGF0cmEgPEF0aXNoLlBhdHJh
QHdkYy5jb20+DQo+IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMC0wMi0xNyBhdCAwOTozNyArMDEw
MCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6DQo+ID4gPiBPbiBNb24sIDE3IEZlYiAyMDIwIGF0IDAy
OjE3LCBBdGlzaCBQYXRyYSA8QXRpc2guUGF0cmFAd2RjLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+
ID4gPiBPbiBNb24sIDIwMjAtMDItMTAgYXQgMTc6MDIgKzAxMDAsIEFyZCBCaWVzaGV1dmVsIHdy
b3RlOg0KPiA+ID4gPiA+IGdldF9kcmFtX2Jhc2UoKSBpcyBvbmx5IGNhbGxlZCBmcm9tIGFybS1z
dHViLmMgc28gbW92ZSBpdA0KPiA+ID4gPiA+IGludG8NCj4gPiA+ID4gPiB0aGUgc2FtZSBzb3Vy
Y2UgZmlsZSBhcyBpdHMgY2FsbGVyLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gSnVz
dCBGWUk6IHJpc2N2IGVmaSBzdHViIHBvcnQgaXMgYWxzbyBnb2luZyB0byB1c2UNCj4gPiA+ID4g
Z2V0X2RyYW1fYmFzZSgpLg0KPiA+ID4gPiBIb3dldmVyLCBJIGhhdmUgcmVuYW1lZCBhcm0tc3R1
Yi5jIHRvIGdlbmVyaWMgZWZpLXN0dWIuYyBzbw0KPiA+ID4gPiB0aGF0DQo+ID4gPiA+IGFybSwN
Cj4gPiA+ID4gYXJtNjQgYW5kIHJpc2N2IGNhbiByZXVzZSBpdC4gVGh1cywgTW92aW5nIGdldF9k
cmFtX2Jhc2UoKSBpbnRvDQo+ID4gPiA+IGFybS0NCj4gPiA+ID4gc3R1Yi5jIHdvcmtzIGZvciBy
aXNjdiBhcyB3ZWxsLiBJIHdpbGwgcmViYXNlIG15IHBhdGNoZXMgb24gdG9wDQo+ID4gPiA+IG9m
DQo+ID4gPiA+IHRoaXMNCj4gPiA+ID4gc2VyaWVzLg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4g
VGhhbmtzIEF0aXNoLiBJIHdhcyBob3BpbmcgaXQgd291bGQgdHVybiBvdXQgbGlrZSB0aGlzLCB3
aGljaCBpcw0KPiA+ID4gd2h5DQo+ID4gPiBJDQo+ID4gPiBhbSBwdXNoaW5nIHRoaXMgc2VyaWVz
IG5vdy4NCj4gPiA+IA0KPiA+ID4gSSBoYXZlbid0IGxvb2tlZCBhdCB5b3VyIGNvZGUgeWV0LCBi
dXQgcGxlYXNlIGF2b2lkIHVzaW5nIHRoZQ0KPiA+ID4gY29tbWFuZA0KPiA+ID4gbGluZSBiYXNl
ZCBpbml0cmQvZHRiIGxvYWRpbmcgcm91dGluZXMuIEkgYW0gcHJvcG9zaW5nIGEgY2xlYW5lcg0K
PiA+ID4gd2F5DQo+ID4gPiB0byBwcm92aWRlIHRoZSBpbml0cmQgZnJvbSBmaXJtd2FyZSBbMF0s
IGFuZCBkdGIgbG9hZGluZyBieSB0aGUNCj4gPiA+IHN0dWINCj4gPiA+IHNob3VsZCBub3QgYmUg
ZG9uZSBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+ID4gPiANCj4gPiA+IFswXQ0KPiA+ID4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZWZpLzIwMjAwMjE2MTQxMTA0LjIxNDc3LTEtYXJkYkBr
ZXJuZWwub3JnLw0KPiA+IA0KPiA+IFNvcnJ5IEkgbWlzc2VkIHRoaXMgZW1haWwgZWFybGllci4g
WWVzIEkgYW0gbm90IHVzaW5nIGluaXRyZCBvciBkdGINCj4gPiBsb2FkaW5nIGZyb20gVS1Cb290
IGNvbW1hbmQgbGluZS4NCj4gPiANCj4gDQo+IElmIHlvdSB1c2UgYXJtLXN0dWIuYyBtb3N0bHkg
dW5tb2RpZmllZCwgeW91IHdpbGwgYmUgdXNpbmcgaW5pdHJkPQ0KPiBjb21tYW5kIGxpbmUgbG9h
ZGluZywgDQoNCkRvIHlvdSBtZWFuIHRoZSBjb2RlIHBhdGggZW50ZXJzIHRvICJpbml0cmQ9IiBs
b2FkaW5nIHBhcnQgPw0KSSB0aGluayB0aGF0IGNvZGUgcGF0aCBoYXMgYSBtaW5vciBpc3N1ZSB3
aGVyZSBpdCBwcmludHMgZXZlbiBpZiB0aGUNCnRoZXJlIHdhcyBubyAiaW5pdHJkPSIgc3VwcGxp
ZWQgaW4gdGhlIGNvbW1hbmQgbGluZS4NCg0KIkxvYWRlZCBpbml0cmQgZnJvbSBjb21tYW5kIGxp
bmUgb3B0aW9uXG4iIA0KDQpUaGlzIGhhcHBlbnMgYmVjYXVzZSBlZmlfbG9hZF9pbml0cmQgcmV0
dXJucyBFRklfU1VDQ0VTUyBpbiBhYnNlbnNlIG9mDQpjb21tYW5kIHN0cmluZyBhcyB3ZWxsLg0K
DQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9lZmkvZWZp
LmdpdC90cmVlL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvYXJtLXN0dWIuYz9oPW5leHQj
bjI4MQ0KDQo+IGFuZCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gZGlzYWJsZSB0aGF0LCBhbmQgb25s
eQ0KPiBlbmFibGUgaXQgaWYgdGhlcmUgaXMgYSByZXF1ZXN0IGZvciBpdCAod2hpY2ggSSBkb3Vi
dCB3aWxsIGhhcHBlbikuDQoNCi0tIA0KUmVnYXJkcywNCkF0aXNoDQo=
