Return-Path: <linux-efi+bounces-1009-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B92DA8B8599
	for <lists+linux-efi@lfdr.de>; Wed,  1 May 2024 08:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278981F231D8
	for <lists+linux-efi@lfdr.de>; Wed,  1 May 2024 06:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D500C29CF7;
	Wed,  1 May 2024 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nlkRFrD7"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05187F;
	Wed,  1 May 2024 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714545418; cv=fail; b=AB63JuyECifJECc+uS8CFTtEm9dmnlhfgLwTb4ISGtvY5bFg6cpLlPcbMbPzIORMx8kuRT2Lw7e8W6M6+5WD5LUvHfiQBpXvpkjJc3PGONTax8oaaLPZZK4PpNShuJ5DHWR6zDsnjvMWYSHYncIjt3xZ1JoSMoWJ4048AG+OfHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714545418; c=relaxed/simple;
	bh=hWdUUtCmclMYWe5DIaCQgI/5QGY1FPzyhIizQxVEKtU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=ZWgBjN742oraWuY4QqAwsZMB+gNUJ94ld70l1QYwjTU1NXxc0cNEaxi2Cr6fytosDbAKgaHiwcYTcMtD10enFTdQjxifhIXCvKm/NAPYu24E2ZVoV/2PTvvqg63/NA/bi2SFjP1ZPv1ltKYVUk6upPHF5pHj6XOxkr86LMQsfVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nlkRFrD7; arc=fail smtp.client-ip=40.107.95.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7pVNEitt1jCg9XGSvKDA464DCNJptjg40YFVXK3XYIqbUMCDevWhf3/kxoY5fgKLBNF4nltXwbzQl2jfH3D5XDjkLEjfk47KFGjsw9jz4lvV4BVlygcDabu1WmZyRtVDsvq22C7fvfllHRPw8eiGrSu5NqDB/K08UojQfsFU7/41TcG6KNl4rJEPLbFCo/INyage6Loruzcm7413QMLB26NjzMr5UkWcoG2TtwvOIl/wY/pmUePL6w92wVx3MOtNhyiX+a3aUZ7/nhDvK5OTT9Y1rIJwNULbv5n/0ms+uJF1Px8o5g5nfC3vpyp2oFKtG4bjMwnSpDPEKfZm5/6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVeJe53AOGmivEHTRxGO8n8xN/dHL2tfQKtM3p2qjYQ=;
 b=nDcOASVO4rH7iR+5sythZryN0GwZA1Qngazx5UtdGm6Bxi0UbpsL9Ixp4KPU8cWkjbBfMYrLiY0OMg99nbuy3FwARlXmWbibQuj7S0+1q2t2x1+9C0HiPTbED62X5Ms3zAFjNiWYiB7moyoDWyFDdSYxZA8eULhghugsQJG71RkNI6fJWrucA+eOG0oRTMzgGVkHcnxGDV6NX19pFT3AaPnmzmaQaZxf+1dZoUEGbkP5Jh1A06dd4GOttzJsLlNlz1so61HmoslfhIdc9bclMVz021vMAphsdq9q4X4ZYzFfIjx0V2OYrSZCZ9iKLdBR0JjNl8Hcf80gcLvhYmeT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVeJe53AOGmivEHTRxGO8n8xN/dHL2tfQKtM3p2qjYQ=;
 b=nlkRFrD7kUNamuZdmdWkWaVKeGE9EEYuD/t6HZlXwm6hwoCjy0LmUBvImfoA4+fMaRkwI/4LFiVxY5DLP/eljJRvZN6QIVoV4SAI1uJ1RVb9Y69PZWiijPuxfD36rUcAgKQXF9tzKx05Wl5h0oEfTGj0Q8w5EKuR5kggztz0KHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 06:36:51 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 06:36:51 +0000
Subject: Re: [PATCH v4 1/2] acpi/ghes: Process CXL Component Events
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <20240426-cxl-cper3-v4-0-58076cce1624@intel.com>
 <20240426-cxl-cper3-v4-1-58076cce1624@intel.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <02b42a2f-9e0c-2895-47dc-d176ee320e7b@amd.com>
