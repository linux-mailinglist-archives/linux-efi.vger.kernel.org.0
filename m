Return-Path: <linux-efi+bounces-4511-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99907B1BA31
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 20:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C483AE0AE
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 18:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C1D2989BF;
	Tue,  5 Aug 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="rTbPoazN"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2090.outbound.protection.outlook.com [40.107.236.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7FB29CE6;
	Tue,  5 Aug 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419020; cv=fail; b=Wn1Qgzg5d6DPLEH4UqJSF8Uy3o3OTS5jl2LpaHZyDwfDDYKM80RLFyn3IuNhwIVwOtUi6x7uwXXNgCEM2/xyxzH2wbnW+HzW8jxlbc3ebv6tlS8op+/mkP9RDzaqOes903ow7gv4EAsTLs3KMCLPTx2rvsHK4UKOc09A11P4XEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419020; c=relaxed/simple;
	bh=bP9MxTfWp2iunf1t/SUtqZzYx3gp637mDqP2KLuzeok=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Rx+6mg4zGjwM0J0MOTqoByUX+vZFsfwuvCZPzG/c7/p3Wzg5ikoJwB2rdopuMLGd5+A0EPzcC5wGaB+bl5LG+B6YqK2zjUn/SfDJzzwUs34B7QsVj7HVRSfLBAtMubLmMZ8zEwaDUSryEyi8KMzjPilAYQc4V/E7/h3OEU4YgUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=rTbPoazN; arc=fail smtp.client-ip=40.107.236.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAtDwxeLEeiQugaRseo8dj4Fo7HeBQ39Ym1RqboHr66jXG9qZWKLbi9e3jcItOy7FnBpNm9XrYq3DFWEOfrQO9wuGT9M3ttzFznPDxZuHHh0lRdeE6wZtXm4UKsjoj+H64gZ6XrSsXqKUAhadXEi/SlKhd30SYbQkMM+R9U14zx2rIc13ZBMEU+giaU+542XGGe/Nk2pJEC0bHY4J5MxI+2GGdVzQw9HPxng82A6qjTEMUdr9vJhHeFsgao4rT/C+5aV9cz0YpcGZC/yBY6In4Txg/ZHXyKq3rLaCdP7amEaS94XUCPrqkPNIm9T42dTuGB9D9Po4b+cWEZvxZzLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw/UUci8NxIzvRqSucAZNn/fc+rnYcjbBLQ8KBo3SV0=;
 b=G1Ul9m2LcdxM5MAbj3EPvd1B1GhGVuBqMHLus6k+8DKbrKIznu0vs0V52QZPeD5upET/z/0OGjfNcmlINTW5dCsY3M6401ubBDxKlIdDSohBMr43dRFWlNM6FkYfCBNB41jt+im0OZhFmNN2FKRelkJvCQTXb6lOXl1b/j8vUgxB6D6ovJjyVbhPD1K9mGgQ4UBNjGN7dRwoggImxq7Ge8ZZyfdQiHzVMcAhHCoGGU5OsUg+Log/4yuywmJ9mJaDG6hjU6g8nlWaKzucltQw7IH6tEhr72/TVQnvxAoMUAUjW8U4IaN/Y31Fq6UwAdVvVF8sadrR/8jFytKtSXpDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw/UUci8NxIzvRqSucAZNn/fc+rnYcjbBLQ8KBo3SV0=;
 b=rTbPoazNJXhW2yDFQBqYNwrBk5+o68HxDxOeBJHJQfd3uNSc4Z79IF5udYvDxUd5SfFGEJ5Ki+0uVGr8mxzcC/KZi5JfYC0/mY60utlot9N/PRU9yUlVFPfzqSp0naUEa7dA3gpSKjFtYOxwZQf8q9W0paQjkPudhLe0PCbncuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 MN0PR01MB7755.prod.exchangelabs.com (2603:10b6:208:37e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 18:36:55 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 18:36:53 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: [PATCH v4 0/5] Fix issues with ARM Processor CPER records
Date: Tue, 05 Aug 2025 11:35:37 -0700
Message-Id: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPlOkmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDI1MDc2ND3dzE0qL8+DJj3TIzXUMzXaAeI11jSwszEwuzlFRTgyQloM6CotS
 0zAqwqdGxtbUAGuxdoGUAAAA=
X-Change-ID: 20250731-mauro_v3-v6-16-rev2-3986486de50b
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org, 
 Jason Tian <jason@os.amperecomputing.com>, 
 Shengwei Luo <luoshengwei@huawei.com>, 
 Daniel Ferguson <danielf@os.amperecomputing.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Shiju Jose <shiju.jose@huawei.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: CH0P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::15) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|MN0PR01MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: a98a9a10-3df6-4d9d-3546-08ddd44f0c43
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGdvZ0F5ZVduVS8rMzdkQXluSy9xaU4zR3VtOTNxcVFGdHl0OGI3d3podmlB?=
 =?utf-8?B?VmxpMFphTG1WKzZuTDNCQm5iR0NjYXRHMWkvZmlraCsvazBCOFc4Q3JtbGdR?=
 =?utf-8?B?YVdlMSt3amk5SExBMjB4MzNaUlkyZklXMFlYODRVWnBNRklpTi9PWmdYTSt1?=
 =?utf-8?B?RDVCMXNybG9HeDBMUlhrZ3Z3WHdRZTNBSDVLenNhY21FcTNSdGdsbmVibVFK?=
 =?utf-8?B?OEQ2eVhncXhwZUtFclVtSlhpbElKMlF5cTFVam1FdnFROUxkL1gwQ2F4bStt?=
 =?utf-8?B?Sy9GczBCWjBsNzBtb2dGck9BOGxpclhBdlkraUwxSDdrT01sMHJTU0p5QnpE?=
 =?utf-8?B?K0pHc1ZHVFB6aThtajVLdmw1WDJEemRZK3gzSVA5amFnUjF5WC9kS3p2SUJ2?=
 =?utf-8?B?cENKYzZPTUVoclc5RTJiRTBjaVYxYlFNdjM3ZFJCKytsYnZ0T2dxd0NmQXFi?=
 =?utf-8?B?dXlydlRzM1FJUGVLZEJlWmpqS2tQRjNZdkFBRjZVY2phV3UvRkhsdHF4S1FC?=
 =?utf-8?B?bk1OUFlCVk9jMmtYQ2syUnJJbGZrd0dsTmp4Ylk1dFpGVnM4a1pDWHozTitz?=
 =?utf-8?B?NW1KazAvUmtzZklQdkFIRG9vUkpTQW5VY0JHRXh1K0pkSFVIeTEvVjJqYzZ0?=
 =?utf-8?B?Z2lNNlkxdXdneWJtNFJNVFJ6UzZ5Uld1dEZzc09aRytVMnFQZG5JM2ZMeDdW?=
 =?utf-8?B?OFdwNlZsVU0vSUlKY0VqSFpjbDlhbHlDVXdESmovUm1IY1UyMTRZOGtXalV5?=
 =?utf-8?B?VkpWYkhlWVN3NDAyL1J1ejFJM0w3dWUwb21NT211ZktHODVyZUZySCthbWg5?=
 =?utf-8?B?TDJrWTBUOGVXUlc2UTZwcGM4N3BSdzFvN2tyVHU4d1V2Um1ybTFSR1dtb2Vk?=
 =?utf-8?B?K29XU2FISHBvUTBQTDh2ZHdoTktBRnpDOEp0SC9xYzdrQTYrViswdU8wbWF3?=
 =?utf-8?B?M2RMTU5MUmRIdFZkanhiZWt0THpSaWs4NDlGclVscEdkbkx4VGVyeUd3ZWM4?=
 =?utf-8?B?cE95RVpEcVh5Z1lZTEdQQkFUNEhVTFVlK1huVEdkUHpMNGF5czk0cG0vbHpN?=
 =?utf-8?B?clNDNUl6WlBHTDJTVGd6ZXMycE5WOG5LcUtLSDBJTmdlK2tIUlJBb3BzQmpn?=
 =?utf-8?B?VGtTVEk4OXZUVEwzTEp1QWFaVEVkZlFHejI0Tk5qVnFobk1sVU1iWHloeUxL?=
 =?utf-8?B?b2JmVDhYUGlYblZ1a2ZQMnZGTG90MEQrRTFSaUx5VlV3WXFOSlBnNEhmKzcz?=
 =?utf-8?B?aVdoUENZSWkzalNGWXRtZEFwaHlac0xKUDJ2YWpyWWY3cGZEZk1RZXQyaExh?=
 =?utf-8?B?Yyt1VFFTMmdrcVhiMXYrNEhPbkVvYkJOakJKaHVlVFhRRk1hWjRXTFFQdldR?=
 =?utf-8?B?NzluT0J1ZDdueWRnS1BXT0dpSDlBL3hUK3ZSZzM0QXpSZzFCbFpRYTFKQm1m?=
 =?utf-8?B?RmkrUGFsZWlvYWlsRHR2bE1LRDM4KzhJeVJWYktwVHFlOEVJYnB5Ukx4YlpR?=
 =?utf-8?B?UVI1QVhsKzZOTlVjbmVZbEkzWHl4bjJacEhKeXpiYW5BQ213RDBydExJcHBZ?=
 =?utf-8?B?UjlhQWRlVHhNcEFSZ3R2Y1g0eFE4M2MraFJYZzJBUzdTYmluNnYvN01XRDBr?=
 =?utf-8?B?MmVsWVRub1lmUVhrZUEwZ3B5cVFyMUJnRlBicGJRVTMyOTNrQU5VZFBFT0RF?=
 =?utf-8?B?TGhUTmVCT0ZxTjNBbWQyaDMzNmgxdmh3VlpDdzNtVTMyTGkzSjBHK1VNbTFt?=
 =?utf-8?B?TFZDeEZkdUF3RWY4dFIxVmJFTHEwelZ0L2NoZ09Ka2hRVlRjZGM0RFV2cmFG?=
 =?utf-8?B?T0Z2bjRRNmpuL0tpMjNHT3MxVlFZQU0yTGFpbUxic0NrNzRtSHkvS3p3bjA0?=
 =?utf-8?B?aWswYStwSGtFOGUwd1FsWi9vaFQveEp1OGVxbXZSak02NUNBTVg0Y0VzeU5y?=
 =?utf-8?B?TFlKOGE1eVI4cjVwVjY1ZjNMUjlCRnJGZmRpdkNGcnBQS2UxVkNXWlpiWlF5?=
 =?utf-8?Q?DYU0BbIdTv5p5bP6FJ4cXb9FqP1N3s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WndtK2FzbnVEbzdWMHFSVGxhcWpQUHF1MG9CZE50QUdJQjBqdWtEaGNGZlU0?=
 =?utf-8?B?RzFBNzdibE1YSWMyOWIwbWZDekpIamFDaU9rSkZMdGJwelZlOFRRNGQ1VktY?=
 =?utf-8?B?M1Q4VmxJMnMyQVQ5WXRSNmlHQUNJWnlkNjdOd00yRG5lMDJkZURkRWxkZ1o5?=
 =?utf-8?B?MThuc1NMZGZ6VllLQ3kweFVxQmhIT2VxYitkMS9Xa3VEbnAvQ0RLZ2NNS01v?=
 =?utf-8?B?azlyUWlyUHRlOXVGbzkxR0htd1d0R2lNa3N5VkRMUUVkMUltNzAzSC9zVUJ0?=
 =?utf-8?B?enp1eWo4dURNZFVoWkFqYnIrdG9odU0rMUNSSHlJbVZ5Z0FBdmdsVzQyV2xn?=
 =?utf-8?B?Tk42T3Q4aUtQMnNzZm9mREtadlYwZyt6U1EwcFZsTlBFcEZ5WHUvSDJmcDFm?=
 =?utf-8?B?S1VUQW1uOHVMd2wxRFMvSkZRd016cm11Yi9sMjFCSGdVbUhzc3BvNjRXalV1?=
 =?utf-8?B?OHVPUm52aVdkY0UzVE1NNG1ONk5xVVFEbnFtQTkrRXBtcitlZUFxajhOdTBX?=
 =?utf-8?B?WDVmUHhwWm5vN3BUZlZqT1J4SThWdVgxUEtjR0d4TXRsNnZKMTEyWm5iQWp4?=
 =?utf-8?B?MmtrTW9iWUdORmZjc2FZNTZVRkh2S3poZ2lpWWFIK3dld1F3RXkveXloVm5V?=
 =?utf-8?B?cFl6NDhqOEdPRDJqbGJIWUdwTUlPUmhaUVdKS2dSYzR6dzZEN1F5b3hORVZl?=
 =?utf-8?B?QU1pRU5GNjVseVZOeVZFVnN4cE02N1BCZ1E1d21peGVsdlBlb00wckw4Y0FS?=
 =?utf-8?B?Q2laZDNSSjcwcjN0ZnRVYjUvaTFjUGxVMmN5dDN4MVlZcWhPTDBGcWVPVEcz?=
 =?utf-8?B?azZsTTc4UGtCZExUMmZvLzl0c2tYV1h3R2lGcDRCbjZPNlpuNko2cWk0VGJC?=
 =?utf-8?B?a3lpY2VzZG0veloyRCtvTHpNYlNodUt0STdNSUQvNUZ5ZXB4UlZ0eWFYM253?=
 =?utf-8?B?aGVSTjdUS2JROWdkV09kaGI3MStQWUVlUW9QUmhKMTJRWnBiVS92azFPS1Q2?=
 =?utf-8?B?Z1ZOTTlWcGs2S0RQd3VTaFRNVFZvanYyaGhlZEQxWGZ0aStXUnBaQW5Xbmkx?=
 =?utf-8?B?a01XSW0yK1cvKzlBd0FRMmcxdGlzTzQvK3JrTzlaODJaaTgzb25SYWdDRGNy?=
 =?utf-8?B?d3UwdlBENEZKVVlXR2ZFOXZpd2hkWlV3WFd3NWlCUVF2QytOQkE2MHFQQ3Qz?=
 =?utf-8?B?MTRQUHlwUTdmY2lhM1N0SmNTUzRLM0VuUEVZancwdkFwcTRVVzlieVQrWlJH?=
 =?utf-8?B?MDA3OUhYOEhveFdnMmd4TzA1enNONHNIbmFHdjEyZDhYanBpQ3BRcmhxWEla?=
 =?utf-8?B?bGY4YWtOa3Q0UDhsOFJpZjh3Mi81YWtFVkN3cXc0VU1OKzJ0OGNHWmo4YnZp?=
 =?utf-8?B?S3E2bmpHVnYzSHl6dmNFT05TbFhYZHJ4L25xamdFWXJ3bklGYUtLMVZuTmxs?=
 =?utf-8?B?Rkh4NG9oelFnWXJpcmd1TE9ZN3RLbWtOc3QyY2RiZi9iRkJOWVl6eUxMQmx3?=
 =?utf-8?B?eU1QN3pOUHlhQ25malN0U3dYZFVlbHJMTkNjTjMwWUVtL1FyeEJ2SEdmRDND?=
 =?utf-8?B?eDFkRGhyOTM4d0FoSldJWUJKVU9uTkg0SFAyVG1RcEZnQmt1bFJuQUx1WlMy?=
 =?utf-8?B?WTluZG9rQTJrYTZTMCtDTG05NE16NTZqU3JWRUcrK0wxdkdzQyt2eXlYZFVD?=
 =?utf-8?B?WmxXWTZGdDZyODRJUisrSnIvRVVLMmlBRyt5dHBvTTVHNUhwK2d5VERLZ0xU?=
 =?utf-8?B?dVh1WEt6UDVmN3VMaVNaYW1GQU45MDdSeXZib2dLUy9VK3dUMFlsdXhEWEtr?=
 =?utf-8?B?dTllVVN2b0dhaUMya0hOR2xrZ3pYb01EaUx2Y05xMHRXZ0kyejZCbU1CL0pI?=
 =?utf-8?B?ZjNoTlIxZWlDU3RxRi90MGxmeDIwSjIxRXc4TUV1cWNIcDJFSGdmYUQ5cU9D?=
 =?utf-8?B?bEdMTHorcUxmUmFIWkNsN1FVV2ZyWXlrcjJpWmpNaFpkeElpVkhkS21Ud2ZS?=
 =?utf-8?B?TUtudGRGWjRBSXl5eEFxVFRRRGZHTU9JMkhwMVNnckxhRHh3ZDBVMlk5RkNt?=
 =?utf-8?B?U28xYVN2cytDKzVHZ1A1bW1SMjFLdkZITFR4aE1zUFJaaU45N0lodGxTT2Yx?=
 =?utf-8?B?alljamorbUpUMmNZbGh2eDRNcmxTT3ZuTTJmTkYzbEZiK0p5YmFiRk1XMnZM?=
 =?utf-8?Q?R6UmMx5c374romuDtWjqZuw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98a9a10-3df6-4d9d-3546-08ddd44f0c43
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:36:53.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RnkondL6OGE6/KX/v+ItmJ+FkdqirP6wCb90/J1WhT7FRoiu5gme1zu/BCCxe35VYiophG+00U58wepRGgypmUY2f8xnygJRmdUZeXZlWHpWqZu9uli20x9mnK2wUmS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7755

[NO NEED FOR INTERNAL REVIEW, THIS IS JUST A TEST]

This is needed for both kernelspace and userspace properly handle
ARM processor CPER events.

Patch 1 of this series fix the UEFI 2.6+ implementation of the ARM
trace event, as the original implementation was incomplete.
Changeset e9279e83ad1f ("trace, ras: add ARM processor error trace event")
added such event, but it reports only some fields of the CPER record
defined on UEFI 2.6+ appendix N, table N.16.  Those are not enough
actually parse such events on userspace, as not even the event type
is exported.

Patch 2 fixes a compilation breakage when W=1;

Patch 3 adds a new helper function to be used by cper and ghes drivers to
display CPER bitmaps;

Patch 4 fixes CPER logic according with UEFI 2.9A errata. Before it, there
was no description about how processor type field was encoded. The errata
defines it as a bitmask, and provides the information about how it should
be encoded.

Patch 5 adds CPER functions to Kernel-doc.

This series was validated with the help of an ARM EINJ code for QEMU:

	https://gitlab.com/mchehab_kernel/qemu/-/tree/qemu_submission

$ scripts/ghes_inject.py -d arm -p 0xdeadbeef -t cache,bus,micro-arch

[   11.094205] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
[   11.095009] {1}[Hardware Error]: event severity: recoverable
[   11.095486] {1}[Hardware Error]:  Error 0, type: recoverable
[   11.096090] {1}[Hardware Error]:   section_type: ARM processor error
[   11.096399] {1}[Hardware Error]:   MIDR: 0x00000000000f0510
[   11.097135] {1}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000080000000
[   11.097811] {1}[Hardware Error]:   running state: 0x0
[   11.098193] {1}[Hardware Error]:   Power State Coordination Interface state: 0
[   11.098699] {1}[Hardware Error]:   Error info structure 0:
[   11.099174] {1}[Hardware Error]:   num errors: 2
[   11.099682] {1}[Hardware Error]:    error_type: 0x1a: cache error|bus error|micro-architectural error
[   11.100150] {1}[Hardware Error]:    physical fault address: 0x00000000deadbeef
[   11.111214] Memory failure: 0xdeadb: recovery action for free buddy page: Recovered

- 

I also tested the ghes and cper reports both with and without this
change, using different versions of rasdaemon, with and without
support for the extended trace event. Those are a summary of the
test results:

- adding more fields to the trace events didn't break userspace API:
  both versions of rasdaemon handled it;

- the rasdaemon patches to handle the new trace report was missing
  a backward-compatibility logic. I fixed already. So, rasdaemon
  can now handle both old and new trace events.

Btw, rasdaemon has gained support for the extended trace since its
version 0.5.8 (released in 2021). I didn't saw any issues there
complain about troubles on it, so either distros used on ARM servers
are using an old version of rasdaemon, or they're carrying on the trace
event changes as well.

---
v4:
 - rebase to kernel v6.16
 - modify commit message of patch 1, and adjust white spaces
   per Boris' suggestions.

v3:
 - history of patch 1 improved with a chain of co-developed-by;
 - add a better description and an example on patch 3;
 - use BIT_ULL() on patch 3;
 - add a missing include on patch 4.

v2:
  - removed an uneeded patch adding #ifdef for CONFIG_ARM/ARM64;
  - cper_bits_to_str() now returns the number of chars filled at the buffer;
  - did a cosmetic (blank lines) improvement at include/linux/ras.h;
  - arm_event trace dynamic arrays renamed to pei_buf/ctx_buf/oem_buf.

Jason Tian (1):
      RAS: Report all ARM processor CPER information to userspace

Mauro Carvalho Chehab (4):
      efi/cper: Adjust infopfx size to accept an extra space
      efi/cper: Add a new helper function to print bitmasks
      efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
      docs: efi: add CPER functions to driver-api

 Documentation/driver-api/firmware/efi/index.rst | 11 +++--
 drivers/acpi/apei/ghes.c                        | 27 +++++------
 drivers/firmware/efi/cper-arm.c                 | 52 ++++++++++-----------
 drivers/firmware/efi/cper.c                     | 62 ++++++++++++++++++++++++-
 drivers/ras/ras.c                               | 41 +++++++++++++++-
 include/linux/cper.h                            | 12 +++--
 include/linux/ras.h                             | 16 +++++--
 include/ras/ras_event.h                         | 48 +++++++++++++++++--
 8 files changed, 210 insertions(+), 59 deletions(-)


