Return-Path: <linux-efi+bounces-1967-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69FF99F446
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 19:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F086C1C2240D
	for <lists+linux-efi@lfdr.de>; Tue, 15 Oct 2024 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066FC1FAEE0;
	Tue, 15 Oct 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k4W36UB/"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FC01F9EA8;
	Tue, 15 Oct 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014151; cv=fail; b=IwIxwZwSfRU7D0ZylYEY3wNbflgVIkrJ2VEgZdEcHqjROucKER5/taV+AFqTw1PSCqIecDonpi+QBSSFoVemaMwrqmpBlj8A34T1Yrt0POk6diio4AYmJ8gTCRlTf69riXsPQvexWmbZehqWZ1qETilIjY1xaAhi8Foq8DQMBnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014151; c=relaxed/simple;
	bh=o9AxbLfGdbRJdWIIdT66qjHjTVP1kLULes/J0EvMDc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fnYxAjFh9ktqpk/prE735Ng5bn7M4JFVYlfOQwyEarhsPIoQ6xIoq9iycoS6/ZGMJFcaU770TnJ4jY1A0S0pJPwI1j8Uy9S6os1jQUhkOz7VKG1BJfbGf0t2sNsPo/YdN3Zc7hcZBWUd2Thx8vzi5wDd54pNz+SZcRhBbeSwelA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k4W36UB/; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXoH2a6UHVWJ6eRp+LbqDtw1CFYQWzfgGII0OIWZcBigGr1W9q58nK/eDD8fQddO+qVpIHKF0bUYuuvU5JQYfMdPaAecGLd5VHPJEwH1y30I1j3mv332QzOfPRASk/AT6fGtJAIxixGKKovJPApUYoO3BReCHXtvzXJnNQwajrl7hG1nIs4iX1ACocw6j2Jk4HPn1VL5XE3gJBv5SxeKqY+w+8oaEe25XlJWMt6pU96Lkk3MGMr7dAuNQ/E1sN/1BYhiQpeWGb6BTnZBsRCFs42eieJjGYVbKZ2E4Hvi2Kda7aygguiaZ8FouVK56arEK5/KjZ6emNYugXsOlzbjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ux51XEHi24yp1xnyldsk9iWycZ0L89FlJ7Q6amsnm4g=;
 b=ZGx8hPFPmzcn0hf+lpXYWoHmg5BKHFbXL2WjVtJ9cDHYEXoCs98r2h3N8wJXt3FefIpo0OPPzmDkSSNRFb7FrcgzdnozHNYMyI1HfQ4/nNYEk9Z3FbAmL6+GMrjzHqP8RKJxFAb9SuDaSNGgNKW0gImRqQLu8HN3tMjpLcI//9+dmJV+3s3vht5kWtegk8UAo1gJqOPonU7rPlStSNdPKMYepzoR+YkF9er3nseAISRrMdOl7+Cuwu4PU3emA3w23vzLXn9Lm3PDZ63/jHoA0Fj/hxE+bLfBypqITHzaxCRJndSX4iIIpMfyLESYxgCTDK+sSCc53zmbmDaYVO7s0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux51XEHi24yp1xnyldsk9iWycZ0L89FlJ7Q6amsnm4g=;
 b=k4W36UB/upwHKdmbRBv6Ksncvj+8FHP6Rtjl+7lqvDljUeoJIA8FlFbJ6P+evGuY2Ruq6GlD2qh6Ss8NT1f4+Km70njuouFLbnWrpYmAYhxFQUcGETdq9uxYQNK2SJTJyMdog6mRL0CfEYG/lwrUnsXPN3pfzFBoOxhoGYnVpVrKpgSGUNYUfMwUVd76aTNpNrHIRxKzgTGnrTrYCwazE4hTZ+f82fcBQLS5SWCTktbRDMwTG4l+IlCa8l9hg36BXjmyyx6D/SEX+kOUHPgiuzk+Plyl78ommsnqz61/D60CURZ4pRB+t//mFa5fdA6LjS0t7/xWFtZosooUPhyn/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Tue, 15 Oct 2024 17:42:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 17:42:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden <greg.marsden@oracle.com>,
 Ivan Ivanov <ivan.ivanov@suse.com>, Kalesh Singh <kaleshsingh@google.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>,
 Oliver Upton <oliver.upton@linux.dev>, Will Deacon <will@kernel.org>,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 57/57] arm64: Enable boot-time page size selection
