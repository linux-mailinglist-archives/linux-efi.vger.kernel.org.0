Return-Path: <linux-efi+bounces-3312-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA21A86F1A
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 21:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDAD8C1388
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE3621ADC6;
	Sat, 12 Apr 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KfbrJbYT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KZOsiOii"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963220E700;
	Sat, 12 Apr 2025 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744485416; cv=fail; b=NQk0SbEtvhIaokmzRJ/iIuVoMTJZJDUK58syGof7o5Jxo79Mtg5z+1wIzs7vcoYyQ+LNCEXgnBzb9j+xOqWEk5FPZgNvvumapnQ+EUgQ/ySZnINrf1DQfCPlusp3JZll8sJVOFumFfsj9ckQX8INUUfOZ+zlI20JRtLKOl2l4pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744485416; c=relaxed/simple;
	bh=G/Rx2OjhAflYlCs3AsFSnJLodsfHQG1t/IHa0V6SGhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BVnJEs7syikz6lojO+QyAy9eR4e4xmwvsalsN9/rcBpY/ga5yc1mpmuJmC3cE9CU8yDE39IZuGNgPTogJipVxFTQZqHlbX8zgqzntgEv3NY706lBePLTQWKSNZqpi/KoZ0EM8XCBDAB/1IDhn/gAdOmbxA5+ejbnob4wnIX7WJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KfbrJbYT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KZOsiOii; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53CIX9c4015322;
	Sat, 12 Apr 2025 19:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=N+1JPrXrPAG9ZPjPk4sZ9kmJBay63GWkov2DC3gu4JY=; b=
	KfbrJbYT7AD2PWbY5BInLfIRA9x6LeNdq30TmVlJKaRuA7tMtGpteTNk8u376zLL
	NdBpf6LoFhrKSZsk8wTn94qZF1C2CaA2V4qbNC49SY6AhEQXAGVs9tFO47z5Uo+f
	u8APinVGCjJRIM7BW2XQPWW5EVlakbGBplPJowXer2atUdn1gNbokUr4YIPI6f7V
	GSKSLj7igk6WdXwUlBZ9upvXzp7+AUB+Gp3ngI3CMbhpRsHiUmUm2gFbA8wynaCE
	V+MamSzH+G2BfvlIpIPeCDnkzMdX6OwMCDTX/GSuDIYQdY2KZgsICr0q2i92/JJM
	c7oLchSwGDyvt354XdRJbg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45ywhg80px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 19:16:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53CG4F5s020067;
	Sat, 12 Apr 2025 19:16:09 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013074.outbound.protection.outlook.com [40.93.1.74])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45yem6he1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 19:16:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3S6M5CRL/ceFLlB/WTwCj5LYyt/n792wHW4efXQI6V5YsSi2cvo5WFK2Fz4rbRvKNl++XYF9yYSd8T7FddZIu65WYmfodQ/1IOEBACKu1QQYSTcWqY6qnv5wVbRFKlsxaRqgJhjO/w0EKB+viZ4HLYNUiTKJwtjeG15sA5RtGPl9+zfOJR6qMXKRicB+h8Ju3MHKGoJ7qgZPUTprG6iparaKVZS+YRdvtEYPRnKnV5RekkCqd54tC6RR5YaEm2uSk2Q1jiPeIG5HSPHAF+rbK9qemdEPhyQvaX4xqQQ7rNtp6PDfkwg/h+xFxfd+fK4iXWR1X04XALP1qABd6HfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+1JPrXrPAG9ZPjPk4sZ9kmJBay63GWkov2DC3gu4JY=;
 b=p9HmaBgUHy/FVznpX05vXuBack1aMZwG8p5Esr2cI/wjCoskjXlcTkh7WoL4XFBb0/FG9fpgRxq+Gq3xVJwKSivyfOR0IuofdW2PY1Yq3boAq/Zn96GGjpdJ0xOw7XYyV45Vxyq9BovgQNe60kyow+vgcVd4K7gt9RVxk8NJ53z3po2dFgON1AsE7hQ4zzgZY6IgPK++OToMlSi5sERwZ2DpiW2U+MSSbKyN+he9O7XjMbNycrMa4USh0YpMzcuqKMt7lLBiOo7vAyZ0m/pW5e9Jl9Ej1YcZSOJuy9LJWBy2fQ12md0LDc/UzGdXBuBA5tktVG3i5xhqfw4CwgVoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+1JPrXrPAG9ZPjPk4sZ9kmJBay63GWkov2DC3gu4JY=;
 b=KZOsiOiiytdUer102aPM2o1o/EdAZtUxSmBbFADe38g6p280ZzBgQSahZxDgovZaD8nWRgBwqWDfFdriPJNuGJa41u8hVAKUGwdSezR6yxlU/4tMNqm9VqHMiRX//LlOYpoQsIMxpOB3S5Magl+0zzx0FaRKNAX2ScpQhzI2IPA=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM4PR10MB6253.namprd10.prod.outlook.com (2603:10b6:8:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Sat, 12 Apr
 2025 19:16:05 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.030; Sat, 12 Apr 2025
 19:16:05 +0000
