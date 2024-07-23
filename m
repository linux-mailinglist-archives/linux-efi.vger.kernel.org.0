Return-Path: <linux-efi+bounces-1479-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9686C93A45A
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jul 2024 18:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E33B1F2173C
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jul 2024 16:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3A715746A;
	Tue, 23 Jul 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="IQcDfC6S"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2048.outbound.protection.outlook.com [40.92.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5B14C5B0;
	Tue, 23 Jul 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751928; cv=fail; b=EFlfv8iAQJSsmaXWmJ4+shz97MZNgnyeVa9FsPkfQnakT2+zEYgHzSh/R3jdhlAl4pSMOs9Rpa4U82YopClaOvwPX5p9U7J318hRL76im/5/PSuqs0pPnX5QX2yvLPOQbnaXkAvY7e3uBcVqa/E7HZqhOJLrGOpxoI7XM4+O1c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751928; c=relaxed/simple;
	bh=dlrphakg6Mu6lMGBoomT1rA8FP2Wbo4eUGJxBJ743hw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KXIrZu5tb7ZFLQnv/QcCngnD4gziE0CVg9xVxOawLyUjG2dlL1uh3ot0IKGrLMiUnHYyLjbXGfmwTadka3yfvEuciB75MbBMRAwaFvOrNQmFMVjxUNKfAPQNbX7O00L7mqnBdV3FFmaocGnfBxMEsXq4Wt4s5CkA/y+MJFPk1RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=IQcDfC6S; arc=fail smtp.client-ip=40.92.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FndLWnfafWUYiNIRMbQfZasej5u3YPnaV+2PrJNIoTcQ0Yb6iMA9htw6VyLfZymwQdyU/tugIS93GuwWeF1mbM50WE0zyZA0XZiX1xuGCPektt/ZECFzocxePaI17ywWsLdLnIVCKvNLjFqfwI4kxjMczUzaNpXk+zO2QtJ+lBiolJ6jna1OMnPaj/lNfS/WPDFlix4c47UAaDoiPydsyi44+1eAQ0SRhSrpHW0QKORqXxO6osc/a8tZ5ep0YeYnnB+PWReyN+Hc7KeVMBB2qyV6ic/MlsJp3pazmbDlPjQ/K3smm3XBBQSnUmBp4UMz7nMf7VnNC3z/GqiELA0MkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8u6h2/xpezFCw2+fWs9grxhrb+jpHqgXWRS+6z+nAU=;
 b=wi4l42YfEktD8PH67PPjdA8yiz2gvkvTG6jkDzxifZVR5QXCXQrIHDK5WT+V8iibSxJsXGL2LDkRhGsT+S/VYFqBl81SjPmHw1M4g1uGOU2KEDbdiF0dVbS7QoZQ+jnGTAe4cRPMeWvQu6nAozpxtKs+e2K7nE6GzBFWSCKQ18x31bcDd08m1ZZJKLcWz2nNou47M+xlkLONWXEmPSM44mIkPAWMh/JWEzPnzQmZT3SzwvN6SuLMLXi+C2eOOUK3mRh41t0NC57zJ94mubtAg1YVYd62WZQgNv516we1ti0f7M98GyxGpOrdLwPl1qPflg0Pn924E/gOVtEeUT8qUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8u6h2/xpezFCw2+fWs9grxhrb+jpHqgXWRS+6z+nAU=;
 b=IQcDfC6S9wl0Otls5Dw1M9x99lsiOpczJdJux9AbKmoTSxlByi2FbHdW8sKislTJPk+MEENpQ+CwXkOj+uEhf4Hr8hDxcPQfSD+OJ1t95fG/wn+90QtkuP5fPqu5rnVPkt/kWQvBQvMBk9qkOIVEN9UUw9YErwqH2zXJKPNs7j0fi/f9KfuPIfZvuUsbomLLv1dZ4Wp9AfRfx8ALKqEqak4Z7NwP9X7jHUNVcftVBBvezR79JIafhN1nqbcb253h4RjWgUl3JJ3Qcs/dFfwPhEAU1K2AK+mq3EdVxCPhdj+59eRXAiHzYot2WKTKQx2RJVjax3TgwXxNz+6H4YKTNQ==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN3P287MB2028.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1d2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.18; Tue, 23 Jul 2024 16:25:19 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 16:25:19 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Ard Biesheuvel <ardb@kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Kerem
 Karabay <kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>,
	"sharpenedblade@proton.me" <sharpenedblade@proton.me>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Topic: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Index: AQHay8BxbD/3780MxUWT4The9rzhebHiRiV0gBjw9fOAACgFAIAJQwrw
Date: Tue, 23 Jul 2024 16:25:19 +0000
Message-ID:
 <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZpgUVjjj3naBGtfO@wunner.de>
In-Reply-To: <ZpgUVjjj3naBGtfO@wunner.de>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [4QPcZxKTHhxmqhdnZ4AaiGMcLOKuBOO8dPOLc4przuuRXd4t3seVYgtImMOWzc+7]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN3P287MB2028:EE_
x-ms-office365-filtering-correlation-id: 4f9bbc1f-49ee-4cd3-3891-08dcab340b17
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrORrPiYp+O3K2PHowtbVet0mAQ3fDL0YUDXZN7Xbago+9JFnbcTGZlsDL+n2y2NNuh5LoYd+VQQ743hRc6VDTiXBaPvM4YzQM4xi8JM0W7Ik6anlfS9jyGB97kBUpuW7gqn8nyhiZpRieSWPE5hPfO7tPrmGz2S0PjSCeZ8R94u4cXQXp7ID4zgNnqoJyFDQFBNJvIsrhg0+5g9J2y3V/hGxASc4npTaYnmAhKQRy9N/jWoY0E9VKXAKrn0m8KF9JtW0VvgA6mJmAfy5Q0Oqy2LPEn+GczC2j20f2xczFw/l2Sjb1EZljgpu0C0KZWCvKxTx3XbkuH/0XhsZ9IHiiJ55aFyzKbpo6oLH01XuWEUyvJY8/cn2b5TfkvzZ4sBzvANeBsE0JCOIEhWcyvNsAZ6jhrt2whvm+0vbeEMRPxateRoT53BAcDvmti1fforgcYC+V530dkA+bkJuGvlrQlYCSaOi7K/gc3sCzccf/6pHRyCYrjkSxSNLoL8K1VDrbv8XvKYWB+HqwxwqxevQtrJ9Rn+jBkVkRqZXXKON1jPIVHj9tIDiHzvcJ3U5hC/Q84XtyUi0L56b531hBJPczSSGT0c2k99QcX0d0svrykKY1tJUlwgS3ttABIoT1v2t+RHz9BnXG9i1gKnPa1HTvVCqosvPOsmtH6cJTTjNRnx98KcCOPPZRMFCox8aZW1LSP1Q/TafUwB/2unReUtonhbp4iOHeT6zaDfFDeX/b0SyR+U95P4kp/OtuEursS7sXc=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|8060799006|4302099013|1602099012|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 NeGH50G/ofKNdb6/SEK3nEBCyly7MdRvUZ453wMuJkgyctOCBq71ox1qt2Pe0OT9WufjH521cyxBDn3Pm3X883hV5ihWmsiBrXpR0KpY/bkWBOlUPyCrqjig5ExvCmU+E8EmmPDe4Tyg9aizAQUEOCtd6gJCe17Hudky1PC1SWb4r6uq3RDwVuK4gVvF6tQ8AO6dh/J/N1RseZJFZN5Ob/YWC6VO/N9ec4C/OUF19bbRf00cXRspwIdlp1vMX6Gx/+Pjz3z78+eL4xsFQ+jSJf9XwHJkGpdhFwp3FHU0aBYnJ0lU52Jy3nLzyXTSZahD/0iC0QEOwY1glCg98BFAk4V8Q79DL430eL45tdEHKfj6zz8Mf9ThiLxQM4uwWrbFS0lm+MqEgIitOMfkfiKPwbbOFja8U1xDRWegItfdQANdQcqWXq7BY/1p0rXkqJUOnluXD1oyp8AtJo86uIwLjArVy9ktI5WuJkO7/6wiCWRKl5wxTjh0TpluYVmzDKYxIAnBU+ZuigeyP1WCUhmfCXAAhM01hEAGeqo07jmNWDcccEDH0FwSNRiO56qxdb9qm4rjI58MwmN6pDqbwQ7QufkKBm41q2mBxN0IM11VBkk88W7MiiIYBYjE0MjKm6kbyf9Y+E+g8GJQU2U2ALzl38uuxDo2TdgvsuKdgp5AzA5zC3uYC5qDxAhPhpPukYwc0ursm2ljsxSBR983vFhGPBgQ6RNR61DJuMmONvfk0HHlSQmSUXAC/JHRLeNaSA5F
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EnustCPQg0q70fcoxEwbc1YNCAxiUbX/OIHqmmPGk3NuHyq2EKJJh+qwOTwW?=
 =?us-ascii?Q?7UzTgSVyW3bwUzwVguFZTkPkeIPvTT0jSOB9W5JQmjUhAmmXtzxNS17yHBby?=
 =?us-ascii?Q?TWaYVusWYT57Qk3SkQ2As/KGJ53gafYkaLqXdEFbgoBiDbtVYHBpGQsd9Dme?=
 =?us-ascii?Q?MrVgAKVBHHpAr9PGtmcsQ2yXzuh9SlzuPrgDp65LHwrVCSMr6wc2pjb2n+Dp?=
 =?us-ascii?Q?djlXACz9k5Jp3wBXFtUGikHhhSql6910iooYk2EsN+9qeD3HcNHxs0dmGDvb?=
 =?us-ascii?Q?1jingH4/GTiu97H16YeiNBX3PVcY8ehaRc8vw6ZSt6AQp+7ygLvRXydwGfsO?=
 =?us-ascii?Q?PYh1DsDQCX6IdVYCQMY7CDwweUFv76yue9Dn338ujY5FJhY+MKdeibh9/mqP?=
 =?us-ascii?Q?TSMxbRe2Mg125Xx4oUqm2nN1H/7lblT+eE034djoPVFyknMGyEjgO1SWLIFh?=
 =?us-ascii?Q?n6xsJzXk++K0iyH2shXYYc+8B0MYHlmtlxiB5ys6L3xVJpYdi+oayXTqH7jz?=
 =?us-ascii?Q?6itSAvq55wHX97DO95CesuXP7QfImEgWzYLF5eyRxLNNRpewwIhJ2F3pFmGB?=
 =?us-ascii?Q?fVpbMT8ztABuCxlZCPSKz2kS4Lqd+Qz6n7spW8dc73b3Ges8uTJg55vOrCy6?=
 =?us-ascii?Q?BsdI3iPVXHiS5qURAO+LKOLYZFJcS64aZnAVZ6QJTNDZ39rRw78nx7cvHebN?=
 =?us-ascii?Q?/vaU3KaJhQ/I2eQzU8laUJHveE0ejBGHUk7vY+XbqQHM99xRe/WV8qT8Kjx4?=
 =?us-ascii?Q?lnR46VR1OgQ7jekyLyD4j/WKE9/1z7o88sxrEQQBe6hP49fyVz39Kk3BJPI7?=
 =?us-ascii?Q?kDx0nCXkXF0Qn28Vn0CsaEOx3oRY7lXJP6VvN5VPZirlkmQIxkMrQX2A8mPr?=
 =?us-ascii?Q?rLB4Cfm3TxMLzOhcjLoOwBPMAe8kNVxTEq8DMo8LE0zhQefiWlZM7ULe7+it?=
 =?us-ascii?Q?DBETzu3T6iYAuJNRkHdjnwHsEihu1sxYU3lllLeFpwSSto/9iRJCE75TgRLX?=
 =?us-ascii?Q?9iQrL39zDWZa+uC4HviableFPBahW+s9cdZS1DPXY1/42y0WpA99hcbRUpG9?=
 =?us-ascii?Q?m31i+NSMvB+6BDsRJfLUnvAC3Uv9YBRF4Pxo6II6mY+qWXCA+f2de9NlyoQg?=
 =?us-ascii?Q?tAx+J0iwvkEv3xZOgcl6la9emsahbiDVvJbkAuSqwIyL6fVsVPf4dsKM7dhL?=
 =?us-ascii?Q?sV2VD4ugplsrGJz6pynPqLdNsJGEOtp3RN0M3XZsR21eC0xjAw+BkfheZl5i?=
 =?us-ascii?Q?A1xDlMkOJRmjsWh9OvQJXFmjRM6HKAzBpwmMZJjEPyoRXfSMVJfAZebJx5jU?=
 =?us-ascii?Q?N8o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9bbc1f-49ee-4cd3-3891-08dcab340b17
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 16:25:19.2050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2028

Sending this message again as for some reason it got sent only to Lukas:

Full model name: Mac mini (2018) (Macmini8,1)

The drive link below has the logs:

https://drive.google.com/file/d/1P3-GlksU6WppvzvWC0A-nAoTZh7oPPxk/view?usp=
=3Ddrive_link

________________________________________
From: Lukas Wunner <lukas@wunner.de>
Sent: 18 July 2024 00:28
To: Aditya Garg
Cc: Ard Biesheuvel; linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org=
; Ard Biesheuvel; Hans de Goede; Kerem Karabay; Orlando Chamberlain; sharpe=
nedblade@proton.me
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Mac=
s

On Wed, Jul 17, 2024 at 04:35:15PM +0000, Aditya Garg wrote:
> For the Macs having a single GPU, in case a person uses an eGPU,
> they still need this apple-set-os quirk for hybrid graphics.

I don't quite follow.  You mean the integrated graphics are
disabled by EFI firmware if an eGPU is attached?

This sounds like a bug on Apple's part:  The panel can be switched
between integrated graphics and discrete graphics, but an external
display can't be switched between eGPU and iGPU.  Is the person
affected using the latest EFI firmware update from Apple?

We need more information before we can devise a way to solve the
issue:

- Exact model name
  (I'd be surprised if this affected pre-Haswell models)
- Full dmesg output with command line option "dump_apple_properties"
  (EFI drivers provide various properties for Thunderbolt-attached
  devices and graphics cards, those could be queried to recognize
  the situation causing the issue)
- Full lspci output with and without eGPU attached

Perhaps you can open a bug at bugzilla.kernel.org and attach the
files there.

Thanks,

Lukas

