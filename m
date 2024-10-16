Return-Path: <linux-efi+bounces-1980-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC89A0CC9
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2024 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6868D1C2229D
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EC520E000;
	Wed, 16 Oct 2024 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G9jd2LaT"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3D20C487;
	Wed, 16 Oct 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089309; cv=fail; b=P1/A5EwqvRyodWqBykyLzdvUi/3YlokjRyceBIssnwuvrjn50lwciFLiJR2oMzY2o4KeC2cpj6SHcamyuIiEmIZ0HEYz9tHsxq9rpnJHPgYvwmK1LBEbT0QlOoZnWCEQcAuZqYkhAGvCRz6cWeJ+5cZAii5fZlZldZmRBAgGq7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089309; c=relaxed/simple;
	bh=dm5hOiVGF8yBJj+wVePPMT0PLtPrtPyyX8+cygiBduw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oYQhy3vPahyWMWKuZsT0UpRPMWxonRLtcRc7LRlGIxZo+MaUR6A+JlxiFteRNASoDui82W0rkFSvROrk+7GZu7QOFBdtCvLX4aoSvgWkBObtdk4Uhg2X94XuzMsKynfwR5mEpaB/EuNOATwvFyxReLESbA1iiSu42yDxxddoPD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G9jd2LaT; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7JrxbrkmJT72aRpBRhU3riVWBeRtqARQHd7Om8YTk/wRaWYmTKocoTLvjKL9cw+XcEz9hM9+m6ONDczylziuXKB8U0tQmvy7Vy5XgWFmCllb0tozveE9ila0PFDF2XEZ5udNdl2BXbJ3fpYiH9R8YecFkD8KkCmfErth/cZWmFn+IX0VETGwt6W1/JDEAhfHJAYuztB4AfwPtNyFOs8Po68vb1411YKx2PNCLnyKDuEq5/NkptZP3BR27ecmUGWCM9QpfpStTcGa4u9BV5QBd3SHFTRjW7We+sj7OAf5E1bFcozS5F0l2V0rqUcFsBV02rRl0jNCWLVvcMNIyBuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBQB2GQDmSUSMZwfrZvQNxYyToZ9zHinVenhMKXMM1w=;
 b=WpqqvekGS0a0FNn8QvC7GHd1YuWOQ5HqheRPlZ3cFpah/QSavQN4QbIS5xyCYrvnMXZfQaNBjQ9xJQA1rjkCd/FCs54Uls3fRjFwd4tC9EiCoo4j0asIoGCQzvRsKW7SjSMO0fmrU6Zs+MYs6dPgPS2AFBayMAAxySxNJuLGU9/3/YPDAhJpanvDjEO3MNtDDnWB6rDv6JvBJ2+xpPf+i3LsAWmdeqwx6UdEhYQbXOTzd4dDVpjdx/p2SbLCAz8oI5B/ZMzDseUw5bTnUh3BSfuOC9WdfH+8vGVgjt66LZE2262B1b3SimmfC1QxSjQAqrW3qgJdv8G6jtfcaB4uAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBQB2GQDmSUSMZwfrZvQNxYyToZ9zHinVenhMKXMM1w=;
 b=G9jd2LaTmeeW5sIeOt5/CBQlu6DYK/HEs4N5Jh5aTpLam4v1kj+PlYFOlnnGwA93+LoYz6o0YO2HuHwu2Tw5Mkp3UUq3R1B5hWtlOOaUT5Wq0Vc7l4uoNeQmwWGp77lhQwGv9I0mMnCbJsgltxx+TNj8pLMSB1wm+PnJaSwCyBuTi42rlZ6UabdmVjstp80vwr900dQifjIBKMgfwK4II4mkU0BKwKSKK1zh1SdyXrb6YaNHxJQ7KDZRz6iMsa9om99aRCfnWtnpP+Jz4/E803EKxrqEeurr2tH22AD07W4htdy8DkoWdN6aCoW0j+f//zOLQX8dcvfHaKn8ifrkyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Wed, 16 Oct 2024 14:35:04 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 14:35:04 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Oliver Upton <oliver.upton@linux.dev>,
 Will Deacon <will@kernel.org>, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 57/57] arm64: Enable boot-time page size selection
