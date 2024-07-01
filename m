Return-Path: <linux-efi+bounces-1347-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2C791DB1F
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 11:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037B7285865
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 09:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EDC84A39;
	Mon,  1 Jul 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="egDd/4jO"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2073.outbound.protection.outlook.com [40.92.103.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF99839FE;
	Mon,  1 Jul 2024 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825019; cv=fail; b=bMdf2zGoI/betmFIoZlo8OTkUiPL5UDxH9vHM2co7wpPZHYSnJojxl8DgGas0XEMS7r7/WT9C+IXstJsMJbSuYVd0gIM8OFTABuHpqpOXjcZEVPkwcUjVJrRCZBoqTgUeG94Yewywvoo7hthcobd4MZPtdRwNcMTex9hjLjfji0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825019; c=relaxed/simple;
	bh=qt6zcDdryNeLf5VTWpfgH3jbAZzo3WkKf4aBhka7z8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MrUENoQvo3J4foiC//1QaAPPgnkZh4JqGJd6mVzf3QmZW19+Xo0FC0rxDye6hvzGYToUcTP8/9dwnhPKxh0Ya4X153XhNrFO1AVMjXsBESMP70Ly2BjPkIPUZnH4xb27cxJ/5ejuDAnG8wdizOlkS4sT1cm9yKSeaR9lQ9BfvfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=egDd/4jO; arc=fail smtp.client-ip=40.92.103.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdVSMXgirWyjBQ04u/JtYyL1nOvp5HBZAxHTtZtv7xR506RpWLilbYh+MLet9hupRekqfDxW/Pe5bPPfXqViJDMWEq3iu7Otlq+iLh0fhAjtKqccXFbcpnp/8C68KgAdwG9xTities+xwKWCzeBP81LRkhmWtQy1CWNb/bZkQ/gbks5ZyV+peZBVayHIZmmxq3IQbcIZESUdiO1/1yO9ewJjb7h8ya2F4maTCcCrqDIuZs+rszOstXQC8wtWBwu9FBNwXRoQ6532borocS1FmhKsazkwpYKUfpgMHKDFnJcpdJGvRfM8rDWtdbfjTKdH+Ox30A/spiNBeXCIhaP3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qt6zcDdryNeLf5VTWpfgH3jbAZzo3WkKf4aBhka7z8w=;
 b=eDNcy7BAgb8D7x1zqFr6pvFD4GmQD2R5RtgBEu6ODoBjTiBve5Yyt+KwGiVXONA17TJz2YF06zovMDduGbaBzVedodanXAZsV0DbWmmecQwymdoxDCWZlVcZ1JQHyrz7DE8jrfSESplAmmMnMlXLq3XFGaIEz7Xb5B3axh/onm2++8xl4PyessKCQIJW56bdfZlZhrbJBg3yn7HQNJK+6VuUS4sxZ7BTr0/n/D8issZKl7gvfUGuHSt1YdT2tlwghK+c6fuSZdBmZoEQFQ41rpBS4DTmoKe8rwtrx7pRU7nBchqkExV+yaULTThW0Ulnfu4xMzjzqDIEogjhGie4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qt6zcDdryNeLf5VTWpfgH3jbAZzo3WkKf4aBhka7z8w=;
 b=egDd/4jOdPDz6/rZcN9uINUv7vlwh9e4DWN6CzNA3luR3HTpz9cOiNvoGHvmXBJC2KVZft5gYySePYsU4PtONxpY8/JgdFEDoKSfWIXMNTXcCrA4IP8NTTXxdDEERUi3TFN4ztgYEuQVChkxRSwosPNbKvFP85W9hYwtnyjZcp+dxRZdZbpsvCKxTYjwkgxJ/loRnJ1EwPcw34h/jXPo806mWGu8CuFFe26LZM7zGpz+ut4NmgAHDNeW0qIs+qmo9xkXX/AxGBGJtnu4lbm5sYF+wUx2Q4T88aEJDR++Y6oCYC8fjZxfdM2g/YmXsCdhNtYKtEkQAKEvli0MuNeoaw==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 MA0P287MB0731.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:c2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Mon, 1 Jul 2024 09:10:11 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 09:10:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Ard Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Kerem Karabay
	<kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os
 protocol
Thread-Topic: [PATCH v2] efi: libstub: add support for the apple_set_os
 protocol
Thread-Index:
 AQHayyMw+x8Tv3BlDUuYLD8zHzW0zLHhWosAgAABBwCAAANoAIAAAXYAgAAMlICAAA3UAIAAA9mAgAAB9YCAAACgEYAAApwLgAADXQCAAA9uOw==
Date: Mon, 1 Jul 2024 09:10:11 +0000
Message-ID:
 <MA0P287MB02177E3AFF8E87A152CAA743B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <ZoJAAifMqIDXdniv@wunner.de>
 <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
 <ZoJDuunseVIDua-m@wunner.de>
 <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
 <ZoJPgSlZJ3ZlU2zL@wunner.de>
 <CAMj1kXHR+mCR5eibj23S26-PN6yLPD1uf9+H2fEEDhNWOh6TjA@mail.gmail.com>
 <ZoJeVWMU8yg4CRLl@wunner.de>
 <CAMj1kXFRNrmyAtVaqHr+RWQ22+++u70eJ__brLjmJa0ocyc0Bw@mail.gmail.com>
 <MA0P287MB0217F69CBAB2D5776D4AFA43B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217751F3532CF80BA255DB3B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZoJlgkUohsIuL0_r@wunner.de>
In-Reply-To: <ZoJlgkUohsIuL0_r@wunner.de>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [Xm468YL20uIy/YeFuNSx8MVeYsPLpzRFwkEoTzYwvR5xpCvKy/nq0JBJWO+3WOZRMpsdObWUGPg=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|MA0P287MB0731:EE_
x-ms-office365-filtering-correlation-id: a64e4055-009c-4634-84e9-08dc99ad9cb2
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|440099028|4302099013|3412199025|102099032|1602099012;
x-microsoft-antispam-message-info:
 qrTAlaPpojKHDr1fnl3ywIaw7JSZ48ZX6ZPnZZmEfb8yfb20nHvpHUqYY1rwKY410+yCmQz4aoCgcdi8PtOFC7lLlALD4qOOTQlxKf8Y9S7Kj025ZtSzXcs78slVeNeCi74YqthX0+55ASaSpsisu5P20PePMUd/AsgVod3A2jHItsXPOmM/Z9XsDxQu1sOKLulQ1+bVP50XQtpCwo9OIDuw/P4Tio2laSIlIhxHwD4jCqw2FV9rIT1OxtZIJJQ88BU29s40QczsZTATOATHe7wbsas0+uzAonXJj8ahwiJ0kbXyx6AtXa2xNLVt4DWQmXtp2sxBHICF+0hNPejQJx6dSFc8yivm6IUf0xkv1Z4EVKMoInkHNTdtc0c5ilMQp+nnL13SV9+wJkHSHoTVllZav498cKd69a2s9B7HeEQGyW5aF8Mfvi9NrskiDXGlUAONnDmERC3gqW9Yd0MmAEYpcGg+F3bXzy576o6gitZ+1iYEDdRBXpEcadif1Sn/P0DL385unGAz8W6jF8wVuXO//RSRjj3lrgLsHq8AGDPM2NFzB8HgC98AZQqQQhb7Ifq/wJD3bIKZvmdSZWAHWGDbIpBeTofdujVeUEq9XTenz/we2kWuSF/PxHaSKF8+B2/FKAVcQPgnGbMkyxtRZ5oBHDPQVORihX/VBhzl+gXQwzmJ0iSLyP6fqwvj7NhyOT4lVpPcwgW+r5UtULdsEIiRHMj90lckYWmMDU9ziJ4=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bFk1b09zYldOWGE5RURwMXU1eENINitBWWZEVkJIdlJ1Q1E4RHA4NWEzNFJt?=
 =?utf-8?B?QUhTbzRXM3ZqR2wvSTYyZ2RFc2pPelpNTW1uRGE2eUNIOTJYc1NvLy9KY2Ns?=
 =?utf-8?B?OFZISW44NWFsTFFJTUNhTGZaaWZQTFVrb3c1YmhjenRHZFZGQ0wzVit3Rmx6?=
 =?utf-8?B?cENnRVNEYndUaVZwRnFqQUtlM0U0SWFiZ0FGeXVVUFJZbC8wQUo0enFYcW5Y?=
 =?utf-8?B?V2lIUTBaWDlreFg0R2J4alBuRHFZVlZpSmxtazVhNzZVdldjWHNROC9Ba3c2?=
 =?utf-8?B?UjdFRXBvSktiWlBNSFdZdkp5Q2R6cEl6SGl5QnRWUGZsc2NWQnlQR1VjVEk2?=
 =?utf-8?B?SEluSitEWVhnZFEzUUlBck1iTE90SEVzUGNVcVg0bzBxcWw1WWdBTThLcllr?=
 =?utf-8?B?SUR2QTdCY055amQ2T0xieFphUytPSE9nRER1elp4clJaaHpGVzZienZ4L0lI?=
 =?utf-8?B?Q1ZHVklERE5Ga0UzcEcvbjNHdGU0eEpNQ1hnbW01YmRlVkl1dWh1UFB5ZExO?=
 =?utf-8?B?S0VRc1dPUGFmaVQxTUhPc1AyUndGVVlEM3BMZzRpcU11TDAvRVFZVUlVcjdm?=
 =?utf-8?B?SG1iQjRUajFNbE9TUkVPZE44WE9qOFRpcHFFT1hjWmRUL05sRU16Z1IzZjhB?=
 =?utf-8?B?NXNLWXBSTHlxZ1ZBTlNyZjlRY01pcitDV3pZUjBvZkZSMU1leC9pbk5SNHEr?=
 =?utf-8?B?dlRmVTZ4bTNKQzNuNndteDA4SzYwT055UXJmZkhIZFBXU0FXTy9lTFFSZTRP?=
 =?utf-8?B?MVBQWEQ0dFZwRnlxcUZ3Ukx5ZEkwTzFtSkNTSTMvN2RsUDBsM0E3MkhSVWpo?=
 =?utf-8?B?a0RramNUNmNjRWFkRXJKZFpHblI0a0ZrdHAyb0NxRVNNcmd0eUdWbHF1elRV?=
 =?utf-8?B?VHJsdjZXSFNFY2t1NHl4OENOeFJhSysrVlR2ZmpFaEZCU3VscG9SaEtmS0ZB?=
 =?utf-8?B?Mytob2dlSERvUWN5MlFLWkJUQml3ZU02UlFFeFEraTdDT3A0NCs1dGVBUkVS?=
 =?utf-8?B?TnNZSDJWazVuR0c3NVlmN0N4bHZxSDA1NWhPRFF5dGVtazN1bnpRcENXM0FZ?=
 =?utf-8?B?aFVqQXN0emIxRFVjekJTcDV2T0pDMTFZbWt0NjczN0laazNyUFFYQ2NDc3Vq?=
 =?utf-8?B?V3FhMmJKQkVHblVjbVd3M1dHdWN0cHBvWElNVjV4WlUrNFh4SEZGSjE4Q1cv?=
 =?utf-8?B?QytmT1FTSGZPTXRsMGpId3g2aU9Ta09ZNUh3VnpadEgwSC9xeU9yTFkxVEFy?=
 =?utf-8?B?dEVXeGh4b2F3bHI3MzZPS3k3REdBNG1CKzJyVkpSZE5lSktteGs5cUpDSlJW?=
 =?utf-8?B?a1lpL0d0SnlnWEprMDllZXFUQ1NoVGk5cjdOem00OVlUOHRvbVgrYUgveEpO?=
 =?utf-8?B?c0dpeVBRZVJyTEtwRGhyOVhCKzZNb08rQjNmTWNBZm5aOWxhUnVlK0tLcFo5?=
 =?utf-8?B?WnkwWmFITlhoY2htTjQvLzZ4amdYQjMraVlKdEdVQmxWNVEvdGNobzRhdWtJ?=
 =?utf-8?B?ZGJaSGx3QXpSYVduTm9US0tmc3lIOEluOTVBU1VYbWRkamlCRFZ4TU5sVDZn?=
 =?utf-8?B?WlJUYjg0Q0FUS25iUkJHQTM3T2loMWh4RzcrUmczVmhJOWRDUjdBdko2RWV6?=
 =?utf-8?B?dGtzRzU4Yy91dXdMbTFLVm9HTW1md0pjWGFUOVNadENZUkx1VzJHSFZidk8z?=
 =?utf-8?B?b0RZbjNRZ2dZZ1VTVzNLblJCU2FmbWlvcWZKaWg4N0JTWHlDb0dGa29uOTdU?=
 =?utf-8?Q?A1cwQetb1p8zZNhVD8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a64e4055-009c-4634-84e9-08dc99ad9cb2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 09:10:11.6894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0731

DQoNCj4gT24gMSBKdWwgMjAyNCwgYXQgMTo0NeKAr1BNLCBMdWthcyBXdW5uZXIgPGx1a2FzQHd1
bm5lci5kZT4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIEp1bCAwMSwgMjAyNCBhdCAwODowMjo1
NUFNICswMDAwLCBBZGl0eWEgR2FyZyB3cm90ZToNCj4+IElJUkMsIHQyIG1hY3MgZG8gbm90IHN1
cHBvcnQgU01CSU9TLCBidXQgSSdsbCB0ZXN0IHRoaXMgYW55d2F5cy4NCj4gDQo+IEZyb20gTWFj
Qm9va1BybzE2LDEgZG1lc2c6DQo+IA0KPiBbICAgIDAuMDAwMDAwXSBlZmk6IEVGSSB2Mi40MCBi
eSBBcHBsZQ0KPiBbICAgIDAuMDAwMDAwXSBlZmk6ICBBQ1BJPTB4N2FmZmUwMDAgIEFDUEkgMi4w
PTB4N2FmZmUwMTQgIFNNQklPUz0weDdhZWQxMDAwICBTTUJJT1MgMy4wPTB4N2FlY2YwMDANCj4g
WyAgICAwLjAwMDAwMF0gc2VjdXJlYm9vdDogU2VjdXJlIGJvb3QgZGlzYWJsZWQNCj4gWyAgICAw
LjAwMDAwMF0gU01CSU9TIDMuMC4wIHByZXNlbnQuDQo+IFsgICAgMC4wMDAwMDBdIERNSTogQXBw
bGUgSW5jLiBNYWNCb29rUHJvMTYsMS9NYWMtRTEwMDgzMzFGREM5Njg2NCwgQklPUyAxMDM3Ljgw
LjUzLjAuMCAoaUJyaWRnZTogMTcuMTYuMTMwNTAuMC4wLDApIDAxLzE3LzIwMjANCj4gDQo+IFNv
dXJjZToNCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9EdW5lZGFuL21icC0yMDE2LWxpbnV4L2Js
b2IvbWFzdGVyL01hY0Jvb2tQcm8xNiUyQzEvZG1lc2cNCg0KVGhhbmtzLiBJJ3ZlIHB1dCB0aGUg
a2VybmVsIHRvIGNvbXBpbGUgYWxyZWFkeS4=

