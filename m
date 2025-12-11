Return-Path: <linux-efi+bounces-5837-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F147BCB7450
	for <lists+linux-efi@lfdr.de>; Thu, 11 Dec 2025 23:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B139306637B
	for <lists+linux-efi@lfdr.de>; Thu, 11 Dec 2025 22:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3F32E7BDA;
	Thu, 11 Dec 2025 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F3tUwJQh"
X-Original-To: linux-efi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010010.outbound.protection.outlook.com [40.93.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BDC2E7179;
	Thu, 11 Dec 2025 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765490863; cv=fail; b=CNwx6fjTw8ve0HpwSEcoD/L9irAX3o4vAA1iqeC/vWEJ6XqnFrHx1T3Xp+shbWv7tUTeNmi+8NbflA6rEI3K0idRqDbRqe20ccKYxbOPipoo3t6nxdTUhIYRz7GrCiqmxri50Rk4CqTLmjMJqocH6UXs53I9XgGagiTO34GBRBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765490863; c=relaxed/simple;
	bh=FXkraAGCyqcVw11pJHkQj7nTqOEBH6CV9MzqN3f+XYI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XWGtWo4m+N1o7sVfRxOivqNITFOprox9x90UhhVsKu5E0dgHXhcamme7k7vx7YyLdV1zPmcfnj7/TkSk1G9q6Aqt1yP97qnJAXBTjNdyyL7i4NQYtPNbQ/EKZbagTEhl95syiiOcZbE2nLBmoG0qYOdtpSpQR4YDyG4pxUey9VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F3tUwJQh; arc=fail smtp.client-ip=40.93.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9TsMKVxtQv3Y/RuHR46Dk25551UaFEYniVRK2UtygLeqSgMkpsL6cp+oCQaxndNkYKftBABbZT4B5jCSEcCSI6Bi65TePLsflObSG2N9xUGyU+S5U8zhjcFJbuNsb62c9GIQM8VtQKGotb2QibzOkv7sHjKQO9Vl38ChdcGnm/W7bxpWxaxsVZjsK+Ea9O4XwnRBGnWNV5b4oxShSgJwAXpC6TppoFiPSgxA2qlXputuJbWgWOwBJ+WNh6UFVt6Q2VsEMTZ3KxxSWNxvNXS2xaItEzXikqZh2MjGtxuo8FUznlUX8GWCNiFJ2poyP9534wXaqyKDO640jEnZbw5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvsMrk+u8D3Tg7bcnUePKzfgrYkmMGbsykZWq36Qf1M=;
 b=tSVP3F52+DDojd1oP3wOECwOoi/EfEGppxUpVmwcp9qtRIT40fkwYOZl2VO864KfaPD3fWkYb+zWPONo2NJRe925MW4Aj752HTbCG2auz3RxcZRbQvp3ttx3CuBBok/6ZmJ44QrsrasejBJhxOvWEls5sXHCU6vou0zn3IQ/I7sSzJEGQGFrPTgSI3GqLf2gImt7/Jw/zAI1xrWbBdh+57u3xxlNG23+KzAelM4j2jsZR5IQb17ZzL9ZkBWdKkRNytKWmj1q0HjlVvV90S4GieS2pfTVRbYMbw411zPwWm55acTWcnaUu8Ibod+OI1RLUZNP27LaGIaqpKK/NQENUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvsMrk+u8D3Tg7bcnUePKzfgrYkmMGbsykZWq36Qf1M=;
 b=F3tUwJQhy/ZOx6Gi48VAtLpDN2BKzGku3pY7vxGBxRqM7whqQr8eDpqsiYEUqq5gVKHLRZxxZmpdKFjuw3i8bwXcn3u6lUHXpwbm3Za8ma880IJ0xdqEjcdQ+CXvI5lljI8y3gh3SvodwrMtMtH6KWsqzuPq2J9kcrV0ZrYUM64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 22:07:38 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 22:07:37 +0000
Message-ID: <b767e107-9000-49fb-a93d-40192e1f170e@amd.com>
Date: Thu, 11 Dec 2025 16:07:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
To: Kiryl Shutsemau <kas@kernel.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org,
 linux-coco@lists.linux.dev, linux-efi@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, ardb@kernel.org,
 akpm@linux-foundation.org, osalvador@suse.de, thomas.lendacky@amd.com,
 michael.roth@amd.com
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <ac479414-e0fa-49be-8a30-8f9c0e7b7d32@kernel.org>
 <73a69c03-feda-4c56-9db1-30ec489066fb@amd.com>
 <938a7948-7882-41a3-926b-3d2a8d07620d@kernel.org>
 <89fde0fd-57c4-4146-82fc-a4c1a56e74ec@amd.com>
 <a7ac1f74-32a6-41d1-82da-b338c127fb2e@amd.com>
 <uc6yz23havsg2cdgtk3fgku7xr4gj2ykse7lxitcs4eh2fw4vo@hyavdm3ovdfh>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <uc6yz23havsg2cdgtk3fgku7xr4gj2ykse7lxitcs4eh2fw4vo@hyavdm3ovdfh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:408:e1::25) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 3287b53e-2c48-48d3-0db0-08de3901b1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVVmKzF1MHZSRmRGWVVXNFlqcHh5L1FXWndES2duZjdpTTM5Q0Y2UWhmRFpC?=
 =?utf-8?B?ayt2QVlRdGExUzRkOUcwS2wwdlRIWkgxZDlDMllyUzIzdTF1R2dNOXVrT09X?=
 =?utf-8?B?cGZKbWlMS3N5UlZ4MWFpMTdEOVRrOWVMUERhcHlENEFFNThIZWl1OXBCVjdL?=
 =?utf-8?B?RzFOY0NiQlpJYTFiSUx3VEN4Q1VOK2xOdE84WFBmUkNTRzBDdjYvMnpKZzdp?=
 =?utf-8?B?VWhBdS9QTk1pT2JhU1M3VnY4Q2J0NE50aGhDdks1MFU0Y0M4SnVZMS9MeEtr?=
 =?utf-8?B?aDBLRVozLzl5bGIxbU9BSDNpa051NS9jenVlc2lNZ3R4dE50eHc4emFPa3Ja?=
 =?utf-8?B?WmNoZk0vOXd6L0ViTml5YklhdWllTWI1UFRGWGtaM3g5VmZKQU1JdVM5eEw4?=
 =?utf-8?B?VGVRZ1NqWmxMeUthQ1dpcWNDSWxHMkdPMXhOU0F0SFRXMXdSNFZ5aG1lZVlE?=
 =?utf-8?B?TjUrTHZkYkl2Q0JsQzIvV3hOb1d2Q2xoS2crL1FkR0lSUnRETWRCN3pjT1Qx?=
 =?utf-8?B?ZTV0c3lteDlmRVBYamVOTjNKZStFRzU2WkdKY2tmSWFuNm1uTjl1RWV1NG5s?=
 =?utf-8?B?VStOQkpFQjFqOVQ3dy9BMjQ2UXh0WmRtdmV3cUNNTHhlRWtzVTd4bWhSbzJK?=
 =?utf-8?B?OXpkcXZtTHRmOGQ5K1hKVk0yQ09WbEZVdzVIRHVzOG5yODZlMTh6YTlDeGNo?=
 =?utf-8?B?TXdnbFpkTCtYNDZnTEswd3pzV2ZJZlJWQ2I5SXlWbUlTUlI1QkpxVytOZFNV?=
 =?utf-8?B?VTFoSGZTdDEvQUs5YVgvZ1h5UURxcDlMeDZsa25kMHZIdjZsaDY2VW44TUNK?=
 =?utf-8?B?OGxST2lFYm1ZeHVNVW93Qk9MbkNCRXZWa2ZpOVh2S0hHR2RLVFUrMi81WmRK?=
 =?utf-8?B?eEdGa3hFdzl6a0Z5RUFCOXpzQ1JqTmVmTSt5RDBDRGRidVY3b1BRWGloK1E5?=
 =?utf-8?B?Qzg2L1luS1ZxNEZuaVdsaXJiRWU3VUdpc08yaVJFMU8wR3BnUGVPSnJyeUZV?=
 =?utf-8?B?U0tsemNlMEFmZHRBSy9wZVJWY25jVFR5TktlRkFoaWd2ak5OSHlYWHgwSVZW?=
 =?utf-8?B?emtJZjduRExjYWovdHpkeDl6QWJEa1dEMXJSMTdFVmVRYjNPZUE3OVB3R0Z2?=
 =?utf-8?B?aFIxS20zRks0RVVsNkowQ0d0ZnBkMUxCY1NUSU1JOHFyd2FrQnpEZnVIWTA2?=
 =?utf-8?B?VERKYXVYVnZxdG9aTFZRejhvME5pRkZ6cHNwblNheHhyWkVuVFVkaVNLU25h?=
 =?utf-8?B?a3dwNWF6MHFNS3Urb3VacHRtdG9HejFLZmRQN1A1QzZvMW0vb1k4bWQxNnF0?=
 =?utf-8?B?c1ZIelYvWlBDYjFTNVZQK3dIbUh1NEdackI2SllvK2pLVnZBQUY3LzJTbklL?=
 =?utf-8?B?bGpwSy9Pc0lLZWU4SGFGK2JJbVJkdDdPbnlEZHB4Um5RTklpWjJZRk55bFU2?=
 =?utf-8?B?WXhIZlFLcGxrTXYzU1k0RzhXa2NuN1BPWTJwT3o4dVFsb2FZL01OdXVhQ0sv?=
 =?utf-8?B?c3lzVGRWRWlMMVRyQ2QxWEFzZXQ1d0wvK25uckRQUGNieFYxL2NYMUQra29o?=
 =?utf-8?B?WXNrRkh1T3hpa1Y3MWVzcWlpNFIwbHdXTmd1ek14ZzQ5OXhSS3BkcDZWMHdn?=
 =?utf-8?B?b1BFL2JZOWRmRUhmZUo5M0pSdGtaK1E5MkVxeUVZM2svbm9pYTEweFlUTjFV?=
 =?utf-8?B?amNsSVFvYVROR3RWUmRBdTVIVjVQSHJRVVk5TjgxdmVIQVp0RGtVemtVanFM?=
 =?utf-8?B?eDI5V1N3RGU0ZXo5a2txaklJclNJWnU5YWFSek5sczU5cE0vYzd0VlBlQitr?=
 =?utf-8?B?VmJKSkc0TG1FN1h2dnpqa3hnQ3hxc0RhQkMwTFBGaVZMSXhhM3doSjFqQVdS?=
 =?utf-8?B?WlBmZ05aSy9qbzhNL3hnODMxdE1vaGk4THZONExtZHkvcWRXcnNFSU1PZmJv?=
 =?utf-8?Q?CUacnuWQw/Q+WBaiNEe3oDd6AX4j9AtJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVg5MjdnMVMxZVZQZ21ZdHVJYm41QkFnc1hlYlAwK2YrN1kvT0ZscVhtNC9h?=
 =?utf-8?B?bzh0YWJhU21zV0xVNlJYemJ6SDRTYjJoMWVKVWtGN0Rjd3lMVWlscE01dVA5?=
 =?utf-8?B?VXNNdS8yVU5URUxjYVJIaCtmbC9jd2lWaXBqazRWVEl5VHJMS2kyaTVkSTZm?=
 =?utf-8?B?dFpoNFZmdzZUVkFvK240UjRJNEZiZlVZcnJmZHo1dEI0b1hCTmVBMFhqMFVD?=
 =?utf-8?B?ajF0ME1WaUxRVnBucmlqVHZLOUNDRENQc2xDcFlIVTJ2VXFhaWFuZGpzUlNX?=
 =?utf-8?B?TmVtK3BSV0lra0Z3R1lxdzNsakJJRnJORVA4NHp5Nnl6VHVZREtJd0ZpZzdO?=
 =?utf-8?B?cGxZVStNUHZuWlA1YThnVGtGOUNicFR3OVh3bWJaYXo0cHFFckVPQ1NIQ2N4?=
 =?utf-8?B?b25LQW1mRU1RYnRkM3R5Z01PNzNrazNOTHBIdlliOC9oWTNjRzhza0lzRXpl?=
 =?utf-8?B?cmpvUVl6Tko5b09VeWtCdEVscnpiKzI2ZWJGeG9raFlVZ0pTZEpxOGk0K1Z2?=
 =?utf-8?B?b2FQQmVVeEh4cXc5dXBtRitScmltOHcycXlqMUNCVDNYR3lpTkNjSGxkc0Ns?=
 =?utf-8?B?NmwzcEZVWWJIU3VJU3owTUs0bk1mbVRCVGxkV0x0bzZ6Q0xSKytyc2JqdEwx?=
 =?utf-8?B?NWpzYkQranI1cDkxUmRxbTZJSEs4N2JFY3lNYmJIWjhEM1NUMVkrMWJIb0lq?=
 =?utf-8?B?QkN6WTMzampVU28wdDVxVWhUWWx6eURLNnQzbUdubU42WmYyMVh3Qm9ZQW82?=
 =?utf-8?B?MzJqVThuYjFZcUlxQjVvZW5La0o4ZW9mQlZDTVArbWlrVUpMMExYbUJHMUIz?=
 =?utf-8?B?T0Q1WTNJSXZZRzkxNlFWaERvWlp2cmpmY3hxSGRaV0J6NlJKTWZmM1h6cGo1?=
 =?utf-8?B?ZGNsZkRYSlZ0aVJqMDRpcXE5RlFiSWpBcUY2b2xCTi8rREdKNTBMUUFMYzNK?=
 =?utf-8?B?WVU2Y0NkV294eVBoaG1VNmRvbDUvRlVRMTAxNTZpbVY0cVphc0QwK1JIaTJJ?=
 =?utf-8?B?aDlhQmRHbGd2dTdWR0pQU2ppb0pReE9CRS94RW5lWERYMlhVL2xZcFhNcldZ?=
 =?utf-8?B?RWN4bHZYU2ZWd1RoNFpMNGluVng1V0d4T0NhK2ZRdjI4TWpzK0t2M1hpdlQr?=
 =?utf-8?B?NHpjdFNvb2NhOVB0RnBEa0ZjUXRma0VhL21SRzE0VytuY2IwT1VzalNWZnFo?=
 =?utf-8?B?L21WekNMeFpvWTh6N1ZPUVozZnB4MFJvOTFTMkZmMjMxNldQNGE4RE1TVXlI?=
 =?utf-8?B?ck9QVUxCV054T2N2K3UyNHBteXdrZHV0R1hqM2Y3MFNlZk0zd3R0VmM2RlJM?=
 =?utf-8?B?ZzFFbnI3VGlXTzYxaDMzUzQxUjlVSExxRnh3a1RaY2xmOTdiRUhySGdhNUUv?=
 =?utf-8?B?czdHNVo2dE9TK1ZkSU1Tem93Mk93TXpkbTlyVkZ0SmtLeFZmYkxvU3BPY2pJ?=
 =?utf-8?B?aUpENDJpcjhIYWxtdm9Ca0hVWWJ4T1VBdkkrU2VCMjd5NjBmREp2TGx4UWh2?=
 =?utf-8?B?TU9qM0pmU3dWQktoN2lKRDNtVFUrRGpTNXdPa3l6aTR5Rm5lZGc5RlkwRmU3?=
 =?utf-8?B?ZUhCUndacWZYcEdheE9yN0ZjcThlS0duMm16Nzg0SUN1c1RIZWZqUHY1SC9j?=
 =?utf-8?B?TFY0WkxwdDI4azdDRW12VXN0dVhyMHk1QmcyczMyZlNtZmhKcUd0WjlmSWd5?=
 =?utf-8?B?c2lxeW42elZnMy9GcytOSU93MkRwWEcvdnhCZmlDNTl3ZUVBVWxuNVN5Tmlx?=
 =?utf-8?B?RGUyMi8vbzlobmJuZmY2Zmx3TEpKN3VONWY5Q2RlcHh5bTBoMlI1MmpJYXhp?=
 =?utf-8?B?TGlPRkhaWTdlbXMwYjJxSE0zLzg2VnBsZldQd3kyRlNjV0V6cHEzRzJLaXUw?=
 =?utf-8?B?cHpyTFBPZytpZTNMbjQzU0dicytVVkFwYlJqdTUrWTBkZEZwMTVKTW1PSEgv?=
 =?utf-8?B?NG1KZkZtK0hwNDUxTG5ySXV4clB6b2NpZmZqcGt5a3pjdVh4ZHZRa1ROZ0hE?=
 =?utf-8?B?SFZXb3lXanJCYnFLMEtqVzhUZjQ2MXZKOWhSOGZMNG5TWTQrUHJITXcrdXVZ?=
 =?utf-8?B?eWFvNi9nekNoeE56Y1pHTjdIQXB4T3dpRVZkVFV5OGlUTjE3bS92TnJ2QWxt?=
 =?utf-8?Q?OuefsQmeKitET9yO9JePLCSqB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3287b53e-2c48-48d3-0db0-08de3901b1ab
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 22:07:37.3745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxHaUoLRoQfEEatrmQE3wfZ5TW8RlikZf8f+IlbLjSl8I6MX7pT4nRM76/8wePjZuoVf9jKoHKDPdYHP6/gHig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145



