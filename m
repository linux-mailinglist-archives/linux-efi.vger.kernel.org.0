Return-Path: <linux-efi+bounces-1978-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFD69A0C7A
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2024 16:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CA31C209C1
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2024 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803D41422DD;
	Wed, 16 Oct 2024 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZklIxHf/"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1621E3C1;
	Wed, 16 Oct 2024 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088489; cv=fail; b=bJt1Ldh5TWakIQ0x9QhhRBIgUPdwMtSqlfDD+2EKv8CiECgQkyw3+TgJ/37R+hRFvYQxhKSGE1BaRvi80zjU8QKS3iH8kP8d1oDO1vAxUiAG2VVEiEGd8/g9AHOmuBle54l5hkGm7P4OqqBfD7O0hx7u2ECsA2t2elNado0K0Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088489; c=relaxed/simple;
	bh=GBMtQ3Fdh6sp79slgX5cBNZ8JpvCuoP69/jH4ptIq7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H44ylMQl4zaYisPHOIAoNTJ3P5YWatzRKIrhKzIk0GJR7NvCfl1GW6Z3A2u42xsk2oWIsvkNiNa652eu1/7rYx/LzMGk2D+YEXimsGut81hPsvet+3opX7L76pLvdraF+x4fRUDv+8iIqjdYuQ6LPR9GI9GjImItbbvclMxCrjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZklIxHf/; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h29IE96nul1VhrRW79v32whG4F5C6FS1G1v2C5E0eOvuktCNnwFKkNss6arMSb0e6zhVNiHvGV965KDlc6VBgM72djMJrGoGOYamoq+7uuDzZjQBIDfTWy+3UM8fY5TptgjnVpATfakpydTnKblcZCBG0q5RYCCTvEUc4SpoXK/PCY6xzK+q6jyJzxUr2USj939sJMoa9cyxjoPDvLqhNB29hh72JMcDzHtc/VMj8mvgGBlpzl514c99IaF4R9OoadgqPG353vLVsGvNL2eIQ+ieaP3TZDZS8cI3Ku5H0iwRgBH0jxoB4H/e8SbWZpChlmvotRoQJf5cGfpQ7ML49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk0BP6yrSFYB3xtvTxZUcxiHOjcjKmeh2pNLtLMzCPU=;
 b=tRgtvW2YQEwr+0wqnHW9+k7870npd8Bo5BlQnhtK3DjKQAYiSKPeu/pUe6Kyg7e+4xsmK54lWjOKYt4o/zKvn1hOs5PQmbSkiiesGE2ysAFkb0z66+NBXcO7w/iCTRkxtDCuyu7ubQDzq6wd0J4oDznC7u9yBE6rVGHaPsfBy9kjxz3fZoKwE7B/GcT9m9U5vhGONfU2ycu8Gt3+6zLqDWYzjECT6TlEM/KTpFCDztmwU/NM62sGToNAdNj+bSiZSlmx53oVzhJEJRodd5jjBs6d9VmRITSyF/XvAPJ6B5pL8ivO+ec6Xsx6+wEX5YJT3cig8hsmeQD+Mn3CAx/f8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk0BP6yrSFYB3xtvTxZUcxiHOjcjKmeh2pNLtLMzCPU=;
 b=ZklIxHf/AgaY/Q1xfXeyqqx59WSR6gGlJQfF5WaCNy/8BatrvbYf0xaDEl8U+ePHPcrvFbSD7B93xRoqWBTmxazlrAUW0Zq0S6VujU8Pt8b+r5Q2bxfh7qfA+IrsGJtAzuKpfWTV8NY1dy/bKluovdvQgSd5egjNJJD6+2PQ7WnUJgzriqCH+kTsZfIqjez3ejSv3j+0QjH1CZwcQPwFRe8u7J06tmBk8OzKnhrZ3KodbUGNZmaSpqEbqOFkjTAFVwDVYXACVhblsljW4yNKZ7dxRNiaQ48pjgp2PCrK6UjDqdV3uoEaJU8ggPp2N3MqFG0kjd2f96MIZQX9jRJuxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 14:21:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 14:21:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Date: Wed, 16 Oct 2024 10:21:18 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <6C0A53C0-C332-46B3-A84A-3232E9D71003@nvidia.com>
