Return-Path: <linux-efi+bounces-4390-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 367C2B07BBD
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 19:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40C41881994
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572DC2F5C4A;
	Wed, 16 Jul 2025 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QdBNu5O2"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BBA28A1C8;
	Wed, 16 Jul 2025 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685436; cv=fail; b=MsTvxXFWluFqJg7sLhk2HNXu4gU98fwsoh6j/Q+N/6RSJfeFxZI5PeMk+WqQ6aVtIZe2vAtKnpKiCEYyKEyqu9joZWj4NIzxBa36MRH52JPIPHGgBxQyeTfVkqYpj5nhr2CaUZP+p+N8DKe9GczjsG5IaaICJ7hGLdxjfMad6Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685436; c=relaxed/simple;
	bh=CrM74iG3NMARglnRzJFtzqEbG8KfuaEpDVy6AmXXBfQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=llqx7fJtw6UDICICu+IStoVd+Xnsg6R5EEIjYa/qBXGDa1bHoRA93p4nbwJdtTsh7tpJ/gqI3hkMqMfO6QmGCFkbFL3rYHJLTy1/qRp6W1G9NOzg/cJTyUGYiScIMBqqPp02rV1w4NNnVb8vBZcTrKdgQwnXaiVKV+tIj7tVaxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QdBNu5O2; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTYBNn2eNywt8bYzHZdO8ns6lfi6xSqxD0qzHBTwox+3rJdpx63pGzvmuUz3tED0vOyeAc23MJVMbi5gTNr0MqyRSdNhbJ9iiYIB7pqdOoYi0Qh+roEXk2U2U/gp0nKDR+aBXOlAYrwZfgBzlgD5RHQikUKtbWFr+Hr2T3Jx1GmVoNbrTok4nPXlOEGTGLqN2U6dHCWCRPhfZN4Xqe000ByRNy4zp8cImqgF3nMHf0KZSabvqvB/ky7SGJcZMTO77MIIkjSaqeBWl/cSXKyseF0RKJkh/jo771Q+xCczlVHGae9l8Ji0yUlAuT+cC9dSLaCn8H52EKe11yFgmc7vSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q21l/b8bxrPMWu9TxKVjGTdkCWt0WSN9OaW1kS+K7LA=;
 b=EZX6ysa+YFahf+hCCQg8A2HblGQ3q5q5jb0Ue2swqTekWsyi7fG2lB00CYxumxw4wqaqkPqow4IrcC4448UWBW81DirC1HgSCYzD6Z2OP+JX8X+x5479z8404kqSrWaBqecKVTwSeB+OhH59jTNZF5GYGXIVsUSzQ3Z8wnS84mcQsWZt8roF3v6fZdAVeXcT/K6LDFpmjfQpFglXS3RES3wG1Mh5rma09FkExTq+ekINM+XeZEeH+BBW0V1I8dmB//480FzvFV8xx1eNOdG0NciPsRz6aSM9/wspwzpCzHzVBq+K/i0b8YnAy8DMvD1NkZ8822xIXK/sR5O//2YNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q21l/b8bxrPMWu9TxKVjGTdkCWt0WSN9OaW1kS+K7LA=;
 b=QdBNu5O2AyDdod8U+fjUt/Sham4iHBlra6Q4mVqzw7VPL1QCyOZ4Tmc/oraaNnerd/LJpZ6TRhDK2+18MT3TocTsnKGx3LBDRQknKdRN2v8r9CQgCsvUquJBXuAYjFzZaFBsNf5y3DpBpIE3b/a6bhjqGUyNToXfm6xC7xszzRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 17:03:46 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8922.035; Wed, 16 Jul 2025
 17:03:46 +0000
