Return-Path: <linux-efi+bounces-1618-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C57963191
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 22:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1A21C21CA9
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 20:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094031ABEC7;
	Wed, 28 Aug 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IH9AD3GT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="twHGrWq/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766C1A0B05;
	Wed, 28 Aug 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876168; cv=fail; b=jITGLeigZ3T/JRboZEQkfPg8XkvMyF3sA4qMkcs0poFdvoUUMp4c/AcI0OQIHNwdIdVdzMwJC0dDOvn4s9BJvou4D/0Bj4Ov2YWO4IL4+MEDw8NHyDQVrU0+wKYcGW/1aEqPgtAGr1XLYiADvqclk7c+OSfrFrwTtCxgtgZ3yE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876168; c=relaxed/simple;
	bh=brrkhbgQzhBj8ZhAKNDVTtmlHbA+Fi6ahVF1PF7ZA+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LEpiQdqIznXMY9QbuPcF9xfd5GwhoPorYPVjV+i1wEbXD7wQTVX4MgqL6ZF9hFA4a5/822q0hK5K4D1Q4qqP7Irywr2RolenKwUmSgtqcdq1TUBtilvmfjLpAfFXHIUcuNVVoT08USuLD02ec2H6RtJrKCLdhEUud6EVRddYdoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IH9AD3GT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=twHGrWq/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJXYNW026674;
	Wed, 28 Aug 2024 20:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=thdaJMgMyuYGqq8n3FY/SB2ISAWSvg0IaIhowwZxmCM=; b=
	IH9AD3GTEmv5v7zqBKyxy9+1T9sPzZ45SoJgq0l7HJGXMF4AEQxbhqkeivXtpGdi
	emUhlNnZde+h/5ZyAgKNRt57fQIaEsAKRSc1z7jeAvvn/XDfB114S0gFMnEg5u2R
	dW6YfbBJkC+mxrUqyI06WLMh2D1VuLFPKAazurXd3CemnGkeir/YyPcFWeLW0knT
	zlk59egP4KgdvCvmaoWupElYD2shzlJ/7y54Ton/Tg/lVofwMBOiBD2XB44Znzvt
	cvmIwTvb72qGmA4iSiJP8Z7+q1EZBN+/mhP4r4Smvs718HrGisixW3jOPniMw0Pw
	igP1wj6N+Qx0CH4U24N78w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pura7tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 20:14:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SK5p8J035057;
	Wed, 28 Aug 2024 20:14:55 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sv125h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 20:14:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybUX6VkItmZLjCZNYUoRtU94kCxxl3AaSkds7zb+LBEEJvvkbbTg+BQ6aPTUfrIjE/3hHD2REtnknEGvTCcwog23750L4rmX2I/aus+Zh8KWTjEfovo55ek7yQyk9vj4qj8z8JumFdZ5kUF73XCQCiE2HFBGrrPK7ss0snJAVax/giql1+WPq+Qo4ZdJceOZx59q+4diUJi5Nufl3BPdLI2B55SmUI1P3Hdj1GeKbdLBdD0eZv98R1/XOBNwCo1rZbIkh4lTDV4Jw75VSGfa4YbQr/rTIPgMevLEQfg1cHljH2xQQM2drsFIEaU8xauzju/WxEFYkGQqry+NP07S6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thdaJMgMyuYGqq8n3FY/SB2ISAWSvg0IaIhowwZxmCM=;
 b=wyW4/DjzIbBUqyHhMPnGLG+4ZBzeg+UtjvZEarIZvRg/xvGlVlhuaG96mXF90B3uBfU1hrfDOEb83lHpGGjNjAzKLO8ss2ADyDfm65mOsqJ4KrZ/ai5EeS68GMv5rBECw+ddFSPnBNfsFAjeRvOfPUQlZzhDyYeeTJ4rveDFujsYsj7ALA833s21sSGtZXFysiQjUFejDO9wMXn1xYXKp0/c6shU+CCSOmX1FgfSZ2PYMWIb7O9EaKKHAcEPqpoI1TMHZ0o3hiBXnhDWCYGxO1bYK190hTQ+0dVVXtnnP0WWn79NF4DtYfYMTY02eMMryNYOiKd/DLsmPmCvInBB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thdaJMgMyuYGqq8n3FY/SB2ISAWSvg0IaIhowwZxmCM=;
 b=twHGrWq/0pDhNDNZ4443V/m1/WE40Qyy30mdojeectMLQaAApbQ3rcoFADpZChkKX5FOkITug+tuoexexurooXaT1q5DfVJI47ItjURRssS6U3oiOYGICXaVMXGidAwN7fFxLfEsC8cMAJrgnBzb6gNU4LAuGTaWcHMVzt2rhMs=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CH3PR10MB7645.namprd10.prod.outlook.com (2603:10b6:610:17a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Wed, 28 Aug
 2024 20:14:52 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%7]) with mapi id 15.20.7897.010; Wed, 28 Aug 2024
 20:14:52 +0000