In-Reply-To: <daecf1d1-04c7-4513-86db-397c2ef6f768@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-57-ryan.roberts@arm.com>
 <CD2DC486-F4B1-4043-82BC-0CB2AA513A99@nvidia.com>
 <daecf1d1-04c7-4513-86db-397c2ef6f768@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_8B77AFF2-B39C-4BA1-B5FB-D7051CA6DD16_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:208:238::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 066f0854-90db-4b43-f1c8-08dcededcfdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GdykYoxz5oaPLPE4XoEdEjd+IRFedQHgXPHDTIjRZIBjF5CnCtxSX1Yjkv8M?=
 =?us-ascii?Q?Mmdz5yi7XspPv9KiKRnztmRjJNeL7I9yzX9xNP9eS2ovy33epcBRrPEtuRzl?=
 =?us-ascii?Q?Ez4XTKf0RoJ82PRCz3WR/ycFR1SJ9hkMH9mR+PcVgvcElhUC+1O7qni8W6ql?=
 =?us-ascii?Q?++cAVefzzh1mIW+jHD+VQyLGjAdJo785bdcKVS7S0kd2Uka+lY4pRCDNHJhH?=
 =?us-ascii?Q?ODH4Re2ihnLiZUpAqfXCdLNMJR04osRH0KmdPpDpqkx0lVGI2cmI2/vjFS+X?=
 =?us-ascii?Q?v9yp6Xd3gqi8PS/Ugzwz4IWXQsxbEKl2F6cVp08tAcGcg/FdU3DrfedmM3XS?=
 =?us-ascii?Q?2CuVK8zSVMWC3+JfB75X8Fyh5WF9fL2zEAv7igv683PXWhQ3qsfo5VIxOCtO?=
 =?us-ascii?Q?sHD9iXfpSiFErzJruCxZ2j6ylOqe0EnHLsQv6VJcoNnFwR78PHoYWzqvrRrT?=
 =?us-ascii?Q?uT1Vf7tQnRpSSllaCc5DdO/tbLKRUuPa8bl+Xljafy9FEREU55sWiV1oLdMI?=
 =?us-ascii?Q?SfaMfp/x10St34xwF1s3iOVrCPPrjRuCPDr8pwKlo3YnI0KD3oY8yRBLw6LH?=
 =?us-ascii?Q?Rp5kaYLj2yGLa4H0TnPlqVav5WJq80aJcxgqn9Blgjg5MbHzWwIe2fdWOc20?=
 =?us-ascii?Q?UIXzfT0/Z1BfdnGwj43gMfSNYupVx39THfhGfcyJH3k+Qrm7Vd9FP0m7voCn?=
 =?us-ascii?Q?Qhj/V5zGY3vWjFM9riQ1LaJkLCD1NN2zf7fIM5epRW3xdEIaLEQ7mgumhK7r?=
 =?us-ascii?Q?+JZiOQxY36yvg9OgOdRG8q1TxfAHTg6e9WCKji+UI4w7rez1nr48fdsFMQ/V?=
 =?us-ascii?Q?CUSS1fDXLvUkUwPhWLZCLfEhUP2oa79zLdyesbkWmSsCwaGbfhUTU4/mdHgx?=
 =?us-ascii?Q?JxjHl9Z97UY45/2+5HYzFk1KKYmP3+yeSZgv5BNLTRFBFScbHd0c7Pa0tPKd?=
 =?us-ascii?Q?3eH1zRZPAgPgkqu8NKxFhoALRatINHVVbzuzbmDHrvmsA0qEPplUFwkyh4nB?=
 =?us-ascii?Q?Hq3XOVBeBWro9QpUM+x9Wj4whIFk4QlJBQbsfwzxD85nC8ZNvdRAbXvpCJZA?=
 =?us-ascii?Q?Npe8TWn10gPuD/f4LViMlc3DEfZKtBcDJEkPs1co/9VLIHkzqZTOp8HjykgI?=
 =?us-ascii?Q?9TT8yK7USQJXzX/6+7aTVbrwIRDt/enct1QvHjlErrOVhBIMNVusTwpGMKvc?=
 =?us-ascii?Q?48B/a5V2xvHufP7IQrxsml+9m8WuIrs8MhP+Nv95cmWPwyvpL60kFvgBwclX?=
 =?us-ascii?Q?Emr0JvYrstnO9vIloRWDFt9e3bnfjUu5YbLPOjikPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jEiZIm9nlElmczEEwRdX4J7e1/xjZ9vTlMgMOQ1h5cC8VTHihyGsLaM/Edq2?=
 =?us-ascii?Q?5LfkPb2mBx21DvdVHxGzPbeZPEbkrfNisuBRKMgraxHWkEUmjL2eky2SIgE1?=
 =?us-ascii?Q?M1+bxu5AgVjmlDm1pTWWAhujs6NQ6tF4NKYMCkcvwtIfSjah10frQPnpj985?=
 =?us-ascii?Q?mit2Xdo2tFUXUF74o2d5E0BLtB7rmkxUq8NAONiWwI4DMHudmWmR8P/t+yg0?=
 =?us-ascii?Q?bxA6MnnvdGHiQj5PLUSIdL6DTFIdxSKShx+aRh2fKQuYEnfayCjMLmGmCgcE?=
 =?us-ascii?Q?K1D2dO73GEA4jsJRlD3I8zzEPtxWM8uANFFN+FiA4CxQqAR1FtJa9bxB6wO0?=
 =?us-ascii?Q?Xc7waySrvkb0pr20uk1UG7K2OsjqE9JrwNcflhJ4jC5gyo9YSZ9Wp4izfs/H?=
 =?us-ascii?Q?k4DtVl+NbM89n6DxY8AnJQGR4ts8TvjKiljqe6LVWGscbcsytYgyprh9ygiG?=
 =?us-ascii?Q?5sWAV10CTyHWkkblzXvYX8dZYJcf9FVM2bYPH/H/hPmQtqZCEOPWQtZdaIwp?=
 =?us-ascii?Q?ZgDIX5jhM1OOvlwXZibGghbtzeKih7DnDJ9h0gksE4PbtNhEh1+X4Ewwqcl4?=
 =?us-ascii?Q?D8FgqgSSlrIv6WQLgn6VsHJI9m7oZKxK3k0fGDo59i1vaeXPThDll91I6bFO?=
 =?us-ascii?Q?Mu3x/b0w8OsZ7f3uSIrCAEeP+dLhDu3duz7wfzeUI9bJA7/bh69taITRj0pH?=
 =?us-ascii?Q?LnI7Ifi0TKj0EnBDBgKQn6lLoYs+Bq3lTGgEgfRVJPSBfIUvvpaY+ofpdW9v?=
 =?us-ascii?Q?SfnY6CnwJDDBChdVpeJ85zvRm3uv0YOOOcrZjD6i/QiUfYC9SISzmCG3qmnn?=
 =?us-ascii?Q?Q6xjd+csWUiEx0lI8R81Oyy93lGV5u7DGYczClvLCqNOj/hHSVblS3hgR+WM?=
 =?us-ascii?Q?USvt9sLt72jFxy0qeiGEC05DGTb8YwsWDJzk/ru/LovkMCuOFBO3Tf/10WQe?=
 =?us-ascii?Q?d5iimEk+99aM3hFU0/hOMEe/IsmFYnskTjoqfWaSlf36ab//lnjTyAHxtcGG?=
 =?us-ascii?Q?qYHk4a0t/Cb/csk84yiODowm5UtGvMlualo0MgHKAofs8Efg4zhvfDPkwn4F?=
 =?us-ascii?Q?RaC+uviabSc2p+0/WGM6LyXk1CDyRyl+dATsWBor4ubXb6o1Bmh7WJo0DhwW?=
 =?us-ascii?Q?nG9tWDVBNTvhAr6eXxCmIUy/ekGP2P25ztpsmPRcHeJFvlM03iL/e4Ge/wLC?=
 =?us-ascii?Q?+o+RgSVc00rdRzjEiVznwx+60r6E1gWRXxuXk6MB1lK//bGRosysk2WQZDYf?=
 =?us-ascii?Q?yM7N7ozs8MHDqnzvfdQ4XtULmgjWuVlbJbO3UG1Er6Q63YI8jy11FPrqzk+n?=
 =?us-ascii?Q?BIqdjU8/zSxudQN9hhZXx/hCAQEPYSSZB+VdlU31E0T+ILOrJGpuRH62J1+x?=
 =?us-ascii?Q?ZMy0xqd+qML/8gFo4oLrkV5hoPcV55VRtNm5SkN+f/jO/L7wCzog0wBq/XNq?=
 =?us-ascii?Q?TsDBgQZK2mW9C0kmnL+94ZWTHoFBh9D+T/FgJKnM/6VuFp0irnCVtiNBbHT3?=
 =?us-ascii?Q?PwC/58kZi8bxblMcxbwQLJikcGmMdd2KMQjgDjAr7OmQWWxNNRZeHqkLQRKx?=
 =?us-ascii?Q?8rB48bGHZX+SjRNulW1P3TGqhlpdsFdlBNIrnphQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066f0854-90db-4b43-f1c8-08dcededcfdb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:21:23.1214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMsyJViJEG2XLx2kxjhdhHHeN7pZdIA9lHAGZFqy0l2dj7/82/p35yJ1cC/B0qlZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237

