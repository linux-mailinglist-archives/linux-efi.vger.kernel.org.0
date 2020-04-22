Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE0F1B4CD8
	for <lists+linux-efi@lfdr.de>; Wed, 22 Apr 2020 20:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgDVSsJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Apr 2020 14:48:09 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4471 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVSsI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Apr 2020 14:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587581287; x=1619117287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9hKrVdUr6yO/pp7sbTz2eUVTxHKo+424/gLRznq4nA4=;
  b=dgaoiwd1XkDj9Z0nAhRD++RaEEUOqPDql6VPQDOoXgMbCCyNvDZUFmyZ
   y7PkdfspBhbAIkt4nSV6Smv+yiXRdJLMydnCzT4qJAZIR/H6MEQdu2jM5
   UX9ipWYUugFu++ltGHaFJ3Dv+pua/wnQgb6PgMg37BkMOERqKSQTe+bek
   j9BARILZ/P6g1O7GG+Z2KUnyHcbaAIUOkifcEJdtRtmUzZzH02WN8Uanf
   fZAy7zVHr/u9avIP2DzCSO2YtI9aMCmnDV2wegiz7GbTaPZwnmtZE4cLJ
   Q/Q46lHCZwuv2UlxwGVQAsGawIKKaeIhkeos6RqllHW2enwLjDg3BkP5e
   Q==;
IronPort-SDR: 81zDVFtccrnk1UwTT11dCLj5HbwDagn84jyAvVm+ppAyhu87TvGt7AGp42u6rvfZkxq5DBkHgS
 F8JB3j7ByBLnCanb6BUX6tV+ozl5bdR41OKhV+u4ulFKuRiwIL1OeZGeE0o0MzyvozKEvfT4hi
 +0rPqTopO7QPtC0t8kYS9PpunTG4SlN98APBJ3hvvEjtcdsstCQENDI6H9Or+eHcKcutrrtL7A
 XQmytq+4P25nPihQt7X/oQkrDZooxF0koI1z36VoLwGMIp7UKAxnchgVbXrHR3CBEBW/GmdtKT
 JIs=
X-IronPort-AV: E=Sophos;i="5.73,304,1583164800"; 
   d="scan'208";a="135907722"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 02:48:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlWZUY09ZI4dN6c8+topdzEUf95Uu4dY6zRc7ZrLHX6e/CSxHxn5W7/ajmAavGTx5inSVJC5eCVIsmw77N4jc07ivnZLhkih6LmJe4sxR6brO0bVH9ta+ZabHtd45YYyU4KG63ACtwW9d97pXMmjL1fWQAg8fFrl1YbHHNgdYJuUMmtCU43nBejwzdwdkoTJ1uT70ZpzmwIQMxXHSBhCXO71+CIIQH8XYkBVr1llr8e2wSVqHPeR1MDHJeWTbGzM9VZJXPPQC8dKCRFEpl9dvJxs9FuGk66pXdlynLkIRIlR96ITh9XWueEgKbn4jm2bwyjZCjJ0tbaMYR0NTdG6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hKrVdUr6yO/pp7sbTz2eUVTxHKo+424/gLRznq4nA4=;
 b=fQPpIW93fmqkdGPyaRylPKDfArDFTe7dV/RY9yPU+BG0lcvb1oSlKI8F427mFMNES49NIgcMD0NWE5rOOea3PaLuFxc/DbFX7/xFtFP4YToOqw0+1FzFQUo97fttQut+yOduItU5103mWZpjiMmLbOkhg6cIMT4owEFPXCW8P5d3rkHySmaUMiABhcxNblkpSlfVR8Vrr2/qFVVMxOj2g9aaTJsv0zr4RZ6YTa+b5kQyDov1NuJ81RoYZ6kgt50Il+zMMfTN2DMW3rbx+1AS9k3KchhJz1mIw1K/8kAKtiYrSNsKy/147gyP0xsh3wT90FQhiZOKB1OYFVFvzlfT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hKrVdUr6yO/pp7sbTz2eUVTxHKo+424/gLRznq4nA4=;
 b=EGoUqvwOGqKlweHsL+CgNQDjGcmtTFkW5bSpEqO8Kg8AGDJc6tdz+cSAtFRxKZY/+zao+sDcWZGvOvcaGCQbzEVcWrX/G39ollg14shsWfNP/CWGLGrMwUUagZaNN4PsKyDQyV+HUrRC4ZPs39Ekn4nGooC307Mw8aYHkorWgEE=
