Return-Path: <linux-efi+bounces-1448-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC699340CD
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 18:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C311F2314B
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAE0181D16;
	Wed, 17 Jul 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="JL0bxjDA"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2053.outbound.protection.outlook.com [40.92.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC13B1822E6;
	Wed, 17 Jul 2024 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235178; cv=fail; b=abQxGvIxv4g1q87SetelT9izVGoBtENfMsM2QLrHghAL1nwIyqhbFPrEXwb30EncgM8TNb6QSORlZ/wuhyGVOBx8mCiW4K1yYWqTGwAtplSLey3mjDJMLdueVU7py+9FcSln3zDd3HweLL0hXKZkMMFEPqH/mUw03WHlLSDH83k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235178; c=relaxed/simple;
	bh=Sg7qGmG64hAPyS2lqxkhMbSyE0Fzl/txPmA3lv/n1R0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IXbHrR6kz1+qocLN6fNSifS8tSA9EuHN7PkiXH31CQ2FsfqNfHqxUR7f3vdH/okJMejBv9vxtLZduOERcxNEZ7p6uXePm+tZd3RjSwv18rcE/E9xXjjMJ1xAjBhdt5jsXXj1BurSXVRiRg8ttJX09ei32PGWVR0h3O4GOsmVn8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=JL0bxjDA; arc=fail smtp.client-ip=40.92.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTglU3G3GfxcDie4hAPpbMoZs7p6GYXPFrXEGX+fte7ky+aVVcjvZgTk2+KNL7EjIgivM8f2LX0eUmqjwQsEb2bZYPZBW/iRV/bC2vNueRHXHxUPDeENOMD8Rdj+Si1aarbeNOIM6Feg5YKjQRmgtrMPOXzyE2k07RUHEeffXSfqw0dDB9umkm+68SZTJx7crC8WYiiRemvbCkss0dOdxMVpJIiGWx7hXk6uyubYlI42OJZS5W4HgokvscV/+mrSu7biHUydXCRCK9MlQS1L777oQOQiEjlfctz4JD7Ey82CfRkXd0gYjimexoBpOmRwGVp/0dYSizM9dJPgCT0S6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sg7qGmG64hAPyS2lqxkhMbSyE0Fzl/txPmA3lv/n1R0=;
 b=l/70KFRsAHmQGdnTtad2/KSTkIYYiS5lIraAQwi6jRhVjOqtAhOJ9NVQ/RDO9tNme00aHqDngxi3GjC7csQLAKTzrL112R+p9vRpW8P7DGOq+NaGZxbUw0DtGi5tthee8Q9uRfwP8KYBRilC+UIVnd2CJXBwOABHVveCQg7KBQlJRuDYYTARziRhIAnsEwS4Xl+N9OZ8oavan4unF5YwTGMOr+E3RW0u7PWj4FqtUGWJ7wtxdlQikNstjJSivntdP3G1suNVlI2GjqKii+1aBQrD67ZdsVmVgEXSg1J6mg1ZvveQ0g6SQKAlviJrnrp2W8CroXeVKT1kLDeqsy2w3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sg7qGmG64hAPyS2lqxkhMbSyE0Fzl/txPmA3lv/n1R0=;
 b=JL0bxjDA5CkWv4S1JgLhcpOMnpQR5Av1sD39EG1MZzeucWzzSxXAEe01ROOgr4OtSXN1fbPlBb/l0WJ9GbM3qg6tk5e+DCYheOGPkdsbQGIH8x7CymgFSK/hwFCiJEfSINEAl8kdZqAt0YC4YiJ80baxOdXix5RXYY20VlTukcWanOdpnBrFjS6gFTTiQZk6nk/YypJbC7g3szOzTOi1FRXotTuTqmDhtFhmx9dslB5xMN/ZX2NWWcI16IBvdHLJ5bE1zi3IXIE7wEwVm1RfIhurKdBV0PtwBUMEMialIQKahCFfq+6d+wWHdRYSwMPp+N7086IUDX/nEhuaIoj8kg==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 MA0P287MB0664.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:11b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.18; Wed, 17 Jul 2024 16:52:51 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 16:52:51 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans de Goede
	<hdegoede@redhat.com>, Lukas Wunner <lukas@wunner.de>, Kerem Karabay
	<kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>,
	"sharpenedblade@proton.me" <sharpenedblade@proton.me>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Topic: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Index: AQHay8BxbD/3780MxUWT4The9rzhebHiRiV0gBjw9fOAAAM9gIAAAa0C
Date: Wed, 17 Jul 2024 16:52:51 +0000
Message-ID:
 <MA0P287MB02171286CB1BF5CD506FCE55B8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <CAMj1kXEGsnd5S3-nnCUNYJ5tVr2LU2BOkNp513OfU6A=jgVX2A@mail.gmail.com>
In-Reply-To:
 <CAMj1kXEGsnd5S3-nnCUNYJ5tVr2LU2BOkNp513OfU6A=jgVX2A@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [qFI8ItOogssk/eRT2VAFsn/2lBuskVKo]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|MA0P287MB0664:EE_
x-ms-office365-filtering-correlation-id: 41bade55-3975-463f-89a6-08dca680e541
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 xLMV++Z4I6NxyDYpm1CzjzD8W5ieh1pRAx9oLqAQh3EhGhGwE+JmmO3+JMpQTSLS2oQSWyl9urpyKSWO1ydQncgSV/ohlb9CmZ+czHjEWOIKK32QOr8PX+4Vnxh8ZNi/HFv5+ynTqZ3ndPgnMNqC6EmSeNih0P7fKJICTb6OFwEOymWf1AA7eMFXjexMEMQKULnCL5jR5KP0zoGIfATx6d1j1bmkI2J+vCnhjA2py5oM2vlbW71TpYJN6JqVAu4Lzb4QYLiAGnuZsjCyXPfDWfla3X92cSTf78JnE+TSh3URKrk1waPrJRYWkdRo+IgnCgMmAAg8sSGuVeKJ3r8rU9oSrqlhmAIuHIm8cjEUUQnykDZHC9+vfL1NHMvEGLBZXHMqinp678yaOStU9sErKBFMRiy0EW5snA5O5UyNAx7XjTLcOlL4U/h7T4V+4KXXkr7Rr/1BCx0WTmKLdWNe54efzANR52QXpOz5vkyts7M/JlcGHUmMp3G9+Cz8r31vX6aDJlyglIsFqXwIfCyIoDDJthsRiz7DtnLQpd8E+7tfe/dUBxfsnCLABGegjfbgOoUkbEHlPhrk7YJoeQ7yFfr7NdObEg3O6/51B78/GhiT0kHcA5UTrW50gRZ7yl3UUkEpXSPdyveXCZ1BjMyS5Q==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yEwqXes5aATrbUsNBiwD3/y0Cg2sneOe9k1aAdtNFTQFWa7LSSZftIJOX2UX?=
 =?us-ascii?Q?FlK6vshobleUMcUl+lGn/hgGTvNMfRgH4GrqhXtTrQXBMi+QmSSlcJHui4Po?=
 =?us-ascii?Q?w4u1X1XuwlEU76r9ULvYRwVFxf1XSBIU98obqdQjcEPX/yzsI+19kWxqkhYN?=
 =?us-ascii?Q?rmcSaG8f6dG56F+6ASbyBYgZsjr16p1a342tS27noZdBAUI6N/L9GHL/qPQ0?=
 =?us-ascii?Q?ivzTWGaOLu1jVuf6jxnTrpMyfe23fo1WveFl4UZzYwvxz1A8ShUh2mAHh4bW?=
 =?us-ascii?Q?wHQiNF/LZx3MnPSGJuWgpg1F2VFL+GvJKU5IeNar4UXh4Hhl02OUmQ+eWwif?=
 =?us-ascii?Q?cweFf5YZJ8hAtWshCtVswoy2Gn6QRtX328t6H9UhzzPUUhGhpPMu6cwefyW3?=
 =?us-ascii?Q?ShhRlb45OBavI0f8xnMUjdOYye4gnaK0EtFex8A1ItS7llTHgfxqaR7uahvD?=
 =?us-ascii?Q?aV59hqIDu32lXkbtWSGqvhqHl457+23qeaMRHx1sp8kV/L6qCYhW9mZMaUwq?=
 =?us-ascii?Q?RN1ENvjRsYOSkH63gSeKbMDTgkibLQfpBi5F7udnZqdJ2qblTGmsTi+/zW9e?=
 =?us-ascii?Q?alojD3BFDBYXMc6jwW6b0bCNgC2enWpFd9zRF0ApI0xfq0315Lel2UKR9U0o?=
 =?us-ascii?Q?mlTodLw79lx21KdCEkfc/EPuo39+MCIO2C0h9K8HkoxHAFasaL5t3slsu73y?=
 =?us-ascii?Q?l0jgEEpXQPTisSHSyJ6SbF6tkNTMM6ofFF2e5AC5/Y1utRqK0PMOn01lzq8v?=
 =?us-ascii?Q?MqE5Oy8y/uYjKESBBxjEz7/oC9LoMgaaDu3VuqK7zUlYnE3M+hFY/ddoNQM4?=
 =?us-ascii?Q?CW4ymv0yKbGtmkPLushlmiyQeV6B0OjlPDKW+7tCRb5BoYVI3Kb3rHL/VYCB?=
 =?us-ascii?Q?Uq2lCxfRCcpSJAlQ8ZOHgkYx2fPcfVCQOoge0PZ5iZysSi3Fy36D4FeGjiSX?=
 =?us-ascii?Q?Ayu7H65v88s8TISsxxj/RSikvbTgAotXap6tUn403qiAKBabJzYPqQCOMFR4?=
 =?us-ascii?Q?XwY3qF+OQkavoplw1O5vKcW4flVuWyaafG1Zeh0wyG1kvQQZ50lyvX0Tp1os?=
 =?us-ascii?Q?08nSMurkznR0tBghc8RLslt71mwQP2JpZFm6uO0VDseNho8fPnHvIQnrURzR?=
 =?us-ascii?Q?hn1EpdX0fjabwXggyl6Z05Hozww1+injvKBKpikfH5HesHv8R9FdHf/SyBkp?=
 =?us-ascii?Q?ldaDhb9UuHbNsQjMUB3OCdEOQYrG+uCjaaolo93PIkvIMMsQom4LZLC46qg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bade55-3975-463f-89a6-08dca680e541
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 16:52:51.1747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0664

Hi Ard

> Hi,
>=20
> Is this a theoretical concern? Or are you aware of any user that is
> actually affected by this?

We had a Mac Mini user who wasn't able to use hybrid graphics
on his Mac after using the eGPU. So no, it's not a theoretical concern
> In any case, given the niche nature, enabling this more widely by
> default does not seem like a great approach, as the risk for
> regressions outweighs the benefit.
>=20
> I could imagine the use of a EFI variable to opt into this, would that
> work? It would have to be set only once from user space (using
> efivarfs)

I'm not really sure about efivars here, but am ready to test. As long as
it doesn't break booting of macOS or Windows, I don't find it an issue.
macOS may also reset the variable, again have to verify by testing the same=
.
I guess it will also get reset if a users resets their NVRAM.

