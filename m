Return-Path: <linux-efi+bounces-4741-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BF6B53E25
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 23:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45526171B12
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 21:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8926257829;
	Thu, 11 Sep 2025 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UL6+mE5F"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8C1957FC;
	Thu, 11 Sep 2025 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627596; cv=fail; b=NmHxvCXnEDFpq4mMIyuPS7oAiM+u5YQ4faBzqd2oslJbnFDWmr3Y3nDPXp8vsle5H6toI39FZ2kF7GfiSUzE6yWg9saDtWf4Z3rkhAAx8Cf0O16jpjzP0xX/fqbN3vRV+EViCiTIKCVc4H8RxwqGirvjIaw8iXDwKlgHs6peQAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627596; c=relaxed/simple;
	bh=QjmryMmPKIOs9ZMG+FvAztKsHzpN3s/ohdN6OnZaz0U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lNW2AoZeNefw6e9GWaBItd3jSVtnNP5tjh8u4+Ku4b263oLgbqI85G+WNaTUov17tFJ3YaPJxbSHbe1hyGGSq1/kpQCfE1eDG/2bxBEeMc1PEd78VZbXYVuKAO/UADqsf1RdBZJPpmFpQefjM+XTLqiRbU3zgkrjAdOCYFiRyzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UL6+mE5F; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+ySgnFLzvgZvmvwkua3ptL08IcrxqIMSKcw2nAkfAsp9Y7R5TcB4RF4wEYBflC7YFLfLGSfw5Dl0UhOj4zfI8+SwbZd0HekThFERR2OvnmTNTDv9413p5l0ItZc06xIj3sLgPQRBOZZ00B/YVcFePLgkRDGD0uoYzMqdqG8t+2SHif9FuB2fCONCsrxK0aPfQI0vY0bczLhTSTrrTnUIyFYNmLXpA9wr18NU5NwzW7TfOVElZtfQq/CdmUZW+ZRNgz8BV2MFKp4uHA8jbIL++iNHXU1aszWyxUW/redEyFMbdxnPJ1oIFCIsgezid7XqMMwIsGSE/UzkgzjwEUUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ99HczvWm7Ykf2iUCHIeEQOJ+B6CknhZciIfYqjuco=;
 b=cY9klrCMdbBH6v+ZG3o4+sbRwRpjwnTE9hjOIYOzdXmxwx0N8BEbj40zp+MAImpgodgnJqNg1ddoceuKAhwx2qI5f3ENkAJbvE2ZE8bKYXSZEdJ6vlt6+O8vMZ6lc9NxhnDASRoP8NTcCdG4kyGaZb+8SYjFQeKuz2VkpOIyEYTzkT4QsiCKyt9Hwyusf1LvJ665MZVjI6RPmmiQQlEHmi6II/l9EcdXz8Ut90zUi1HLJy6nWUMe/0S6rD6zjiMRmH0joG4FTMVdYTyLqs9qKVN0UWWFb/ftOlekXR7+n2ka8na56ALBn0117YkXJCnpPW+hVE/U5oGfe7+tFOJAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ99HczvWm7Ykf2iUCHIeEQOJ+B6CknhZciIfYqjuco=;
 b=UL6+mE5FRiHYbim6GIM8BpjiVqd2t+sRUUpffPe+IVhXSpGTMVWfxkA1wSvGo3BXcEFTUFF7fqAKCguIyaW4y0IWC9LBouCoaxMiKOp8AupVW/9uK2cH3OCrrrja7cSLb9OIUzghlbswesaG8qZfP8irmfbjgAFF56ccl6nF5c8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 21:53:10 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 21:53:09 +0000
Message-ID: <802166ae-9420-41f6-95ed-6570ef660369@amd.com>
Date: Thu, 11 Sep 2025 16:53:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] x86/efistub: Don't bother enabling SEV in the EFI
 stub