--=_MailMate_8B77AFF2-B39C-4BA1-B5FB-D7051CA6DD16_=
Content-Type: text/plain

On 16 Oct 2024, at 4:14, Ryan Roberts wrote:

> On 15/10/2024 18:42, Zi Yan wrote:
>> On 14 Oct 2024, at 6:59, Ryan Roberts wrote:
>>
>>> Introduce a new Kconfig, ARM64_BOOT_TIME_PAGE_SIZE, which can be
>>> selected instead of a page size. When selected, the resulting kernel's
>>> page size can be configured at boot via the command line.
>>>
>>> For now, boot-time page size kernels are limited to 48-bit VA, since
>>> more work is required to support LPA2. Additionally MMAP_RND_BITS and
>>> SECTION_SIZE_BITS are configured for the worst case (64K pages). Future
>>> work could be implemented to be able to configure these at boot time for
>>> optimial page size-specific values.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>
>> <snip>
>>
>>>
>>> @@ -1588,9 +1601,10 @@ config XEN
>>>  # 4K  |       27          |      12      |       15             |         10              |
>>>  # 16K |       27          |      14      |       13             |         11              |
>>>  # 64K |       29          |      16      |       13             |         13              |
>>> +# BOOT|       29          |    16 (max)  |       13             |         13              |
>>>  config ARCH_FORCE_MAX_ORDER
>>>  	int
>>> -	default "13" if ARM64_64K_PAGES
>>> +	default "13" if ARM64_64K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE
>>>  	default "11" if ARM64_16K_PAGES
>>>  	default "10"
>>>  	help
>>
>> So boot-time page size kernel always has the highest MAX_PAGE_ORDER, which
>> means the section size increases for 4KB and 16KB page sizes. Any downside
>> for this?
>
> I guess there is some cost to the buddy when MAX_PAGE_ORDER is larger than it
> needs to be - I expect you can explain those details much better than I can. I'm
> just setting it to the worst case for now as it was the easiest solution for the
> initial series.

