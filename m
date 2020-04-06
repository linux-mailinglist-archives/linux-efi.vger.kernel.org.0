Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 079D019FB21
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgDFRNH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 13:13:07 -0400
Received: from mail-eopbgr700109.outbound.protection.outlook.com ([40.107.70.109]:33153
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729832AbgDFRNH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 6 Apr 2020 13:13:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfDynuLfduOOUCdChqCr0r7ftJKtRvSdsMGQuLvrGBMtZ1uci+kuPADb72kRTMnBUWp1oeElFoogoARz8phjzcBZUkICVAIfni+mRDbStIz6LSwGIr1Gk7Vp8ZJz+vU14xfG0gRSTqky5vz6OIANOtZxVeZqmKNVI05jKMgQJN5NAWozDqIyAn/sXDSC78+Ku2h3H1LDmSLvLMka81yzAoDfEcWgoc6KFaIQAyNph+zLW71iXtWGYji6KLecvLNPY39ET+JHnqGjQ8xHZtEpnH7alPk7+46uMNaBD/o+G4+hTuiGvBKyu+Fy4myPr0dm/U1t9xz4RgUHQ1wwnUwQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM0GsUud3iCCSD9iWAv3J0OScKtoOfsxyWwYx1n+IDQ=;
 b=TFu+eMfRzofbjA8qz4xkj2Mbp2aUiyBG18eibUV2GGPxSMA9/AO6XpZjTvC09LQYdnsrXMyD1FpmBjFmSzrneGwVIGHAR/IN+xZBV61qMRs67kbiy+GxUbCy7W0qfsgn8bi70pdb7DwaMidIgcc1DAe9prPHBNqqf9aY8Dp2ueVkyT3vjLXdH0pdKMDN+ZdKpsd37fcV/wcbbv2RyHvgGdqpey8mjckjYdJ/PDwxcKblCiSxhelmwjTeyrbN1PplqpVu38jgKoqVsTFScZ8zyAMo6oa54U82NhoU2Yab+UIPaUmmG0X6PIxhp6Iypgms4SvS5U5KWo4VWVTBolNU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM0GsUud3iCCSD9iWAv3J0OScKtoOfsxyWwYx1n+IDQ=;
 b=fL5PLjuUX2egsls0WAXQit6rMHjXq9YUvNUUKsXhLO0/UvV18PsozcqcfiPonjRX7aguNtfeK1D9U/K1TYhI/5ETB5Cunjxt6grPEXexPJqNg06X4h5ctBe+MsoGi32sSkysHD/B5E3cPd32A7T4oRl1CB0ou4gNKJSUuZXLgTg=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0924.namprd21.prod.outlook.com (2603:10b6:302:10::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.6; Mon, 6 Apr
 2020 17:13:03 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.012; Mon, 6 Apr 2020
 17:13:02 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        "lersek@redhat.com" <lersek@redhat.com>
CC:     Leif Lindholm <leif@nuviainc.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Subject: RE: [PATCH] efi/libstub/arm64: avoid image_base value from
 efi_loaded_image
Thread-Topic: [PATCH] efi/libstub/arm64: avoid image_base value from
 efi_loaded_image
Thread-Index: AQHWBUObXv2MTW3u/Ue45F8yahNJA6hgxFuAgAAA5gCAAAAuAIAAqMgQgAAIF4CAAOLlAIAAXdmAgAmrCCA=
Date:   Mon, 6 Apr 2020 17:13:02 +0000
Message-ID: <MW2PR2101MB1052F06F444705247419B2B3D7C20@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200328205809.23825-1-ardb@kernel.org>
 <20200330074721.GV22097@bivouac.eciton.net>
 <CAMj1kXFPtY20afbAZgXT3As4TUuAqi3=pG8u19hjMjFxgN6HWA@mail.gmail.com>
 <CAMj1kXEf5rT1pmDNQoOd5Tx9xQ=fUMT0xo4JXZNfz=VDY9268Q@mail.gmail.com>
 <DM5PR2101MB104760D03E632DD4DBE99AE1D7CB0@DM5PR2101MB1047.namprd21.prod.outlook.com>
 <CAMj1kXF+2O5cDC9zuNp9Lx9Oe6WyxRghPqSi63CnF+KCcGUZyw@mail.gmail.com>
 <CAMj1kXFJB9ciJ41V2tpQNX_mN7S8BweV9_ME3sDxKjwnR2Jwbg@mail.gmail.com>
 <MW2PR2101MB10525381BAB07997EA5F6B7CD7C80@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB10525381BAB07997EA5F6B7CD7C80@MW2PR2101MB1052.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-31T13:37:44.3591636Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=deac7ec8-f648-47d1-8a97-4257f5f9d3ae;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:3:c94d:543c:127f:af4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f34682ab-c71a-425b-e3f4-08d7da4dc3d5
x-ms-traffictypediagnostic: MW2PR2101MB0924:|MW2PR2101MB0924:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0924028E738D2FC5344B1FE8D7C20@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(9686003)(8676002)(8936002)(4326008)(81156014)(81166006)(55016002)(316002)(54906003)(110136005)(53546011)(186003)(8990500004)(86362001)(5660300002)(71200400001)(107886003)(52536014)(33656002)(6506007)(10290500003)(66476007)(76116006)(66446008)(64756008)(66556008)(66946007)(2906002)(82960400001)(82950400001)(7696005)(478600001)(365024005);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EZdm4bZFcY1Eda1DLvdzqDxYxTn05kxe3/dMDiDPw2dpTjTjdaZ5wqKXwbD0rmUAa89S9FDJ3Iebf4i0R84iHVmNLWqfRQNU5N73nDSZNmMyhscV9PNCISc2VRSvP4Uh+QtGVCXi0N3xsj49HhiQsVVBoNuRixZsnnFoe7Sev0g2r6eU8uxngFVtFkPvKHs7h4FnRVYyugPRky+M+X5ngeOoOcM9eq21/5u7ZFqUxwdX19U+BUf57WaRqbXrbSfzrflEf1ia7HRImsd4a/2/RGIXgd0QXWrhAgi44vzCxEX5vEbshBUzwbIWIk9PlsqIzBcmexMgS+tY1oItrEAvFPH2cNa+59+j3bHw+rQqAlzWp+kYjN1rZ5Ksj85SWn0ln8x8kM8A8FV3lHtfpDrEoJMwu9H3WpWvQKTf06oDjro4PKTL/I73rifnSQ9YgyLhx42YMnwgvwvKUq2dtMfFTIEG72SPJNWi1zLlYmAw6oKx/UNGUr48lur8YjUmfE1w
x-ms-exchange-antispam-messagedata: Uxkp1N6J+0OhB98jydXfEkNUpKU+MbObzveXIUJ66jU3tM13bj39vhQG7CTfhTkGAQOmv9Y5QJbsMRbPxebiT4luS+kv3fxT3O5JNEc+lUh5n03jLG05dkofbu2PGeTJ1sc1vnRjdOtTWL3BlQc6VFUwlldX2Kan6s07/nJKGlMk74npyjMaP9RS2yocbvwP1afv4z2BNepIusciM7sQew==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34682ab-c71a-425b-e3f4-08d7da4dc3d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 17:13:02.7397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ap5//IT4IJL0j3gQC0/sxQQ91XuxJh8IJZsInDhqwti2D6YEW6qIm3L9TH9ormwi0XYQHhaimCIqzh/A7Z7hNI0euQriB++qOB4QNUOeIWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

RnJvbTogTWljaGFlbCBLZWxsZXkgIFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDMxLCAyMDIwIDY6Mzgg
QU0NCj4gDQo+IEZyb206IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+ICBTZW50OiBU
dWVzZGF5LCBNYXJjaCAzMSwgMjAyMCAxMjo1NiBBTQ0KPiA+DQo+ID4gT24gTW9uLCAzMCBNYXIg
MjAyMCBhdCAyMDoyNCwgQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4gd3JvdGU6DQo+
ID4gPg0KPiA+ID4gT24gTW9uLCAzMCBNYXIgMjAyMCBhdCAyMDoxMiwgTWljaGFlbCBLZWxsZXkg
PG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBGcm9tOiBB
cmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPiAgU2VudDogTW9uZGF5LCBNYXJjaCAzMCwg
MjAyMCAxMjo1MSBBTQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gTW9uLCAzMCBNYXIgMjAyMCBh
dCAwOTo1MCwgQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gT24gTW9uLCAzMCBNYXIgMjAyMCBhdCAwOTo0NywgTGVpZiBMaW5k
aG9sbSA8bGVpZkBudXZpYWluYy5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiBPbiBTYXQsIE1hciAyOCwgMjAyMCBhdCAyMTo1ODowOSArMDEwMCwgQXJkIEJpZXNoZXV2
ZWwgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gQ29tbWl0IDlmOTIyMzc3OGVmMyAoImVmaS9saWJz
dHViL2FybTogTWFrZSBlZmlfZW50cnkoKSBhbiBvcmRpbmFyeQ0KPiA+ID4gPiA+ID4gPiA+IFBF
L0NPRkYgZW50cnlwb2ludCIpIGRpZCBzb21lIGNvZGUgcmVmYWN0b3JpbmcgdG8gZ2V0IHJpZCBv
ZiB0aGUNCj4gPiA+ID4gPiA+ID4gPiBFRkkgZW50cnkgcG9pbnQgYXNzZW1ibGVyIGNvZGUsIGFu
ZCBpbiB0aGUgcHJvY2VzcywgaXQgZ290IHJpZCBvZiB0aGUNCj4gPiA+ID4gPiA+ID4gPiBhc3Np
Z25tZW50IG9mIGltYWdlX2FkZHIgdG8gdGhlIHZhbHVlIG9mIF90ZXh0LiBJbnN0ZWFkLCBpdCBz
d2l0Y2hlZA0KPiA+ID4gPiA+ID4gPiA+IHRvIHVzaW5nIHRoZSBpbWFnZV9iYXNlIGZpZWxkIG9m
IHRoZSBlZmlfbG9hZGVkX2ltYWdlIHN0cnVjdCBwcm92aWRlZA0KPiA+ID4gPiA+ID4gPiA+IGJ5
IFVFRkksIHdoaWNoIHNob3VsZCBjb250YWluIHRoZSBzYW1lIHZhbHVlLg0KPiA+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+ID4gSG93ZXZlciwgTWljaGFlbCByZXBvcnRzIHRoYXQgdGhpcyBp
cyBub3QgdGhlIGNhc2U6IG9sZGVyIEdSVUIgYnVpbGRzDQo+ID4gPiA+ID4gPiA+ID4gY29ycnVw
dCB0aGlzIHZhbHVlIGluIHNvbWUgd2F5LCBhbmQgc2luY2Ugd2UgY2FuIGVhc2lseSBzd2l0Y2gg
YmFjayB0bw0KPiA+ID4gPiA+ID4gPiA+IHJlZmVycmluZyB0byBfdGV4dCB0byBkaXNjb3ZlciB0
aGlzIHZhbHVlLCBsZXQncyBzaW1wbHkgZG8gdGhhdC4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ID4gSXQgaXMgbm90IGNsZWFyIHRvIG1lIGhvdyAib2xkZXIgR1JVQiBidWlsZHMiIHdvdWxk
IGRpZmZlciBoZXJlLg0KPiA+ID4gPiA+ID4gPiBJIHRoaW5rIG1vcmUgaW52ZXN0aWdhdGlvbiBp
cyBuZWVkZWQgYmVmb3JlIG1ha2luZyB0aGF0IGNsYWltLg0KPiA+ID4gPiA+ID4gPiBNeSBzdXNw
aWNpb24gaXMgdGhhdCBzb21lIChvbGQpIHZlcnNpb24gb2Ygbm9uLXVwc3RyZWFtLCBzaGltLWVu
YWJsZWQNCj4gPiA+ID4gPiA+ID4gZGlzdHJvLXNwZWNpZmljIGJ1aWxkIGlzIHBsYXlpbmcgYSBw
YXJ0Lg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBTbywgZG8gd2UgaGF2ZSB0aGUgb3B0
aW9uIGZvciBtb3JlIGRldGFpbGVkIGludmVzdGlnYXRpb25zLCBvciBjYW4gd2UNCj4gPiA+ID4g
PiA+ID4gdmFndWUgdGhlIGNsYWltIHVwIHRvIHNheSAic29tZSBHUlVCIGJ1aWxkcyBzZWVuIGlu
IHRoZSB3aWxkLCBiYXNlZA0KPiA+ID4gPiA+ID4gPiBvbiBhbiB1cHN0cmVhbSAyLjAyIiBvciBz
dWNobGlrZT8NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJJ3ZlIHF1
ZXVlZCBhIGZpeCB0aGF0IHByaW50cyBhIG5hc3R5Z3JhbSBpZiB0aGUgdmFsdWUgZGV2aWF0ZXMg
ZnJvbQ0KPiA+ID4gPiA+ID4gdGhlIGV4cGVjdGVkIG9uZS4gTGV0J3Mgc2VlIGlmIHRoaXMgdHJp
Z2dlcnMgYW55IHJlcG9ydHMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAoL21lIGxvb2tzIGF0IGNv
bnRleHQpDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAqVGhpcyogaXMgdGhlIGZpeCB0aGF0IHByaW50
cyBhIG5hc3R5Z3JhbS4NCj4gPiA+ID4NCj4gPiA+ID4gRldJVywgSSBwdWxsZWQgdGhlIEJPT1RB
QTY0LkVGSSBhbmQgZ3J1YmFhNjQuZWZpIGZpbGVzIGZyb20gQ2VudE9TIDcuNg0KPiA+ID4gPiBh
bmQgQ2VudE9TIDguMCBiaW5hcnkgcGFja2FnZXMgYW5kIHRlc3RlZCBib3RoIGluIG15IEh5cGVy
LVYgVk0uDQo+ID4gPiA+IFVzaW5nIHN0cmluZ3MgfCBncmVwICcyXC4nIHRvIGdldCB2ZXJzaW9u
IGluZm8sIHRoZSBDZW50T1MgNy42IGdydWJhYTY0LmVmaQ0KPiA+ID4gPiBzaG93czoNCj4gPiA+
ID4NCj4gPiA+ID4gICAgICAgICBVc2VyLUFnZW50OiBHUlVCIDIuMDJ+YmV0YTINCj4gPiA+ID4N
Cj4gPiA+ID4gVGhlIENlbnRPUyA4LjAgZ3J1YmFhNjQuZWZpIHNob3dzOg0KPiA+ID4gPg0KPiA+
ID4gPiAgICAgICAgIFVzZXItQWdlbnQ6IEdSVUIgMi4wMw0KPiA+ID4gPg0KPiA+ID4gPiBCb3Ro
IHZlcnNpb25zIHByb2R1Y2UgdGhlIEZJUk1XQVJFIEJVRyB3YXJuaW5nIHdoZW4gdXNpbmcgQXJk
J3MNCj4gPiA+ID4gbGF0ZXN0IHBhdGNoLiAgSSdsbCBhc3N1bWUgdGhlIGVxdWl2YWxlbnQgUkhF
TCB2ZXJzaW9ucyBhcmUgdGhlIHNhbWUuDQo+ID4gPiA+IFNvIHdlJ3ZlIGdvdCBvZmZpY2lhbCBk
aXN0cm8gcmVsZWFzZXMgdGhhdCBzaG93IHRoZSBwcm9ibGVtLg0KPiA+ID4gPg0KPiA+ID4gPiBB
cyByZXBvcnRlZCBlYXJsaWVyLCB0aGUgQk9PVEFBNjQuRUZJIGFuZCBncnViYWE2NC5lZmkgZnJv
bSBhDQo+ID4gPiA+IERlYmlhbiByZWxlYXNlIChub3QgZXhhY3RseSBzdXJlIHdoaWNoIG9uZSkg
ZG8gbm90IHByb2R1Y2UgdGhlDQo+ID4gPiA+IEZJUk1XQVJFIEJVRyB3YXJuaW5nLiAgVGhlIGdy
dWJhYTY0LmVmaSByZXBvcnRzIGFzIDIuMDQtNC4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBUaGFu
a3MgYSBsb3QgTWljaGFlbCwgdGhhdCBpcyByZWFsbHkgaGVscGZ1bC4NCj4gPg0KPiA+IEkgY291
bGQgbm90IHJlcHJvZHVjZSB0aGUgaXNzdWUgd2l0aCBEZWJpYW4gU3RyZXRjaCdzDQo+ID4gMi4w
Mn5iZXRhMy01K2RlYjl1Miwgc28gaXQgZG9lcyBhcHBlYXIgdG8gYmUgUmVkSGF0J3MgdmFsdWUg
YWRkIHRoYXQNCj4gPiBpcyB0byBibGFtZSBoZXJlLg0KPiA+DQo+ID4gQExhc3psbzogVEw7RFIg
UmVkSGF0J3MgR1JVQiBmb3IgYXJtNjQgYXBwZWFycyB0byBjbG9iYmVyIHRoZQ0KPiA+IGltYWdl
X2Jhc2UgZmllbGQgb2YgdGhlIGVmaV9sb2FkZWRfaW1hZ2Ugc3RydWN0IHBhc3NlZCB0byB0aGUg
a2VybmVsLg0KPiA+IENvdWxkIHlvdSBwbGVhc2UgcmVjb21tZW5kIGEgd2F5IHRvIHJlcG9ydCB0
aGlzPw0KPiANCj4gT3IgdGhlcmUgY291bGQgYmUgc29tZXRoaW5nIHdlaXJkIGFib3V0IG15IEh5
cGVyLVYgVk0uICBJIGhhdmUgYQ0KPiBjb3VwbGUgb2YgQVJNNjQgYmFyZSBtZXRhbCBtYWNoaW5l
cywgYnV0IHRoZXkgYXJlIGluIHRoZSBvZmZpY2UNCj4gd2l0aCBubyByZW1vdGUgYWNjZXNzLCBh
bmQgd2UncmUgb24gdGhlIHdvcmstZnJvbS1ob21lIHBsYW4gZm9yDQo+IG5vdy4gIEJ1dCBJIG1h
eSBiZSBhYmxlIHRvIGdldCBpbnRvIHRoZSBvZmZpY2UgbGF0ZXIgdGhpcyB3ZWVrIGFuZA0KPiB0
cnkgaXQuICBJJ2QgbGlrZSB0byBydWxlIG91dCBhbnl0aGluZyByZWxhdGVkIHRvIEh5cGVyLVYs
IGFuZCB3aWxsDQo+IHVwZGF0ZSB0aGlzIHRocmVhZCBpZiBJIGNhbi4NCj4gDQoNCkkgaGF2ZSB0
cmllZCB0aGlzIHNjZW5hcmlvIG9uIGJhcmUgbWV0YWwgcnVubmluZyBSSEVMIDcuNCwgYW5kIHRo
ZQ0KcHJvYmxlbSByZXByb2R1Y2VzIGFzIGRlc2NyaWJlZCBhYm92ZS4gIFNvIHRoaXMgaXMgKm5v
dCogcmVsYXRlZCB0bw0KcnVubmluZyBpbiBhIEh5cGVyLVYgVk0sIHdoaWNoIGlzIHdoYXQgSSB3
YW50ZWQgdG8gbWFrZSBzdXJlIG9mLg0KDQpNaWNoYWVsDQo=