To: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
References: <20250909080631.2867579-5-ardb+git@google.com>
 <20250909080631.2867579-8-ardb+git@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 xsFNBFaNZYkBEADxg5OW/ajpUG7zgnUQPsMqWPjeAxtu4YH3lCUjWWcbUgc2qDGAijsLTFv1
 kEbaJdblwYs28z3chM7QkfCGMSM29JWR1fSwPH18WyAA84YtxfPD8bfb1Exwo0CRw1RLRScn
 6aJhsZJFLKyVeaPO1eequEsFQurRhLyAfgaH9iazmOVZZmxsGiNRJkQv4YnM2rZYi+4vWnxN
 1ebHf4S1puN0xzQsULhG3rUyV2uIsqBFtlxZ8/r9MwOJ2mvyTXHzHdJBViOalZAUo7VFt3Fb
 aNkR5OR65eTL0ViQiRgFfPDBgkFCSlaxZvc7qSOcrhol160bK87qn0SbYLfplwiXZY/b/+ez
 0zBtIt+uhZJ38HnOLWdda/8kuLX3qhGL5aNz1AeqcE5TW4D8v9ndYeAXFhQI7kbOhr0ruUpA
 udREH98EmVJsADuq0RBcIEkojnme4wVDoFt1EG93YOnqMuif76YGEl3iv9tYcESEeLNruDN6
 LDbE8blkR3151tdg8IkgREJ+dK+q0p9UsGfdd+H7pni6Jjcxz8mjKCx6wAuzvArA0Ciq+Scg
 hfIgoiYQegZjh2vF2lCUzWWatXJoy7IzeAB5LDl/E9vz72cVD8CwQZoEx4PCsHslVpW6A/6U
 NRAz6ShU77jkoYoI4hoGC7qZcwy84mmJqRygFnb8dOjHI1KxqQARAQABzSZUb20gTGVuZGFj
 a3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPsLBmQQTAQoAQwIbIwcLCQgHAwIBBhUIAgkK
 CwQWAgMBAh4BAheAAhkBFiEE3Vil58OMFCw3iBv13v+a5E8wTVMFAmWDAegFCRKq1F8ACgkQ
 3v+a5E8wTVOG3xAAlLuT7f6oj+Wud8dbYCeZhEX6OLfyXpZgvFoxDu62OLGxwVGX3j5SMk0w
 IXiJRjde3pW+Rf1QWi/rbHoaIjbjmSGXvwGw3Gikj/FWb02cqTIOxSdqf7fYJGVzl2dfsAuj
 aW1Aqt61VhuKEoHzIj8hAanlwg2PW+MpB2iQ9F8Z6UShjx1PZ1rVsDAZ6JdJiG1G/UBJGHmV
 kS1G70ZqrqhA/HZ+nHgDoUXNqtZEBc9cZA9OGNWGuP9ao9b+bkyBqnn5Nj+n4jizT0gNMwVQ
 h5ZYwW/T6MjA9cchOEWXxYlcsaBstW7H7RZCjz4vlH4HgGRRIpmgz29Ezg78ffBj2q+eBe01
 7AuNwla7igb0mk2GdwbygunAH1lGA6CTPBlvt4JMBrtretK1a4guruUL9EiFV2xt6ls7/YXP
 3/LJl9iPk8eP44RlNHudPS9sp7BiqdrzkrG1CCMBE67mf1QWaRFTUDPiIIhrazpmEtEjFLqP
 r0P7OC7mH/yWQHvBc1S8n+WoiPjM/HPKRQ4qGX1T2IKW6VJ/f+cccDTzjsrIXTUdW5OSKvCG
 6p1EFFxSHqxTuk3CQ8TSzs0ShaSZnqO1LBU7bMMB1blHy9msrzx7QCLTw6zBfP+TpPANmfVJ
 mHJcT3FRPk+9MrnvCMYmlJ95/5EIuA1nlqezimrwCdc5Y5qGBbbOwU0EVo1liQEQAL7ybY01
 hvEg6pOh2G1Q+/ZWmyii8xhQ0sPjvEXWb5MWvIh7RxD9V5Zv144EtbIABtR0Tws7xDObe7bb
 r9nlSxZPur+JDsFmtywgkd778G0nDt3i7szqzcQPOcR03U7XPDTBJXDpNwVV+L8xvx5gsr2I
 bhiBQd9iX8kap5k3I6wfBSZm1ZgWGQb2mbiuqODPzfzNdKr/MCtxWEsWOAf/ClFcyr+c/Eh2
 +gXgC5Keh2ZIb/xO+1CrTC3Sg9l9Hs5DG3CplCbVKWmaL1y7mdCiSt2b/dXE0K1nJR9ZyRGO
 lfwZw1aFPHT+Ay5p6rZGzadvu7ypBoTwp62R1o456js7CyIg81O61ojiDXLUGxZN/BEYNDC9
 n9q1PyfMrD42LtvOP6ZRtBeSPEH5G/5pIt4FVit0Y4wTrpG7mjBM06kHd6V+pflB8GRxTq5M
 7mzLFjILUl9/BJjzYBzesspbeoT/G7e5JqbiLWXFYOeg6XJ/iOCMLdd9RL46JXYJsBZnjZD8
 Rn6KVO7pqs5J9K/nJDVyCdf8JnYD5Rq6OOmgP/zDnbSUSOZWrHQWQ8v3Ef665jpoXNq+Zyob
 pfbeihuWfBhprWUk0P/m+cnR2qeE4yXYl4qCcWAkRyGRu2zgIwXAOXCHTqy9TW10LGq1+04+
 LmJHwpAABSLtr7Jgh4erWXi9mFoRABEBAAHCwXwEGAEKACYCGwwWIQTdWKXnw4wULDeIG/Xe
 /5rkTzBNUwUCZYMCBQUJEqrUfAAKCRDe/5rkTzBNU7pAD/9MUrEGaaiZkyPSs/5Ax6PNmolD
 h0+Q8Sl4Hwve42Kjky2GYXTjxW8vP9pxtk+OAN5wrbktZb3HE61TyyniPQ5V37jto8mgdslC
 zZsMMm2WIm9hvNEvTk/GW+hEvKmgUS5J6z+R5mXOeP/vX8IJNpiWsc7X1NlJghFq3A6Qas49
 CT81ua7/EujW17odx5XPXyTfpPs+/dq/3eR3tJ06DNxnQfh7FdyveWWpxb/S2IhWRTI+eGVD
 ah54YVJcD6lUdyYB/D4Byu4HVrDtvVGUS1diRUOtDP2dBJybc7sZWaIXotfkUkZDzIM2m95K
 oczeBoBdOQtoHTJsFRqOfC9x4S+zd0hXklViBNQb97ZXoHtOyrGSiUCNXTHmG+4Rs7Oo0Dh1
 UUlukWFxh5vFKSjr4uVuYk7mcx80rAheB9sz7zRWyBfTqCinTrgqG6HndNa0oTcqNI9mDjJr
 NdQdtvYxECabwtPaShqnRIE7HhQPu8Xr9adirnDw1Wruafmyxnn5W3rhJy06etmP0pzL6frN
 y46PmDPicLjX/srgemvLtHoeVRplL9ATAkmQ7yxXc6wBSwf1BYs9gAiwXbU1vMod0AXXRBym
 0qhojoaSdRP5XTShfvOYdDozraaKx5Wx8X+oZvvjbbHhHGPL2seq97fp3nZ9h8TIQXRhO+aY
 vFkWitqCJg==