Message-ID: <601646a2-46ac-47a0-a8b7-1d45a09172ab@oracle.com>
Date: Wed, 28 Aug 2024 13:14:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <20240827181426.GC2049@sol.localdomain>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <20240827181426.GC2049@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0658.namprd03.prod.outlook.com
 (2603:10b6:408:13b::33) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CH3PR10MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 382cb9d9-5af2-4e38-f4a3-08dcc79e1372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVdLUlJsQ0NrcDhKY2NDUkFyNERzYU1meHppdUtFZFowK3hRUXhBM3BXVXZQ?=
 =?utf-8?B?VnV2T0QzOFVWeDAxNnJHREt5VDZEdkhweXNSN284dlhsUXRJb2RBVzNGejBV?=
 =?utf-8?B?VXhDU0FWeUJndnFuV0tKYzJZaVpJOUgwaGc1VytpNFQ2TUxjYUM2RFgvM3pG?=
 =?utf-8?B?ODd2eFRRSndENm5rWUlGUlRVUHlJMkFQZUo2ZnY2dWt4T1h4YnhHM3N3Tzk2?=
 =?utf-8?B?YXhpbmpEMXZmTHQrUEhtSmJvNm5zMHNSTDlaU0pkU0FhTm5jaXAvQ0dJNFR3?=
 =?utf-8?B?WFFJRXNYVUh5THJaYmwrWlNKU2RHN1cxUnVuS2RrOW50aStxL3dFaWJ1dTgx?=
 =?utf-8?B?RlFJalpMRnFLWjVRMk9DMjNZTlUzbnFyemI1RWg3ekZxTkNjb2txZktIcXhK?=
 =?utf-8?B?T0RERGovU3FKMmpPMjJCUE5Vb0V4eFVBTGEyRWwwRGxUTWl0Z0xucENuRk5B?=
 =?utf-8?B?a0l5ZFBueHQraEhpb1UrWUNnR05rSEQxNS8yaDZITWI1Ui9NQTZoUU1mK2hQ?=
 =?utf-8?B?cm8wV1hWM2RlUnlGd01DSG43aHphNlE2ZTNSWkt4OENIN2ZYZGc1ZzRvdERv?=
 =?utf-8?B?Q2xFcTI1aGVjdExQc1pRdHJ5R2l5SVhkMGZsTmJqSW9YMnNIZG5jMFZUdnhK?=
 =?utf-8?B?RC90enNKSC9ieW1ObjZSWTNlTVlsVCtpU29KeHpFeks5MHdJL280K0JlVkVh?=
 =?utf-8?B?YXUxc0xjdEtaNllFdUw1MUV1RkUxS0FaNVc1YktVN1JVWnRYWWJMbGdySDQ3?=
 =?utf-8?B?b3RpWmk1cFJqRGh4bXBkYm45a0p3ZEFpaVl2cTc1ckNZTVByYk1GbnpvbEVH?=
 =?utf-8?B?SDBhTmhMaXZGaklKTGZwMkRtRFBONjdUVFRNVjZjQ2FlZDBacDEvYnhvK1Ew?=
 =?utf-8?B?Ym9JR09oUWZ4MXFxL2l4b2drY0tScERqU09nYVJuVVY2bW9TZGpBM2VmNUNo?=
 =?utf-8?B?MDN5VHhpb0NxbURXUENBMWdWZTN5VWU4aDZSUmZCT1R3NXZtVVFjMnRpSTRV?=
 =?utf-8?B?dTYzTWMzNGxuL2FFcEtZc3BQUWNZaXExR295Q0ZZdVFxTWRSeDd1NG9xd3l1?=
 =?utf-8?B?cWg1eUdSK1RUV21QQkxzb1RiYkY5RWpVbE5JZ1ZFNFZ0MjBWeGMvN3ZNb0Jk?=
 =?utf-8?B?d1hMS0hhcDBIM1dycTJLM1JINVZDOEhOUWV1UEU1Zm83dk1qOUtLTFhRcHhN?=
 =?utf-8?B?aVFZeSt4RTF6dG05UmQwdDF0Y3F0M1FTbnVUdXNLMUhiTkxNNDVISnA4dERX?=
 =?utf-8?B?RFkrd3JGcFlOb0Q3aXl5K3BsS1lNTU5Ed1pEUC9tWFNYL3BxQ0R3cnhaRGMw?=
 =?utf-8?B?MHBQZFZqUWljcCtQWUFNZTE5d1I5N3lGUHFpYm1RaHdYZVViWHNUUUl3SmIr?=
 =?utf-8?B?cVo5TytybGtsalBKdk1CTE1Kai9PZ3dvWG1lcDQ4ZkFnREdnZUpSMzNkbXJm?=
 =?utf-8?B?emlpL3JJcCtqNzBVUG9SNUhTdlZ3aU1YM2hFSGw4d3E1V3FkNFdjNVRHb2hY?=
 =?utf-8?B?aktDbHhDVm5BQjNyck13dTFhSDRlK2dWV2txQlRKNW80ZTJjcDdIUDNHaW1L?=
 =?utf-8?B?OW9ING9ONEdURW1ETGxMYlV6dldxRnN0VWtOcEJrSEhQeVN1K08yWE9ObHZW?=
 =?utf-8?B?N0pOclNsQVhnaFlmNjFmeUJlemhFK3lJRHdmZmNPR21NZWRoemZuRThaUjY3?=
 =?utf-8?B?M3BhdFY0Y2V1SGsvcFFyZFJQMExwWTQvMU92R2NLVTA2ZW5DOGcvczYrYzV2?=
 =?utf-8?B?eXZIYmxUNHhySENEang5U0c0RnF5b0lxME9iWFJ4WHM3MmlyM2U3dXR3UGI0?=
 =?utf-8?B?SWdWZVFNb1hpc2tRa252dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGc1TmpXc0NyTWVRRUZabHRvZlRvajRXRUNBNWgrN2VGUFJaSFZwZXJiU29M?=
 =?utf-8?B?LzdjdVhib3o4TTdBRmdia3hicExTcUJiTjdMWlZXTUhVNXhrenhya09VcVJj?=
 =?utf-8?B?QTFMdHdwWDRMN3dpMmNqcHdVc1JhV3g0d0ZHRnZiSVV1aGg0dE4wTlBVTzgw?=
 =?utf-8?B?K2tTNjF1eTlvbWJLQ2RJNnVyNS9IU1dpR2d0Y2lIelhNS2l5Q2NHZFYvRkZ0?=
 =?utf-8?B?cEpHV1l2S1ZKY095Q3dpYVRoTjdqTVNGQ3lWQ09UeU5MaVBJL3VEYk9rYXBW?=
 =?utf-8?B?SXloRjJpQzA4NzA3M3E2UDQ4eWcvaTg5MStLOUsyT2o3U3hNNG9nZmRvVGpu?=
 =?utf-8?B?MkVvN2JkMHljNWJmS1ZnMFhEbERpdCtGMFE2aldUN1g5b1FEKzNYb0xFVXNq?=
 =?utf-8?B?YTROc0lFQVhRd2F1Nkp4T0ZjOGVPRTFMUTVUMVI5U2wwL3ViZW4rdHFsUlJI?=
 =?utf-8?B?K0NvVWM2Z3NmWVo5TElIWUlnemwyallFbGd2eTNTdGw0TVdrQjRXOFQyTzhM?=
 =?utf-8?B?N2U5aS9rbDluWU1lTk9EZTV5bnR3Q2lXcVpwTUNFdmJZOVRVR2d0eXdWS2Y2?=
 =?utf-8?B?bWUwaE5BRkxaSGY1WmNaelNSeHlnM0ltR3FGb3lZZXBNcTgxQjROSnBKdGoz?=
 =?utf-8?B?aWo5YUgrSHJsRnNFMGEwK2c4LzZmRzFzMERrbWorUUd1OUIxNCtYa3QyMzVC?=
 =?utf-8?B?aVRJYitjRnZZQ3hOc1BrYzZzVm90SGl2SkF4UmZEZ0JxaENHRzFIODJRS1Iw?=
 =?utf-8?B?eUU0K0NiR1ZyZDJIampPZmNNNUJOKy9WUzZ3clhJUkFadDRKblk2OUNncVd4?=
 =?utf-8?B?L0xiWkZCZ25wcEhjZ2pJc3lhUnFQU1JMcGJpRXNFOVZyQjZuZ1Q1VGtKNlQ2?=
 =?utf-8?B?Q0w2bmtadExmOWdIQWV1bE5TL2UzbjNHbnpIQUhoajdRVlllaU5XTWVkSERZ?=
 =?utf-8?B?akJycm1JSC9RcXQzdFlmbW0yNXZKdGhvVDAvK0dyRVcyU2wxUk1IV2twRjBq?=
 =?utf-8?B?TzU2UzYvb0JUZlpXUW9ncEZoSENac20xZTFRQ2xTZENwdHE5OTV2L2F0QkdN?=
 =?utf-8?B?ZzA0VW5sYzdjMTBIQ2VacDBYWENscXVRWEdIQW1Ic0ozQ2xUSFpPRUhiTnpH?=
 =?utf-8?B?dmwvT2NUaEs0MnArZHc3RG9weGtPNXpNeG9LNWUydmZQRGI5UHZwTk0wcEJE?=
 =?utf-8?B?aDR3akpBV1l2c3JsVi9GTkxDSVQvQUVqSnIxV3ZYSEJ0eWVlanVXU0pWZGxu?=
 =?utf-8?B?bjhYam9TZ2xGbDNaVFFUOHEzdktWQ3BRZm1qV1hRbEVtY09XTC9jUGlmYnY0?=
 =?utf-8?B?U0xOQW5uOCtiWlVjRXY3SUpjMzRyVVZqc3J5bzZYNWs1U2xNQlBSczZ2YTU2?=
 =?utf-8?B?bUljNUxYY2xlOERnakpYR1BUZEd2TDFCUm42N1pxRE5GeG5qVThMZUlqZndw?=
 =?utf-8?B?QStrNDFxREx2V3hteHRJUGh1Sjk3MUx5VEhCbXJ1aFBCdEU4a0VFTGNBZkpD?=
 =?utf-8?B?U0d5RE9vUmtFemlOQnpMaVJvYi9rUEFjVTgxanRFZUhjTWZCZDJKRjVxWkt6?=
 =?utf-8?B?WUp0Q2czeXE3MlRMc09leG9FdlV5RWtoRHlibE0rMVZGbmRkRUxBVUpPeGds?=
 =?utf-8?B?NjA4WFlwaGJXVkxjTEUzZDhnVTRrcEliWldNMDkwNm1Hd0lRYm5xbnRTbGpm?=
 =?utf-8?B?aDEyUGVtRC80UWZpQmNraDJ0MThlZlZ6Vy91T1ExRVlXSktMWHRBQ3k1Vyti?=
 =?utf-8?B?YUQxeWY3TmNTeG5uL1hMRXZzSWpOazM5c0JHRmtoYTRMeTFDOTBjV1F0bnRK?=
 =?utf-8?B?cjc1U1l6TG8zTzEyTWhialVRSWg5WW9Ya2s2RWFXUU55VjZCWkVpOHB3Sk5n?=
 =?utf-8?B?RS9ETnVWbWRvZm5JVWI3T2lLOFFWaEppRTA4eGJrTU9mcGVNL1MwNVZPSjFm?=
 =?utf-8?B?NUUyZGpkeHB2cndrbllPWjhTancyRTlLVk1UUEU5ODdBaENmRzZtY0ZpNHlC?=
 =?utf-8?B?a2tocjBnSlgwNDRaS1hLZ2FHQlNFWFRTeUltZnRZdWlyb0c1ZGdsT1pJKzlj?=
 =?utf-8?B?SjBocGtBaEpGeWJNNXlxMGUxWlJGbCs3UFRCZFBBSWJUYVk2TFFNSVhrWHFy?=
 =?utf-8?B?RlRibkVQNlNFOVpVY1lsb1NmQ2Z5dnN6cDBoWHNnOU5BdHRDSlhaVVRXRGV1?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	izCdzmR5GWQ621jOms/TEJDbmSLXaK21S4wzPYZObFNlh1G2DuwJOBmpr4w6NDHASBQOYsBzwFgDmuUMRn99pfop36ob1IIxjzL2u1AGWxZpU2SFdkiocLCO8+x/Ou22+Xx13OHF8V1mM7aLT/zJSk6TgZzoQmo0wxTWCevnNK868DswgsEaD4MTnCccQhEhqlLwmiC88eQ7lNlqK2sjpRD/M9oTAAxzWUuihfQSwPlKgIgmRSD8/dvDjT5qqH4C5cE/XssetFD0+G0uwPgqZJ3i3SiP3TEnCX1ET2nBOP/EGFcxSNxro++VHonYIXpfIo7/GJdfMuvoKSxB0W1Ms8GRi779ld/msauzKpN2aM6RzyWYAxhn/NunXsRhFq8F3HOzHxsnJ1C+i87H/7gUks4JlpuRvLdFRUyHUdslI84ngEo88/+KzKZz4fyk8kGDNlgmH1mkyBLLd+BG0k6m+XXHs7HWqw8rgnHhdZuqmzG1mafo8XmppyFjlVmIPco9Fqwt+PzvSai441Qz861u97B/qwHIIocYlutg9MmxdCaRUYXEW3WtwL2gULyBYIJRtV6+ajlSr+S2L4WbXtJrqvk/QMqpcrixwfGhiDlYn1E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382cb9d9-5af2-4e38-f4a3-08dcc79e1372
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:14:52.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvIE3zmAQIFaurCCGyAkl56RUBSd1xXJ6vgY+OWAqNrpUGRz1pKV8OhJSneSpEmwkVufj4rRPYRgVwuuZcd8FAZPYK+yGxLV/iK3eN1A4oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280146
X-Proofpoint-ORIG-GUID: T2Y0OfwG0i4dmRrj9dgEUWi9uBvESos8
X-Proofpoint-GUID: T2Y0OfwG0i4dmRrj9dgEUWi9uBvESos8

