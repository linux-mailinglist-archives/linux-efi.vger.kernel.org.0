Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA0DF18C254
	for <lists+linux-efi@lfdr.de>; Thu, 19 Mar 2020 22:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgCSVbp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Mar 2020 17:31:45 -0400
Received: from mail-eopbgr690092.outbound.protection.outlook.com ([40.107.69.92]:42912
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbgCSVbo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 19 Mar 2020 17:31:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaxBJczhGmIfJ+JGKTwNJkJIzKuEYCCD/wdVmFbtlae8Za6tW4+GNMX2DfN6MYmnQKRi3VC3rKWSzZMyQeahiyxuOBemzrlmldfjnogSlQNIROLow8KskWyIeePCfNUwRL+0fQ7Nuh1Z9tEs8nBK0mG7o5lItZ1Pcdkxba0D4zQM8iYPS10Z4yvMnQc3WDHY6M4GcsVDjTbUmbnbZvqOPtHOaE+T5M42Y0IEzAuT/vmNJsBFoW4gwWoc7qrY5r0wnkx2Zaa6kZPjnKxAZ0CL0YET0fu5N1nRGqMgrF1CX6nmw//aPMDJPUHpPuKcYdinwWFt4HI0WDLc6mczQb8osg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HU+BBf7ND2gEiOjiKd4zNiG5FH0mQK6nJmzt/W7YcQ=;
 b=TzbEFH4NJMPmqxZ7wq2o1BsppdvFoy7WcAZxs/qOCcOBxU+fMR7UlMNBSHz7GLLhvPyXolAE4PN5jD6tdlQ/1oGtiSd2wBn5ZhK1ozfIO3no98PMGdhTpX4B6FIlZ4/d+rVe22U/Z1Pz6G3AoEI7o+jEmlc1tMfCW4hTCosw4+C+ROYDNiwiyGwv4Rc8SEz+8x8nd22iXZcu+BBYJ9KzCysyxS+zSJYU5JWHExzUoXi5c/yauUymhwyJYgCXnLaoAl+ze3J2P571apeEdoi6FxEblj5I8vCrU497wexSE4fix8xRV9DT9sK/inN6/bztyaQ8orRhjQLlonYB3Tw/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HU+BBf7ND2gEiOjiKd4zNiG5FH0mQK6nJmzt/W7YcQ=;
 b=UDEX1jlZNCAn+crOsW3FEKN02CKWJxvO65oKBQMDlv2H22S70ni5jiVPwFkQnIKKZIC2dHFoyd9rKgu5xKK8yC0Nrj6Lf9NAoCoLjt55veoy/rvNh1AMfjnME5JZMF0fI6881GalElTAoZiAwQoIBEaqReBZyg9LLR2qiPenHko=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1081.namprd21.prod.outlook.com (2603:10b6:302:a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.12; Thu, 19 Mar
 2020 21:31:39 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%10]) with mapi id 15.20.2856.003; Thu, 19 Mar 2020
 21:31:39 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        Andy Whitcroft <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH v6 01/10] arm64: hyperv: Add core Hyper-V include files
Thread-Topic: [PATCH v6 01/10] arm64: hyperv: Add core Hyper-V include files
Thread-Index: AQHV+hZFy2PYk3vLgUeMDTQcrJxEgqhK6wGAgAJAuNCAAPrlAIACSZwQ
Date:   Thu, 19 Mar 2020 21:31:39 +0000
Message-ID: <MW2PR2101MB1052686237C57955148F173ED7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-2-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1GFDUY4mXzst4Ds+S-4SGXso6-jfpsYyy-eHyceAC1Zg@mail.gmail.com>
 <MW2PR2101MB10524879CD685710A51AB740D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a02EULGxyuKFq8YnbG8BQ_m-RKciaNEc9ZbdP2yz9dt+Q@mail.gmail.com>