Date: Tue, 30 Apr 2024 23:36:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240426-cxl-cper3-v4-1-58076cce1624@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0051.namprd08.prod.outlook.com
 (2603:10b6:a03:117::28) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 329c2d5f-25ac-43f8-a843-08dc69a915a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0NlTHBoVUlvckRsbTZhUi9Ra28rdGhmMm82b0xtRWpYSTJhWGpCaFkvQlVa?=
 =?utf-8?B?di9XUTB0TlR2VUhDRnc1QU1kZ05HVDhDZkw0RTlYczl2SU5LOEpEOFEyMkpY?=
 =?utf-8?B?RXpwaHRDL2pVenQ3NmRHWTZpMlFUdnQ4cXB4ak5MSmZEazZjdERiV3FEaDEy?=
 =?utf-8?B?bUZhQ3g1K2MxbldGOEZ6Qm5RcG84U055QW1MdTJwNjRLUVVTZkdiY3FJSGZB?=
 =?utf-8?B?TWZFUmMzaVZROFpxWk9US3lzUjZGWW5DVGRkUEk1a2RzZ0xBc2szSVVKS0wv?=
 =?utf-8?B?TkZtcDlLOHlFVVdOWkZCN1JzVWxtaUZhakNzbUh6d3Y0d0xxQmJlMUhzeWdJ?=
 =?utf-8?B?QnNTZ0ZtODJ5WGlQWmllQWNkYWdlMU85T1dqc09ZNWw2NlVGbGhFTWg4U1V6?=
 =?utf-8?B?dmJHUEF2VkxvMnJLbXU4TUNvLzk0RWRIR25XTDdsWXlSbnFPTGo4ZldGMnNY?=
 =?utf-8?B?YXBmM1A4YmJjKzhIWWhWSWtYL0h0N3lXblQveG4wRnpvNjhSdUFmSzNWUUFD?=
 =?utf-8?B?c2kxVGhRNnR2ajAvVnhsZE1xaG1PZDd5SmxtSWNxZm9nZ25NaGV5QUpmcG9y?=
 =?utf-8?B?TGpVWi9jc2hjTzd1aG1DY0hUSm1ST25seGNKYndWQzFlQnI1dFYycnlqTlJY?=
 =?utf-8?B?NFlZbkE1a1VnSE93ZVljaTB6K2FBQ0xVdkJDTGNnb3hpY2wyYlBJZVkreHJT?=
 =?utf-8?B?MDBTVU5JYkxDWGFkVUtCWlE3ZnhhWU9Eem91Tm93SmhiMFhEMmQ0QUhUTWdE?=
 =?utf-8?B?bE02R09qQ0dET3VadGk3cXJseHRDcERCQ0hNMkg4dlZBNWhPWUluZVQwQmM5?=
 =?utf-8?B?TGg5a0FPd0hUSWNWb09oKytHVDd6c3RoOVRiRXpZTUp4RkVyclR6SlhWNGdo?=
 =?utf-8?B?SkFPdFJzV0NHUVVybFNuVjNqV3kzWjQ1SWdUVHErSER1bGtiWEp0VmUyOWJB?=
 =?utf-8?B?YnFCcjdEcjlicEh1MjhNMkRETkYraTI1UUNvZWVUUXR1aGErZE01bGhrdmFj?=
 =?utf-8?B?TDF3ZjdUTVptd1FqWnRpWXJ2Ri9hcG1xcklUVFEwalJzWGZaaVRPUWR3Yk9I?=
 =?utf-8?B?cUdteFJuVmhLV3h2dEZENU9zSHFEV3FNQzY3YWdwVDY5dWVDUDJic05la2NW?=
 =?utf-8?B?bjFpUW1Hbm8vZlVGbmg3b2dzUUZEQmpmd0RkNVdSK0RidS9PV0dZZEVZNGlB?=
 =?utf-8?B?TEZqN010VGcxZEdXTnphSUtEK1hnUDBVQUljSXB2R0kxWVBpZXBhbkFmZjJP?=
 =?utf-8?B?R1ZkSWxRYlVzTGV2aldSaWVxTVJYdWZ2WGtmN2NnaVRGMEtndlRTQmp5dVVB?=
 =?utf-8?B?NE1KbXVmc1c0YmJxcUZEWmtlOVU5MlZyNFhFbTNlWVkrdW5PSXZ4U3hLcHI3?=
 =?utf-8?B?cS9zWXFkYWFVRXc4VEh0N1JLQlZjOHFXUzJHL21RRzdrSFpnUGJCaWQ4OXJO?=
 =?utf-8?B?RU4rSkJLU1FQYnE1RC9kVTdITkFvWk1OOVNCU3ZBaVhmM0tvZmNRTjAxdU1y?=
 =?utf-8?B?R290bElEMGx5NnVhRThsNWxvS3Z3dVZWcDZrQzdJTmlpYlRhbGIxbXRuTzJT?=
 =?utf-8?B?bUV5TlN6VFBLa3dzaVNNMlhuYzJoZjJDM1F1QWsrMHdDU3djbkhWL1FsdS9C?=
 =?utf-8?Q?hMMuQUxmMcx0DnE3MMgRpdjIfKj6D0mnybd6o62iuSB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXU2OS9wNForNEtjOHpxQmYrVWIzUnd3ZGdsSU15OHhPNmNoRDg2aUZOUWNh?=
 =?utf-8?B?bFdCMEI5clFyQ2FuS0tBbzhRMWZwMkV6VDVWN3ZiZ0NkNDgzNFJacXRHNHJj?=
 =?utf-8?B?UTJCSkhzWUpqYlRkb2FWeEFXMjF4VlY1bkFXR2hQWWxOSWFNNUk3Qk1qTExN?=
 =?utf-8?B?NVRPbXZ1VWl5aTVMZTYrb2VpY3g3TDVXZ09lU09hemJqR1lHbEI5UjRxRm9v?=
 =?utf-8?B?eEhEaGxRUWhET2kyOExkRk83b0xQMUx3N0dBVlkyT05hdDNMejFMR2JIazJx?=
 =?utf-8?B?MXZSNUlpcVVBK1FyeW8rd3BPeUNSelo2allXcVV5d3pudFBsZHgrVkRydXdr?=
 =?utf-8?B?K2lTVGFiRktTRlJEeUMzNGRNTnJYUWQxTFQyK3RaWE00eFJ6UGRXVjRqRm5C?=
 =?utf-8?B?L3BuTE1RdE1ORUdpaVlGTlRJcjE1b24weURqL3ZjaWxxc245QWlhZTQ2OHNm?=
 =?utf-8?B?c05LanZKYmZvc2ptZkNEandlN0RTZmVoaG9tZGE5QVE4UjZRb0tidjJqWXlO?=
 =?utf-8?B?RVVPdDBJTDRuRURYMDhOZENIejcrUDRmYUlNNTNjK3RheEY4R043Q3RWUFky?=
 =?utf-8?B?MVVYQlVXWllKcFFMZVV2L3J1bGltdjZCVVREYUVJcVFIRWl3VHlWVGpoKyt6?=
 =?utf-8?B?d1VTa2E5c1J6SFBMZjZ0azhnaWlGbkhUSTdqZWxITUJOQzJwRjAzN2Z1RkxV?=
 =?utf-8?B?TUtaL0ZnaVMvVG1TekNPZWdUZVExRWd3T1JIZlRKdHBZdUd3UmRnckpCMzFv?=
 =?utf-8?B?VXNLWkEwaURLbk5EaDlYQURJQmlITWF4aGEwaHhESXNBRjZwd1MvWTZYWkp5?=
 =?utf-8?B?a0pXSVIrVjlPTERSY3E2THh6d0xmZFl5c3FPNnRsUURVU01SK0xYUWJjOTZB?=
 =?utf-8?B?R2RLSDNjZUhiMldkbFd1Q1N4NkRLOGRPaVJuS2M1S3d2NTR5WStyU25GM0xU?=
 =?utf-8?B?NHlDT2NiZHdQYTArdEpOWURxbkFSZUM0SnN5ZWNoU0IwR3lDUlgwSm5Ibzc1?=
 =?utf-8?B?d0ZYZmF1M2FvZUpCZjhjdjJHVndCa1EyYW1hTWRHVmI0Z1p1bEtNUmFMdlhE?=
 =?utf-8?B?Yit0M1l1OUdvTGowc0Y2VXdJcGRUT29BZ2ZPYzNLVWhVRmM0VVVLUVAybitE?=
 =?utf-8?B?MldwZUZoSzl2RUthcG5PTUJRUzNrcHROeTdXVDFNbURZTXRXWlcyb3pWNzU1?=
 =?utf-8?B?azEzNmFYMWFXQWhLWlNINjFNUlZ2NjlDM1dtWTNoODVWM0tpd1BRZUhMSVZz?=
 =?utf-8?B?RnpBM3JmZHJqQk1zY01lV2tvTUoraGRiR1dqWExLQ0lsOEhVT1JmQkRtV0dH?=
 =?utf-8?B?SmJwL2tyQ2RweXV3MDNqQnJreFo5YWVjeFRLMzZvWXdYOWxYTVUyY0pLL3dZ?=
 =?utf-8?B?WkJyOVJiQzVTR0tlcU1YNTRZK2xXYjNZRjhFSit2dkJzcEt5UkgzY1JQSkNv?=
 =?utf-8?B?a0JFU3NLKy8yV216UWNRUjFzb0EyYzJFV1YveXpJSXVmNGZWRCtIalNValhF?=
 =?utf-8?B?b3N3SzZUSzZaaC9pSjl3cVlKN2s3U2xFeWxQUHRpUytMbyt2eEh4ZkMwcGJR?=
 =?utf-8?B?RW5Ic282YXk4QlhxaGZIUThrU3lMM2tSelFwS1VuaWduL1NtVFZlQTZ0V2hr?=
 =?utf-8?B?Uk5oQ2NCRURWNGZNSDk1K2xqYzNCcCsyeG1PRmhyWFJYUHUzZHpheDVxSVpy?=
 =?utf-8?B?Q2puM3JTNFloNHBlTlpIU0pKTFRyanI3Y0dtSnREdGpSV0Z5dkgxZEFTMkJq?=
 =?utf-8?B?RkRnTmhWYmtqMkNtaHpBYllWOUw3NWxmSTlLSFNsRnRxZnF1NmtLQ3loZTdK?=
 =?utf-8?B?Zzl0SDhpTG42RkIvMUFDaGErbjVoK1JwYWczYWxLQTMwQzFlY0Z6WmM1VVVM?=
 =?utf-8?B?dWZNaGx2L0wzWVV5cGtQUFlwRkNWeFp6a1Azcm9GYk1JSjg5bXRKZnhjK3Rv?=
 =?utf-8?B?WExzTjl0NXNOZVFldjR6MjJsMWs5aStLYUNNSkhZVVpqeTRSSmRTblBoOCt4?=
 =?utf-8?B?T1VaY1NOQlM4TGYweGozbGRnVDVxbk40S2d1anZxM3o0MmIxcjREZ0l0NUtr?=
 =?utf-8?B?S0tHd2NVc2R5YWJ4aFgxdVk1S3lnblU0WUNsbnZlcFZtMmlTeWw3ZVE2U1Z5?=
 =?utf-8?Q?ETmy2n0Zwdjra92TlUNj9DWuF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329c2d5f-25ac-43f8-a843-08dc69a915a4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 06:36:51.4634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzBIq6VWzMcAgnfmxtzAAlRhBTpQhC3HpKUExCwcNrzEuNsncmSefMnnpFpaMjVA7Lv3HBckkpZePzicCU7kbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410

