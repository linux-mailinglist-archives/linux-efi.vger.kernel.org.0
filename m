Return-Path: <linux-efi+bounces-1150-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2558FBDB8
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 23:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D461F2323A
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 21:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9039E14291B;
	Tue,  4 Jun 2024 21:03:37 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD84140375;
	Tue,  4 Jun 2024 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535017; cv=fail; b=jzQ/+8ThX5fom+m7S5FJ18qkb4aLI5VilMFV0CCKCB9SdSkzGiHyb7FUJNisoTZ5TU1pdDSDLCWzQrfsCQ6tunpDhc5Eyi3gwjW7O/W4EldWIwLkys1yJyMj6xhYAEsfNpYhmlXavjxCBwXWxoN/ezJ8pnLUPJf+s2luYAZuXtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535017; c=relaxed/simple;
	bh=q7e5kXHWtKtlgglSBsXGZ7gy/oFdM5enn9PFd+AQ2UI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uM2MtJvQhy6pBuZBKBixlJmZkRDkG1lglH9dgDz9ir6RYoVzY3pMgj+0fqCsah1b1xljZWSW3Ikghq7hfKx6F1Ic5m7iliv+jR0iLSHU+648ZgwrjdN8+kK+rNa2FUqvFX1s2ParAIqajBP0rvKzAgOW9SbhCVEMzUVcJlSUkrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454JYqtA027777;
	Tue, 4 Jun 2024 21:03:00 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Dgq2RqRj6QYVnN/86+DJf/HnKi+Uo2+DvS7LECwLjI48=3D;_b?=
 =?UTF-8?Q?=3DAOAStYwU/mCHbWoZIIasupouK/+1+srsd1HsdgBnbSMycj+1IGU+uUeuDCnX?=
 =?UTF-8?Q?gwTC6BuG_dRbARdk6UvF7uueElCbrYiw2iBFNjd9yvthjLkSaLA1gk7isZCmewE?=
 =?UTF-8?Q?Hg3SseVEiTYhgD_Hjg5N/5kDZiWexmGpnTzLo8xe0rxLy5OhvNaw3JefWeuQmXV?=
 =?UTF-8?Q?dGq67ro0CYfJt6BgFpjj_guLIKQes2WaWLPLI3B1/KR0gwpjJJ0/ydbO7kG3ZCx?=
 =?UTF-8?Q?AlOF82p665BWQW7H0qtsm61PX7_33xGC7UcxgrjQrV2jiqZ1JXXJMAKj3dpzMRn?=
 =?UTF-8?Q?YKtgOFqNdZuxyA4r2nSeFn14PGvyfwDE_8Q=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv07wxft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 21:02:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454L1KnD023917;
	Tue, 4 Jun 2024 21:02:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrqxd1gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 21:02:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n43b9qc74LZN6MYLUe5KLsdH6t25Hp5K/v70o8tCBLACF0LM33Tnoc/xTnhR0ldlhZorS5paKzj40lETCNTllaW+Gxuam1DVBK5T6Gu/QWxVgegcEzuYCOvbBlCwcDIGZ1l6qn27lVhgyRH49pPX/vTQSFqDmMAnFnzEd/usnG65gq7h22I0c2QIBP9M0Wwj8IbX/v3FVMAcJ3kssOeeT/eoEtUe0uRZNguJTz6i7M4jDpiT5pd1mbgzAPrA4450sk/mMRKlp901jOwIBUzgp3OBcvJ6a6UKi4Y6/F9DcBFFWR3GDK960rFjdH6nS8vBUdOrcZXgnfLskxYtHt0ndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq2RqRj6QYVnN/86+DJf/HnKi+Uo2+DvS7LECwLjI48=;
 b=XyMzHCC8wedgNjQUBmmPVXQVAjdyHuVbqN9kFZxu74JO3/vdmuIOaSh5as0D/vda7HvqbI6KQCl7rDIDXrgdysKuab3Vh7n3+z1sPoAkt8KxC+HDB+rXVz+bB1M5FWw0KWabDCgeBksNu4wLLXxhEL0ia8N10m2g02QKBs8VxZqf/+xpsrU3eCD+3LYw1ctx629g2dyoyVzFFEfbSXf2PxhEZN+0gpE/G05VuWhmYW1riR+IARoHYt7aJTVVaAnjU0ow7NjRAUPBk++Df10NDKM0ZIO30tHk4t+mttvqpmXBz09rCEj1LNG9J5ZX2Xl2RAUwJJLm/yIIye01ViGmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq2RqRj6QYVnN/86+DJf/HnKi+Uo2+DvS7LECwLjI48=;
 b=MyF7s/PD+kNgmUTfjjnXTn9AfHqRtjl1B+XXViBSJ+NewgRJMbKQ3+PJkufvla4TSkMUpeIp6SH7X36WP8wSzTiEkSxDXejqMZYLANmhsjTScV1WryoX1y2B1SZU3dfhliOmEkoVevqVqVRpjG7RNxqHMHxNVr9j4jj9sBRZLt8=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 IA1PR10MB7114.namprd10.prod.outlook.com (2603:10b6:208:3fd::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Tue, 4 Jun 2024 21:02:52 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 21:02:51 +0000
Message-ID: <0ed3cdf6-2e4a-41f2-b2f6-363899405298@oracle.com>
Date: Tue, 4 Jun 2024 14:02:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com, ross.philipson@oracle.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <D1RGK44SJ477.3BQ82NMUKH2Z8@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1RGK44SJ477.3BQ82NMUKH2Z8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|IA1PR10MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: b07254d7-c27f-4942-8b9c-08dc84d9b254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RnRnRFpFa3oyVkZlN3lRVWNhVkh6SE9iaVBJQW96OXlMOVBtYzZScUswY3dV?=
 =?utf-8?B?NjNBRkpwOWw5Z0RhZEUrR2F1MUErMjhzeDJqYThoZURmNUZubTNjaXVnOWls?=
 =?utf-8?B?bEdhVVdvU2NuMG1JL0h6NjFGRE5HemFIVTRVT3Z0Mmx5Qyt6Q2ZvYTRyemhm?=
 =?utf-8?B?eVBrcWc0a1ZGODU1N0MwYU5HZHVCTGwvMmQzaHBLSTZZeHhCdDNBbFNPTlJS?=
 =?utf-8?B?MHZjS0RlSE94UlJCeHNKSmR1Z0cvSHg0WVBtNzJNQ0FkV1FsMG1TT0xjVDF1?=
 =?utf-8?B?aFNTS1NYOVlHbjFkajByOGtHYUlqenJFTDdTd3hUM2ZjbTdTQlNSRFU5R2ty?=
 =?utf-8?B?OVZ5NjhzMTBCeXJ0V0pvOEEwMUN1YkM3TWx1c2cwK2ovNFMzNGVJd1VMUktP?=
 =?utf-8?B?bVJjZmxBeXpZNlQybFB5alpmdVc1SkZuOEdGNWJiRWxzUEIycmx5YmdmcVFN?=
 =?utf-8?B?UGZOcVFyM1JLTzF0d3p5cHorRWVONVYwWFBZVjdMbFRKNnVac3F1SjFQeno4?=
 =?utf-8?B?M2thTzlCSzJ1enFGTnBnVW1SZ056WGY1SitXckRXL2tlS1BDWmNEOUhzNlo1?=
 =?utf-8?B?SkJoYkZrc2l6T1dDbWRsZFBRTS9oMWU1OVNoK2ZNdnJONHNnR1czRVB2RmVJ?=
 =?utf-8?B?emlPNkhEUVZBb25CRzVNc2xrdExzd2RWaCtzbDB0bHdSTTRST04zUElQSFp5?=
 =?utf-8?B?VkZQbzNBV091Qk85VXU2WG5QQWx5elRBZzNSb2daZnhVelJ5dFl6bUdaWDFY?=
 =?utf-8?B?NlJlTGFMOVo5OTlBYWVSbmFHSjlGYm4vNXpOT0dEblRacTZ4VmtLZGFCQWVH?=
 =?utf-8?B?RjFqN203WjI4b0I5cmVGbnpUT0xaYjNYNWU2VjZQWWJXVXA2bEEzUjB5V0t2?=
 =?utf-8?B?b1hla3dmQlJrcW9sbUdkVHVJMHVVR1ZiK3J6VGxrWkRPSzFwRmpZRDQ0NGZJ?=
 =?utf-8?B?VWtaUE02b1Z4R1BIR2JRaThTcGFYVXIxTDcvd3dBY24wKzdLRVhhYXc1WGFP?=
 =?utf-8?B?NXlnMFVKMmI5NThJVnhlTEV3ak5wNTlNS3h4UUhYb2F2amxobStPb3hQZkx1?=
 =?utf-8?B?ZHNJZjlXZUloU3A3Szc3aGdBVGY5Q2VORTRYeGkxUHJsOUwvWHlzYTNPclQw?=
 =?utf-8?B?OXphYjdUcVNkYWxQeERPUnJxL0VKTzRNWFkvczdocEdrSU5QS2MzcVFRbGs1?=
 =?utf-8?B?Q3dhb0ZYbmpZYnJGeFo3OU9NanJIRUorR1RURXFLZGIwaHA1Rm9pdHNkM3hU?=
 =?utf-8?B?eVAvVmVDRTFqdjB3MkliUGVZdU1GVmFQaStORVZrUDFlVXVBd1ZGbEllQkli?=
 =?utf-8?B?WHFzK3ZHd1VvY1hNZ1ZHMVJ3UGk1cndvTUUvS1Z4dWpqUm9yMC9UOUdtWEhw?=
 =?utf-8?B?UlNEcFlaVFdJMXJXbWszY1F2ZVdPbzZxTHo1U1hMVHptRXcyNFJvUGZlZ2lI?=
 =?utf-8?B?eEdwSGdQZE5yeVRMRi85U0JVWGZOTDFlOS83MjFpbXpZaWRmWE0zTW9JUERn?=
 =?utf-8?B?aERPNDd4ckhjdGViQXNid1BqQWZEQ2ZNbWxML1FBTmNHb29oYUxIdGJaUkxq?=
 =?utf-8?B?QUZJaTBLZHJRb0JDVnRqNUx6eDNNcnVQRmVZRHhSNlRFVEtYcEVxWTlQWjRi?=
 =?utf-8?B?N0l5cUxVQVRSQzBqUmVJZjd4ek5oVU1henk1RGlhbVFaTmpNbGpNZTVaejlW?=
 =?utf-8?B?OTVTazZEdWlDS2RNRW5JQTVpQi8zZzNleENpdjhFL3loQzRnKzh1aTBlSGNK?=
 =?utf-8?Q?/IMMAAHuoOIhEOe+B+nXQaaih4ewycWeT9A1K70?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aytJUnU2M0NxZTFHWVE4eHpVZ2dtSVlaVHpnS25adzRpbGFKNEhRSGxUQURy?=
 =?utf-8?B?WEFsQmhQbmxBN1ppYnNCVlc5RFdENmlYM1draFlKeXpVcFoxVk05ZlJvYytS?=
 =?utf-8?B?L0JuTjRXTmt4ckk1SVRWbkJoY2JKd3d4ZE9uSnU3eVk3eU0wejQ5SFZjdFhm?=
 =?utf-8?B?VUpPQmdINzNscGhqdkF1L1E2cUM3aGFadEN0ODJ0QXRtRkpoT1daN04rL2tn?=
 =?utf-8?B?L1hQYjZTWUNwSDMrMFhFVlRrL3FTTWxRaUxOdE1lbGdidkx0eS9DanMwYkpV?=
 =?utf-8?B?bGhWR2ozcEdPbUxteDBEcTdjV2ZBdjJuQTdHODNJK0hONklMaFJWOWNzOUdo?=
 =?utf-8?B?UUlLYklYS2tFQjEzdHNBZldaazZjUTNIMXRTSzU1aGlZWEJXYWxnSEtsZG1k?=
 =?utf-8?B?ditSaWhaVm55S3NRMi9jMjVwVWRWbktoOS8vcTIvUEVIWjlCVHZlZVVWKzcw?=
 =?utf-8?B?eDF1U2MwbUwwL3lCblhLQU9OZEZFV1RjMFlMMWJyZmhkR0pxZ3FReUIvMHF0?=
 =?utf-8?B?NHBkSlA5Wm5lZXNMWDNPWlh3V2lHWU1JaXZ1OEZiLzJjd2ZBOTJ6NjBGcTNw?=
 =?utf-8?B?cVVmL1BLVXdicTZ0N21TZlNwalB6eUlNZ25aZ0tHZ2swbFJsd2tkcVJQcmwv?=
 =?utf-8?B?UkFxWTJPaHh5TEM0eVJ6SXBsRWxKc21yU3hjcm5jd01TY3hYR3JkL0xoUjhp?=
 =?utf-8?B?WGxnSnluMVVUbHlYNUl4WDZDSzNGMTk2c1ZsNWt6ditSaHZNL0Qxa3JZaUd0?=
 =?utf-8?B?eU04U3h0ckp2a0RsNEc5Z1JNek04OXZUUnlSOEVKYXFSVEpzME1QdDNiS25k?=
 =?utf-8?B?UlBVMmEvRDdxckt3Y0hrWk0wSkNyMFFnck5DaUpFdjB6dVk1TlpURkZnTFFH?=
 =?utf-8?B?RTI1cjJ5a1pMbzNKL2M2UjB6alVtejIwVFJFZXloOE9OWnBXUXBEZDFKRXhU?=
 =?utf-8?B?TVZxUkRYYTlwQTgxR3ovMGtmQytYL295VlRiZHVtSWN2NEw4WlViV1hYZ2c5?=
 =?utf-8?B?TmJydU9keFZaRWtmMkFvOWdPSG1BbUZZTnFyRTFhSzB5aVdsNzdFSlhMalpm?=
 =?utf-8?B?dy8reE00UjNSS3ZLTXlUTVQxZG95NFl0dWNzaWI4YytjU0xJbytCOU05TGlu?=
 =?utf-8?B?aEV1YmVCVDFWeDhCL04rT0RQTGVBZnVNcUF2TnlFQmlmVGdSV1llUEtEQVVF?=
 =?utf-8?B?bTlYVkIvRktHaTBFaTFON1gxQ2lnOTJHZ1VIclFRdUpxVVZRVDJ2ZG1uSUI4?=
 =?utf-8?B?NThhbitWaFhSdytLVDQwT1BVUWZGeE41T2pKbnJNVW9peHk0Tnk3bmZFblZZ?=
 =?utf-8?B?eHBpYmdUZ2Q2N3RtWm9hZHRLTW9qb3NkNTZvQjJiazZ3VkJaVldwWlQ3YmpH?=
 =?utf-8?B?d2VWbUFHcFo5bkFsU3p2QStFa1dCV1JkbVdhVzJNYldyaFZIOFVUWEpOVy85?=
 =?utf-8?B?aVVXbElDei9tTmcxTjBKTTVLQU5JMmhUYWpXS1U0R1oxRVFSMDlQYzBLa05q?=
 =?utf-8?B?QWdnTlpleXM2L25zSVBqK3hzeFEybmUwU1IyUUJjZ2doTFRreklLQWdPdzdQ?=
 =?utf-8?B?SEVQWTNVcCtrdCtWY0Jab0R0NFFjN2NCVHkrMGREYWFlWnZqcHZuek5DWWVO?=
 =?utf-8?B?VTREdkhNNnNET0dkNjRTU2VtR25QcTZGZmYwWnRqZFhNN1REZmlmVlloSStS?=
 =?utf-8?B?cTRCUGtDY1E0U3BaOXJpamJvcHJ3ci9laG9sa3FrWnFLMXlwOVNyY0FEdmYx?=
 =?utf-8?B?L0MyNG9MazN3ZTNPb3g3SGRGU2RGL3poSmFYMXdZb0hEbGhadlBkYmJaK0lZ?=
 =?utf-8?B?SkpYSXd2c0F5ZGNjVkNtUnB6aXNrWnpUcTlKd0NLVTluRGxOOXU2bDdidEg2?=
 =?utf-8?B?b2xWS2lSbzR5NytPUndlVHM4K0VjNUdweE9CVGRhMTdJYjdPdEJmZlpONDZO?=
 =?utf-8?B?cklrUDVoWFh6SHpybzUzWnlYeE9jWlJSMjFXMXJ5YnZUbjRWU0k3emx4eGVB?=
 =?utf-8?B?SHJwelc0STFzNmVqaHg0QVNaS2E0bmptNXhmY2N6SGg5eTB3U2IrUDQvMlhk?=
 =?utf-8?B?ajY5L2pZZEUxa0NiTm5nUGFsVHVWeC90YnF6WC9BdXRXbUFLb29nZVAvbVd5?=
 =?utf-8?B?Ky9mYjJJNENrQVdzWU9GcEtWdHROaStRMmRRRncvTjlzUkJxajBFQXJlS0V2?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+TzPfsyOhWhHEVz/fLQ8gyrKEzmaZd8PlU/V24BUZdz6QIkLaJLJJoZif7/KLexA02VlE05y61zq6O9TTLOfB3hETS/xhrIXHMW5VjrRZe5OxUgEEJHx2CVCZvxRYC9g+5gffBYACXLrQ+1JbpVkSjDbubzmYZhjEgPO8+MPFIbXv7gwZVzutQ3Lh4uWlnS/Gs/YuTMLnm6EKpoTkx1z56bi2hePfV526beOqL5/fXYVkmn+MPek3OzTvG9ZyT7c0HA1SO4BuTwYEeHmm0MgQKANJkvL+/CYqNJMnwWUnJX0Dsx7lGdbiRMSYvNW7/AgLPQ4ytaBy3oaVexg0y1lWXFbL4OE0r4q3iplJSrwiQmNcyl8X5d6F6TQXSqxylb6AQPzckW2UdEfgGn+GjSp+Px5NF6LDKX+W/rkKxMeAreZPoplzHx7bXDwMJBDj0L1nFF0djvyBzd91gs8suwFF13ezC4Qya1hTMHvxKit/2mgVhaCKA02PAMlat9UMmAQfH2Ee1CfkGcO4o/LGzkfjhHs+iiNwS/XQWAuHANfuMIyuRPJIjB3rVHYNZMB28rOPqodZ58TLCTF0LXaTCQYLpAhBW1AVw5eHHvqt8OiUAs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07254d7-c27f-4942-8b9c-08dc84d9b254
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 21:02:51.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xV6dn7NP50yxJ83a+/UfhhZQNCY35z71UXfXXY0rrguRwIAyvKZ3TIGQ5TjC7RE1cLDLIa6mwdiEMS2hI+xLV0akBX+ySRFCiG8j+re+4DM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7114
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040169
X-Proofpoint-GUID: hgQOLCd6slkk7nq_MEoRlFtYgpJs0ZNZ
X-Proofpoint-ORIG-GUID: hgQOLCd6slkk7nq_MEoRlFtYgpJs0ZNZ

On 6/4/24 11:52 AM, Jarkko Sakkinen wrote:
> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> For better or worse, Secure Launch needs SHA-1 and SHA-256. The
>> choice of hashes used lie with the platform firmware, not with
>> software, and is often outside of the users control.
>>
>> Even if we'd prefer to use SHA-256-only, if firmware elected to start us
>> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
>> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
>> to safely use SHA-256 for everything else.
>>
>> The SHA-1 code here has its origins in the code from the main kernel:
>>
>> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
>>
>> A modified version of this code was introduced to the lib/crypto/sha1.c
>> to bring it in line with the SHA-256 code and allow it to be pulled into the
>> setup kernel in the same manner as SHA-256 is.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   arch/x86/boot/compressed/Makefile     |  2 +
>>   arch/x86/boot/compressed/early_sha1.c | 12 ++++
>>   include/crypto/sha1.h                 |  1 +
>>   lib/crypto/sha1.c                     | 81 +++++++++++++++++++++++++++
>>   4 files changed, 96 insertions(+)
>>   create mode 100644 arch/x86/boot/compressed/early_sha1.c
>>
>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>> index e9522c6893be..3307ebef4e1b 100644
>> --- a/arch/x86/boot/compressed/Makefile
>> +++ b/arch/x86/boot/compressed/Makefile
>> @@ -118,6 +118,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>>   vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>>   vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>>   
>> +vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o
>> +
>>   $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>>   	$(call if_changed,ld)
>>   
>> diff --git a/arch/x86/boot/compressed/early_sha1.c b/arch/x86/boot/compressed/early_sha1.c
>> new file mode 100644
>> index 000000000000..8a9b904a73ab
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/early_sha1.c
>> @@ -0,0 +1,12 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2024 Apertus Solutions, LLC.
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/linkage.h>
>> +#include <linux/string.h>
>> +#include <asm/boot.h>
>> +#include <asm/unaligned.h>
>> +
>> +#include "../../../../lib/crypto/sha1.c"
> }
> 
> Yep, make sense. Thinking only that should this be just sha1.c.
> 
> Comparing this to mainly drivers/firmware/efi/tpm.c, which is not
> early_tpm.c where the early actually probably would make more sense
> than here. Here sha1 primitive is just needed.
> 
> This is definitely a nitpick but why carry a prefix that is not
> that useful, right?