Date: Tue, 15 Oct 2024 13:42:22 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <CD2DC486-F4B1-4043-82BC-0CB2AA513A99@nvidia.com>
In-Reply-To: <20241014105912.3207374-57-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-57-ryan.roberts@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_6FAE8C0E-9490-41C6-BD5B-AAD8E9899AD4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:208:fc::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6cf5f4-f71f-40fe-10d6-08dced40bb7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pMzTT7eHxj5G+YbEw2LhTkUxqez9DTBGY0bqBEim8JQFlZmP9rpLjaNrB0DV?=
 =?us-ascii?Q?xCQP/l3ZketR1U0nbziJCUbNJzIl97wlTg5IYyaSDZ9VZ6XH0AT1eRzaqPZc?=
 =?us-ascii?Q?5foYaQViIUo6OTosz+ymtpVf4f3F+FYS4fyX5BhwsRkTRsAhEYvhAx4xvXop?=
 =?us-ascii?Q?yQ/fSME5yOvBp7vvvgN/2XuDoEvonbywo6x1Ffq0KVjS2upg5WCiGj/R2kpU?=
 =?us-ascii?Q?krMctUttRjAWYgIeRvsWfZ/expoN1KOeicpQkOz+0X3dpENREJYz56579tFL?=
 =?us-ascii?Q?gNm3L2n+HMD0HpgRWoYN4SwzZRjwxoAMqASLRJ8SgN3IC245JNFGg5jfQ1Cm?=
 =?us-ascii?Q?A1V8WlGZ41M2q+nmTmBW4d5i7anRx5ZAqiFiR5AC6ws12OsW6k1Q/lCP8ZD+?=
 =?us-ascii?Q?zOIYy2QYmnGYJmK/dQ8FOqBuVfN7F1WAOgfpXcc0BxVGOvniLHeCqaYcYLPu?=
 =?us-ascii?Q?1rM6xJDoGKk7xOtQjt+6ruqmQuf6R5zTjtsHqAleLyUEC2jZ2VxRGvQuNxWJ?=
 =?us-ascii?Q?HDtqjVR7LUPBnd9OdN8qbQFX6l6lORBSQBk2T66df5WQzDBMnJ+fHqMZCI6p?=
 =?us-ascii?Q?0GbR93Myy4Qzejs1+obXI4i/nOk0+QtM5sPrufa9na/v0/hR/0KfT6PbTVIz?=
 =?us-ascii?Q?Z0zkatYbIAtYxkQSEgnhTzwSlwRbbNH+TTgHC8Pfy6uNHjmZogyC8YMwEVZn?=
 =?us-ascii?Q?U1gPZ7UwZGTVRzrDjRIk5J/39xPC3/eRhRZnIBYJB95yzl0obcQF/k621R8N?=
 =?us-ascii?Q?chWXGXe3PQafI7HUYCNeWs2QKNdGVVFkQC7NGKr2QAHQN4VRtvQXEKIwZes5?=
 =?us-ascii?Q?mEXXoKJAaH36CN+KmB7Vr25zmdt+xDXe2pJzyokh7L6K1A4/TUsKKQx6kV71?=
 =?us-ascii?Q?2EMoVCJfHG+LslawU8w9YKKm5YFbM4K0r9mvTGjaMwJcZg13YmOUGhnNygJ8?=
 =?us-ascii?Q?E24q2CMhUsUATY3t+n6Oz+BZREg2IEj2FoQQ+Y8WJMM0AZk1umMpdtj2lbEP?=
 =?us-ascii?Q?TMx3OAdMhbVHuFqHoJ9/AN0dhoGJER1NV3JgPmW7psBLUXv5psVliAsM2CUE?=
 =?us-ascii?Q?Vg0ga8DhmrYuqUq/4diu6qsya4A3qnUOipv5GZZhcXMErxcnoCDBySYhfIQG?=
 =?us-ascii?Q?3mBXzQQGIjEPNO0QM8G8zeOKLXCrEJJ6HICun6jfgS0vgjZsk26Qr/LHAUff?=
 =?us-ascii?Q?f6PpQ2cJxV/zhZVzj2DWbhTc/AGIrok3/T6YLFnw3c3q/2eVUwrSTIMYle3O?=
 =?us-ascii?Q?3l0y4lbcRLw+G6pFeSOkefYJFEbLzk2U9KRUivMoyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BD0m4cEW3ayNEXlZa/dsDJlc6hOQjM4b5AaOTph2sPARiVeFBxk73s4RtMCr?=
 =?us-ascii?Q?f1UrQ2WUekwhiGU/nQmicBLFgWzQNN8bFe/YwYbd2DeoAV0JpAu57ij7RS8D?=
 =?us-ascii?Q?a/OMEHa9pkeHxsmTaXW6DtRO1zHcLpPNFmTeMSFekro+eEH1FqAenbzV58fZ?=
 =?us-ascii?Q?C9vxen+lpBwHOKocf2znP4sNaWeQHGsiMuCeorqx0JXXaD6O8DAP8vA4I+Fn?=
 =?us-ascii?Q?axsMusO/Z/jKKyIXG8WWJx8qfrh+cBi83JhpOFjZDQnICbME6pWGJczlmgEU?=
 =?us-ascii?Q?vOD265KI9iXyfcLpDsbnr/vAqpNDSB3GhFwBhXrySLLe4rClO+YPJ3hD3zTx?=
 =?us-ascii?Q?7+ixJdkfR+ffFVHo5f0FYky7tqzti9qxm/C+LzQtm8/7VA0LR/zuPHPcT/Af?=
 =?us-ascii?Q?Uzr+53Y28P8JpOBM5uimQT04mvbrMwt2b1TOOc0R5LQKwW6D5Pqm1eXIT4cT?=
 =?us-ascii?Q?Alf4iuBJktScQ/gNP7BPnWn9zd1M6hR+tDyOJ5SsaWdlnKwPiwb84nqRTnex?=
 =?us-ascii?Q?U3aCyVFqSt5ZrzEe8Uvg3a0hkoqIjIQc2WYcjoD0LVaCG2PtEwpLjIuzdAIC?=
 =?us-ascii?Q?78yuhuYN5N4Ym0lo73Awe5svVIZOQWGJ7I5zhWAQN6tIjuYdowLrH7BLOl6J?=
 =?us-ascii?Q?VYl/BpXPEtkn0t70QVF2ePXlul62VJKOvis4CbCLg/DoAIqR1xKl0gK0aZb9?=
 =?us-ascii?Q?Efbc0YfZOukTS0+lhrcJiE/wRdK/UIau1tfKOFn4HUFma6sT3DpXPDE6zxoc?=
 =?us-ascii?Q?lLMUTBxEi4R8lUbjX6NzeMR4/H+acv01zpepqsI+NljtKuBNjbm8hYDAHrB+?=
 =?us-ascii?Q?tyWleS9U/ytcRqmVdaoE5p/RTLGWdWlxDg65Lu5vcOhdt2W/q8eTaBQPNh18?=
 =?us-ascii?Q?Cg58eNSJNLUbFBrmfUZ3UfpO9j74awaWLEcvOpRQbQqwE/CVe/rzmNo1aOpi?=
 =?us-ascii?Q?zSZkS2fyi8rjw4/3JubzuGSOo3gtn90shkHR7wtmSqzxTh1DUGFPHaw4VOg9?=
 =?us-ascii?Q?7mluLHvC6Z7AfHu47/l6vpjv1m6IbbAhH+dMv3zQE/nbmBx16Nvytb9d+7hg?=
 =?us-ascii?Q?pMWsK0YsXwsUwELWb2PDinDSQCJxbUziWy3iqqec818T4/Sp8U1+awAS+Ah9?=
 =?us-ascii?Q?fpfht6Yj/jKW/Tycim5KtWZo4BBgPWH6jJ7Rma8tGFpNBLmalEvMnQXjGJCV?=
 =?us-ascii?Q?dfSr6+QrI3phlHrEBVTKnIK1tTkVGOS5aWiKZV4PH09fWp59q3dMD1mHTs3m?=
 =?us-ascii?Q?fvyZrzMX+mQRjsLCZreD40xEmuzC/gwx6fCy9W43MesuZeMn5ofp3FFmch2p?=
 =?us-ascii?Q?p/M9+LYjQ2eXfYdbLVM7a42k0JWW1IZlZVj1GVlBv+2V/0C/CMyGz5fNPKS/?=
 =?us-ascii?Q?Gb9w8YvmX8Ec27eI+/oD1wTOWcAZ6NCL3HLC+5oDfBQJgqTCPU9LPQKDBAPY?=
 =?us-ascii?Q?Wy9wUZkoTtH8UIE8uyC3wdeovd6IwgJ8b2ZdTmvbGrWQvlE0qzKQnNsYGtlS?=
 =?us-ascii?Q?2Wy/qCruAaxY2uPqdAGIqgJJ5uglyw9LCfenfsZuyVfkTcPLGKnHNkuv2kFA?=
 =?us-ascii?Q?9cBwx7JOTYkyJro0MWS4yLYVZVuJtzhHRrWRSxXD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6cf5f4-f71f-40fe-10d6-08dced40bb7d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 17:42:25.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upRKNy6febRse/DuoJcleaVqUSCjl26Ekq1dt6K8SXglrUZTIhOlmEBb8ZAN7IQG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254

