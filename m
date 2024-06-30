Return-Path: <linux-efi+bounces-1327-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C932491D191
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 14:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D960282894
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 12:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B812D1F1;
	Sun, 30 Jun 2024 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="dMYDBdZ6"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2109.outbound.protection.outlook.com [40.92.103.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A591E878;
	Sun, 30 Jun 2024 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719749391; cv=fail; b=VCIWKeE1J264CB7ZrYIy7C8mCahqraeRmaKOiCdmEHnT83YpJcw4JwmlkWEhBnXni8VnIT5y+WOTzLrcS5UuX+8VTbMeFV/lbw/qjb9YqRF7MfmR4ug8HiJ3nXJ+bXSwmdgfUHnn+kLU/m1upW1g+0tpMDkY79b8mXjD2BEIZ/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719749391; c=relaxed/simple;
	bh=zzIiglvDJX4Hrr3sQHIx0VlIzCnfoYhaAN3mfy9m2wM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fMcsSR1QS7bAE34zKIA5Kc53jtuUZ+WBD0abGqwDBoX+6JF5qaKP8Gwe0uuUFrLBANdlOXTvgx6RPZvsWs8dzw03YqoIbUnk8AZhsMJh7u7hEaJzRVeWpeEmHr47ysDy0FmsN2ThfAfrtJcPdXGMvMcfJKrIT2BWOeVZwOjZGjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=dMYDBdZ6; arc=fail smtp.client-ip=40.92.103.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6sXgypz9OMpBQ/RZ0VIbAgWxSWhe6EzQ5CBreHnfXx7jNCYSpWJiD8b8YLmmdi7HyCAt00wXBt0Gbg0RCtW+Lh9Hp7Pt7c1fnEHwVU/lsBvl8Wh+ICm9OLvHgQrDOy04BiSEPnGcyZb3lFi7MaKzxoXJ0qEuoVPsKGh42Ghy1jnzdlcQFO/2IEXIvqqr4FB8p/FuxDaC9ytNblrGrNP0EGJ2wR/c7FgvC0aSGIlUzUwmVSFxBN5boVMlf99il4r1rMnG4ZgMw6oT5beAfOKRpZvb1wEpOUsR9ljgBw0Oj9HHYrQ5FQCGLZbOE1XUzft+gVc/rl6+j+vOuKymTi9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzIiglvDJX4Hrr3sQHIx0VlIzCnfoYhaAN3mfy9m2wM=;
 b=gyQ6QpPJXhn2xbYa+Xx/qBF5ngYBMORY1H2vXvnefR4NIZBZQGV9ekiCoIrSbIhstBRVDN9i15jscNZVFJQq5jkVCol31QiPKOqqEThJoqjBRJi00B9eMkchEQeQ1W7h9ObfUh2NBFTETBdXwnbu3epD7DbA3k7syQ7HXq8Ma6r419VwbUMs4yoY3Qo8VcN0n2StoU9EGPBKNWpDhLnK69WIknmDZIvuh9ZaHPoBr0H0M0NnEvpnaCqaIiTYnSaLRc09jWJ0r5RvnM4fdiZjZOGzULURZaRXnxy8ep+iEv0rd0j1rLioRzgXpcDrT1lI3Cj+3QyQz2raFwNX6iGhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzIiglvDJX4Hrr3sQHIx0VlIzCnfoYhaAN3mfy9m2wM=;
 b=dMYDBdZ6enK/lvBCyADXdV2HWcxU9eWDKUfBR4MofxtH2G5NKsLuMThao0rPkaN3NxR8HCTzMi6Fz2nEgDWeqtLtRD0Fi9NJOOr2WapIIi4CiCwl5jnQRYbTZB7GtBbxWALUzslDJFUOuMLra1jrgPZItO6cLOvIZHsxoOlcIHFsquObluFgZQClT1Jpd8A8FGkzMMy1srAfAtgRfm4GH0KzvdYa4u/6wlmrDnfJ+Th590CMf3pfJFXvgqHBhxFyp8bFlrYTwocToiaJFqKsz1T22X047Y7YC+i1VbQJB/26Rwl7qYLavlNUF0//IkBdVk02sBsSyuJEz6NbhXqkKw==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN3P287MB0869.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:175::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Sun, 30 Jun 2024 12:09:43 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 12:09:43 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Orlando Chamberlain
	<orlandoch.dev@gmail.com>, Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH] efi: libstub: add support for the apple_set_os protocol