Message-ID: <d750dec4-f68f-0f3d-69cd-53749044ecba@amd.com>
Date: Wed, 16 Jul 2025 12:03:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 02/22] x86/sev: Use MSR protocol for remapping SVSM
 calling area
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nikunj A Dadhania <nikunj@amd.com>
References: <20250716031814.2096113-24-ardb+git@google.com>
 <20250716031814.2096113-26-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250716031814.2096113-26-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0098.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::8) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: f58a77e9-f9ba-4c1e-44d0-08ddc48ab9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3E3dGgxRWlINzZuRFlMUEtMNndlN2tuS3ZCSTZxZ3hjY055bXg4UzU5eVov?=
 =?utf-8?B?QkljZHB4MFJ6QzEvTU1rSHBtNGUwTHhnSUVSMXVVZHZBeEV3VHlZVEloYU5Q?=
 =?utf-8?B?cmljSWFTY0ZJWDRWRENsV2dwaytJYkJEbWVTSXg4aWlnMHFGNmVJOCtqbjZz?=
 =?utf-8?B?RldJdTI5dllYMXRZeWNKekxna3k1dXloVkNMdVBieWxSeXgxLzNyQmVNUTVh?=
 =?utf-8?B?YkdZSFFyUFlZVjVmbm1JM0FFN3pVMHMxUFM3Ynkzb3BNcFFQVUxzcGRTUjdh?=
 =?utf-8?B?MzhBY3VkVUMwOTBjUmZGd3JNUzh4VFhTZ2JGS01BK052UjZ0STd1Y2ZmMzhm?=
 =?utf-8?B?azc3ME43K1BveS85bGZLb0w0VHdlMy91dGkzT3IwOG5EZS9vSE8rY3F6cUYw?=
 =?utf-8?B?RE52ci9SLzZzMjc2ZDV6ZlNQL2FCdXN4OS95MkRpNUpMeWl3K2JtcVZlQ3NZ?=
 =?utf-8?B?YU1pRmlMTnkrMTlGeFZudm1maEVrSFFzSlNHLzQxeWpaV0U5RG53dDNwUmRt?=
 =?utf-8?B?LzNQYjhwd2NNKzlqYUpxZUU0b0Y0OGJNQXlDN0F6U0tCSG1NWE14UnRabnBC?=
 =?utf-8?B?S1JKdElOY1N4Ti9yMFcwa3E4cWFCZ0hKdEc1M2t5d0F1NEJWT2drQWFyNUlD?=
 =?utf-8?B?ZHRGaHRUQVZ0OGNjd1BKaVpBa3hpWi81b0haNTJQcHNYUW1hTGZBVjNTdVVn?=
 =?utf-8?B?NEF2cWlCbGZqVHM2ZDhpMWVXQ253OWJlNkZPaTVjYmNhUS9jcW96aGVvaFhX?=
 =?utf-8?B?bUNGTnJDdG9RQzkyYWdaZDJGMTMzaWxiTmRacyt2MUVOUWpKdUxITkQ2NU5K?=
 =?utf-8?B?Y0FxWGlpRVAzTGpHUk8zcS8rV1BDcU01cDZpRGgrTnE5Vm9tb3R1b0YxTmZF?=
 =?utf-8?B?ZXFNeWJ4ZXBxUkxrL1p3bFViWmFLUFRYRE1adkkyWDVkSysrRHc3M09Gck5i?=
 =?utf-8?B?THRsVlJXNXRaTnpBZlhXWHl2VDhjRTliaUd0bjVLa1VnUTFvOE9iY0w5UDFS?=
 =?utf-8?B?cDBDaitUVG9uZldxN3E2aXBxaEV1WnZML2hpdC90NFlhUlplN2xsL29taFI3?=
 =?utf-8?B?OHJsZjhKYjFUU2twTXZXZ2FOS0FqaW83Ykk2WENsUDZhRVZNYStiY1Y1TlMv?=
 =?utf-8?B?d1UyZ0dnaU9CMmFmdDl0M0laSTNuTzBZRTlVOHZDaGhJVVR6ZVVhU0F6VCtm?=
 =?utf-8?B?RHIrdXJhNldYSFVkZE9pdEdPOU5xTzVuTWVOSmZvTEFsQnBpWE5aWFNUVDVt?=
 =?utf-8?B?Q0hnUnVYMGZvK0p5dG9DSmx5bHJNUndUOXdmTGxlTjF3WkR3WWtvbWtpRTNn?=
 =?utf-8?B?dnF3dmM3NHM0SGpJem9uWmRCOUl3MVhhRzJrQ3hiVmJKbDlRMnNvUFIwTG1y?=
 =?utf-8?B?aUZ3K0s1enRVc0JwQlNvZkRYRlFxWjA4cExQY1hUVlM2bEx0N29aZEF4SGtu?=
 =?utf-8?B?UjF6V1NLSjR2UGszWll0MzEzd1ZuSkJTTVlOZXd2dFV3THZmaWV1dkZueDZm?=
 =?utf-8?B?L29KL3FPV3g1Z3huUlpLdmhwNXEwYm40SlBBYlkvQ1FVekpOdFl2d0xDTGZv?=
 =?utf-8?B?dS9kN1NyYlNVcHVKOC82ZDFRR1NPWDBpc2FReG1kWHZyZTc3SlBQMkRuYTFj?=
 =?utf-8?B?MzI1cU5LdnpLbE42OStreHJ1L21INzdKZzE0Wm1sNUxKelFnVUt1a0FXbjhw?=
 =?utf-8?B?RjVTM3lBSlpVcW9UUFFvcUZwK1MwVnFFdVZxYzd0SS9oYmFEV2NZd0hGaHkr?=
 =?utf-8?B?c3Zmd01UUVFPMnRKd2dDTk1aejBSK0l0TGsrcUUvWE1QR0RQaDJMcDc4ckU1?=
 =?utf-8?B?TEVpQ24vM1FIYVRIRS9obE1LbUtaNmRMMWF2eTNTZEdyMkVCU3lUOHJXYWhr?=
 =?utf-8?B?SGowS1o5bVhwd2RHU0w2VFpuSWgxMzlTR1VUUnM0TWtaL0k1K0pKdXBPQVRH?=
 =?utf-8?Q?fhTGqxxGLt0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGFqblZwRDU0eG1HeW80YWZJRWNUYjFBTFkySlEveWk1dGFVWS9nalJ4RllU?=
 =?utf-8?B?RWpSbXo3UzR6bmdlY1JUTzc5b3hXb2g4TVo3V1QxeUdMemphdVlBblAybXpn?=
 =?utf-8?B?c21SdW9yd0Zoc002V3FsZ1RsZUFNei9tMFVLTFNBaXN3aDFuU3UySnNlN24v?=
 =?utf-8?B?azh0UVhFT0RPYWYrbUZQUGczUkRSeXlLMXd2QTVLK1RmYnlaY0FrM092aGp0?=
 =?utf-8?B?QW1LYkRoamZ6am9QdXVVemcwKytOUStwd1U3MlJkS3QvYnh2VHhETVVLSXU4?=
 =?utf-8?B?bEJxQWsyNGdvWXVoS3dzVTJyRlRjTk9WRktYbjBPZ0ErelhobWhYS0Myd2xP?=
 =?utf-8?B?eTZ6dTEzUkxXNVpwYmFVdE4yZ2EvbjVEOVduYy9kUG02dm0rY29rL3RzcFdK?=
 =?utf-8?B?dmRaQThTT3BNKzlaZ3lwS0RJQmVUb0tVWjNwRVAyOEtoTTBoTTc0YnFYTlph?=
 =?utf-8?B?a3BIU05GL09aNy9QY0trK0tsODF4SXVKK21scWVyMWMzV0pVVFVOMy9mYVRz?=
 =?utf-8?B?V0J0elFQcjkrY3llMEE5SzkvbmZ1Z3JZMHNnVTRJckxPbkVlejRYbW1pUTFu?=
 =?utf-8?B?TkpBcDRkSjc0clR5cldyTTlrbDd1SDFjRm5OeUgwZGE4WWI3c2N2MG11WnF0?=
 =?utf-8?B?N2NGblA4enJINHo5K1hNL2x3d2tlN3dnZVl5VDRtSVZlS3BJZTlXV1ZPbHND?=
 =?utf-8?B?NXU0cVh5SlV3K2JkYWtWSk00a1JwWjRyTWJkcHdUNTFvcDB6clQwUGxzQnlQ?=
 =?utf-8?B?RG51MWVtZmJ2UnlVOGYyWHpEemhuaUM4QVg3bkhpcUJTYXpyN3A1a25vaVBp?=
 =?utf-8?B?ZmdTQUowQkViZ2o3V09KWFpwV2tOSktkOXIvTGNVSnlPaG9ydkhnMFhKT2M0?=
 =?utf-8?B?Nzd3ckExcTB6VTNHdEVZZXIwaHRJMCtXMjFlTW92UmllTVJLRVZkU0dEM2JP?=
 =?utf-8?B?ZE9HbDk0MVQ1VENueEREclZzd2J4eG9rUm9rSnMwYTNpWUVmL3M3T1RYdEZw?=
 =?utf-8?B?d2V4N2lnU01pVGw0aWFKU040TjFkNWRQaTI3L1g5b25OT3FNT2NvVUpKWjQ5?=
 =?utf-8?B?Z3ZabkNFRGZ2Y3hxVDZPeWlkSGxwZHNuMm9vdDVQNWNXa0tmQVdRU0xwYjQ3?=
 =?utf-8?B?a3BQeEtza1ZRRDdJQWxGSTBCZ1lqSkduS3YraTVEbU0rV2E5RXZNYTFqaVcy?=
 =?utf-8?B?Mm1qbThTU0o2OXhyK0ZRQzJQWUNsUTNqaUl2eUk3NTZqTktNQXExYXROSmFy?=
 =?utf-8?B?ekVNai8vaVFCVzF3L3ZSYXdrbEJQbytOUzNQd3VIcnc1TlR5b3RHc2U1RXVy?=
 =?utf-8?B?OVRSNTlsY085d2dpYU9ER1BacGQ3Q3FPU0pSSjBTNHE3L0djTjVuRFo5Nk9w?=
 =?utf-8?B?aXpiQ3o4ZTk5K1lxN0JpUTFNV2c0KzRDZ21hRGtKVWljK3gyYXB0UVVwSVNI?=
 =?utf-8?B?ZTdIUEpTWWgrRDJyU1JUOUF4S0RJaDdJL09QdkU2M01NK3BVVnhYNTNFR0dz?=
 =?utf-8?B?SU5ka2NYWW9MUGpNRXNzbnc5SzZlbU9BZGFxZGt0bldVYmlUb0lyNWlkUU1n?=
 =?utf-8?B?TUl0QVQvM3diQ1didEQzYWF3SThzS1dLbThCcCtVZ1FZR2FxVVlsZkh6QTZy?=
 =?utf-8?B?K3RDdzUxbWozT08ydVI1QWlPM0FaM0ZYd2FQOTlEbVdncEZZZmVWaGI0c0hx?=
 =?utf-8?B?dGs5SlVyZXF0U0xpREhVVG5FZVJ4Rnhma3l3NjVBajlPZ01laE1ESm9Ddndr?=
 =?utf-8?B?N1ZRVlM1YW1qbGRkNndFcmFtMW10dVZPczhxTUFpZEkwanJTZU9JeGplY2Nh?=
 =?utf-8?B?Rmk2czRWWmVaMlljK01OZmYwa3VMbFlxZE9rMUtiSE4yTXJaY0VKZmg4MFdp?=
 =?utf-8?B?RndIb3k0REpIekdlTGlwRGtkNUc0QWMxL28vVUZKVE1id1dySjRpS05GRTJQ?=
 =?utf-8?B?N21iVUo4Qk1zMzB5OWNKcFFJNGdPNkt2eW4vN1Jqc0o0VVJVcTFZWFQvcjZl?=
 =?utf-8?B?U0NXU0pwOE1TdVQxMXBnRzd0WWs2QlgwaGlzN3Y0VU5qV0pEMXFyQVVERzVG?=
 =?utf-8?B?dmxORStpQjJnNHplbjdZNHc4SSt5RTh0TW9NdlJRZDJNSk12ejRSNVI1UllS?=
 =?utf-8?Q?GoRf7kKEgKNhsGu/SrbWRaNdI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58a77e9-f9ba-4c1e-44d0-08ddc48ab9d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:03:46.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zYfxxpNtIOM0LldUDzgx5x40Qx/lIPcLeifw1IHQZybKvDTHdk5y4TblrvPC9gmgOp4yWmQiX1gJhlKdxdlRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248