On 12/11/25 9:00 AM, Kiryl Shutsemau wrote:
> On Tue, Dec 09, 2025 at 03:36:09PM -0600, Pratik R. Sampat wrote:
>>> Agreed, I think Kiryl was hinting at pre-allocated bitmaps as well.
>>>
>>> Since, the overhead to do this upfront is fairly minimal, that should
>>> certainly simplify things and have very little to no meddling with the
>>> original EFI struct.
>>>
>>
>> Taking another look at this suggestion, I think there may be more to it
>> than I previously thought. Parsing e820 tables to know what the range
>> are for allocating the bitmap to cover hotplug may be difficult. For e.g
>>
>> [ 0.000000] efi: mem110: [Unaccepted <snip>]
>> range=[0x0000000100000000-0x000000017fffffff] (2048MB)
>> [ 0.000000] efi: mem111: [Reserved   <snip>]
>> range=[0x000000fd00000000-0x000000ffffffffff] (12288MB)
>>
>> Parsing of the ACPI SRAT seems to be the one that gives us useful ranges
>> to base the upfront bitmap allocation on. e.g.
>> ...
>> [    0.018357] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x17fffffff]
>> [    0.018781] ACPI: SRAT: Node 0 PXM 0 [mem 0x180000000-0x2ffffffff]
>> hotplug
>> This is also where max_possible_pfn gets updated to reflect this range.
> 
> Do I understand correctly that EFI memory map doesn't mention hot plug
> range at all, but SRAT does?
> 
> That's a mess. I thought, all hotpluggable range supposed to be declared
> in the memory map.