In-Reply-To: <20250909080631.2867579-8-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0096.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::23) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bf971f-6ae0-4e81-dd5b-08ddf17d98fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUIxMjB5M0hwVEhwNGUvZlZPQ1NQNXVFYXdMSWpuai93RDFpK1dBMjBSUnc2?=
 =?utf-8?B?OExwT3VEbk9MSS8xUnM1ZGVSb1d3YkttRnBDbk9Cb1dFcjdIekFNZnF3T2ow?=
 =?utf-8?B?QzA1RmNtaTJvS2ZiY2NxNHdOV1c3cEd6a2hsdHc3aU1kREhWTzdYN1NHQmo1?=
 =?utf-8?B?UmswYkdFV0RrRlJxcGxocnYxV2VLenp5U3pyenhGZmphYWMvSDNkQktMVEdM?=
 =?utf-8?B?RjZqYnUrRG9aMmxNTEtRNTZOR0NwY1ljSk50Y01JbHlRdzRPZm9kbm11dC9p?=
 =?utf-8?B?dDR6UGUyclNxTUxBMG92eUJTNDdhMjY4cU41MldkaXhyUW5HMmd3dEVDd0J5?=
 =?utf-8?B?QmNVZTdnUnlRZnFiczFCMExPc2FDTTVScDZIeFcwNXY0eFMxT29UbXF2eERz?=
 =?utf-8?B?U2VJVjM4cUI0ek5iYXIyRm03d202QnplSldabFFDaGpmRXY1a01oVDQrcHlk?=
 =?utf-8?B?eTVnZTE4UU1aUzVaTWpnenBheWdFWU9JSW4vK1kzbEZKd2dBVDB1TjhMYXJP?=
 =?utf-8?B?dVY5eVd5akh5OW56aHZZTmhWNlZDcmpOSlZpT2FOTHliTmVtQmI3SGtkdGNo?=
 =?utf-8?B?VDlRYStxS0FRdlg5bmpwUmJiczlqWTRrZGQ0QXB6b3N2b3B5RzRMMHAvTEVh?=
 =?utf-8?B?d1J6OE9VVlZZVjVOYUhMWXNzSU5Hd1RweFZHemczekZ6eHJvN3h0bGpwcHpB?=
 =?utf-8?B?QnMxYkl4STVycHRycVRZZDdRT0drb1IwRFJHS25HOWNISk5RNGNaMG1UUXlZ?=
 =?utf-8?B?ZHlyY2J2Y0lFbHpJMVlOeEZOU093eGJGT2czdnoxeGZsVVBFZEhsK1o2Ujkw?=
 =?utf-8?B?bnY0a1BEZW14eUIrbVdZUVluN1VVMFE1Q3M1VkZtTy9YMDVTbTdrMWJGakNz?=
 =?utf-8?B?WW1uQXMyK3p4VFNZb3VaQTFUaU1FdWUxdldTcDN5V05ZY29DeDV4SWlpUCsz?=
 =?utf-8?B?bjhFU3BDQkM1OWlrUnA2ZE5EeHhlM05IYnpKN001T3QweTZQVlltYXVQclZz?=
 =?utf-8?B?Mnk3ZTV6eHpSRGtaZnV5a2t6TTJINmdrMGJnU2pUeHQrTjFJeFAxQjk3UnUy?=
 =?utf-8?B?YlJNRWtXeUhaM2haMW9SelRzeHBldU5jY3QzZGNrbHRncHJRRjRaSDUzekVG?=
 =?utf-8?B?d1JubTg3QXlJb1JSd2x3REZaSXp2bFhlQTg2OGN0K0g2MEZGaTlzNnplVGdw?=
 =?utf-8?B?ZnNlRFZWUENJTHVCSjAzMktlU3RJR1RnWFJidEIrYkZyMjlmSysrS2ZhRzF3?=
 =?utf-8?B?elBUQXlRV21SQWJMdzdxMWJpVVdMV3F5dzFYVDdpNWRHeFBTRThXdzA0RGhL?=
 =?utf-8?B?RFRyMWUyRUU2eXZnOFBaUWx6Y2FmYjI5V0YwTjRQaXFIMHVRNUlUeWpxb0Zw?=
 =?utf-8?B?WjNORnN3VEd5Z0U3cnYva28yNXZ4NTRpSFJlYm9IZUl1ZVRwUlJTZ3krdGFS?=
 =?utf-8?B?SndKSDZoYjcyaTlhOWxaTWt0ZGErZGRYQXVhdkJPUTI4VFc4RXh3RnlvNDJR?=
 =?utf-8?B?UURwQWI3SFlDRXNnNUVQanA4dUxidWFyVTloQ21DdXAvaytqNW5qSGliM2gv?=
 =?utf-8?B?dTZKMW9KSFFySDM2cE1qM1pnUzArQkJwSVFySlA5R09ud3BpK1d4bmdFR09L?=
 =?utf-8?B?aXVnbnF4VGJ6NDJZZjkwSmFZcVFnZmZZSUtzUnkzMzU3VGFoamJWN0tSb2Rh?=
 =?utf-8?B?ZFhya1pkS2FqMWRsQTUvRGE3bmprb3d2NVZZSEVCeVlYYW1HUU1TK0hEWTQv?=
 =?utf-8?B?Rk8wTFdxczZnbVpYK0xXS1QyWm84SWswOG9YYXJ0OGpjcEZGbGRJWk1wNUpq?=
 =?utf-8?B?U3ZPUVkxUEJzYTdVeUdNOThpUFBVQzZadVVPUkpUcENxRmV5emRTYXFLUXgy?=
 =?utf-8?B?SkhrZUhSUjRhQVJmSW1EVVYxdk43Qkw2Q3A3MGdXNTkvT2YxdXdGb042ZEdY?=
 =?utf-8?Q?JHe8HR2UslI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTNRSEx4UU1hRE4zcm1manVEcUZ1c2pJcnQvNnJHalFRbjhUWVhTZ1ZFTFF6?=
 =?utf-8?B?VEYxcjRVR1NkaTdobWtULzhHTnN1Q3RJOWlSeVdjYVdjcFpUZVl3U1FwODJ3?=
 =?utf-8?B?c1Y5aTdkTktwZTIxUGRXL04xMzUzQlQvU21JKzRDdXBLYVhnMS9kMGhub2dz?=
 =?utf-8?B?cWY5bFZzdExtWGdhWHVlU21qdVVnb0psd0dRbnJlTmV2M0N0ZUlvY2MwUGVC?=
 =?utf-8?B?a2FBNzNjRnl5dXI1MEdvYWRnZXB0aFlZTXdGUHJQVyt4d0g2YmVZUHVhZVdS?=
 =?utf-8?B?eWVnTnRwKzdKZ0YxdTcwS1lqYzZ5bDNqVzBTZDZVRWxaNk5XMFVNU0cvOFow?=
 =?utf-8?B?VGdzVjM0VHZRL2NFN2xhMm55aUpheXdJaUNEKzZoSkNTNXAweUdtNjBLdGdz?=
 =?utf-8?B?WWhSZWhtWnA3NllvUS9xR2ZjQzdZVHArWG5ZQ0U4WGVOUlhiL2k3enJqSnUy?=
 =?utf-8?B?VGM0R2xZTnEwUmlVaGhzWUZVdWdWa3lKY0JvMnFaVG53YWJmTGNsckNRWkNl?=
 =?utf-8?B?dTRBTTZsT3lUajM1Uk1vamErcS9xUmsvdURkU1BEQ3d2RlFNRmNDOTYrOFZI?=
 =?utf-8?B?R1pGc1Z5YnBNaHZheG1Vb3BkSzNldUhVOG96QjdYZGNtd0RqQUxJTSt5SGZV?=
 =?utf-8?B?MkFDTnA0NDdjRXJYMlJNdHR0ZFFzMDFoYkNnbWI2M3FlcXl6M2JJVERTV080?=
 =?utf-8?B?RTJPQ3NmcE1iNUlDYXJQY2p6dkZXQ1ZmWVFvSG04bi81TGc4QmZPSzFUZnFT?=
 =?utf-8?B?eVlHSGNadEF2YmFrTXhkc3I2OHlsanRVWlVnd01RSmVWRk1BRzNlVXVVVGpQ?=
 =?utf-8?B?YzBjYTZQcEc5ekdva1JGMkplMXhETHE3SEdwdjJLT1hkSmhjV09SeTRuSkgx?=
 =?utf-8?B?VUM5N3VDSkFnQ3JoVTU0V2d5WjhaZFc0MERnVTl5SmF3amswenM4WnpMc3ND?=
 =?utf-8?B?YVlTYlN6eHA0WWNCajhGYVloNVlLRzlFRlFseWZCZis5Z2hNU1RaSGNCeVVk?=
 =?utf-8?B?bFlHcTBnY3ZiU1VuQUd3Qk1QRkp5S3QwS2d6TEk3Q2RNZ2VUMlRMM0ZVYkxF?=
 =?utf-8?B?b3p3OUZSOEcyWVBoeEFWU1NEaUZKQUxkc2o3ZFpIUUFYdFZGYUIzbXhPVndv?=
 =?utf-8?B?Y0k1d1lWRUo4YWhpZXlqTVduYkxBRDR4d1djT1lPaHhLbXdYSkdoN3dDWmQ1?=
 =?utf-8?B?TlVRTGMvL2ZjSnJma2RLcExTQU00NVd5dFdSODkvclZMK1oxR0NDb09CVXZj?=
 =?utf-8?B?b0RGMEFyUHJTZHJQcEZEN3BBY1lLeTlmT0hCcjR2UWMwZ0toT0tmOG9DNG9z?=
 =?utf-8?B?N0tqb0ZQNGZZZEpzcU5QdEFCVDZPeHNDK2k5T1BZVUdtVUpRQ1FtT01NQkQx?=
 =?utf-8?B?YnZRMExFOHpqZW1QTXc3VzdCWGNMNzVpVzJwK3NNb1NoWjFyNS91UzM2UGRk?=
 =?utf-8?B?VHQ2RmRpOGJVRXJveHBBVTZ3SFdBdHVIeklBZWpVS3BBNkM3VXJqTzV2U1ky?=
 =?utf-8?B?WlMrVHpRbVhWMmR4SjhFUVdxc0lUWmlpd2NFaVpMVHBNRXpESm1PTUJUcDZ4?=
 =?utf-8?B?MTIwZ082V0ZZSjI2NXJ0NE5LM3p2RGRUVjNTREJnb0x2cXNhY1p6QzVVOFdD?=
 =?utf-8?B?K0M4WTRiOGdkaHpXOVp6Z2tkTWdxNmJVcFBQRVdSZ1Z4czRadUJaVnZWZFUw?=
 =?utf-8?B?YVdLTGdxbUc5WjNmWHJKSlJUK2NhMUx0THJ1RGJKNUxqdEVTUDBmYW1kM3BE?=
 =?utf-8?B?VW9ULzNwc3pQeFkrWVc2ZVRoaU9OUURVaHlTWTJHM3BWREo5RkxNNFBUVEhO?=
 =?utf-8?B?YTdYVHVScXhVRVN0SkROV21SZjNOQnJ3b3k2UkN2Z1pzeEVQZkkvTExOd1h6?=
 =?utf-8?B?Q2hETnNWNjRJaFk1Tkd2TmZXQVRqMlMrWENjZ3NBUFhhRVc4elFpenlxZ3N6?=
 =?utf-8?B?V0pjeXM4Yko3OE83VHJZejhBSUJsQ3FrVG5Va2tmVnM4VDZBZ1JEWllDN293?=
 =?utf-8?B?Y0Vlb2QvTFI0ZHhpcS9MTGphclloTEZiNjRaZTdabEhmN2NleTBGY0YrMklw?=
 =?utf-8?B?WEtCTzdMcCtHZ25wKzAzN250VVJYR2xBZHNpQVBGVjNSMGR5Y0VQTWFtaWUw?=
 =?utf-8?Q?b71baQhWBnhGdSwMxEZxDnzuL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bf971f-6ae0-4e81-dd5b-08ddf17d98fb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 21:53:09.7589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK5PQGTTHtZ38r5rQoTnsHIVJQa7exwW72xlRQAYL+aYMZ4xNGhQt+bTtUxyzt5naG7eJ7p7TAYF+70AhUoAkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998

