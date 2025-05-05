Return-Path: <linux-efi+bounces-3593-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B546AAA9680
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 16:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F233AB7E4
	for <lists+linux-efi@lfdr.de>; Mon,  5 May 2025 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8359D274668;
	Mon,  5 May 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m3y2/imn"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486C26FD8A;
	Mon,  5 May 2025 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456537; cv=fail; b=UKIl/7zAaJWbyuVV8F4605581jNod3ZoEUa0cKBI8COweX7g8J5iLSmmVGW4Lr3xNWqPz9uyGEfP1PLfsEfjW1iLlHExLVOUtAY00R1bFrhdizpHE+IpPQlZKIWcNK0A4llvTiI0JdSx9us586xV3Y3webOonD85SUnPjv5l1Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456537; c=relaxed/simple;
	bh=FvnkgDIMXn3XlIv57NZwjVW8QCxzQ7HvbmL9i8Qeq5k=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=q9noFGHmfRRDKlJgOnpvap3vJSV8mhf1eZ6bjilN0Mq0P4hCbyzdPGmWdfGx/YPTwwJWj1gHzIrhbmm/2ecKreBCjHDTfAokELGZqY2g2BaKluJbp0z4SN9UXK3CgnYWmWTbr22u8idVRdp1W6eOirln3ojGtBHmyjedkHkM7/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m3y2/imn; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xR6bDW7ZRkNhUajQztP1qaWdGKRRykvzLdOoFEO7LKCqBDhu0OhE9maSUSihcVsV6B7bu3CRatoQhI5m6/Uu2dcTWKgllTp4EYUUH1xjbVG3GHzMev8fFdHI+fLJw8zWCjAgBXr0w3sANTvnSA3/I4NHw6wFMAFaj9XkugrchKU9WsFZvx5bmJwjOjjoAEypWK7Wa4kS0PYYjpUz7tQS7CmPTpa7wmvMm0P9Ropy707m7Src4HraSl1lc0AW4HT7FDhFE7+17E28FmPRg8PjB9N4HPdJgICWTmHNDGpjaiF9ezbnMysaY/GwvEdf4+oq8BtHn6dKAFjninJewcitIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLA/c76Foktt76lLuT7jtf9/bZ+FfkWvjqC19P2Flio=;
 b=xGGNfC5Bd2jq49M6QF5CD34M3NLD4V9toFnFmNkqsvUtTLcUhl6wXYd1MGRrGnTR5sqg8Cct7Kt9Vot9etMX9bh8NNTMf7abEXzDU1BiLeLkQrz6lAuh/3mCJbfcNvK89LDvTMaZlNIIICSsYZpx+UyBamLOiuO2WcPsIrK3DaV7KQtZZDsSAQd2tP9zzq60h+BO/gPro8ZfQ4UbQLEO1srzu0Fk8mPCLEcCamo01wgjCuBwoKs8k/ATXDmsuX7DWgrKp4zUULjNJF3IQ1LRjMIHcGXmDn3Kk3lp6boYsUFUe5OttwTh0JZa9lNNiTkDGeIseIDVUTOpdzKvaOVBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLA/c76Foktt76lLuT7jtf9/bZ+FfkWvjqC19P2Flio=;
 b=m3y2/imnYntsPMTJGWo5qC24BX9o5RXZKcApcpAuNq5fLxoLGsOGxjTur37a0kwGcfD9/dR17o9QEksQy6ePktt5sJxlpUWrHu0eHCJ3/PpY3wkW8WcWyQ2JANDTthbPcbA1WrD7q9JIHwnp40elZmh6JhkDLhIxBHtcyS0rZ1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 14:48:52 +0000
Received: from BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a]) by BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a%3]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:48:52 +0000
Message-ID: <836eb6be-926b-dfb4-2c67-f55cba4a072b@amd.com>
Date: Mon, 5 May 2025 09:48:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-30-ardb+git@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v2 05/23] x86/sev: Move instruction decoder into
 separate source file
