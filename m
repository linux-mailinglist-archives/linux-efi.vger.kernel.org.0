Return-Path: <linux-efi+bounces-83-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16917F5827
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 07:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7501C20D01
	for <lists+linux-efi@lfdr.de>; Thu, 23 Nov 2023 06:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6F79DF;
	Thu, 23 Nov 2023 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="XYgfgEq0"
X-Original-To: linux-efi@vger.kernel.org
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2079.outbound.protection.outlook.com [40.107.9.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AE91B3;
	Wed, 22 Nov 2023 22:23:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoHaG7qzGGYP1Y8RMZn2/i5dUxmXQWEd0lHl/0uqdfWSM8wQqL5Lk+AbI+tXwAXOUyy+xt10Fm8R6yb+EhzeodQ+4oXFwqSjkYYNuzv2P1oVgvspf4zfkGlnmCeucBeUT4wS+dcTkhJWXRJBzAxVDKC7IkQ8k481FDvcFyaUM5fnWFihSHGVSAM17qDfArJG9WPvEEwlLziTGV6utFTkeajGdVSrtkpHZegFM+1wkCif3wvX5eK1lg5UOSJENgygXseKr40536bkn/0cjdYRFxf/SAW6ZB60zK5oSeIfsEZ0Si738c4uayLElghM0xk+bWiu127lH6EbEDJnOGGEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KiQ6cmgxv2Pj2cLmol/nfcj14XrNHYahdcKZ5Qg5k0=;
 b=VW3seC0jt60W8gXN8h43BGeMQgmzrj+F6xwZrky2jkxR/SZLV5F8yC+lEFiJXpRgWX/dZhDdXAwHUiy5HLV7UIVMdjaxoNKKiIrbdJGOq8ACXSx9NkuJtHFc6KXzILJmEByN++KKalwy6mlWG8wuBa/j3qjq/k2oM+jf+z0VVQlYlWBWqugtLeVWVdyrb+4oUG8vFPxkKKuCtLKix4AJ+v1+FlB18X4DlYIVkF01N132o7g2Ad9Z9g03/2aWKdRKgnIrOikxqIU7S91XgglP2gLAuQXPykYy+XHZWoUR1z5W8XYk8z3MmTkjFUl14d5YzhoUHT+kYbcl1OxkMPAddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KiQ6cmgxv2Pj2cLmol/nfcj14XrNHYahdcKZ5Qg5k0=;
 b=XYgfgEq0a1g79a7/dvHIlZutC1LcSLPWLYJgWjNIUSwNoULUexrZSW3rFAM1Y7ObzaFbm4wLKyIf+U7YhdnWc7tmgja8Lsb/TIMooo8DXREVEIIHJ9yXftrKv9EBD0R0A5PbuSg7DCxe+RWKSizG3UJuxAUy3l8N39SGEB8lvLonWFYlHF0IJQVdKdlWNm2Wb0buHogoiYeZObK5ljWk21HOq4MuaUwVUPNaG1ifzLEx2n/7OdZ/hfuzCofzeiAPUj8biwIJkK60mREqjGgi8pG4XhBEICz51bZK5PN/w2m2bKtlYXlJ9gZqPaEV8SneOZQ/KxOLgQEnYM0tlX8bDw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2011.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:168::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.12; Thu, 23 Nov
 2023 06:23:48 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5bfe:e2f2:6d89:8d97]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5bfe:e2f2:6d89:8d97%3]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 06:23:48 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Daniel Walker <danielwa@cisco.com>, Will Deacon <will@kernel.org>, Rob
 Herring <robh@kernel.org>, Daniel Gimpelevich
	<daniel@gimpelevich.san-francisco.ca.us>, Andrew Morton
	<akpm@linux-foundation.org>, Pratyush Brahma <quic_pbrahma@quicinc.com>,
	Tomas Mudrunka <tomas.mudrunka@gmail.com>, Sean Anderson
	<sean.anderson@seco.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 0/8] generic command line v6
