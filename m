Return-Path: <linux-efi+bounces-875-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64305889F22
	for <lists+linux-efi@lfdr.de>; Mon, 25 Mar 2024 13:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677D91C2CAA2
	for <lists+linux-efi@lfdr.de>; Mon, 25 Mar 2024 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4697515EFC2;
	Mon, 25 Mar 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="NkPExYL/"
X-Original-To: linux-efi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11010000.outbound.protection.outlook.com [52.101.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2513D2308;
	Mon, 25 Mar 2024 03:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338006; cv=fail; b=oh0TElFDA9ss1YROkjxqZYTYxKPHEO+NtykHzMKwDDooZv0jnrxrR9F9p/OF7CR/6lgYMh/9KSIrDtDSKmYxmRvaOrfuJNRNs6FE4S+ygVsn0RlXcFUjPqxImoa2ztXmndpdRXrBHv+IlrXR4bYaVRXviK2GFELgoU4AMsyjLR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338006; c=relaxed/simple;
	bh=zMe8DfqnZM4XeEB6sgl+iA7ry0L/wkh9Y6SyVgIwBpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CivNJXCdvi2MKghIZBkgkz14Y574wgZMJvazE+WF4/wua/Sc4TziDrZg/tdL8fRP+dHUOqJ29mn2O7JHhMddZvVs0rZfmJlK/3xCS+YmZkZStiH3nY2iLfR5Qoto/h5qIwrgm3gpzdKUkDo/so/TyQgCqH4w2+gExfv20SdHekE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=NkPExYL/; arc=fail smtp.client-ip=52.101.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtDvkCY9rft9uiWVEWMwCPmsEFEMFTpUg2rVkSxZeTAN0mTH4J2tFsvsnHrmCJR2Y/LXi6lEuEXhF1Y0SDUcTBr8hTPRs47oY2jGYigrwmEvgNp76v4mDZHokuhzo9BoNgkinyCCF79QlQoHINuBK5uTu69qmDZusnT/8MUTjjLtsjd8E+szVr8r7yw1akiLqPGWPhx9LW51lSZk1QZaBZr30eiF7FBXzAIxD9q5UAoYDOFmEc5JMoEfW6Dun2odLUGXyGA9JutolxRg//0osGi85SqxcXgy+bLzULSUo5Jme5PtHwKWjoaN6bYx8vmG55rfuG/ThvcL1Bcw2RVtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMe8DfqnZM4XeEB6sgl+iA7ry0L/wkh9Y6SyVgIwBpc=;
 b=XtyHN33O8zLHWZ2QHfLIW1qA2R3U/PGwB5IoLrDkwB3a4P3gQX4hH+KVFViw1OdEFKdIsvy7PzGmhntMSxxbFDjiqZhG8Qd+yg16+Fz8gdjtjdFaRdsfJUb8kpaQsfh1u2UGXmNOlJfv1kuLBrpAQgac6wISiK/DpQf6NuS5TVyvgPvYPjfrC5ju9Xk+sqZglmyrjZQf3usozQi4eLgFaZ7RhvpAm3Qs+Lj8kE4nb37i3x6eDtLjCy6pgZV20RVURKVJ4k4tPLEVL04Wvz30xtQuAtDoRpLJNypEhR9Asok9STr17RHC4vywI8mZFboXD5xHWFogn4hD4w2n2mhurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMe8DfqnZM4XeEB6sgl+iA7ry0L/wkh9Y6SyVgIwBpc=;
 b=NkPExYL/vn3Pph7ExQoHKDe2m69Hy04FXHBudLXLScPpbVnHsJEtKpLQ/MvpGBtW1ROstXwsEoU+Eh/HsTSpwL+/wrpL9Y+9QWvba5bpn3YbTICJjSZgBcOkSy1w4XeD1z1buxnO+PccpENclysnKfS5WheF7K2GhGApSqP45U+1LcSy7lZlvGHkI6Fg9GJ7GhenP989fsp3LxelhTM2/jFef8pQX6dsa+zWUbew5sNP7YzahJLZUYpwNqwb9+gxxfuvF343E4AWnUf3a/QHHwxusxpVSH6vMHpjepGn/3KXQ6l6rycxxkTVdW+6fsxrkp9E3ve8zEV7mYTvDlsMxA==
Received: from TY1PR01MB1625.jpnprd01.prod.outlook.com (2603:1096:403:5::19)
 by TYCPR01MB10463.jpnprd01.prod.outlook.com (2603:1096:400:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 03:40:00 +0000
Received: from TY1PR01MB1625.jpnprd01.prod.outlook.com
 ([fe80::fb45:85ca:f420:e514]) by TY1PR01MB1625.jpnprd01.prod.outlook.com
 ([fe80::fb45:85ca:f420:e514%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 03:40:00 +0000
From: =?utf-8?B?S09ORE8gS0FaVU1BKOi/keiXpOOAgOWSjOecnyk=?=
	<kazuma-kondo@nec.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"tomenglund26@gmail.com" <tomenglund26@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi/libstub: fix efi_random_alloc() to allocate memory at
 alloc_min or higher address
Thread-Topic: [PATCH] efi/libstub: fix efi_random_alloc() to allocate memory
 at alloc_min or higher address
Thread-Index: AQHafEg9wcbkIIdoj0CvtWchAjlv4bFDviKAgAQVhwA=
Date: Mon, 25 Mar 2024 03:40:00 +0000
Message-ID: <ee451b6f-b601-426b-af1c-15dcb6626175@nec.com>
References: <20240322110058.557329-1-kazuma-kondo@nec.com>
 <CAMj1kXFSpF0YzwtgER11ocBrhjyG0Us7=kp7a92tDm3aZy=WrA@mail.gmail.com>
In-Reply-To:
 <CAMj1kXFSpF0YzwtgER11ocBrhjyG0Us7=kp7a92tDm3aZy=WrA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1625:EE_|TYCPR01MB10463:EE_
x-ms-office365-filtering-correlation-id: 1b94ee3b-c9f9-42fd-9f2f-08dc4c7d3fde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Z4wwC0pBKEuor52alCxjS3kay3Guebd9K6i19j12Fqb++RmGhQRouM8nOLuJm+/AUaCmrIQBBxzcn61Ao88VtFa6Jt2+M7WjkeWzP18Ut9emptYw6G/VBbbcUGdYeMH9uZdD0l9NfBGNScM3MNkWJn1zhYEqrHWBanDpVNIyAGNlaLkb8aGUSF9YdjWXnJe+pzHczbmuTTrqPfwN0R8DOS0HLHE7Zz5jATcb1A9dvHjdWa85/tN2MgxHAVi6Ef+DV2GI3TjHmLs1MBVURml/hWRsI55UJBeU1wBBM6MYgMB5VlsQEcoe+7mQqIiZYA8vlKiRXMOBsQRsXq2DUD7/xmZBDtbM6Ju88m9I82r+KwyMEmu7qaxOAUOySRcIcl8yEpJI84joZoLoo/Tv8wU1qmxqBezGL7XWaLraha7Aq1SnHXzBx1M+joF+bbPFABAyzV7WYdkCGDrjnecODCN7WAm3EYyJyCLQrdjfidOA1rvoo6Tpbj0DcbxxtEz7IN0pGrNwe254o8CcJN5YczCcP1Mpz/Fb20TxT2dVe421vmYoRE/GRgqUxlI0JLVL1qiSFp0CORX48ALEXXfGELnP2QvdyOQ3mxkrgyL4pI4K0h4KK8TBjIAgNQlFw+8QX1rVc5o2H6nN6VPo9eY2D4Fg72OKMu9lB6vJXWBi4bRMnbeHRii2/C5ihThNiVReMGvsw/KGV7OOzWMua6LZIr7/sUKtmFU7PHTfvDJUzqLu4hk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1625.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHA2Mkx3Sk5Ia250eXhCVC9WRktLQ2JrTFN6T0ZnWDlVNWtNMGNZeGZEK0lP?=
 =?utf-8?B?MlVkbUltUFlLd0Z4UXB0WFY3QnVhMFBRMVdTSHVZTEtPSHcyK3N0RkRGWGxj?=
 =?utf-8?B?Z0Jpb1QvNTNWZGE3VGFPOUFRRzJoaHd3Y3NlTGR6RzJBdHZtNEFvTUtTWWh5?=
 =?utf-8?B?ajhCaEdKQ2lvWnN3Mjc3a25hRG1OQmZGdEZxcXEwWVM5MFp2VkF1YXZSRFlz?=
 =?utf-8?B?U2Z3VkN5S1V5b1ExZy90TUk5aHJtTjUza0VvbkVPeEN6Z09VSDl0UFNHbXBM?=
 =?utf-8?B?WWFNWDE0VlJyWGxrcG1XWWd4Qnd2eWRNbGZ2MjVSZ0l6Z1FvY0JkL0V4WDBi?=
 =?utf-8?B?ZkpnaCtQd0ptM2FvQWF6UnJsZG54aGdGSzhOTDZLNW9sS1NxLy9LVERDaS95?=
 =?utf-8?B?SEFZVlhkdXA5Sk9sVnNCd1B0KzExRWNLK3VMc2hXLzVQZXRGQjVub1BlQ0xV?=
 =?utf-8?B?YXRSOG43UVQ0RWlKZVllK09NZGxpRFRaREtZQ3E0a3VhNW8xU2VqdE9Zek9x?=
 =?utf-8?B?bTV4OEdBTHFxY3JQdlhzTEg2OXBvSGx3b1FNMWpZUFkrWGhlT2NSTW5SZk9Z?=
 =?utf-8?B?UlIwZi9vZmdGTjduLzllbHNINTVUcjBJYXEvdHNPV0V1SzFOOCtMRzRWckVX?=
 =?utf-8?B?cm5aMEViUjByM1d2SjFSaDhNMElvcUdqOFVvRVI0a3hja3d3VVZjM2x5aFl2?=
 =?utf-8?B?enJPWUd2SDRPNFp4NGpOWkNYRFdkK0RGQzhqU2Y0MUFmalRjOTdjcjFNSUZ2?=
 =?utf-8?B?K0xHd2piZ3ZCUlNoNzhGMnBoU0pML1AzS3hKd0pDZ3pyYk5DeDRGTXZETDNr?=
 =?utf-8?B?Mmo5d2Q5Q2JWV3AxZVZJYTNXZ2t5REZwblUxdjVmWHRGc2ttRFhPWlJtd1VP?=
 =?utf-8?B?VW4rOVJiNHFyaXZaTFdscmpLRzd5YXRmY3lrdTB3alhmYm9ZZ0U5RCtBa1py?=
 =?utf-8?B?UkdoWCtMVFNjQVQyM0JEUis1NW9DMUVUeGhwOWo5TndnZVVNM1NqSlUrK0tH?=
 =?utf-8?B?Ym9MbUlROEUrVG1pUXdIQWdyNG16TWVwZlkrQ3FIWk9CVm5CZHFCY2lmWW40?=
 =?utf-8?B?dVppYWRHbkhYYWpjb2JnS3BhblBrVU15R1JqVnlKN1Y3TDFvNnFpMlBDZ0xP?=
 =?utf-8?B?d2E4VHVuWlhLaUVPRWo2NTVUWnpzREJqbjJtZXJ5UTl5MFUveml2TTNQYmdr?=
 =?utf-8?B?aXFiNXFoSUhXY1lTd2RsY0VHZWVpd3lmQnFHcDdDVnd3UStwRmljQndOR1FD?=
 =?utf-8?B?aG43bE9Sek5PUWNDeTFrN0J3WlBrLzJYZ0pMUGV4ZU9nUE9rMUhVUzNOQ1JD?=
 =?utf-8?B?L1RpMENhYVQ4WlMrNk9DcmtOL2o4SlkzOGIvVGZMSk1ta1NUVUJXVDQ3VGhU?=
 =?utf-8?B?dDErR1p5c3FDdkdGRmFuQTVNanlxb1JhS2VYOU9QWUdGbFBtaFI4M25XMkV5?=
 =?utf-8?B?OUI2QTR0R3YycmYwZVc2TVNmRVFIY1QwWjJlTXEyOEJKKzA1RU5nRUt4RFpZ?=
 =?utf-8?B?Tytxd1NKWHB4NFdYZ2lIOXJmcDhhcXBCYVlFbjBqaFUxaWZuZGNhQk1adTRv?=
 =?utf-8?B?UG1XVkhCS0lFcTNXOUpBdENxUEVTeEJscTNGMHN3TlpaOUprdldNQmt6S3pQ?=
 =?utf-8?B?L2UybEZQeWJwaGxyYWNqN0NoOWpNb3BEMjVtbEQyd0Ewcnovd2paTVAwUVFw?=
 =?utf-8?B?R0xmUkxsSVhURUdacEl3U3h5VlNJa2pPOTlubzlnNCtNYjU4OXJkcWdVbXpS?=
 =?utf-8?B?TFp6TWJYQVdIanFEc1c5NUJUbFZocTJqNjdDZ29Kd1RHd1pvSnVNZmRUK3J3?=
 =?utf-8?B?dHFqQlVDMFRidGJoUUtta0s3R01wZTZ5Y05Kd2REcTNuRWRkUURra0E3b2ty?=
 =?utf-8?B?N3VFMnZOTkdTNFAwS0pqdzh3VVhpa0NCbmFRQW5OQWdmT2ozYjZiRGNkR2tX?=
 =?utf-8?B?R0dlU1Z0blJtUzErcHAwRXUwT3k2UkhHNUgwdXpxSHgwaEl1Y29FNXlVTlNH?=
 =?utf-8?B?dmNnUS9yM2lGUWJjRktRcE5GMVhkK0p6bEVHRnJXMHIxb0MzOWVIR0duc0ZU?=
 =?utf-8?B?aVBBTU93R3ViM2pXenh3MjNJS3IxU1FVaEc0RXRaOExVT29DMWk4c2NYUDN1?=
 =?utf-8?B?UnIyK1J3cDhnNlpnMFM0L3lEbUtmcTFZaVVhL3plbTJuQitQUTFWdEFaR3ND?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7FBCE00BEBED54EB836FB2511583B65@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1625.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b94ee3b-c9f9-42fd-9f2f-08dc4c7d3fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 03:40:00.5783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLt14jfSzPWGTCpb3Ss5jGtNK97appdTZlyTk4TeGKiGaPVmyTjwJanREDLMDaNuCV3u40LboayvfElYEvNMOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10463

SGVsbG8gQXJkIEJpZXNoZXV2ZWwsDQoNCk9uIEZyaSwgMjIgTWFyIDIwMjQgYXQgMjI6MTcsIEFy
ZCBCaWVzaGV1dmVsIHdyb3RlOg0KPiBPbiBGcmksIDIyIE1hciAyMDI0IGF0IDEyOjAxLCBLT05E
TyBLQVpVTUEo6L+R6Jek44CA5ZKM55yfKSA8a2F6dW1hLWtvbmRvQG5lYy5jb20+IHdyb3RlOg0K
Pj4NCj4+IEZvbGxvd2luZyB3YXJuaW5nIGlzIHNvbWV0aW1lcyBvYnNlcnZlZCB3aGlsZSBib290
aW5nIG15IHNlcnZlcnM6DQo+PiAgIFsgICAgMy41OTQ4MzhdIERNQTogcHJlYWxsb2NhdGVkIDQw
OTYgS2lCIEdGUF9LRVJORUwgcG9vbCBmb3IgYXRvbWljIGFsbG9jYXRpb25zDQo+PiAgIFsgICAg
My42MDI5MThdIHN3YXBwZXIvMDogcGFnZSBhbGxvY2F0aW9uIGZhaWx1cmU6IG9yZGVyOjEwLCBt
b2RlOjB4Y2MxKEdGUF9LRVJORUx8R0ZQX0RNQSksIG5vZGVtYXNrPShudWxsKSxjcHVzZXQ9Lyxt
ZW1zX2FsbG93ZWQ9MC0xDQo+PiAgIC4uLg0KPj4gICBbICAgIDMuODUxODYyXSBETUE6IHByZWFs
bG9jYXRlZCAxMDI0IEtpQiBHRlBfS0VSTkVMfEdGUF9ETUEgcG9vbCBmb3IgYXRvbWljIGFsbG9j
YXRpb24NCj4+DQo+PiBJZiAnbm9rYXNscicgYm9vdCBvcHRpb24gaXMgc2V0LCB0aGUgd2Fybmlu
ZyBhbHdheXMgaGFwcGVucy4NCj4+DQo+PiBPbiB4ODYsIFpPTkVfRE1BIGlzIHNtYWxsIHpvbmUg
YXQgdGhlIGZpcnN0IDE2TUIgb2YgcGh5c2ljYWwgYWRkcmVzcw0KPj4gc3BhY2UuIFdoZW4gdGhp
cyBwcm9ibGVtIGhhcHBlbnMsIG1vc3Qgb2YgdGhhdCBzcGFjZSBzZWVtcyB0byBiZSB1c2VkDQo+
PiBieSBkZWNvbXByZXNzZWQga2VybmVsLiBUaGVyZWJ5LCB0aGVyZSBpcyBub3QgZW5vdWdoIHNw
YWNlIGF0IERNQV9aT05FDQo+PiB0byBtZWV0IHRoZSByZXF1ZXN0IG9mIERNQSBwb29sIGFsbG9j
YXRpb24uDQo+Pg0KPj4gVGhlIGNvbW1pdCAyZjc3NDY1YjA1YjEgKCJ4ODYvZWZpc3R1YjogQXZv
aWQgcGxhY2luZyB0aGUga2VybmVsIGJlbG93IExPQURfUEhZU0lDQUxfQUREUiIpDQo+PiB0cmll
ZCB0byBmaXggdGhpcyBwcm9ibGVtIGJ5IGludHJvZHVjaW5nIGxvd2VyIGJvdW5kIG9mIGFsbG9j
YXRpb24uDQo+Pg0KPj4gQnV0IHRoZSBmaXggaXMgbm90IGNvbXBsZXRlLg0KPj4NCj4+IGVmaV9y
YW5kb21fYWxsb2MoKSBhbGxvY2F0ZXMgcGFnZXMgYnkgZm9sbG93aW5nIHN0ZXBzLg0KPj4gMS4g
Q291bnQgdG90YWwgYXZhaWxhYmxlIHNsb3RzICgndG90YWxfc2xvdHMnKQ0KPj4gMi4gU2VsZWN0
IGEgc2xvdCAoJ3RhcmdldF9zbG90JykgdG8gYWxsb2NhdGUgcmFuZG9tbHkNCj4+IDMuIENhbGN1
bGF0ZSBhIHN0YXJ0aW5nIGFkZHJlc3MgKCd0YXJnZXQnKSB0byBiZSBpbmNsdWRlZCB0YXJnZXRf
c2xvdA0KPj4gNC4gQWxsb2NhdGUgcGFnZXMsIHdoaWNoIHN0YXJ0aW5nIGFkZHJlc3MgaXMgJ3Rh
cmdldCcNCj4+DQo+PiBJbiBzdGVwIDEsICdhbGxvY19taW4nIGlzIHVzZWQgdG8gb2Zmc2V0IHRo
ZSBzdGFydGluZyBhZGRyZXNzIG9mDQo+PiBtZW1vcnkgY2h1bmsuIEJ1dCBpbiBzdGVwIDMgJ2Fs
bG9jX21pbicgaXMgbm90IGNvbnNpZGVyZWQgYXQgYWxsLg0KPj4gQXMgdGhlIHJlc3VsdCwgJ3Rh
cmdldCcgY2FuIGJlIG1pc2NhbGN1bGF0ZWQgYW5kIGJlY29tZSBsb3dlcg0KPj4gdGhhbiAnYWxs
b2NfbWluJy4NCj4+DQo+PiBXaGVuIEtBU0xSIGlzIGRpc2FibGVkLCAndGFyZ2V0X3Nsb3QnIGlz
IGFsd2F5cyAwIGFuZA0KPj4gdGhlIHByb2JsZW0gaGFwcGVucyBldmVyeXRpbWUgaWYgdGhlIEVG
SSBtZW1vcnkgbWFwIG9mIHRoZSBzeXN0ZW0NCj4+IG1lZXRzIHRoZSBjb25kaXRpb24uDQo+Pg0K
Pj4gRml4IHRoaXMgcHJvYmxlbSBieSBjYWxjdWxhdGluZyAndGFyZ2V0JyBjb25zaWRlcmluZyAn
YWxsb2NfbWluJy4NCj4+DQo+PiBDYzogbGludXgtZWZpQHZnZXIua2VybmVsLm9yZw0KPj4gQ2M6
IFRvbSBFbmdsdW5kIDx0b21lbmdsdW5kMjZAZ21haWwuY29tPg0KPj4gQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4+IEZpeGVzOiAyZjc3NDY1YjA1YjEgKCJ4ODYvZWZpc3R1Yjog
QXZvaWQgcGxhY2luZyB0aGUga2VybmVsIGJlbG93IExPQURfUEhZU0lDQUxfQUREUiIpDQo+PiBT
aWduZWQtb2ZmLWJ5OiBLYXp1bWEgS29uZG8gPGthenVtYS1rb25kb0BuZWMuY29tPg0KPiANCj4g
SGVsbG8gS2F6dW1hIEtvbmRvLA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoLiBJIHdpbGwg
dGFrZSBpdCBhcyBhIGZpeC4NCj4gDQo+IFlvdSBzZW50IHRoZSBzYW1lIHBhdGNoIHR3aWNlLCBy
aWdodD8gSXMgdGhlcmUgYW55IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgdHdvPw0KDQpTb3JyeSBm
b3IgdGhlIGNvbmZ1c2lvbi4NCg0KSSBhY2NpZGVudGFsbHkgc2VuZCBzYW1lIHBhdGNoIHR3aWNl
Lg0KDQpTbywgcGxlYXNlIGlnbm9yZSB0aGUgb3RoZXIgcGF0Y2gNCndoaWNoIHdhcyBzZW50IGJ5
IG1lIG9uIEZyaSwgMjIgTWFyIDIwMjQgYXQgMTA6NDcgVVRDLg0KDQpUaGFua3MsDQpLYXp1bWEg
S29uZG8NCg0KPj4gLS0tDQo+PiAgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9yYW5kb21h
bGxvYy5jIHwgMiArLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHVi
L3JhbmRvbWFsbG9jLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL3JhbmRvbWFsbG9j
LmMNCj4+IGluZGV4IDRlOTZhODU1ZmRmNC4uN2UxODUyODU5NTUwIDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9yYW5kb21hbGxvYy5jDQo+PiArKysgYi9kcml2
ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL3JhbmRvbWFsbG9jLmMNCj4+IEBAIC0xMjAsNyArMTIw
LDcgQEAgZWZpX3N0YXR1c190IGVmaV9yYW5kb21fYWxsb2ModW5zaWduZWQgbG9uZyBzaXplLA0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+PiAgICAgICAgICAgICAgICAg
fQ0KPj4NCj4+IC0gICAgICAgICAgICAgICB0YXJnZXQgPSByb3VuZF91cChtZC0+cGh5c19hZGRy
LCBhbGlnbikgKyB0YXJnZXRfc2xvdCAqIGFsaWduOw0KPj4gKyAgICAgICAgICAgICAgIHRhcmdl
dCA9IHJvdW5kX3VwKG1heChtZC0+cGh5c19hZGRyLCBhbGxvY19taW4pLCBhbGlnbikgKyB0YXJn
ZXRfc2xvdCAqIGFsaWduOw0KPj4gICAgICAgICAgICAgICAgIHBhZ2VzID0gc2l6ZSAvIEVGSV9Q
QUdFX1NJWkU7DQo+Pg0KPj4gICAgICAgICAgICAgICAgIHN0YXR1cyA9IGVmaV9ic19jYWxsKGFs
bG9jYXRlX3BhZ2VzLCBFRklfQUxMT0NBVEVfQUREUkVTUywNCj4+IC0tDQo+PiAyLjM5LjM=