Message-ID: <40d90268-272c-45b1-add5-220e9e162101@oracle.com>
Date: Sun, 13 Apr 2025 00:45:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 16/19] tpm, tpm_tis: Allow locality to be set to a
 different value
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-17-ross.philipson@oracle.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250410204149.2576104-17-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM4PR10MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 384b53b7-6238-42db-6835-08dd79f67892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkRVU1ZFK3g4U05lSGIyWWF5a1hUSHhETXBncjJ0cFljYkJRMW5zZWZyVXJr?=
 =?utf-8?B?ZW5VRWNWSU5xbEdWN2gyRjBCQXZkdDg1aHBWUHhadEFBSEZzSUFLUDNydkll?=
 =?utf-8?B?WWd3RjFuT1l5Y3dFRVFnYys3NEgxRkMzdktOZ20wL1JCTnlNT1d3bXI2eFZY?=
 =?utf-8?B?VWlVelZucmVaM1BtaGtWNkgyRUYyUU9uZ1hXWU02cmxWVnA2YWN1N3p4NThX?=
 =?utf-8?B?Kzc3UzdkdmRwZVVsc0hyaEVEOGMwazExaE1IUndwMmZwNkhsK0gvaGdWbG1R?=
 =?utf-8?B?THpyM1ZNeFBSQ0gwTEtaYzIxd1BRM1BJekxVUW1nOWx5K3kweXlGS2JjTVM3?=
 =?utf-8?B?aEpRVGxwaTBkMTJTQndOZ2pnWDMzdS9aQ1k3Vjc4UVg4RmpDa1lCLzNBMkt5?=
 =?utf-8?B?T3BZeGRSUnhFNWo4eTRKdkd0djVIR0cwaDF4cWRvVzg1cTBzS2N4cHozZ05m?=
 =?utf-8?B?em9Ga01yR2gwT2tlMlM1NTBkTjZWdGhpeGc1WjdublV4TThac0JRNHBFS0c4?=
 =?utf-8?B?V0tmZVRYdGtoMjlDQm05QTcxVnk2a2ZjM1Fqd3ErendRVW1RQnNVYlhaeHh6?=
 =?utf-8?B?K2JaaUdrU2lFNTRzYzBWY3l5WFZoVDhqMDl4dUVxcjdya1dIUjIzeFk5cTE3?=
 =?utf-8?B?SlBMOXFCQ09taEwybVRSQ3owUXZNUWg1KytuSXkvZTVEN25ZT2tYT3E3QWtS?=
 =?utf-8?B?UGkwcHB5ejhDSUl1UXU4c1dVdTVsU2ErOXpMdy9nY1lpYk1iei84dUREamYy?=
 =?utf-8?B?ZndoeWhOVE5FMmJ3OTh1THdMb3VEVDZQM3JKeHlWV1JuTzZWMW5USWxucmo2?=
 =?utf-8?B?LzhIZkNpcnhNK0ViTTRKRHlRK2V0aDZWcXdIWU5lY0h1cW1XaG5KZFZZeEU4?=
 =?utf-8?B?Q1VlWHFRME9CVlB3M3lpN3hsY1lyK0s1QkJ4WnM4RVRNMkNhTGlwSHBERTNZ?=
 =?utf-8?B?and4bEI1bzBFUFBmbVhGMnZJWTVSSW9PSFhVc2pnRlpNSERYR1d5dlVhYVR4?=
 =?utf-8?B?VUx3T0MyeW9zMW02RnpPR2MzbkFVZkt4RVplL01lTGFrTndabEpXV1RidXo2?=
 =?utf-8?B?ZmptTDk0ZS9iMmdFbXlyWDFqMGNWd21wQWxyL0FTWmg5M0RLUThVWEgrL05B?=
 =?utf-8?B?Mmx0eWxuTGpRMWI0Q1ZYZnBORGVJaDdHMHgvU0l5ZHUwQlN3V1VZckhnSkZv?=
 =?utf-8?B?dnduUU94bFNpTStYNVg4SFFvcDlXb0dBMk82dmhVZzl6Y0tRR1RQUHVJWklo?=
 =?utf-8?B?aWVtYjZvcHVuSmZoUStWbThOTjdUNFBHaUNGaU9zTVFqaHVSYVNNZnJ3K1VB?=
 =?utf-8?B?YWd2bTlYZUpYWmNSQzZpdmhMamRFQThzK05hb0lrWUFoam9DdElSclloMTdM?=
 =?utf-8?B?UlkxdEFsNm16T2VncXBLTDhPNzFNMThOVmFsUDEwYXU1Z0R6WDlNcE9nRTdq?=
 =?utf-8?B?aXlTc3E1V0dtdER0OUREaDVHdDlQbHplT0JnVloxcDJGeUtFdlFHWEJwdlps?=
 =?utf-8?B?a1dmZ0phTzFEUVUwTldkWVVyMCtXLzZWREVsQmVxSllKaDJnajRhVGpiWFlO?=
 =?utf-8?B?OVNhQ2l4clJUL0hxbmNMYjN4NzRmUFNhbVA2aTJCd2phZ09ZU2pxcCtpZHN5?=
 =?utf-8?B?WUZuZjV1Q0NocTllbDBFbHgvMGlVekJEeTYyR1lGOXJTLzh5SE1HclB6TEdX?=
 =?utf-8?B?Y3NOVHlGVk9zWGZ3MW1vdzNMcThpSEZ1NDNldTBYejdGaFNhdm51YjF4S1lT?=
 =?utf-8?B?WW5hUjJiamEya0JnU2R3TU5jbVpGbVBQNWV0cDlndUhQUVZONElrRHE4OUt4?=
 =?utf-8?B?blRlTHZQWnFDbC84Q3ZUQTM2MFdsR0R3UzhpNmlYWjVtYkJtdXJYODgyUVBJ?=
 =?utf-8?B?bU9XN3pxVC9CN0Zub2Q3M2lET0QyVURnWm85dVRpV3hiZ0xETmtFeUx1OGNh?=
 =?utf-8?Q?GI2qTy9QFtg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzFUTTNqMDhkSEkreUREcEVmZnFCUnVFQ1VNaGxnZkNpZGpaQ1kyNE5NNTUw?=
 =?utf-8?B?TDcrSkkxcUxqMFlZRlhneFgxVGZqM0F2Rk9NaURKcndBTVRNbXFFQWxUdGg0?=
 =?utf-8?B?cU5hYmVQMHI2UDllYytSTTF5anVBVnB2SVQ5cEx0WXl0QVhPTFN1LzFlVmRh?=
 =?utf-8?B?U0ZZc1RZTVFOKzBFdmpET25tMXFKMy9Va3JGalVyMlhXSnFQMFRnUzE3OCtm?=
 =?utf-8?B?YkZlbWZjYldzc3ZUVzJvSUhJMDMzMGRXUnJRVWM3Q2JuSjlVNUFZTjg5ZGNk?=
 =?utf-8?B?aDBXeWZSSjcxVkNaL2hIdXl6UVNCTmMxNFdRVmhmekdwOFk4VWRIZmpVNzNB?=
 =?utf-8?B?RzRsTFdMQzUyRHlUMTM0UjBxd2Q5Y3hkSS8rMGRTZW55SHNKVG1BRXB5WFNW?=
 =?utf-8?B?N2YxKy9MRjZMZjNBcWlkb2RPODFuM21HZE9EcVZQYUxqa1dBWXQ3YWwvTXRQ?=
 =?utf-8?B?YmE5RzF0R3VJMmhOWDdRZ3BDakwzNTRBWElXSExuYmdPMDhVUVdBakpsTmh5?=
 =?utf-8?B?Ynhad1I2R0xRRExLU2V1WEh3SE55akdBaFZFMmVLMkp4SFR4U0tPNmE4OGlz?=
 =?utf-8?B?OEQzOC8yUDJNZWNuWEs1ck1lOXRWYWxxNDdmeHRqUXFqWHBPbmZmTkxtZ1Jq?=
 =?utf-8?B?aGFsdnVmT0J2UlNZV3ovRWdMWnNKYUExbDRIdkZyVDFNMS91STZkZjE0MFlt?=
 =?utf-8?B?NHdkNGdKemNaeUNZNzhkdm5LSkNSQjVOSy9lSStYMTl6T2N6VjYvSWZ3N1hE?=
 =?utf-8?B?c0N0ZHBQSVUvdDNZNVdrYks0ZnRwKzY1TWdMNENlNzA3dHZmRG9ENzhhZGs0?=
 =?utf-8?B?SUNQOE9HdmdMNFhrdndNTERmRDNISE14Mm5iY2diL0hQZmMyOTVrTnNNSUc5?=
 =?utf-8?B?M2xsTFhXZS9wSldpYlh0SjlCb1JJbWJvUVdiQ2d6STZjZDdPaTBmMHNleG52?=
 =?utf-8?B?czd5dzVWRzlNLzVacC9ZZzVjZklBb3IwaWNYcnFNUHdXMjI2cHEyMFJkUmoy?=
 =?utf-8?B?ajNVcXFwMFJQaWRUOVAzdlFMU1dTS1hIUE5mWVU1NTFqOG5rVHlxaEFYZW84?=
 =?utf-8?B?NHRsY1JTU0tweGtVblN3a1o1UW50WHFmd2RCamRWMnBtdHBqQ1FSb0xvUW8w?=
 =?utf-8?B?V2lmaExTTmgyaG51SEluS2xuODlLbGYvSHprSktGSDg5TWR1SE9Ecy9nUFMr?=
 =?utf-8?B?T0ZSUFVHc1dmbEtjMURiSkl1ZnZYUjJBMmd2T0dDbittbFc0dkRiRGNYYXhX?=
 =?utf-8?B?Q0RwYXFsZVR6S1haZDVPZlh2K0tuK0JKcWFtdzBVbmlIVFp5Ly8xNEZ4cGtP?=
 =?utf-8?B?enNmQms2MG9Sc1NoYWtITjJKa3AwbU1WWmNzVU44MHJKUTk2TjJrYWFXMnZH?=
 =?utf-8?B?ZmFleTU0eW54aHJsNWpCejFoUjNOYklLUXIyTzcrNERlc28yR1Q4K1BrWkV2?=
 =?utf-8?B?QzZ2NWRSbkJkMWtOS09ZV0dVaHVIZVNlVVhZN0tHRmZkRFhVZEsvTVZXaHNY?=
 =?utf-8?B?dUdvWGVKMWxXSWQwUUNySWRqZ2ljcG9UUmZ3dnpwSmsrbTVJZjR6R05aQXFR?=
 =?utf-8?B?dTZSVmU5RGFHTTFYbVNiV0I3dUxLeDB0OG1EcWF1ZjZHVDJaQlpSell2M1dW?=
 =?utf-8?B?MlB3OWZVWGF6aE9iMlNVejh2U3BJRWNRcGNEcFVyS3loWFdPSDZvSTZhVmNr?=
 =?utf-8?B?aDhGZlhuS3hTcjJUcjJ6K2d0Rk9VamJZd25zc3M5NGkweThwa3RjSVpXUUdu?=
 =?utf-8?B?dVpQNUplb2JibkRrNUZXOE5GYzJ4cHpRb24zSUozMlpqemVDUnJxQ1VMVEJT?=
 =?utf-8?B?OEVWWU5XekxPc1BDaHlLVXQ2Mlg5bDFCaUhvV3BtSU1PL0pHbm9rbHNBNTBO?=
 =?utf-8?B?SEVYUEJ1RjQxSzBYdXppeEd0Nzg3NnUwSEVUOXErSTZvSXRqZFVnOE1vZDd6?=
 =?utf-8?B?YlN0c3FZa0ZLTmF4QTZOK3lBM3dEK3BodDV2TTJZdEJEVkhHMy9tSWg4MG9X?=
 =?utf-8?B?VTYrMnVWS3ZqSlQ4VXlFdUhFTWtvNUZuOTZoTGJVK3I5YS9HZjJvM2hmUmhI?=
 =?utf-8?B?SGd3bzZwdmlWS1JManRMam10bWNmYXFnM0VRbE1Jb2lzOUkraTUyRjY4bkFK?=
 =?utf-8?B?aXMzaFJ1U05PN1IwMGUyWXkwK1loSUpUOW9pb1FVOThzQklKaHVIUmRKMzZv?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1GwaBSCuibwXUOysUGbXk9uim/amsUNTt976B4P1R2Z+YBHZaf/RZzTWc5kz5IDOrH3RnOsSJxVD9GFZN4RqKYYcAH47YX5XBxi6jVug6pBqdDbM+VMrpDh7zai1qf/mu1tEBlrg2WMxGVygGhDzviqgu6AgKUkJg8vH8zUpadsCkHIkE0K5RPFc6XddyfAON1P8N65hwIkR40tETLvtoQ116BNp6e0Cw6MEmzrcWJCSv7VXvMW82892AEwNTE/HXQmXJrhXVh4+8zyDtZMt58BfXtUnyuU56wMaCL5GnZSbpFZPt8/gWZqKCjYwqmNpcUAyKK6hhxGv10PrksBcJnRwlZIudjj9whLDvddjrH7Z+oAyEcMS3NxQmLJ8k7rv96rmTEnSYicc0VUc+hSIm2Y1zqKk3bCBU4rIIGHsXOkxH4uYfIN5FMmNUrKZqDSf6OTdOEBrpRZrm6oCvXNNFIuFj/ScUnHNx+XB4XVOmF9IMVzYWlAO+r+Arr6nSuLnIjOaYvP3TmMJeEQ2/KkomyzA/mJVJWG45AjFnEA7DWKt8NsJDRC/z1Uc5p6sLU3d8cU4MIvVatdxjJT4RgaegB9XwutJmZf+8TN81A4FZF0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384b53b7-6238-42db-6835-08dd79f67892
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 19:16:05.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yj/AEc3MhRZGqFhMAvAW32x5Oo0HODlOOK5FUEXL+yl2quONAH0PLBFu1wT5yrKTOMYF3WvYm1gbd+0h97bF9ZpUIGEoS1OKl8tYqwzlLhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_09,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504120148
X-Proofpoint-GUID: RBumteSSxMD2r_fUf2ULNvRjf36AKoUI
X-Proofpoint-ORIG-GUID: RBumteSSxMD2r_fUf2ULNvRjf36AKoUI