--=_MailMate_6FAE8C0E-9490-41C6-BD5B-AAD8E9899AD4_=
Content-Type: text/plain

On 14 Oct 2024, at 6:59, Ryan Roberts wrote:

> Introduce a new Kconfig, ARM64_BOOT_TIME_PAGE_SIZE, which can be
> selected instead of a page size. When selected, the resulting kernel's
> page size can be configured at boot via the command line.
>
> For now, boot-time page size kernels are limited to 48-bit VA, since
> more work is required to support LPA2. Additionally MMAP_RND_BITS and
> SECTION_SIZE_BITS are configured for the worst case (64K pages). Future
> work could be implemented to be able to configure these at boot time for
> optimial page size-specific values.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

<snip>

>
> @@ -1588,9 +1601,10 @@ config XEN
>  # 4K  |       27          |      12      |       15             |         10              |
>  # 16K |       27          |      14      |       13             |         11              |
>  # 64K |       29          |      16      |       13             |         13              |
> +# BOOT|       29          |    16 (max)  |       13             |         13              |
>  config ARCH_FORCE_MAX_ORDER
>  	int
> -	default "13" if ARM64_64K_PAGES
> +	default "13" if ARM64_64K_PAGES || ARM64_BOOT_TIME_PAGE_SIZE
>  	default "11" if ARM64_16K_PAGES
>  	default "10"
>  	help

