Return-Path: <linux-efi+bounces-1489-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8782693B525
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 18:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C242832B0
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A6B15ECF2;
	Wed, 24 Jul 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="dKteoPIL"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2084.outbound.protection.outlook.com [40.92.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7713F219E0;
	Wed, 24 Jul 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838849; cv=fail; b=YvACb+nsbsqzjoISpkkTX31lt6jkaDXF3+QMKpRYL7uQMzfxmCIlhyEAe8cdfhCKefzwucGGqMk3XJtD1NRCLmL/Nsaql9I1/80pIlRPoCKxJYuA7wUb41NSwx18dI/8l+Le9VvI1wJalXBqbvjGoykd7Zswf20XE/+95a9x0IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838849; c=relaxed/simple;
	bh=Ty0SFygZj0vhtS0DZ/R9JcHsF7hnRtTtAoa2ld43bD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YY2W0NscUYmU1kC+5aCqRzKFE0ANgUpY41AgPD29bIrsXGfZxGbgVvF68twm7+o3hLiuY43eZmlSSdf5bt1OrsLwJfpvzR8vauPBMwo93moORAO38ztItQkLkStytKBQIX6Sj0P/OPysiWfFzzP9t5CYtLvBOpNnBddWfaviTrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=dKteoPIL; arc=fail smtp.client-ip=40.92.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXV9QDx/vsvOr2EKEoEl4oQO366HJKgnsBbZZ7WkmMRkP4a9zLxwtBJqHl2oHYfHeDs2hDRU5fbUiKVdHHvaLmqb9JFe6iOzCnHMMUCi2olgu8JlVgEHB+oqQVpTPCCcJSnb85qJYvuoD4TXKwwq6KjkUnO/qb1kLbyeqz94Dbtisr4g/fEdAbf/p6qJNvhAcYgKIkffgHMhrqkD4FexmW2NyuzJXWDCE8waYQ2FoNMXcdHcC4BI/UG1+egcLjnMr9wnkesPGmj9aMfjXAZIaLlSEq5tmAPe9JrtRTsHp8JadyiawtrRJCTAuBspSiDJA5BGLgmYNGobQxtEtJUUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty0SFygZj0vhtS0DZ/R9JcHsF7hnRtTtAoa2ld43bD8=;
 b=jegnEOZJDZV14OPwD+6r/u5g6Q2SnZDNFcHvGOW5B//yCYvKPCkLJ0xFcYd/qa95LQXD1wMWcbxGkiO/4gSRCKt6GIOtPReuQpXPSQc/HahoZebKlqgrRNRy1Dm2vsd7PDUN7ObE2MzRCF2YllHmA/SC+I41Yo8JbubCJP/8QwxwN87rqfDjtwXAKMZTuKVWmDMDD2HvFZQkZjD3svcFMCBd6i5XQSe96QDY2Ztc+lnjY+TWIhB4butKeej4ZMNNq79A+3HzmnFcZtHI0JuXEvtlrYNjyPNCWTDga4Vdms6YJzQNYXjMTAsseZHZcReaxNog5ph6xVDevlHrZO76Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty0SFygZj0vhtS0DZ/R9JcHsF7hnRtTtAoa2ld43bD8=;
 b=dKteoPILbKeOOvO7ClObw8P6qb6Tl0vibEbRLASS9lkmh3OCyEX/MLho98JOUwsMnk0+ecvbEQl2hPoABVy0P8Ogrji652kxPKoH/kxld5bgIf+idcsjN8RTupZAFzjjBLwfhWFjVIs58k64bXK5/DgP3myfTveEn2L3QZ9Ev2wVOCLnU4efksuIDsWkyhzvDCu2ySXBWwIW4txeBs8uoo6zFnoHCPmnSFqKAZx0eeRGcEPL0X5oc52eODYPiqKlvvZfa0P6fV29qf+pQ71QdRvRVW8E0ngl+/adc+wQjCI7Ynp2oxrC3wXQJJsX716Ulxip492DiHhOtv9u1qnV+A==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN0P287MB1670.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:188::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.18; Wed, 24 Jul 2024 16:34:02 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 16:34:02 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Ard Biesheuvel <ardb@kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Kerem
 Karabay <kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>,
	"sharpenedblade@proton.me" <sharpenedblade@proton.me>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Topic: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Index:
 AQHay8BxbD/3780MxUWT4The9rzhebHiRiV0gBjw9fOAACgFAIAJQwrwgAGLugCAAAc4MYAAAVwAgAAAnWw=
Date: Wed, 24 Jul 2024 16:34:02 +0000
Message-ID:
 <MA0P287MB0217753D93980EB617739103B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZpgUVjjj3naBGtfO@wunner.de>
 <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqElRH38f_XV3fKK@wunner.de>
 <MA0P287MB021789D73CAD62C16BCF0306B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqEsdkVvwsq-CgeB@wunner.de>
In-Reply-To: <ZqEsdkVvwsq-CgeB@wunner.de>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [JfXUvZqX0ZIyYnWCcISEmAXL5IdJgTd7+g/aWdYFxoNjkJk+hiCHZk1EkOJ1S9wAHbExb+BtFUk=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN0P287MB1670:EE_
x-ms-office365-filtering-correlation-id: d4953dcd-305e-413e-8536-08dcabfe6d51
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrORrPiYp+O3K2PHowtbVet0mAQ3fDL0YUCaMT4rMjKMbcZaGnuvOQVzpSo2imB8jJbt66QvyJP1DL2JX6M6L0ERW7l8AbwBgPfOXPu3SPm8iJcVaOVMA2EZj1pQBmAkufg2xo7H9AVw1cbP01FubhHeRLqk8g3QzGWbbP+I0qesHC3fnDYS6sNe7yyTyXTmc5pcyeMyIbSBI86nkoy2UP/Yizisx7tP0vnJAqTIsunHO0rrolffWNSb47J9L1tBjjYg7N/DBq39mHKHKltX9pMewtieBrZ1PLqtv82WUxJrkqJuiuY7DPKNvbk+1oCqlPn7KbfohtxUhYd4vgELV4ctqCjn5YSV10TlYkxVK4FuRTpDwv1LvpsnX+b/bqfeLUICelnuxREDueXnuZA2A9YEaZiiNfrP+MjJXjgX6wEmMAEGNyRCieldPzsbcPCj+GdKupGFjFkEQyRYwm+8L6MWE2vwU3+uViYGi9Pljw2Qqu8xFpjU//gk2pdG6/daPFyGAskZXCRtRIg16zVCABUlA62kzfd3RyysYq89DHxkdnvyw7FybZGiKicCMDxkvIH/jSUTo29TuaKGdaYQoGpnyRZEyrTIx+EzGZ5gCnxKxIXutMyrnZwx2GhlS+X62DzFkVNAFPFRruugglJpwei2XwEdnwpRWdoj1aNdwuRTn4Y2GrhF7+cHxMVo8DEE4ChrqX6PfaHbVzVSenLJV8ILBk2d4/6CRsQN5jS6HvVHfZMwWlOEEdwWgoqoBvWZlgw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|19110799003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 YU19dWnG1DPNy9v4UudeAEAVLRxYM15q5a5Xz3jfspHupUO8nUxeHe1YP4vmrMcrwNobJmtW5t8USMsIWHVLIlmtfHQBCuRy7M3kMLleOaRdMthMWXeJbsSE8ZWS/AlJ4OWM6rUI9sHu0mlJbIyoPWBXuYx60nAmciKa84czwfM4hriNy7QVnMt6osRVgDAhh9Haoqn4UFbWiF/F8L0I5nORFEa8EscCt1SuXGErNdkxKzesPH8WsPjL2F3i+uuHvkqdvZeqwxUUouRfRglsP10+g/lO3PoPGNyVJBFwgiz01e7F+rCo1xbCPEchpMHf+/Z7P33l/t9J7ozFSNdHGl5gBcacenLCqog2w9s2kf/TMowtC6c/2vDv7E+fd2QajbfRbxZP0XKd36yWgITerC9T1fWauqq94seNg0//xzhs8iitAfhscQshoJTYyRHb1IpZx0GFLhggISy5R/KlU4Cl75yGeeohYr5aM1iUW8Vz95UfbfCe+wVIUEpDKDlopbDx4YLT/Nu2qy9BRTcvK5QqvB1yxKtzVWvyiKHl/RRHlEMPOOzZlm+tP/mSAue7nOx1PjJbiU2PWFxTh0Yj1XMDq1aLGr7CD5NvDTvk1Fko+oelmZjoQpEj505WHNBmLR3fg/i1ykm/mqWKnUl9zg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SS9FMGtzcm44NnBGbk1yMmVRc0RmWDZEaS9zUFRQakdNZDRrVStOZzRsWFZR?=
 =?utf-8?B?MkF2L3JDY04vam5rMVdWTlZjUStocFlTTk52YzdFZ1NjRTJ5YmxkNlNRSVVq?=
 =?utf-8?B?L0lWaU1NODk5TUdTTEFTZEoyejhxd1AxM1dtVitNUjFya0d3WlJ1c0xnNFhJ?=
 =?utf-8?B?dE9OV0gxY3lhK0xzNmFHVkpjMDI3MUEzNDRUMWw4Z0NrckRpNGxUVHNneExF?=
 =?utf-8?B?cDl0MHNTUTJGd2FDVU52Sko5RTNpMkM3SmF5V1NXemdaS3BzQmFld3pPYkhx?=
 =?utf-8?B?bkpaelJBRFZyaTlLRHJmZEh2VUN0MVpVaHcrWjlIOXdwVU1EU2ZQdE1EWmNV?=
 =?utf-8?B?MFlFRHpNN29BVWVObkZwODRGU3VlWUxiVEc5UlRCaHlEazQ3VU1GU3JZYzFI?=
 =?utf-8?B?c21EaC9CL0lSalJTWHBlZmkzTlVDcFBMU0RwZWZJd2JlOXdQeERWNHJyZXlZ?=
 =?utf-8?B?azFMMFcxNSszczRSSjdEci9xQU9ERUltNDdwSmFhNm1MblRKS1NrZ1hGTHpP?=
 =?utf-8?B?YmU5YjR6b3JlWmRBbElGbndWRWhXZkNXVXJhUWNGVE56VWJsTUI4Smc2MklG?=
 =?utf-8?B?cGUycTJFeW40RFdvdW9UaWV0eTdxVGoybDJYcnltU00yTjVqR0hnOGFCWk1z?=
 =?utf-8?B?NGUwMDhQaEhtYTR5S1JzNEUxcHgvSUo4TFhzdjBMVHEvSmorVktQTytXWXpJ?=
 =?utf-8?B?UXBVS3E4VjhMN2dxZkFibzRwYkZWTlJXekQ3OFl4bVRkL2w3QWZyWWZGU3E5?=
 =?utf-8?B?S0ZjR2srcWw2UmJ0RkowUEE2cSswNFluYm1RT1J4ZUpQTk4weGpmUjl5WmhP?=
 =?utf-8?B?Sm9xSk9pU2Nsb1Y0czZvcTlOVTg5MlVyYU1PNTNrRWR0elk4MWp5N1NwSUov?=
 =?utf-8?B?STd0ZlVYSzhUZWdpd2dOaHVaR0lNRFk4bjRSajFPNW1Na0xNSnQ5bThDUXF5?=
 =?utf-8?B?RUoxRmpMbmorU1VFblFqT21NVVBSQTNnMGpqejZ6NlBSekZXUis4Zzk2YmI1?=
 =?utf-8?B?cWtHNzgzOElYYk9aekxmbkZkMG9ENHF4eFR1cmVKSWQ1TFB0UXlZSmRaaDlW?=
 =?utf-8?B?NW1ERjBUVjIxUjhZTS83Y0Jic0RwWFdPd2pCdTR3N0JRMkhOaDJWMXY0cDVs?=
 =?utf-8?B?M1JWcTE4UURTNHZkVlYzSVduOVd4b1BjUFVxeUZnKzlIWURyTVQzUUxmV3U3?=
 =?utf-8?B?Y3I2b0dleWcvMXByZFNUWXQvTjJTZG1IbEpkM2JoTTV2ajZKRkMydG5qeDcw?=
 =?utf-8?B?b3QxMFc0MmNoclRzcFZlUkZPSlhCajZQZnRncHpJNWtON0Jvc2puSVZNUFp3?=
 =?utf-8?B?OERvc3VTMmkwYjNIU2ZOMXgyVkxjWisvRE9jUmZrNlRaUkVIMzBab1ZGZXZG?=
 =?utf-8?B?NmM0Z2dxUkJURGcxOWlqTTlmR3Jrc0prUmhJVkF6ZmhiVFAycnllSXM0d01T?=
 =?utf-8?B?emRyWjlEWjZpRnU4R3U4L3NDT25oSVhySG1kSWI2c3dyblpyS005NVNUSEdS?=
 =?utf-8?B?NWdMNXJYbXNXc2pXR1YwaWVucDRXc2d6VmpveDIzY2F4OVlrOVN3bUMreGww?=
 =?utf-8?B?cGVqSk1LZGpBTzZOUjZzMVA0bXcvaWJWbG5OVkQ0ODA5NHgzL3I0NENUQnhJ?=
 =?utf-8?B?YjcwMFpKN1k3VVVLaGFmNjdFS1RSeUhEcEQydzd0em9WVkliekRCbnZPSW44?=
 =?utf-8?B?UlJkRGNuRU52V0VIWFFiN09rWFUxM0RaZC9QVkhGL3JMY0J1MS9zOFduMHIz?=
 =?utf-8?Q?BkVEruJw+cU8dtK6l4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-24072.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d4953dcd-305e-413e-8536-08dcabfe6d51
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 16:34:02.3447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1670

DQoNCj4gT24gMjQgSnVsIDIwMjQsIGF0IDEwOjAx4oCvUE0sIEx1a2FzIFd1bm5lciA8bHVrYXNA
d3VubmVyLmRlPiB3cm90ZToNCj4gDQo+IO+7v09uIFdlZCwgSnVsIDI0LCAyMDI0IGF0IDA0OjI2
OjU4UE0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+PiBPbiAyNCBKdWwgMjAyNCwgYXQg
OTozMSBQTSwgTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+IHdyb3RlOg0KPj4+IEkgbm90
ZSB0aGF0IG9uIHg4NiwgdGhlIGVmaXN0dWIgd2Fsa3Mgb3ZlciBhbGwgUENJIGRldmljZXMgaW4g
dGhlIHN5c3RlbQ0KPj4+IChzZWUgc2V0dXBfZWZpX3BjaSgpIGluIGRyaXZlcnMvZmlybXdhcmUv
ZWZpL2xpYnN0dWIveDg2LXN0dWIuYykgYW5kDQo+Pj4gcmV0cmlldmVzIHRoZSBEZXZpY2UgSUQg
YW5kIFZlbmRvciBJRC4gIFdlIGNvdWxkIGFkZGl0aW9uYWxseSByZXRyaWV2ZQ0KPj4+IHRoZSBD
bGFzcyBDb2RlIGFuZCBjb3VudCB0aGUgbnVtYmVyIG9mIEdQVXMgaW4gdGhlIHN5c3RlbSBieSBj
aGVja2luZw0KPj4+IHdoZXRoZXIgdGhlIENsYXNzIENvZGUgbWF0Y2hlcyBQQ0lfQkFTRV9DTEFT
U19ESVNQTEFZLiAgSWYgdGhlcmUncw0KPj4+IGF0IGxlYXN0IDIgR1BVcyBpbiB0aGUgc3lzdGVt
LCBpbnZva2UgYXBwbGVfc2V0X29zLg0KPj4gDQo+PiBUaGlzIGFsc28gbG9va3MgbGlrZSBhIGdv
b2QgaWRlYSwgYnV0IEknbSBub3Qgd2VsbCBhd2FyZSBvZiB0aGUgcGNpDQo+PiBxdWlya3MgaW4g
dGhlIExpbnV4IGtlcm5lbC4gU28sIHdvdWxkIGNvbnNpZGVyIGl0IGEgYnVnIHJlcG9ydCBmb3IN
Cj4+IHRoZSBtYWludGFpbmVycyB0byBmaXguDQo+IA0KPiBUaGlzIGlzIG5vdCBhIFBDSSBxdWly
ayBpbiB0aGUga2VybmVsLiAgVGhlIGVmaXN0dWIgaXMgYSBzZXBhcmF0ZQ0KPiBwcm9ncmFtLiAg
SSdtIHNheWluZyB0aGF0IHRoZSBlZmlzdHViIGFscmVhZHkgd2Fsa3Mgb3ZlciBhbGwgUENJIGRl
dmljZXMsDQo+IGl0IHdvdWxkIGJlIHRyaXZpYWwgdG8gaG9vayBpbnRvIHRoaXMgdG8gY291bnQg
R1BVcywgcmVjb2duaXplIHRoZSBUMg0KPiBkZXZpY2Ugb3IgZG8gc29tZXRoaW5nIGVsc2UgZW50
aXJlbHkuDQo+IA0KDQpJJ2xsIGxlYXZlIHRoaXMgdG8gQXJkLiBJJ20gcmVhbGx5IGNvbmZ1c2Vk
IGluIGNob29zaW5nIHRoZSBiZXN0IHBvc3NpYmxlIG9wdGlvbiBoZXJlLg0KDQo+IFRoYW5rcywN
Cj4gDQo+IEx1a2FzDQo=

