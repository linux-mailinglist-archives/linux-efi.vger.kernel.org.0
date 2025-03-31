Return-Path: <linux-efi+bounces-3140-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD40CA76CEF
	for <lists+linux-efi@lfdr.de>; Mon, 31 Mar 2025 20:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B10877A33C1
	for <lists+linux-efi@lfdr.de>; Mon, 31 Mar 2025 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE402153FC;
	Mon, 31 Mar 2025 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DedVKYzk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VC9NuhQl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8301E8353;
	Mon, 31 Mar 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445815; cv=fail; b=sAonNQ1NL8A7ma6CQXqjiravqnw9DwKC6wo74Rz3+tvyItEVjJbLFZ53sVinrm5yZwBhB3l2LIQ9yCM0ixvEjtkFRtd3yBY55ceSiAIYKD10Z93ytgt2BYol+iuNd+NeKpmW1t47Z9Vj4+qPfFAoSnJxFGLP4R9fsnRT31+Uzyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445815; c=relaxed/simple;
	bh=7nWec/52Ah1KdW4gRGVz2zdGnN9vLMA9XrSLihTwApY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mfR8+0+0VkFXZqsCvBjVMMhnKCvppTGuHGCaJdolbh19yo4/BQBGUAIKct4qD+eLZH/Yjas3AaIbi58JvyOBcrCZ3/rv4syThkzCdzzVEj+fmDn9NhO4QIJyjGGRu2KeYEopYRvHDlFf9iiPtdcW93ffN3b+QsVI0Nua6L9qfLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DedVKYzk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VC9NuhQl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VIPaYk024783;
	Mon, 31 Mar 2025 18:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DJYnoqlJb+PRh2pC8d+eYwqBkqxYTUT1uc2MrG5KgU4=; b=
	DedVKYzk2q89i7/MPOnq8NDAAoJhd13u1qY+tLAwsYd6tM+onKPau/Jtj1HcSree
	PRkcunrBdXO2gMiWsBf3FDyn7SE2R+hBNhmiwcvJnos+kslUadNlGIkZjVm4Y5mp
	rE3LDog1zMoqueZuibsdSKomLl4bx7RnzcIo4QbRxL8llbnSkTPLM41IyWWvSp9L
	/Gme0wUnOnRG5yTESSOGaEtjoBPJYJgyGEOYRA9NQxk8PWlVjJ6H7gAsBn5Li/YD
	HMmzNHMLm0HNYzwslmaEC/Vy+bnGtWOyulGSPHvf129XhsczsL2LO4sBUyPbj6ud
	gMlkCGAoBxyIgGnCnqAwcw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8wcbwfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 18:29:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52VH4vST010832;
	Mon, 31 Mar 2025 18:29:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7ae8uh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 18:29:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsZhzo8HROByCqD8aJXzW8WM3cwjUzWyxebL0gZJHPB4PJKPsUIEj4+A7d2+u5zlYv5XlL4nPRcjkSQR0Q6gYenMXFRCkENgRCnTgv0GgXYJjCLfsO+hyLsanL2mFs57ng2Py9CeYQWy4PXDg2qUfqyPx6pnUEeKS+jVYMEPeiqNoK2EBoFTciGkGGaEQfEjpEH2ucYJyoWprTTOrdzEKw1yIns2QLO9t7vgrhqUQoGah3tu7NwMx5gyl/n06x6dwgfH2BEttFac3BeP005pw743IGNcbT+hXKyOPb3ztOf2qK2gx0a5mcVyM87M7CBRLiVZbB0E4gC0IEukCNBW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJYnoqlJb+PRh2pC8d+eYwqBkqxYTUT1uc2MrG5KgU4=;
 b=QdcOZLB3n63LCA4IHn5jJbMeBA9HOBwKDhrJnzmVukgEW170ydY0TE1BueoXsVj8DlESO/nd2ylrYKdyRG8KJ5DO0YZGL6i5GZyf9FiW7xlzYm9yN1YlB3+AvwCByJiblyPLKasPJVCIfg9fO7q3EgeBEo2f59+pOFeDeY7HVluxN9YAx3AWKFHRbGikazQfOImqOOluiqXLWvHJ5nR0BZJ5noV2VvCc8RXVIzd2H7wlyRRHpMYVpZZ8G02W6tT+c3wS4QQmke4FuyxI6EApewXD96nfYj9xRA30bppMrvQlv+biOrQT7HHfGuTjXIouH3ZhbVv9b7JFT0I6cZhtYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJYnoqlJb+PRh2pC8d+eYwqBkqxYTUT1uc2MrG5KgU4=;
 b=VC9NuhQlPReTWQKgEOwFPph5bPvya4W+iUkpGLf04OrlAWlUIAZGtTEA3cxhqYupyin/Il8ZyOE6nfZG1cek/pwYkexF+NzFiqb7p61xBy8w8HL9Xa3Gv6VM0D7AfVNZhT1x4OuAulfQfz5sK2yy2REqovCi3XT3QwTundYTx8M=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CY8PR10MB6444.namprd10.prod.outlook.com (2603:10b6:930:60::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.31; Mon, 31 Mar 2025 18:29:15 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 18:29:15 +0000
Message-ID: <886145d3-a9f2-41f3-a754-253decdb1b4f@oracle.com>
Date: Mon, 31 Mar 2025 11:29:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 19/19] x86/efi: EFI stub DRTM launch support for
 Secure Launch
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, ardb@kernel.org,
        mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20250328230814.2210230-1-ross.philipson@oracle.com>
 <20250328230814.2210230-20-ross.philipson@oracle.com>
 <B41D3199-8054-4B2C-94D6-508D1DE4C8B3@zytor.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <B41D3199-8054-4B2C-94D6-508D1DE4C8B3@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:408:e7::18) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CY8PR10MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 64a57db0-6256-491d-2a5d-08dd7081f0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWpmbzJlZVhlcHVva0w4OG9aNEJuTzBjVTEyM01nZzhRQ2hrNzg2czdiUUpS?=
 =?utf-8?B?OU5OeDNRMnM0U0w5ckc5L0pocWZQeDl6aVZoU1VoMUEvYlc3TjFXeWJFWndB?=
 =?utf-8?B?d0plYWpiRmUzaHJGSlROcmYzT1FnRzY4bnVXdDRmZFFleXZVYWQ2SFZzdWlG?=
 =?utf-8?B?Q2MwVWlsSG9yU3NKOEhtdmpTRHd5U3hsK014ejdSMTdtUVNRQW9DQmRwSEJF?=
 =?utf-8?B?NlgyWUR4Wk1rRkNrM2ZFRGd2a3NlVEQzMWdyem5iQ2tuYy9tVjZiRi9IVmZp?=
 =?utf-8?B?L05KblZFVXlySFZNKzVrYXd5Vm9yb3dROHQwcE1rQTVDU29YVStHREFpTmZC?=
 =?utf-8?B?YmlnRWZiOWZiRmV4K1EvQ1R3TXVGTk1PNUlJczVrRmFEZk5BNDBwUldNcUds?=
 =?utf-8?B?cUNJRjE4eGU2TGtjbmd1U3E2UzZleHVTK1VIWXd0MW85bEJyeWRWL1MxU0dv?=
 =?utf-8?B?aElyRTRFb1JkdHhmbW1qd0dwbEdnK05WbGRjYjV3T1MrMmFqYmhBajIxeEhR?=
 =?utf-8?B?K1czbWlneXlNUnJXSkhxVm1QZEZJWGVzSTdWYzNVU3IwTVYzTWJib0VzQlVv?=
 =?utf-8?B?eTBZRHQyajVEb0EyeWlXMjR1UUxXSW03ZFAwQVBBZ1NBL0ZYSjB2Rk9hcjZC?=
 =?utf-8?B?cE9XdG9GdFJpSFVxWUNTY0NiUUZuNUJwaDlaY1pkeU41QzhmcVVUTHlHUVBC?=
 =?utf-8?B?SDVxemVJMFNtUjd2RlNrNmR4aEtNaTYveUxhRVJyUG9jWGdDN1JtaWE4dTZF?=
 =?utf-8?B?eHMvS25ZdEtBbFBwYmwzUDBVZHFGVmw3c2kyOUUrWnVtcGtCNVBTWmUxZVVn?=
 =?utf-8?B?ZTdWMGROZmp6TEpiZWpjMEx3SUs2Uy8zVThGWFZJSHlWUWhkQTBLU1JCcHgz?=
 =?utf-8?B?cW8wTk9vKy9lQ1RCRGlVb2RLcWpETlBZL0o1dmpkdmlYa0hJamNIRUd1WjE5?=
 =?utf-8?B?SWluVTRQTHA4SDIxZ09IamhNRmw4ZHZ5NUttLzhZdUk2YktmWkVtWUxabndL?=
 =?utf-8?B?ekNaZms3K0V2WHNCQnl1UEh5L05adHRCVUQxOTNMa1piWGhvdHhIUytHUXNk?=
 =?utf-8?B?R2lEb2dXUkhXRVJSamxSOUZiTHkwWG8vd2ZKSFEzTTc1d25ubGRpV0wvOHNw?=
 =?utf-8?B?RzdvdXhWdjZqUHZrN1ZTM0YvVEdTY3FnQjZlejZ6YzNnb2J4YnQ0eXgrbEpQ?=
 =?utf-8?B?UVVJSlhvZnhhQmxXNEduWm1zS2NuSzBIWFJiTi9GUzRHV2hydVNyZk9CU1l2?=
 =?utf-8?B?MlBtUW1IKzhhM2xsRzA3cWFDaExORVdhUm1pQlF0U2VCQUdCOGdlTWowdzNQ?=
 =?utf-8?B?M2xLYStRdFdlMGtDVFhKU3hBQ1ZacjNlQ1laeVZxM2JudnNZWk9EZU55bC9N?=
 =?utf-8?B?cDN6eVlHZmR6SVhkM1FqYnlWdVR2U3psZ2FGakNLcGFISGRpdW5jUkcraUtu?=
 =?utf-8?B?L2FWbXZDMHdKNDNPQmVBL1VCSS9YeGN2eWZBeUZBVzBhWlRXRTBTU3VvclZi?=
 =?utf-8?B?dUtxNGRVNVVFQUN0WUtiYnN6QTQwR3N5N2owaXhmK1gwc2pFMW9EbU5BbkRD?=
 =?utf-8?B?MXAvTHhqZ25TYzRFSXRKY2t3U0dQQWREcWVvVlI1SlZEK04reFg0LzRSZXZq?=
 =?utf-8?B?ZWlKbjZjUjVKVDBFV2tnSmhUZ212WDNjTWFoRXFaSVEvRE43TFV6NklMam5D?=
 =?utf-8?B?TkZpNlN0YkNLVzJQMEgyRXpPaFl5bkJaVTlmbFVoS1RhWUpOdnRRMmNHK2xP?=
 =?utf-8?B?R094TmpEWkpvQzd4Ukh4Sjk0RDBRU1BpSlBGck1HYkh2cGJjUEd0eTNabjBk?=
 =?utf-8?B?SkF5Sjdob28vMy84b3Z0a3hVZEF1K002bHVnTDRxcDRaM21LblBCVjQralor?=
 =?utf-8?Q?x1jqUTOElF2aF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU5xMUJqd3NxUklBdnRoZWNteE0zQXVwV1RqS3hBZE5YNC9sVStmV202UkU1?=
 =?utf-8?B?ODYxS05UYUl0OHovSm56VXpIZ3ZTY0RhWVpOMEwxc2c0RmtYREYxNGlWK0Ew?=
 =?utf-8?B?OVlaT3NEVEg4VmxhQ1JoN05kTGp1dzN3SHM5MW1HeW0xZDZwNXhqODhsTVF2?=
 =?utf-8?B?aFgzS2M3VkV5eFZLelltQXJVYUNxNk5XR083SnBhUGs0U3k1ZGdET1dKdEVR?=
 =?utf-8?B?c3VDcDZnVGVzWFRDalBGQmhxZUVlc2paN0h4UmlUMWkxazdRSUtNVjBmVUNx?=
 =?utf-8?B?ZVBuQmszTm9hOEZhVHBvVlltS3ZjaWxWZHNMMUdYVVNoU01WRDAyR1krM21q?=
 =?utf-8?B?RTA3S0FYSVhrNVRkT3VQQThyNTNGYldYckd1c3RCMU1CVk5Wd1pReHlXejJF?=
 =?utf-8?B?UHAzMWJCOUp3dGZmbmhVdXVMSEhmaFFwRCtZcFNPTXlvcDVjTEtjQWo1c2VU?=
 =?utf-8?B?eUNZd1lpSkNjdnB6RkFYVndDZzNJRk1vdkZ6eUs1bi9zV0FYS3VyZndiUGVi?=
 =?utf-8?B?YjNZMnFJeGw1TkZhdDJpaEVGdStzRGsvNWtjSmlqcXY3VldwUXgxc2RISC9N?=
 =?utf-8?B?VkxsNXdGeDVZRjVXL0k4N2x0Tjc2blBvOXh0OXp6MFZwQ3h2eEZ5UXJVV0ZI?=
 =?utf-8?B?a0tFcDJDWDNCQkNDTkRMQkFwZnZVWHFPRmV0N0VyMUE1d3NZM2JFRFdWTjVh?=
 =?utf-8?B?aVNKMlpzUk83MzlpaGRWMEVrRG9zSDEveXdnanpwWFRpek9IZkQ3MER4T0FS?=
 =?utf-8?B?eGZZcHRhckQ1VWlHWlpaT2w3TFhROEdjeFN6V3lYUVd5cW0vS2cyQUVDMzZR?=
 =?utf-8?B?eWhCUHhiNFBWcU93Yklva1gyRUN4ZUlTMXZhazM0RzkwVWFic1lkMzFmbzBZ?=
 =?utf-8?B?ZkttNE1raUJKaDBZTGdZRHQ3eTJoV011cXpPL2tWa3BPQ2NyVjZTaGRId1pD?=
 =?utf-8?B?amtGa3hXNnRUbURCR1ZtWWxwQnJWODhEbGxJb3ZlSUhtUU9Dd2RmVkx2STB5?=
 =?utf-8?B?dVY3Rzg4S21wVGExdlRaSGpWcjBqVEpadTB4UWJVdzFTVjhRTHFqT2RvVFBL?=
 =?utf-8?B?NzVKakxWZktESTQyb3JSSTNVM08zdllkN1JsWkFVUzBFczljb1hDRjQ1MGlS?=
 =?utf-8?B?VzgxaG0vRmt2UFdQaEhGSWc0WE9yeUJaRkdVSXZTVVpLcTZ5TTUzYWdwOU44?=
 =?utf-8?B?dmtadytSSE9GODNxYWxhaHdYdW9wRE51NXFHZ3ZuWGZtc0h1RWpDQVZKbE4w?=
 =?utf-8?B?T0pwblR4QzRUdlkvSWV0UEtaTHM2UHFQK0xtU05jazJKK01KcWhJa1I2aHow?=
 =?utf-8?B?L3pBSXdLVEVia0d5UTNPcG16R1dXSGxlRVBUWFA0bC83ZmNWdmE0NE85R0NW?=
 =?utf-8?B?VDJGVlpJRngraEw2TVNjVmJsaUIrTy8xOHUvYm82Y1M2d0F1bWpFbWkwaWU4?=
 =?utf-8?B?TkpVWXh6Tm1xQ0xjbnkxeWt0c2dxZmtQSy9WQ2dReTNlN2ZoUW9md0xsM1Ix?=
 =?utf-8?B?dFg2NUFESUJ0czBwL1RYME40MkxKcERCdWdxRVFPVlRkRFZqckVtUEJhelAx?=
 =?utf-8?B?eTg4d1JLRjRiOUROTjJVSnVSbmgvSEdSTno3ekdqbHE0a25lM04xMVRQT1hD?=
 =?utf-8?B?dEpTNFNGMkRvRGc1cEtrYWtwTkNBckt0Sk0vTEowMGtxa0lHZURhTjkyWFpu?=
 =?utf-8?B?dzFzVGdGQkRqQS9kdFI4SlRlVmtPKzZ0RHNWYTUxVE0xTXFuTW9nMjJKYXl0?=
 =?utf-8?B?azVwZU9vNUp1QSthUmZCWDBwUlFTa3k2Qk1HM0xycmkrRDVKMzRHZTJ5WXpk?=
 =?utf-8?B?dWJvem9rbWw0YjF0WGJSYTF0SUMzaVFRTnJHelltVTc1RldxeS9TSFk1eC9P?=
 =?utf-8?B?YzcxN3diZjhMUUtqQ1FtbzR5blNCRVFFcjlEd0dKL2ZNc2s1QVdlMTJ1VGQ4?=
 =?utf-8?B?T1pCVkpTdXRaMmw5U2hCSmpoUGxRSW1TMFlEUTFsK0k2ME1SekRiRlJ6c3ZK?=
 =?utf-8?B?NFBpOUpUcm5IZkZVc3dOeFZHVTRMWHd2SzdrOGNPcUZVNUNRWElFWFkxUXdX?=
 =?utf-8?B?czZ4MWorSVFKYlR3Nk9XQTR3K3NyamthblJiSm5FVUVMSk5Bc2NZNFlOU1E4?=
 =?utf-8?B?SW5uUlBseHZVZjFFa1RFQXQ1d0h0S1RXcmkrd3dyUy9jbFFLZ1dqSUF3eGdS?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9n8hyU/2CgQnZEwWKQSKu1p/qrYwMVUF0lADnnottdZUW1b7N2OaSuD2FM5MYBrqZWYs2y/w0KrTH6yl2covsS+1NNHBmDwQVRLOSZjxnd/up2wEWST1WVLzkw2NO8ThMOZHRm+ozyslzHdR6ZeN0ga4wujxmFKMlOakNQ2jKq2w+JfHnDrU49PAQufVMyoRa0fa6qmcC7S5TCB6bmUN5nXF14KXo8VPOYJlvIQSbKxgPFc/7snoUsZwFfwx4kAcORk5whluq5W57eOnY0ocxWEA+dgcx7odtZeEzWJ1MQoA7WfNteW24unpxtOtnuXuEWsJ3YddCz17fMc8QnlzMcAMOpXZ0VCBaQpLbnINuSXG+CY2ZxV3+AQKqqU/ONfKUGHHYfysVEvmyN0dZTgQ5KRpelYuxhrQdmkmdsW7WDDWdufbfg4emAw0QRSvcIHdPLy7dnAPaEPKVepCZptJCrwcegYBE8b176vI+e65mT6Cg/P9WjWPAgswuv9JWZ/ajtecM2JmoDBowZH2WiD63GsW+L8IrauoDmf7LbcmyYq5lm91wPkxyiPJu7aJBVqpOSA36ziYXQmb1+c1rnkCWXcIO78WDTrVcR7ZLqp2r48=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a57db0-6256-491d-2a5d-08dd7081f0bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 18:29:15.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yn9+le2PKehOWyruvV9ICC0yMEcYgPqGbvv3mu6bbZ6TP7tQDLKlM+Z2c7X7OWF0BWsCPlVZjIeUXVlZcaZS6xz+OTvDVAUUOaH5XGEZ+iI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_08,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503310130
