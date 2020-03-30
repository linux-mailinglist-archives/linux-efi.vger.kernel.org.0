Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0426E19831A
	for <lists+linux-efi@lfdr.de>; Mon, 30 Mar 2020 20:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgC3SMw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Mar 2020 14:12:52 -0400
Received: from mail-bn8nam12on2092.outbound.protection.outlook.com ([40.107.237.92]:16929
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbgC3SMw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Mar 2020 14:12:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWdcYnqdG11T14UW1Bgwx/rFNMAzMc5D7172dXtPqCWBRKENpJvr7EqmK0FrWRdMX8ynRmbjlyFo4bPF+wMgE9nBxoewmLyJabVoOB9Zq7ucgY193GSZ1fejDM4fWxwOthqRzyHY56EdTM+gE8zm8Zp4Sr9eNwhxXfomZqRHm/IRZlouTqYggc+Ks9T/Em6D2U//RLmzzDf5Z13RQTtouIjaSx7ojV7qCsg+36frVO7637ztBqJgn2RxSJbW2TcJiq0bHai5vXjMB162M1JEFGrCvZa0AQP4PWqL/zBTLaQORhDUZqh2bBTCmZL2TehDFIelhkZlpl24Utq712Yi+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy250IrG9u6aOLw+oIxJlCv3mA0PZRenUZSN0Qr0S6c=;
 b=VYiOwS0CSGGOA914X4wdB0hIXpg1HWIO/MToRQheVVkCsQej1Mu4PfePZFMKOO6NoZalbx11k0PWD7vDDk/GCFMPv68FBXl9btuTHC008JSaAQ+RrAIHNSH+zosVAsAECeP36vhIRf0Jo5ZsV7jX+1MUmEnbB8iMnpHkqkOf2YZcDMm8VoPj1lP7I4AsgYjrx/OmFWIo/xznu/N935W0+xQQecE+wKQJKxRBaDJpB8ME2Yr9aLvKdnnFcJ9O+6J8NmJYA4XefnMmK9ZhNLkrz0ptlzr0LffiBVNSwy3KMSS0Gx81z5hMgLsuS/L9rQqggLkaDe5Ppd7zQAEiXOoR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy250IrG9u6aOLw+oIxJlCv3mA0PZRenUZSN0Qr0S6c=;
 b=Epny1QZ9y08rME9deT2g5oBHQz1zQyzVQyFTRem9RGF8OektG43VYR0YoDvzcjgxwJZ3lvuvh8Yn9fG4UU+2rwvbfCmTmTHvNYRFLcHK3wv4w417zPhoxAwtN45otwZ/p1M0z+2memLfXjAsE8PLiBRIBsJxr1uDHmqByRpPoxI=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR2101MB0935.namprd21.prod.outlook.com (2603:10b6:4:a5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.3; Mon, 30 Mar
 2020 18:12:37 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::1cf9:aae4:18cc:8b3d]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::1cf9:aae4:18cc:8b3d%7]) with mapi id 15.20.2900.002; Mon, 30 Mar 2020
 18:12:37 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Leif Lindholm <leif@nuviainc.com>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Subject: RE: [PATCH] efi/libstub/arm64: avoid image_base value from
 efi_loaded_image
Thread-Topic: [PATCH] efi/libstub/arm64: avoid image_base value from
 efi_loaded_image
Thread-Index: AQHWBUObXv2MTW3u/Ue45F8yahNJA6hgxFuAgAAA5gCAAAAuAIAAqMgQ
Date:   Mon, 30 Mar 2020 18:12:37 +0000
Message-ID: <DM5PR2101MB104760D03E632DD4DBE99AE1D7CB0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200328205809.23825-1-ardb@kernel.org>
 <20200330074721.GV22097@bivouac.eciton.net>
 <CAMj1kXFPtY20afbAZgXT3As4TUuAqi3=pG8u19hjMjFxgN6HWA@mail.gmail.com>
 <CAMj1kXEf5rT1pmDNQoOd5Tx9xQ=fUMT0xo4JXZNfz=VDY9268Q@mail.gmail.com>