Not an EFI expert by a long shot, but seems so.
EFI_MEMORY_HOT_PLUGGABLE attribute does exist for hot-removable regions
of memory that must not be used for allocation during the boot context.
However, I am unclear if this in principle is also supposed to span
the entire range or just the cold-plugged regions of memory.

> 
> I wounder if it is what BIOS provides, or is it result of EFI memmap
> cleanup by kernel? I see we are doing bunch of them, like in
> efi_remove_e820_mmio().
> 
>> One potential solution could be to parse the SRAT during unaccepted
>> memory bitmap allocation in the EFI stub. However, this would fragment
>> the implementation by duplicating the SRAT parsing. Alternatively, we
>> could keep the current approach of dynamically allocating the bitmap on
>> hotplug or I could also replace the entire memblock_reserved unaccepted
>> table like Kiryl suggested if we must absolutely avoid changing the
>> unaccepted structure?
> 
> Other possible option would be to accept all memory on hotplug and don't
> touch the bitmap at all. It might be not that bad: it doesn't block boot.
> We can think of a better solution later, if needed.
> 

Absolutely, accepting memory as soon as it's added is easy.
Benchmarking it's effects may be a little tricky since unlike measuring
boot-time in eager vs lazy we may have to find representative workloads
to measure how much overheads accepting memory up-front adds.

Thanks
--Pratik