From my past experience (around 5.19), the perf impact (using vm-scalability)
seems very small due to MAX_PAGE_ORDER increases [1] (I made MAX_PAGE_ORDER
a boot time variable and increased it to 20 for my 1GB THP experiments).

Larger MAX_PAGE_ORDER means larger section size and larger mem_block size,
so the granularity of memory hotplug also increases. In this case:
1. ARM64 4KB: mem_block size increases from 4MB to 32MB,
2. ARM64 16KB: mem_block size increases from 32MB to 128MB,
3. ARM64 64KB: mem_block size keeps the same, 512MB.

DavidH was concerned about large mem_block size before. He might have some
opinion on this.


>
>>
>> Is there any plan (not in this patchset) to support boot-time MAX_PAGE_ORDER
>> to keep section size the same?
>
> Yes absolutely. I should have documented MAX_PAGE_ORDER in the commit log along
> with the comments for MMAP_RND_BITS and SECTION_SIZE_BITS - that was an
> oversight and I'll fix it in the next version. I plan to look at making all 3
> values boot-time configurable in future (although I have no idea at this point
> how involved that will be).

In [1], I tried to make MAX_PAGE_ORDER a boot time variable,
but for a different purpose, allocating 1GB THP. I needed some additional
changes in my patchset, since I assumed MAX_PAGE_ORDER can go beyond
section size, which makes things a little bit complicated. For your case,
I assume you are not planning to make MAX_PAGE_ORDER bigger than section
size, then I should be able to revive my patchset with fewer changes.