On 8/27/24 11:14 AM, 'Eric Biggers' via trenchboot-devel wrote:
> On Thu, May 30, 2024 at 07:16:56PM -0700, Eric Biggers wrote:
>> On Thu, May 30, 2024 at 06:03:18PM -0700, Ross Philipson wrote:
>>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>>
>>> For better or worse, Secure Launch needs SHA-1 and SHA-256. The
>>> choice of hashes used lie with the platform firmware, not with
>>> software, and is often outside of the users control.
>>>
>>> Even if we'd prefer to use SHA-256-only, if firmware elected to start us
>>> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
>>> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
>>> to safely use SHA-256 for everything else.
>>>
>>> The SHA-1 code here has its origins in the code from the main kernel:
>>>
>>> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
>>>
>>> A modified version of this code was introduced to the lib/crypto/sha1.c
>>> to bring it in line with the SHA-256 code and allow it to be pulled into the
>>> setup kernel in the same manner as SHA-256 is.
>>>
>>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>
>> Thanks.  This explanation doesn't seem to have made it into the actual code or
>> documentation.  Can you please get it into a more permanent location?
> 
> I see that a new version of the patchset was sent out but this suggestion was
> not taken.  Are you planning to address it?

Sorry we sort of overlooked that part of the request. We will take the 
latest commit message, clean it up a little and put it in 
boot/compressed/sha1.c file as a comment. I believe that is what you 
would like us to do.

Thanks
Ross

> 
> - Eric
> 


