Return-Path: <linux-efi+bounces-4349-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99ACB0620C
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 16:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1753B1F5B
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3247C1E9919;
	Tue, 15 Jul 2025 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="j0MLJSY2"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2100.outbound.protection.outlook.com [40.92.23.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D1B1DF26B;
	Tue, 15 Jul 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591130; cv=fail; b=YSNdTIPTWjfqQZXd9mjsAYSau0pIcamoMAtuaSmTHzVY9rveTYHTnembqfgcaOR9vQmg+IDIFDEBR/3TkuwljmWAoQHhdjlidYk66XYzVGWQH1Io8tijE/XqAt6XwAZSA4RoXFqOCd0Ba8RrlLtcVtl6YMGtbvU8sDcODoFjmuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591130; c=relaxed/simple;
	bh=pjDohlUIgSfabP18/h0+AeP3XNM3AhZZQhjzhLLQxuQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dI0v2/H9HSp69asXp5bJamcRDGLVVF+QZfI1cwbaN1PiY951Um67mN7dTQfEzZYA+hwbNKtrQdNTP4r4b77+GjxvsqfKPim2lmbSNB1w8PsP/JpiU5UGhdFO+yLErvBr2GSDbKBTNdC3yD1iDGdIjITfuaFYoVVjx6pU7jjn9Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=j0MLJSY2; arc=fail smtp.client-ip=40.92.23.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y271Wt8MCxyb+uaxBAr0ATX2vG3oD4s/TInTwGyXItzRX9vTA0Dw/oV111s5sUigw/iOQECJ8fyR4kLPWJBlGO9cXBWt7FNIWR2EryId8w9gyAI9CaXUOAl8w4DEI9RBxNzx3d2LW47W6gUItday5SrNUzSnAMtycxtiJ2LPLkGyeVIIfWWkI5WLvpB2LKpwyqPquJAM9nmmT0YOabttgrzj2mN44qPa2G3bMdm7fC82Fbr+av+1qNiYmziCTOFu20WIE/AOgc3uHxvk5FhSBPMvw285GlFFiEZObHf80zx0qKmynOEb7jqCxXQtEaL2Vo0HXgANPHS4pNgXanhflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgGytzTIloI9R0yn3ITiawz32Ce43t+Mfo19EhXJAEk=;
 b=V6H9MWorL803TJOexwT9T9HIl0PIdQlLYV5ekoeCejah6uWzvJwGX8RjQnLEQW/ESpJAPlfqAOYnLHGjFEku+RnkNH4QokHrxhEpe+Kti8Hi1enpBx9BOMABaS671M+tKPkJ/vcmjQ6s2VCHrcjsvUOMqet8g1wlaKk8D5f0bp9mbyaBl50/LIm6TRpZffHOw//4dQfJDPatCxvNfPGAP9LtBfT5WfRbqw0QEBi97jtqV6nnfXuVJ+X7mtjdwJk3CJDSy2rzq8wT50jab3XKRRBIy5/3i6fB+Pk2WPC9IPjcudITEBqVXe83nCRVH+sD9gtMrH3NkjtTZ2uGMBNSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgGytzTIloI9R0yn3ITiawz32Ce43t+Mfo19EhXJAEk=;
 b=j0MLJSY2jVZXCw3f0s3yRtwnaBka5WIALJWvaFfyGWWbDu4SUh1UGIHpSnjjj9BNEdXzeQY9bDCHUoCIbzfuCs/5CVIDeAJLPB+0nVTRO7REMlAc2laCZL3hK6mk8awcTfz8vMcjCRZ9u0F1RQrpCa08IL+eQuU4pkqFhYGfJVWKlMf+IjWOYYoVTFlnVgzHBxJHtlilviion9991C5m9lHPWRqMh8b+p3LsfRd3epMKGySu4/9YbKYqIxYLV4sBr0pDXe4kYkL7z8PVJe0UCz2fx39ukang2nbK7c//DWUr0kooYZV3WoGJNx3FmFc5IOAyHMRcX9JGg9H6eljOhQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8438.namprd02.prod.outlook.com (2603:10b6:510:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 14:52:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 14:52:04 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "kees@kernel.org" <kees@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "ojeda@kernel.org"
	<ojeda@kernel.org>
Subject: RE: [PATCH v3 12/16] x86_64,hyperv: Use direct call to hypercall-page
Thread-Topic: [PATCH v3 12/16] x86_64,hyperv: Use direct call to
 hypercall-page
Thread-Index: AQHb9Kxd7PMno2VhtEaGMiupvp6sarQzRb6A
Date: Tue, 15 Jul 2025 14:52:04 +0000
Message-ID:
 <SN6PR02MB4157F2108DDFBD991F5E926DD457A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714102011.758008629@infradead.org>
 <20250714103441.011387946@infradead.org>
In-Reply-To: <20250714103441.011387946@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8438:EE_
x-ms-office365-filtering-correlation-id: f997d2ac-8910-44e0-3d01-08ddc3af29d4
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmovRtSN2t7hJGY3YvaBnzOVz35v2Kwswx2A3snn+LVDLuDbeUg4Nf3aY+NooM/6Hrn5AzQSRaFDsTQX+AJF351S/APMslK1lpg7cDFH7VOhTTlvQoexQ43zIm0O6SiHSa9NRSw9Kj5E6Z8FKgaJ7TwMkpRJudyx7/8AKnTy8KMrWod2ZmJgzpS9AovwAhdC42CHk4i1PYvVsYWrGOs/u9UmSbu28LCrwAVSrGqGtb0N4/mBl3Tp63v7g+WJASZChs3O7F01yweAU1/AebENpKl+zcqcm5Rpsi8uYLkr9UK9IldmJ2Tu/7jc2G2ZOqSGKefZynViTHEnd/++GGENLj+fVNAfs8vwt9jh42uAqQ7OsfV1KlTQb8GisaCxMHqju/pxHN6UdwfskQ77AW1d+d2q9U6arZjrZys3MKKYjUriBUe6O9WLKm3WYus98RlOQ1/0ePpAvQ1B1xfg/h+9fctQb/qzM9pUf+a++rHQtpwiByfXnOI6UXSOXCttaH7tWKWgroOBErWShiFyuzzccZ8g9DwcAw4zLD1taqYgcKSJhAMpIWOO3kN2KZn/llTfKdJ0OFn4K9VrtVTsOqLI+EJQFdOkRDp7tLKTjAAXdE0f0ylqx2shms1xhCds7XoOtAK081/xlIjyeveEZpM+nBeDM7nMNfqc6evqiLQ+w5LW9MLrQ6wbdGzf+kBBoOzJJmHz9BYRXfo8IJZysv/qAE1DFxTxksX51eb/R52m9GmVg6WT++Xd7ib14ujxCiqsuCU=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|3412199025|40105399003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?S23/+VmD7aUWnue1FfICWMN+swl9qBOFxQUp3Z8eJTU2G/kHhHWbhl0rPsv4?=
 =?us-ascii?Q?Ef/HgX12qMyKN4Hkv6LKGHpJ6pZIEctlEf5tNY4XGJGOm65/kBkKlEOykQoq?=
 =?us-ascii?Q?z/xbI5rqbi9XEhqqP46krHwk65kWQVg4FemDn3P5dFFUSqW6ZoVOLvU5yFaM?=
 =?us-ascii?Q?eMBLK8Fa9qHBKPrjV9kNXxrtEtY3xwIPB7D4N8QrxwOFvBNQSl2olwC9ctOO?=
 =?us-ascii?Q?C16vN74vsb1+dh9TEHJJCmImEa2AbzE6+gfxRSrOhhsez8cTnvXBGiqHTKvD?=
 =?us-ascii?Q?Csxk/6Zy1flMqRXwhIlz+cw4ckKut52kgqOjaT5xGOiKpHyfW5cWLUwZDgls?=
 =?us-ascii?Q?ERmOO2p7nSFXrqXo3QbaxYTp3Ds17RZewg0VZv0NYucZGM7drZwK9kUAXqOG?=
 =?us-ascii?Q?tT9Y6P4mwGCxr5tlltrPqEk3pCVqQ9Xv7S+8yVumKxpk6+1nIsIE+6d+eHzm?=
 =?us-ascii?Q?3tjTzWKWWDWC0RprEQ374v6NAZclywbh7DCx9ncZO4qSLSgE4pLJii9GdvQF?=
 =?us-ascii?Q?NwLLx7Mz2C7iiy+qWYBPJsrHeWPIHLx9247yZtWt8slI6yCLzzS4lVmpa+dh?=
 =?us-ascii?Q?5mvZzI4WCjt0NqZmPYYbIoYEoyOTAxJt8+0a4g6rIXC5cktf5mge3yrzENzx?=
 =?us-ascii?Q?XUBvAqdnnOTBDH2b+MG5Y9Sdh7pRBKUyF1awfvZKoCT9+SoREKJ6vF+RdkAE?=
 =?us-ascii?Q?7EfkXJ0dZd0UpCFCLG56orRcrWVeltS3zcEkO4YO8sQyo/YJPnb/PpuY8uSY?=
 =?us-ascii?Q?BCHXuJDDMH8VljNBxITQh3ycAJ1siLkKQhLxHzqv1X0XtBN+AH/Cw6ztscCJ?=
 =?us-ascii?Q?y+Pp8hl0n7pqweh1NgnbFaf0qRkcC3kHoOSX1np0i2rGPMaNyNkM9Z2pnz9o?=
 =?us-ascii?Q?TzgreIqhVBdQb1aaCFVhgd5sJwXgxkad2UKdpwlldBGKzkuwHPBv/L2JGQ/3?=
 =?us-ascii?Q?n47IkK+ldzu558r+fM7OXpUkjWUrPGCahRmTt8qRYRdfEHdVtxmZdy1NWCIc?=
 =?us-ascii?Q?CZEhOds9fufoIsbqpqdNicYMIF+3UN2wNCZjaFdAnhu64ZTA7Wx+xI/tJktg?=
 =?us-ascii?Q?6ror/Zzc?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cSgjoSWmaTj6T06mKQrbfZv9B8V3t2lq7j0D4axURujS/5ljNYiRwIckkl6v?=
 =?us-ascii?Q?BbPZL3fqVhVGCXarVLeAGDm+teBD+pAeqv5W0dwIehzwAYAhXW8sOEfvmaX4?=
 =?us-ascii?Q?x635+365lvQFlIZjN4BGDGWU3eLrfoEN4r1fAo6a6n1AS9HSHTU/FarvJ+fg?=
 =?us-ascii?Q?19TmOav5iJsbnKFFLIhnGZkI0xi/WbSONhqzQUQZnxd2NKZtzZhizCs9+1px?=
 =?us-ascii?Q?G6LjICL6HDO/vDtuJkoVNZCBm7r9mgwaXftoI68HOi17geQ4L161/l6ALUX9?=
 =?us-ascii?Q?4p/mlMDCnb1/3sYWe/v+yVtBQYWeZsfhc6UaCfRQuNr94h6vR5GRZWoIe/z9?=
 =?us-ascii?Q?7dW/OwfpivftRFiyFxHAWS/GwCJY9kow0OmKsjLIFcW0ia5W9mjYmdkCUjrn?=
 =?us-ascii?Q?7Jo3R5UpBLRlikfUbRJI+8O/sNWfmoZHFk/tdGdNMM2F6+NdrB9GHGYwBCew?=
 =?us-ascii?Q?894YAOf6b4p3UiluGxNXzXKkocf8+YJIdXPOSn3pR/6lDeaHfukIFUl29NlM?=
 =?us-ascii?Q?uMw5p4pCsTn00bWb/eV+sfgdmcCQSM7rqXFo9u0tY3DSWEtsF7r6WR9GdDaD?=
 =?us-ascii?Q?6p4yDdEBg9DCL2I1CvO2CoLl4VGjTvicCg3L4Tn5VFGQDSl6RxQNoHoFbK5N?=
 =?us-ascii?Q?kzKpisf7BiYEpEn4gGpGspzn5nnmEcrzeEIOGBmE9Zr+5MzG7wmXRoAwpACn?=
 =?us-ascii?Q?DBMSpMCaB5sPYyr+6GPtloh8Jbr3xj3K1I0RItc/U/WAX1+0m6LRnGRLfmWe?=
 =?us-ascii?Q?ix3YU3tgJO+x2X4F1xN7pv47dgGPuFTSofnob/WeYTvkkvfZ5Udu+0/mHTmL?=
 =?us-ascii?Q?T7HJNObgci8OQKdkF1MtCMdocvDyfcNBU3g6hsC/X3feh5CTfAAhrHXjRN1m?=
 =?us-ascii?Q?4X+zNs2yqswKA5cJD3CbqC6M4cNXQSpHzoBjr/jgnFtSy5XopAIrIRbK1iao?=
 =?us-ascii?Q?ZjNc52E06CifKTBp61FpMSM8RPa17G2dnNrseZogV0FtAGdKiLT283lDbzZz?=
 =?us-ascii?Q?56kqiyx8k0P2vluS+KLt+J6QC/W63sSitjsHAKUsWjuADXljUMUxxwKpO6/z?=
 =?us-ascii?Q?V9ngSDlpKWLkSe+6rdEMSYUvZl4Ui+zr17thTdXCMnQlRoXUFmQicg64r+sz?=
 =?us-ascii?Q?wUmlOEpTHSzzyAd1OD6SxAykBa1CvT3mkJX8iddXlU0Xq90/OKEU2L6MomBN?=
 =?us-ascii?Q?O/anlHmNZCDVPcs5im7cikoyVAe483WeGx+mUueV/x6h6T/ePZhvv0Nhx40?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f997d2ac-8910-44e0-3d01-08ddc3af29d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 14:52:04.4462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8438

From: Peter Zijlstra <peterz@infradead.org> Sent: Monday, July 14, 2025 3:2=
0 AM
>=20

Same nit here:  Use "x86/hyperv:" as the Subject prefix, for consistency wi=
th
past practice.

Michael

> Instead of using an indirect call to the hypercall page, use a direct
> call instead. This avoids all CFI problems, including the one where
> the hypercall page doesn't have IBT on.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/hyperv/hv_init.c |   61 ++++++++++++++++++++++-----------------=
-------
>  1 file changed, 30 insertions(+), 31 deletions(-)
>=20
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -17,7 +17,6 @@
>  #include <asm/desc.h>
>  #include <asm/e820/api.h>
>  #include <asm/sev.h>
> -#include <asm/ibt.h>
>  #include <asm/hypervisor.h>
>  #include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>
> @@ -38,23 +37,41 @@
>  void *hv_hypercall_pg;
>=20
>  #ifdef CONFIG_X86_64
> +static u64 __hv_hyperfail(u64 control, u64 param1, u64 param2)
> +{
> +	return U64_MAX;
> +}
> +
> +DEFINE_STATIC_CALL(__hv_hypercall, __hv_hyperfail);
> +
>  u64 hv_std_hypercall(u64 control, u64 param1, u64 param2)
>  {
>  	u64 hv_status;
>=20
> -	if (!hv_hypercall_pg)
> -		return U64_MAX;
> -
>  	register u64 __r8 asm("r8") =3D param2;
> -	asm volatile (CALL_NOSPEC
> +	asm volatile ("call " STATIC_CALL_TRAMP_STR(__hv_hypercall)
>  		      : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
>  		        "+c" (control), "+d" (param1), "+r" (__r8)
> -		      : THUNK_TARGET(hv_hypercall_pg)
> -		      : "cc", "memory", "r9", "r10", "r11");
> +		      : : "cc", "memory", "r9", "r10", "r11");
>=20
>  	return hv_status;
>  }
> +
> +typedef u64 (*hv_hypercall_f)(u64 control, u64 param1, u64 param2);
> +
> +static inline void hv_set_hypercall_pg(void *ptr)
> +{
> +	hv_hypercall_pg =3D ptr;
> +
> +	if (!ptr)
> +		ptr =3D &__hv_hyperfail;
> +	static_call_update(__hv_hypercall, (hv_hypercall_f)ptr);
> +}
>  #else
> +static inline void hv_set_hypercall_pg(void *ptr)
> +{
> +	hv_hypercall_pg =3D ptr;
> +}
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
>  #endif
>=20
> @@ -349,7 +366,7 @@ static int hv_suspend(void)
>  	 * pointer is restored on resume.
>  	 */
>  	hv_hypercall_pg_saved =3D hv_hypercall_pg;
> -	hv_hypercall_pg =3D NULL;
> +	hv_set_hypercall_pg(NULL);
>=20
>  	/* Disable the hypercall page in the hypervisor */
>  	rdmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> @@ -375,7 +392,7 @@ static void hv_resume(void)
>  		vmalloc_to_pfn(hv_hypercall_pg_saved);
>  	wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>=20
> -	hv_hypercall_pg =3D hv_hypercall_pg_saved;
> +	hv_set_hypercall_pg(hv_hypercall_pg_saved);
>  	hv_hypercall_pg_saved =3D NULL;
>=20
>  	/*
> @@ -529,8 +546,8 @@ void __init hyperv_init(void)
>  	if (hv_isolation_type_tdx() && !ms_hyperv.paravisor_present)
>  		goto skip_hypercall_pg_init;
>=20
> -	hv_hypercall_pg =3D __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
> -			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
> +	hv_hypercall_pg =3D __vmalloc_node_range(PAGE_SIZE, 1, MODULES_VADDR,
> +			MODULES_END, GFP_KERNEL, PAGE_KERNEL_ROX,
>  			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
>  			__builtin_return_address(0));
>  	if (hv_hypercall_pg =3D=3D NULL)
> @@ -568,27 +585,9 @@ void __init hyperv_init(void)
>  		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	}
>=20
> -skip_hypercall_pg_init:
> -	/*
> -	 * Some versions of Hyper-V that provide IBT in guest VMs have a bug
> -	 * in that there's no ENDBR64 instruction at the entry to the
> -	 * hypercall page. Because hypercalls are invoked via an indirect call
> -	 * to the hypercall page, all hypercall attempts fail when IBT is
> -	 * enabled, and Linux panics. For such buggy versions, disable IBT.
> -	 *
> -	 * Fixed versions of Hyper-V always provide ENDBR64 on the hypercall
> -	 * page, so if future Linux kernel versions enable IBT for 32-bit
> -	 * builds, additional hypercall page hackery will be required here
> -	 * to provide an ENDBR32.
> -	 */
> -#ifdef CONFIG_X86_KERNEL_IBT
> -	if (cpu_feature_enabled(X86_FEATURE_IBT) &&
> -	    *(u32 *)hv_hypercall_pg !=3D gen_endbr()) {
> -		setup_clear_cpu_cap(X86_FEATURE_IBT);
> -		pr_warn("Disabling IBT because of Hyper-V bug\n");
> -	}
> -#endif
> +	hv_set_hypercall_pg(hv_hypercall_pg);
>=20
> +skip_hypercall_pg_init:
>  	/*
>  	 * hyperv_init() is called before LAPIC is initialized: see
>  	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
>=20