Date: Wed, 16 Oct 2024 10:35:01 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <8B1AC3A8-514F-48C1-9F9C-A4A29E129788@nvidia.com>
In-Reply-To: <401175cf-e205-4e5c-939f-60b7ab948355@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-57-ryan.roberts@arm.com>
 <CD2DC486-F4B1-4043-82BC-0CB2AA513A99@nvidia.com>
 <daecf1d1-04c7-4513-86db-397c2ef6f768@arm.com>
 <6C0A53C0-C332-46B3-A84A-3232E9D71003@nvidia.com>
 <401175cf-e205-4e5c-939f-60b7ab948355@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_3B303FDF-2AEE-4550-9D2F-014729012A86_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0392.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 19523878-35c5-4ed6-a54f-08dcedefb92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvwuXk1r4ae60Xn8rtT07wy/CDaLxHDXKVTTzJXhp5lR45e/nEj65MXe2bZN?=
 =?us-ascii?Q?8TO+56CDSbQfkmeZLOOSHXtcpjjbHBRSpni8FtsCfhTVyvPdMefQ6JNTRE0k?=
 =?us-ascii?Q?K8XxiS363Dl9Bnazjqofz0dYgvL5CM9U54Z/eu/UUQ2Jpk2/bLZyLsk09Eot?=
 =?us-ascii?Q?O8Sn96ieN0kzH1bBiMknGrOp//3AQfdX0VoqERCR6eKyy2v6B90X/7qE3rR3?=
 =?us-ascii?Q?F4APb5fg0K0lQe/Kbi0HEm9zvZ4nfRQqQW6H8d5/kW10VklPEr0XcuyORK9v?=
 =?us-ascii?Q?hwiv+2koUukhuwaOaxbSRmBftVz7QiI7n/bzy7jV8Bx1fnV8GQ4IgHWyrjc+?=
 =?us-ascii?Q?oFa3oY5H2ExMaYZ2oZrbsRrbvjv/GlJviIUXQ3o/7iZJxv5nlwKlq0F+mfUj?=
 =?us-ascii?Q?sbATw7Zw8B1Yc5XXOlKBbx/BxtzI/I+XXl8h3E4mvAa0jYT2dz0XC33ta42Z?=
 =?us-ascii?Q?CU1r+DL1fptqzjCI32EIztmhb+0LyASBk8uaODCG+3l35aJzdN2Bf6hZoLBv?=
 =?us-ascii?Q?O4n284YTTqOBRsZLIzQURWhlwue9Z9FH8skZx1zdojbP7ltpO36uCXmwKPUu?=
 =?us-ascii?Q?H0GWRhyhO/yBiyePC5Zl2DJgQWbX1LhmYkbgGRhoULy6YxoAtNLasc8dYKGy?=
 =?us-ascii?Q?oWOpwunIkhiGwXpashmAUJhJFTTLaeUZHIY5EGAqQtrN7pv+wOaM7jMfjsKj?=
 =?us-ascii?Q?ekUvgDsdPzV2AGl2GKp9+wDGjAyaejFkNbzgk5GqyTuEhWP0fUCbvS/6RmD9?=
 =?us-ascii?Q?VlzclSzWQgwnkgmkdfRGB2rKAk3zoY0+0TOhiiGqYMNoDsUBKNXQl+rvfNYl?=
 =?us-ascii?Q?uyUYaKccXmR/wrJb3QWu0GkmE7tUiNUPK8htX31qxRcbIhN5KN7+lPVkcC+U?=
 =?us-ascii?Q?1o/MCTm1+zBUIeZzvrZYiKGo+RA5w3NT5D71mlgzvOFCCad0928dNM8TY9Gz?=
 =?us-ascii?Q?4qxT+LFybX95gJOrXjcQCDFWygEWXFlTaJAVVVUYt/3XyHAofAwuGAqUGvuc?=
 =?us-ascii?Q?DX4ysHjX3CY6R1iv6asL+6lqONTSN+0F7AlgWXaZ5kHE2BfRv/ZWmef35Tca?=
 =?us-ascii?Q?VOUJdsL4kn17syV3nyWerswEbatAcCHaVwJ8mAA9LJj8L9Z+tzDhH6etEJr8?=
 =?us-ascii?Q?7nZrH1oO2wPTRvlkpOZUih+b6fL+o39ITfnS96xmcskyAKbPo+Mlw4N9HZsN?=
 =?us-ascii?Q?yoYCjLb3oFnKMZtQ9mFivvTUAiE+yFMiIfhYIPg6hgEyCRidZQVeqWqogHE/?=
 =?us-ascii?Q?zFarzlJ8dmeyFBh/M7UqvHg9Dvgq8vdd2slhZNvVfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kaO70DfQImsW4PET/UmAHL0WVNnqqZ5NLYv1arJK9JDzcFX5aqpY7YARn1UG?=
 =?us-ascii?Q?CMle9gjGUUypoQ0m4UZYxSUZcz7XFV2SyPktstSkpZXTbALITRqpZ2eDxSak?=
 =?us-ascii?Q?CLv+tEazpbTtb+df7v9qLMiSaqFOI9B9eqN681dVHzRJ/bbOGW5WR63TuJnD?=
 =?us-ascii?Q?BEGPbKT+9IIy05GkaQ3FVR8k0cMNs+qiuqXq5o8EpFzZHhERnNC6Y37tiqA/?=
 =?us-ascii?Q?GkFhQ6fi5k8a2S3DcCf4qmILS9+jkhqCMO3o5UZBjm8gQz55nxhVH6K3SZtL?=
 =?us-ascii?Q?B/e02DrjJi25JKP+J9MrdWUEqbq5ODZUCgWcwACayDlVjqTmnGs/0I1/CoE+?=
 =?us-ascii?Q?uSGKUL5X6kB5eeoRPfkpURAPtFEZQNKXA9KcGMLzC+BmUhxqfkuWo1HPdHqU?=
 =?us-ascii?Q?fTb0Le3L0OjTQI9Xur61EEtYy+iYP8bXORP20zC1E768xzW0JkHy5OqYDogm?=
 =?us-ascii?Q?NcdxCr7yvtdxOOd7kDJZmDWWZSrVOgQz2EBb2Kq3BpSZttiiBxYrioK5EKP0?=
 =?us-ascii?Q?s3e6/KnZ7C6uzVO8d7u0k2pKZEmKfSFWRGm3tAVvdU3xCJxMus5a+6buOLAN?=
 =?us-ascii?Q?cVY3OOlUGMLCUo5xTQbE9OK/yfv8UkzTgWvFQuy7fksLhVE1m+qvlIzYrFBa?=
 =?us-ascii?Q?9/u2O7lSEd3JrlypOI50tSG9lYopfqr6X+qOq1tj0UVvtJGGvz/GBR4zpHPi?=
 =?us-ascii?Q?Azdpv3KKRMMjNDrdOLVWMboSFuAbSaIABXoS9PaQY0uB0a0Ev61//DsnzRYZ?=
 =?us-ascii?Q?gXQW7CUUGTUs4zJWhIJxHJVy7RpQrzNyVj7aPCEomr36PreBo9xxl24J06O9?=
 =?us-ascii?Q?9ThkLND+UEWiEAKC5ZHRmktBhgxxYqOt5JU7mXWIEcHwixcQKMwPTnD6EdOe?=
 =?us-ascii?Q?QjBOBkk4Umw4lYegq92sdpqEbI2vtSIyHT9E5S78w4O9crp3sMR2Vy7W3xZQ?=
 =?us-ascii?Q?SFNUrj5DIKRwiCwKIYR56D9s7+Q0f27SDoxq4ZraKwEtcrLwiqFCYZ8k1trT?=
 =?us-ascii?Q?Id40NPymRBDKZQGuZ/iz9Cr7MFsoiIcMD6uFyDg15aaKVsZWbTVxuW5aBx3L?=
 =?us-ascii?Q?OMXMTTQOu/O8mO0tKhTJ3nlVnzUOwjvP7kLgXWIG95Zr7tfopoOXqutkCGL1?=
 =?us-ascii?Q?Q0N8EXCYuy6++6P9tCCis6kdDT1H3Gxm4Jj6vGVbBK5SQgZBK5VPAHDcTgkg?=
 =?us-ascii?Q?Nf1VWKduvlrnzI5YGt05ANiKX3oilcDXtf6PSu8ZIbg6sDo28lBqMqOO+Ane?=
 =?us-ascii?Q?sEtxDtnPGXUqhkHKzex+Req7HDFYwg3HUNYEMLnfK6k8ckFgnfEsOODmyLFp?=
 =?us-ascii?Q?p7Ly6fBw4lGgP7yc0Owd27ZwWxkj7TAFX+YrqZOpSTXfmqEperuaFSv2Q6av?=
 =?us-ascii?Q?uIyRj8z3xWTLUxgQEAqbU12VGV4Z5jPk+l3rlfJS/4q1CPY4yVV93PpioBcE?=
 =?us-ascii?Q?B9x1mwlJ2ZY9Tc8Vlq3ulhQZ9DOVsGbSBxpqhw7UA6297yjIMqanmifRHsS9?=
 =?us-ascii?Q?GFIdsCsdT7XbYq5eBV5hKyQRDV153r7IQtGVYBk7aJfrfRtAvw2yBAvZopkX?=
 =?us-ascii?Q?cK+Tx1L4pqucG5B/+PClxpvL5jzTxJm14oJT/5vY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19523878-35c5-4ed6-a54f-08dcedefb92f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:35:04.0581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1nsgeUEr/mWtTnmENm2P3Sl/0rXbKHL6ixrLXidQFpwS4nplwNBjLggH4ygMjjQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244