Thread-Topic: [PATCH 0/8] generic command line v6
Thread-Index: AQHaE3aYyYtaflaPK0KukGb2TY1/pLCHhEwA
Date: Thu, 23 Nov 2023 06:23:47 +0000
Message-ID: <fadce169-9037-4601-93c4-b3a188dbfeec@csgroup.eu>
References: <20231110013817.2378507-1-danielwa@cisco.com>
In-Reply-To: <20231110013817.2378507-1-danielwa@cisco.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2011:EE_
x-ms-office365-filtering-correlation-id: 53573e5f-626b-4320-c3fb-08dbebecc0a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /1rA8joN5L1LGVltdFgKUc70VooJ+f1M23sGY79wL48Ze1KetWx9pKgl01BMwQ3YuzaUPd6SzGjp44XalA0biEJXXIGk+pYHylb1ZujGO589IEiX4VigkB7c2ykO7ad0Pk4bcHbg6CLd6zbEaU20bxwJz9CO+e6Q4H7tVgxx9+UaIQX74J4w+tElo6/FeyETbB06e0xXO66pai/yE3rpchOdo1t8M6uhUd6k3JEi+7QgeEix0RIAgRiDkcuGosVj1hb8DBBrc5XpfNI6PxvKq9HoL1EtI8elMkSMn1/TEM1SqsJ9DQlcw9hh3EUnRY0K5KsbuiLfBh4nOVj3tECAQOPTWCfc0Nny7x5i5EmGFgPibU74tMbsY4DHOdrD8WB6P6qq2W72d0426jFO5xOI2Elsv64xGNHIDrTSKuDl3SJTD5Hf1uhquP/oaTZXPB2RGyKjNKS+675kR531r3liCCH6lyPBgcEXflQP2LDT6jv1MBZ630Uy+NEaZoG8fDWk5M1vW2rPBQJiuQGAd9/9AoLHDdZL8TgO70O6uj6OoiDeNun2O3f6Yc2RGSeOOW/IZ8RQbAUT27Lq1NkttCY5dlz2BAblVErgXXwQmdYNgZazztSj2lu/xA1XLljG6LJHlmSldMqob4ehB2IDIEH+v/sjroTAbM/YtlrOy0dn3f33UMB51d2mWXDGGgZRfUmrbBIaNiEkqk8YMHbkOe0FUg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(921008)(38070700009)(31686004)(66946007)(66556008)(76116006)(66476007)(66446008)(64756008)(91956017)(110136005)(38100700002)(36756003)(122000001)(31696002)(86362001)(83380400001)(66574015)(26005)(6506007)(6512007)(2616005)(6486002)(2906002)(966005)(7416002)(316002)(478600001)(5660300002)(8676002)(4326008)(44832011)(71200400001)(8936002)(41300700001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkhQVEdZK3EvcWkxTEZqSFd5WnZTR0M4WXFnU0x6Mm1xbFAxUG1yTVlEZHJS?=
 =?utf-8?B?aGpUN2VZQVNXVWhYb1JOQkJGbU9Qa2lRaThTRVBWWEdhUlM1T3JjUkk2UjRL?=
 =?utf-8?B?ODNCUEdMU1k3NlpkMlM4TTFOUjdyVXl3bmJPS3A5M3NqeEw5OWJaWnlUUDdQ?=
 =?utf-8?B?azFOYXZEUDhuQVptY0pGUHJSbGtZNUNYYVZSOXQxc3FCREhIMWZNTDJGenV0?=
 =?utf-8?B?UmN5UUxibE5IRTRuTnlzU0JLRzBLYXdicTkwbkppeDZwVHdCS1VXeUM2VEVu?=
 =?utf-8?B?MmZMMDZMcGc4Rlp5anQ2eFBiVTZoa2tXL3V4YUppUm95dWFRUHBHUjdKekZQ?=
 =?utf-8?B?dzd3M3g3Ujhyd2ZSS29KYjcvYzV3Rk1ya3RId3dCenN5UVpBTTV1Qm5XNFoz?=
 =?utf-8?B?emJ5VHk3aGJpZlFiQXR5ZnVqdGRIcm5ldkVLSVdpU0gzRmpuYkVjV29pWUJq?=
 =?utf-8?B?NWFNR0ZVQjhwUUU3RlQwVjNjd1JRRy94dHpMOWZGWmxMSVZhTWxYa1p4Vko3?=
 =?utf-8?B?SEhWTHRnN1ZNTDEyRkxvL2l6Ri9iSE9XaXFkS3FSYTZxaktDanJ1T01KdWNE?=
 =?utf-8?B?YnAySUl3a3Y3TmJEdUdlcE40dVk3Mk54VWVTTHRLSVdGUjRSMmpxYnhhYmJ6?=
 =?utf-8?B?S3N4NDhuNnM1c1N6TkVwS2RkUWFkendocE9OTk0rZ0EyTmk1TDlGOWhtaC8z?=
 =?utf-8?B?bHRXQ3RoNTE0VzlaQlBXWWdUTTM4TXdWRGNmUE5RaFZIQWVYL3I5c1lJTzNa?=
 =?utf-8?B?MmpyMnNqTExSc0o5UXpta0dQdEZXa2s3TTVsZTI4RkRMV09ldlRkNHBaSVNI?=
 =?utf-8?B?RXg1ZXBpYUpxUDRueHdCOWkvS0ozazE5TlcySWUycjlDelZDZlRzUEMrQzNv?=
 =?utf-8?B?VGRta2JzaFoyTUFhL3VDN1lJcU5MaUlTZysvWGF1bEJwMjdkcHcvS1FYUlhh?=
 =?utf-8?B?RGFNZ3k3TkVlSVFzWnRzYmNlYUtVN2c0S3p1K205eVJMQ2RtUjdYUGlUZjM1?=
 =?utf-8?B?OU0ySnVxYWFZSHp6QVlpaEJtaXBndXpmZ2hmL3VZY1dKTWNhS3A4L2hMNXdX?=
 =?utf-8?B?Tng1VGhGN29HLzM1VTR5SlROYmswaU1qczFMRENLcGFCVVpRU3Vpd3B6UUk1?=
 =?utf-8?B?R2NxR1BiQ1A4Q1BocEFCbDJSejZUWTZ1VGVmVDB2TG1mZFkxVUdZWG9HUlVq?=
 =?utf-8?B?eDhSU3Z4TUtLd2JCN2NQblBSSGFWeU9UVXRsZmlKbWpYak1XQk5yVk5vclZy?=
 =?utf-8?B?Z0U5Q3RzcW5tdGNyaXZwZjAzb0R4VXVZdU02QWZ6YVZjL0Q1aUtlUGJiZVJk?=
 =?utf-8?B?VU92WEJ0V2NaTWxOTFVSQ0s3dVJZTlF2aXpwczVZRlh4OTZhQU1OSXVHb2kz?=
 =?utf-8?B?U3BYclU1QXc3ak5rdG5aQU5SWEFid09oR1VxY2E0TE5RdWgrVmZ4czVNcHVB?=
 =?utf-8?B?SWl2dStmZFFZTzlVci9jZXJuVkU3anM1YVlvUXVDQ1BrQ2gyYldobTZtMEtL?=
 =?utf-8?B?ZlNHK3AzbFBTcUl6OTJXTG5oQ3VSQlpFT3pwc3g4NWNtc3RkSGNONHMwQ1FI?=
 =?utf-8?B?OG1qZWNDK3ZvM0VvSnNjWlRyc1MrVnBYbVV4bTNmdlpDdUE0T3Y3Tkc4ZVdp?=
 =?utf-8?B?SlN0emExZUFmREhndS9rWkhNR0dIblNpV2pJZnV0Rm9pUE1YU1FpTHNhQ0gw?=
 =?utf-8?B?UkhjQUZPRHFRUUd6YU1EL0I1SFUvUnJ6UzZSeVRBcFlYWVhaQ055Rll6K0g2?=
 =?utf-8?B?RnkybkRXekYyZ2pRODRPNXZwYy9GUGkzbHIvNm9NQzNQYUtRNGRzMTY5VmZS?=
 =?utf-8?B?bEdJWG1HZk1NYVhQUjE3WEc2ZFJkWi9tbm0rd2xLczRrQjNkY2FKNjR4WDd1?=
 =?utf-8?B?V3g5M3NBZlBFRXlYYmRnN3V3OWY1eGYvb1NRL214Ui9heTdzdm1BbE5uNUQ1?=
 =?utf-8?B?QVZzc0lZT040YnVYV3V2bDhPNGpIb05zTzNsb21UcngwSmpIcXM5cUlvTDB4?=
 =?utf-8?B?d1ZHQm9CRmpsN0x0djhQUUxoeXNHWkZVNEZpUlJZb1F4WE5jVWxjempudExK?=
 =?utf-8?B?OGhKM3NvUkVWaEJZVUZyRWlyYnJHNWFmVjgza1pBKzE4SkoxcTM5blpsNHdH?=
 =?utf-8?B?V2Zib0VBczBEU2tkQ0tUbmlwU3JIVmFTWmhGWk9aaUQwQWRxYWdoWUdaeW5F?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B365FB85E196742AA10C83DF3C4031E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 53573e5f-626b-4320-c3fb-08dbebecc0a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 06:23:47.9847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0iXvoYWi7Gcq+ciE6SoIwUBSziQUi7J3I3R79/08QRH8oGNdu3q57mRHelmrWI78HFzad97UEVFiRQpHEPsQ6JUNx8E26nDqYksEIo13UXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2011

DQoNCkxlIDEwLzExLzIwMjMgw6AgMDI6MzgsIERhbmllbCBXYWxrZXIgYSDDqWNyaXTCoDoNCj4g
VGhpcyByZWxlYXNlIGlzIGFuIHVwLXJldiBvZiB0aGUgdjUgcGF0Y2hlcy4gTm8gYWRkaXRpb25h
bCBmZWF0dXJlcyBoYXZlDQo+IGJlZW4gYWRkZWQuIFNvbWUgY2hhbmdlcyB3ZXJlIG1vZGUgdG8g
ZnVuY3Rpb24gbmFtZXMgYW5kIHNvbWUgY2hhbmdlcyB0bw0KPiBLY29uZmlnIGRlcGVuZGVuY2ll
cy4gQWxzbyB1cGRhdGVkIHRoZSBjb25maWcgY29udmVyc2lvbiBmb3IgbWlwcy4NCj4gDQo+IFRo
ZXJlIGFyZSBhIG51bWJlciBvZiBwZW9wbGUgd2hvIGhhdmUgZXhwcmVzc2VkIGludGVyZXN0IGlu
IHRoZXNlDQo+IHBhdGNoZXMgZWl0aGVyIGJ5IGFza2luZyBmb3IgdGhlbSB0byBiZSBtZXJnZSBv
ciB0ZXN0aW5nIHRoZW0uIElmDQo+IHBlb3BsZSBhcmUgc28gaW5jbGluZWQgcGxlYXNlIGNvbnRp
bnVlIHRvIHJlcXVlc3QgdGhlbSB0byBiZSBtZXJnZQ0KPiBvciB0byBhc2sgdGhlIHN0YXR1cyBv
ZiB0aGUgbmV4dCByZWxlYXNlLiBJdCdzIGhlbHBmdWwgdG8gbW90aXZhdGUgbWUgdG8NCj4gcmVs
ZWFzZSB0aGVtIGFnYWluIGFuZCBmb3IgdGhlIG1haW50YWluZXJzIHRvIHNlZSB0aGUgaW50ZXJl
c3QNCj4gZ2VuZXJhdGVkLg0KDQpHb29kLCB0aGVuIGxldHMgd29yayBhbGwgdG9nZXRoZXIgYW5k
IGdldCB0aGUgYmVzdCBvZiBpdC4NCg0KWW91ciBzZXJpZXMgaGFzIGdvb2QgZmVhdHVyZXMgbGlr
ZSB0aGUgdXBkYXRlIG9mIHRoZSBjb21tYW5kIGxpbmUgYWRkb25zIA0Kd2l0aG91dCByZWJ1aWxk
LCBpbmNsdWRpbmcgdXBkYXRpbmcgb2YgdGhlIHNpZ25hdHVyZSB3aGVuIGFwcGxpY2FibGUuIA0K
SG93ZXZlciB5b3VyIHNlcmllcyBzdGlsbCBoYXMgd2Vha25lc3NlcyBpdCBoYWQgaW4gcHJldmlv
dXMgdmVyc2lvbnMuIEkgDQp3YXMgaG9wcGluZyB3ZSBjb3VsZCB3b3JrIGFsbCB0b2dldGhlciB0
byBpbXByb3ZlIGl0LCBidXQgeW91IGhhdmUgYmVlbiANCnJlcGVhdGVkbHkgdGVsbGluZyB0aGF0
IG15IHByb3Bvc2FsIGRvZXNuJ3QgZml0IHlvdXIgbmVlZHMgd2l0aG91dCANCmV4cGxhaW5pbmcg
d2h5LiBDYW4gd2Ugd29yayBpbiBhIG1vcmUgd2luLXdpbiBzcGlyaXQgdGhpcyB0aW1lID8NCg0K
QnkgdGhlIHdheSwgZm9yIHRoZSByZWNvcmQsIGhlcmUgaXMgYSBsaW5rIHRvIGEgc2VyaWVzIEkg
c2VudCBvdXQgYXMgYW4gDQpleGVtcGxlIG9mIHdoYXQgaXQgY291bGQgbG9vayBsaWtlLiBUaGUg
aW50ZW50aW9uIGF0IHRoYXQgdGltZSB3YXMgbm90IA0KdG8gaGF2ZSBhIGNvbmN1cnJlbnQgc2Vy
aWVzLCBidXQganVzdCB0byBzaG93IHdoYXQgSSBtZWFudCBpbiBteSANCmNvbW1lbnRzLCBiZWNh
dXNlIGV4ZW1wbGVzIGFyZSBvZnRlbiBtb3JlIGV4cGxpY2l0IHRoYW4gd29yZHMuIFRoYXQgDQpz
ZXJpZXMgd2FzIGNvbnNpZGVyZWQgbW9yZSBtYXR1cmUgYW5kIGNsb3NlciB0byBhIG1lcmdlYWJs
ZSBzdGF0ZSB0aGFuIA0KeW91cnMgYXQgdGhhdCB0aW1lLiBMaW5rIHRvIHRoZSBzYWlkIHNlcmll
czogDQpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXhwcGMtZGV2L2xp
c3QvP3N0YXRlPSomc2VyaWVzPTIzNzE1OA0KDQpZb3VyIHNlcmllcyBvbmx5IGNvbnZlcnRzIGEg
ZmV3IGFyY2hpdGVjdHVyZXMsIGFuZCBJIGNhbid0IHNlZSBhbnkgDQpkZW1vbnN0cmF0aW9uIHRo
YXQgaXQgd2lsbCBiZSBwb3NzaWJsZSB0byBjb252ZXJ0IG90aGVyIGFyY2hpdGVjdHVyZXMgYXMg
DQphIGZvbGxvdy11cCB3aXRob3V0IHRvbyBtdWNoIHBhaW4uDQoNCj4gDQo+IFRoZXNlIHBhdGNo
ZXMgaGF2ZSBiZWVuIHVzZWQgYnkgQ2lzY28gU3lzdGVtcywgSW5jLiBvbiBtaWxsaW9ucyBvZg0K
PiByZWxlYXNlZCBwcm9kdWN0cyB0byBncmVhdCBlZmZlY3QuIEhvcGVmdWxseSB0aGV5IGNhbiBi
ZSB1c2VkIGJ5IHRoZQ0KPiBlbnRpcmUgTGludXggZWNvIHN5c3RlbS4NCg0KVGhpcyBpcyBub3Qg
YW4gYXJndW1lbnQuIEJpbGxpb25zIG9mIGNvbXB1dGVycyBhcmUgcnVubmluZyBNaWNyKnMqZnQg
DQpXaW5kb3dzLCBkb2VzIGl0IG1ha2UgV2luZG93cyBiZXR0ZXIgPyBEbyBJQk0gb3IgR29vZ2xl
IGNsYWltIGFib3V0IHRoZSANCm1pbGxpb24gZXF1aXBtZW50IHRoZXkgYXJlIHNlbmRpbmcgb3V0
IHdpdGggc3BlY2lhbCBMaW51eCBmZWF0dXJlcyA/IA0KU2hvd2luZyBvYmplY3RpdmVseSB3aGF0
J3MgdGhlIGJlbmVmaXQgb2YgeW91ciBmZWF0dXJlcyB3aXRob3V0IA0KcmVmZXJyaW5nIHRvIENp
c2NvIHdvdWxkIGJlIGJldHRlci4NCg0KPiANCj4gTXkgYXBvbG9naWVzIG9uIHRoZSBsZW5ndGgg
YmV0d2VlbiByZWxlYXNlcy4gSSB3aWxsIHRyeSB0byByZWxlYXNlIG1vcmUNCj4gb2Z0ZW4uDQoN
CkNocmlzdG9waGUNCg0KPiANCj4gDQo+IERhbmllbCBXYWxrZXIgKDgpOg0KPiAgICBDTURMSU5F
OiBhZGQgZ2VuZXJpYyBidWlsdGluIGNvbW1hbmQgbGluZQ0KPiAgICBzY3JpcHRzOiBpbnNlcnQt
c3lzLWNlcnQ6IGFkZCBjb21tYW5kIGxpbmUgaW5zZXJ0IGNhcGFiaWxpdHkNCj4gICAgc2NyaXB0
czogaW5zZXJ0LXN5cy1jZXJ0OiBjaGFuZ2UgbmFtZSB0byBpbnNlcnQtc3ltYm9sDQo+ICAgIENN
RExJTkU6IG1pcHM6IGNvbnZlcnQgdG8gZ2VuZXJpYyBidWlsdGluIGNvbW1hbmQgbGluZQ0KPiAg
ICBkcml2ZXJzOiBmaXJtd2FyZTogZWZpOiBsaWJzdHViOiBlbmFibGUgZ2VuZXJpYyBjb21tYW5k
bGluZQ0KPiAgICBDTURMSU5FOiB4ODY6IGNvbnZlcnQgdG8gZ2VuZXJpYyBidWlsdGluIGNvbW1h
bmQgbGluZQ0KPiAgICBvZjogcmVwbGFjZSBjb21tYW5kIGxpbmUgaGFuZGxpbmcNCj4gICAgQ01E
TElORTogYXJtNjQ6IGNvbnZlcnQgdG8gZ2VuZXJpYyBidWlsdGluIGNvbW1hbmQgbGluZQ0KPiAN
Cj4gICBhcmNoL2FybTY0L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzMg
Ky0tDQo+ICAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9zZXR1cC5oICAgICAgICAgICAgICAgIHwg
ICA0ICsNCj4gICBhcmNoL2FybTY0L2luY2x1ZGUvdWFwaS9hc20vc2V0dXAuaCAgICAgICAgICAg
fCAgIDIgKw0KPiAgIGFyY2gvYXJtNjQva2VybmVsL2lkcmVnLW92ZXJyaWRlLmMgICAgICAgICAg
ICB8ICAgOSArLQ0KPiAgIGFyY2gvYXJtNjQva2VybmVsL3BpL2thc2xyX2Vhcmx5LmMgICAgICAg
ICAgICB8ICAxNCArLQ0KPiAgIGFyY2gvbWlwcy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgNCArLQ0KPiAgIGFyY2gvbWlwcy9LY29uZmlnLmRlYnVnICAgICAgICAgICAg
ICAgICAgICAgICB8ICA0NCAtLS0tDQo+ICAgYXJjaC9taXBzL2NvbmZpZ3MvYXI3X2RlZmNvbmZp
ZyAgICAgICAgICAgICAgIHwgIDEyICstDQo+ICAgYXJjaC9taXBzL2NvbmZpZ3MvYmNtNDd4eF9k
ZWZjb25maWcgICAgICAgICAgIHwgIDEwICstDQo+ICAgYXJjaC9taXBzL2NvbmZpZ3MvYmNtNjN4
eF9kZWZjb25maWcgICAgICAgICAgIHwgIDIxICstDQo+ICAgYXJjaC9taXBzL2NvbmZpZ3MvYm1p
cHNfYmVfZGVmY29uZmlnICAgICAgICAgIHwgIDE3ICstDQo+ICAgYXJjaC9taXBzL2NvbmZpZ3Mv
Ym1pcHNfc3RiX2RlZmNvbmZpZyAgICAgICAgIHwgMTM5ICsrKystLS0tLS0NCj4gICBhcmNoL21p
cHMvY29uZmlncy9jaTIwX2RlZmNvbmZpZyAgICAgICAgICAgICAgfCAgIDggKy0NCj4gICBhcmNo
L21pcHMvY29uZmlncy9jdTEwMDAtbmVvX2RlZmNvbmZpZyAgICAgICAgfCAgMTkgKy0NCj4gICBh
cmNoL21pcHMvY29uZmlncy9jdTE4MzAtbmVvX2RlZmNvbmZpZyAgICAgICAgfCAgMTkgKy0NCj4g
ICBhcmNoL21pcHMvY29uZmlncy9nZW5lcmljX2RlZmNvbmZpZyAgICAgICAgICAgfCAgMTUgKy0N
Cj4gICBhcmNoL21pcHMvY29uZmlncy9ncHJfZGVmY29uZmlnICAgICAgICAgICAgICAgfCAgMzMg
Ky0tDQo+ICAgYXJjaC9taXBzL2NvbmZpZ3MvbG9vbmdzb24zX2RlZmNvbmZpZyAgICAgICAgIHwg
IDI5ICstLQ0KPiAgIGFyY2gvbWlwcy9pbmNsdWRlL2FzbS9zZXR1cC5oICAgICAgICAgICAgICAg
ICB8ICAgMiArDQo+ICAgYXJjaC9taXBzL2tlcm5lbC9yZWxvY2F0ZS5jICAgICAgICAgICAgICAg
ICAgIHwgIDE3ICstDQo+ICAgYXJjaC9taXBzL2tlcm5lbC9zZXR1cC5jICAgICAgICAgICAgICAg
ICAgICAgIHwgIDM2ICstLQ0KPiAgIGFyY2gvbWlwcy9waWMzMi9waWMzMm16ZGEvZWFybHlfY29u
c29sZS5jICAgICB8ICAgMiArLQ0KPiAgIGFyY2gvbWlwcy9waWMzMi9waWMzMm16ZGEvaW5pdC5j
ICAgICAgICAgICAgICB8ICAgMyArLQ0KPiAgIGFyY2gveDg2L0tjb25maWcgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICA0NCArLS0tDQo+ICAgYXJjaC94ODYva2VybmVsL3NldHVwLmMg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDE4ICstDQo+ICAgLi4uL2Zpcm13YXJlL2VmaS9saWJz
dHViL2VmaS1zdHViLWhlbHBlci5jICAgIHwgIDI5ICsrKw0KPiAgIGRyaXZlcnMvZmlybXdhcmUv
ZWZpL2xpYnN0dWIvZWZpLXN0dWIuYyAgICAgICB8ICAgOSArDQo+ICAgZHJpdmVycy9maXJtd2Fy
ZS9lZmkvbGlic3R1Yi9lZmlzdHViLmggICAgICAgIHwgICAxICsNCj4gICBkcml2ZXJzL2Zpcm13
YXJlL2VmaS9saWJzdHViL3g4Ni1zdHViLmMgICAgICAgfCAgMTQgKy0NCj4gICBkcml2ZXJzL29m
L2ZkdC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjIgKy0NCj4gICBpbmNsdWRl
L2xpbnV4L2NtZGxpbmUuaCAgICAgICAgICAgICAgICAgICAgICAgfCAxMzcgKysrKysrKysrKw0K
PiAgIGluaXQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA3OSAr
KysrKysNCj4gICBsaWIvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDQgKw0KPiAgIGxpYi9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgMyArDQo+ICAgbGliL2dlbmVyaWNfY21kbGluZS5TICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDUzICsrKysNCj4gICBsaWIvdGVzdF9jbWRsaW5lMS5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAxMzkgKysrKysrKysrKw0KPiAgIHNjcmlwdHMvTWFrZWZpbGUgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiAgIC4uLi97aW5zZXJ0LXN5cy1jZXJ0LmMg
PT4gaW5zZXJ0LXN5bWJvbC5jfSAgICB8IDI0MyArKysrKysrKysrKystLS0tLS0NCj4gICAzOCBm
aWxlcyBjaGFuZ2VkLCA4MDcgaW5zZXJ0aW9ucygrKSwgNDgyIGRlbGV0aW9ucygtKQ0KPiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L2NtZGxpbmUuaA0KPiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBsaWIvZ2VuZXJpY19jbWRsaW5lLlMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgbGli
L3Rlc3RfY21kbGluZTEuYw0KPiAgIHJlbmFtZSBzY3JpcHRzL3tpbnNlcnQtc3lzLWNlcnQuYyA9
PiBpbnNlcnQtc3ltYm9sLmN9ICg3MiUpDQo+IA0K

