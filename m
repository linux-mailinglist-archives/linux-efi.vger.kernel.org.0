Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C17B716EEDE
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 20:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgBYTSo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 14:18:44 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58264 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBYTSo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Feb 2020 14:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582658323; x=1614194323;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s4EEt31MyvBhg++3g55F+H+5eRhMYEWmbcvaZ2dYeK0=;
  b=Btz/Azd/MA+w99GNSXTTWfKzNHETGx6B/c9f2uKZXLIP2Nu3hYQP3eRx
   q9BwjuJStqCq54nEQ7A1fGVB2P1lDtO11W5g8PtPMmMf4fC8S43L38aYQ
   IV+qFhBxZ3kmunklIOpzKUjxamq7pIaaavH2dVtfnHsPkRgO/PYvGp2Oi
   +nof6YqWxMN2ESQjj7eoicB98OeWskd+f1zV2k8v6SGbTK59eSNB5gGGy
   1aqrB6+H8G38CA1iLXTimnc4hDmRkdbDq7htzuUMDnCnxPLBb97ZO62PN
   nLMUVNH4UUYAmKcecoG0wS/2RNxlWV30lbmVJNx77F/BROwETyQXq7etS
   A==;
IronPort-SDR: Y9Jv1+U/5vnDbPYbuEdO8m/lhJ1vPCFsAX9pjVpDI9hM2JWGpt1EPPAnFqC+e1RHDwH5Cv4mom
 pfjIhxFZM0DCqVHxxbkpyS2qGGBXb+3ErFponaLUeGoAQATvcFfjbv/H0nDsiicoBO8R2L5Ibz
 pFgLt3/BwH29pHnWZpbRld/tV4TtSWroi64LjP3ylnJ6mi8EOt05tO404YMCCF37tkY1/FrTbW
 VSK/YqJdYECI0+0D2jpXLqvFdSY+YbiX8ey4/HKjAQGPsb3wjmc9YOijM1o5TG5QlV4wwtrN36
 Lp8=