On 7/15/25 22:18, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> As the preceding code comment already indicates, remapping the SVSM
> calling area occurs long before the GHCB page is configured, and so
> calling svsm_perform_call_protocol() is guaranteed to result in a call
> to svsm_perform_msr_protocol().
> 
> So just call the latter directly. This allows most of the GHCB based API
> infrastructure to be moved out of the startup code in a subsequent
> patch.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/boot/startup/sev-shared.c  | 11 +++++++++++
>  arch/x86/boot/startup/sev-startup.c |  5 ++---
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> index c401d0391537..60ab09b3149d 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -723,6 +723,17 @@ static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
>  	}
>  }
>  
> +static int __head svsm_call_msr_protocol(struct svsm_call *call)
> +{
> +	int ret;
> +
> +	do {
> +		ret = svsm_perform_msr_protocol(call);
> +	} while (ret == -EAGAIN);
> +
> +	return ret;
> +}
> +
>  static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
>  {
>  	struct svsm_pvalidate_call *pc;
> diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
> index 0b7e3b950183..c30e0eed0131 100644
> --- a/arch/x86/boot/startup/sev-startup.c
> +++ b/arch/x86/boot/startup/sev-startup.c
> @@ -295,7 +295,6 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
>  static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
>  {
>  	struct svsm_call call = {};
> -	int ret;
>  	u64 pa;
>  
>  	/*
> @@ -325,8 +324,8 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
>  	call.caa = svsm_get_caa();
>  	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
>  	call.rcx = pa;
> -	ret = svsm_perform_call_protocol(&call);
> -	if (ret)
> +
> +	if (svsm_perform_msr_protocol(&call))

This should be svsm_call_msr_protocol().

Thanks,
Tom

>  		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
>  
>  	boot_svsm_caa = (struct svsm_ca *)pa;