In-Reply-To: <CAK8P3a02EULGxyuKFq8YnbG8BQ_m-RKciaNEc9ZbdP2yz9dt+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-19T21:31:36.1962221Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8be96c31-fc6d-4391-bd38-7597b1f41217;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2427187d-fc4a-41a5-daf7-08d7cc4ce90c
x-ms-traffictypediagnostic: MW2PR2101MB1081:|MW2PR2101MB1081:|MW2PR2101MB1081:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB108187AC99FA65C063D6D85AD7F40@MW2PR2101MB1081.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(199004)(2906002)(8676002)(81166006)(186003)(8936002)(76116006)(86362001)(66946007)(966005)(8990500004)(66556008)(66446008)(64756008)(66476007)(7696005)(71200400001)(6506007)(5660300002)(54906003)(7416002)(498600001)(53546011)(52536014)(26005)(10290500003)(6916009)(9686003)(55016002)(81156014)(33656002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1081;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o2E7VGo1bePfUcBs6evlFv9BTXKv4w+LxGeWU0Qbeq7EUdvVdMMaBtGBlw/ciunVoZ1dot5gwS5CWeAu+evM2nUAU0bexRM9KcwVWAGAWi1GbjqT5W9T9lZjRGwXRqnzqcyPXxrdreJ68v0nM8pm8NaSF7q7SW5+Ce8skLHS4x37dVZ2rD8L9ufsHbsL9Or5Qi8w/sKByTdaKdcF1gzqoqgEk+Pd+Zwz3wI9PHj1wC6g1eAdYn3FpjYqGVgOI1dTRhiYgdyFBHN9d0FJdSWz9roDqCCv5hf9AtjXWjGIsBHGzt8rK0kzjdqunblRxTheVO7sOT/VE9t2J12bNyJv5v1fC+CyU+z9AgGmjcy0erSc9btj0F7I9YdpCJ6cY1dxCfsXGIAZm9EtGAddkOOKlDbBvh4991kcrZsm7P8By6E2WDpC6g0sXOoGv7UeDrjXxHrtJrbqFdFANMuKF0JbMG1mxqg7gCOEmCP51f8Kd1fND9qsSTdzAcZua0mYAlfDXk/u+HjbNwtE2eh5e4oYIA==
x-ms-exchange-antispam-messagedata: XfOlnvaafEGDXHzIDwPgfdsivvwOzBzULVRPQ4Pnza4dtxVyyida1/7yj8QQxrVdK4w/Z3hUIWsOh/Zma3Tnvai/d3LD3Z60L365/TGnAQ9uk/hZwJ1ZZM558oKf1UJXiHNWoib45getludwCh8ezA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2427187d-fc4a-41a5-daf7-08d7cc4ce90c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 21:31:39.4309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2dMQu5fJ6e96Tgx1VNOT5fWBQx0I9mUi02jnHcqnJ9oqvJzuOmcpqFgrlBC/lybAIK3o5Emai03fWd/aopSJcJqujoVZsthHGgZXbEayp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1081
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogV2VkbmVzZGF5LCBNYXJj
aCAxOCwgMjAyMCAzOjEwIEFNDQo+IA0KPiBPbiBXZWQsIE1hciAxOCwgMjAyMCBhdCAxOjEyIEFN
IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPiBGcm9t
OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPiBTZW50OiBNb25kYXksIE1hcmNoIDE2LCAy
MDIwIDE6NDggQU0NCj4gPiA+IE9uIFNhdCwgTWFyIDE0LCAyMDIwIGF0IDQ6MzYgUE0gTWljaGFl
bCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4g
Kw0KPiA+ID4gPiArLyogRGVmaW5lIGlucHV0IGFuZCBvdXRwdXQgbGF5b3V0IGZvciBHZXQgVlAg
UmVnaXN0ZXIgaHlwZXJjYWxsICovDQo+ID4gPiA+ICtzdHJ1Y3QgaHZfZ2V0X3ZwX3JlZ2lzdGVy
X2lucHV0IHsNCj4gPiA+ID4gKyAgICAgICB1NjQgcGFydGl0aW9uaWQ7DQo+ID4gPiA+ICsgICAg
ICAgdTMyIHZwaW5kZXg7DQo+ID4gPiA+ICsgICAgICAgdTggIGlucHV0dnRsOw0KPiA+ID4gPiAr
ICAgICAgIHU4ICBwYWRkaW5nWzNdOw0KPiA+ID4gPiArICAgICAgIHUzMiBuYW1lMDsNCj4gPiA+
ID4gKyAgICAgICB1MzIgbmFtZTE7DQo+ID4gPiA+ICt9IF9fcGFja2VkOw0KPiA+ID4NCj4gPiA+
IEFyZSB5b3Ugc3VyZSB0aGVzZSBuZWVkIHRvIGJlIG1hZGUgYnl0ZS1hbGlnbmVkIGFjY29yZGlu
ZyB0byB0aGUNCj4gPiA+IHNwZWNpZmljYXRpb24/IElmIHRoZSBzdHJ1Y3R1cmUgaXRzZWxmIGlz
IGFsaWduZWQgdG8gNjQgYml0LCBiZXR0ZXIgbWFyayBvbmx5DQo+ID4gPiB0aGUgaW5kaXZpZHVh
bCBmaWVsZHMgdGhhdCBhcmUgbWlzYWxpZ25lZCBhcyBfX3BhY2tlZC4NCj4gPiA+DQo+ID4gPiBJ
ZiB0aGUgc3RydWN0dXJlIGlzIGFsaWduZWQgdG8gb25seSAzMi1iaXQgYWRkcmVzc2VzIGluc3Rl
YWQgb2YNCj4gPiA+IDY0LWJpdCwgbWFyayBpdCBhcyAiX19wYWNrZWQgX19hbGlnbmVkKDQpIiB0
byBsZXQgdGhlIGNvbXBpbGVyDQo+ID4gPiBnZW5lcmF0ZSBiZXR0ZXIgY29kZSBmb3IgYWNjZXNz
aW5nIGl0Lg0KPiA+DQo+ID4gTm9uZSBvZiB0aGUgZmllbGRzIGFyZSBtaXNhbGlnbmVkIGFuZCBp
dCB3aWxsIGFsd2F5cyBiZSBhbGlnbmVkIHRvIDY0LWJpdA0KPiA+IGFkZHJlc3Nlcywgc28gdGhl
cmUgc2hvdWxkIGJlIG5vIHBhZGRpbmcgbmVlZGVkIG9yIGFkZGVkLiAgVGhlcmUgd2FzDQo+ID4g
YSBkaXNjdXNzaW9uIG9mIF9fcGFja2VkIGFuZCB0aGUgSHlwZXItViBkYXRhIHN0cnVjdHVyZXMg
aW4gZ2VuZXJhbCBvbg0KPiA+IExLTUwgaGVyZTogIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4
LzExLzMwLzg0OCAgQWRkaW5nIF9fcGFja2VkIHdhcw0KPiA+IGRvbmUgYXMgYSBwcmV2ZW50YXRp
dmUgbWVhc3VyZSwgbm90IGJlY2F1c2UgYW55dGhpbmcgd2FzIGFjdHVhbGx5DQo+ID4gYnJva2Vu
LiAgTWFya2luZyBhcyBfX2FsaWduZWQoOCkgaGVyZSB3b3VsZCBpbmRpY2F0ZSB0aGUgY29ycmVj
dCBpbnRlbnQsDQo+ID4gdGhvdWdoIHRoZSB1c2Ugb2YgdGhlIHN0cnVjdHVyZSBhbHdheXMgZW5z
dXJlcyA2NC1iaXQgYWxpZ25tZW50Lg0KPiANCj4gSnVzdCBkcm9wIHRoZSBfX3BhY2tlZCBhbm5v
dGF0aW9ucyB0aGVuLCB0aGV5IGp1c3QgY29uZnVzZSB0aGUgY29tcGlsZXINCj4gaW4gdGhpcyBj
YXNlLiBJbiBwYXJ0aWN1bGFyLCB3aGVuIHRoZSBjb21waWxlciB0aGlua3MgdGhhdCBhIHN0cnVj
dHVyZSBpcw0KPiBtaXNhbGlnbmVkLCBpdCB0cmllcyB0byBhdm9pZCB1c2luZyBsb2FkL3N0b3Jl
IGluc3RydWN0aW9ucyBvbiBpdCB0aGF0IGFyZQ0KPiBpbmVmZmljaWVudCBvciB0cmFwIHdpdGgg
bWlzYWxpZ25lZCBjb2RlLCBzbyBoYXZpbmcgZGVmYXVsdCBhbGlnbm1lbnQNCj4gcHJvZHVjZXMg
YmV0dGVyIG9iamVjdCBjb2RlLg0KDQpTbyBJJ20gY29uZnVzZWQgYSBiaXQuICBXZXJlIHRoZSBv
cmlnaW5hbCBjb25jZXJucyBpbiB0aGUgYWJvdmUgTEtNTA0KZGlzY3Vzc2lvbiBib2d1cz8gIElz
IGl0IGxlZ2FsIGZvciB0aGUgY29tcGlsZXIgdG8gcmVvcmRlciBmaWVsZHMgb3IgYWRkDQpwYWRk
aW5nLCBldmVuIGlmIHRoZSBsYXlvdXQgb2YgZmllbGRzIGluIHRoZSBzdHJ1Y3R1cmUgZG9lc24n
dCByZXF1aXJlIGl0Pw0KSWYgdGhlIGNvbXBpbGVyICpjb3VsZCogZG8gc3VjaCwgdGhlbiBpdCBz
ZWVtcyBsaWtlIGtlZXBpbmcgdGhlIF9fcGFja2VkDQp3b3VsZCBiZSBhcHByb3ByaWF0ZSBwZXIg
dGhlIExLTUwgZGlzY3Vzc2lvbi4NCg0KPiANCj4gPiA+IEFsc28sIGluIG9yZGVyIHRvIHdyaXRl
IHBvcnRhYmxlIGNvZGUsIGl0IHdvdWxkIGJlIGhlbHBmdWwgdG8gbWFyaw0KPiA+ID4gYWxsIHRo
ZSBmaWVsZHMgYXMgZXhwbGljaXRseSBsaXR0bGUtZW5kaWFuLCBhbmQgdXNlIF9fbGUzMl90b19j
cHUoKQ0KPiA+ID4gZXRjIGZvciBhY2Nlc3NpbmcgdGhlbS4NCj4gPg0KPiA+IFRoZXJlJ3MgYW4g
b3BlbmluZyBjb21tZW50IGluIHRoaXMgZmlsZSBzdGF0aW5nIHRoYXQgYWxsIGRhdGENCj4gPiBz
dHJ1Y3R1cmVzIHNoYXJlZCBiZXR3ZWVuIEh5cGVyLVYgYW5kIGEgZ3Vlc3QgVk0gYXJlIGxpdHRs
ZQ0KPiA+IGVuZGlhbi4gIElzIHRoZXJlIHNvbWUgb3RoZXIgbWFya2luZyB0byBjb25zaWRlciB1
c2luZz8NCj4gDQo+IFllcywgZGV2aWNlIGRyaXZlcnMgc2hvdWxkIGdlbmVyYWxseSBkZWZpbmUg
ZGF0YSBzdHJ1Y3R1cmVzIHVzaW5nDQo+IHRoZSBfX2xlMzIsIF9fbGU2NCBldGMgdHlwZXMsIGFu
ZCB1c2UgdGhlIGNvbnZlcnNpb24gZnVuY3Rpb25zDQo+IHRvIGFjY2VzcyB0aGVtLiBCdWlsZGlu
ZyB3aXRoICdtYWtlIEM9MScgdXN1YWxseSB0ZWxscyB5b3Ugd2hlbg0KPiB5b3UgaGF2ZSBtaXNt
YXRjaGVkIGFubm90YXRpb25zLg0KPiANCj4gPiBXZSBoYXZlIGRlZmluaXRlbHkgbm90IGFsbG93
ZWQgZm9yIHRoZSBjYXNlIG9mIEh5cGVyLVYgcnVubmluZyBvbg0KPiA+IGEgYmlnIGVuZGlhbiBh
cmNoaXRlY3R1cmUuICBUaGVyZSBhcmUgYSAqbG90KiBvZiBtZXNzYWdlcyBhbmQgZGF0YQ0KPiA+
IHN0cnVjdHVyZXMgcGFzc2VkIGJldHdlZW4gdGhlIGd1ZXN0IGFuZCBIeXBlci1WLCBhbmQgY29k
aW5nDQo+ID4gdG8gaGFuZGxlIGVpdGhlciBlbmRpYW5uZXNzIGlzIGEgYmlnIHByb2plY3QuICBJ
J20gZG91YnRmdWwNCj4gPiBvZiB0aGUgdmFsdWUgdW50aWwgYW5kIHVubGVzcyB3ZSBhY3R1YWxs
eSBoYXZlIGEgbmVlZCBmb3IgaXQuDQo+IA0KPiBJbiBnZW5lcmFsLCB0aGUgdXNlIG9mIGJpZy1l
bmRpYW4gc29mdHdhcmUgb24gTGludXggaXMgZGVjbGluaW5nLCBob3dldmVyDQo+IA0KPiAtIGFy
bTY0IGFzIGFuIGFyY2hpdGVjdHVyZSBpcyBtZWFudCB0byBzdXBwb3J0IGJvdGggZW5kaWFuIHR5
cGVzLA0KPiAgIGFuZCB3ZSBzdGlsbCB0cnkgdG8gZW5zdXJlIGl0IHdvcmtzIGVpdGhlciB3YXkg
YXMgbG9uZyBhcyB0aGVyZSBhcmUNCj4gICB1c2VycyB0aGF0IGRlcGVuZCBvbiBpdC4NCj4gDQo+
IC0gVGhlIHJlbWFpbmluZyB1c2VycyBvZiBiaWctZW5kaWFuIHNvZnR3YXJlIGFyZSBwcm9iYWJs
eQ0KPiAgIG1vcmUgbGlrZWx5IHRvIHJ1biBvbiB2aXJ0dWFsIG1hY2hpbmVzIHRoYW4gb24gcmVh
bCBoYXJkd2FyZQ0KPiANCj4gLSBBbnkgZGV2aWNlIGRyaXZlciBzaG91bGQgZ2VuZXJhbGx5IGJl
IHdyaXR0ZW4gYWdhaW5zdCBwb3J0YWJsZQ0KPiAgIGludGVyZmFjZXMsIGV2ZW4gaWYgeW91IHRo
aW5rIHlvdSBrbm93IGhvdyBpdCB3aWxsIGJlIHVzZWQuIEFzDQo+ICAgZHJpdmVyIHdyaXRlcnMg
dGVuZCB0byBsb29rIGF0IGV4aXN0aW5nIGNvZGUgZm9yIG5ldyBkcml2ZXJzLCBpdCdzDQo+ICAg
YmV0dGVyIHRvIGhhdmUgdGhlbSBhbGwgYmUgcG9ydGFibGUuIChUaGlzIGlzIGEgc2ltaWxhciBh
cmd1bWVudA0KPiAgIHRvIHRoZSBpcnFjaGlwIGludGVyZmFjZSkuDQo+IA0KPiBFdmVuIGlmIHlv
dSBkb24ndCBjb252ZXJ0IGFueSBvZiB0aGUgZXhpc3RpbmcgYXJjaGl0ZWN0dXJlIGluZGVwZW5k
ZW50DQo+IGNvZGUgdG8gcnVuIGJvdGggd2F5cywgSSBzZWUgbm8gcmVhc29uIHRvIG5vdCBkbyBp
dCBmb3IgbmV3IGRyaXZlcnMuDQoNCk9LLCBsZXQgbWUgbG9vayBpbnRvIHRoaXMuICBHaXZlbiBo
b3cgdGhlIG1ham9yIExpbnV4IGRpc3Ryb3Mgb24NCkFSTTY0IGhhdmUgYWxsIGdvbmUgbGl0dGxl
LWVuZGlhbiwgSSdtIGEgYml0IHNrZXB0aWNhbCBvZiB0aGUgdmFsdWUNCmZvciB0aGUgYmlnIHNl
cnZlciBlbnZpcm9ubWVudHMgaW4gd2hpY2ggSHlwZXItViB3b3VsZCBiZSB1c2VkLg0KDQo+IA0K
PiA+ID4gPiArLyogRGVmaW5lIHN5bnRoZXRpYyBpbnRlcnJ1cHQgY29udHJvbGxlciBtZXNzYWdl
IGZsYWdzLiAqLw0KPiA+ID4gPiArdW5pb24gaHZfbWVzc2FnZV9mbGFncyB7DQo+ID4gPiA+ICsg
ICAgICAgX191OCBhc3U4Ow0KPiA+ID4gPiArICAgICAgIHN0cnVjdCB7DQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICBfX3U4IG1zZ19wZW5kaW5nOjE7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBf
X3U4IHJlc2VydmVkOjc7DQo+ID4gPiA+ICsgICAgICAgfSBfX3BhY2tlZDsNCj4gPiA+ID4gK307
DQo+ID4gPg0KPiA+ID4gRm9yIHNpbWlsYXIgcmVhc29ucywgcGxlYXNlIGF2b2lkIGJpdCBmaWVs
ZHMgYW5kIGp1c3QgdXNlIGENCj4gPiA+IGJpdCBtYXNrIG9uIHRoZSBmaXJzdCBtZW1iZXIgb2Yg
dGhlIHVuaW9uLg0KPiA+DQo+ID4gVW5mb3J0dW5hdGVseSwgY2hhbmdpbmcgdG8gYSBiaXQgbWFz
ayByaXBwbGVzIGludG8NCj4gPiBhcmNoaXRlY3R1cmUgaW5kZXBlbmRlbnQgY29kZSBhbmQgaW50
byB0aGUgeDg2DQo+ID4gaW1wbGVtZW50YXRpb24uICBJJ2QgcHJlZmVyIG5vdCB0byBkcmFnIHRo
YXQgY29tcGxleGl0eQ0KPiA+IGludG8gdGhpcyBwYXRjaCBzZXQuDQo+IA0KPiBIb3cgc28/IElm
IHRoaXMgZmlsZSBpcyBhcm02NCBzcGVjaWZpYywgdGhlcmUgc2hvdWxkIGJlIG5vIG5lZWQgdG8g
bWFrZQ0KPiB4ODYgZG8gdGhlIHNhbWUgY2hhbmdlLg0KDQpUaGlzIGZpbGUsIGh5cGVydi10bGZz
LmgsIGlzIGR1cGxpY2F0aW5nIHNvbWUgZGVmaW5pdGlvbnMgb24gdGhlIHg4NiBhbmQNCkFSTTY0
IHNpZGVzIHRoYXQgYXJlIHVzZWQgYnkgYXJjaCBpbmRlcGVuZGVudCBjb2RlLCBhbmQgdGhpcyBp
cyBvbmUNCm9mIHRob3NlIGRlZmluaXRpb25zLiAgSSBoYWQgaGVsZCBvZmYgb24gYnJlYWtpbmcg
dGhlIGZpbGUgaW50byBhcmNoDQppbmRlcGVuZGVudCBhbmQgYXJjaCBzcGVjaWZpYyBwb3J0aW9u
cyBiZWNhdXNlIHRoZSBIeXBlci1WIHRlYW0gaGFzDQpsZWZ0IHNvbWUgZ3JheSBhcmVhcyBmb3Ig
ZnVuY3Rpb25hbGl0eSB0aGF0IGlzbid0IHlldCB1c2VkIG9uIHRoZSBBUk02NA0Kc2lkZS4gIFNv
IGluIHNvbWUgY2FzZXMsIGl0J3MgaGFyZCB0byBrbm93IHdoYXQgZnVuY3Rpb25hbGl0eSB0byBw
dXQNCmludG8gdGhlIGFyY2ggaW5kZXBlbmRlbnQgcG9ydGlvbi4NCg0KQnV0IEkgdGhpbmsgSSds
bCBnbyBhaGVhZCBhbmQgbWFrZSB0aGUgc2VwYXJhdGlvbiB3aXRoIHJlYXNvbmFibHkgZ29vZA0K
YWNjdXJhY3ksIGFuZCB1cGRhdGUgdGhlIHg4NiBzaWRlIGFjY29yZGluZ2x5LiAgVGhhdCB3aWxs
IHJlZHVjZSB0aGUgc2l6ZQ0Kb2YgdGhpcyBwYXRjaCBzZXQgdG8gY29udGFpbiBvbmx5IHRoZSB0
aGluZ3MgdGhhdCB3ZSBrbm93IGFyZSBBUk02NA0Kc3BlY2lmaWMgYW5kIHdoaWNoIGFyZSBhY3R1
YWxseSB1c2VkIGJ5IHRoZSBBUk02NCBjb2RlLiAgVGhpbmdzIGxpa2UgdGhlDQpodl9tZXNzYWdl
X2ZsYWdzIHdpbGwgZ28gaW50byB0aGUgYXJjaCBpbmRlcGVuZGVudCBwb3J0aW9uIHNvIHRoYXQN
CnRoZXkgY2FuIGJlIHVzZWQgYnkgdGhlIGFyY2ggaW5kZXBlbmRlbnQgY29kZSB3aXRob3V0IGNs
dXR0ZXJpbmcgdXANCnRoZSBhcmNoIHNwZWNpZmljIGNvZGUuICBNYWtpbmcgdGhlIGNoYW5nZSB3
aWxsIGhlbHAgcmVkdWNlIGFueQ0KY29uZnVzaW9uIGFib3V0IHdoYXQgaXMgQVJNNjQtc3BlY2lm
aWMuIFRoZSBvdGhlciBjb3JlICNpbmNsdWRlIGZpbGUsDQptc2h5cGVydi5oLCBoYXMgYWxyZWFk
eSBiZWVuIGRvbmUgdGhpcyB3YXkuDQoNCk1pY2hhZWwNCg0KPiANCj4gPiA+ID4gKyAqIFVzZSB0
aGUgSHlwZXItViBwcm92aWRlZCBzdGltZXIwIGFzIHRoZSB0aW1lciB0aGF0IGlzIG1hZGUNCj4g
PiA+ID4gKyAqIGF2YWlsYWJsZSB0byB0aGUgYXJjaGl0ZWN0dXJlIGluZGVwZW5kZW50IEh5cGVy
LVYgZHJpdmVycy4NCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiArI2RlZmluZSBodl9pbml0X3RpbWVy
KHRpbWVyLCB0aWNrKSBcDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBodl9zZXRfdnByZWcoSFZf
UkVHSVNURVJfU1RJTUVSMF9DT1VOVCArICgyKnRpbWVyKSwgdGljaykNCj4gPiA+ID4gKyNkZWZp
bmUgaHZfaW5pdF90aW1lcl9jb25maWcodGltZXIsIHZhbCkgXA0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgaHZfc2V0X3ZwcmVnKEhWX1JFR0lTVEVSX1NUSU1FUjBfQ09ORklHICsgKDIqdGltZXIp
LCB2YWwpDQo+ID4gPiA+ICsjZGVmaW5lIGh2X2dldF9jdXJyZW50X3RpY2sodGljaykgXA0KPiA+
ID4gPiArICAgICAgICAgICAgICAgKHRpY2sgPSBodl9nZXRfdnByZWcoSFZfUkVHSVNURVJfVElN
RV9SRUZDT1VOVCkpDQo+ID4gPg0KPiA+ID4gSW4gZ2VuZXJhbCwgd2UgcHJlZmVyIGlubGluZSBm
dW5jdGlvbnMgb3ZlciBtYWNyb3MgaW4gaGVhZGVyIGZpbGVzLg0KPiA+DQo+ID4gSSBjYW4gY2hh
bmdlIHRoZSAic2V0IiBjYWxscyB0byBpbmxpbmUgZnVuY3Rpb25zLiAgQXMgeW91IGNhbiBzZWUs
IHRoZSAiZ2V0Ig0KPiA+IGZ1bmN0aW9ucyBhcmUgY29kZWQgYW5kIHVzZWQgaW4gYXJjaGl0ZWN0
dXJlIGluZGVwZW5kZW50IGNvZGUgYW5kIG9uDQo+ID4gdGhlIHg4NiBzaWRlIGluIGEgd2F5IHRo
YXQgd29uJ3QgY29udmVydCB0byBpbmxpbmUgZnVuY3Rpb25zLg0KPiANCj4gT2suDQo+IA0KPiAg
ICAgICAgIEFybmQNCg==