Thread-Topic: [PATCH] efi: libstub: add support for the apple_set_os protocol
Thread-Index: AQHayqf5aNOCBZ38jE+N2QIS72Io3bHf8v+AgAA5KoCAAAs/AA==
Date: Sun, 30 Jun 2024 12:09:43 +0000
Message-ID: <F0BC4076-C386-43C7-8D83-754E545880E9@live.com>
References: <EBE51900-DA87-4113-B389-80B9C9160F0F@live.com>
 <ZoERl1PWoc2xDGWz@wunner.de>
 <CAMj1kXFEQDir_VffzHZ0uBMjRqEReNdBZcEQs7kFhi=ipM+y9Q@mail.gmail.com>
In-Reply-To:
 <CAMj1kXFEQDir_VffzHZ0uBMjRqEReNdBZcEQs7kFhi=ipM+y9Q@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [Py4CVRsV2iyfedXC2qzcZ9VdVsn9lKOMYegECBehxGVX/oY0Z/YmEMxIUMZ+qOQSzwUoFUBc7kg=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN3P287MB0869:EE_
x-ms-office365-filtering-correlation-id: a7d19207-7037-4d81-9773-08dc98fd8699
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|102099032|4302099013|3412199025|440099028|1602099012;
x-microsoft-antispam-message-info:
 MgTcTp0r5nhigaF1LGAM4yB+mWVcS4lGJ+G6BuXkQmZwpLyaSQM6q9/Vho946sbYAHcajrGUfzQn3TaQl+PtRzXpwc55yxUrYhM9vv/hM3+q47g8skcBdc1MIqpfdxC2gGszW5hZHux4+6fq+LUyPn0HAe1uJ1nnERAh0aDleXhoh+85FSkR3vYyV6VuFOJwJ4ID24nzWPUovhMxji9jJ7Jf34MDspSoRP7JNnzoHt5wCu1W3oYr28YSNwDhbuR1sytbOsrENbjIpxao819GUFhaIBxsOrQ8QIKl10jxnV0RJuftwOaga31cNysCPE50vMcy/uWJDXy8BSGpId1IFFM1zgGbkh/eSoYYjqV1DOpA3cr+XV3+YSrslXG39NT+xj+VNXUVxq5maRP3jrgaLl8LyHLgbtxk3jTy8lkbcDUFhQe7E3air2bXpt/YVHLOac8aLBSCHsSJGGpxh6pU8cxXIqhNHxQ7G5pk4vCZuSBBzr6lQsRekrDiP+v7MD0okFKd7FdW5+rdAIZCk3UtAqMWd7lseWcYonEai1O+UAQMceUPpRTdBqJrZVfploIN3vh4byTBf77frZml6z1MupBg9SPJM9ARtkddvDKhd3eyBLI8w+aUgYCpL5hJC5CHRuP8xH+L4RAgZjlnGQCVCiEECvonZ7ApIdzuR25121Jht2dkGy1Q7gZKrwH3DWXhln3kKbyEYamo53Ai/OAMGxT2W++/RHdpc45nqOWMU8U=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t9yOyzOAQVWR63d77Na5DBku6TMqMsrYhiM0mcAL4Xbu4VF4NJRnT+qrRncR?=
 =?us-ascii?Q?AadKeTjsVencs1VqWpc984/uWMtKJwbjJxLqD/ff/kieMF6faTzKc51gsFur?=
 =?us-ascii?Q?Xi8S8lgW+Wr+XfW1/Ds+VrhH3ZCluInoyrm0S/yzd1bCxBtulLP4Fgg57B2F?=
 =?us-ascii?Q?/RExYZiqKz4gG1mBpeQF4aDlWGaH6VX+ehUANdKW1e95iQGu+0D2FUgdMapV?=
 =?us-ascii?Q?PwQIePpKYRVe22HfNgLrHf7hRTdU0ZleUNlt6JUl/+g+x7VKEksMrA9UD4Id?=
 =?us-ascii?Q?t85VKCdZKOIGsCb4fkhQ3hT8yGg7SSZscmWJWDQ6jzQPoLrYpEa07C2PowaF?=
 =?us-ascii?Q?fyajhFeCqdvpX1TJoCOChl5SzxJK9bZ8MyLGymeh5I3/Mo18ocRwhQNASZPi?=
 =?us-ascii?Q?eRXOTM2TcJo+1nX7yaL7lWouKmExqi/Wmjh/hTmfmIGu2/xhIOzjTiq6EI2B?=
 =?us-ascii?Q?1UBkL5H518zf5ofWvOk7VNLgHftL83TCgCzmvY1Ii2IlktRwrjonEffqtR8o?=
 =?us-ascii?Q?Li9rxTwHGRecV4Cv8nJf7dC5bKuB1ZNPEgEX2gBNfFIF/XrGRWB0wc5o6zKC?=
 =?us-ascii?Q?XzpQBygPizYUlitea89owrtJvMtKuZ+mJX81h3ZLtqCPGX8c2VtJmR6DrPVC?=
 =?us-ascii?Q?S5XxElPeBKgALMPiigR/Rlp93dmHXexNnO8rENQv0zJnnCmondvQCFnOKDKi?=
 =?us-ascii?Q?TPhbvWnaONMeupEyxIss6NK5B3/uSnGen8V8QisILhk/TW0/S0/3TbXauvs6?=
 =?us-ascii?Q?P4PpWofQx/atE1wYfzQf7KkW4dVMW5LJYM3pIjj7M3Oo5c8EH245vTKjvd+c?=
 =?us-ascii?Q?KIrqav/Vy9tkffKnonR8pNcM4EnKfawDSpSWHH+fgDg0ZBb4vhel6/p8+syZ?=
 =?us-ascii?Q?ilPxmU+dSHyB8X76mS8N/Xk14IDt1fLfDz3TBYecyY+vMBIzOKwTQNq9XHbb?=
 =?us-ascii?Q?dK+PYG1cbi/WCt/2FhBPNmvRI1f4Scuj5WibNbCdmK8Acig79k8yL1VRGkTA?=
 =?us-ascii?Q?baSPDRaLYl1HaYUXSSZ4HQuK8KGpM8B/5rNHn7fwDi/ZiGgCk9E1JvSwQffg?=
 =?us-ascii?Q?GUbKjao6L3+grAHLVISeSM+VTJAnN/KiSw6CTQBqZ/QgaS/1b1vUKHRr0qBl?=
 =?us-ascii?Q?gph8sDZNUOHaNmhCU0Yx3bZBa/CQNKW3ZUeT3MLcFtmYn/5eW/2WT3khmHAz?=
 =?us-ascii?Q?FrI2DtXHhrsehNVKWC8Svs3rd5V2ocH5FIBgxFXxw74ORrKIc7fZXpygEYnh?=
 =?us-ascii?Q?lBSoKJk+o1RRa/k6Q65B6Gbaz096Vx3SmMR4U1W11R9abDKHSR1T71XkcAI5?=
 =?us-ascii?Q?g6r4HIGHZEJNDVFBHCfgBJKF?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C732D5056E3E2C45876C073451980B5B@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d19207-7037-4d81-9773-08dc98fd8699
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2024 12:09:43.1627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0869


> No. You cannot simply add a signed-off-by on someone else's behalf,
> even if you cc the person.
>=20
> Andreas contributed code to GRUB (which is a GPLv3 project), and had
> no involvement whatsoever in creating this patch.
>=20
> A signed-off-by is a statement on the part of the contributor (which
> may or may not be the author) that the contribution in question
> complies with the requirements imposed by the project in terms of
> copyright and licensing. Linux is GPLv2 not v3, so this code should at
> least be dual licensed in order to be reused directly.
>=20
> I did not look at the GRUB patch, and IANAL, but this code invokes an
> Apple provided protocol (which is proprietary) in a hardcoded way for
> interoperability purposes, and so there is not much to
> copyright/license anyway. I would be fine with having just your
> signoff on this patch, but you could ask Andreas for a GPLv2+3 version
> of his GRUB patch if you are not sure.
>=20

Code similar to the patch sent by Andreas uses MIT license

https://github.com/0xbb/apple_set_os.efi


