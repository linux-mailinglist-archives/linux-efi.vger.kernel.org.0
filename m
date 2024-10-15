Return-Path: <linux-efi+bounces-1968-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C93E99F469
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 19:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E23C283C2A
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 17:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01291F6676;
	Tue, 15 Oct 2024 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="X5CfHwy7"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2090.outbound.protection.outlook.com [40.92.22.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829F216EBE8;
	Tue, 15 Oct 2024 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014746; cv=fail; b=JO5OUVMRULNgGSNmGxYCAYLRYgs6DiXRHzXku40txvsP/vFx0PacuLv0p/Lgq8p/8zRyNyzKVd7V6cd1+EB0h35+d2thSta/2Pk6UzDVLFTMJ5FSndC4UwINqcsEldNJSQA1fpy/OA+lanyJ1nCNH9ZkbVGD095H7KpTn4a5YBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014746; c=relaxed/simple;
	bh=6rqwR9+MrxkuJef3xAehFv1xYMoLKAHvOslTlKYmR40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qm0Mt1tqghSjPTixxhdW4rImqDmeLJZeMZq6JlPXYp4NYhzEX9OWCxsdfegUT7YwEPj8SwuBmJKdTsfLtcVS0eJLpjTCqSYbEC0iSJdLQoEo7ODHxTd02vWDkAOFQL26rpax0AWGdRkrhN2UsZxaIe1+LMXIBlxzcD9Vx8BfHXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=X5CfHwy7; arc=fail smtp.client-ip=40.92.22.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCoOMAgg31qkk/9kt8DzY42UOCjTmjFBgZSCr7VN8wZCaqYfeum5eH+8y3ha+6QTjMpzkETmncH0X20BD/DgrJGVBnZB3WFHLcBB/gIlPkV84NwO6GhbxRmjwgmN6B/00ZUtyWUYf3U8bLZW8UJ4lTVLPkf/SHNZJTNrCxUUt4wEgMTEHq3Vp32YCeqOUdxeLsnPpXoJ+PQnlVHJ0MkTiq+qNEP+PiYfILytuNcpMHP9chbfXyClMk2vzUzaYPq23fjrTfgiEtT6uZ/6Vqbq1XUyzryuJajlqpNs6k5EMjwvfOcxKhJUp4mJzUeFlu96hwWk/VXT8q1QkqfwSfdthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOn79tSZRHn16bmBdh24FBGLEToeiQPwm9Yt1zXQVVg=;
 b=gDrXhNrmcivMJ98AN2xCRDv5TDK6wPQP7Twv9S27NVZK5+Z9CapbR1bFawP4zJUg+qg0XABoSOX/vMW4MQk8sL/u8OlbjxvYxWCVKD3uJN1OJnvsTjjjzZO/CxALMCBAZdgiJwOmBeDUW/JiFpEQtvdAlMwjII+/5us/dbomj4kDeJET3udbtFT/KDZMxMIM+2ecKsrEqmrzbdRTgZCJ480Jvb9DOj2KkYyoftApQcITuZx/E9BfiQJ2R/pPMP7aVPbniX5SB0otELTbS7DABAsd0hpllBKzToX+xxuhEQqAeBCdpWOoBu0x9GXu2NLfASnUxXE0X7ph5xDu6VmgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOn79tSZRHn16bmBdh24FBGLEToeiQPwm9Yt1zXQVVg=;
 b=X5CfHwy7jS7Lz81r5aiQFj2Mwp0+vwy9eTRzDAlYDDWdwXBdQdEGxbPJ69QOfLnjCkq+a+UfSnf+d+GGR2m1TxsuiQlrxOPi6E3ZKq+V2W2gWX8KyVfoeFGIaV61IVVV5iu/JtoW0cddAOR+w9dAF5MoEH50Z4mqV02qfIqVC1RkDS+S8wKYPBF4sYnXGAQDXvCh6btgw9kLt8wdkpERFct1HViPcD9qJAdI7/Vrfdmv56umoyPVD4/A5Rww6T2lqUUgqmClz08acNQIX1cV6jzapp+vTf7xwZ2clVgZmz9uxis3h9n1yllNwZ4OXyVjK0nd/VuvoRiFDJOlWAr0Kw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9451.namprd02.prod.outlook.com (2603:10b6:930:70::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 17:52:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 17:52:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>, Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>, Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias
 Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>, Oliver Upton
	<oliver.upton@linux.dev>, Will Deacon <will@kernel.org>
CC: "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [RFC PATCH v1 57/57] arm64: Enable boot-time page size selection
Thread-Topic: [RFC PATCH v1 57/57] arm64: Enable boot-time page size selection
Thread-Index: AQHbHinigN15OgEeL0atXx8Mwz4uQrKIFjlA
Date: Tue, 15 Oct 2024 17:52:20 +0000
Message-ID:
 <SN6PR02MB415789255D94336BCC9B1E0AD4452@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-57-ryan.roberts@arm.com>
In-Reply-To: <20241014105912.3207374-57-ryan.roberts@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9451:EE_
x-ms-office365-filtering-correlation-id: a73f9cb0-2a29-4e18-6ce3-08dced421e03
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|19110799003|461199028|8062599003|102099032|10035399004|3412199025|440099028;
x-microsoft-antispam-message-info:
 DAP1qlTJYcddydsZ+0FZV+P9bpd2V5WFM/5gM6pNZGuH2FLarxBfd/IkdWz8znX+FL2xHggqAa7nEKiXovf1mjNJIW41TWftq+nJYuycoihCEOweeYJWrm2Hg6FI4QZD3vKMzr5HMZ+I1wJn5o7K+OuGXqx9DkL/VZEFNWuIqdyqRj5t27JYBPfXcBLQ0t5Uz+Vla3vDsXbCr9SGcy+ir+RV4egrs7vrFo7ZoBV5AWFlxx+RqO49axaYguPeMDLiuSJsRMPOvtRJr4YGJFKE93bDTWtYvTiayoTOJ+S2tjSL6oCchOHEWCHMrVZxAlUGaRVwmhSyGnOVvQfDmJm7IRUjAhdfwOmUJC7TJNxxu0eweLxUDzqNtwqMdWP/XfCVDT1JT7ygUPOXETTY6qZfwYMMl+/go+X7KYP8Z6PzLUQMLUYHgQcIfJgzDG2fz7hqLV+VxIMHNbesCTRraHRyCPqlOT8NqLdoJEzvIZTbYVQGsK2MQulqyV2X/WhM1sonPy4ouix50ZK8e4Qj+42eSkf6/ZBa5wAACzP2JdWTsgV1MMwMzp4ffsK3OJ6zqzwTNHtIBx2IxueJeLVzRUeNtgpGVS3Jjj+Lag5T8WreF9QwFN+QM3C+PZhetwWtIi09YN1q4gr6N3zwO+AFDcbqbU2ruxmOzCncnLgglIqH+xClQ7+RRg7m3DsSWwZxuOG9YDU8EpuGuxIRrdnXY+L4jaUww6Z3HbZlx8usCpoproMhTtlAG8aaqdyve8PU9Sb7uldNHxvhp8BXzSPEAp75yXaKK0Hx4JZ4opNXf2tTzjZzaskp+e+OMAhVYEatls0X9aHzz8KI05reuTEU7t/JJA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NSnncWWBr6+ASiLKteV8szaG/yUPjIGJuOIeYGp32ed4Zsc2ewKXL2IEhozL?=
 =?us-ascii?Q?aTyVtLdXxExcvG8fKUL83H/ixeHIiYZnWbUN+x3qsFVpKFt8XbehySx8G8aL?=
 =?us-ascii?Q?egaSiKMgp0sSdcLKHeVlbB0aG0nRRQBXP45Wtl0b3h+A/OHFLUrYoI4fHmT1?=
 =?us-ascii?Q?9ElY/vmsb8fAhKMD1Romfr81pnyTbaYlgWb3tTRTHeHURs9+x7Bl3kbbxCiL?=
 =?us-ascii?Q?B4t+dAVLH4fU/Dnb1RtYByJL5FgyFunQTDHA9WNpUhLxTx9xv2VAcEbihvI+?=
 =?us-ascii?Q?Mtz0q6a4H4SkeMppw6pRQ9yIH7H+AIV+63b5uVRQGFpK8iByZRSidRiqOCq4?=
 =?us-ascii?Q?v8ShroR7BqxmrDf0TR7+2wM9J/VZuLlrgEa+nm+WW4Vo4sCKufI2wnePy3SZ?=
 =?us-ascii?Q?jD8Vd0wloXBvw8TcwM+xzEPiCE1yYHYSrKajj3PW09zg1NgkZPs5QTaOXcl6?=
 =?us-ascii?Q?MJr/LLGvWVRYApEIXrt8HGxzYrG58IQrrvE/62vllQfF6jxWRqz/Tl5UZwWd?=
 =?us-ascii?Q?Y6P+Z6F/GzxBsKfakstlNFdEMTAOST4HNCclFhH7hs7RfA/xIEuSDv8VkBIU?=
 =?us-ascii?Q?+QI8dqxY5PZeLwq/lMoEI+WfLzgYOrGrS58ejsHS+eBFVX9lrWBM5OPzmcel?=
 =?us-ascii?Q?ZTjWb9VQHHP/o2wMbDxIFA4HdtzMVYyaLnboe1ZpCFH3khISnF5ioa0q2PFl?=
 =?us-ascii?Q?82jJQItJ7Z6YKOZ7hLBp+u/VpJw14SucYsaNI5F1Q+5D9eLyGz9jMcTR1c87?=
 =?us-ascii?Q?0ShANpirw4Zj5iKnBsjjtJSsEZPvB21K1iSK7nDSiX1PZU6lp4ECqFYCrrZg?=
 =?us-ascii?Q?rnBIf2T2S5T1WiC+IOOwn1ENVUOSOXnb3+UMrfde8A+o1R0RzpZH2/B5eQxa?=
 =?us-ascii?Q?FrXa8bcQuT3Hrtjo+LceJB8jki+SpFvuSXrOsIlWOb4HwxLTxbWCr4rw3zgU?=
 =?us-ascii?Q?0zN7bCAmZRDzHkJK2V3/KGVOy5hdENvAWCFsv/MZQH2S/WCfGWr2ulvEpI/R?=
 =?us-ascii?Q?kt976Uk0OwmBKpBeHSFBFLCJVjcF7nOPxv82hW8pjz5mGxn31Ah1W3SMzRNN?=
 =?us-ascii?Q?nAULfeNXosDoLEDJ62BK2hFiGIDJUEki85Jnu4g5FnGg0JD1nHYkvlKPrKjU?=
 =?us-ascii?Q?/7OP1LoK04Fmv6KjbL2rOKZ3bHAoTgWiBi6iZezPKitKdediOTfuuRz8ai3R?=
 =?us-ascii?Q?dc+xBGaaHj7TinNI/wM2WnFX2oaNpr5JjQYtn70Buju+u4MwyYCNYPy+qW4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a73f9cb0-2a29-4e18-6ce3-08dced421e03
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 17:52:20.6718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9451

From: Ryan Roberts <ryan.roberts@arm.com> Sent: Monday, October 14, 2024 3:=
59 AM
>=20
> Introduce a new Kconfig, ARM64_BOOT_TIME_PAGE_SIZE, which can be
> selected instead of a page size. When selected, the resulting kernel's
> page size can be configured at boot via the command line.
>=20
> For now, boot-time page size kernels are limited to 48-bit VA, since
> more work is required to support LPA2. Additionally MMAP_RND_BITS and
> SECTION_SIZE_BITS are configured for the worst case (64K pages). Future
> work could be implemented to be able to configure these at boot time for
> optimial page size-specific values.
>=20
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>=20
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context=
:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com=
/
>=20
>  arch/arm64/Kconfig                         | 26 ++++++++++---
>  arch/arm64/include/asm/kvm_hyp.h           | 11 ++++++
>  arch/arm64/include/asm/pgtable-geometry.h  | 22 ++++++++++-
>  arch/arm64/include/asm/pgtable-hwdef.h     |  6 +--
>  arch/arm64/include/asm/pgtable.h           | 10 ++++-
>  arch/arm64/include/asm/sparsemem.h         |  4 ++
>  arch/arm64/kernel/image-vars.h             | 11 ++++++
>  arch/arm64/kernel/image.h                  |  4 ++
>  arch/arm64/kernel/pi/map_kernel.c          | 45 ++++++++++++++++++++++
>  arch/arm64/kvm/arm.c                       | 10 +++++
>  arch/arm64/kvm/hyp/nvhe/Makefile           |  1 +
>  arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c | 16 ++++++++
>  arch/arm64/mm/Makefile                     |  1 +
>  arch/arm64/mm/pgd.c                        | 10 +++--
>  arch/arm64/mm/pgtable-geometry.c           | 24 ++++++++++++
>  drivers/firmware/efi/libstub/arm64.c       |  3 +-
>  16 files changed, 187 insertions(+), 17 deletions(-)
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c
>  create mode 100644 arch/arm64/mm/pgtable-geometry.c
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a2f8ff354ca67..573d308741169 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -121,6 +121,7 @@ config ARM64
>  	select BUILDTIME_TABLE_SORT
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
> +	select CONSTRUCTORS if ARM64_BOOT_TIME_PAGE_SIZE
>  	select CPU_PM if (SUSPEND || CPU_IDLE)
>  	select CPUMASK_OFFSTACK if NR_CPUS > 256
>  	select CRC32
> @@ -284,18 +285,20 @@ config MMU
>=20
>  config ARM64_CONT_PTE_SHIFT
>  	int
> +	depends on !ARM64_BOOT_TIME_PAGE_SIZE
>  	default 5 if PAGE_SIZE_64KB
>  	default 7 if PAGE_SIZE_16KB
>  	default 4
>=20
>  config ARM64_CONT_PMD_SHIFT
>  	int
> +	depends on !ARM64_BOOT_TIME_PAGE_SIZE
>  	default 5 if PAGE_SIZE_64KB
>  	default 5 if PAGE_SIZE_16KB
>  	default 4
>=20
>  config ARCH_MMAP_RND_BITS_MIN
> -	default 14 if PAGE_SIZE_64KB
> +	default 14 if ARM64_64K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE
>  	default 16 if PAGE_SIZE_16KB
>  	default 18
>=20
> @@ -306,15 +309,15 @@ config ARCH_MMAP_RND_BITS_MAX
>  	default 24 if ARM64_VA_BITS=3D39
>  	default 27 if ARM64_VA_BITS=3D42
>  	default 30 if ARM64_VA_BITS=3D47
> -	default 29 if ARM64_VA_BITS=3D48 && ARM64_64K_PAGES
> +	default 29 if ARM64_VA_BITS=3D48 && (ARM64_64K_PAGES ||
> ARM64_BOOT_TIME_PAGE_SIZE)
>  	default 31 if ARM64_VA_BITS=3D48 && ARM64_16K_PAGES
>  	default 33 if ARM64_VA_BITS=3D48
> -	default 14 if ARM64_64K_PAGES
> +	default 14 if ARM64_64K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE
>  	default 16 if ARM64_16K_PAGES
>  	default 18
>=20
>  config ARCH_MMAP_RND_COMPAT_BITS_MIN
> -	default 7 if ARM64_64K_PAGES
> +	default 7 if ARM64_64K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE
>  	default 9 if ARM64_16K_PAGES
>  	default 11
>=20
> @@ -362,6 +365,7 @@ config FIX_EARLYCON_MEM
>=20
>  config PGTABLE_LEVELS
>  	int
> +	default 4 if ARM64_BOOT_TIME_PAGE_SIZE # Advertise max supported levels
>  	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
>  	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
>  	default 3 if ARM64_64K_PAGES && (ARM64_VA_BITS_48 ||
> ARM64_VA_BITS_52)
> @@ -1316,6 +1320,14 @@ config ARM64_64K_PAGES
>  	  look-up. AArch32 emulation requires applications compiled
>  	  with 64K aligned segments.
>=20
> +config ARM64_BOOT_TIME_PAGE_SIZE
> +	bool "Boot-time selection"
> +	select HAVE_PAGE_SIZE_64KB # Advertise largest page size to core
> +	help
> +	  Select desired page size (4KB, 16KB or 64KB) at boot-time via the
> +	  kernel command line option "arm64.pagesize=3D4k", "arm64.pagesize=3D1=
6k"
> +	  or "arm64.pagesize=3D64k".
> +
>  endchoice
>=20
>  choice
> @@ -1348,6 +1360,7 @@ config ARM64_VA_BITS_48
>  config ARM64_VA_BITS_52
>  	bool "52-bit"
>  	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
> +	depends on !ARM64_BOOT_TIME_PAGE_SIZE
>  	help
>  	  Enable 52-bit virtual addressing for userspace when explicitly
>  	  requested via a hint to mmap(). The kernel will also use 52-bit
> @@ -1588,9 +1601,10 @@ config XEN
>  # 4K  |       27          |      12      |       15             |       =
  10              |
>  # 16K |       27          |      14      |       13             |       =
  11              |
>  # 64K |       29          |      16      |       13             |       =
  13              |
> +# BOOT|       29          |    16 (max)  |       13             |       =
  13              |
>  config ARCH_FORCE_MAX_ORDER
>  	int
> -	default "13" if ARM64_64K_PAGES
> +	default "13" if ARM64_64K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE
>  	default "11" if ARM64_16K_PAGES
>  	default "10"
>  	help
> @@ -1663,7 +1677,7 @@ config ARM64_TAGGED_ADDR_ABI
>=20
>  menuconfig COMPAT
>  	bool "Kernel support for 32-bit EL0"
> -	depends on ARM64_4K_PAGES || EXPERT
> +	depends on ARM64_4K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE || EXPERT
>  	select HAVE_UID16
>  	select OLD_SIGSUSPEND3
>  	select COMPAT_OLD_SIGACTION
> diff --git a/arch/arm64/include/asm/kvm_hyp.h
> b/arch/arm64/include/asm/kvm_hyp.h
> index c838309e4ec47..9397a14642afa 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -145,4 +145,15 @@ extern unsigned long kvm_nvhe_sym(__icache_flags);
>  extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
>  extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
>=20
> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
> +extern int kvm_nvhe_sym(ptg_page_shift);
> +extern int kvm_nvhe_sym(ptg_pmd_shift);
> +extern int kvm_nvhe_sym(ptg_pud_shift);
> +extern int kvm_nvhe_sym(ptg_p4d_shift);
> +extern int kvm_nvhe_sym(ptg_pgdir_shift);
> +extern int kvm_nvhe_sym(ptg_cont_pte_shift);
> +extern int kvm_nvhe_sym(ptg_cont_pmd_shift);
> +extern int kvm_nvhe_sym(ptg_pgtable_levels);
> +#endif /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
> +
>  #endif /* __ARM64_KVM_HYP_H__ */
> diff --git a/arch/arm64/include/asm/pgtable-geometry.h
> b/arch/arm64/include/asm/pgtable-geometry.h
> index 62fe125909c08..18a8c8d499ecc 100644
> --- a/arch/arm64/include/asm/pgtable-geometry.h
> +++ b/arch/arm64/include/asm/pgtable-geometry.h
> @@ -6,16 +6,33 @@
>  #define ARM64_PAGE_SHIFT_16K	14
>  #define ARM64_PAGE_SHIFT_64K	16
>=20
> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
> +#define PAGE_SHIFT_MIN		ARM64_PAGE_SHIFT_4K
> +#define PAGE_SHIFT_MAX		ARM64_PAGE_SHIFT_64K
> +#else /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
>  #define PAGE_SHIFT_MIN		CONFIG_PAGE_SHIFT
> +#define PAGE_SHIFT_MAX		CONFIG_PAGE_SHIFT
> +#endif /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
> +
>  #define PAGE_SIZE_MIN		(_AC(1, UL) << PAGE_SHIFT_MIN)
>  #define PAGE_MASK_MIN		(~(PAGE_SIZE_MIN-1))
> -
> -#define PAGE_SHIFT_MAX		CONFIG_PAGE_SHIFT
>  #define PAGE_SIZE_MAX		(_AC(1, UL) << PAGE_SHIFT_MAX)
>  #define PAGE_MASK_MAX		(~(PAGE_SIZE_MAX-1))
>=20
>  #include <asm-generic/pgtable-geometry.h>
>=20
> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
> +#ifndef __ASSEMBLY__
> +extern int ptg_page_shift;
> +extern int ptg_pmd_shift;
> +extern int ptg_pud_shift;
> +extern int ptg_p4d_shift;
> +extern int ptg_pgdir_shift;
> +extern int ptg_cont_pte_shift;
> +extern int ptg_cont_pmd_shift;
> +extern int ptg_pgtable_levels;
> +#endif /* __ASSEMBLY__ */
> +#else /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
>  #define ptg_page_shift		CONFIG_PAGE_SHIFT
>  #define ptg_pmd_shift		ARM64_HW_PGTABLE_LEVEL_SHIFT(2)
>  #define ptg_pud_shift		ARM64_HW_PGTABLE_LEVEL_SHIFT(1)
> @@ -24,5 +41,6 @@
>  #define ptg_cont_pte_shift	(CONFIG_ARM64_CONT_PTE_SHIFT + PAGE_SHIFT)
>  #define ptg_cont_pmd_shift	(CONFIG_ARM64_CONT_PMD_SHIFT + PMD_SHIFT)
>  #define ptg_pgtable_levels	CONFIG_PGTABLE_LEVELS
> +#endif /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
>=20
>  #endif /* ASM_PGTABLE_GEOMETRY_H */
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h
> b/arch/arm64/include/asm/pgtable-hwdef.h
> index ca8bcbc1fe220..da5404617acbf 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -52,7 +52,7 @@
>  #define PMD_SHIFT		ptg_pmd_shift
>  #define PMD_SIZE		(_AC(1, UL) << PMD_SHIFT)
>  #define PMD_MASK		(~(PMD_SIZE-1))
> -#define PTRS_PER_PMD		(1 << (PAGE_SHIFT - 3))
> +#define PTRS_PER_PMD		(ptg_pgtable_levels > 2 ? (1 << (PAGE_SHIFT -
> 3)) : 1)
>  #define MAX_PTRS_PER_PMD	(1 << (PAGE_SHIFT_MAX - 3))
>  #endif
>=20
> @@ -63,7 +63,7 @@
>  #define PUD_SHIFT		ptg_pud_shift
>  #define PUD_SIZE		(_AC(1, UL) << PUD_SHIFT)
>  #define PUD_MASK		(~(PUD_SIZE-1))
> -#define PTRS_PER_PUD		(1 << (PAGE_SHIFT - 3))
> +#define PTRS_PER_PUD		(ptg_pgtable_levels > 3 ? (1 << (PAGE_SHIFT -
> 3)) : 1)
>  #define MAX_PTRS_PER_PUD	(1 << (PAGE_SHIFT_MAX - 3))
>  #endif
>=20
> @@ -71,7 +71,7 @@
>  #define P4D_SHIFT		ptg_p4d_shift
>  #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
>  #define P4D_MASK		(~(P4D_SIZE-1))
> -#define PTRS_PER_P4D		(1 << (PAGE_SHIFT - 3))
> +#define PTRS_PER_P4D		(ptg_pgtable_levels > 4 ? (1 << (PAGE_SHIFT -
> 3)) : 1)
>  #define MAX_PTRS_PER_P4D	(1 << (PAGE_SHIFT_MAX - 3))
>  #endif
>=20
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index 8ead41da715b0..ad9f75f5cc29a 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -755,7 +755,7 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>=20
>  static __always_inline bool pgtable_l3_enabled(void)
>  {
> -	return true;
> +	return ptg_pgtable_levels > 2;
>  }
>=20
>  static inline bool mm_pmd_folded(const struct mm_struct *mm)
> @@ -888,6 +888,8 @@ static inline bool pgtable_l3_enabled(void) { return =
false; }
>=20
>  static __always_inline bool pgtable_l4_enabled(void)
>  {
> +	if (IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE))
> +		return ptg_pgtable_levels > 3;
>  	if (CONFIG_PGTABLE_LEVELS > 4 || !IS_ENABLED(CONFIG_ARM64_LPA2))
>  		return true;
>  	if (!alternative_has_cap_likely(ARM64_ALWAYS_BOOT))
> @@ -935,6 +937,8 @@ static inline phys_addr_t p4d_page_paddr(p4d_t p4d)
>=20
>  static inline pud_t *p4d_to_folded_pud(p4d_t *p4dp, unsigned long addr)
>  {
> +	if (IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE))
> +		return (pud_t *)p4dp;
>  	return (pud_t *)PTR_ALIGN_DOWN(p4dp, PAGE_SIZE) + pud_index(addr);
>  }
>=20
> @@ -1014,6 +1018,8 @@ static inline bool pgtable_l4_enabled(void) { retur=
n false; }
>=20
>  static __always_inline bool pgtable_l5_enabled(void)
>  {
> +	if (IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE))
> +		return ptg_pgtable_levels > 4;
>  	if (!alternative_has_cap_likely(ARM64_ALWAYS_BOOT))
>  		return vabits_actual =3D=3D VA_BITS;
>  	return alternative_has_cap_unlikely(ARM64_HAS_VA52);
> @@ -1059,6 +1065,8 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
>=20
>  static inline p4d_t *pgd_to_folded_p4d(pgd_t *pgdp, unsigned long addr)
>  {
> +	if (IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE))
> +		return (p4d_t *)pgdp;
>  	return (p4d_t *)PTR_ALIGN_DOWN(pgdp, PAGE_SIZE) + p4d_index(addr);
>  }
>=20
> diff --git a/arch/arm64/include/asm/sparsemem.h
> b/arch/arm64/include/asm/sparsemem.h
> index a05fdd54014f7..2daf1263ba638 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -17,6 +17,10 @@
>   * entries could not be created for vmemmap mappings.
>   * 16K follows 4K for simplicity.
>   */
> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
> +#define SECTION_SIZE_BITS	29
> +#else
>  #define SECTION_SIZE_BITS	(PAGE_SIZE =3D=3D SZ_64K ? 29 : 27)
> +#endif
>=20
>  #endif
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-var=
s.h
> index a168f3337446f..9968320f83bc4 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -36,6 +36,17 @@ PROVIDE(__pi___memcpy			=3D
> __pi_memcpy);
>  PROVIDE(__pi___memmove			=3D __pi_memmove);
>  PROVIDE(__pi___memset			=3D __pi_memset);
>=20
> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
> +PROVIDE(__pi_ptg_page_shift		=3D ptg_page_shift);
> +PROVIDE(__pi_ptg_pmd_shift		=3D ptg_pmd_shift);
> +PROVIDE(__pi_ptg_pud_shift		=3D ptg_pud_shift);
> +PROVIDE(__pi_ptg_p4d_shift		=3D ptg_p4d_shift);
> +PROVIDE(__pi_ptg_pgdir_shift		=3D ptg_pgdir_shift);
> +PROVIDE(__pi_ptg_cont_pte_shift		=3D ptg_cont_pte_shift);
> +PROVIDE(__pi_ptg_cont_pmd_shift		=3D ptg_cont_pmd_shift);
> +PROVIDE(__pi_ptg_pgtable_levels		=3D ptg_pgtable_levels);
> +#endif /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
> +
>  PROVIDE(__pi_id_aa64isar1_override	=3D id_aa64isar1_override);
>  PROVIDE(__pi_id_aa64isar2_override	=3D id_aa64isar2_override);
>  PROVIDE(__pi_id_aa64mmfr0_override	=3D id_aa64mmfr0_override);
> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
> index 7bc3ba8979019..01502fc3b891b 100644
> --- a/arch/arm64/kernel/image.h
> +++ b/arch/arm64/kernel/image.h
> @@ -47,7 +47,11 @@
>  #define __HEAD_FLAG_BE		ARM64_IMAGE_FLAG_LE
>  #endif
>=20
> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
> +#define __HEAD_FLAG_PAGE_SIZE	0
> +#else
>  #define __HEAD_FLAG_PAGE_SIZE	((PAGE_SHIFT - 10) / 2)
> +#endif
>=20
>  #define __HEAD_FLAG_PHYS_BASE	1
>=20
> diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map=
_kernel.c
> index deb8cd50b0b0c..22b3c70e04f9c 100644
> --- a/arch/arm64/kernel/pi/map_kernel.c
> +++ b/arch/arm64/kernel/pi/map_kernel.c
> @@ -221,6 +221,49 @@ static void __init map_fdt(u64 fdt, int page_shift)
>  	dsb(ishst);
>  }
>=20
> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
> +static void __init ptg_init(int page_shift)
> +{
> +	ptg_pgtable_levels =3D
> +		__ARM64_HW_PGTABLE_LEVELS(page_shift,
> CONFIG_ARM64_VA_BITS);
> +
> +	ptg_pgdir_shift =3D __ARM64_HW_PGTABLE_LEVEL_SHIFT(page_shift,
> +				4 - ptg_pgtable_levels);
> +
> +	ptg_p4d_shift =3D ptg_pgtable_levels >=3D 5 ?
> +				__ARM64_HW_PGTABLE_LEVEL_SHIFT(page_shift, 0) :
> +				ptg_pgdir_shift;
> +
> +	ptg_pud_shift =3D ptg_pgtable_levels >=3D 4 ?
> +				__ARM64_HW_PGTABLE_LEVEL_SHIFT(page_shift, 1) :
> +				ptg_pgdir_shift;
> +
> +	ptg_pmd_shift =3D ptg_pgtable_levels >=3D 3 ?
> +				__ARM64_HW_PGTABLE_LEVEL_SHIFT(page_shift, 2) :
> +				ptg_pgdir_shift;
> +
> +	ptg_page_shift =3D page_shift;
> +
> +	switch (page_shift) {
> +	case ARM64_PAGE_SHIFT_64K:
> +		ptg_cont_pte_shift =3D ptg_page_shift + 5;
> +		ptg_cont_pmd_shift =3D ptg_pmd_shift + 5;
> +		break;
> +	case ARM64_PAGE_SHIFT_16K:
> +		ptg_cont_pte_shift =3D ptg_page_shift + 7;
> +		ptg_cont_pmd_shift =3D ptg_pmd_shift + 5;
> +		break;
> +	default: /* ARM64_PAGE_SHIFT_4K */
> +		ptg_cont_pte_shift =3D ptg_page_shift + 4;
> +		ptg_cont_pmd_shift =3D ptg_pmd_shift + 4;
> +	}
> +}
> +#else /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
> +static inline void ptg_init(int page_shift)
> +{
> +}
> +#endif /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
> +
>  asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
>  {
>  	static char const chosen_str[] __initconst =3D "/chosen";
> @@ -247,6 +290,8 @@ asmlinkage void __init early_map_kernel(u64 boot_stat=
us, void
> *fdt)
>  	if (!page_shift)
>  		page_shift =3D early_page_shift;
>=20
> +	ptg_init(page_shift);
> +
>  	if (va_bits > 48) {
>  		u64 page_size =3D early_page_size(page_shift);
>=20
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 9bef7638342ef..c835a50b8b768 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -2424,6 +2424,16 @@ static void kvm_hyp_init_symbols(void)
>  	kvm_nvhe_sym(id_aa64smfr0_el1_sys_val) =3D
> read_sanitised_ftr_reg(SYS_ID_AA64SMFR0_EL1);
>  	kvm_nvhe_sym(__icache_flags) =3D __icache_flags;
>  	kvm_nvhe_sym(kvm_arm_vmid_bits) =3D kvm_arm_vmid_bits;
> +#ifdef CONFIG_ARM64_BOOT_TIME_PAGE_SIZE
> +	kvm_nvhe_sym(ptg_page_shift) =3D ptg_page_shift;
> +	kvm_nvhe_sym(ptg_pmd_shift) =3D ptg_pmd_shift;
> +	kvm_nvhe_sym(ptg_pud_shift) =3D ptg_pud_shift;
> +	kvm_nvhe_sym(ptg_p4d_shift) =3D ptg_p4d_shift;
> +	kvm_nvhe_sym(ptg_pgdir_shift) =3D ptg_pgdir_shift;
> +	kvm_nvhe_sym(ptg_cont_pte_shift) =3D ptg_cont_pte_shift;
> +	kvm_nvhe_sym(ptg_cont_pmd_shift) =3D ptg_cont_pmd_shift;
> +	kvm_nvhe_sym(ptg_pgtable_levels) =3D ptg_pgtable_levels;
> +#endif /* CONFIG_ARM64_BOOT_TIME_PAGE_SIZE */
>  }
>=20
>  static int __init kvm_hyp_init_protection(u32 hyp_va_bits)
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile
> b/arch/arm64/kvm/hyp/nvhe/Makefile
> index b43426a493df5..a8fcbb84c7996 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -27,6 +27,7 @@ hyp-obj-y :=3D timer-sr.o sysreg-sr.o debug-sr.o switch=
.o tlb.o hyp-
> init.o host.o
>  	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.=
o
>  hyp-obj-y +=3D ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../=
entry.o \
>  	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
> +hyp-obj-$(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE) +=3D pgtable-geometry.o
>  hyp-obj-$(CONFIG_LIST_HARDENED) +=3D list_debug.o
>  hyp-obj-y +=3D $(lib-objs)
>=20
> diff --git a/arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c
> b/arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c
> new file mode 100644
> index 0000000000000..17f807450a31a
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 ARM Ltd.
> + */
> +
> +#include <linux/cache.h>
> +#include <asm/pgtable-geometry.h>
> +
> +int ptg_page_shift __ro_after_init;
> +int ptg_pmd_shift __ro_after_init;
> +int ptg_pud_shift __ro_after_init;
> +int ptg_p4d_shift __ro_after_init;
> +int ptg_pgdir_shift __ro_after_init;
> +int ptg_cont_pte_shift __ro_after_init;
> +int ptg_cont_pmd_shift __ro_after_init;
> +int ptg_pgtable_levels __ro_after_init;
> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> index 60454256945b8..2ba30d06b35fe 100644
> --- a/arch/arm64/mm/Makefile
> +++ b/arch/arm64/mm/Makefile
> @@ -3,6 +3,7 @@ obj-y				:=3D dma-mapping.o extable.o
> fault.o init.o \
>  				   cache.o copypage.o flush.o \
>  				   ioremap.o mmap.o pgd.o mmu.o \
>  				   context.o proc.o pageattr.o fixmap.o
> +obj-$(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE) +=3D pgtable-geometry.o
>  obj-$(CONFIG_ARM64_CONTPTE)	+=3D contpte.o
>  obj-$(CONFIG_HUGETLB_PAGE)	+=3D hugetlbpage.o
>  obj-$(CONFIG_PTDUMP_CORE)	+=3D ptdump.o
> diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> index 4b106510358b1..c052d0dcb0c69 100644
> --- a/arch/arm64/mm/pgd.c
> +++ b/arch/arm64/mm/pgd.c
> @@ -21,10 +21,12 @@ static bool pgdir_is_page_size(void)
>  {
>  	if (PGD_SIZE =3D=3D PAGE_SIZE)
>  		return true;
> -	if (CONFIG_PGTABLE_LEVELS =3D=3D 4)
> -		return !pgtable_l4_enabled();
> -	if (CONFIG_PGTABLE_LEVELS =3D=3D 5)
> -		return !pgtable_l5_enabled();
> +	if (!IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE)) {
> +		if (CONFIG_PGTABLE_LEVELS =3D=3D 4)
> +			return !pgtable_l4_enabled();
> +		if (CONFIG_PGTABLE_LEVELS =3D=3D 5)
> +			return !pgtable_l5_enabled();
> +	}
>  	return false;
>  }
>=20
> diff --git a/arch/arm64/mm/pgtable-geometry.c b/arch/arm64/mm/pgtable-
> geometry.c
> new file mode 100644
> index 0000000000000..ba50637f1e9d0
> --- /dev/null
> +++ b/arch/arm64/mm/pgtable-geometry.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 ARM Ltd.
> + */
> +
> +#include <linux/cache.h>
> +#include <asm/pgtable-geometry.h>
> +
> +/*
> + * TODO: These should be __ro_after_init, but we need to write to them f=
rom the
> + * pi code where they are mapped in the early page table as read-only.
> + * __ro_after_init doesn't become writable until later when the swapper =
pgtable
> + * is fully set up. We should update the early page table to map __ro_af=
ter_init
> + * as read-write.
> + */
> +
> +int ptg_page_shift __read_mostly;
> +int ptg_pmd_shift __read_mostly;

