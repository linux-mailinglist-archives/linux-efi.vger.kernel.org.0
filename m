Return-Path: <linux-efi+bounces-2926-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF78A571A2
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 20:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573C7189841F
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 19:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA85724FC03;
	Fri,  7 Mar 2025 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G4UG06tp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y0EsvB1f"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A721E0A8;
	Fri,  7 Mar 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375565; cv=fail; b=DeC3AXmJ5gtVgR/K8OOpEC1CHDpgnH2MZhZVqq2T8A2s6dMqfuIKIbp20a2vPn9B3w8smoyTPnM4lixuX+eO2Mi4W2Ay4K08vEpOafFdjF4D3AfGYOWKDFiPo9O4vTT5di2hjDRPFYOdb7yVLzVXXDT91r5E6wGvrNyTbFULqEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375565; c=relaxed/simple;
	bh=x5BROM8tKt2/bAi6Q2ccYxLfATLp1f0BWai7RsvnycU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lPui2QFdpXqRQjEy/JiA2Krdd5klQiGYpVNLf8l86u3csPDb0wjyVZjZIG2TjCRtLLbIMKSK5sNqjiWVqpnSKexGr/0EXkRQ5fBtwOirJ6hdD3nGATGR0gAiP7rYOJvA4QRy3CTwslPm5dlZLw7Zd+0glaQVJ+UlZFxsXMtEQBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G4UG06tp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y0EsvB1f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527ItgKE020966;
	Fri, 7 Mar 2025 19:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/OVKzJtrSD/6eExJAsJmxJeEgW89gLwlzpyhuP0uFG0=; b=
	G4UG06tpj7WJk9xjrqdhGbDjLuqDKl2ZwsVYA13rWhvspgd5/j0psk8P2GQE5Sv9
	yka3cifiXxwXGR3DHxoyUvKWPRSBbBt+Ct31ZsdG9KyiS9/9tNaxJsf9BAZJSRwR
	dLcCP29FWsnNGpTr+ugCjK/YFONHqrmE7mqxjqgS9hpDQJbMPoCPF/dkEgPl+h1f
	UKHMyFH28fZB8qnbfqnoXu9yPBXAYPfY5dvETicI42SmOLP2nhdQOBCrOKwFI9vv
	Zs2CfIOjtkoEBZwa0rSOUFAXUB3GT90fNx+2Ys2Ke9S+nOLhtNz3+wdqkkAnVOS9
	IVFpLq+15kS/DWcfUpv92w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hmwyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:25:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527IsBSU015695;
	Fri, 7 Mar 2025 19:25:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpf08pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:25:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvskfJC3BsTZ3TX6tWS/WuADKn0V4OXwgVL77AyS6UcthbvAgVht6bNFuntQIkeL1wmR1Wo7mPKhDbyzSfCZ31vxOwgW2aB9wUF+/q57pFgBd9k1JopUrL9WeKodG6s1UfrynhPcNFVgc+VyfUl0BFI8PbcvPgtvI1tnqgBOve6jDi39HSGqnAG6e3X41BsmN2PiKcDHNRH44AOLFfHcBq80vpS/uaxKkOYXG5M2+IBhugNudPP68BDHfgi4ZKVpOs8PClNZhO3joM0z7KD5h1mqssAk3rejreduOvEfn8oC8TqTN27IzrMkjtJUkYZcSsFxahBHXKEnc3Wmlhae8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OVKzJtrSD/6eExJAsJmxJeEgW89gLwlzpyhuP0uFG0=;
 b=AzRmJfAml72kev141ZSogw0XknEk+bz/9Ov6i7YAXncWQehepTEpE3lFRWlx4J4eDQs9RhPpnmxzv886Hc5yBY+PEuD8isibNpSZA8JIPISalwgPMK5JQs+moJFzzPigBtrDx6RXfyxCwX7DRQy1uGCgzAVHyREAuUN9UcTEBUWxn7qv1X8hvDxF4WLlCBdCMzJYJ4xPPoZqPFl0WLQDPa11gFNzx2aT5ZqVFXeMr5LrKc/b0rZvxlaSk1ApEG+d9dxUAsArFcPgQwl3IExcfdm/54pfRORDpeoyIVmVodHrFka9Ggc6+sWFlEJ/XteYT80sgEG0NjT3sjrbrJV3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OVKzJtrSD/6eExJAsJmxJeEgW89gLwlzpyhuP0uFG0=;
 b=Y0EsvB1f2BnJ2MxTlPbe66yZmaS0hrFTNW2ovBxwaCvuYF3nL6THzYnsfD++a0OJumzUReKAplQnnxnXREInPrbKu2pVXzu3GoROttdB2YtrT3ci5KEjIAcbMxF2Z/QysiSBZBJ9XdPdaPOcE6ohT67UF4FHuFZQQ7KrBh0sj8U=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 LV3PR10MB7844.namprd10.prod.outlook.com (2603:10b6:408:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Fri, 7 Mar
 2025 19:25:23 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 19:25:23 +0000
Message-ID: <d2adb4c4-b03f-4fbd-81c2-1cd017ed2822@oracle.com>
Date: Fri, 7 Mar 2025 11:25:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/19] x86: Secure Launch main header file
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-5-ross.philipson@oracle.com>
 <Z8qFdeM8YEck2j1C@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <Z8qFdeM8YEck2j1C@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0076.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::32) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|LV3PR10MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 7474f1c2-f6db-4855-cf43-08dd5dadceb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0FocXkraUE5bVNZWUFRSGZBakJTT0ZqY1N1ek9BMDNGSnNCQVNMd1VwYkFy?=
 =?utf-8?B?UUdrVlZ5WW9IYU9PU214M2IzVmVhWXFGRnZxK1pKbmN4bWZyRnAxaDlzYU5w?=
 =?utf-8?B?TlRVK25LUjlsMUZMd2lOWkt4RjVzV0dwU1ByRnN2a2VrZXp5WTJhdWxxdFBG?=
 =?utf-8?B?THJOSHlrRS9XQVdYTTByVXU1ZVlpdkZJdVFEbmVtVkd4VXZ2cGZWd1F1d21R?=
 =?utf-8?B?L2VVQ2VRMkJXckhGdEhBQU9DQ0pldTU3MXc3THp3WUpYeS94WE9GbWE3NzI0?=
 =?utf-8?B?Q05BdnZwK3hiRVozUm9nMUkyTnNNNGNXUmJtSnowY2FiNkJFVk41amYvRHha?=
 =?utf-8?B?T1c4OU0xZTNFSUVaSVJyRVNvSUNoS1lVZ2dyWmg4UHQvTmxwdkorRXlQU05C?=
 =?utf-8?B?YjVPdDBTNkJSTlB2bE9XQXo0Q2xXTzdSZEdGbU9lUThOUXgyWitHQWpDSk5l?=
 =?utf-8?B?ZzlxcDVZYWdzUmhmaWRtSXY5OVJkMHltSTlqYkRyMVhHcTArU3A0WnJYc2lo?=
 =?utf-8?B?L28wdGRkYXhWdFJ1dGZiMUd2b1BLM1YvOFhJZElLRWFVYmYrZlNkeDJkQzh6?=
 =?utf-8?B?TXRtQkhIT2c1L0J2bEtIRFNDK0V3YTF1TzZrRGp4YW5CN2Q0U1VXc25WaUpK?=
 =?utf-8?B?T3hDOW8wNlR3ZnlsQkxJZ1EvMXZ2VXJCMGhmTnpueko0TG5VZEJrbzZWZCtk?=
 =?utf-8?B?REFXQVJZdDI1bmFiWU4wV05GWFdFL1dPUk16anFsRkhxVEZqdkJQRWVSWXEv?=
 =?utf-8?B?RUZGTnYxendNRm10cC9zT2IrdHJkQUpUajZORUt6UVVFb0NUaEM0VjFBa0Fp?=
 =?utf-8?B?ZzMvcTk1TDFPd04zRDd6WUsvUzZ2alFaL040b0haSUFJWjhhcHN2cFJVTS96?=
 =?utf-8?B?TTFpWFdEdzFlR2lieDAxbVJZUjluQlU1RkhQZnF3ZXlMSDZ1YVowaG5jWUFT?=
 =?utf-8?B?eFd5NkM4Q1YvOENLTzNUSkJ6N2lnVFJOaHNKd2ZvcTdsdzhLOFFJSmlSRFI0?=
 =?utf-8?B?dlVxSWR2dGxkR2tMWERrNG1ZTEJKU01CYjdJRWNJZ1M0UFU1dG4xTWlMU0tS?=
 =?utf-8?B?NVpETXVxNnlWSThwTnVCMjFQc0E2a3VHMFVUWjlZTmZDZ0ErbW1LUVRta3hU?=
 =?utf-8?B?UVF2Z0F0K2lBNXR4dWpKZitmdE1Qa2lxRGwxU0tja1ZwSCtyVjVsem1KMWpl?=
 =?utf-8?B?ZlhQWTRacXgxQlg5aGZYanp0MDUwRmVnYVlIOFllNWgvKytZNi9reElpVGJh?=
 =?utf-8?B?TmpKaW8wMjB5dVBVaVQxSjF3ZzdqUnNVRnludGJVc2Z2Rm5tb2ZuMFpiSFVq?=
 =?utf-8?B?WUFnSFlkRkxjVGFMTUh6NWMxc1ZIbE5xTWM0cVMyYzMvTTZXNER2cHVlM1pn?=
 =?utf-8?B?VWp5dlB6L1BTRDNrdjdZeitLdFVBM3pnZHh5OHRXSjgxeWVTQkVTSE83VGtQ?=
 =?utf-8?B?b3hQY3IyZzBKUFZoWmszcVVwZ0RPbUQzWWRUbHU0QVVoU3lrU1BkRXlKNEZS?=
 =?utf-8?B?RHB3YisvRVZMS3BMZmlVYzNzMTV3bldiMVlRQURhQ3p6ektReVdYdlM0WlY2?=
 =?utf-8?B?alNmMWVDUml4L09Md0RVcENDODRzQ1owbnlLQVdBWWt2MkwwRG1LR0J2UmpW?=
 =?utf-8?B?cTlIOEkwTHNJNm9Cd1ZiRHRCR3lka2JuZzF3TVpGYVJRcGpKVnZKTlRnb2tF?=
 =?utf-8?B?TU9sRXVrTWJOYmVjOVdTdlQweHZ6ZStWTmJGR3lzSEV3ejg1cWlua1MyR20v?=
 =?utf-8?B?L1hpT2FEN0tXWlV1cjdXbkt4YXgxd2VwNEU0bnlJNUQ1anhEbWRZeUlUN3JY?=
 =?utf-8?B?WVh6OWRWYTJ4MzBHYjUvTk5XTjZnUk95NC9Zd0RYaXl1QkhMMGVocTByU0Fh?=
 =?utf-8?Q?WklSkCqHpd7oe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um0zWGtJZG1CNnN3RXFJTmZoKzBySThSdHNCK0dROFl5SHRyQ2ExVWxOaURJ?=
 =?utf-8?B?TCt4NWliSHVZVm43VkMvUmVxMmFmYVpBR3RKWW12OFVpeEp3d0NDUmdXSEkr?=
 =?utf-8?B?LzVQQjdxb0FOZXczSEM2bDBOa1JWUjVNdTFqVzAraTlSMEhqekxpZUNwWHhz?=
 =?utf-8?B?dGUvZzkxYkJLODNDOUlSbXFYSklBSXdydmNCSmNHM2QzR0QvVW5HK21wcU5J?=
 =?utf-8?B?NnhtU0RSZHBnaTBCUXhrUVpCWXpaZjdiR3c1V20wa21hbDVRSFlBZ0YwNFZ3?=
 =?utf-8?B?aWRzV2pQSjhHUGRTaGRqYnpXbm1SNVh0SnV1VXNRTTZSN2pSU0kvOHlVTFBs?=
 =?utf-8?B?U1NMb0cvYms5YlNEcUxFbDRYZGszWlV4YVB3bHBhQkJyMFVMcEdKMHIzQ0JV?=
 =?utf-8?B?TTBrWW1vRTV3U1M3OUJmY0hwS00reFF0aDVMOXBROU5MZUtnbmpiRzN5c0tO?=
 =?utf-8?B?NHdSSllrMDZjL3Z2b2tvemEzVDZuVy85ZE1TZ28yYWZib0xRUVMybzB0K2tI?=
 =?utf-8?B?eVh0ZkdoRkJzc1NrdGdDOElqMTFObkFRRVFBSlNHNmU2SFFQVzZzbk1xYWFW?=
 =?utf-8?B?U0xGWnpTZmM3b09FYzVQc2J3RTFCQkNPUmxJVzFLSWtMNHUwa0pNajhlaXds?=
 =?utf-8?B?MTB4NDVCU1FEN3QyQ0FXVmx4clBGMndiK01oL1NqVlNRM0hVUDJPQmFRMndF?=
 =?utf-8?B?NUZUODhzclZ3bldpRXBKdks0QmpIVFVPOGh3Qm1MVWJLaHpKZnNnVCtzb1Fm?=
 =?utf-8?B?MXlrWnhjQndWK202R21UblN5YTdlYlVNdGNjaHNLWjM0V0JvNDBmdDZmQkNP?=
 =?utf-8?B?OHdTR0dQeG1wTXo0ZXlGSWZZeXQ2SHhITmIvV1o0RWcybkVzTWpqcElYWFdY?=
 =?utf-8?B?SjMwOFZ0UnNhUFB0c0U3RjY5SnRkdEVoNTFLem5ONlZrQklGWENLandUSUMr?=
 =?utf-8?B?RjJWeGc2Q1doTUtHN1dTM1JUWW5WaEZPMUI2dG8rUnViTkIrYXdUWHNIanFw?=
 =?utf-8?B?WjdaYWt1Z3pXR1dtNEx2TXZzM2xNSDE3V3M1V3dFWWIyMWFpMzREZXFGcjQ0?=
 =?utf-8?B?UTBUNlBYNGxmcEpMZlhRWXhHc3p2YW1FeDRMRktwTzZUTGxIQ2NWSkFrd3BO?=
 =?utf-8?B?bURiZElkNGF0VmtMMXQ5Tm9jZ3orYlZYWTFKckxwRVQvOS9yTzE4MEo5RE8z?=
 =?utf-8?B?V3ZYTG8zVkdRRVU2ZGRHTG41a1pmQW9yTlFQK0F1NzZwZVZqT24xWW93ckNp?=
 =?utf-8?B?eTdHNjR0WVB6alZqQ2x1SVp5RVUrSFlYTE92a25xckgxSWRnS3RwcFRVSjUw?=
 =?utf-8?B?NEtrakpGbkZjTC9OVXNaL21RNUhyOFFvVWQrS3pETFh3ZDkzdEx0dXNpT01P?=
 =?utf-8?B?aEZVZzlCWGlKOFdlZFcrS0xpVDd4QnFJTDVvOElkK2FqdzRDeVNIUnZGOVBv?=
 =?utf-8?B?MnB4bXFqVG5aWUhzcldYM2svMC9WUjVudW5VM2UyWkpJbllrV0xCdEJlTFpr?=
 =?utf-8?B?S3lVeVUyYmpad1lTVFhmR2FyZHZRYTRQak1ZajVteG5WdWkxNkpNOHRoaUhM?=
 =?utf-8?B?YUw1eW5BWG1vOHRkODI2STBvSm9rTStZdStMZ2pNeXdnV1dQQ09xNTljL0px?=
 =?utf-8?B?M3JQQnlZU0RlTTJ1RkdJYm9sYkJmbzVzWUVjNFdrdXBTWDkyMWZOQ29lc3Uz?=
 =?utf-8?B?YkNxYWt1a1RHMWdZLzlMcDRPa1R0WFIrZDQwN2huZlVVNnMvRTIrVVg4Mnda?=
 =?utf-8?B?eFN3eU5iSFBtZzVqRFQ0R3A1ZjlSQkFzM0l1VHVNMUt5aGdQeUtwVGFTWlJM?=
 =?utf-8?B?Q01BQTFQMllPYzRpNGdHMzBXb25WVkJNSklKeEFIa2p1SHZsWGZmcmxxZ25K?=
 =?utf-8?B?MHErOFVpbXloZFQzUmFmcmpLNitFTitPMkJnQjhnbUxIR3dnSTBHNVNrbi9i?=
 =?utf-8?B?T2xtWG5hUHllRHkwT1VER2Q5YmVEUzRDTjNxa1VySVd0UTE4ejJGZ2Fhc1ZM?=
 =?utf-8?B?R0kvZmFacWNRRG1SUWRKL2g5RHZxcE1scGQrbC9qZXBLMEEzVm1iUkYxMUpj?=
 =?utf-8?B?QU9nc1hDUDBKakMzbGt1b3FDKzZkNjNSQ1Rtb0I5OWI4NmFod1gxT1AxQVBT?=
 =?utf-8?B?am1aNGVMQU5mamJ6bWxPbDdERVBobUhwWEUwRVpOTW5mY3luZnhwQUo4MGto?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b11hV+NEnbkgR+oMtidSrNN8cDoZUtCIvDziohsMB22ldHg98DlE85R3AzpQ1Q3Q2iMgk+pXcZmeh6J65FLkMvAd/k/CJeqcu0RzPDrISP0t6WD7/Iw0WakJBmh1CwTuYQdPVrrwerntatoaYNNQzTuHYVRAE+tCk9X2Np6lm0GuLwHJAB/KuwpMkMnvIu4SVKGV/QSSVbORxlUFgObqYkFvWMZesukIbUA768H+dsig77BcmagfS515vUI+OInE0CtzkxrTmzcnUKDmSvZzmlVdw2uMZxqXDjMazkeRVOFfMmQWPyLUL7pXHE1NFQ+8mx7vAfDqtUP/uCIjhzaynq96izLUVjlYIKXesSs1fhH8WQxbsU3834duarGxtzsCEqSyd8Q9Y2t8uQgNK+WLgYdL7r/4q/ytisbT5smG8+vcG0I8G/zpuO5mRcATJSiXz2ANNJFWRur2Vi/xkNLU+nZLOsQLZDL4khid4jsof+oMHNl8cG2qcQh2VN9lAsG6HszqZqs1McHMpRqjSXzBmnQzJwWnqpBBcw8xSif0LC48qplMCJZVfJlJnFAESLfptg/XdWi29/sAFuJcdwAs2VTyyVllMjN8BzoDbyOlvB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7474f1c2-f6db-4855-cf43-08dd5dadceb7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 19:25:23.6871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSoJ3iY5D38FKEf9VgQE/6vGAuzP65ZAl5QUPyiReDJRC4RWcUX2nnPlD6mpdd1/Qkea6CX1SY3HHejuxGj9ObAknNT+gPOzmVkf+PN6zGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070146
