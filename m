Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7643C170CA0
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 00:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgBZXfM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 18:35:12 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50319 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgBZXfL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 18:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582760110; x=1614296110;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4ZLGQ2DdMUXICvvCxqEV0jH9EAQtWDlC7TUW5lUptLs=;
  b=rpLFcFxb0zpe1BGEtqQkWL5/Fm9JlRFTd9OHFLG8a3FbIe9279rAnpZ7
   1GO+Ix4zmqS84YPBt1O+5+r1Alxgk1qZXoTysDJ9fuRpIyuxcaizaN+MV
   pz6YALpDoOfjOFAVFlxXJ708WaFKzPhIpaYYx50upsSFkK+ydivI1vvzF
   DKz8nbJeqqE++cKVwwVMlX9dWMRBfLcZI4YsxOUJROvEY8y87VVNXuP40
   utWH9o0Pojpsv/TL+F34Wwlz2wPHMCuz0k+3RpXfe9r7B8yjlkvFnrxpX
   4YBD3orS9YXELz0ClsbdXdSCxtIn6p0ST9oMtLCWqfapBRSw46HXwwdTh
   g==;
IronPort-SDR: s4+FWbfu3/o8H5fY3Rz4s/Zfg/OqG/0OfbfjCHh8/AMi8ELoiBUf0V9g1hStqKdr7KXqjuBJes
 l9VMyyJtz2Alg6yELbaKmmXNjfEaFz4ygJg5sLWKLvyKbTcXXvgh2ixj5pJJFCOoM45bDnZVwA
 qGz2RZTjSSCPcsU8g1neRz831/uXSC6PY4jJsk5+tgZOJTMxNjS2d5Xhj5sIGG9oKWQRIoT+LX
 NQ1RWok2ZIqXFR36lH/Bb6YLH3YZ+msD9mBi//p7pxo4dn+p/OaPvExOGpuQvOokT2H9U7wjmE
 JTs=
X-IronPort-AV: E=Sophos;i="5.70,489,1574092800"; 
   d="scan'208";a="130842626"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2020 07:34:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzm2BxO45VPrZyrgf5fZWQ1rNaUQjrIyUxwTrN07ddCWkfveOa3dCPtOsIOeQd5r6R6o6xjRn7nAwTEAthPxw43sf7IH5mpaVK1cpUWVw+A6B7vSda3Y6ilVWJnCfqWNDrJhPTIhpu2rQYH7ILFKSc0RMVAKwfq8tjgD3PaOZTc5mziQ8QvucQXnmQZJpeUtahwMJK2yXWqpKwYNKGsKiT2r/JzvIVznRnWDljgLS591a5HsYvUhdbnl7OjaLDe/+WsyuuIne3v8A0Bgpa6iScLDKxlyevp6U70JncybjRoZGBv/t/ndbWVQRROB6zbn7sIRMq6R8rjt8YdEttSEFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZLGQ2DdMUXICvvCxqEV0jH9EAQtWDlC7TUW5lUptLs=;
 b=YXxqtAJH5fxcyYR8hqfR5cWf+iWEPFbrnimkOQeX9qSMy9gUjStpmlfzNJYTg8B9fe1mRfaT3iq1SYC2qW4R/nE/2PJVNLrW8OrZm7+MS8AVLz5yvlUiM+UPzlyiNx9zfB061cbg9egtesp50etmi3LxgI+mMrzR9F6X9UWgDmH4M88loZgcBOZ1HysDPVwvieTtGGLAbUuBn2SM69jSngE3VtqyXCudAag64A5Q1hvcjdgKR4rdlF4GE/1hFxqOjV1BaP9cEjdOwp3Qv8bUuBK3ORLU+BOq4GcfuuVe5CifSiZm1Y1o8Ta4FnsOkszDjNIGhWKrMdNo5Iauotvv6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZLGQ2DdMUXICvvCxqEV0jH9EAQtWDlC7TUW5lUptLs=;
 b=WtqKEQ2Rzlzy39mmXKpSIPn4lkCHBr7775NWIGA1uHqMyhPtQCGlcDyP1UGeEMPkPs3n+OoOaM1Tz1fPkbTGnmr9LIn9NbXP/Y7gPHIFjbdGn5//KdKUkzEHr2/k8/B62js4E3ko4jqkGU9Vln/rGckPj/jG80oKoG270xRQfxY=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (2603:10b6:a02:ae::29)
 by BYAPR04MB5525.namprd04.prod.outlook.com (2603:10b6:a03:f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 23:34:54 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::ecfa:6b6b:1612:c46e%6]) with mapi id 15.20.2772.012; Wed, 26 Feb 2020
 23:34:54 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "ardb@kernel.org" <ardb@kernel.org>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "nivedita@alum.mit.edu" <nivedita@alum.mit.edu>,
        "lukas@wunner.de" <lukas@wunner.de>