On 4/26/2024 8:34 PM, Ira Weiny wrote:
> BIOS can configure memory devices as firmware first.  This will send CXL
> events to the firmware instead of the OS.  The firmware can then inform
> the OS of these events via UEFI.
> 
> UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> format for CXL Component Events.  The format is mostly the same as the
> CXL Common Event Record Format.  The difference lies in the use of a
> GUID as the CPER Section Type which matches the UUID defined in CXL 3.1
> Table 8-43.
> 
> Currently a configuration such as this will trace a non standard event
> in the log omitting useful details of the event.  In addition the CXL
> sub-system contains additional region and HPA information useful to the
> user.[0]
> 
> The CXL code is required to be called from process context as it needs
> to take a device lock.  The GHES code may be in interrupt context.  This
> complicated the use of a callback.  Dan Williams suggested the use of
> work items as an atomic way of switching between the callback execution
> and a default handler.[1]
> 
> The use of a kfifo simplifies queue processing by providing lock free
> fifo operations.  cxl_cper_kfifo_get() allows easier management of the
> kfifo between the ghes and cxl modules.
> 
> CXL 3.1 Table 8-127 requires a device to have a queue depth of 1 for
> each of the four event logs.  A combined queue depth of 32 is chosen to
> provide room for 8 entries of each log type.
> 
> Add GHES support to detect CXL CPER records.  Add the ability for the
> CXL sub-system to register a work queue to process the events.
> 
> This patch adds back the functionality which was removed to fix the
> report by Dan Carpenter[2].
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Link: http://lore.kernel.org/r/cover.1711598777.git.alison.schofield@intel.com [0]
> Link: http://lore.kernel.org/r/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch [1]
> Link: http://lore.kernel.org/r/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain [2]
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

Sorry, I couldn't get a chance to follow up with all revisions. But 
tested this and it looks good to me.

Tested-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