I found that ptg_page_shift and ptg_pmd_shift need
EXPORT_SYMBOL_GPL for cases where code compiled
as a module is using PAGE_SIZE/PAGE_SHIFT or
PMD_SIZE/PMD_SHIFT. Some of the others below
might also need EXPORT_SYMBOL_GPL.

Michael

> +int ptg_pud_shift __read_mostly;
> +int ptg_p4d_shift __read_mostly;
> +int ptg_pgdir_shift __read_mostly;
> +int ptg_cont_pte_shift __read_mostly;
> +int ptg_cont_pmd_shift __read_mostly;
> +int ptg_pgtable_levels __read_mostly;
> diff --git a/drivers/firmware/efi/libstub/arm64.c
> b/drivers/firmware/efi/libstub/arm64.c
> index e57cd3de0a00f..8db9dba7d5423 100644
> --- a/drivers/firmware/efi/libstub/arm64.c
> +++ b/drivers/firmware/efi/libstub/arm64.c
> @@ -68,7 +68,8 @@ efi_status_t check_platform_features(void)
>  		efi_novamap =3D true;
>=20
>  	/* UEFI mandates support for 4 KB granularity, no need to check */
> -	if (IS_ENABLED(CONFIG_ARM64_4K_PAGES))
> +	if (IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
> +	    IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE))
>  		return EFI_SUCCESS;
>=20
>  	tg =3D (read_cpuid(ID_AA64MMFR0_EL1) >>
> ID_AA64MMFR0_EL1_TGRAN_SHIFT) & 0xf;
> --
> 2.43.0
>=20