Subject: Re: [PATCH 13/19] efi/libstub: Move get_dram_base() into arm-stub.c
Thread-Topic: [PATCH 13/19] efi/libstub: Move get_dram_base() into arm-stub.c
Thread-Index: AQHV4CugasGk9YRM9UekC9cWCfOkeKgen7IAgAB66gCADx+9gA==
Date:   Wed, 26 Feb 2020 23:34:54 +0000
Message-ID: <00a157796e420dbc8dee08ae2592daecde8bb07b.camel@wdc.com>
References: <20200210160248.4889-1-ardb@kernel.org>
         <20200210160248.4889-14-ardb@kernel.org>
         <952796db5423caf21c411c6f5629f32882f55b29.camel@wdc.com>
         <CAKv+Gu_eJvZn8a45t5Hr23+QQySJOBaBwSsxW7dkYCoVPO4RPw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_eJvZn8a45t5Hr23+QQySJOBaBwSsxW7dkYCoVPO4RPw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9707c7ec-188d-4b70-024d-08d7bb147ba4
x-ms-traffictypediagnostic: BYAPR04MB5525:
x-microsoft-antispam-prvs: <BYAPR04MB55258A72EE8FA88381586C70FAEA0@BYAPR04MB5525.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(199004)(189003)(81166006)(8936002)(6486002)(5660300002)(186003)(26005)(8676002)(36756003)(966005)(71200400001)(316002)(81156014)(54906003)(86362001)(66446008)(2906002)(6506007)(4326008)(6512007)(478600001)(66476007)(66946007)(64756008)(66556008)(6916009)(2616005)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5525;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ikXWl/Xok89wLQQSCjkchmofVyDxZkWivSE4Tjb9k5TL4piCzGu5wZ+0VO4o/AAHeG47hjmxpXagvpqJa4PQfXNtgLEqrcQeCoILW9miJX6l7MzxVFrDh9j/cxJUg/FU+kranF2yH8FkUf+GdR6UN7jC+ySf3Xi9B5S2P+sBpPNjUi0ACw4rRECjs/RGzfEfYTnn0aSfEIyErcy19vZnJNZ/P2XnXnSbOs8XbdSulesQ58kefdpt2dnrwYvZxGUzHPt8Gy9A7nAfeJO34dIjyudpnGeNOSt+F28htZmKUXR2XQPNfPVa1cOO+Irlqh/PK5OZntHYKRTZyOda0tPj8IHl+XmJvJ0f4LNOHITL3gXzjX/vrLhEkkV7aac+ZclUhnNB9rUnz6ffMzhoNqIw83/hUTmQOcHNCmSSKXNKxxkoAQluOdv9t4dDC5lemI+Wv4SzLC/k6jAacteCF+HZY2lwZGS2wg1ZTOD3byEW15SXRHrbmidjyjEnxOvSKa9OrF8K82w4LxkuF9pWGUjAaw==
x-ms-exchange-antispam-messagedata: Rw8NGteB69nwh0Do2zp6FHm+mCl3cbrmltMyRiOPooN4lxWzjbOHbf+1XWkAHIJGPUk60Efa6WfXIfPdXDooQHV5RZ8EYfDi5BuyoK0BYosagisnUp9Dg0nXKOVUkHisWDCQGUlYil7+LihnDhi08w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B6337F2F274D44FA34430020854EE00@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9707c7ec-188d-4b70-024d-08d7bb147ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 23:34:54.2611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTmNv0z772CCIdyBA878a8okkrL9QjoN7hyrjo/5k3K8d6Kiy6v3+JBSECY1boulCjE10EHrVKHM5vEtP7ZYaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5525
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTE3IGF0IDA5OjM3ICswMTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gT24gTW9uLCAxNyBGZWIgMjAyMCBhdCAwMjoxNywgQXRpc2ggUGF0cmEgPEF0aXNoLlBhdHJh
QHdkYy5jb20+DQo+IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMC0wMi0xMCBhdCAxNzowMiArMDEw
MCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6DQo+ID4gPiBnZXRfZHJhbV9iYXNlKCkgaXMgb25seSBj
YWxsZWQgZnJvbSBhcm0tc3R1Yi5jIHNvIG1vdmUgaXQgaW50bw0KPiA+ID4gdGhlIHNhbWUgc291
cmNlIGZpbGUgYXMgaXRzIGNhbGxlci4NCj4gPiA+IA0KPiA+IA0KPiA+IEp1c3QgRllJOiByaXNj
diBlZmkgc3R1YiBwb3J0IGlzIGFsc28gZ29pbmcgdG8gdXNlIGdldF9kcmFtX2Jhc2UoKS4NCj4g
PiBIb3dldmVyLCBJIGhhdmUgcmVuYW1lZCBhcm0tc3R1Yi5jIHRvIGdlbmVyaWMgZWZpLXN0dWIu
YyBzbyB0aGF0DQo+ID4gYXJtLA0KPiA+IGFybTY0IGFuZCByaXNjdiBjYW4gcmV1c2UgaXQuIFRo
dXMsIE1vdmluZyBnZXRfZHJhbV9iYXNlKCkgaW50bw0KPiA+IGFybS0NCj4gPiBzdHViLmMgd29y
a3MgZm9yIHJpc2N2IGFzIHdlbGwuIEkgd2lsbCByZWJhc2UgbXkgcGF0Y2hlcyBvbiB0b3Agb2YN
Cj4gPiB0aGlzDQo+ID4gc2VyaWVzLg0KPiA+IA0KPiANCj4gVGhhbmtzIEF0aXNoLiBJIHdhcyBo
b3BpbmcgaXQgd291bGQgdHVybiBvdXQgbGlrZSB0aGlzLCB3aGljaCBpcyB3aHkNCj4gSQ0KPiBh
bSBwdXNoaW5nIHRoaXMgc2VyaWVzIG5vdy4NCj4gDQo+IEkgaGF2ZW4ndCBsb29rZWQgYXQgeW91
ciBjb2RlIHlldCwgYnV0IHBsZWFzZSBhdm9pZCB1c2luZyB0aGUgY29tbWFuZA0KPiBsaW5lIGJh
c2VkIGluaXRyZC9kdGIgbG9hZGluZyByb3V0aW5lcy4gSSBhbSBwcm9wb3NpbmcgYSBjbGVhbmVy
IHdheQ0KPiB0byBwcm92aWRlIHRoZSBpbml0cmQgZnJvbSBmaXJtd2FyZSBbMF0sIGFuZCBkdGIg
bG9hZGluZyBieSB0aGUgc3R1Yg0KPiBzaG91bGQgbm90IGJlIGRvbmUgaW4gdGhlIGZpcnN0IHBs
YWNlLg0KPiANCj4gWzBdIA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1lZmkvMjAy
MDAyMTYxNDExMDQuMjE0NzctMS1hcmRiQGtlcm5lbC5vcmcvDQoNClNvcnJ5IEkgbWlzc2VkIHRo
aXMgZW1haWwgZWFybGllci4gWWVzIEkgYW0gbm90IHVzaW5nIGluaXRyZCBvciBkdGINCmxvYWRp
bmcgZnJvbSBVLUJvb3QgY29tbWFuZCBsaW5lLg0KDQotLSANClJlZ2FyZHMsDQpBdGlzaA0K