Received: from BY5PR04MB6724.namprd04.prod.outlook.com (2603:10b6:a03:219::15)
 by BY5PR04MB6850.namprd04.prod.outlook.com (2603:10b6:a03:21a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 22 Apr
 2020 18:48:05 +0000
Received: from BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::5591:a2e7:4fad:6b0c]) by BY5PR04MB6724.namprd04.prod.outlook.com
 ([fe80::5591:a2e7:4fad:6b0c%6]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 18:48:05 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v5 7/7] RISC-V: Add EFI stub support.
Thread-Topic: [PATCH v5 7/7] RISC-V: Add EFI stub support.
Thread-Index: AQHWGMrxOK/IDTemwUCPZOOKoG6FvaiFe4YA
Date:   Wed, 22 Apr 2020 18:48:04 +0000
Message-ID: <47e7e7a64905eeec1094116234c80a0553b02346.camel@wdc.com>
References: <20200422172414.6662-1-ardb@kernel.org>
         <20200422172414.6662-8-ardb@kernel.org>
In-Reply-To: <20200422172414.6662-8-ardb@kernel.org>
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
x-ms-office365-filtering-correlation-id: 9ac686d5-4071-4576-46ce-08d7e6edb12c
x-ms-traffictypediagnostic: BY5PR04MB6850:
x-microsoft-antispam-prvs: <BY5PR04MB68503B4812D3120CF5F990DEFAD20@BY5PR04MB6850.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6724.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(71200400001)(316002)(36756003)(6512007)(8676002)(26005)(186003)(478600001)(54906003)(86362001)(6486002)(5660300002)(966005)(110136005)(2616005)(4326008)(6506007)(76116006)(2906002)(81156014)(8936002)(66476007)(66946007)(66446008)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eeAITiGHi+MNLkVVz+9gaz/3x4JfMghrZ2ndwsNC9DxZi3Tn7zu++cR3VQ3HG0AMiLiWIl2F8mNBAgdqNzHrNla6mVahXdwcvoEvE9DL49UDZ87G4/4Yd8pPlbBB9xo/I4WDPhYv/2RSeTi/mvMVvvt32eKY59sVgYCfdTm2PiBbR8ZGvlJCuK683SSe0wwzKpho/FOVZbZ66nxmNLoiRqB6AYrBkuUT+yMfZAnt2css1gbmV16z0cJ0+mY598THagt0SC4kyAO+ibXLOuVEraseeEYz74XDJYwc/jQl2UFsoSWGjc4GXsGU4kt0bAD49WLPtc44cPD3eFS+7WX/olBuC/m3rCGtoHOQkx8SNSH/kyI+8PYPMB3J6+aorzDKBYpu1pWk014mQAz5j60Yo0ZKIDylgzWDbNvqLgqwHcm/7G/OqM3K1BvgGVOmfIl+aWXv41qMijb1KWGfjtU1WdFCxC0PYQ6ZX2j8G+D/4VtWgTBIszRi3kMFbM1o/CJ00bh2tcVxveN+SyyvzOc3PQ==
x-ms-exchange-antispam-messagedata: jk2oKCpbC6fJPQsaM7HRtKZ645BQCGofocuSgvei0w1yBxjORV+n1CtY8CQiKpuT7P2bOQ/OgTNPf3qQA0HOABNCXi40yfmQ6zQCAeY+f/yw+QXsymYJzqSpGIoIoUBKKHQm+Vl6WN+XzvtBeFlH1g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <36A17530DF895D47B2F51D7709C432A9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac686d5-4071-4576-46ce-08d7e6edb12c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 18:48:04.9265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZBTx29UtKYuePdYG+0E7CrK6V2O9EUUFQywUtiEkndHQNcReqSO4ZvDQPU3AeAHJ3HSvAFGZFe82Dkn4amV3Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6850
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTIyIGF0IDE5OjI0ICswMjAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gRnJvbTogQXRpc2ggUGF0cmEgPGF0aXNoLnBhdHJhQHdkYy5jb20+DQo+IA0KPiBBZGQgYSBS
SVNDLVYgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHN0dWIgY29kZSB0aGF0IGFjdHVhbGx5IGNvcGll
cyB0aGUNCj4gYWN0dWFsIGtlcm5lbCBpbWFnZSB0byBhIHZhbGlkIGFkZHJlc3MgYW5kIGp1bXAg
dG8gaXQgYWZ0ZXIgYm9vdA0KPiBzZXJ2aWNlcw0KPiBhcmUgdGVybWluYXRlZC4gRW5hYmxlIFVF
RkkgcmVsYXRlZCBrZXJuZWwgY29uZmlncyBhcyB3ZWxsIGZvciBSSVNDLQ0KPiBWLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQXRpc2ggUGF0cmEgPGF0aXNoLnBhdHJhQHdkYy5jb20+DQo+IExpbms6
IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjAwNDIxMDMzMzM2Ljk2NjMtNC1hdGlz
aC5wYXRyYUB3ZGMuY29tDQo+IFthcmRiOiAtIG1vdmUgaGFydGlkIGZldGNoIGludG8gY2hlY2tf
cGxhdGZvcm1fZmVhdHVyZXMoKQ0KPiAgICAgICAgLSB1c2UgaW1hZ2Vfc2l6ZSBub3QgcmVzZXJ2
ZV9zaXplDQo+ICAgICAgICAtIG1vdmVkIGFzbS9lZmkuaCBhZGRpdGlvbiBpbnRvIHNlcGFyYXRl
IHBhdGNoIF0NCj4gU2lnbmVkLW9mZi1ieTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9y
Zz4NCj4gLS0tDQo+ICBhcmNoL3Jpc2N2L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICB8
ICAyMCArKysrDQo+ICBhcmNoL3Jpc2N2L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMSArDQo+ICBhcmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgICAgICB8ICAg
MSArDQo+ICBkcml2ZXJzL2Zpcm13YXJlL2VmaS9LY29uZmlnICAgICAgICAgICAgICB8ICAgNCAr
LQ0KPiAgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9NYWtlZmlsZSAgICAgfCAgMTAgKysN
Cj4gIGRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvcmlzY3Ytc3R1Yi5jIHwgMTA5ICsrKysr
KysrKysrKysrKysrKysrDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDE0MyBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvS2NvbmZpZyBiL2Fy
Y2gvcmlzY3YvS2NvbmZpZw0KPiBpbmRleCBmMDVkZDA5YWNkNDguLjU0Yzc4Y2FmY2QzNSAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9LY29uZmlnDQo+ICsrKyBiL2FyY2gvcmlzY3YvS2NvbmZp
Zw0KPiBAQCAtMzc5LDEwICszNzksMzAgQEAgY29uZmlnIENNRExJTkVfRk9SQ0UNCj4gIA0KPiAg
ZW5kY2hvaWNlDQo+ICANCj4gK2NvbmZpZyBFRklfU1RVQg0KPiArCWJvb2wNCj4gKw0KPiArY29u
ZmlnIEVGSQ0KPiArCWJvb2wgIlVFRkkgcnVudGltZSBzdXBwb3J0Ig0KPiArCWRlcGVuZHMgb24g
T0YNCj4gKwlzZWxlY3QgTElCRkRUDQo+ICsJc2VsZWN0IFVDUzJfU1RSSU5HDQo+ICsJc2VsZWN0
IEVGSV9QQVJBTVNfRlJPTV9GRFQNCj4gKwlzZWxlY3QgRUZJX1NUVUINCj4gKwlzZWxlY3QgRUZJ
X0dFTkVSSUNfU1RVQg0KDQpBcyBwYWxtZXIgc3VnZ2VzdGVkIFJJU0NWX0lTQV9DIHNob3VsZCBi
ZSBzZWxlY3RlZCBoZXJlIHRvIGF2b2lkDQp1bmludGVudGlvbmFsIGVycm9ycy4gT3RoZXJ3aXNl
LCBldmVyeSBsb29rcyBnb29kLg0KDQo+ICsJZGVmYXVsdCB5DQo+ICsJaGVscA0KPiArCSAgVGhp
cyBvcHRpb24gcHJvdmlkZXMgc3VwcG9ydCBmb3IgcnVudGltZSBzZXJ2aWNlcyBwcm92aWRlZA0K
PiArCSAgYnkgVUVGSSBmaXJtd2FyZSAoc3VjaCBhcyBub24tdm9sYXRpbGUgdmFyaWFibGVzLCBy
ZWFsdGltZQ0KPiArCSAgY2xvY2ssIGFuZCBwbGF0Zm9ybSByZXNldCkuIEEgVUVGSSBzdHViIGlz
IGFsc28gcHJvdmlkZWQgdG8NCj4gKwkgIGFsbG93IHRoZSBrZXJuZWwgdG8gYmUgYm9vdGVkIGFz
IGFuIEVGSSBhcHBsaWNhdGlvbi4gVGhpcw0KPiArCSAgaXMgb25seSB1c2VmdWwgb24gc3lzdGVt
cyB0aGF0IGhhdmUgVUVGSSBmaXJtd2FyZS4NCj4gKw0KPiAgZW5kbWVudQ0KPiAgDQo+ICBtZW51
ICJQb3dlciBtYW5hZ2VtZW50IG9wdGlvbnMiDQo+ICANCj4gIHNvdXJjZSAia2VybmVsL3Bvd2Vy
L0tjb25maWciDQo+ICtzb3VyY2UgImRyaXZlcnMvZmlybXdhcmUvS2NvbmZpZyINCj4gIA0KPiAg
ZW5kbWVudQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9NYWtlZmlsZSBiL2FyY2gvcmlzY3Yv
TWFrZWZpbGUNCj4gaW5kZXggZmI2ZTM3ZGI4MzZkLi4wNzk0MzU4MDRkNmQgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvcmlzY3YvTWFrZWZpbGUNCj4gKysrIGIvYXJjaC9yaXNjdi9NYWtlZmlsZQ0KPiBA
QCAtODAsNiArODAsNyBAQCBoZWFkLXkgOj0gYXJjaC9yaXNjdi9rZXJuZWwvaGVhZC5vDQo+ICBj
b3JlLXkgKz0gYXJjaC9yaXNjdi8NCj4gIA0KPiAgbGlicy15ICs9IGFyY2gvcmlzY3YvbGliLw0K
PiArY29yZS0kKENPTkZJR19FRklfU1RVQikgKz0NCj4gJChvYmp0cmVlKS9kcml2ZXJzL2Zpcm13
YXJlL2VmaS9saWJzdHViL2xpYi5hDQo+ICANCj4gIFBIT05ZICs9IHZkc29faW5zdGFsbA0KPiAg
dmRzb19pbnN0YWxsOg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9jb25maWdzL2RlZmNvbmZp
Zw0KPiBiL2FyY2gvcmlzY3YvY29uZmlncy9kZWZjb25maWcNCj4gaW5kZXggNGRhNDg4NjI0NmE0
Li5hZTY5ZTEyZDMwNmEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvY29uZmlncy9kZWZjb25m
aWcNCj4gKysrIGIvYXJjaC9yaXNjdi9jb25maWdzL2RlZmNvbmZpZw0KPiBAQCAtMTI5LDMgKzEy
OSw0IEBAIENPTkZJR19ERUJVR19CTE9DS19FWFRfREVWVD15DQo+ICAjIENPTkZJR19SVU5USU1F
X1RFU1RJTkdfTUVOVSBpcyBub3Qgc2V0DQo+ICBDT05GSUdfTUVNVEVTVD15DQo+ICAjIENPTkZJ
R19TWVNGU19TWVNDQUxMIGlzIG5vdCBzZXQNCj4gK0NPTkZJR19FRkk9eQ0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvS2NvbmZpZw0KPiBiL2RyaXZlcnMvZmlybXdhcmUvZWZp
L0tjb25maWcNCj4gaW5kZXggNGU3ODhkZDU1YjAzLi44YmZjMTczODFiMjkgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9maXJtd2Fy
ZS9lZmkvS2NvbmZpZw0KPiBAQCAtMTExLDcgKzExMSw3IEBAIGNvbmZpZyBFRklfR0VORVJJQ19T
VFVCDQo+ICANCj4gIGNvbmZpZyBFRklfQVJNU1RVQl9EVEJfTE9BREVSDQo+ICAJYm9vbCAiRW5h
YmxlIHRoZSBEVEIgbG9hZGVyIg0KPiAtCWRlcGVuZHMgb24gRUZJX0dFTkVSSUNfU1RVQg0KPiAr
CWRlcGVuZHMgb24gRUZJX0dFTkVSSUNfU1RVQiAmJiAhUklTQ1YNCj4gIAlkZWZhdWx0IHkNCj4g
IAloZWxwDQo+ICAJICBTZWxlY3QgdGhpcyBjb25maWcgb3B0aW9uIHRvIGFkZCBzdXBwb3J0IGZv
ciB0aGUgZHRiPSBjb21tYW5kDQo+IEBAIC0xMjYsNyArMTI2LDcgQEAgY29uZmlnIEVGSV9BUk1T
VFVCX0RUQl9MT0FERVINCj4gIA0KPiAgY29uZmlnIEVGSV9HRU5FUklDX1NUVUJfSU5JVFJEX0NN
RExJTkVfTE9BREVSDQo+ICAJYm9vbCAiRW5hYmxlIHRoZSBjb21tYW5kIGxpbmUgaW5pdHJkIGxv
YWRlciINCj4gLQlkZXBlbmRzIG9uIEVGSV9HRU5FUklDX1NUVUINCj4gKwlkZXBlbmRzIG9uIEVG
SV9HRU5FUklDX1NUVUIgJiYgIVJJU0NWDQo+ICAJZGVmYXVsdCB5DQo+ICAJaGVscA0KPiAgCSAg
U2VsZWN0IHRoaXMgY29uZmlnIG9wdGlvbiB0byBhZGQgc3VwcG9ydCBmb3IgdGhlIGluaXRyZD0N
Cj4gY29tbWFuZA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9N
YWtlZmlsZQ0KPiBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvTWFrZWZpbGUNCj4gaW5k
ZXggNzVjYjJjM2ExNTE5Li5hNGZkMWIwNDhlOGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZmly
bXdhcmUvZWZpL2xpYnN0dWIvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9lZmkv
bGlic3R1Yi9NYWtlZmlsZQ0KPiBAQCAtMjIsNiArMjIsOCBAQCBjZmxhZ3MtJChDT05GSUdfQVJN
NjQpCQk6PSAkKHN1YnN0DQo+ICQoQ0NfRkxBR1NfRlRSQUNFKSwsJChLQlVJTERfQ0ZMQUdTKSkg
XA0KPiAgY2ZsYWdzLSQoQ09ORklHX0FSTSkJCTo9ICQoc3Vic3QNCj4gJChDQ19GTEFHU19GVFJB
Q0UpLCwkKEtCVUlMRF9DRkxBR1MpKSBcDQo+ICAJCQkJICAgLWZuby1idWlsdGluIC1mcGljIFwN
Cj4gIAkJCQkgICAkKGNhbGwgY2Mtb3B0aW9uLC1tbm8tc2luZ2xlLXBpYy0NCj4gYmFzZSkNCj4g
K2NmbGFncy0kKENPTkZJR19SSVNDVikJCTo9ICQoc3Vic3QNCj4gJChDQ19GTEFHU19GVFJBQ0Up
LCwkKEtCVUlMRF9DRkxBR1MpKSBcDQo+ICsJCQkJICAgLWZwaWMNCj4gIA0KPiAgY2ZsYWdzLSQo
Q09ORklHX0VGSV9HRU5FUklDX1NUVUIpICs9IC1JJChzcmN0cmVlKS9zY3JpcHRzL2R0Yy9saWJm
ZHQNCj4gIA0KPiBAQCAtNTYsNiArNTgsNyBAQCBsaWItJChDT05GSUdfRUZJX0dFTkVSSUNfU1RV
QikJKz0gZWZpLXN0dWIubw0KPiBmZHQubyBzdHJpbmcubyBcDQo+ICBsaWItJChDT05GSUdfQVJN
KQkJKz0gYXJtMzItc3R1Yi5vDQo+ICBsaWItJChDT05GSUdfQVJNNjQpCQkrPSBhcm02NC1zdHVi
Lm8NCj4gIGxpYi0kKENPTkZJR19YODYpCQkrPSB4ODYtc3R1Yi5vDQo+ICtsaWItJChDT05GSUdf
UklTQ1YpCQkrPSByaXNjdi1zdHViLm8NCj4gIENGTEFHU19hcm0zMi1zdHViLm8JCTo9IC1EVEVY
VF9PRkZTRVQ9JChURVhUX09GRlNFVCkNCj4gIENGTEFHU19hcm02NC1zdHViLm8JCTo9IC1EVEVY
VF9PRkZTRVQ9JChURVhUX09GRlNFVCkNCj4gIA0KPiBAQCAtODAsNiArODMsMTMgQEAgU1RVQkNP
UFlfRkxBR1MtJChDT05GSUdfQVJNNjQpCSs9IC0tcHJlZml4LQ0KPiBhbGxvYy1zZWN0aW9ucz0u
aW5pdCBcDQo+ICAJCQkJICAgLS1wcmVmaXgtc3ltYm9scz1fX2VmaXN0dWJfDQo+ICBTVFVCQ09Q
WV9SRUxPQy0kKENPTkZJR19BUk02NCkJOj0gUl9BQVJDSDY0X0FCUw0KPiAgDQo+ICsjIEZvciBS
SVNDLVYsIHdlIGRvbid0IG5lZWQgYW55dGhpbmcgc3BlY2lhbCBvdGhlciB0aGFuIGFybTY0LiBL
ZWVwDQo+IGFsbCB0aGUNCj4gKyMgc3ltYm9scyBpbiAuaW5pdCBzZWN0aW9uIGFuZCBtYWtlIHN1
cmUgdGhhdCBubyBhYnNvbHV0ZSBzeW1ib2xzDQo+IHJlZmVyZW5jZXMNCj4gKyMgZG9lc24ndCBl
eGlzdC4NCj4gK1NUVUJDT1BZX0ZMQUdTLSQoQ09ORklHX1JJU0NWKQkrPSAtLXByZWZpeC1hbGxv
Yy0NCj4gc2VjdGlvbnM9LmluaXQgXA0KPiArCQkJCSAgIC0tcHJlZml4LXN5bWJvbHM9X19lZmlz
dHViXw0KPiArU1RVQkNPUFlfUkVMT0MtJChDT05GSUdfUklTQ1YpCTo9IFJfUklTQ1ZfSEkyMA0K
PiArDQo+ICAkKG9iaikvJS5zdHViLm86ICQob2JqKS8lLm8gRk9SQ0UNCj4gIAkkKGNhbGwgaWZf
Y2hhbmdlZCxzdHViY29weSkNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9l
ZmkvbGlic3R1Yi9yaXNjdi1zdHViLmMNCj4gYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHVi
L3Jpc2N2LXN0dWIuYw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAw
MDAuLjM0OTY0NjkyOGU5Yg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2RyaXZlcnMvZmlybXdh
cmUvZWZpL2xpYnN0dWIvcmlzY3Ytc3R1Yi5jDQo+IEBAIC0wLDAgKzEsMTA5IEBADQo+ICsvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyoNCj4gKyAqIENvcHlyaWdodCAo
QykgMjAyMCBXZXN0ZXJuIERpZ2l0YWwgQ29ycG9yYXRpb24gb3IgaXRzIGFmZmlsaWF0ZXMuDQo+
ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L2VmaS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4
L2xpYmZkdC5oPg0KPiArDQo+ICsjaW5jbHVkZSA8YXNtL2VmaS5oPg0KPiArI2luY2x1ZGUgPGFz
bS9zZWN0aW9ucy5oPg0KPiArDQo+ICsjaW5jbHVkZSAiZWZpc3R1Yi5oIg0KPiArDQo+ICsvKg0K
PiArICogUklTQy1WIHJlcXVpcmVzIHRoZSBrZXJuZWwgaW1hZ2UgdG8gcGxhY2VkIDIgTUIgYWxp
Z25lZCBiYXNlIGZvcg0KPiA2NCBiaXQgYW5kDQo+ICsgKiA0TUIgZm9yIDMyIGJpdC4NCj4gKyAq
Lw0KPiArI2lmZGVmIENPTkZJR182NEJJVA0KPiArI2RlZmluZSBNSU5fS0lNR19BTElHTgkJU1pf
Mk0NCj4gKyNlbHNlDQo+ICsjZGVmaW5lIE1JTl9LSU1HX0FMSUdOCQlTWl80TQ0KPiArI2VuZGlm
DQo+ICsNCj4gK3R5cGVkZWYgdm9pZCBfX25vcmV0dXJuICgqanVtcF9rZXJuZWxfZnVuYykodW5z
aWduZWQgaW50LCB1bnNpZ25lZA0KPiBsb25nKTsNCj4gKw0KPiArc3RhdGljIHUzMiBoYXJ0aWQ7
DQo+ICsNCj4gK3N0YXRpYyB1MzIgZ2V0X2Jvb3RfaGFydGlkX2Zyb21fZmR0KHZvaWQpDQo+ICt7
DQo+ICsJY29uc3Qgdm9pZCAqZmR0Ow0KPiArCWludCBjaG9zZW5fbm9kZSwgbGVuOw0KPiArCWNv
bnN0IGZkdDMyX3QgKnByb3A7DQo+ICsNCj4gKwlmZHQgPSBnZXRfZWZpX2NvbmZpZ190YWJsZShE
RVZJQ0VfVFJFRV9HVUlEKTsNCj4gKwlpZiAoIWZkdCkNCj4gKwkJcmV0dXJuIFUzMl9NQVg7DQo+
ICsNCj4gKwljaG9zZW5fbm9kZSA9IGZkdF9wYXRoX29mZnNldChmZHQsICIvY2hvc2VuIik7DQo+
ICsJaWYgKGNob3Nlbl9ub2RlIDwgMCkNCj4gKwkJcmV0dXJuIFUzMl9NQVg7DQo+ICsNCj4gKwlw
cm9wID0gZmR0X2dldHByb3AoKHZvaWQgKilmZHQsIGNob3Nlbl9ub2RlLCAiYm9vdC1oYXJ0aWQi
LA0KPiAmbGVuKTsNCj4gKwlpZiAoIXByb3AgfHwgbGVuICE9IHNpemVvZih1MzIpKQ0KPiArCQly
ZXR1cm4gVTMyX01BWDsNCj4gKw0KPiArCXJldHVybiBmZHQzMl90b19jcHUoKnByb3ApOw0KPiAr
fQ0KPiArDQo+ICtlZmlfc3RhdHVzX3QgY2hlY2tfcGxhdGZvcm1fZmVhdHVyZXModm9pZCkNCj4g
K3sNCj4gKwloYXJ0aWQgPSBnZXRfYm9vdF9oYXJ0aWRfZnJvbV9mZHQoKTsNCj4gKwlpZiAoaGFy
dGlkID09IFUzMl9NQVgpIHsNCj4gKwkJcHJfZWZpX2VycigiL2Nob3Nlbi9ib290LWhhcnRpZCBt
aXNzaW5nIG9yDQo+IGludmFsaWQhXG4iKTsNCj4gKwkJcmV0dXJuIEVGSV9VTlNVUFBPUlRFRDsN
Cj4gKwl9DQo+ICsJcmV0dXJuIEVGSV9TVUNDRVNTOw0KPiArfQ0KPiArDQo+ICt2b2lkIF9fbm9y
ZXR1cm4gZWZpX2VudGVyX2tlcm5lbCh1bnNpZ25lZCBsb25nIGVudHJ5cG9pbnQsIHVuc2lnbmVk
DQo+IGxvbmcgZmR0LA0KPiArCQkJCSB1bnNpZ25lZCBsb25nIGZkdF9zaXplKQ0KPiArew0KPiAr
CXVuc2lnbmVkIGxvbmcga2VybmVsX2VudHJ5ID0gZW50cnlwb2ludCArICh1bnNpZ25lZA0KPiBs
b25nKXN0ZXh0X29mZnNldDsNCj4gKwlqdW1wX2tlcm5lbF9mdW5jIGp1bXBfa2VybmVsID0gKGp1
bXBfa2VybmVsX2Z1bmMpa2VybmVsX2VudHJ5Ow0KPiArDQo+ICsJLyoNCj4gKwkgKiBKdW1wIHRv
IHJlYWwga2VybmVsIGhlcmUgd2l0aCBmb2xsb3dpbmcgY29uc3RyYWludHMuDQo+ICsJICogMS4g
TU1VIHNob3VsZCBiZSBkaXNhYmxlZC4NCj4gKwkgKiAyLiBhMCBzaG91bGQgY29udGFpbiBoYXJ0
aWQNCj4gKwkgKiAzLiBhMSBzaG91bGQgRFQgYWRkcmVzcw0KPiArCSAqLw0KPiArCWNzcl93cml0
ZShDU1JfU0FUUCwgMCk7DQo+ICsJanVtcF9rZXJuZWwoaGFydGlkLCBmZHQpOw0KPiArfQ0KPiAr
DQo+ICtlZmlfc3RhdHVzX3QgaGFuZGxlX2tlcm5lbF9pbWFnZSh1bnNpZ25lZCBsb25nICppbWFn
ZV9hZGRyLA0KPiArCQkJCSB1bnNpZ25lZCBsb25nICppbWFnZV9zaXplLA0KPiArCQkJCSB1bnNp
Z25lZCBsb25nICpyZXNlcnZlX2FkZHIsDQo+ICsJCQkJIHVuc2lnbmVkIGxvbmcgKnJlc2VydmVf
c2l6ZSwNCj4gKwkJCQkgdW5zaWduZWQgbG9uZyBkcmFtX2Jhc2UsDQo+ICsJCQkJIGVmaV9sb2Fk
ZWRfaW1hZ2VfdCAqaW1hZ2UpDQo+ICt7DQo+ICsJdW5zaWduZWQgbG9uZyBrZXJuZWxfc2l6ZSA9
IDA7DQo+ICsJdW5zaWduZWQgbG9uZyBwcmVmZXJyZWRfYWRkcjsNCj4gKwllZmlfc3RhdHVzX3Qg
c3RhdHVzOw0KPiArDQo+ICsJa2VybmVsX3NpemUgPSBfZWRhdGEgLSBfc3RhcnQ7DQo+ICsJKmlt
YWdlX2FkZHIgPSAodW5zaWduZWQgbG9uZylfc3RhcnQ7DQo+ICsJKmltYWdlX3NpemUgPSBrZXJu
ZWxfc2l6ZSArIChfZW5kIC0gX2VkYXRhKTsNCj4gKw0KPiArCS8qDQo+ICsJICogUklTQy1WIGtl
cm5lbCBtYXBzIFBBR0VfT0ZGU0VUIHZpcnR1YWwgYWRkcmVzcyB0byB0aGUgc2FtZQ0KPiBwaHlz
aWNhbA0KPiArCSAqIGFkZHJlc3Mgd2hlcmUga2VybmVsIGlzIGJvb3RlZC4gVGhhdCdzIHdoeSBr
ZXJuZWwgc2hvdWxkDQo+IGJvb3QgZnJvbQ0KPiArCSAqIGFzIGxvdyBhcyBwb3NzaWJsZSB0byBh
dm9pZCB3YXN0YWdlIG9mIG1lbW9yeS4gQ3VycmVudGx5LA0KPiBkcmFtX2Jhc2UNCj4gKwkgKiBp
cyBvY2N1cGllZCBieSB0aGUgZmlybXdhcmUuIFNvIHRoZSBwcmVmZXJyZWQgYWRkcmVzcyBmb3IN
Cj4ga2VybmVsIHRvDQo+ICsJICogYm9vdCBpcyBuZXh0IGFsaWduZWQgYWRkcmVzcy4gSWYgcHJl
ZmVycmVkIGFkZHJlc3MgaXMgbm90DQo+IGF2YWlsYWJsZSwNCj4gKwkgKiByZWxvY2F0ZV9rZXJu
ZWwgd2lsbCBmYWxsIGJhY2sgdG8gZWZpX2xvd19hbGxvY19hYm92ZSB0bw0KPiBhbGxvY2F0ZQ0K
PiArCSAqIGxvd2VzdCBwb3NzaWJsZSBtZW1vcnkgcmVnaW9uIGFzIGxvbmcgYXMgdGhlIGFkZHJl
c3MgYW5kDQo+IHNpemUgbWVldHMNCj4gKwkgKiB0aGUgYWxpZ25tZW50IGNvbnN0cmFpbnRzLg0K
PiArCSAqLw0KPiArCXByZWZlcnJlZF9hZGRyID0gcm91bmRfdXAoZHJhbV9iYXNlLCBNSU5fS0lN
R19BTElHTikgKw0KPiBNSU5fS0lNR19BTElHTjsNCj4gKwlzdGF0dXMgPSBlZmlfcmVsb2NhdGVf
a2VybmVsKGltYWdlX2FkZHIsIGtlcm5lbF9zaXplLA0KPiAqaW1hZ2Vfc2l6ZSwNCj4gKwkJCQkg
ICAgIHByZWZlcnJlZF9hZGRyLCBNSU5fS0lNR19BTElHTiwNCj4gZHJhbV9iYXNlKTsNCj4gKw0K
PiArCWlmIChzdGF0dXMgIT0gRUZJX1NVQ0NFU1MpIHsNCj4gKwkJcHJfZWZpX2VycigiRmFpbGVk
IHRvIHJlbG9jYXRlIGtlcm5lbFxuIik7DQo+ICsJCSppbWFnZV9zaXplID0gMDsNCj4gKwl9DQo+
ICsJcmV0dXJuIHN0YXR1czsNCj4gK30NCg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