--=_MailMate_3B303FDF-2AEE-4550-9D2F-014729012A86_=
Content-Type: text/plain

On 16 Oct 2024, at 10:31, Ryan Roberts wrote:

> On 16/10/2024 15:21, Zi Yan wrote:
>> On 16 Oct 2024, at 4:14, Ryan Roberts wrote:
>>
>>> On 15/10/2024 18:42, Zi Yan wrote:
>>>> On 14 Oct 2024, at 6:59, Ryan Roberts wrote:
>>>>
>>>>> Introduce a new Kconfig, ARM64_BOOT_TIME_PAGE_SIZE, which can be
>>>>> selected instead of a page size. When selected, the resulting kernel's
>>>>> page size can be configured at boot via the command line.
>>>>>
>>>>> For now, boot-time page size kernels are limited to 48-bit VA, since
>>>>> more work is required to support LPA2. Additionally MMAP_RND_BITS and
>>>>> SECTION_SIZE_BITS are configured for the worst case (64K pages). Future
>>>>> work could be implemented to be able to configure these at boot time for
>>>>> optimial page size-specific values.
>>>>>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>
>>>> <snip>
>>>>
>>>>>
>>>>> @@ -1588,9 +1601,10 @@ config XEN
>>>>>  # 4K  |       27          |      12      |       15             |         10              |
>>>>>  # 16K |       27          |      14      |       13             |         11              |
>>>>>  # 64K |       29          |      16      |       13             |         13              |
>>>>> +# BOOT|       29          |    16 (max)  |       13             |         13              |
>>>>>  config ARCH_FORCE_MAX_ORDER
>>>>>  	int
>>>>> -	default "13" if ARM64_64K_PAGES
>>>>> +	default "13" if ARM64_64K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE
>>>>>  	default "11" if ARM64_16K_PAGES
>>>>>  	default "10"
>>>>>  	help
>>>>
>>>> So boot-time page size kernel always has the highest MAX_PAGE_ORDER, which
>>>> means the section size increases for 4KB and 16KB page sizes. Any downside
>>>> for this?
>>>
>>> I guess there is some cost to the buddy when MAX_PAGE_ORDER is larger than it
>>> needs to be - I expect you can explain those details much better than I can. I'm
>>> just setting it to the worst case for now as it was the easiest solution for the
>>> initial series.
>>
>> From my past experience (around 5.19), the perf impact (using vm-scalability)
>> seems very small due to MAX_PAGE_ORDER increases [1] (I made MAX_PAGE_ORDER
>> a boot time variable and increased it to 20 for my 1GB THP experiments).
>>
>> Larger MAX_PAGE_ORDER means larger section size and larger mem_block size,
>> so the granularity of memory hotplug also increases. In this case:
>> 1. ARM64 4KB: mem_block size increases from 4MB to 32MB,
>> 2. ARM64 16KB: mem_block size increases from 32MB to 128MB,
>> 3. ARM64 64KB: mem_block size keeps the same, 512MB.
>>
>> DavidH was concerned about large mem_block size before. He might have some
>> opinion on this.
>>
>>
>>>
>>>>
>>>> Is there any plan (not in this patchset) to support boot-time MAX_PAGE_ORDER
>>>> to keep section size the same?
>>>
>>> Yes absolutely. I should have documented MAX_PAGE_ORDER in the commit log along
>>> with the comments for MMAP_RND_BITS and SECTION_SIZE_BITS - that was an
>>> oversight and I'll fix it in the next version. I plan to look at making all 3
>>> values boot-time configurable in future (although I have no idea at this point
>>> how involved that will be).
>>
>> In [1], I tried to make MAX_PAGE_ORDER a boot time variable,
>> but for a different purpose, allocating 1GB THP. I needed some additional
>> changes in my patchset, since I assumed MAX_PAGE_ORDER can go beyond
>> section size, which makes things a little bit complicated. For your case,
>> I assume you are not planning to make MAX_PAGE_ORDER bigger than section
>> size, then I should be able to revive my patchset with fewer changes.
>
> Yes correct; no need to make it bigger than section size. Thanks for the patch,
> I'll certainly use it as a base when I get there or if you're interested in
> doing it then even better ;-)
>
> But I don't think this is urgent. For now, boot-time page size is a new Kconfig
> for arm64. It still supports the compile-time page size options. So having a
> larger MAX_PAGE_ORDER than strictly necessary doesn't represent a regression,
> just a limitation of boot-time page size config - something we can optimize later.