In-Reply-To: <CAMj1kXEf5rT1pmDNQoOd5Tx9xQ=fUMT0xo4JXZNfz=VDY9268Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-30T18:12:36.0834379Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=13c2cf8b-0026-4669-a1c7-30e995bf61a7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9184ec95-f24a-4ff1-ea4b-08d7d4d5edc8
x-ms-traffictypediagnostic: DM5PR2101MB0935:|DM5PR2101MB0935:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR2101MB0935626D7B887D0516D5682DD7CB0@DM5PR2101MB0935.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(6506007)(82950400001)(26005)(82960400001)(107886003)(316002)(52536014)(54906003)(4326008)(5660300002)(186003)(10290500003)(53546011)(8936002)(478600001)(8676002)(71200400001)(81166006)(110136005)(81156014)(2906002)(7696005)(66556008)(66476007)(66946007)(64756008)(66446008)(33656002)(86362001)(76116006)(55016002)(8990500004)(9686003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P7hbZJfn3+bQq25eFnU+EQOmvc26BRUwIsDA9eenczBkv63VTutpwx8V5+HTTzMg1GxSqHO9Rf4UU4i5LEtyVG+YAn5sHKqmamA+Etd/uJ5LvUTDVVeKAfbg0p4UUh1pu6t9PbpIKHxV2RRjjxSSdovjWKDCSGfWPDmbi2ntG40DsFGYoSwZfY6M+2JREIxrFGh0RDupxJDMsiMSes/WSYhXfU1Yqiw52qeBB0IO4CXm4MNq/wGN/RLJBP/nlngF4KTvWctylQ05jGWms6FjflHa985IyIJXGVI5wMWT3qKJ6pt2W7N0INOop+tF5NCv3OlzIIx6BRgz+1wuV6d9VXG0w1MuCyICJg6kqQAGOocCvlX2yFWJfOfoI1rCO+pXTY/AJdn5ioRfjniPY5AQCihjwB8508h/CUX1Uhbf7LVfPRVXIuRCug1Qeld60EYO
x-ms-exchange-antispam-messagedata: 3j+0I1uwZjlXCkfOLU3kOpw++9r5r0a36is5+OYJD1IOXMUONNdzpSxzUAZW7A2mc3hHOR2akuryZLMxa1kAALu6qU7C/KpvOoCmNOWAjWYsgD/UHR1ESwkfKy57rD1pVVflVWYx932SxWer8DHEWw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9184ec95-f24a-4ff1-ea4b-08d7d4d5edc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 18:12:37.7335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrvcEKcAli2oKOBU/z963JNkbl1P1AfpIN4e7gbIwiWYbmaxSKIeoRrbtdSJvIjTUwT0NETY4zHR8JHXbcVz5CbDLLo/Vd2hELxd+iOfXeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0935
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

RnJvbTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4gIFNlbnQ6IE1vbmRheSwgTWFy
Y2ggMzAsIDIwMjAgMTI6NTEgQU0NCj4gDQo+IE9uIE1vbiwgMzAgTWFyIDIwMjAgYXQgMDk6NTAs
IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9u
LCAzMCBNYXIgMjAyMCBhdCAwOTo0NywgTGVpZiBMaW5kaG9sbSA8bGVpZkBudXZpYWluYy5jb20+
IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIFNhdCwgTWFyIDI4LCAyMDIwIGF0IDIxOjU4OjA5ICsw
MTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToNCj4gPiA+ID4gQ29tbWl0IDlmOTIyMzc3OGVmMyAo
ImVmaS9saWJzdHViL2FybTogTWFrZSBlZmlfZW50cnkoKSBhbiBvcmRpbmFyeQ0KPiA+ID4gPiBQ
RS9DT0ZGIGVudHJ5cG9pbnQiKSBkaWQgc29tZSBjb2RlIHJlZmFjdG9yaW5nIHRvIGdldCByaWQg
b2YgdGhlDQo+ID4gPiA+IEVGSSBlbnRyeSBwb2ludCBhc3NlbWJsZXIgY29kZSwgYW5kIGluIHRo
ZSBwcm9jZXNzLCBpdCBnb3QgcmlkIG9mIHRoZQ0KPiA+ID4gPiBhc3NpZ25tZW50IG9mIGltYWdl
X2FkZHIgdG8gdGhlIHZhbHVlIG9mIF90ZXh0LiBJbnN0ZWFkLCBpdCBzd2l0Y2hlZA0KPiA+ID4g
PiB0byB1c2luZyB0aGUgaW1hZ2VfYmFzZSBmaWVsZCBvZiB0aGUgZWZpX2xvYWRlZF9pbWFnZSBz
dHJ1Y3QgcHJvdmlkZWQNCj4gPiA+ID4gYnkgVUVGSSwgd2hpY2ggc2hvdWxkIGNvbnRhaW4gdGhl
IHNhbWUgdmFsdWUuDQo+ID4gPiA+DQo+ID4gPiA+IEhvd2V2ZXIsIE1pY2hhZWwgcmVwb3J0cyB0
aGF0IHRoaXMgaXMgbm90IHRoZSBjYXNlOiBvbGRlciBHUlVCIGJ1aWxkcw0KPiA+ID4gPiBjb3Jy
dXB0IHRoaXMgdmFsdWUgaW4gc29tZSB3YXksIGFuZCBzaW5jZSB3ZSBjYW4gZWFzaWx5IHN3aXRj
aCBiYWNrIHRvDQo+ID4gPiA+IHJlZmVycmluZyB0byBfdGV4dCB0byBkaXNjb3ZlciB0aGlzIHZh
bHVlLCBsZXQncyBzaW1wbHkgZG8gdGhhdC4NCj4gPiA+DQo+ID4gPiBJdCBpcyBub3QgY2xlYXIg
dG8gbWUgaG93ICJvbGRlciBHUlVCIGJ1aWxkcyIgd291bGQgZGlmZmVyIGhlcmUuDQo+ID4gPiBJ
IHRoaW5rIG1vcmUgaW52ZXN0aWdhdGlvbiBpcyBuZWVkZWQgYmVmb3JlIG1ha2luZyB0aGF0IGNs
YWltLg0KPiA+ID4gTXkgc3VzcGljaW9uIGlzIHRoYXQgc29tZSAob2xkKSB2ZXJzaW9uIG9mIG5v
bi11cHN0cmVhbSwgc2hpbS1lbmFibGVkDQo+ID4gPiBkaXN0cm8tc3BlY2lmaWMgYnVpbGQgaXMg
cGxheWluZyBhIHBhcnQuDQo+ID4gPg0KPiA+ID4gU28sIGRvIHdlIGhhdmUgdGhlIG9wdGlvbiBm
b3IgbW9yZSBkZXRhaWxlZCBpbnZlc3RpZ2F0aW9ucywgb3IgY2FuIHdlDQo+ID4gPiB2YWd1ZSB0
aGUgY2xhaW0gdXAgdG8gc2F5ICJzb21lIEdSVUIgYnVpbGRzIHNlZW4gaW4gdGhlIHdpbGQsIGJh
c2VkDQo+ID4gPiBvbiBhbiB1cHN0cmVhbSAyLjAyIiBvciBzdWNobGlrZT8NCj4gPiA+DQo+ID4N
Cj4gPiBJJ3ZlIHF1ZXVlZCBhIGZpeCB0aGF0IHByaW50cyBhIG5hc3R5Z3JhbSBpZiB0aGUgdmFs
dWUgZGV2aWF0ZXMgZnJvbQ0KPiA+IHRoZSBleHBlY3RlZCBvbmUuIExldCdzIHNlZSBpZiB0aGlz
IHRyaWdnZXJzIGFueSByZXBvcnRzLg0KPiANCj4gKC9tZSBsb29rcyBhdCBjb250ZXh0KQ0KPiAN
Cj4gKlRoaXMqIGlzIHRoZSBmaXggdGhhdCBwcmludHMgYSBuYXN0eWdyYW0uDQoNCkZXSVcsIEkg
cHVsbGVkIHRoZSBCT09UQUE2NC5FRkkgYW5kIGdydWJhYTY0LmVmaSBmaWxlcyBmcm9tIENlbnRP
UyA3LjYNCmFuZCBDZW50T1MgOC4wIGJpbmFyeSBwYWNrYWdlcyBhbmQgdGVzdGVkIGJvdGggaW4g
bXkgSHlwZXItViBWTS4gDQpVc2luZyBzdHJpbmdzIHwgZ3JlcCAnMlwuJyB0byBnZXQgdmVyc2lv
biBpbmZvLCB0aGUgQ2VudE9TIDcuNiBncnViYWE2NC5lZmkNCnNob3dzOiANCg0KCVVzZXItQWdl
bnQ6IEdSVUIgMi4wMn5iZXRhMg0KDQpUaGUgQ2VudE9TIDguMCBncnViYWE2NC5lZmkgc2hvd3M6
DQoNCglVc2VyLUFnZW50OiBHUlVCIDIuMDMNCg0KQm90aCB2ZXJzaW9ucyBwcm9kdWNlIHRoZSBG
SVJNV0FSRSBCVUcgd2FybmluZyB3aGVuIHVzaW5nIEFyZCdzDQpsYXRlc3QgcGF0Y2guICBJJ2xs
IGFzc3VtZSB0aGUgZXF1aXZhbGVudCBSSEVMIHZlcnNpb25zIGFyZSB0aGUgc2FtZS4NClNvIHdl
J3ZlIGdvdCBvZmZpY2lhbCBkaXN0cm8gcmVsZWFzZXMgdGhhdCBzaG93IHRoZSBwcm9ibGVtLg0K
DQpBcyByZXBvcnRlZCBlYXJsaWVyLCB0aGUgQk9PVEFBNjQuRUZJIGFuZCBncnViYWE2NC5lZmkg
ZnJvbSBhDQpEZWJpYW4gcmVsZWFzZSAobm90IGV4YWN0bHkgc3VyZSB3aGljaCBvbmUpIGRvIG5v
dCBwcm9kdWNlIHRoZQ0KRklSTVdBUkUgQlVHIHdhcm5pbmcuICBUaGUgZ3J1YmFhNjQuZWZpIHJl
cG9ydHMgYXMgMi4wNC00Lg0KDQpNaWNoYWVsDQo=