X-Proofpoint-GUID: yGpyYJ3ONZJ-WkXWOY8dMaPiWqoUlJy3
X-Proofpoint-ORIG-GUID: yGpyYJ3ONZJ-WkXWOY8dMaPiWqoUlJy3

On 3/29/25 6:13 PM, H. Peter Anvin wrote:
> On March 28, 2025 4:08:14 PM PDT, Ross Philipson <ross.philipson@oracle.com> wrote:
>> This support allows the DRTM launch to be initiated after an EFI stub
>> launch of the Linux kernel is done. This is accomplished by providing
>> a handler to jump to when a Secure Launch is in progress. This has to be
>> called after the EFI stub does Exit Boot Services.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>> drivers/firmware/efi/libstub/efistub.h  |  8 +++
>> drivers/firmware/efi/libstub/x86-stub.c | 94 +++++++++++++++++++++++++
>> 2 files changed, 102 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
>> index d96d4494070d..bbbc4b327ce1 100644
>> --- a/drivers/firmware/efi/libstub/efistub.h
>> +++ b/drivers/firmware/efi/libstub/efistub.h
>> @@ -135,6 +135,14 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
>> 	*hi = upper_32_bits(data);
>> }
>>
>> +static inline
>> +void efi_set_u64_form(u32 lo, u32 hi, u64 *data)
>> +{
>> +	u64 upper = hi;
>> +
>> +	*data = lo | upper << 32;
>> +}
>> +
>> /*
>>   * Allocation types for calls to boottime->allocate_pages.
>>   */
>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
>> index 863910e9eefc..033133e7d953 100644
>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>> @@ -9,6 +9,8 @@
>> #include <linux/efi.h>
>> #include <linux/pci.h>
>> #include <linux/stddef.h>
>> +#include <linux/slr_table.h>
>> +#include <linux/slaunch.h>
>>
>> #include <asm/efi.h>
>> #include <asm/e820/types.h>
>> @@ -798,6 +800,93 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
>> 	return efi_adjust_memory_range_protection(addr, kernel_text_size);
>> }
>>
>> +#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
>> +static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
>> +						 struct boot_params *boot_params)
>> +{
>> +	struct slr_entry_intel_info *txt_info;
>> +	struct slr_entry_policy *policy;
>> +	bool updated = false;
>> +	int i;
>> +
>> +	txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
>> +	if (!txt_info)
>> +		return false;
>> +
>> +	txt_info->boot_params_addr = (u64)boot_params;
>> +
>> +	policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
>> +	if (!policy)
>> +		return false;
>> +
>> +	for (i = 0; i < policy->nr_entries; i++) {
>> +		if (policy->policy_entries[i].entity_type == SLR_ET_BOOT_PARAMS) {
>> +			policy->policy_entries[i].entity = (u64)boot_params;
>> +			updated = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * If this is a PE entry into EFI stub the mocked up boot params will
>> +	 * be missing some of the setup header data needed for the second stage
>> +	 * of the Secure Launch boot.
>> +	 */
>> +	if (image) {
>> +		struct setup_header *hdr = (struct setup_header *)((u8 *)image->image_base +
>> +					    offsetof(struct boot_params, hdr));
>> +		u64 cmdline_ptr;
>> +
>> +		boot_params->hdr.setup_sects = hdr->setup_sects;
>> +		boot_params->hdr.syssize = hdr->syssize;
>> +		boot_params->hdr.version = hdr->version;
>> +		boot_params->hdr.loadflags = hdr->loadflags;
>> +		boot_params->hdr.kernel_alignment = hdr->kernel_alignment;
>> +		boot_params->hdr.min_alignment = hdr->min_alignment;
>> +		boot_params->hdr.xloadflags = hdr->xloadflags;
>> +		boot_params->hdr.init_size = hdr->init_size;
>> +		boot_params->hdr.kernel_info_offset = hdr->kernel_info_offset;
>> +		efi_set_u64_form(boot_params->hdr.cmd_line_ptr, boot_params->ext_cmd_line_ptr,
>> +				 &cmdline_ptr);
>> +		boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
>> +	}
>> +
>> +	return updated;
>> +}
>> +
>> +static void efi_secure_launch(struct boot_params *boot_params)
>> +{
>> +	struct slr_entry_dl_info *dlinfo;
>> +	efi_guid_t guid = SLR_TABLE_GUID;
>> +	dl_handler_func handler_callback;
>> +	struct slr_table *slrt;
>> +
>> +	/*
>> +	 * The presence of this table indicated a Secure Launch
>> +	 * is being requested.
>> +	 */
>> +	slrt = (struct slr_table *)get_efi_config_table(guid);
>> +	if (!slrt || slrt->magic != SLR_TABLE_MAGIC)
>> +		return;
>> +
>> +	/*
>> +	 * Since the EFI stub library creates its own boot_params on entry, the
>> +	 * SLRT and TXT heap have to be updated with this version.
>> +	 */
>> +	if (!efi_secure_launch_update_boot_params(slrt, boot_params))
>> +		return;
>> +
>> +	/* Jump through DL stub to initiate Secure Launch */
>> +	dlinfo = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
>> +
>> +	handler_callback = (dl_handler_func)dlinfo->dl_handler;
>> +
>> +	handler_callback(&dlinfo->bl_context);
>> +
>> +	unreachable();
>> +}
>> +#endif
>> +
>> static void __noreturn enter_kernel(unsigned long kernel_addr,
>> 				    struct boot_params *boot_params)
>> {
>> @@ -925,6 +1014,11 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>> 		goto fail;
>> 	}
>>
>> +#if (IS_ENABLED(CONFIG_SECURE_LAUNCH))
>> +	/* If a Secure Launch is in progress, this never returns */
>> +	efi_secure_launch(boot_params);
>> +#endif
>> +
>> 	/*
>> 	 * Call the SEV init code while still running with the firmware's
>> 	 * GDT/IDT, so #VC exceptions will be handled by EFI.
> 
> efi_set_u64_form()?
> 
> What the heck is that? If it actually involves two u32 packed into a 64 field, why not simply do two stores?
> 

Well the story is this. The EFI maintainers asked me to use the 
efi_set_u64_split() type functions (this one splits a u64 into 2 u32). I 
went to look and there was no function that did the opposite action so I 
added it. The original function was called efi_set_u64_split() so 
efi_set_u64_form() was what I came up with. I can name it anything that 
is desired.

Thanks
Ross


