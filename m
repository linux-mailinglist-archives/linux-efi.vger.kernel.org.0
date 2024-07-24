Return-Path: <linux-efi+bounces-1487-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968EF93B506
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 18:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40177282DB3
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E3E156967;
	Wed, 24 Jul 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ruhCDBLM"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2108.outbound.protection.outlook.com [40.92.103.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA61C696;
	Wed, 24 Jul 2024 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838663; cv=fail; b=cxD+Wo2DIwJMgnAFSSi1MZxVycshDHFHp1x09wPHxL5mPHU0wDOoHtGQ/xkmr4Hd/Qk6NqnKqpf8mOmJFABGZzPfn+zZF2y3EZsPTxSMurS88od8mT+Fbo5EXn/LxTsX4Fm3KdvvkJFgPFalFcYnt6HGk3La78JvAyfYW00Qvnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838663; c=relaxed/simple;
	bh=HL88CHGDt8TfFGZ0BuRQisgfD2AGT6f4Q8VA6Wrp4QA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CWTO5ZeNlmB1RqxjL3Q1neD9wHX/s48GZNhYboprsN21SRobr7Ms2r38+K7p+ioYM8cH46/V1HGM2Wr8LEUbi+Xph01NhxrUOnwIWE5Sr86fjKlYWhH0EA4ZYzSWer9AW2HJv4vM/tj9Ul+7hk/n/94ZsuMn0eK/korSUGPSnJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ruhCDBLM; arc=fail smtp.client-ip=40.92.103.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzy5/MJSFBIQ+ETRVs8cd1/nLwBHhs0McDqM5K1U8RSuii2FZUvHXm6mpUY/gPoiS1DG4/T31lbKsFcFAxyAgc28d8zZdZCzuO/wca2IBnmQFFBdpsWVwGiZeVEn1QrkJzP8Pc+1BfNRZoWmnF4dhXM4BFlV2ewGNNrr1Vf9hZYmIbDp8MplIlyVX8pnGJuue3hTnX/60h1tZ0eOqOfIkdkF579s/RjDY1sKjVkZ3ONPbWwUlWhkofZNksAySeYbg4x688UhSAnNZiANRDrrhLQY4mIeZzpNBR2Cek/ToZzSNv41b0AG5xi1JsjFc3e0uBBYb64BGu4t15Nq9cm6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL88CHGDt8TfFGZ0BuRQisgfD2AGT6f4Q8VA6Wrp4QA=;
 b=Jvj6yttzRG3lfIMu59urG77VHBMbd+nSHGnJhltQZtRqA0iNXXtC7FX8DMjnLOb4WqMv1KQUBTTI/Zier68OoiMIXiCkHdg2ZO98MoZShGa/DHtmmP4paY5WOHcakn/v3oQqTHrCnQMHaDZhSqmfpqS4HWy0CaAowWf4e1Elnad90t0qkF2QIIADoQqJ7ZkSoT335Lqs3UAnFJ2Ml3LcADyn25dG1I0LFuB9qRlgp17NP8ma9KldQ5u/895Zrih9g9iiPND/y3wIDDSo+2bXj/N1dSL7bZlsvde4MSMgjE4ekzIEKhJtjGb8SYOPr/JBa6v+4D8r3SezkipdtVmn/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL88CHGDt8TfFGZ0BuRQisgfD2AGT6f4Q8VA6Wrp4QA=;
 b=ruhCDBLMIVnRYnc2SiQvvUwdsmOy1BbUly4585jdgY915jcnmgCO7Ek4JwXsiAyp7QFD36B/0KvkZjNoA5Zot+LLUMYAqHlbObtcwDUB13LKyuc3M5udkwSNOlHSgIpWB5g0aq1Im8TAj5GS74n1IiCdSx2TV647wxUSCa7l3p0YxVdKXVneLb1MMTrUHVGNQTbqWhEg1cUmy6kNqGei5mZ8KXVbhvelqkpee2tJNieyXNow8ovhUZvaYQ8Wk6dWzoWjX2+JICy6Zn9GTLvt0BC0RH9kUXVHHJWqs71RWktMGJLa05460RF6Et/n8fD/CD9NpPwxlFaQzTskAHgvXA==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 MAZP287MB0502.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:cd::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Wed, 24 Jul 2024 16:30:56 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 16:30:56 +0000
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
 AQHay8BxbD/3780MxUWT4The9rzhebHiRiV0gBjw9fOAACgFAIAJQwrwgAGLugCAAAEmyYAABnCAgAAAvbs=
