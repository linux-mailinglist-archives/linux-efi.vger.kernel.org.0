Return-Path: <linux-efi+bounces-3128-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC504A757DC
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 21:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99236188AFE5
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D681DD889;
	Sat, 29 Mar 2025 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UvG/YxoB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c2U5hE5J"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE68134BD;
	Sat, 29 Mar 2025 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743281254; cv=fail; b=WAv7hr8Z9/eGyiFgkJ8bI4LUR4J/c/A6h8wIwIdY3EQTP6wQoBZzB++I83lFiCeTBxm2dCV6nGTvpoYRHm5AITb1iovkxlrtmr+MblvT4smvGZRzST86h8w5qVTM2db+4EcjtC0l0RkIxgEFSz34ZoJa/UohFFr5MzbVwuORYfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743281254; c=relaxed/simple;
	bh=MuEOK5o8GYQmi6MSLQx2ZoiGzfiYdhvMJgLKfW+28Xs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sRuV0rye/8zDCOf7ntE08ogWixdw5e1pf5k8Ii/7TguJPLxxk6OSKmuR7M9PtHU4HlxsA+Hk+Xa8Xv7cHxSh75FiEOTvhrDEzwRFFr528olJEww45/p6cdZsl1fkZIX8yquV9fZcJLWjAZPnpsHaWfN99rfMinrIYtNKb0jI/bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UvG/YxoB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c2U5hE5J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52TJwHtD013969;
	Sat, 29 Mar 2025 20:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=h81XR3S/Tjc87b7Z3OZ2cumXjvuYsJ1+ShwVylmIXs4=; b=
	UvG/YxoB9ad19E8RDzcRM4TlJkUBzkp3/b2CiEhFS8AoH0mu4qIZUIlShy42oUJy
	j6oEMIFX4vXT4G4jzJbut2OZZW/xXNJquBnK3WU9ZatRRLVOeatZwz2NyWPHj81A
	7GtnM2FjEigygOPBzmB2zKG2uB47Vmk8Js1hpW6qHPpYnp+BMD8WkeXZfdHC690H
	KuGAzundpCfoAxo0lWm7UnqigmuFON+RW9qEvpfVoMZuOkHcBX4z5NM631vCl4u5
	OzeCR7VIC/H9UFUlRaoNLcwqaWHG/DTe3Y0OxcuB1ixBRm3fx1xV2tKt5auPMm1Z
	HXIw6uiEp4PQU7W5P28NSA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p79c0qtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Mar 2025 20:46:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52TJsMAP010698;
	Sat, 29 Mar 2025 20:46:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7acjcwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Mar 2025 20:46:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSEj/Su91R7rlzcqKuIpRYDUNjHJl+o2Gi6IpdHn4NxsC7MGQQ+SXTUXg8g4/P2N//kzmMWncUy7y7Qb2MG3xSYx2KOqkqcukn0avFaLV8WudVqt5T09try9WB6izt+ht4cFPvEBAPf5BqcInEwaCiN42xIl8XLtIePAlJRDFM1ZRP5FGT+L3COX5jhNReDXfFbK0+flhaxjtr+iUaC9F2IXtkCtBfCi4bB9gbvswF4hxd6qXgEWD2omxRrkiXmPL/ZffuIUkbU14zV+pUb0hT5WitXUEwbsoB7+g2ggd6HcDi6hJNpsn0QvymD/GX1nNa0ugbJlq5UH4IyqNtlWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h81XR3S/Tjc87b7Z3OZ2cumXjvuYsJ1+ShwVylmIXs4=;
 b=eoeEUy/Kkr/4PpBrsmro9ZIlmhnYC32DGhysbYT2/GApGoEixZY39hnLZ79C59weZrPdpiRtNLy8OniCiDKLlo1M8JoDkEkuWhLeOmKg0LTrFgP+Wmv1cXH98b/xSeIzOKF408jeKzw8rwmfO+HHbzEso8l//3PNFYcAvEDVRx0tR1Lt9WEu0L/QMWJ9vKCqUBkxe5wOIHpJqqBgz7IpykrI9QgAW7YhK759qAd7OYkz7vmWHwp7uhJpufMHhFAu69W4btVtlh7hkVkffikmRYwEseskaJE0yIUNXYVTT7o4OoVVUPV5/M9XpNBAcT1r+NgSys50IXuNF7xCjuMbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h81XR3S/Tjc87b7Z3OZ2cumXjvuYsJ1+ShwVylmIXs4=;
 b=c2U5hE5JaeScuNcDMqcJ4CJ1d0ZmE9nYP8sKe3z6m6OSkyy+5qUha/X62YYUSAdvIwIz4s5dXbQQATMXLUutyR4ktF4NzPLJ96T6PsUhFmNzBpZnKtY2vxY537EljA2WFk0kh5LbVMXtLf+9NMcoxkMKhhUgMo0nF+3732/lG+4=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 IA1PR10MB7263.namprd10.prod.outlook.com (2603:10b6:208:3f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Sat, 29 Mar
 2025 20:46:40 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8583.030; Sat, 29 Mar 2025
 20:46:39 +0000
Message-ID: <1370ee6f-fe47-4789-9bae-d6031eab082d@oracle.com>
Date: Sat, 29 Mar 2025 13:46:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com, ross.philipson@oracle.com
References: <20250328230814.2210230-1-ross.philipson@oracle.com>
 <Z-faPSIlZV91j_Z0@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <Z-faPSIlZV91j_Z0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::21) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|IA1PR10MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 007d81ab-fe40-490d-dea4-08dd6f02cddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2E1V0lRRnVTVG5EbkJzeEJOaWU5b1NGZzJtZythTlZyOFVmUmlkYjZKMDBo?=
 =?utf-8?B?Rjd1TW5ZRVVxUmJyZVFYRjVkWTJVY3I4aHZiemFkVmhrRUE4NzRvK1d0SVFZ?=
 =?utf-8?B?QVg5Q0RsV2p5SjNUQmd5ZzVrSmxJanYzbkJOc0NHRHJnSnc0aERkMmYvTnJa?=
 =?utf-8?B?ZWhqa0ppUkdxY1hWUFQxOVR4Q2M4emNnVGpaUytpZDk5SnZBK3B0UmsvWnJK?=
 =?utf-8?B?NS9DSjBqRjJxS0ZsYS9UYnlOZG9yQUVHQ0tRalJzbFZzbFYrdnBqakNjaUVz?=
 =?utf-8?B?U0xlSmpueUsxckhNVkUwVXJJc21oREtEQnNod0MyTWNVSWJpZyswcXFydTRU?=
 =?utf-8?B?Mzc4eklIY2lEaDVHU0d0clFWWjNocHlWQ1JvSDhyTlZCWFh0UTMxclNGWklX?=
 =?utf-8?B?VU9MODlTcUh2bnZZbUh6VWRkNExNSmQ4RWdweloyaFBDaTR2NXJadlFyYnI4?=
 =?utf-8?B?UjdqSHNNWmo1T0xMRFRwRENsNk9OVlRCaTl6ejVvdXFWRFptaVhaYTBNSDFy?=
 =?utf-8?B?azdjQUFkRndKbGk3UWUwZVJ2bm1nVVNKZERLUFJVNllZenoySi9WakV1cm5R?=
 =?utf-8?B?djFKNHRkd3NUSWtqanZIVytTZjdlSW0yRXJTRGk5VjBiRE93TW1jTjBTUHlS?=
 =?utf-8?B?N1dDTzl3OWFRSjZBb3QxNDVzeUVRQnVnYWZsK0RKa2NwYm1IWnZYcWgrR1Yr?=
 =?utf-8?B?S0dscCszTEtCT0pmTGZHVkZzcFZnV2ZxTlpUT0hzbmpIa3F1YitSS2g1RHB1?=
 =?utf-8?B?WWNaS3FXZnJ2WHQ2QXowQzZmNEhPcDRrdnh4RHNYMFdHT1plUVEwblp6RThm?=
 =?utf-8?B?MEVSWDY0cEFMT1p2d0RUTTE2bHRDSkhSSWxZV0dkYktHWnZxcmFHUWVpV1FP?=
 =?utf-8?B?M2cxSkJibzRIcERNSmhEYjhNVngrc2dxYlFESTJ5ODEzbHB2YjVXV3RIRC9L?=
 =?utf-8?B?bHRSTkdNa3JzOVNaOGg4SFYzdGgrcVgvUTlCY2NNSW9HQmFvTzhaZ0JTSHdo?=
 =?utf-8?B?aGNBeGJ6Q0t5ZzB1Y2NXS0F6bnBxaUNWUnJmeWZPWWcwekVvSjNHMWhOdW1T?=
 =?utf-8?B?ZVFZc09RWlJha2VOVmR1MlRwbEt3bHRZaDlKUU01anN5b2ROZFYwQ3NadWU3?=
 =?utf-8?B?bDJicE5CZHBwcVIwcnFXSUlOUmI4eXhqVlI1MTg0Y2prOWlvTmh3UUFad1pP?=
 =?utf-8?B?emprVlI4YWRoME84Rm56emt5aUxraWI5N3Ztc1dxZWJCYXNoelZhYTJsdExm?=
 =?utf-8?B?cm5ocnpNdWtkS1U4RGNqRUExS0cra3JTTUQ1REtZWVRDdlkyNFNYWGRSVjRt?=
 =?utf-8?B?NmZ4VHplc1hiUFIzMkcyRFhDSzZFdXlad2t4eVRZcENGVGorN1YvMzJidDJ3?=
 =?utf-8?B?YWd0ZkFwazFwa09VdnNqNTI4elpKR01kYWRzbXhYSnpEK0VXc2N0eW4zRTdG?=
 =?utf-8?B?UUMzU0pqeUQweWE2ODJzcit6TXpvS291YU8vbUE5SDMxSkZhK04wajZvRXZn?=
 =?utf-8?B?SitVMHA4NXduQ3ZQazVnZkhlaTlaS1A5WndMNFBpVXlhdzluOWRKa2FwTVN0?=
 =?utf-8?B?cy9OaE9hdlZldkRqZFkzQ0xINGtsUXhmcXlmbEJQd0Z4b0hKVDZtYkxZdGlY?=
 =?utf-8?B?ZHB2Yk9rRkcremEySGdtY2lGZlJ0aC9iNmoraUZSenBUZ3Z6WkxFcDZRYVZx?=
 =?utf-8?B?QzJkcVBYNUgyb2ZidTYrVHNXMjg2QmlML1JlcU8ySGxDZHh5bXhITjFJU2xG?=
 =?utf-8?B?WW5hYWMwVU5uaWlzSWVET3NnSDBjTGNlblRvU2JPYTF0NjJoTkhlWXdtbmEv?=
 =?utf-8?B?ZmVPZ0NHYnNqZ1VERURRN2RqTFVybEx5SVZGck9SRjhVS0FzWnlUd3FueWR1?=
 =?utf-8?Q?9rhUK8615AQ9G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTZiNnlIdTlVNkRna0xUU09JNm9adlY4OWFxeGd3bjk1Q2lIMXJqZDJMczM4?=
 =?utf-8?B?L1A5akRDSVBXNjQwUWdJd01xeDNTTGhSZFZjSnQ4eDM2UCtKVFlYcS92ZjhN?=
 =?utf-8?B?YWoxeXZWZGFxblZGYjlqWE1vcmFoOGN3T0QzS1I4dTJ3MXdmNThTOU82ajJF?=
 =?utf-8?B?QzlvQ3VMOUE0SGtyb0kvOFNRWTZrZUNDelpKY0dsMXdtYWtMZW9Gc0JZVHh6?=
 =?utf-8?B?RVl4STNyRHJ4dUJGQjlsZjVKS1FBWUpTbHlWSHo0bzJBWkE4NHlsY20wcitr?=
 =?utf-8?B?Q3ZJVW1MTG1leEh0R25ENkZFK2JBNjV5OCtNN3U4eFlhWnduTjcwUDNzL2Yr?=
 =?utf-8?B?VXVMcGwraWo0ZWp6alltcVpBVVdyViticHVyRXFReGM0dWRVVTRwelNFOENY?=
 =?utf-8?B?SEVKR292M0ZyVXNxVHQ3SGtRenBEN2RETUFueE93MnJVR3RYY0FROU5NNTNO?=
 =?utf-8?B?bFdXVnFqd096aFhxNk55SlR4TnhOSkFtNy83NHFlMFZNL1MrTFZ6QXR3Q2o0?=
 =?utf-8?B?K1VITmI4VEJmZjVxOWI1ZzhEMWxrdEJ2MmtOSlhaWmtGMXF2UmtkckFWcTBR?=
 =?utf-8?B?REFpbHlIK1Z5V25vdlNlMzhjbngvSmJlVFUrMVVzNlN2L3h5UzRnb09MaTBG?=
 =?utf-8?B?NnFRQjExVmVKd2tOd2FETUJZVXR3dnVYWkFyY2xVYnMrR0lNc3oyRnVEbEg0?=
 =?utf-8?B?UStJSU1wUGMvc2RMWGJoZXcyN2ZqTDI3UXQ2VGJ5Ly80bGZMNkpCRUlNNVRS?=
 =?utf-8?B?aWxZbG0ycGxtaFRwcHBMTDJZS3JyalBEcTRpQXBFMDdXWUFsdnB2QjFROXFu?=
 =?utf-8?B?azU3Q3RJOUdMUGVQc3hZRDdZb1NlME0vMk5sdjVhUEdTYmZvU0JIdWZpZ3By?=
 =?utf-8?B?TWR2NDB6Z3hTcC9mTGZBb3pyOTArcDBUMFNvOUQ0eC9UcHMrOEo3RHVrQTJO?=
 =?utf-8?B?cSs0QlJ4VTM5SHBSNTVEVEtRbHJvbzNLMklhN0tXdnFVV1ErOTJmOTJaZkF2?=
 =?utf-8?B?N1pUcE1hNXAxNFBwdFo3TjZKQUt0K2VSeEcvdVNCZ2JMTUkrM3ZEV2FMcUtU?=
 =?utf-8?B?Y1RoNzRWREtyOWlQZFpyTlR4MGNDY0pMTTFSeGt3MG1CL2lDZkRDZk9iOFd5?=
 =?utf-8?B?VFk1aUJaTmhrUGhUT0ZTemk5dGtvVHNCbE5wbFh5WjV4WWdTTmdWUVF6TC9j?=
 =?utf-8?B?cldtMno3aHprTDdnd2grUEFqZmkvQk5nblh1bFE0Y0w3cjBmQVRDYmNGTS9z?=
 =?utf-8?B?VC9DMlViS2lrV3gydTJUTERGZ0pOTVFhajA1a0xuRnJTMC9NVmIxUmdYaHlP?=
 =?utf-8?B?WWMySHZGaWs3ZzdDQmswaTYvTVNpbXJ1di8zNzAxVVROU0JSOGF3UHc1OHcz?=
 =?utf-8?B?U3JXbjlJU01oUDd4QWRKVzhnRGpWQStQUlN1cm01bkorTU94bHgyVjh3M2RI?=
 =?utf-8?B?QWxPYXNSM3F4VXlzc3V2dGIxalYxTnNDVHJTVzhnbm1FdnZqL3JGQXpoNmdG?=
 =?utf-8?B?cUZtUThtVnh5ZzZTWDRka1hoUlBLNlZMdnFvOGdZYXB4bWw5andmNndvbTR6?=
 =?utf-8?B?MlRjcGtqZFNydnMxOEZNQ0Z3enZPa3RSVmlJOVU5YVYrQ1RRZmVGSEg0MTlp?=
 =?utf-8?B?WE5xSGVVSms1Znh6NVo4T0pXQlNWMzBwT1YxTzI0N3RFZ25ZY3JCQVJ4bDRK?=
 =?utf-8?B?clpwaXdVNFBkZDdZZW5zVE9CZGhrczYrSE5iRFgxdGxDemt4R2Q1K21DSjV6?=
 =?utf-8?B?bEdlL3UwekVnYzBHaXQ0MjB1aXZvQ1lGNld1WVJUWHdTV1d2cW1JR2dEM1hR?=
 =?utf-8?B?NnVQZVFzNzlIV3hyVmMwSC9CVjc5L0taSm1QL012MnpRblRXdXhQZzNlSVdC?=
 =?utf-8?B?Z1pqbFZzcjhGZ1pwdkpXVWdwNEt2QjZ6ZHZybmZ2Qk1Ma1B3ZmNjRmNCamUy?=
 =?utf-8?B?dVdsaGpmL3FJTFl5RHlPemg0NTB5OWRRRmJaNFhuMHpsZ29WMi91WndraEJ4?=
 =?utf-8?B?Wjg5dDJaT3FhVGJVS2QvUXlBMHBQa3g5My9SVEpzRWRtbUZXUDNUdlpWQ1Vx?=
 =?utf-8?B?NGh4QTE4OUR2R21SYnAzdk9SYlBXTkNEckpBTDIwcjVIL2lHUUhISGdCeUFp?=
 =?utf-8?B?V1FrM3FLVStRdEJEVGZkNHB0ejV6SzNjYng2b1YwZTcxWThSWmdLQWNPRTBW?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9EdDVDhKJmzPrWTKgb1DjlozCKSlK37486TisqyDil3LvDAfRXhoI54gcrOmu18oygzp0PvYHbn+wm9Qbi4c6/RH2ft2/ryqEgZq1aGmtQL0en41B1nqjizlsEcH5SIChGs1tG4H9Cl33Owme2cBsnb2BmELgSYh9Wg461NB9OZEj+CT+mHCwJewKW+ZhO1Vvg1c+EDCS4nKWWPR0MW0PWfj0sfMmaK7ylcAipyB84iFKoRNCLT14x6swiJ+qWiy42NIyUTm0qeG1LUZ1BGJo+HuOy6sbL+AAkhMbm35iI8L47p6/Z0c74zPMlMrWP7c+i3Py7wOEei79dmS0VuSmRE1uSAChKqDJIhxaWAO9VUWbFy5lk96L7oVqtiGcz8aq2p0ScnVq5IJRXWw5yUHlqbVW67d0UUKdD4seu8deI4o2Vwp8QrFUcF0LhCxwjGBQmKPmkLcEuQhA5viZLJL14PJzuVU+/65wHqeqdYvPw9BxwtWL/cFMJ2fnXX+r9SqRoRYaAKFb7qNKzI+wmG3VDsaD5Ikhc65wvl+xj+Ly7DxBK/HQpsYuwjdJy3/9nIlA3MriePBdxYoj+QWqGVC5xCslAJ936cpxwCiabOy4Q0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007d81ab-fe40-490d-dea4-08dd6f02cddd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2025 20:46:39.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmWzTNLLL1cM2E0rCmnADl2HCB3szXLARljFLFXgMGXNMV81qkq1ib/CXnmQAky9iZiM+ICw0z4pMokcmxleot+pE9qIQdSRj9OcSUMS+1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503290151