In terms of SECTION_SIZE_BITS, why do you want to make it a boot time variable?
Since it decides the minimum memory hotplug size, I assume we should keep
it unchanged or as small as possible to make virtual machine memory usage
efficient.


[1] https://lore.kernel.org/linux-mm/20220811231643.1012912-1-zi.yan@sent.com/


Best Regards,
Yan, Zi

--=_MailMate_8B77AFF2-B39C-4BA1-B5FB-D7051CA6DD16_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmcPy98PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKrW8QAJ2uBRtl+yXCwoBAaqxvhEeK7DB+wQzwCrQf
rPFdb4WCXunE2bn5FNAOPqzNGV4BJhM/zkUgbcdeE5hQZ/16aVZbzbVI8lMhG+SL
RYdRKcT7+MzEH0JqbalpW4BqTr4uqQNcTiiSCyiS+gtNqP0+g0dVWrIdd6tcbdK4
E7Lfu7hnQFD754/Ej6nvT4nMHfOViNauFVyh7wLEtw7XJu9cSEbvQWv0awM6kLQD
GoSUQBOInFu8otVpQ5T7rlltLVP35tWJVEV1iSVwnNpumVnwYGC6ajq/7ulanqyZ
nd0FZ/Qo+4m0aw5QWLFqKFxXP7hqH9F35rI5cbXdl+8z/2egK7PK6Hqt2SFDdJbV
loU4T6HAiMmK54hg/ssT4h96YIumUR9dzwixFJPUmlTlewZtTEvx7Z9TpCs2Q5Oi
EylqTG3H1W9yJEFSoW7V2ONkmqGiSamJcBZ1qDIUn9nOT4FMIRaYRfvkXk1mPjuI
okyAcs4erYl41OBCOEDz+6ZjbDECYd6piWUzv/f2v43LjBuZJreI324H5w3kLtlA
nCAxMjbdmmLeKh/uL7d7nLX1H4lcEcWJObiQEbXl0OOY5ePp9wn61LoK5kMA8k3f
urOorSjfIqbe0vkmWX389dIiIqxTvXxdT60pUwQLTF5AVdi/xCBn1P3RSLnlpHtq
zyJz9smB
=N6Et
-----END PGP SIGNATURE-----

--=_MailMate_8B77AFF2-B39C-4BA1-B5FB-D7051CA6DD16_=--