In-Reply-To: <20250504095230.2932860-30-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:806:d3::17) To BL1PR12MB5062.namprd12.prod.outlook.com
 (2603:10b6:208:313::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7bac8a-ca9d-4888-99d6-08dd8be3f3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STFNYUJjRHNIUkxUMFZSc1VjMWI2VU8xdEwxVHdIZno2UTYzUlg1WlBHcVJW?=
 =?utf-8?B?L2ZjMG1NL05JUzMrUmRKckdyZEdraUUzZlg4RG9zVWYrOVNVZit1SUJQSkpX?=
 =?utf-8?B?TlRra3FJT0x2WXF4Qzg3TGhZWmRlbEN3TU9JckZxeE1NK0NVcCszcDJ2bHpV?=
 =?utf-8?B?K0diWld1UUFpRHhxbTVWdzh1M0QxbnY4WGdXb1JKZ0ZMcERuM0RiRnJ3M0pN?=
 =?utf-8?B?c1V6Q0Z6cTRjMkRScVpRNWZPV0RJQXdweGE2ZjEwSWdsaURpSTdYWEN2eHRM?=
 =?utf-8?B?eE1WVHNTNWxJMFJpY0VMV0lLSE1pQUh3WlZkYkw0Ykg0ZFkzWVFLbnloSVRN?=
 =?utf-8?B?eVdTcGljb0RsTDQ5Z1RXTE83eU1wMHJWaWh5Z2JORHpvZjZXUE1BTXowUk5B?=
 =?utf-8?B?RVdGQlVBUWxrNGc5cUdOOHFVdWg4eStiNkkyYXhncjFMMGw3eEVHczVFcnNw?=
 =?utf-8?B?Ri9WTUxxd1ZITU9NV0lhbWVvMDRnM29kVlJHcmJHZldXWWhZbVQ5WnBqQ0Zj?=
 =?utf-8?B?OWYrSm1oSHlqdkF6eHNiTzdJVVNscFVQdzdwZFNObk52bGtSR3hGdmNuTlJj?=
 =?utf-8?B?Qmt4RVJYQmsrY04vUkpIL0tZY3N6ZU9PUXV4bUpibGNXSnlXVG1meld3QUdU?=
 =?utf-8?B?bG5xUmkwQm9rRnlhOVFpbXpSbFRZdlJpYlUvR0h4a3dxSzVqdEZQdndYK3N5?=
 =?utf-8?B?SlM2aFZWbUFkWXFWZ3Z3R1Q2ZHZ0bVNIeGRUTjJaWk00SmxSd1JUL3E4NW8y?=
 =?utf-8?B?NUJZUmVaVXZEdVpyY2EyVktqV1VEMVhtNk1RRjdPWHRFaE9Db1NWYklrZlFP?=
 =?utf-8?B?WkF1MFpWa1p1VUdYelBkejAvVENCQzBVSWIrOGdRTHlrYUE4dlowMm1NcGJB?=
 =?utf-8?B?eFp1aU04ei8rRE1FeWoyMUs3OXdWYXMzY3ZITUJJZ05KVitHaHZrR3NzcjdY?=
 =?utf-8?B?cnU0UHNvNmZDZWpPaW4xZmRRZ3RHUkZhK3RWa0tPdG5qcHBRcDg4VWQwTFRq?=
 =?utf-8?B?bmFFUm9waEVYQ0F3azBRaUN6MUEzMjlraVJXMzdIYzdFYmE1cWI0ME14aUZR?=
 =?utf-8?B?Rml2QTMyaXRwOTlIZmtZeVpESXo4WG0ya3oxN0ZORzlEQzZFa0lOYzBwRmNC?=
 =?utf-8?B?THEzN1VBWmFuU0tBK29NclNjcFBmZ09XdUJLQnRtTjBGMkJKVzhHVlhicVVX?=
 =?utf-8?B?MmNWRzZjVUZZUnJvLzB2UmQ0UTZoSmQ1RzZINVV6Y21aU1dyU1NwWG02Wlcy?=
 =?utf-8?B?RmExdG5XSG5OWG8rNFR4cTBtNTFNSEo2eUM3MmpJSDFnVEk5M0dncEdxT3ZS?=
 =?utf-8?B?N04vSVhFTEhObU9VTEt5MUtPVTVyb0txUXE3THU3RXZTOUhCSFRLN0UxQzlM?=
 =?utf-8?B?SmJrem9DbFN1UDNyOUE1d0NaWUYrMjJBOU9MMmw0NzdCRWZHYjdKSGRCTXRo?=
 =?utf-8?B?YitrMjVwTVVSMk1XbFhHdWlsbnVwd3d0Ym1XenNGdTlFSmJxd1RQTXEvek1V?=
 =?utf-8?B?ellBcDRpS2tNdWsrOU50ZTJ6WTR0Q1JDUlB1UFM4Z0ZRMkY1cjRETGljNE9X?=
 =?utf-8?B?SU02RWs0ZXFWbjZFM1hVQ2hteTBkVnVhTmtuZmJxeTQxUVJmeHdJdkpVZGR1?=
 =?utf-8?B?aFdORjZwbnVFS3E5elovZVo4Y3RTOUhLWjVhZFdWbGROT2o4d2F2aFQ0YjVi?=
 =?utf-8?B?VUJvV1BRQWhzV0pXeDM1cVpTcVN5aUd1czFlZVNUWTZ0MXl3VXN2Sk5tRnlt?=
 =?utf-8?B?QW9qcDBXN3RoOU9jL0RNTFZUV2M5L0RjSlhTT2dWZGYyZHRUYkdiWVFKN1hu?=
 =?utf-8?B?MThEYU8weEY3OTU1R3Jmc3V6cE94VzBmODY5SExXZnVuRzl1MlpFYWhURFcy?=
 =?utf-8?B?TWxCUHZ1OWI2WXFncFZDdGxEL2pwTElleTcxUzBDQ1J0VzlJRGRLOWlpWXFE?=
 =?utf-8?Q?B4O9NgvmTmA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5062.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWZTU3JRYXVFc1g3VEVGM0c1Z21uSTY1RitOU1pUK0J1YVorNTVJdWdzOWVT?=
 =?utf-8?B?ZEVuT1E2UHRSRFRRaUdUK1VWQXIwZExlTE5KejljWkR2OXpnU1k5V1FYK3No?=
 =?utf-8?B?WDFVVVoxRTNwbVZxdFpKdnNmZFRSazRlM0RiUURLVHBqNjgzVHlZUjJUUndM?=
 =?utf-8?B?alRxd2xLdGNwTlZwc2VMOVJzdmVtczFLbGFHMDVvcEY0Q1FiWmlvTnRpZ1E0?=
 =?utf-8?B?L1lXa01hMmVTUCtOU1hBSWJWeVNQWTlNanBiTVhJeFJpaHhSKzluRW9Mei83?=
 =?utf-8?B?dlh2bVRCZGIvN1hDOW9tOXEzTnd5MEl0TU5saTB3WkhiMXFOVVJKZ0hrcjVI?=
 =?utf-8?B?REhnWHJYd2dLcDB3bXVpWDd5S2dDenJyenpGeXdOVm9CWFdSang4akt0S2I0?=
 =?utf-8?B?TVZmb0wxUEJiK3VESXB2YXhhek5UZXMvWE1lM3NRMjRpVHhvWlV0SGl0Y296?=
 =?utf-8?B?dFVFSWxzTWIrQ1hUeG9mSlZmdHo5ZHNScWRvWHVVWnFsVXQrSHVQTDJ3VjlI?=
 =?utf-8?B?d2pSZmd1eTNId1dGWVF5TnV0UXN4THo2L2VZRUc4OVdKNUxuYnZzMU1YT2Rv?=
 =?utf-8?B?cVEzekFXRU9kSzRVZFNKbXRuZVR3VEVnT0FGRWVLd1dqK0ozZmlhWVlUZEJE?=
 =?utf-8?B?eXk3VEpnSllOLzE0ODh4VzlXREJZVHJFdlZLU3RZb0JMVE5vYW9CTkQrWmlX?=
 =?utf-8?B?eXRHdmJzc1RkNXpVTjVHTUlmcFJwY2tnSzhVYXdrY3A3a1RtOVhrUGJvbm9u?=
 =?utf-8?B?dWdyU0kvRkk3NFJILzBmMGphTjM0SVZMUjMvbWhCQTJWNlZ6RTIzT3huU1B1?=
 =?utf-8?B?ZUVkZkxLZXNQY3lIYnNaU2s0K3VDSUhpSTNndE16ZTVrT3JoNmJBbFgwVDhq?=
 =?utf-8?B?Q0xiM3NLaFAwRmtWSlNiVXp6amFwclNOZEROY1lqRGQzdjNQNDBreC9KdG9H?=
 =?utf-8?B?LzAzZEY2SzdOTFIvVmdMWGVBcW5OYzIxK2NvNUVEZ29YYUtuN2NlVisvck9u?=
 =?utf-8?B?RDN4VGlORzFuTDF6R3VRNXlld255enFHUDhJVWFVVkY5Y2NxYmljYzYzNWJY?=
 =?utf-8?B?a2pRL3FUTkswSVgzdGFnVm9QbzFrTGdjVWZRc1hRdmJnV0pLeFljUTNIRWw0?=
 =?utf-8?B?bVNZZEgxQlRxOUNqVTB0b2tWUFJRRkJGWTBoRm51R0p5SzdvV0c2Ry9ZTWQz?=
 =?utf-8?B?Zk1sRktzSjY0aWxDOExFZ1BjYXdmejcxRFFhTk9qbVZIYzJpQ0NsQ2t1Z0FJ?=
 =?utf-8?B?VDNQYlhvOEdGbUhNNWM2aVJTYWQvZmVoOC9JVlhYbWtST2dSUEJCR2J3NlR4?=
 =?utf-8?B?NHAyc1E3ZTU4MkpocUVIWS83Y2hlenNrSmJLWlMvYjRIQmVOdWhqWnFNMkgz?=
 =?utf-8?B?SWNKZ2ZEaExxK05tNHdYZ1pIOVY0NDZ0Z1ZTUERsWCszdmtGNHJXeExtT09Y?=
 =?utf-8?B?dVF4SlZFYWlhRUs2cUs4RFNDUk8yeDZrWHRWeTQ5bVZ1QzdnYTJPNmdMSTFt?=
 =?utf-8?B?bXlNR0xJTkFkbmRJOFRQaDZDb0ZGaTIvUWNBdnpRYzY4Q0E3T3VqNWlkZVhZ?=
 =?utf-8?B?dGIxeFcvU2VGVWJ3SERFL3NUcUg1cmxTWUdKT2FRMGdLWWx4MmwxSWlhQXpO?=
 =?utf-8?B?YVRiZXFtb3AwK0I1c0N2aUZ0QXhvZWV6NU04YUU0WGJuVWJkaUtDbDl4bjht?=
 =?utf-8?B?MmZYSVRhcGZ4WmlacFg2eEpid3FGOGgzYllaRVhtUjd5bTQ4cUpwaXA0RzhL?=
 =?utf-8?B?M29SL1cxcHpwZ0lNdFMrTForUzFKN0plSVVOUDVTZWFBdlJ5V2FCcXZRK01D?=
 =?utf-8?B?SjlqQ3lZVGFhWkdFV2V0dnhScFFCQ1p0a05RRDhSMkNNVnRZcjIvK005YUM0?=
 =?utf-8?B?eVhvMmJPYTdqWkl6WVp2T0U5azJDWitQcFREaDBvU1VNMllVbFhqK2xPUzlG?=
 =?utf-8?B?YmIrUkNXV0VNK09nYlo5bWF1NWJCVEY0bTJTVEVDd0pTQzJjVDBIc3VaUHEx?=
 =?utf-8?B?c3dtWGVYMnpmU0U1dFVaYTdsTXdPVHBQdjE2TmRRTUdpUFNsRE92R3VOd2ZH?=
 =?utf-8?B?TU5ER1c0OFhXbUlQSVlSWTE3SThYSGR5ckdJTmVpc2J3VU9QZjJPMlhwd013?=
 =?utf-8?Q?XqB/JbBmYvCTCyn7YNTCdci9g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7bac8a-ca9d-4888-99d6-08dd8be3f3a9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:48:52.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUpNz6yurCu90kblK6RJRT9cQIIPFcs+7RpSvzLy72HN2tuqdbbgCAgf4+1VP/hsMdmGeMueXwWILky7NGZbrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126

On 5/4/25 04:52, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> As a first step towards disentangling the SEV #VC handling code -which
> is shared between the decompressor and the core kernel- from the SEV
> startup code, move the decompressor's copy of the instruction decoder
> into a separate source file.
> 
> Code movement only - no functional change intended.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/Makefile        |  6 +--
>  arch/x86/boot/compressed/misc.h          |  7 +++
>  arch/x86/boot/compressed/sev-handle-vc.c | 51 ++++++++++++++++++++
>  arch/x86/boot/compressed/sev.c           | 39 +--------------
>  4 files changed, 62 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 0fcad7b7e007..f4f7b22d8113 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -44,10 +44,10 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
>  KBUILD_CFLAGS += $(call cc-option,-Wa$(comma)-mrelax-relocations=no)
>  KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
>  
> -# sev.c indirectly includes inat-table.h which is generated during
> +# sev-decode-insn.c indirectly includes inat-table.c which is generated during

did you mean sev-handle-vc.c ?

Thanks,
Tom

>  # compilation and stored in $(objtree). Add the directory to the includes so
>  # that the compiler finds it even with out-of-tree builds (make O=/some/path).
> -CFLAGS_sev.o += -I$(objtree)/arch/x86/lib/
> +CFLAGS_sev-handle-vc.o += -I$(objtree)/arch/x86/lib/
>  
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  
> @@ -96,7 +96,7 @@ ifdef CONFIG_X86_64
>  	vmlinux-objs-y += $(obj)/idt_64.o $(obj)/idt_handlers_64.o
>  	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/mem_encrypt.o
>  	vmlinux-objs-y += $(obj)/pgtable_64.o
> -	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o
> +	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o $(obj)/sev-handle-vc.o
>  endif
>  
>  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o

