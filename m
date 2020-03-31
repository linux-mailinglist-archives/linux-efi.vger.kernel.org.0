Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716D81997A6
	for <lists+linux-efi@lfdr.de>; Tue, 31 Mar 2020 15:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgCaNh6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Mar 2020 09:37:58 -0400
Received: from mail-dm6nam12on2104.outbound.protection.outlook.com ([40.107.243.104]:31662
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730216AbgCaNh5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 31 Mar 2020 09:37:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuHeZTR1jrQNqmW0vyZgz/d5ltjVZZoheyIThK1fXd+1cPnTVFPXMWbw8OQN2A4K0KIuN0uB6kkwLDFMfLbxUI9LOTuIBh6TfA+m8E3pTp8qOl61D6jQ00PdRb7hHCAFCHJG8Pj5llRwWNN0Gr20qaGR9YcnnDOTMCLkVRbW8AosnDammka7L3KGrmoshRcXpiZ8pD5nOXjpoTIugUoXRJjWoX84ZruICbbuQO3TPTMM7ViMH8iwXG5eSJeQ2GRDAcep9RRKzGX7oHIYQeV6N8z0aIrk8sazyOzfWRQgoCSe/VoVmb3WZDS76hQ7bf5gryiT8aKs912RMieOOD+ELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCw+T1nTJEBmtAG0toLAUHlQawDKBnglLx8yByveOIE=;
 b=HLLkeqbzzVoaTwRdZTYQJzQtArTgkvPSyQgcuxLlFu+7fBJqHZlSE+FN0uqMDyyMjrFRcPkh/qmXCNzTsbm3WrWgpLdL8M4RPPK7P3e9tb8oCXHa///INYt1hO6vt9WyFK2lxSAjeM1JOzgRA6nPblk8azTWK38uQUCdPuFg6paK5bIsr/19/GUcBJyKGiO5frTXYsZlrqFWO0OO1sBqx9WcgfeNCTsoB53thunpjP3Fx9u0Bv+flPxvnT3sJMjXXO0ZGjbW6NAOdmYELodL5fQuEZUp33VYWojSJmGnChySoBoUd/BUkzHX+30cz2FzJQHVEsHpv1ZV76FNPXjegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCw+T1nTJEBmtAG0toLAUHlQawDKBnglLx8yByveOIE=;
 b=aUayF902efsTPpUG+qdfNgLZgl7bWHmrbIXPlsZPpQUJ8WHCKsVpxRd2Eml4Q8bv7R3nSMTspMGaXZJ9szRD1F/2cy6sDHRVYULIh8j3ZjetoJQHmdVL38To223WTlYSH2e5Pl6l64WBCceYbdbrkY0PxqQGMQ74gDroojTHso8=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1114.namprd21.prod.outlook.com (2603:10b6:302:a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.2; Tue, 31 Mar
 2020 13:37:46 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.002; Tue, 31 Mar 2020
 13:37:46 +0000
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
Thread-Index: AQHWBUObXv2MTW3u/Ue45F8yahNJA6hgxFuAgAAA5gCAAAAuAIAAqMgQgAAIF4CAAOLlAIAAXdmA
Date:   Tue, 31 Mar 2020 13:37:45 +0000
Message-ID: <MW2PR2101MB10525381BAB07997EA5F6B7CD7C80@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200328205809.23825-1-ardb@kernel.org>
 <20200330074721.GV22097@bivouac.eciton.net>
 <CAMj1kXFPtY20afbAZgXT3As4TUuAqi3=pG8u19hjMjFxgN6HWA@mail.gmail.com>
 <CAMj1kXEf5rT1pmDNQoOd5Tx9xQ=fUMT0xo4JXZNfz=VDY9268Q@mail.gmail.com>
 <DM5PR2101MB104760D03E632DD4DBE99AE1D7CB0@DM5PR2101MB1047.namprd21.prod.outlook.com>
 <CAMj1kXF+2O5cDC9zuNp9Lx9Oe6WyxRghPqSi63CnF+KCcGUZyw@mail.gmail.com>
 <CAMj1kXFJB9ciJ41V2tpQNX_mN7S8BweV9_ME3sDxKjwnR2Jwbg@mail.gmail.com>
In-Reply-To: <CAMj1kXFJB9ciJ41V2tpQNX_mN7S8BweV9_ME3sDxKjwnR2Jwbg@mail.gmail.com>
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
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7b84d1c-923f-4861-2d70-08d7d578b263
x-ms-traffictypediagnostic: MW2PR2101MB1114:|MW2PR2101MB1114:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB11149E7F4FCAA2CEE4B917ADD7C80@MW2PR2101MB1114.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(66476007)(66556008)(64756008)(66946007)(9686003)(7696005)(71200400001)(66446008)(76116006)(55016002)(4326008)(26005)(107886003)(8936002)(54906003)(33656002)(8676002)(86362001)(6506007)(81166006)(186003)(81156014)(82950400001)(53546011)(498600001)(110136005)(52536014)(5660300002)(10290500003)(2906002)(82960400001)(8990500004)(365024005);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J2PSF+tJ4P0ibnVw4f8G1aO5/Sa/PgYJkbYQC+rhZkI54uRWCG8XSSI60fL/d43qy5v1Q5B63bH9TZ4VscGuD5tTHu0dsxTeNCBCsDb+ZwxhDAx5egi6dHZAq79jDx5fO9ZgAvFwFevfTEivoB5nAYjsPY9B2u/8yPNQkPG9lkvGcQrytn3hhnaMeD8Yr/eEup4oDZjt+mJ2Z+ynb80D/Vk4b+7ChIMhR4Y2t6cQ8KB5YkUDe8UfUnGxqxeFh9y9bsD6y5B9NTngd14F5K/C6u8Kf7wD/jXlK9R/TJeQ4V+9Z77bTTPdIFJlRlb5HTIeqrMitIiRyOn+SCvR8Jy+Fd72bFV2TQ6/fMOO1Ce+nc/TSEsb73YcLZtV7LIT3aR0bVD0HJ0GW7+zIQNe/wgi38/TkaHQf6PXKSHedoj7pWBC+zAaNAkocLUyvS+lI7AoDK7pjJlA5931NJXkEDRywxZZFGYSe8FllJF3r0IQwSuvQVhLNU7yrD/VpDdvqXK1
x-ms-exchange-antispam-messagedata: eTCQ5/IBfBKQamZ9bnP4WiEtSE2AoGbMeFIodGuWzOVqkTCsVxeN3NOaPaAlLU6nGXbt2azV+phIN4eVgPt0hDUr8dr5t9yiIaFyIZTiV9EQntvqbE0PW2wQKIYutWKscRORKbZE+q6c3yP+3SlBCA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b84d1c-923f-4861-2d70-08d7d578b263
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 13:37:46.0551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWK9cB+KK9xUZiZWPH5XnSzUC25XRg3UG1HeL/B0ebKbpV6cd6PtlK/G7YIydsk4Btb1IIYkbOUyGt+KfG2rzScmom7y33IA5TVJg+hMuNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1114
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

RnJvbTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4gIFNlbnQ6IFR1ZXNkYXksIE1h
cmNoIDMxLCAyMDIwIDEyOjU2IEFNDQo+IA0KPiBPbiBNb24sIDMwIE1hciAyMDIwIGF0IDIwOjI0
LCBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIE1v
biwgMzAgTWFyIDIwMjAgYXQgMjA6MTIsIE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3Nv
ZnQuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBGcm9tOiBBcmQgQmllc2hldXZlbCA8YXJkYkBr
ZXJuZWwub3JnPiAgU2VudDogTW9uZGF5LCBNYXJjaCAzMCwgMjAyMCAxMjo1MSBBTQ0KPiA+ID4g
Pg0KPiA+ID4gPiBPbiBNb24sIDMwIE1hciAyMDIwIGF0IDA5OjUwLCBBcmQgQmllc2hldXZlbCA8
YXJkYkBrZXJuZWwub3JnPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIE1vbiwgMzAg
TWFyIDIwMjAgYXQgMDk6NDcsIExlaWYgTGluZGhvbG0gPGxlaWZAbnV2aWFpbmMuY29tPiB3cm90
ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBPbiBTYXQsIE1hciAyOCwgMjAyMCBhdCAyMTo1
ODowOSArMDEwMCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IENvbW1pdCA5
ZjkyMjM3NzhlZjMgKCJlZmkvbGlic3R1Yi9hcm06IE1ha2UgZWZpX2VudHJ5KCkgYW4gb3JkaW5h
cnkNCj4gPiA+ID4gPiA+ID4gUEUvQ09GRiBlbnRyeXBvaW50IikgZGlkIHNvbWUgY29kZSByZWZh
Y3RvcmluZyB0byBnZXQgcmlkIG9mIHRoZQ0KPiA+ID4gPiA+ID4gPiBFRkkgZW50cnkgcG9pbnQg
YXNzZW1ibGVyIGNvZGUsIGFuZCBpbiB0aGUgcHJvY2VzcywgaXQgZ290IHJpZCBvZiB0aGUNCj4g
PiA+ID4gPiA+ID4gYXNzaWdubWVudCBvZiBpbWFnZV9hZGRyIHRvIHRoZSB2YWx1ZSBvZiBfdGV4
dC4gSW5zdGVhZCwgaXQgc3dpdGNoZWQNCj4gPiA+ID4gPiA+ID4gdG8gdXNpbmcgdGhlIGltYWdl
X2Jhc2UgZmllbGQgb2YgdGhlIGVmaV9sb2FkZWRfaW1hZ2Ugc3RydWN0IHByb3ZpZGVkDQo+ID4g
PiA+ID4gPiA+IGJ5IFVFRkksIHdoaWNoIHNob3VsZCBjb250YWluIHRoZSBzYW1lIHZhbHVlLg0K
PiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBIb3dldmVyLCBNaWNoYWVsIHJlcG9ydHMgdGhh
dCB0aGlzIGlzIG5vdCB0aGUgY2FzZTogb2xkZXIgR1JVQiBidWlsZHMNCj4gPiA+ID4gPiA+ID4g
Y29ycnVwdCB0aGlzIHZhbHVlIGluIHNvbWUgd2F5LCBhbmQgc2luY2Ugd2UgY2FuIGVhc2lseSBz
d2l0Y2ggYmFjayB0bw0KPiA+ID4gPiA+ID4gPiByZWZlcnJpbmcgdG8gX3RleHQgdG8gZGlzY292
ZXIgdGhpcyB2YWx1ZSwgbGV0J3Mgc2ltcGx5IGRvIHRoYXQuDQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gSXQgaXMgbm90IGNsZWFyIHRvIG1lIGhvdyAib2xkZXIgR1JVQiBidWlsZHMiIHdvdWxk
IGRpZmZlciBoZXJlLg0KPiA+ID4gPiA+ID4gSSB0aGluayBtb3JlIGludmVzdGlnYXRpb24gaXMg
bmVlZGVkIGJlZm9yZSBtYWtpbmcgdGhhdCBjbGFpbS4NCj4gPiA+ID4gPiA+IE15IHN1c3BpY2lv
biBpcyB0aGF0IHNvbWUgKG9sZCkgdmVyc2lvbiBvZiBub24tdXBzdHJlYW0sIHNoaW0tZW5hYmxl
ZA0KPiA+ID4gPiA+ID4gZGlzdHJvLXNwZWNpZmljIGJ1aWxkIGlzIHBsYXlpbmcgYSBwYXJ0Lg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNvLCBkbyB3ZSBoYXZlIHRoZSBvcHRpb24gZm9yIG1v
cmUgZGV0YWlsZWQgaW52ZXN0aWdhdGlvbnMsIG9yIGNhbiB3ZQ0KPiA+ID4gPiA+ID4gdmFndWUg
dGhlIGNsYWltIHVwIHRvIHNheSAic29tZSBHUlVCIGJ1aWxkcyBzZWVuIGluIHRoZSB3aWxkLCBi
YXNlZA0KPiA+ID4gPiA+ID4gb24gYW4gdXBzdHJlYW0gMi4wMiIgb3Igc3VjaGxpa2U/DQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSd2ZSBxdWV1ZWQgYSBmaXggdGhhdCBwcmlu
dHMgYSBuYXN0eWdyYW0gaWYgdGhlIHZhbHVlIGRldmlhdGVzIGZyb20NCj4gPiA+ID4gPiB0aGUg
ZXhwZWN0ZWQgb25lLiBMZXQncyBzZWUgaWYgdGhpcyB0cmlnZ2VycyBhbnkgcmVwb3J0cy4NCj4g
PiA+ID4NCj4gPiA+ID4gKC9tZSBsb29rcyBhdCBjb250ZXh0KQ0KPiA+ID4gPg0KPiA+ID4gPiAq
VGhpcyogaXMgdGhlIGZpeCB0aGF0IHByaW50cyBhIG5hc3R5Z3JhbS4NCj4gPiA+DQo+ID4gPiBG
V0lXLCBJIHB1bGxlZCB0aGUgQk9PVEFBNjQuRUZJIGFuZCBncnViYWE2NC5lZmkgZmlsZXMgZnJv
bSBDZW50T1MgNy42DQo+ID4gPiBhbmQgQ2VudE9TIDguMCBiaW5hcnkgcGFja2FnZXMgYW5kIHRl
c3RlZCBib3RoIGluIG15IEh5cGVyLVYgVk0uDQo+ID4gPiBVc2luZyBzdHJpbmdzIHwgZ3JlcCAn
MlwuJyB0byBnZXQgdmVyc2lvbiBpbmZvLCB0aGUgQ2VudE9TIDcuNiBncnViYWE2NC5lZmkNCj4g
PiA+IHNob3dzOg0KPiA+ID4NCj4gPiA+ICAgICAgICAgVXNlci1BZ2VudDogR1JVQiAyLjAyfmJl
dGEyDQo+ID4gPg0KPiA+ID4gVGhlIENlbnRPUyA4LjAgZ3J1YmFhNjQuZWZpIHNob3dzOg0KPiA+
ID4NCj4gPiA+ICAgICAgICAgVXNlci1BZ2VudDogR1JVQiAyLjAzDQo+ID4gPg0KPiA+ID4gQm90
aCB2ZXJzaW9ucyBwcm9kdWNlIHRoZSBGSVJNV0FSRSBCVUcgd2FybmluZyB3aGVuIHVzaW5nIEFy
ZCdzDQo+ID4gPiBsYXRlc3QgcGF0Y2guICBJJ2xsIGFzc3VtZSB0aGUgZXF1aXZhbGVudCBSSEVM
IHZlcnNpb25zIGFyZSB0aGUgc2FtZS4NCj4gPiA+IFNvIHdlJ3ZlIGdvdCBvZmZpY2lhbCBkaXN0
cm8gcmVsZWFzZXMgdGhhdCBzaG93IHRoZSBwcm9ibGVtLg0KPiA+ID4NCj4gPiA+IEFzIHJlcG9y
dGVkIGVhcmxpZXIsIHRoZSBCT09UQUE2NC5FRkkgYW5kIGdydWJhYTY0LmVmaSBmcm9tIGENCj4g
PiA+IERlYmlhbiByZWxlYXNlIChub3QgZXhhY3RseSBzdXJlIHdoaWNoIG9uZSkgZG8gbm90IHBy
b2R1Y2UgdGhlDQo+ID4gPiBGSVJNV0FSRSBCVUcgd2FybmluZy4gIFRoZSBncnViYWE2NC5lZmkg
cmVwb3J0cyBhcyAyLjA0LTQuDQo+ID4gPg0KPiA+DQo+ID4gVGhhbmtzIGEgbG90IE1pY2hhZWws
IHRoYXQgaXMgcmVhbGx5IGhlbHBmdWwuDQo+IA0KPiBJIGNvdWxkIG5vdCByZXByb2R1Y2UgdGhl
IGlzc3VlIHdpdGggRGViaWFuIFN0cmV0Y2gncw0KPiAyLjAyfmJldGEzLTUrZGViOXUyLCBzbyBp
dCBkb2VzIGFwcGVhciB0byBiZSBSZWRIYXQncyB2YWx1ZSBhZGQgdGhhdA0KPiBpcyB0byBibGFt
ZSBoZXJlLg0KPiANCj4gQExhc3psbzogVEw7RFIgUmVkSGF0J3MgR1JVQiBmb3IgYXJtNjQgYXBw
ZWFycyB0byBjbG9iYmVyIHRoZQ0KPiBpbWFnZV9iYXNlIGZpZWxkIG9mIHRoZSBlZmlfbG9hZGVk
X2ltYWdlIHN0cnVjdCBwYXNzZWQgdG8gdGhlIGtlcm5lbC4NCj4gQ291bGQgeW91IHBsZWFzZSBy
ZWNvbW1lbmQgYSB3YXkgdG8gcmVwb3J0IHRoaXM/DQoNCk9yIHRoZXJlIGNvdWxkIGJlIHNvbWV0
aGluZyB3ZWlyZCBhYm91dCBteSBIeXBlci1WIFZNLiAgSSBoYXZlIGENCmNvdXBsZSBvZiBBUk02
NCBiYXJlIG1ldGFsIG1hY2hpbmVzLCBidXQgdGhleSBhcmUgaW4gdGhlIG9mZmljZQ0Kd2l0aCBu
byByZW1vdGUgYWNjZXNzLCBhbmQgd2UncmUgb24gdGhlIHdvcmstZnJvbS1ob21lIHBsYW4gZm9y
DQpub3cuICBCdXQgSSBtYXkgYmUgYWJsZSB0byBnZXQgaW50byB0aGUgb2ZmaWNlIGxhdGVyIHRo
aXMgd2VlayBhbmQNCnRyeSBpdC4gIEknZCBsaWtlIHRvIHJ1bGUgb3V0IGFueXRoaW5nIHJlbGF0
ZWQgdG8gSHlwZXItViwgYW5kIHdpbGwNCnVwZGF0ZSB0aGlzIHRocmVhZCBpZiBJIGNhbi4NCg0K
TWljaGFlbA0K
