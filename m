Return-Path: <linux-efi+bounces-1510-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FCD93EED6
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jul 2024 09:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9A01C20AF9
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jul 2024 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA96B85654;
	Mon, 29 Jul 2024 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="daH510wY"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2027.outbound.protection.outlook.com [40.92.103.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A676F30E;
	Mon, 29 Jul 2024 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239187; cv=fail; b=tAVdv/Et+Fo3BCTX6NxIHB4FEPFAqwvi2WtJD5aEcYiuf1S4ceU4fXt+3T/7U6DTJHTV7k55feN8p65NYAkd+loN1f0EH56CSjxVP2ocp2vuZakybcPUkxTQZvcrZOTGVVf1bB2LgRtRxxCPVXbtqEg/vAtw+8NSZtA+2EYLdnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239187; c=relaxed/simple;
	bh=6iGgBH7hQ3YpCiL/wiE3zaMzQH2a7MAFmPZ5a5oeWU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dm5/fyAmnwSDuluzBc0lD5mi7Prx068n7F+9zkxZ0Asv8qy8aFEUivM9oaF3ia7ailggh5yWtuljvZhgHVvfyky27gt4+dDAdQWbbJ8hhNLWPe5rQ1EsLDH6EScKG6BOaP2myuc7z85VOJyyHA2Qm/x4Utz3xOemuPV29xDjmb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=daH510wY; arc=fail smtp.client-ip=40.92.103.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5kQrWGvEwcvwryOx6e2Ip4TfbfxIBjkR+x/Qvzv/6Kqe0fgs6evwt2pc8vx+Obsf/XWC5ivQ1sr9w4XoKGI/Tsj7ZDUjZE9lTXRLKqcfeaGV0avAsmPv8af8JWpjZL6GivpC10ojS7MDdmEd7x8MDqLfmf9RU2KIyque+Qbb3lXdQFZNnfM0jFqJQvMDKZKjY2hvVID5ZVPrhwngpKc+y3XwE9t48gu/vi8OBYk5+ycGkJefQ4wtIEFStCW9QE9ZccF7OsutYlAC10ygv9AGExhBEjD3VgPjbdFFalhW5fEL01W5wKnWAR+RsNLMqwCXXj0ftezpLqHQDef+yzZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iGgBH7hQ3YpCiL/wiE3zaMzQH2a7MAFmPZ5a5oeWU4=;
 b=JGZ7ZBdhkyYcZ0HSfyW9syUPMp/K9fNPvXKAkrDTwrqsrZcf/JAhlK9uQ/W2fEjIIXZAJUPvPoljMRruFdXRaW3yqfuwO8mV5ylsJBM6XU6NfOW6PKZOj1sNJRsK8/gQXbU4aoyBe00mLTYMAmxlFVUyVN9G7LhUd1tB6U9qQ7MfWYciDTmaXktf42/vau1KodpxG7c76uVyXXrR4/wT2UjCF7SnryLT82Q9aSvol9tfJxlvmB1UOj42mj0jFF1zOIfBce1bkHhZVqWBsqJQUhsIE2LJVK1pcoqdL79It0dUXEnbkQ7Nw/Zahx+fC0eAMULaFytXvc/UFIoiZAtarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iGgBH7hQ3YpCiL/wiE3zaMzQH2a7MAFmPZ5a5oeWU4=;
 b=daH510wYgfjK+osZMr8fKMvAM7Bax3LYs7sBg/GGUo2fUX1rWq9tspJTI5guTeetuBH9bdd3ofyUlZ5rd5jSK9uz+Wc+9z72z7rNhZJf3E/6LX2jPDlPe4gdM4Dnza/tqNHP4EhHbQQj0w4K48UZPemv5rIZlWooIeYxDLqxuo3lVDML8lvVmx+5pv9RgZE8wBkv83cIsiiFA2WsC5CFRkeYpJnHnSt9QH4HkpP8eX6OT6KYmb+b9DvsNTq8oIhczMmxPoF789YMyi8cK+OMMsIx3TUnuBIF7BpXdQQfPN+zUgnBrDlsustgTWuxxPkouxGWMoFwj5WLHkbqCvHcUg==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN3P287MB1349.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:193::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.27; Mon, 29 Jul 2024 07:46:20 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 07:46:20 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Orlando Chamberlain <orlandoch.dev@gmail.com>, "lukas@wunner.de"
	<lukas@wunner.de>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"kekrby@gmail.com" <kekrby@gmail.com>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sharpenedblade@proton.me"
	<sharpenedblade@proton.me>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Topic: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Index:
 AQHay8BxbD/3780MxUWT4The9rzhebHiRiV0gBjw9fOAACgFAIAJQwrwgAGLugCABgb+gIABRUAAgAAFK9s=
Date: Mon, 29 Jul 2024 07:46:20 +0000
Message-ID:
 <MA0P287MB02176046C8D80AF7CB47ED9DB8B72@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <ZqElRH38f_XV3fKK@wunner.de>
 <20240728220343.40fc64f7@redecorated-mbp>
 <CAMj1kXHw0_MicBifz0FdLCOcjjD73AJcM-dyG1J6Ah=BjuQNcw@mail.gmail.com>
In-Reply-To:
 <CAMj1kXHw0_MicBifz0FdLCOcjjD73AJcM-dyG1J6Ah=BjuQNcw@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [r/0WrwKYxPs+5oAY3LpICFK5JaNpSOqC]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN3P287MB1349:EE_
x-ms-office365-filtering-correlation-id: e59f8ee0-f3b3-49ff-1ff1-08dcafa28950
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 8H0YxpT82o8B1lmuk3VxhUB6/Skk7sV6bLG6HT93OTR+/kKJIPwcn1JzHhlj/Iz7cau1iwH6uVwo9jHzZqES0vhxua66PLPGT98ls2SVHLYnJHU92resNRFjr1dnOku6dGtPnY1uHeAgMf3ivcqs53cqqBrahRF3tDo9sA34gxio6IS5GR2b82idPn1fxas20MvyS7F8gPQkF3+7WdwGwrcEbeITKJbFBdjI9TK8wa03Y3u7KtVGTxsp6Gx4AxbEqnVEuMj1Xvf6FZyWBfeYa6fh/da952ZRTHlMpg1vwUyTZgrbbRPfGslo3d94fH+4fhZj72NE43xnKKAKMxTO9LszD5RrTlC7kKihe5Xmq1kJbjL1nL84A6GDmfGbRvcRNjdPItBMhuNNHb9kvGz65x5cwLrguIZWEtyh7yg1dx3uKMBw0YdJqd4E8myyBzbMwKLj0zwqowMlL33mPw9i4+m2KXew274Kco3LgAJEAjE7qEJzApaR8O61r88/31EaReY3wNqey/xSuu2dj2pHB3h86a+5uZJ8dvsxlG0P/CsPo8FqUr441HhxL1x5tWd1unFSbxEJHVVDMOIhKvMYsLQsRhw+oJJZOXcMif8Jgbi1/piE3LKQBphdFnrdFX5JBV87HTYkPFqizI47VTCcXg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oEPE3OuQvMuFNwsfrtKzcwJQKlq5maYZqdIm3kJO+laZXsl+Pdinj3a+ZHlq?=
 =?us-ascii?Q?0gs3JWzbpmfnL7xZAP+PAWRH2lq7wEvbURjsf3vTow7wDpG2zwTlMjXP/B9s?=
 =?us-ascii?Q?lVfvBqOMD/zeD1L7soK2V7Jx7RGxpcX/v0xE+CmvzkVCk7SF8g2UbrS+BfcR?=
 =?us-ascii?Q?A4IN9IppG2RTadREXT/hoL++pnQVux0aoaiV5N56BlwBbgVyFOUAVaNLwn/9?=
 =?us-ascii?Q?LBX5uGX67Nzj8NXTLEC9o4s5W0oFV5pb7QKQOUJE+GBcqDd5X9P6qa1l2FvG?=
 =?us-ascii?Q?+eo9EyxjLCZjwUjOi+5N89tC1cnffs+mzXHsM7J9OW3Yf+A8D8h3kzl0oiYn?=
 =?us-ascii?Q?r6MN/LJFnOgQqTkj1JbAVmeuxesEqI6xZjAtTZsWIua79r+y+EPHiPR/mLdl?=
 =?us-ascii?Q?nIeJszPYFrVO8P2BKWGc+UAHLKx1kXyS8jUyCFopO5Sz2fM6f4MXsMO3rytL?=
 =?us-ascii?Q?yoMq1nlQVM7VtdFog9knW+R1jC1AjME78amxamO0k8bf/MzpIzvMz0W7ihjf?=
 =?us-ascii?Q?0Qu8mDIYlAxZ83QFQ6w+mKSxaXwIKABHb+VWgp2esKMzZDpLpM8amh0iDquQ?=
 =?us-ascii?Q?aGgVU6xkmUIvdGqJHtia3FieN9ggSrlTrrncfPfRkOeDH6K/8Sx24x40u0ln?=
 =?us-ascii?Q?7aW2D5vV+cPCf6+MJmV2+OM4cwAZnak1SgmWWTF3azx7ul8gTGvJAg+e+iIb?=
 =?us-ascii?Q?81viBxw8+b38kgwtu6WPgYHAeUUNNCDYi12D4IWhaeHXjhGKMUVxFP5LNtmf?=
 =?us-ascii?Q?vWCrOUzxQIza0RvvqbdTvEM4lAGRewWaN46zAa58/ZDB1waH4rfuZZe++VCf?=
 =?us-ascii?Q?P/ITTASBX44VAfa3iMa9VZroU8QvGukhW6WDQnQgGvSBrcDtlU1wAcepTPP8?=
 =?us-ascii?Q?KT2cyVU0XQ0v/I1K/60+rBF6rt1nFIxKrH63znv1em6PokB6Xo2xgCoM1S/0?=
 =?us-ascii?Q?V/kTm2gGU/kulOBpQJ72wvLOdC5oXbgJ5MM5ZXCOL63zp5hygiuONA7RtGTr?=
 =?us-ascii?Q?QvBfzufomBJKWDqvcD+TLs9L0TFiDWReXeELKSMAZ9+cYxrxGUlaZeAHrB/6?=
 =?us-ascii?Q?oeaNgqRfUIE99ltG+NIk8l7gDseicoGYDYuF6infER3UinpDZ9ayvFxrVY9P?=
 =?us-ascii?Q?k6WlAwBV7tk/JHiSUEhZYOX8V9BCex3KFpzzHsPs8fTfmLt8Gl2K9+dd4U1A?=
 =?us-ascii?Q?v3ElbQHwCV+Z8pmq2HjnRP6r+sJ1aUGXyO07aKNF5XVc499+n7eCOoE9lcM?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e59f8ee0-f3b3-49ff-1ff1-08dcafa28950
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 07:46:20.2523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1349


> Thanks, this seems useful.
>=20
> Does this mean we can drop the type1 product name list, and just look
> for 'iBridge' in the type0 version string? Or does that list contain
> non-T2 hardware as well?

MacBookPro11,3
MacBookPro11,5
MacBookPro13,3
MacBookPro14,3

These are non T2 Macs that were in the previous list