X-IronPort-AV: E=Sophos;i="5.70,485,1574092800"; 
   d="scan'208";a="131242573"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2020 03:18:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnAprPfHj4KZJ/hZdDCHAm3xD0hAqIJ+XGBzwyTB5qE85lgkpciIryTnD6H1o3tOksiatwqEEEfoPp3huI6apZCqNdLblt9GVPxBtH5AKOJy26xpQbeZSwgkY/UI50pBiZ8tj5K/nidftzBNIPuiiIU61iW/1Cb3bW5FQ1aGLjwQLnW9TcQbQpbXZn2qrVQOFX7BoYpO3Tf0/z6/H8WgK0jKGI7AEaj+N/pDPdf4fkKlH5CshlrxXdVpHnG++1qxA43lo9Q+G/pmIkTR3kjbYop8c2ZL1lyEvBVAEn9uuv2JoHfgMoIiLHqyEWE0ZkQ1evnMcylxNCOEESoBMJNFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4EEt31MyvBhg++3g55F+H+5eRhMYEWmbcvaZ2dYeK0=;
 b=Sim0KdjJueIC+qguVX5cqBsoYDob5xgoGYhRCAtoe4Kpjo2hwNDdd2D5yIiMuNXtUQyyYShZA2vpKaFA3/kr9jg5uideNfHxcSOSqIGe+HXcy4uriVyEA0vdW0syx8pK+DJ4r+CKLVwpAKZKw/I2zuyEB3f8uZPK0UuXxnR71kmgdmkmDzmjhhzqkC2cHFpLEqPRZAVE0wpEkDvhl2jjEYSY3xKbgw7lRjvJ/jqYbyzW3bWKM/eNQv8bfvsKMS1hVGRHEALZeNuvFRTTPM8UT4C8PkRjTN5HENdYwSx0jTFRkgwIsX3g4xeIO3PSSJmYIRI6cd+WcwUo3ryIof5n7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4EEt31MyvBhg++3g55F+H+5eRhMYEWmbcvaZ2dYeK0=;
 b=UKIxuvCgoR+7m+o2FLb3qnzS+fO6Z6ls1TZfqPFqoozDHd0udsge6FgBiPTKaXM3GwrJWb3wGKkk+YcZB/xilodVT1SfpjEQmB4at3BrSpvAGMscrXyX1tFx0RhVQP8gpd080nwZl33EGXunGM0u3fJPwiM5VOzj2NrjNEMiHAc=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (2603:10b6:a02:ae::29)
 by BYAPR04MB3877.namprd04.prod.outlook.com (2603:10b6:a02:ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Tue, 25 Feb
 2020 19:18:33 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 19:18:32 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "ardb@kernel.org" <ardb@kernel.org>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "nivedita@alum.mit.edu" <nivedita@alum.mit.edu>,
        "lukas@wunner.de" <lukas@wunner.de>
Subject: Re: [PATCH 03/19] efi/libstub: Use hidden visiblity for all source
 files
Thread-Topic: [PATCH 03/19] efi/libstub: Use hidden visiblity for all source
 files
Thread-Index: AQHV4CuVi5Pe50PEP02TQgbPh7708qgrEEAAgAAF9YCAAUougA==
Date:   Tue, 25 Feb 2020 19:18:32 +0000
Message-ID: <8801a47f278447b284a06879b026fed76658cef9.camel@wdc.com>
References: <20200210160248.4889-1-ardb@kernel.org>
         <20200210160248.4889-4-ardb@kernel.org>
         <d3402c42836aca94d1a2ff385c088af605578068.camel@wdc.com>
         <CAKv+Gu9bPsiJLQqsfXwDMNe-VCsVCqDNvZAiCnon18kYG4M9qA@mail.gmail.com>
In-Reply-To: <CAKv+Gu9bPsiJLQqsfXwDMNe-VCsVCqDNvZAiCnon18kYG4M9qA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f04365c5-7a9d-4361-fdbe-08d7ba27811f
x-ms-traffictypediagnostic: BYAPR04MB3877:
x-microsoft-antispam-prvs: <BYAPR04MB3877A1BEA301974EAFE0D2E7FAED0@BYAPR04MB3877.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(189003)(199004)(71200400001)(2616005)(8936002)(66556008)(66476007)(6486002)(26005)(36756003)(8676002)(64756008)(66446008)(186003)(4326008)(478600001)(66946007)(316002)(76116006)(54906003)(6916009)(6512007)(81166006)(2906002)(81156014)(86362001)(5660300002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3877;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K1CvbfOVFOWUGxMVpGA50i6WwhEc16AP5Cq+OHo9YP9FoBD9cZSqOmNZ3etgJ482eUQxc5+yZr/EC84Gj/3ABhoaFlwANKadH1RCz3eQJ4NQpW7gIqYd8J+KbCgNLm3feILlRIxXgcjcvYTp5UIqNAJuqmZ6ubnzdEgNQGEW55uyWA1xSxPhQrjXxLfPacOryEdaOXXe6jQFXlAc25XZ4SMPuVyIdIgySVJ9r8BM2Krp1WCjZWpaCGckLgMqaS7gVMHE5bJdYxyaW3nbVdZcUlAI/+9IclVQhCEi7n4ornBzc2HYGY8ztQ8tX+UHCXMa+oJaOdfbJWxzBro103TbPs/stwbPVfBGN3gnVxxjGExofeWI5//7PF3EGQ1oxNtjX/3mBfDc1gZI8jZ7iqe+Z2GyFpxLH6ELkBelnGteujgjfVPppBiAgsl2MLoVgf9W
x-ms-exchange-antispam-messagedata: 7KsjUlCbB6fCh86tdaq2mdTjYxo4y8lL4AGJuQV5F/yW+K8ZHP7eG/ZcM4OI0GGzUbzwswsCa/NEmLzLLDk1cKiu0ZydGGUsUxN2nHbgboLWD62GIiPP9iXVctQgGxQVaoDQaAgeAWWhdyBfc0QfOA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1BFBC2862EBA3428165B12327E3EA6B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04365c5-7a9d-4361-fdbe-08d7ba27811f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 19:18:32.7213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rpDbRigxH1g9x6sje5PhHZ4VrY1peekW32WIJ5yLF/Cpdi5MROCUOG66J1BnfpYgKadPuDtWeemlfpNAyKgdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3877
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTI1IGF0IDAwOjM2ICswMTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gT24gVHVlLCAyNSBGZWIgMjAyMCBhdCAwMDoxNSwgQXRpc2ggUGF0cmEgPEF0aXNoLlBhdHJh
QHdkYy5jb20+DQo+IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMC0wMi0xMCBhdCAxNzowMiArMDEw
MCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6DQo+ID4gPiBJbnN0ZWFkIG9mIHNldHRpbmcgdGhlIHZp
c2liaWxpdHkgcHJhZ21hIGZvciBhIHNtYWxsIHNldCBvZg0KPiA+ID4gc3ltYm9sDQo+ID4gPiBk
ZWNsYXJhdGlvbnMgdGhhdCBjb3VsZCByZXN1bHQgaW4gYWJzb2x1dGUgcmVmZXJlbmNlcyB0aGF0
IHdlDQo+ID4gPiBjYW5ub3QNCj4gPiA+IHN1cHBvcnQgaW4gdGhlIHN0dWIsIGRlY2xhcmUgaGlk
ZGVuIHZpc2liaWxpdHkgZm9yIGFsbCBjb2RlIGluDQo+ID4gPiB0aGUNCj4gPiA+IEVGSSBzdHVi
LCB3aGljaCBpcyBtb3JlIHJvYnVzdCBhbmQgZnV0dXJlIHByb29mLg0KPiA+ID4gDQo+ID4gPiBU
byBlbnN1cmUgdGhhdCB0aGUgI3ByYWdtYSBpcyB0YWtlbiBpbnRvIGFjY291bnQgYmVmb3JlIGFu
eSBvdGhlcg0KPiA+ID4gaW5jbHVkZXMgYXJlIHByb2Nlc3NlZCwgcHV0IGl0IGluIGEgaGVhZGVy
IGZpbGUgb2YgaXRzIG93biBhbmQNCj4gPiA+IGluY2x1ZGUgaXQgdmlhIHRoZSBjb21waWxlciBj
b21tYW5kIGxpbmUgdXNpbmcgdGhlIC1pbmNsdWRlDQo+ID4gPiBvcHRpb24uDQo+ID4gPiANCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+ID4g
PiAtLS0NCj4gPiA+ICBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL2VmaS5oICAgICAgICAgICAgICB8
IDMgLS0tDQo+ID4gPiAgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9NYWtlZmlsZSAgICAg
fCAyICstDQo+ID4gPiAgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9hcm02NC1zdHViLmMg
fCA4ICstLS0tLS0tDQo+ID4gPiAgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9oaWRkZW4u
aCAgICAgfCA2ICsrKysrKw0KPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
LCAxMSBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQv
aW5jbHVkZS9hc20vZWZpLmgNCj4gPiA+IGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9lZmkuaA0K
PiA+ID4gaW5kZXggNDQ1MzFhNjlkMzJiLi41NmFlODc0MDFhMjYgMTAwNjQ0DQo+ID4gPiAtLS0g
YS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2VmaS5oDQo+ID4gPiArKysgYi9hcmNoL2FybTY0L2lu
Y2x1ZGUvYXNtL2VmaS5oDQo+ID4gPiBAQCAtMTA3LDkgKzEwNyw2IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBmcmVlX3NjcmVlbl9pbmZvKHN0cnVjdA0KPiA+ID4gc2NyZWVuX2luZm8gKnNpKQ0KPiA+
ID4gIHsNCj4gPiA+ICB9DQo+ID4gPiANCj4gPiA+IC0vKiByZWRlY2xhcmUgYXMgJ2hpZGRlbicg
c28gdGhlIGNvbXBpbGVyIHdpbGwgZ2VuZXJhdGUgcmVsYXRpdmUNCj4gPiA+IHJlZmVyZW5jZXMg
Ki8NCj4gPiA+IC1leHRlcm4gc3RydWN0IHNjcmVlbl9pbmZvIHNjcmVlbl9pbmZvDQo+ID4gPiBf
X2F0dHJpYnV0ZV9fKChfX3Zpc2liaWxpdHlfXygiaGlkZGVuIikpKTsNCj4gPiA+IC0NCj4gPiA+
ICBzdGF0aWMgaW5saW5lIHZvaWQgZWZpZmJfc2V0dXBfZnJvbV9kbWkoc3RydWN0IHNjcmVlbl9p
bmZvICpzaSwNCj4gPiA+IGNvbnN0IGNoYXIgKm9wdCkNCj4gPiA+ICB7DQo+ID4gPiAgfQ0KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvTWFrZWZpbGUNCj4g
PiA+IGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9NYWtlZmlsZQ0KPiA+ID4gaW5kZXgg
ZjE0Yjc2MzYzMjNhLi40ZWZkYmQ3MTFlOGUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2Zp
cm13YXJlL2VmaS9saWJzdHViL01ha2VmaWxlDQo+ID4gPiArKysgYi9kcml2ZXJzL2Zpcm13YXJl
L2VmaS9saWJzdHViL01ha2VmaWxlDQo+ID4gPiBAQCAtMjUsNyArMjUsNyBAQCBjZmxhZ3MtJChD
T05GSUdfQVJNKSAgICAgICAgICAgICAgICA6PSAkKHN1YnN0DQo+ID4gPiAkKENDX0ZMQUdTX0ZU
UkFDRSksLCQoS0JVSUxEX0NGTEFHUykpIFwNCj4gPiA+ICBjZmxhZ3MtJChDT05GSUdfRUZJX0FS
TVNUVUIpICs9IC1JJChzcmN0cmVlKS9zY3JpcHRzL2R0Yy9saWJmZHQNCj4gPiA+IA0KPiA+ID4g
IEtCVUlMRF9DRkxBR1MgICAgICAgICAgICAgICAgICAgICAgICA6PSAkKGNmbGFncy15KQ0KPiA+
ID4gLURESVNBQkxFX0JSQU5DSF9QUk9GSUxJTkcgXA0KPiA+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLURfX05PX0ZPUlRJRlkgXA0KPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLWluY2x1ZGUgaGlkZGVuLmggLURfX05PX0ZPUlRJRlkNCj4gPiA+IFwN
Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICQoY2FsbCBjYy1vcHRpb24s
LWZmcmVlc3RhbmRpbmcpIA0KPiA+ID4gXA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJChjYWxsIGNjLW9wdGlvbiwtZm5vLXN0YWNrLQ0KPiA+ID4gcHJvdGVjdG9yKSBc
DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtRF9fRElTQUJMRV9FWFBP
UlRTDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9hcm02
NC1zdHViLmMNCj4gPiA+IGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9hcm02NC1zdHVi
LmMNCj4gPiA+IGluZGV4IDI5MTViNDQxMzJlNi4uNzE5ZDAzYTY0MzI5IDEwMDY0NA0KPiA+ID4g
LS0tIGEvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9hcm02NC1zdHViLmMNCj4gPiA+ICsr
KyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvYXJtNjQtc3R1Yi5jDQo+ID4gPiBAQCAt
NiwxNyArNiwxMSBAQA0KPiA+ID4gICAqIEFkYXB0ZWQgZnJvbSBBUk0gdmVyc2lvbiBieSBNYXJr
IFNhbHRlciA8bXNhbHRlckByZWRoYXQuY29tPg0KPiA+ID4gICAqLw0KPiA+ID4gDQo+ID4gPiAt
LyoNCj4gPiA+IC0gKiBUbyBwcmV2ZW50IHRoZSBjb21waWxlciBmcm9tIGVtaXR0aW5nIEdPVC1p
bmRpcmVjdGVkIChhbmQNCj4gPiA+IHRodXMNCj4gPiA+IGFic29sdXRlKQ0KPiA+ID4gLSAqIHJl
ZmVyZW5jZXMgdG8gdGhlIHNlY3Rpb24gbWFya2Vycywgb3ZlcnJpZGUgdGhlaXIgdmlzaWJpbGl0
eQ0KPiA+ID4gYXMNCj4gPiA+ICdoaWRkZW4nDQo+ID4gPiAtICovDQo+ID4gPiAtI3ByYWdtYSBH
Q0MgdmlzaWJpbGl0eSBwdXNoKGhpZGRlbikNCj4gPiA+IC0jaW5jbHVkZSA8YXNtL3NlY3Rpb25z
Lmg+DQo+ID4gPiAtI3ByYWdtYSBHQ0MgdmlzaWJpbGl0eSBwb3ANCj4gPiA+IA0KPiA+ID4gICNp
bmNsdWRlIDxsaW51eC9lZmkuaD4NCj4gPiA+ICAjaW5jbHVkZSA8YXNtL2VmaS5oPg0KPiA+ID4g
ICNpbmNsdWRlIDxhc20vbWVtb3J5Lmg+DQo+ID4gPiArI2luY2x1ZGUgPGFzbS9zZWN0aW9ucy5o
Pg0KPiA+ID4gICNpbmNsdWRlIDxhc20vc3lzcmVnLmg+DQo+ID4gPiANCj4gPiA+ICAjaW5jbHVk
ZSAiZWZpc3R1Yi5oIg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xp
YnN0dWIvaGlkZGVuLmgNCj4gPiA+IGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9oaWRk
ZW4uaA0KPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+IGluZGV4IDAwMDAwMDAwMDAw
MC4uMzQ5M2IwNDFmNDE5DQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiArKysgYi9kcml2ZXJz
L2Zpcm13YXJlL2VmaS9saWJzdHViL2hpZGRlbi5oDQo+ID4gPiBAQCAtMCwwICsxLDYgQEANCj4g
PiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiA+ID4gKy8qDQo+
ID4gPiArICogVG8gcHJldmVudCB0aGUgY29tcGlsZXIgZnJvbSBlbWl0dGluZyBHT1QtaW5kaXJl
Y3RlZCAoYW5kDQo+ID4gPiB0aHVzDQo+ID4gPiBhYnNvbHV0ZSkNCj4gPiA+ICsgKiByZWZlcmVu
Y2VzIHRvIGFueSBnbG9iYWwgc3ltYm9scywgb3ZlcnJpZGUgdGhlaXIgdmlzaWJpbGl0eQ0KPiA+
ID4gYXMNCj4gPiA+ICdoaWRkZW4nDQo+ID4gPiArICovDQo+ID4gPiArI3ByYWdtYSBHQ0Mgdmlz
aWJpbGl0eSBwdXNoKGhpZGRlbikNCj4gPiANCj4gPiBJIGFtIGdldHRpbmcgZm9sbG93aW5nIGNv
bXBpbGVyIGVycm9ycyBiZWNhdXNlIG9mIHRoaXMgcGF0Y2ggd2hpbGUNCj4gPiBjcm9zcyBjb21w
aWxpbmcgZm9yIEFSTSwgQVJNNjQgYW5kIFJJU0MtVi4NCj4gPiANCj4gPiBjYzE6IGZhdGFsIGVy
cm9yOiBoaWRkZW4uaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KPiA+IA0KPiA+IEFkZGlu
ZyB0aGUgZm9sbG93aW5nIGxpbmUgdG8gY2ZsYWdzIHNvbHZlcyB0aGUgaXNzdWUgd2hpY2gNCj4g
PiBpbmRpY2F0ZXMNCj4gPiB0aGF0IGdjYyBpcyBub3QgbG9va2luZyBhdCB0aGUgc291cmNlIGZp
bGUgZGlyZWN0b3J5IGZvciB0aGlzDQo+ID4gcGFydGljdWxhcmx5IGluY2x1ZGUgZmlsZS4NCj4g
PiANCj4gPiAtSSQoc3JjdHJlZSkvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yg0KPiA+IA0K
PiA+IEkgbWlnaHQgaGF2ZSBzb21lIHRyaWNrIGluIG15IGJ1aWxkIHNldHVwLiBKdXN0IHBvc3Rp
bmcgaGVyZSB0byBzZWUNCj4gPiBpZg0KPiA+IGFueWJvZHkgZWxzZSBhbHNvIHNlZWluZyB0aGUg
c2FtZSBwcm9ibGVtLg0KPiA+IA0KPiANCj4gVGhhbmtzIEF0aXNoLiBIZWlucmljaCByZXBvcnRl
ZCB0aGUgc2FtZSBpc3N1ZS4gSXQgZGlkbid0IGFmZmVjdCBtZQ0KPiBvcg0KPiBhbnkgb2YgdGhl
IGJvdHMgYmVjYXVzZSBpdCBvbmx5IGhpdHMgaWYgeW91IGJ1aWxkIGluLXRyZWUgKGkuZS4sDQo+
ICRzcmN0cmVlID09ICRvYmp0cmVlKQ0KPiANCj4gTXkgbGF0ZXN0IGVmaS9uZXh0IGJyYW5jaCBj
YXJyaWVzIGEgZml4IGZvciB0aGlzIChzaW1pbGFyIHRvIHlvdXINCj4gc3VnZ2VzdGlvbiwgYnV0
IHVzaW5nIC1pbmNsdWRlKQ0KDQpUaGFua3MuIFRoYXQgc29sdmVzIHRoZSBwcm9ibGVtLiBJIHNo
b3VsZCBoYXZlIGxvb2tlZCBpbiB0aGUgZWZpLW5leHQNCmZpcnN0IDooLg0KDQotLSANClJlZ2Fy
ZHMsDQpBdGlzaA0K