X-Proofpoint-GUID: rPGCCCfAw9CG2CzTyoHDZCYNHfKvajPY
X-Proofpoint-ORIG-GUID: rPGCCCfAw9CG2CzTyoHDZCYNHfKvajPY

On 3/29/25 4:32 AM, Jarkko Sakkinen wrote:
> On Fri, Mar 28, 2025 at 04:07:55PM -0700, Ross Philipson wrote:
>> The larger focus of the TrenchBoot project (https://urldefense.com/v3/__https://github.com/TrenchBoot__;!!ACWV5N9M2RV99hQ!O3YD_Gg-b5rJB_LxeqAKq7YGMDlmbkk1dUS2khRWPxGpRgR36kf2jpRZPcmqJD83GOvjam2SUAJ1J5iy914$ ) is to
>> enhance the boot security and integrity in a unified manner. The first area of
>> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
>> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
>> Trust for Measurement). The project has been and continues to work on providing
>> a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
>> cross-architecture (x86 and Arm), with our recent involvment in the upcoming
>> Arm DRTM specification. The order of introducing DRTM to the Linux kernel
>> follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
>> Technology (TXT) is present today and only requires a preamble loader, e.g. a
>> boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
>> been present since the introduction of AMD-V but requires an additional
>> component that is AMD specific and referred to in the specification as the
>> Secure Loader, which the TrenchBoot project has an active prototype in
>> development. Finally Arm's implementation is in specification development stage
>> and the project is looking to support it when it becomes available.
>>
>> This patchset provides detailed documentation of DRTM, the approach used for
>> adding the capbility, and relevant API/ABI documentation. In addition to the
>> documentation the patch set introduces Intel TXT support as the first platform
>> for Linux Secure Launch.
>>
>> A quick note on terminology. The larger open source project itself is called
>> TrenchBoot, which is hosted on Github (links below). The kernel feature enabling
>> the use of Dynamic Launch technology is referred to as "Secure Launch" within
>> the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be seen
>> in the code. The stub code discussed above is referred to as the SL stub.
> 
> I did a quick recap of TPM patches and still looks good as far as I'm
> concerned. Not actively reviewing these anymore but I'll do a sanity
> check per patch set version.

Thank you Jarkko for all you feedback and help.

Ross

> 
> BR, Jarkko