X-Proofpoint-GUID: M2TmVtnL_f2whmD4aUZ3ysAKG_K_SLfX
X-Proofpoint-ORIG-GUID: M2TmVtnL_f2whmD4aUZ3ysAKG_K_SLfX

On 3/6/25 9:34 PM, 'Jarkko Sakkinen' via trenchboot-devel wrote:
> On Thu, Dec 19, 2024 at 11:42:01AM -0800, Ross Philipson wrote:
>> Introduce the main Secure Launch header file used in the early SL stub
>> and the early setup code.
> 
> Just would need a *short* description of what slaunch.h holds. I guess
> it holds Intel TXT micro-arhitectural data structures? Anything else?

Later it will contain data strutures etc. to support other architectures 
like AMD and Arm64.

> 
> This helps e.g. reviewers to skip some but still keep on track what a
> patch contains (and return back to it when necessary).

Yes we can make it clearer what is in this header file.

Thanks
Ross

> 
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   include/linux/slaunch.h | 547 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 547 insertions(+)
>>   create mode 100644 include/linux/slaunch.h
>>
>> diff --git a/include/linux/slaunch.h b/include/linux/slaunch.h
>> new file mode 100644
>> index 000000000000..0950e14e7179
>> --- /dev/null
>> +++ b/include/linux/slaunch.h
>> @@ -0,0 +1,547 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Main Secure Launch header file.
>> + *
>> + * Copyright (c) 2024 Apertus Solutions, LLC
>> + * Copyright (c) 2024, Oracle and/or its affiliates.
>> + */
>> +
>> +#ifndef _LINUX_SLAUNCH_H
>> +#define _LINUX_SLAUNCH_H
>> +
>> +/*
>> + * Secure Launch Defined State Flags
>> + */
>> +#define SL_FLAG_ACTIVE		0x00000001
>> +#define SL_FLAG_ARCH_TXT	0x00000002
>> +
>> +/*
>> + * Secure Launch CPU Type
>> + */
>> +#define SL_CPU_INTEL	1
>> +
>> +#define __SL32_CS	0x0008
>> +#define __SL32_DS	0x0010
>> +
>> +/*
>> + * Intel Safer Mode Extensions (SMX)
>> + *
>> + * Intel SMX provides a programming interface to establish a Measured Launched
>> + * Environment (MLE). The measurement and protection mechanisms supported by the
>> + * capabilities of an Intel Trusted Execution Technology (TXT) platform. SMX is
>> + * the processor's programming interface in an Intel TXT platform.
>> + *
>> + * See:
>> + *   Intel SDM Volume 2 - 6.1 "Safer Mode Extensions Reference"
>> + *   Intel Trusted Execution Technology - Measured Launch Environment Developer's Guide
>> + */
>> +
>> +/*
>> + * SMX GETSEC Leaf Functions
>> + */
>> +#define SMX_X86_GETSEC_SEXIT	5
>> +#define SMX_X86_GETSEC_SMCTRL	7
>> +#define SMX_X86_GETSEC_WAKEUP	8
>> +
>> +/*
>> + * Intel Trusted Execution Technology MMIO Registers Banks
>> + */
>> +#define TXT_PUB_CONFIG_REGS_BASE	0xfed30000
>> +#define TXT_PRIV_CONFIG_REGS_BASE	0xfed20000
>> +#define TXT_NR_CONFIG_PAGES     ((TXT_PUB_CONFIG_REGS_BASE - \
>> +				  TXT_PRIV_CONFIG_REGS_BASE) >> PAGE_SHIFT)
>> +
>> +/*
>> + * Intel Trusted Execution Technology (TXT) Registers
>> + */
>> +#define TXT_CR_STS			0x0000
>> +#define TXT_CR_ESTS			0x0008
>> +#define TXT_CR_ERRORCODE		0x0030
>> +#define TXT_CR_CMD_RESET		0x0038
>> +#define TXT_CR_CMD_CLOSE_PRIVATE	0x0048
>> +#define TXT_CR_DIDVID			0x0110
>> +#define TXT_CR_VER_EMIF			0x0200
>> +#define TXT_CR_CMD_UNLOCK_MEM_CONFIG	0x0218
>> +#define TXT_CR_SINIT_BASE		0x0270
>> +#define TXT_CR_SINIT_SIZE		0x0278
>> +#define TXT_CR_MLE_JOIN			0x0290
>> +#define TXT_CR_HEAP_BASE		0x0300
>> +#define TXT_CR_HEAP_SIZE		0x0308
>> +#define TXT_CR_SCRATCHPAD		0x0378
>> +#define TXT_CR_CMD_OPEN_LOCALITY1	0x0380
>> +#define TXT_CR_CMD_CLOSE_LOCALITY1	0x0388
>> +#define TXT_CR_CMD_OPEN_LOCALITY2	0x0390
>> +#define TXT_CR_CMD_CLOSE_LOCALITY2	0x0398
>> +#define TXT_CR_CMD_SECRETS		0x08e0
>> +#define TXT_CR_CMD_NO_SECRETS		0x08e8
>> +#define TXT_CR_E2STS			0x08f0
>> +
>> +/* TXT default register value */
>> +#define TXT_REGVALUE_ONE		0x1ULL
>> +
>> +/* TXTCR_STS status bits */
>> +#define TXT_SENTER_DONE_STS		BIT(0)
>> +#define TXT_SEXIT_DONE_STS		BIT(1)
>> +
>> +/*
>> + * SINIT/MLE Capabilities Field Bit Definitions
>> + */
>> +#define TXT_SINIT_MLE_CAP_WAKE_GETSEC	0
>> +#define TXT_SINIT_MLE_CAP_WAKE_MONITOR	1
>> +
>> +/*
>> + * OS/MLE Secure Launch Specific Definitions
>> + */
>> +#define TXT_OS_MLE_STRUCT_VERSION	1
>> +#define TXT_OS_MLE_MAX_VARIABLE_MTRRS	32
>> +
>> +/*
>> + * TXT Heap Table Enumeration
>> + */
>> +#define TXT_BIOS_DATA_TABLE		1
>> +#define TXT_OS_MLE_DATA_TABLE		2
>> +#define TXT_OS_SINIT_DATA_TABLE		3
>> +#define TXT_SINIT_MLE_DATA_TABLE	4
>> +#define TXT_SINIT_TABLE_MAX		TXT_SINIT_MLE_DATA_TABLE
>> +
>> +/*
>> + * Secure Launch Defined Error Codes used in MLE-initiated TXT resets.
>> + *
>> + * TXT Specification
>> + * Appendix I ACM Error Codes
>> + */
>> +#define SL_ERROR_GENERIC		0xc0008001
>> +#define SL_ERROR_TPM_INIT		0xc0008002
>> +#define SL_ERROR_TPM_INVALID_LOG20	0xc0008003
>> +#define SL_ERROR_TPM_LOGGING_FAILED	0xc0008004
>> +#define SL_ERROR_REGION_STRADDLE_4GB	0xc0008005
>> +#define SL_ERROR_TPM_EXTEND		0xc0008006
>> +#define SL_ERROR_MTRR_INV_VCNT		0xc0008007
>> +#define SL_ERROR_MTRR_INV_DEF_TYPE	0xc0008008
>> +#define SL_ERROR_MTRR_INV_BASE		0xc0008009
>> +#define SL_ERROR_MTRR_INV_MASK		0xc000800a
>> +#define SL_ERROR_MSR_INV_MISC_EN	0xc000800b
>> +#define SL_ERROR_INV_AP_INTERRUPT	0xc000800c
>> +#define SL_ERROR_INTEGER_OVERFLOW	0xc000800d
>> +#define SL_ERROR_HEAP_WALK		0xc000800e
>> +#define SL_ERROR_HEAP_MAP		0xc000800f
>> +#define SL_ERROR_REGION_ABOVE_4GB	0xc0008010
>> +#define SL_ERROR_HEAP_INVALID_DMAR	0xc0008011
>> +#define SL_ERROR_HEAP_DMAR_SIZE		0xc0008012
>> +#define SL_ERROR_HEAP_DMAR_MAP		0xc0008013
>> +#define SL_ERROR_HI_PMR_BASE		0xc0008014
>> +#define SL_ERROR_HI_PMR_SIZE		0xc0008015
>> +#define SL_ERROR_LO_PMR_BASE		0xc0008016
>> +#define SL_ERROR_LO_PMR_MLE		0xc0008017
>> +#define SL_ERROR_INITRD_TOO_BIG		0xc0008018
>> +#define SL_ERROR_HEAP_ZERO_OFFSET	0xc0008019
>> +#define SL_ERROR_WAKE_BLOCK_TOO_SMALL	0xc000801a
>> +#define SL_ERROR_MLE_BUFFER_OVERLAP	0xc000801b
>> +#define SL_ERROR_BUFFER_BEYOND_PMR	0xc000801c
>> +#define SL_ERROR_OS_SINIT_BAD_VERSION	0xc000801d
>> +#define SL_ERROR_EVENTLOG_MAP		0xc000801e
>> +#define SL_ERROR_TPM_INVALID_ALGS	0xc000801f
>> +#define SL_ERROR_TPM_EVENT_COUNT	0xc0008020
>> +#define SL_ERROR_TPM_INVALID_EVENT	0xc0008021
>> +#define SL_ERROR_INVALID_SLRT		0xc0008022
>> +#define SL_ERROR_SLRT_MISSING_ENTRY	0xc0008023
>> +#define SL_ERROR_SLRT_MAP		0xc0008024
>> +
>> +/*
>> + * Secure Launch Defined Limits
>> + */
>> +#define TXT_MAX_CPUS		512
>> +#define TXT_BOOT_STACK_SIZE	128
>> +
>> +/*
>> + * Secure Launch event log entry type. The TXT specification defines the
>> + * base event value as 0x400 for DRTM values.
>> + */
>> +#define TXT_EVTYPE_BASE			0x400
>> +#define TXT_EVTYPE_SLAUNCH		(TXT_EVTYPE_BASE + 0x102)
>> +#define TXT_EVTYPE_SLAUNCH_START	(TXT_EVTYPE_BASE + 0x103)
>> +#define TXT_EVTYPE_SLAUNCH_END		(TXT_EVTYPE_BASE + 0x104)
>> +
>> +/*
>> + * MLE scratch area offsets
>> + */
>> +#define SL_SCRATCH_AP_EBX		0
>> +#define SL_SCRATCH_AP_JMP_OFFSET	4
>> +#define SL_SCRATCH_AP_STACKS_OFFSET	8
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <linux/io.h>
>> +#include <linux/tpm.h>
>> +#include <linux/tpm_eventlog.h>
>> +
>> +/*
>> + * Secure Launch AP stack and monitor block
>> + */
>> +struct sl_ap_stack_and_monitor {
>> +	u32 monitor;
>> +	u32 cache_pad[15];
>> +	u32 stack_pad[15];
>> +	u32 apicid;
>> +} __packed;
>> +
>> +/*
>> + * Secure Launch AP wakeup information fetched in SMP boot code.
>> + */
>> +struct sl_ap_wake_info {
>> +	u32 ap_wake_block;
>> +	u32 ap_wake_block_size;
>> +	u32 ap_jmp_offset;
>> +	u32 ap_stacks_offset;
>> +};
>> +
>> +/*
>> + * TXT heap extended data elements.
>> + */
>> +struct txt_heap_ext_data_element {
>> +	u32 type;
>> +	u32 size;
>> +	/* Data */
>> +} __packed;
>> +
>> +#define TXT_HEAP_EXTDATA_TYPE_END			0
>> +
>> +struct txt_heap_end_element {
>> +	u32 type;
>> +	u32 size;
>> +} __packed;
>> +
>> +#define TXT_HEAP_EXTDATA_TYPE_TPM_EVENT_LOG_PTR		5
>> +
>> +struct txt_heap_event_log_element {
>> +	u64 event_log_phys_addr;
>> +} __packed;
>> +
>> +#define TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1	8
>> +
>> +struct txt_heap_event_log_pointer2_1_element {
>> +	u64 phys_addr;
>> +	u32 allocated_event_container_size;
>> +	u32 first_record_offset;
>> +	u32 next_record_offset;
>> +} __packed;
>> +
>> +/*
>> + * Secure Launch defined OS/MLE TXT Heap table
>> + */
>> +struct txt_os_mle_data {
>> +	u32 version;
>> +	u32 reserved;
>> +	u64 slrt;
>> +	u64 txt_info;
>> +	u32 ap_wake_block;
>> +	u32 ap_wake_block_size;
>> +	u8 mle_scratch[64];
>> +} __packed;
>> +
>> +/*
>> + * TXT specification defined BIOS data TXT Heap table
>> + */
>> +struct txt_bios_data {
>> +	u32 version; /* Currently 5 for TPM 1.2 and 6 for TPM 2.0 */
>> +	u32 bios_sinit_size;
>> +	u64 reserved1;
>> +	u64 reserved2;
>> +	u32 num_logical_procs;
>> +	/* Versions >= 5 with updates in version 6 */
>> +	u32 sinit_flags;
>> +	u32 mle_flags;
>> +	/* Versions >= 4 */
>> +	/* Ext Data Elements */
>> +} __packed;
>> +
>> +/*
>> + * TXT specification defined OS/SINIT TXT Heap table
>> + */
>> +struct txt_os_sinit_data {
>> +	u32 version; /* Currently 6 for TPM 1.2 and 7 for TPM 2.0 */
>> +	u32 flags;
>> +	u64 mle_ptab;
>> +	u64 mle_size;
>> +	u64 mle_hdr_base;
>> +	u64 vtd_pmr_lo_base;
>> +	u64 vtd_pmr_lo_size;
>> +	u64 vtd_pmr_hi_base;
>> +	u64 vtd_pmr_hi_size;
>> +	u64 lcp_po_base;
>> +	u64 lcp_po_size;
>> +	u32 capabilities;
>> +	/* Version = 5 */
>> +	u64 efi_rsdt_ptr;
>> +	/* Versions >= 6 */
>> +	/* Ext Data Elements */
>> +} __packed;
>> +
>> +/*
>> + * TXT specification defined SINIT/MLE TXT Heap table
>> + */
>> +struct txt_sinit_mle_data {
>> +	u32 version;             /* Current values are 6 through 9 */
>> +	/* Versions <= 8 */
>> +	u8 bios_acm_id[20];
>> +	u32 edx_senter_flags;
>> +	u64 mseg_valid;
>> +	u8 sinit_hash[20];
>> +	u8 mle_hash[20];
>> +	u8 stm_hash[20];
>> +	u8 lcp_policy_hash[20];
>> +	u32 lcp_policy_control;
>> +	/* Versions >= 7 */
>> +	u32 rlp_wakeup_addr;
>> +	u32 reserved;
>> +	u32 num_of_sinit_mdrs;
>> +	u32 sinit_mdrs_table_offset;
>> +	u32 sinit_vtd_dmar_table_size;
>> +	u32 sinit_vtd_dmar_table_offset;
>> +	/* Versions >= 8 */
>> +	u32 processor_scrtm_status;
>> +	/* Versions >= 9 */
>> +	/* Ext Data Elements */
>> +} __packed;
>> +
>> +/*
>> + * TXT data reporting structure for memory types
>> + */
>> +struct txt_sinit_memory_descriptor_record {
>> +	u64 address;
>> +	u64 length;
>> +	u8 type;
>> +	u8 reserved[7];
>> +} __packed;
>> +
>> +/*
>> + * TXT data structure used by a responsive local processor (RLP) to start
>> + * execution in response to a GETSEC[WAKEUP].
>> + */
>> +struct smx_rlp_mle_join {
>> +	u32 rlp_gdt_limit;
>> +	u32 rlp_gdt_base;
>> +	u32 rlp_seg_sel;     /* cs (ds, es, ss are seg_sel+8) */
>> +	u32 rlp_entry_point; /* phys addr */
>> +} __packed;
>> +
>> +/*
>> + * TPM event log structures defined in both the TXT specification and
>> + * the TCG documentation.
>> + */
>> +#define TPM_EVTLOG_SIGNATURE "TXT Event Container"
>> +
>> +struct tpm_event_log_header {
>> +	char signature[20];
>> +	char reserved[12];
>> +	u8 container_ver_major;
>> +	u8 container_ver_minor;
>> +	u8 pcr_event_ver_major;
>> +	u8 pcr_event_ver_minor;
>> +	u32 container_size;
>> +	u32 pcr_events_offset;
>> +	u32 next_event_offset;
>> +	/* PCREvents[] */
>> +} __packed;
>> +
>> +/*
>> + * Functions to extract data from the Intel TXT Heap Memory. The layout
>> + * of the heap is as follows:
>> + *  +----------------------------+
>> + *  | Size Bios Data table (u64) |
>> + *  +----------------------------+
>> + *  | Bios Data table            |
>> + *  +----------------------------+
>> + *  | Size OS MLE table (u64)    |
>> + *  +----------------------------+
>> + *  | OS MLE table               |
>> + *  +--------------------------- +
>> + *  | Size OS SINIT table (u64)  |
>> + *  +----------------------------+
>> + *  | OS SINIT table             |
>> + *  +----------------------------+
>> + *  | Size SINIT MLE table (u64) |
>> + *  +----------------------------+
>> + *  | SINIT MLE table            |
>> + *  +----------------------------+
>> + *
>> + *  NOTE: the table size fields include the 8 byte size field itself.
>> + */
>> +static inline u64 txt_bios_data_size(void *heap)
>> +{
>> +	return *((u64 *)heap);
>> +}
>> +
>> +static inline void *txt_bios_data_start(void *heap)
>> +{
>> +	return heap + sizeof(u64);
>> +}
>> +
>> +static inline u64 txt_os_mle_data_size(void *heap)
>> +{
>> +	return *((u64 *)(heap + txt_bios_data_size(heap)));
>> +}
>> +
>> +static inline void *txt_os_mle_data_start(void *heap)
>> +{
>> +	return heap + txt_bios_data_size(heap) + sizeof(u64);
>> +}
>> +
>> +static inline u64 txt_os_sinit_data_size(void *heap)
>> +{
>> +	return *((u64 *)(heap + txt_bios_data_size(heap) +
>> +			txt_os_mle_data_size(heap)));
>> +}
>> +
>> +static inline void *txt_os_sinit_data_start(void *heap)
>> +{
>> +	return heap + txt_bios_data_size(heap) +
>> +		txt_os_mle_data_size(heap) + sizeof(u64);
>> +}
>> +
>> +static inline u64 txt_sinit_mle_data_size(void *heap)
>> +{
>> +	return *((u64 *)(heap + txt_bios_data_size(heap) +
>> +			txt_os_mle_data_size(heap) +
>> +			txt_os_sinit_data_size(heap)));
>> +}
>> +
>> +static inline void *txt_sinit_mle_data_start(void *heap)
>> +{
>> +	return heap + txt_bios_data_size(heap) +
>> +		txt_os_mle_data_size(heap) +
>> +		txt_os_sinit_data_size(heap) + sizeof(u64);
>> +}
>> +
>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
>> +
>> +/*
>> + * TPM event logging functions.
>> + */
>> +static inline struct txt_heap_event_log_pointer2_1_element*
>> +tpm2_find_log2_1_element(struct txt_os_sinit_data *os_sinit_data)
>> +{
>> +	struct txt_heap_ext_data_element *ext_elem;
>> +
>> +	/* The extended element array as at the end of this table */
>> +	ext_elem = (struct txt_heap_ext_data_element *)
>> +		((u8 *)os_sinit_data + sizeof(struct txt_os_sinit_data));
>> +
>> +	while (ext_elem->type != TXT_HEAP_EXTDATA_TYPE_END) {
>> +		if (ext_elem->type ==
>> +		    TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1) {
>> +			return (struct txt_heap_event_log_pointer2_1_element *)
>> +				((u8 *)ext_elem +
>> +					sizeof(struct txt_heap_ext_data_element));
>> +		}
>> +		ext_elem =
>> +			(struct txt_heap_ext_data_element *)
>> +			((u8 *)ext_elem + ext_elem->size);
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static inline int tpm_log_event(void *evtlog_base, u32 evtlog_size,
>> +				u32 event_size, void *event)
>> +{
>> +	struct tpm_event_log_header *evtlog =
>> +		(struct tpm_event_log_header *)evtlog_base;
>> +
>> +	if (memcmp(evtlog->signature, TPM_EVTLOG_SIGNATURE,
>> +		   sizeof(TPM_EVTLOG_SIGNATURE)))
>> +		return -EINVAL;
>> +
>> +	if (evtlog->container_size > evtlog_size)
>> +		return -EINVAL;
>> +
>> +	if (evtlog->next_event_offset + event_size > evtlog->container_size)
>> +		return -E2BIG;
>> +
>> +	memcpy(evtlog_base + evtlog->next_event_offset, event, event_size);
>> +	evtlog->next_event_offset += event_size;
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int tpm2_log_event(struct txt_heap_event_log_pointer2_1_element *elem,
>> +				 void *evtlog_base, u32 evtlog_size,
>> +				 u32 event_size, void *event)
>> +{
>> +	struct tcg_pcr_event *header =
>> +		(struct tcg_pcr_event *)evtlog_base;
>> +
>> +	/* Has to be at least big enough for the signature */
>> +	if (header->event_size < sizeof(TCG_SPECID_SIG))
>> +		return -EINVAL;
>> +
>> +	if (memcmp((u8 *)header + sizeof(struct tcg_pcr_event),
>> +		   TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
>> +		return -EINVAL;
>> +
>> +	if (elem->allocated_event_container_size > evtlog_size)
>> +		return -EINVAL;
>> +
>> +	if (elem->next_record_offset + event_size >
>> +	    elem->allocated_event_container_size)
>> +		return -E2BIG;
>> +
>> +	memcpy(evtlog_base + elem->next_record_offset, event, event_size);
>> +	elem->next_record_offset += event_size;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * External functions avalailable in mainline kernel.
>> + */
>> +void slaunch_setup_txt(void);
>> +void slaunch_fixup_jump_vector(void);
>> +u32 slaunch_get_flags(void);
>> +struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
>> +struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar);
>> +void __noreturn slaunch_txt_reset(void __iomem *txt,
>> +					 const char *msg, u64 error);
>> +void slaunch_finalize(int do_sexit);
>> +
>> +static inline bool slaunch_is_txt_launch(void)
>> +{
>> +	u32 mask =  SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;
>> +
>> +	return (slaunch_get_flags() & mask) == mask;
>> +}
>> +
>> +#else
>> +
>> +static inline void slaunch_setup_txt(void)
>> +{
>> +}
>> +
>> +static inline void slaunch_fixup_jump_vector(void)
>> +{
>> +}
>> +
>> +static inline u32 slaunch_get_flags(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)
>> +{
>> +	return dmar;
>> +}
>> +
>> +static inline void slaunch_finalize(int do_sexit)
>> +{
>> +}
>> +
>> +static inline bool slaunch_is_txt_launch(void)
>> +{
>> +	return false;
>> +}
>> +
>> +#endif /* !IS_ENABLED(CONFIG_SECURE_LAUNCH) */
>> +
>> +#endif /* !__ASSEMBLY */
>> +
>> +#endif /* _LINUX_SLAUNCH_H */
>> -- 
>> 2.39.3
>>
> 
> BR, Jarkko
> 


