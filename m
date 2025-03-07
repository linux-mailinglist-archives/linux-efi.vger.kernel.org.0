Return-Path: <linux-efi+bounces-2927-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B476A571C8
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 20:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D461898A9C
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EEF2561DA;
	Fri,  7 Mar 2025 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GlZNYQl+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sAjSzOFk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011E2561BC;
	Fri,  7 Mar 2025 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375815; cv=fail; b=qMxl2GEMVXlU9oHfLMBNa9eFpYrsvYUtIBBTCKSjUWlYRHqccfrQEdZWEDB2Q8oLRGewgmlfQUnRmGsfoZonh5HHEJ7I4uSB+HfLwfWV97Bd8D9THaBWDiWqXRgey2WkY4ilpS3SC6U88DPK0CttXXfJY1UXqAyql9f00HR7qVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375815; c=relaxed/simple;
	bh=HGgzvf8uBIPe+gRod3Ep3QkiR045CNmolTk+M2SGEn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QrDz7/PDfcSVCMV+0U+7pLedNJzFFY9yjqRQqV7RGEmG8QGT1eZjn9TKD8Un9azpmVayiPf1H1Az952Tnm6cvByXl9V6fYKqWLkk7vaj0O8TSaHig+nScN/zHh6PYsDnTSjvnrynjDtut02os/dbJo2D0uAYPL9nD4ywdl4Lcas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GlZNYQl+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sAjSzOFk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527Itehc022209;
	Fri, 7 Mar 2025 19:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=N1IbY+hrEN6y5pCCKZexEF3YsC445jjFacTpW3jDs1w=; b=
	GlZNYQl+9mqx4Tkf4QHnaaxXgyMfOH8sqTJYneXigbZcbBHDmhVy/xKSNgE+sPbH
	C60gU3hs2N8p7/e/iYesVc434kcGVyMBMig06jGxBwLJTYhZ1PxqCNTiUdT4/BSp
	tnwO2ZKO2Ve9xEtZP0ikvLCGafIa5w1aeMJSsfYS77cR54vAj4/QLUoj9IRgmCdl
	0Auyp9vT1BAlKOzL6qFpJAPKR3kKvvwBB8Jwb/3MjZqMhCfVYsm5yS3u4suRQStc
	sXQiCULXbsctSR73PH0Kqp4UaeuHvndy4Db9TJD+Nd0UprmjMvCABhfnxcBnmjQQ
	2zBjjfXiFOSm+vDUFR2XZQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86vtw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:29:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527JBjH4003162;
	Fri, 7 Mar 2025 19:29:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpdx5ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:29:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cubLZAq4tT9hPJbbbgPaS1y+DVyJWvrE4K7QoF5MiJgoLDWPcFVW11m2XCIQwhK0ZzXhU6wAPzjWAdoUvBJb18/3/mY5HY5eCMl57xNepwJmGStjidL0JPPv5IDkLD3waT52O3lA33dlQ6h7ix/A2KzOLB+7T3bFt8Utj4g4KeCBEWWEO0/i1KBfX115s3ii7+7Qvdi+cX/Bpx/8NMtZqHa3hswfRUoU/+EkOB6jFP98C9Cnh2Ur5zTG9wugN2e0ONQocty6rEFc4zLR3fUpB2M9RjMeI/xkOdaUDnu5MQ+DMGCdRJZlF/ThFmWCWMpJZKCnDjx376qgVGJShJNfcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1IbY+hrEN6y5pCCKZexEF3YsC445jjFacTpW3jDs1w=;
 b=NrhR4Xh0Rh5xUhM6XKCqA98bl3q5rdyipEx45T+RhzwfCvIgUsNs7+k74tLzwIk37bnESkMCCulHyzWyt2CF2OjpQbk2hwDCD2TspMj4tmfsS2Vh+mAx8wYjGzGpobWGauRNX/VQigRMfid67Ro5wbU9Z4scNomWiqd3EFGnEURYcTvaQsS3Bh1i3pepFtaicNt49Ir/vXq34AdpkWMArNQEdSSqmwPj5cvhPA0y5YW4ToPBDGcZid/YqqwLvCdcEoIE0PmtcBikFEvqZMgHOFZ57xBnhfmbkLdbU9MKPwlP4iXxMQkU8LByb7uTVQUnmQFdH4gl0qsii3AMYR7KDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1IbY+hrEN6y5pCCKZexEF3YsC445jjFacTpW3jDs1w=;
 b=sAjSzOFkJwb3D251Y7NRBbZhoSoYXoxs08Vp972uEP1LycN6SelkUMgnLuQqrgdNDaE01F+FY/8i7CAipSLkeWTXbTXTkZMzNIJ7VO+pB4aP2PACsHvbShLZDX7Y8/yycWnGOd174IhmsTgzgpnwjorfvl/RYG1KOI6Uqdd3vvY=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DM4PR10MB6160.namprd10.prod.outlook.com (2603:10b6:8:bc::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Fri, 7 Mar 2025 19:29:30 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 19:29:30 +0000
Message-ID: <4ac5aa09-81c2-4f12-87a7-5ac7799a8d98@oracle.com>
Date: Fri, 7 Mar 2025 11:29:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/19] x86/msr: Add variable MTRR base/mask and x2apic
 ID registers
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
 <20241219194216.152839-8-ross.philipson@oracle.com>
 <Z8qKStnfCBvSw_yI@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <Z8qKStnfCBvSw_yI@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DM4PR10MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ebb774-759b-44a9-ac94-08dd5dae61d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWZ4NUVEWHFmaGpzamZod1gyUmpnYm9sN1lFOHB4RVk5RE9VMUdWRWYxam5Y?=
 =?utf-8?B?OGk1anpRQmdxV0psSTFoa1BlZzF3MjRUa2txNllZUFVEbGR5eXVEQ0ROdG5u?=
 =?utf-8?B?Y2cwVzJZUk8xSE5sclR3cENyYUtYbndSL2ZaSC9DTUlCb2Zza0pBVVZUai9R?=
 =?utf-8?B?SkpmeTUzSTh4cUlSbVdMWkRlQXVQc2dLZ0YvS2M0S2pYYXluV3ZEbGxlYnQw?=
 =?utf-8?B?UklCUVpmK0JzMkJkZzlSTkZRMzk1QTF4OUV5STQrTERKdDhNQmtPQTN2S3Vn?=
 =?utf-8?B?NnhmUHQwYjVmQlNSWE1pem1QZHNUZ2RBWWhzc1RMYUlFelhLWk5UQXpWQzk2?=
 =?utf-8?B?a1VNazMvMS95Vnp6b1NqRS9uQ2NUWlB0ZnJYaElvYWpxYzVQWFY4NUpTT3pK?=
 =?utf-8?B?WHpxV0JjZ3F5Y3VEay9VeUpwU0Z6cHlZVzhpM0s1djZUOTZLZER0WGlJMTE5?=
 =?utf-8?B?ZkZuNytISmh1QXJTV3ZmL1VlWlVHWVdyQ0l3NWhnSkhoaDhvS1podlFOT2Ny?=
 =?utf-8?B?ZWluNkgwRldUQXlmS2lxUzNhSUQyMDNXbXRlK243U1FTU1dmbGJ5Mk9HNU5t?=
 =?utf-8?B?aW1nODNvcWszUkxEY09DSzRQZ251ZjBNWVBmK0NtUFJMY0JwSk9mNWVwQVJ4?=
 =?utf-8?B?eDFSTzVMMTRpMzJTNit5OUZhYzl1TDh4SjdvaFNNcS9ZbU9UcGdod054N25l?=
 =?utf-8?B?VytBMi9WbmUwdGJpL3cyZ1RDQ2kzSmsvQ2w2WlVnVlZ2bGE3VndnQlNhTFpP?=
 =?utf-8?B?eXI2ZHB3K085UzdYYkFuRW53enpINWkxZ3IwVTJBS01oc0RzekVkelVrcjYr?=
 =?utf-8?B?VmN0VVdlTk1TSklLRmh1V0Y5Qld3blBEajBseEZIeWluUG8xZ0Fzc3F5RjBO?=
 =?utf-8?B?N3BlN3V5TDcvZmFyT2dicmZRTTJTdUx2L05RYUwrK1RjcytrSUs2djZ6cmpy?=
 =?utf-8?B?aG9qUnE1VU9ZODdES2J6S1BPQUhiWVk3NmJnUDFRbHEvUHF5dEdZdmRFUm9L?=
 =?utf-8?B?Rjd0dlFzeTVQNk5DZjEzb2YyTk1pb0FqR1ZLWmNIQWRnQ3hYM05QS3I2Mk5Y?=
 =?utf-8?B?L2gvVVpZVVRyQjRaNk44S3ZSTlBneDN5MEFBR1lPMG0wbHA0TzJPbkkyTWd0?=
 =?utf-8?B?bWRMeDdlQ3IyNXQvU2tBYmVad0tMTnQyS0dqSjJoaGxTUXpxeFFrVVhzQWsv?=
 =?utf-8?B?ZlFsMlUxWUJSa2wzdmRLR2Rwc2gxenFyYitNRGhadmdaNHl6WHZyVWVQWmVa?=
 =?utf-8?B?dnhmaVQ1eGZhcmt5eWhOT0ZDZWhXUlJtN2dEZXNzajlyTTdaQWtDWDdVTzll?=
 =?utf-8?B?cFZiWVVGd2ZwTUEwOHplRjBKWDBJY2JnTnZlSmZUREtaelU1c2hEOFpTSnNW?=
 =?utf-8?B?OUpaVVdIaFp3b3hDTVR2SEVFYlNPTmY5eXVRK0pHNWxoK1M4cThCVnk2di93?=
 =?utf-8?B?aEhTdE5LK24raldJTzJKZ0h6U01TYk4wVWhuODgzamlrcHFuZXNxQjUxWHJG?=
 =?utf-8?B?bnV3WGtrZDFZMVBxQkFPZHBJQnYvN2ZzZ01RRUw2ZWllbUJYeUVDT1NBOUlV?=
 =?utf-8?B?enJmUlNDcVlDTm16ZWFWOWYxajg0cG9uUlh6Y2hGc2JOd29UengxVzJiN1FO?=
 =?utf-8?B?WmxTNGg5M2NsZnJLaVNOMjRtaTRZbHVaVEFreFpHcjl1aVA3SVRNdHpIQkNZ?=
 =?utf-8?B?b0wyK0FEOTJ0Q0p5Vm8rTFRXYTZQalY1dkVTaVlrRyt6V0g5bm5qRjlqdXJn?=
 =?utf-8?B?aWlIMzlzejloZzZsaE1lWEIxcVoxRUw3ZEw3NXFjZWpnYTdkNklITmtuaXpu?=
 =?utf-8?B?Z3VmWDduQTV0SDVIWVU3ZnlpRHVpU1FlYnhSS2FZd3o4NzhFd0I3TzY1RXF3?=
 =?utf-8?Q?I4Axx4O9ALNtd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTB6NEpRcVFUcTVybW45ck9vcjA2KzVreXBkNG14ektiQU51YWdueEVwYnZX?=
 =?utf-8?B?aVI1WEtJQ05JSmxRRGIzbWFZU052bEJEOFdkRWk5Sjk1ZE5scThCdDlhcHlx?=
 =?utf-8?B?c29IdTNXTDM0Z2MrQ3c5Zk9lQTJBVWxRT1R5bGJnbjZsUzNjUVhubDZWbG8z?=
 =?utf-8?B?bk53WGRDSEVRTlpoa09ML1QvaTRkcjhYWTF6Y2RGZ0pjM1dYOG1tWU93OEpM?=
 =?utf-8?B?NTdIMUVRNWlNanB3TTF0bExwcUxyYXpId1ZBV1liZ1FzSk9ETU4xbGJ4V1VH?=
 =?utf-8?B?TzBoMENlWTFCczAzSWpGY25hY1E0YVNXK0I1bGRJd0xnSTF6K29qOWkyNE8y?=
 =?utf-8?B?VnMyS0dPbGxNMTV5M01WOWswMGplWHJoM2ZXNE90SUFKbGo4SE5uUVVOdGFB?=
 =?utf-8?B?UjRDdTRiZlI2VUU1aHJZcnBTanp1Vm9sMHZyWUpEYkVLMmpuZGYwUjREWUY2?=
 =?utf-8?B?eWdGb1I1d2xQbkhVV2t4eE9JRDVieVROalErelkyZjl1RG40eGM1N0tacWJF?=
 =?utf-8?B?VHh2Uno0cVhmWXkwUmoyaXhOSHJzOHhGWUR6WjVvdnNieW1tbGFIbmVMR1hT?=
 =?utf-8?B?Y2hPQ3BKQ1o2VUhoQ1NJTW11OUo4UythbjYra0dMTVpUUTArOFdQdFFuWVp5?=
 =?utf-8?B?dWRwUkJPUXBVeGg1MnRVQjJ0QktQbUJycXlzdG9RN0U4WEtXMC9MclNkRWJO?=
 =?utf-8?B?cjZHVStlYVpaSE9VZzYyaTR4YmFJZk9sWnljYWFxNTRiNDlKTU4zTTBlNU1n?=
 =?utf-8?B?MzRwL1hjOFgxc3NYbmdwRm0zU0Q3Y1JUQlphNDVUR2wrY1RzdmdWYUxSU2FH?=
 =?utf-8?B?TjZzblgwSmNZeDJZS0Z4UlBxaTUzOUNUby9ZdFJjbHpBRWxLZzBINHRkZXBV?=
 =?utf-8?B?ZDIxS29yNFM4YnRIOXdzdVNPdTQxYnpvdFc4RXk1QzdHN0ptOG9lK1NvdXJE?=
 =?utf-8?B?aHV3RThTeDhHZEQzZDRJWlB4N09iZ2NQdzNxbnJPakVxNGk4d1luUjFmUXZx?=
 =?utf-8?B?Zk41UGI4UW5aK2hEK0xuN1hoQ1gwcjJycmhMWDRvTFVIb1VwUXpReE9QSVZW?=
 =?utf-8?B?eHhaTnBOYTJqUDJjb3RiL0FKY05VL2tFejhRR1lVNHRmaHhETXYzZERCTjVz?=
 =?utf-8?B?TDU3YkhLNmRzc01wQjZWN1V6R3gxNnVWdGpZd2FTV200bEU1bG82YkQ5Yko1?=
 =?utf-8?B?MTgxbGlYVVBkcTlReHFLRHJhOEE1dklKclNwelJ2N0pmdTVSdDB3TFBISGFW?=
 =?utf-8?B?L080djgrR0UxZzFndVpDWTFreVJnV2xQUFlZMEpFbnlQS3J2RWhWdzl6ZVNu?=
 =?utf-8?B?L2NlS295K3oydlNSQk5tQ1N3VW5XNjcxUFp0V0VSV1hqWWJLQVZUYklTYWkz?=
 =?utf-8?B?Q01tc1I5bTJsemo5eks2WVVpaFRlVnB4S1NodkZZL3NpbkJIeVpSeHZScGpo?=
 =?utf-8?B?V1FsTTNrZUZ5eW0vT0JYeWFDcHBRdG5mZHRpb0lTM1JuSm5lUlFjSUM2MXAy?=
 =?utf-8?B?VDZ5SUJZQUlTTjYyUHl1K2N0cDY5VnloZnpoTHRzck1oaGxZdmVlcjNKOHJ6?=
 =?utf-8?B?d2pkWE5ia2lMck81Ull0Rm9LNlhZdG41bEx0eTlGOHEwOFVVOThhVUVpYkt4?=
 =?utf-8?B?TmE1ellwYXFqRnlDOHc1YTVIenMvWkdBUkkzTTAxUkJ0WVBRRENjbW1kTnpq?=
 =?utf-8?B?VEpLYnJPYnEwcURpeEF5eWw2d05qVGpYdUJGWDJiWFFBSFNSZkladG1ycFgv?=
 =?utf-8?B?d3JSTHc5aFQ0bHBacEZLUVIwVU9oSjRFK1VzbkJNalJqSDBFNVUwSXZaT1pQ?=
 =?utf-8?B?RzcwdmNJQm40SmpwME9mOEk2MUlyMExMcnFMbnhWUE52d0ZtV0hybmoxSlVM?=
 =?utf-8?B?K1FXNHlJZzJ4QVRnNGl0ZTBma3ZETGxSYjdQellTV2o3ME1wajFtaURvQlR0?=
 =?utf-8?B?SkFLK2ZBQ2R3dHFibmNaTkhHelVSaGFoZVB3U2hhcnd0TTh1dEdscElTOTBV?=
 =?utf-8?B?UGVEOW9CdHZzMDVXZnVvTzh2bEprWDBEMHpzVWhuWWtPbjNyNDY4Um1MWE9Z?=
 =?utf-8?B?ZGJET0p1N1ErT3NPeDQ3K3d2U0xQRGIvWDdZVmJQcTF6ZWJjOUV2N1h1dnRj?=
 =?utf-8?B?cGZtbWZ4eUdrQUsvcFBCS2RhQzZrZGRXZE1hKytGa29CTUFxU2JiNXZRM0xi?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LgyKQ0swRL+R1BmzrL+lIPIxaBEbrD/EiE3Y9lLEalByKEkcfU7U91+B5xzmU4LsnC6tTwnQPlillYpKnNjvaT5M4tX1NCpoSXyfrZ2uRoBrpMgj0sqInhBLgFxFvhUquZjnZo29lrmeOrd8F1z57QjWrEBu8ktYctJnEkKgst0AErayYUyoCM1/ta/xBNcjAtI458YV0kEV20r3pBGJF72oENdrx80gUTamRFt8u74Ah5Bn6Ot5vC7zHetT7aC9YQktvjL28V3ZZv0EdPie0H3dzx42v03Fkm2arqmN/Rv/mqulGyt5ka+id7e1Nv01p98Hw6dL2ExyBgR0qggLe1wukdWmRxaIa/+uimbXGzBrqjIM7g2Ny09f53FL8PkUu1vIzC4pR+7oFsbqdq33L8Dts5/nVUe9s1vCAcZ9BSPVGvjVBMQtmddeOnpcL+4mQwwuzOmxkNop8o4cVYK5MHJoUsSjD7ACQgF5VSd742GDyvMjbS2nmdnTdkNitoDCq/zhKEBs7aFu9cHfW83pAvSHL8goTYR+xRp5YcsJreZ0q+GsUEyc2enVc9Lra5IsxC/mONOJVFdkghnB/BZEA8ETS/pBpZqSSyM18KyAxys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ebb774-759b-44a9-ac94-08dd5dae61d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 19:29:30.5580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsmNZyYzieXOyZD2RXdUJXrnNCuoo2+VQDqK/AYLYwmTWaP4gKxKwC3GIhEn5rDM6ujj/YfBoDLZ/oIueU1yQYlU2vQWiTCuJCKgiv4TZEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070146
X-Proofpoint-ORIG-GUID: m9rjCE7fMTXDE--ObnEGLkTkzSD-IoWw
X-Proofpoint-GUID: m9rjCE7fMTXDE--ObnEGLkTkzSD-IoWw

On 3/6/25 9:55 PM, Jarkko Sakkinen wrote:
> On Thu, Dec 19, 2024 at 11:42:04AM -0800, Ross Philipson wrote:
>> These values are needed by Secure Launch to locate particular CPUs
>> during AP startup and to restore the MTRR state after a TXT launch.
> 
> Hmm... does the first part with like locating particular CPU cores?
> 
> I'd start also the sentence with the action taken except assuring
> why the undefined action is taken.
> 
> "Add the MSR values required by Secure Launch (SL) to locate particular
> CPU cores during application processor (AP) startup, and restore the
> MTRR state after a Intel TXT launch."

Yes we can adopt something like that. Thanks for the suggestion.

Ross

> 
> Along the lines would be more informative...
> 
> BR, Jarkko