I am not 100% sure what you mean here, sorry. Could you clarify about 
the prefix? Do you mean why did we choose early_*? There was precedent 
for doing that like early_serial_console.c.

> 
>> diff --git a/include/crypto/sha1.h b/include/crypto/sha1.h
>> index 044ecea60ac8..d715dd5332e1 100644
>> --- a/include/crypto/sha1.h
>> +++ b/include/crypto/sha1.h
>> @@ -42,5 +42,6 @@ extern int crypto_sha1_finup(struct shash_desc *desc, const u8 *data,
>>   #define SHA1_WORKSPACE_WORDS	16
>>   void sha1_init(__u32 *buf);
>>   void sha1_transform(__u32 *digest, const char *data, __u32 *W);
>> +void sha1(const u8 *data, unsigned int len, u8 *out);
>>   
>>   #endif /* _CRYPTO_SHA1_H */
>> diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
>> index 1aebe7be9401..10152125b338 100644
>> --- a/lib/crypto/sha1.c
>> +++ b/lib/crypto/sha1.c
>> @@ -137,4 +137,85 @@ void sha1_init(__u32 *buf)
>>   }
>>   EXPORT_SYMBOL(sha1_init);
>>   
>> +static void __sha1_transform(u32 *digest, const char *data)
>> +{
>> +       u32 ws[SHA1_WORKSPACE_WORDS];
>> +
>> +       sha1_transform(digest, data, ws);
>> +
>> +       memzero_explicit(ws, sizeof(ws));
> 
> For the sake of future reference I'd carry always some inline comment
> with any memzero_explicit() call site.

We can do that.

> 
>> +}
>> +
>> +static void sha1_update(struct sha1_state *sctx, const u8 *data, unsigned int len)
>> +{
>> +	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
>> +
>> +	sctx->count += len;
>> +
>> +	if (likely((partial + len) >= SHA1_BLOCK_SIZE)) {
> 
> 
> 	if (unlikely((partial + len) < SHA1_BLOCK_SIZE))
> 		goto out;
> 
> ?

We could do it that way. I guess it would cut down in indenting. I defer 
to Daniel Smith on this...

> 
>> +		int blocks;
>> +
>> +		if (partial) {
>> +			int p = SHA1_BLOCK_SIZE - partial;
>> +
>> +			memcpy(sctx->buffer + partial, data, p);
>> +			data += p;
>> +			len -= p;
>> +
>> +			__sha1_transform(sctx->state, sctx->buffer);
>> +		}
>> +
>> +		blocks = len / SHA1_BLOCK_SIZE;
>> +		len %= SHA1_BLOCK_SIZE;
>> +
>> +		if (blocks) {
>> +			while (blocks--) {
>> +				__sha1_transform(sctx->state, data);
>> +				data += SHA1_BLOCK_SIZE;
>> +			}
>> +		}
>> +		partial = 0;
>> +	}
>> +
> 
> out:
> 
>> +	if (len)
>> +		memcpy(sctx->buffer + partial, data, len);
> 
> Why not just memcpy() unconditionally?
> 

... and this.

>> +}
>> +
>> +static void sha1_final(struct sha1_state *sctx, u8 *out)
>> +{
>> +	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
>> +	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
>> +	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
>> +	__be32 *digest = (__be32 *)out;
>> +	int i;
>> +
>> +	sctx->buffer[partial++] = 0x80;
>> +	if (partial > bit_offset) {
>> +		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
>> +		partial = 0;
>> +
>> +		__sha1_transform(sctx->state, sctx->buffer);
>> +	}
>> +
>> +	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
>> +	*bits = cpu_to_be64(sctx->count << 3);
>> +	__sha1_transform(sctx->state, sctx->buffer);
>> +
>> +	for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
>> +		put_unaligned_be32(sctx->state[i], digest++);
>> +
>> +	*sctx = (struct sha1_state){};
>> +}
>> +
>> +void sha1(const u8 *data, unsigned int len, u8 *out)
>> +{
>> +	struct sha1_state sctx = {0};
>> +
>> +	sha1_init(sctx.state);
>> +	sctx.count = 0;
> 
> Hmm... so shouldn't C99 take care of this given the initialization
> above? I'm not 100% sure here. I.e. given "= {0}", shouldn't this
> already be zero?

Yes it seems so. We will look at changing that.

> 
>> +	sha1_update(&sctx, data, len);
>> +	sha1_final(&sctx, out);
>> +}
>> +EXPORT_SYMBOL(sha1);
>> +
>>   MODULE_LICENSE("GPL");
> 
> BR, Jarkko

Thanks
Ross