Date: Wed, 24 Jul 2024 16:30:56 +0000
Message-ID:
 <MA0P287MB0217724D1527969D721453C9B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZpgUVjjj3naBGtfO@wunner.de>
 <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqElRH38f_XV3fKK@wunner.de>
 <MA0P287MB0217AA8547F79B36B754A7B2B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqEroUgkB-J-JG4D@wunner.de>
In-Reply-To: <ZqEroUgkB-J-JG4D@wunner.de>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [dghka4BYUFHNz+L2H0hy2RZQbkdkjNPWdn5jZSWUXU5go5JpSCLRv61IPXYBCe3w]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|MAZP287MB0502:EE_
x-ms-office365-filtering-correlation-id: c9bf4b69-1bea-4ebc-9e2b-08dcabfdfe78
x-ms-exchange-slblob-mailprops:
 vuaKsetfIZm19wj3BccaDfPX7+VQ1E3ZfnSWZCEX3AngzyL9KOwdZkS7kYUcvamycIZE88jsDurbm/Ouf+s50aEBKkCi++bsr1Te8rM7/u9QQrp98L6tSb+e6gFIcgopuRFiL9Sd5Omr+QogBLVB0yQIPKtpU1xLM6UMmFsokzYe/zuJCNctjobadBlrm3qLN8dnRqADKs2/i9PPvsQHlMSt3mvOHZoIWhq742nCJCLW/3QyZP3jpovT7zEHbhIVkz55nIZ/tr+0cPol1zsjWg1BfGWQKYMEF4eZKD6CHj7ovka+yyBrGsYVEjh+qYWM/kBV5qp50a9be1YoA7F/hFGBeXMw8PEWhc5iAaOdEoQyuD2PtmRH/ryVMZVas7SdrMQM4m/WSyAVnQmWVS9cT92oI6OrlMrj4QZJg+URPXEfqyBpp8npO42Wzei8JO7/Oh/BsNU7cTK/j7GfA3rrTNjyf39xpX5oA77UKm4SPNu8x4f9+BhDKZhVfRnmfFwSKEFqPMT55y89Clf56bJE1Lz85JUXhjKY0Imk5Fe3nVdWE/jGTIDTib5/H/V7ACiy4jwCoMl/ojzF2SRNBHD0e4XsWEXUxxPV4jgvArpO2BkmmmpfKxrlVwkvk8tA4Rd6HcsaU1Azg2uhUtt3uOY+zKwO/K4d/EFAdvFOApjLBx0Pxguhi33hFOUvtIURyBxNzELcNGMsF3EURL53i6USyrfeyBMGNCetoxivW1zC9yLk1+HVXPZefTYGVMZZW6hmT/mmSgeI5sbmpwqiS6DoFE/++h2p76LgdXaFOFdgwINzqs+P9e/JayNVUOp7vlTm
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|461199028|4302099013|1602099012|3412199025|102099032|440099028;
x-microsoft-antispam-message-info:
 ew4B8t8+B/qak0/570pfx/NC/mDRGaoS3lz2DK0vySjLKVWrpUNPQ8oGeE/21kigdMRmzC+rTx+w8+JHJ0M0ykvoEBXE1/XD5dbNQaugdn4AJwieb8JBlVLkYXNWb1hHN4I6l16NMdJqS5EqiCoqtYoYXuyudM3d+led1Sgi3WVHSKM15o42RWVz4H0JpVMTbv0jWDuW/fuK8hiNm+6AFvJ8L76ToRRoBFkQEeWbVRtEQYOhfyeY+jRbOQQZLB3o+gCsN1bSCkvEjFirw8r7dHGpZ4FJeKZrC7Ihc085VaG5o5BtBThEerqHvrZ6VJVUMHiMCtbtIgu5F14MZ44X0Hv92gvajZKDxKMoY7KMD4gKl51XgfUCvJjtoLMgbFQQc+D717vZ/v7C7SeShKaPAnr4PScDpG/pqTaUZsQoLakk7e5T5Maj/GVpQk4B15eoYXdTgT0WnGkR4oDB0adZQvN2Z33Bsm/eMqJWhcMhPQlRnFaOWcyiNIfuU3C82vPKyvQjvWA71oPk2euoJOpuPcD0VwiT1VVaBEZ8OAoRumeR9CY30BIiWbHURApuCmU1tu8Ut4EhG23f6+wHgylDsHWUHOA5WYxo2gre0pTDsBX4H7QusbvHMF6o5+qG1ESPWoJ+/OdCqxsseEnN/rAkbwcuoeGHaD3pmr765LHtLI6QOuDT4h4aXYxtTVce4hAsA8ckUMAWKYrTaVnxiYFE6cuQjcfq6ffxJ/GtMHKxaOKld4fFRunhzVVfWREoXU33
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1BCYUJvOG40SGNCejFrTzVJVmtVK1Q3VkhIT2toMExCbzhhb0YzK1I2eEly?=
 =?utf-8?B?SlNneTBIVXc4TFpOSUdmaC9FOVJHL3pWOE1ZcFpiWUYwcDUxMGNpNFErenVX?=
 =?utf-8?B?UGppcDQ5OGtrR1hqOVpsYmJpUzRmVVJFMElLTW4rZkNNZ3VIcmNJZlNXMU82?=
 =?utf-8?B?TUYvVTM4eUphM1U1WVYyNStpT3FiVnFDZzFUamYzQWpiL25NRDRqNGxRQVk5?=
 =?utf-8?B?dm9MWWdZZUoyYm56c1hBZ1JvdEJKVWJCOHpwMUN6ZTRBMjdOYXlmSXJBRUNH?=
 =?utf-8?B?OGJWVEtLQmliUWJKaTRHQ3dTNTAyV2hpSDkzN1BzTkJFRCtvMmRsZy9Jdi83?=
 =?utf-8?B?a1d1NmZGZERjV1piZUtQS3BUaU9sSlE3MG52K0hOcEZ6b2hVYXFsV2RZWHYy?=
 =?utf-8?B?cDRyaG9tWWlGNEwvUmtoQ1FrT05ycm1qM2hnenZtTXZ4Nml2YmZaeU85eU1Q?=
 =?utf-8?B?YTBCclIwa1RpSkdnV3BjSVlZVjFkZURZVWlDRFZRaEtZWE5UT1lQd3JSdGVK?=
 =?utf-8?B?WDRycmpPNnFtdGxNZ0RQaVNnOFNDWmFxSjl2cURYc1IzZmI2ZTRvY0ljRnNn?=
 =?utf-8?B?U09TcGJWV0w3WnBmamVJZHl3bWZ1RVMyTkQyYm9Dam40aTBQNE1ObzJxdkhL?=
 =?utf-8?B?UEFiOUxleVJIMm5vdUUxd21GN0FjeGJnc2hvZUcwdWFBZnhOMDdqeDh3cGlw?=
 =?utf-8?B?bFZoYjhlOFBiZ2VLWFhpbTg5NnlEYngvTm8zdjExQXRRbjdzQ2k1QU02VXdn?=
 =?utf-8?B?USt2c203SmJVK3VsdkJPTUZYVlYzQVNldytZcm1nZkhxR0lwcVRzbmdBMlF5?=
 =?utf-8?B?dUpXREtud01DanZMUEo0M21VcmlEUGoxclVvSEg3ejh4R0dFQmtBT3NQdnNB?=
 =?utf-8?B?V05TOGsyVmczSFczL1R0SGU4czNUUEovcVRkeVpqaC9xdXlpOE5SaStpeW40?=
 =?utf-8?B?TWl5YzRhOFEvYUtEQjVHLzUzRVJrWk5ZQnpkRklnVGl1eURGRXo2dy9IeHBP?=
 =?utf-8?B?cjA4R3BoMXpOczJtd2tEVk5aZzJRQ3Y3NHFpMmpBejJObVJFZXRJNU43YVpu?=
 =?utf-8?B?VFN4ZVNadlg0K0FEMGxUVGFKNEtPb0wzcWg0NC9sdkJKVUNrT2VuSENSNXJk?=
 =?utf-8?B?RjFmd0lvN3d0Wk5WRDZ4SVphOHFsSythMG9OeDduNE5ac3Vxd2dSVzRyb2VG?=
 =?utf-8?B?amQwcDNZMFhPdVk4TU5NaThmSHFnUE41RjVKa2VDY1dieEZKdWtSblVQK0Zn?=
 =?utf-8?B?REJqQk1qdjh2N2NFQi9rUDNHSmozemlqQ0IrSjYybm9YaDlGaFRWSEZJVEQz?=
 =?utf-8?B?MlNPMHBMMFJ5UzdHd0U1cnJMa0lXa3kyVGI4WTlhZlJ1K3BFeFZIZElYVWlu?=
 =?utf-8?B?MTdCalZWYXEyUis0aDA5UCtQZUo4ZGhZMW5FZFlJZ1NOeUN4emRDVmhvVDFq?=
 =?utf-8?B?dUtod2tCZ3YwRlEzWUwrdE9OTWpQbnZlZll1VWdMRjJJZ2ZGYmtWU3RKMGhs?=
 =?utf-8?B?RjZqK0J0NEdCdng4bE9XT1lwY1hKem5FZVBVZHBFdGRrajFpODlFMllRSjN4?=
 =?utf-8?B?K0RGT0M5WWs3a3Zaajh0bEx6MU9MR3pYK0E4UFNEY21zd0JuWmQrMWs3RDdZ?=
 =?utf-8?B?cTJlR2c1QnVXVVZScm9FaVFyTE9VSE04OUM2Vk1rRkU1VWFoNFhCckxRc0dZ?=
 =?utf-8?B?WWZNRkN1RElNaGN4SWpaeHp6VVlqbG83Y0RaSXVKNWFnOVEzTzh6ZnpML2NL?=
 =?utf-8?Q?fVsbKuDCHEFFoXoZ6o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bf4b69-1bea-4ebc-9e2b-08dcabfdfe78
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 16:30:56.3631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0502