Sure. I will revisit my boot time MAX_PAGE_ORDER patchset when this patchset
settles. Glad to help. :)

>
>>
>> In terms of SECTION_SIZE_BITS, why do you want to make it a boot time variable?
>> Since it decides the minimum memory hotplug size, I assume we should keep
>> it unchanged or as small as possible to make virtual machine memory usage
>> efficient.
>
> When I say "boot-time variable" I just mean something that the arch can
> configure at boot based on the selected page size. I'm not proposing to allow
> the user to set it via the command line. That means we need to rid the code of
> any assumptions that it is compile time constant (e.g. c preprocessor usage of
> the value, etc). The same goes for MAX_PAGE_ORDER and the MMAP_RND_BITS stuff.
>

Got it.

>> [1] https://lore.kernel.org/linux-mm/20220811231643.1012912-1-zi.yan@sent.com/


Best Regards,
Yan, Zi

--=_MailMate_3B303FDF-2AEE-4550-9D2F-014729012A86_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmcPzxUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKDcsP/0FwZafyBDetn+/HtBMm63Vi2W+LZ0OOM0Tx
wOhIy79WDEsDstv7N3ePwLUKSjR4aL3mxVxMpPHyZwjBV9lRravBXqvyevkMOmgS
OlY0Lhj6hGDAx3lwp8buRImXnwhnkb+kyyaYhYi+4KnjLLvswIjZ1puAwzIvllnz
pq0Loz2g9FkVLtohE4gAoQt6XBgolsuqb9nfDRL/erAfp3wkMC3RsrbigxjZ2Bdd
vRvyIizup0DLFhJa1sBxNdLy6Rl+kZ6JSYNaYFSW+im3zKYKnl/Gp+bKfLqM2Chj
1mGrntGETpZawzRc/xfUfmiLSkkni7uK5wjnpXoKH9HuOIDMj4PA/Zd6lhZMtKj0
GKxElckfvGAP10jbAFQc8zHgDfLgL0IZSppzG5Zg6AND+2JZwmLxsduSrIUcXMfW
EHIL6vhunUq9ScW0MDGQeN4FFHiLoy4AiydV8LbVY1RlNZvQaK2OAAzQEnYD+Y1x
5qmXTf1iw0TirU5+95awoogYnvktNzheKfLBXzuIHjpaKbVQ6sR22UZgsWkI+r2I
godwyL7mzgg9KWFUUIUrpUlnF0oEa2aBaMOTqFw8JdFTYAeKcq8dKmmhhRZaQ4zk
0pWH53yW54Gm+h8zveIsAYXTz/fGwWQqAVn/Xec85e2DZTj/KfHeTd1qnyjIk+cz
wQa95b/P
=5CIG
-----END PGP SIGNATURE-----

--=_MailMate_3B303FDF-2AEE-4550-9D2F-014729012A86_=--