On 11-04-2025 02:11, Ross Philipson wrote:
> DRTM needs to be able to set the locality used by kernel. Provide
> a one-shot function tpm_chip_set_locality() for the purpose.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>   drivers/char/tpm/tpm-chip.c     | 33 ++++++++++++++++++++++++++++++++-
>   drivers/char/tpm/tpm_tis_core.c |  2 ++
>   include/linux/tpm.h             |  4 ++++
>   3 files changed, 38 insertions(+), 1 deletion(-)
> 
> +/**
> + * tpm_chip_set_locality() - Set the TPM locality kernel uses
> + * @chip:	&tpm_chip instance
> + * @locality:   new locality
> + *
> + * This a one-shot function. Returns zero or POSIX error on failure.
> + */
> +int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
> +{
> +	int ret;
> +
> +	if (locality < 0 || locality >= TPM_MAX_LOCALITY)
> +		return -EINVAL;
> +
> +	ret = tpm_try_get_ops(chip);
> +	if (ret)
> +		return ret;
> +
> +	if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED)) {
> +		tpm_put_ops(chip);
> +		return -EINVAL;
> +	}
> +
> +	chip->kernel_locality = locality;
> +	chip->flags &= ~TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
> +	tpm_put_ops(chip);
> +	return 0;

a '\n' before return is customary

> +}
> +EXPORT_SYMBOL_GPL(tpm_chip_set_locality);
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c


Thanks,
Alok