On 9/9/25 03:06, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> One of the last things the EFI stub does before handing over to the core
> kernel when booting as a SEV guest is enabling SEV, even though this is
> mostly redundant: one of the first things the core kernel does is
> calling sme_enable(), after setting up the early GDT and IDT but before
> even setting up the kernel page tables. sme_enable() performs the same
> SEV-SNP initialization that the decompressor performs in sev_enable().
> 
> So let's just drop this call to sev_enable(), and rely on the core
> kernel to initiaize SEV correctly.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/include/asm/sev.h              | 2 --
>  drivers/firmware/efi/libstub/x86-stub.c | 6 ------
>  2 files changed, 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index d7be1ff3f7e0..b017e1dab705 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -462,7 +462,6 @@ static __always_inline void sev_es_nmi_complete(void)
>  		__sev_es_nmi_complete();
>  }
>  extern int __init sev_es_efi_map_ghcbs_cas(pgd_t *pgd);
> -extern void sev_enable(struct boot_params *bp);
>  
>  /*
>   * RMPADJUST modifies the RMP permissions of a page of a lesser-
> @@ -588,7 +587,6 @@ static inline void sev_es_ist_exit(void) { }
>  static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
>  static inline void sev_es_nmi_complete(void) { }
>  static inline int sev_es_efi_map_ghcbs_cas(pgd_t *pgd) { return 0; }
> -static inline void sev_enable(struct boot_params *bp) { }
>  static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
>  static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
>  static inline void setup_ghcb(void) { }
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index c4ef645762ec..354bc3901193 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -938,12 +938,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>  		goto fail;
>  	}
>  
> -	/*
> -	 * Call the SEV init code while still running with the firmware's
> -	 * GDT/IDT, so #VC exceptions will be handled by EFI.
> -	 */
> -	sev_enable(boot_params);

I think we lose the check for GHCB_HV_FT_SNP_MULTI_VMPL by doing this. It
might need move into svsm_setup_ca() now.

Thanks,
Tom

> -
>  	efi_5level_switch();
>  
>  	enter_kernel(kernel_entry, boot_params);