So boot-time page size kernel always has the highest MAX_PAGE_ORDER, which
means the section size increases for 4KB and 16KB page sizes. Any downside
for this?

Is there any plan (not in this patchset) to support boot-time MAX_PAGE_ORDER
to keep section size the same?

Best Regards,
Yan, Zi

--=_MailMate_6FAE8C0E-9490-41C6-BD5B-AAD8E9899AD4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmcOqX8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKhMQP/2+gUcElSZqBhnmgBG3pWbS2kRF2vxLfqMBA
LOXJ18Jhd3PJOqKwqGXadzonVramqMEwXwwZ9vCglK0R13oXzyzGW/JvPOD2q5vg
lIiW50eu7AnkS4vFgNOEMIzyemleXrwkky6DzazYrIEeiMvdLP2+wDdpWYxJRTzl
oMjElTHGkx36HFdZa3Xw63Xu8ZWX8vZOsiwdcaL0een/BQlU9VQq98sZr9RE/zri
fKUNVxV5XcixSixzChTV/FSj0tsY6VesOjm1MkTubNehJct66QK0Ro4bP3XHp3r8
QE1382fGBNn7FHflG4UBjqd1YEqQFOxM7kITyfsQ1uTKfXpVZhykJwtvVL7g1zCf
ibb60dfofuQqCdvdW5WHlwW2AnqEsiEkZ8w5vq0UME/1PW2aU1EkeevVlApEj1+r
0oZ00IreTNBkxtGFyeunLrux1kjom+dY99QEj35i3qDZ4ul9dgm04khd4heiOpqK
gwrgHhPYlFU843VadCqsAr+yMhkDcAXLNoEuHkTVnwOZFZo8H2m8k/j7OCudYyHl
u4QEvjCYco6dIJl62lK+uOuniHBASmZSOJ99BgQnDEM+NX8Cax3WMpDm+9YAWkHv
bgotYGepe2xU1mwB1k4T6eG9nBHqTMw5h/oqJBlgSH4OMuUDfCt/yI7KJd0IQJl4
MaxFKRCn
=upBa
-----END PGP SIGNATURE-----

--=_MailMate_6FAE8C0E-9490-41C6-BD5B-AAD8E9899AD4_=--