DQoNCj4gT24gMjQgSnVsIDIwMjQsIGF0IDk6NTjigK9QTSwgTHVrYXMgV3VubmVyIDxsdWthc0B3
dW5uZXIuZGU+IHdyb3RlOg0KPiANCj4g77u/T24gV2VkLCBKdWwgMjQsIDIwMjQgYXQgMDQ6MjE6
MDNQTSArMDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+PiBodHRwczovL3d3dy5waG9yb25peC5j
b20vZm9ydW1zL2ZvcnVtL3NvZnR3YXJlL2dlbmVyYWwtbGludXgtb3Blbi1zb3VyY2UvMTQ3OTE1
OC1saW51eC02LTExLWVmaS13aWxsLWZha2UtdGhhdC1pdC1zLWJvb3RpbmctYXBwbGUtbWFjb3Mt
dG8tZml4LXNvbWUtZHVhbC1ncHUtbWFjcz9wPTE0NzkyMDUjcG9zdDE0NzkyMDUNCj4+IA0KPj4g
QnkgbG9va2luZyBhdCB0aGlzIHBvc3QsIGl0IHNlZW1zIHRvIGFmZmVjdCBub24gVDIgTWFjcyBh
cyB3ZWxsLg0KPiANCj4gRGlzYWJsaW5nIGlHUFUgaWYgZEdQVSBpcyBwcmVzZW50IHdhcyBhIGJl
aGF2aW9yIHRoYXQgZXhpc3RlZCB3ZWxsDQo+IGJlZm9yZSBUMiBNYWNzLCB5ZXMuICBUaGF0IGFm
ZmVjdGVkIE1hY0Jvb2sgUHJvcyBmcm9tIEhhc3dlbGwgb253YXJkLg0KDQpJZiB5b3UgcmVhZCB0
aGUgcGVyc29uJ3MgY29tbWVudCBjYXJlZnVsbHksIGhlIGhhcyBzYWlkIGl0IGFmZmVjdGVkIHRo
ZSB0aHVuZGVyYm9sdCBlR1BVcyBhcyB3ZWxsLiBGYXQgY2hhbmNlIGhlIGlzIHVzaW5nIGEgVDIg
TWFjLCBiZWNhdXNlIEkgaGF2ZSBiZWVuIGEgcGFydCBvZiB0aGUgdDJsaW51eCBjb21tdW5pdHkg
Zm9yIGEgbG9uZyB0aW1lIGFuZCB3ZSByZWNlaXZlZCBzdWNoIGNhc2UgcmVjZW50bHkuDQoNCj4g
DQo+IEhvd2V2ZXIgdGhlIHF1ZXN0aW9uIGlzIHNpbmNlIHdoZW4gaUdQVSBpcyBkaXNhYmxlZCBp
ZiBhbiBlR1BVIGlzIHByZXNlbnQuDQo+IEkgaGFkIG5ldmVyIGhlYXJkIG9mIHRoaXMgYmVmb3Jl
LiAgSXQgd291bGQgYmUgZ29vZCB0byBoYXZlIG1vcmUgZGF0YXBvaW50cw0KPiB0byBjb21lIHVw
IHdpdGggYSBxdWlyayB0aGF0J3MgYXMgbmFycm93bHkgYXBwbGllZCBhcyBwb3NzaWJsZSB0byBh
dm9pZA0KPiByZWdyZXNzaW9ucy4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEx1a2FzDQo=

