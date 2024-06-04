Return-Path: <linux-efi+bounces-1166-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876738FBF8D
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 01:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399F5288D45
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 23:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B9914D28B;
	Tue,  4 Jun 2024 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z/+92Bs5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uAwf8yOl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9940013A41A;
	Tue,  4 Jun 2024 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542327; cv=fail; b=SRJJNO2tuGGvbyu3zNT9ltqGZ1dlc8jdOTldnjBzS7/R/nLabfzz9obiRsCMj1eGz0In2B0TUgTW+xuVxs31Htqh4TfwEKrRvPi2/MYrt24JfVwKw7T4ZQoitLoUA8RrBokgdPwQVFg20FtuCTsxFZMV0GiQ79IZk+OCiyE8xeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542327; c=relaxed/simple;
	bh=W39bgIrmo+TCdnlj61X88fEKsZEJnCn8Xo6UTN4HYR8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H2gVcS3567JDuy6aXj7Du/PAxUW66gZeVtUE4Y1IouYRx2jaEO7W/WnUjp2wFTm8CYMGQO/4tf2gA25Dnd8rym1+z+3oLQPdT9bTpIQYG4yt1nQUbvvG914iGFIGFzyp1TjO4vJZR6uM1aWLvk1lowWwAhOj0qv55x0nfq+GgvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z/+92Bs5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uAwf8yOl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454MUsFm001570;
	Tue, 4 Jun 2024 23:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=fZQfe0sFDinsh7CjnOBrIRvmFM4XchX5Yn8x9+2dxFE=;
 b=Z/+92Bs5F35BxGGDkCZInGS1SdK0bkHqT5vIeUpu6RQpxqAuawpsRkYgeLyqbZjI8IzW
 R/DTeULd9ZdrGk09Etn8q9fVIpOJXbyhwwelXxKALjqmuhB2X0TP8mNOXjbuI9OIAU82
 5wCyb85r/WNLMItvCsydOLHSu4U/+vY59Z+H4y/06Eo2rvAU6EXA28p2P8NhJIjuFyCU
 wa/KeZLfBdw/w3C25LMQ3a8FpME3OMMu660RxZtLaLgQLLxaE/pqZ+9Mf85/MQFoYokp
 Q6FpWFXYerhn3ib10vZGRCMoJnmSRBBZT9mK64EjsYcGgei0gnSYn0us0NThVi4fvwpj 2g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsq00y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 23:04:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454LY6gK016141;
	Tue, 4 Jun 2024 23:04:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsas0fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 23:04:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/dS4NuuidWTvAbxcazJwJXaS1uCrUfErWMAABGAG/6FHIMKOCu9Kes3a1M1PK4I36p8LpYYvFhi0h7vQCPPBZ0K/l0jmoIfuXQ35znEUuMILYLDQzR8DRFT3N/WYwPoc13GQhgPJIiAWns4WR7NYUHJFHuMGNa8kYRDYxcVZXX7LFoTcaEVCfOfrnTP3CbNmzB7qNW3RBcYN/gC2Abqknv0ooSumVu/SnUyQyakxt7OdC2AAK45JKx6/Bbmsu1xZmPAeXCeHKomhuewOCiM7UFY/hpgi0myLhG4lFaZDrdSfiatNEcae4tVnly96QJ6U1WNtBBOmbwqQVw1q0Yp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZQfe0sFDinsh7CjnOBrIRvmFM4XchX5Yn8x9+2dxFE=;
 b=nuca7e9l/UpbuL8QXjflSOplM6KvMeHw2xxL7uQso7IguZS/wdLIAm/UwN4935PJ9HPKGNEWNmr0G1H7d+6mECLuDr8R4paFZstvVquAuEPmia68aYS9NQXeGCEGXPThYx1iAXz0JnPJrxQUz3+ngqizZs1Di1v/p3Oj3c5AHFklUD4Lonh+tkr0Y6GTxW+4Q9Ebao7Dw/wYzAHHFLQK4HLe+ybwSGF2qmGhnUZsLyyXzccSjxVTF64cW2Azvwbps72qLlb4WHMWNrdYPAdeVg8KSozEFU6UhTk/D4os8eTNpp5I8Pt4EYWAeoxUNafZT5X8tXZj1/T2X73LKK4QwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZQfe0sFDinsh7CjnOBrIRvmFM4XchX5Yn8x9+2dxFE=;
 b=uAwf8yOlthL+985ayVgtSvYV1uqaN+ph80kp4CMy+jk/qE09xmRWy6vogt4qw5Fo8/ITb1D/9zknDDLU81pKtoPLsVQIhOdjodiXOZm/VPMOprKR5jNa59WQcILWELUigJzJQ0bYuSOpNJM3e7LZ1Uf/WeHGo1zpvYxFV5N3/JA=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 BLAPR10MB4833.namprd10.prod.outlook.com (2603:10b6:208:333::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 23:04:30 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 23:04:30 +0000
Message-ID: <f9cd1025-700d-423f-a5c2-182d625b3440@oracle.com>
Date: Tue, 4 Jun 2024 16:04:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/19] tpm: Add ability to set the preferred locality
 the TPM chip uses
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
 <20240531010331.134441-17-ross.philipson@oracle.com>
 <D1RIKP548WG9.Q5MM7K3FRH4P@kernel.org>
 <282fddde-d156-4bd3-906b-0318d0a3746d@oracle.com>
 <D1RLMF7VZ0BQ.1Y0SVHN39UQNN@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1RLMF7VZ0BQ.1Y0SVHN39UQNN@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::28) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|BLAPR10MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: a329e3ac-33b4-4d66-c77d-08dc84eab077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d3hMSlQ2Vlp2NHJ6YjRPbjg4Q0c2MXd6ZEVhMUljRDRFWi9xNTdCUFdRdUpn?=
 =?utf-8?B?VzFYUEFrWlhEZkNxVzByQTRtMVlRTkNJem9pT0J1QmJueU1rNWpIcExRZDhC?=
 =?utf-8?B?VU1vSFVSWmU2dFFoMTBRVDZuTnF2cVBVb3QvWGhnUjgxTENHMDhxc3B6SDh0?=
 =?utf-8?B?OW1MN2Y4VTc4Z0pJdjRockFoRlRMZUhQTzFSek5td2ZoQmFDMFUyM2xoWlBK?=
 =?utf-8?B?Q0xJZUhHdVFRTXd2RXUxNUNvYjBHU1lSMENSQ0dsMkQ3SzdMaG04Q2FNQjVm?=
 =?utf-8?B?RERCSzBUeTFzWXJibS80SHV4UWRNNjJMM0Yzd2lCQitaTkNWNzVYZThMS2lV?=
 =?utf-8?B?cHRxaTREemJjNTRvbDFzNnk0Q0RyMVQ1K1hVRE9aNFFlMk9ZS3FMVVRDNVgv?=
 =?utf-8?B?c1JzWmIrdlB4NDB2NkJMVm4yZm5ja3BzK2hxVnBxUFJvNTUzSTRjSGFRNWVa?=
 =?utf-8?B?MlhGRE53TTJWbDB4ek4rT2YyRzNDTjBhZjAyMDRxcHJLcVZjZnVmVFVHVFl1?=
 =?utf-8?B?N1EyMkorSFhpOHVDMGZhOUlpOTlxajhBVVFGTUZyN01TTnRpc1o3UkFtYlE2?=
 =?utf-8?B?bjJoU3RWbi9nRkxiTG9nU203ekZFOE1yZ04xWGJOMGlYNGxnRC90YmdLcEF6?=
 =?utf-8?B?cG1pKytOSjJjRHhKaDZKVXNXUGlDSTNJSStoWldaYmtTYU53T1VjSTRWaGlv?=
 =?utf-8?B?Q0tBUi91TTZGMFdST2E0YTBpRTI0UjZaWi9JQVpMNGtKWVAxb1B4Rnk1OHFL?=
 =?utf-8?B?Tm1sWVdsSjhNd2xLQ1oxZEc3dHFJL3Z0SWdJako3T2dUeVlTbEc5M241RHV1?=
 =?utf-8?B?STdSdzlsL0dadklkR1dnejZ5cHdaMnhwSE1IMHlwR21TcnNhdVRkeitjOFhP?=
 =?utf-8?B?VjUvZDcrNWtxdkhLcFEvbEdMWkdzbzBLck56c0FWaXBsVHpmajJ1VEprQ2RO?=
 =?utf-8?B?SFJoZTI0STBPODRJTXVkdVF6UU9OV0RvTUxFREhBZDU1NmtKc1h4L0s3R3g5?=
 =?utf-8?B?bzdMczdLZGVVYlkrZGJGUnIwcVlkWWJIMExJN3VZQ3FORVdubSt3V3RBSXRp?=
 =?utf-8?B?T3R0WXp6ZEpKTXVKOVJ0T1J2OVhHdmRnNzZzRkUyRzJPanczd3dHUzJLRWp6?=
 =?utf-8?B?U2k5SWpkRC9XaHNGanphZThxbW1Ialk0VTl4dXozczB4NVFRTjk3bWkwSXIr?=
 =?utf-8?B?YTRpdGZub2pubjFLc0F0Wi9BNVI1R2FSSGN6QXkvcmtwQXRlQUorbXovMCs4?=
 =?utf-8?B?QjV0VEZlc1hrT3NUN01pS3VtYlF1M29PcElidUZDMzVyS3prR3lLY25lR2tL?=
 =?utf-8?B?OThTTmt1SEJwNnBLenhaTjJWRVVTYUI2dllTTGJzelJOUzZwRGhyMHNndld5?=
 =?utf-8?B?bTZHbDg0Vjg3MzRPYUZSK0ZINkJJTm5QbXEyRFlJa25MV2V0UnlUM0xMMGZO?=
 =?utf-8?B?dUgvTVkwa09IUzBLSVAzUEtSbXU3UzZ4MmE2T1dzc0ZKNk0rT291b3hHM0dL?=
 =?utf-8?B?T2VTaHM1Zm1zOTJrVlBIWC9VUXM5VHJtWnBtWVE0aGg1dnBpR0tUM1lCb00v?=
 =?utf-8?B?KzdaVU5pK0JqS3l4ZTZoTk15Y1BBMWQxQmN5bXd5V3l5dkcxYXZYb2hmRWwz?=
 =?utf-8?B?ZnJqQW5nMVNNTDVYUDRIVjArckN0WU84dGFEQ2NZV2RxTHl0MUNDN0tRTFZK?=
 =?utf-8?B?M1N5YVh2RTB2Rll6T3FNdk9qVmRiM3FoRU53SFJUYTUxTnB0eDYvNXZBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnFKYWI5bldQeG5SM0h4b0wxZVBtbnVaTlFHbzZpb2NOcDUzd0cvYlpKYzh4?=
 =?utf-8?B?QmlHdlZLdTJmSXhBSkwzOC9adE5Wa3lGS0w3OEkyY0laaEtCVmJaM2NwRXZn?=
 =?utf-8?B?UUVxMGI2RTNDTUdnTWpBSmZvV25xV1FMWE5VY2R6YnNQSWI4L1lHVlowWjdR?=
 =?utf-8?B?WDljVm80bVkvMHhrazRMUGNkOS81aEdGT1lWNG1FdTl5dExCanUzd201WGhn?=
 =?utf-8?B?bklWcCtWdm9HOXRIQ3QzcXpCYm5rczhpam9Vekt0clNlc1dMWGNybk55aWxs?=
 =?utf-8?B?Mis2dkxrOUsrcFVybjR6bkxUSkdpYUNkbW9nNVlkanRXa3BEU0NHUnZBUmV4?=
 =?utf-8?B?VFU0UThZZlFKaXl4T2xGWFBVQW1qM0ZWSFN6QW10c0tRK2s0YXVIeXhyQ1JD?=
 =?utf-8?B?L1BoaS8rZU9QZTc1OG9SRUxoUnVDd3RNRzRublVGY1V2MnJTOXNNQklobmZu?=
 =?utf-8?B?UW5ySnhZa3BHRkc2OUR2SUFNbzhSQlh3alUwQmhwZFhDaEd3TU0vbUZtOTRm?=
 =?utf-8?B?MUJ3SEtEVVhpUEc5djFuYlZHdzA2R1VyanNKZnVEODJDTTBkNGF5dWhQWER1?=
 =?utf-8?B?VkVRTzhFVURoRFJEUkFlaUtmdGg0WXZVTUIwNVU3YU0vUU14UjNnTGZtNzFv?=
 =?utf-8?B?MmRzWGJ2SVVxQU9CblBsVXY5U05FNTcvNnZ6aFd4T1NwT01mbXBPZ2R2ZVVp?=
 =?utf-8?B?aDhyYUVkazJidU9EakdFWVJEUVRVSmNIWjNNekl6UXNtMkdrYmdGSWUyR1pC?=
 =?utf-8?B?NFpReG1xcGdIZXJLTXdvNHZmSXM2T1dhMjRWNXZRbFR6cjRNOE9tTnpkQlRM?=
 =?utf-8?B?eUNKN2NaOTZTMlZCaU9obmVCZ0ZweXZXUWVZWSs0TVRSTjdqTnNyWkNEZnA3?=
 =?utf-8?B?UnIrTENQNCtPc3czL2ZJRUxHTE05aDlFeE1XRXBaOVFHQkNmSVYwdDNHRUwv?=
 =?utf-8?B?WEM2SjFmVzZFK0VBY1IzT2pqWldqSDNNaC80c2VveEVMdFFvMXFNYm1CZGo5?=
 =?utf-8?B?R1FHWGxVQ3ZWNldPNkxxVDBIczV4bHhGYUtUbTd5U2F6YWxCMG14bTMyQW5H?=
 =?utf-8?B?SnpabFEyeVAyVnNtNk5aNzZ2QkYwYnRSbHlWa2VYWXExajBKZkxuTStmL2dJ?=
 =?utf-8?B?d3JYQ1QxU0MrZnVmaUc5TnZMS01YM0gvQnhtK2gxN1VLN1M0TVVwYjk2YzhU?=
 =?utf-8?B?blh1dk9wbklodTEvNjBDcnNkVGNPb1FBNDJDTGg2dnFOUk91Wm1XUXNHd05j?=
 =?utf-8?B?djM0Vno2NEg3cjNvWEh1Y254NEJxQ1pYc1VHVTMzalJDdWczcWxpQmZYQWF2?=
 =?utf-8?B?TGFSWjMzVE1LTmhOejNIUHlLdHAxc0xpWklZYVNPYktkMk91SnpDQ1lCTity?=
 =?utf-8?B?Ymh4TUdFcm9WN2taOFF5S0ZQTzFCOHZlV08vYVdtNmJES014MWRJR2lQT1p5?=
 =?utf-8?B?R280ZGhSV0tua3FDVDc4S2E0dUVtREhxK3hNcGg3OEtzd1cvWTc2RDZTckw0?=
 =?utf-8?B?VitSVjdlUVBBMjdsbW1TRGVMUjlwV3hnTkxvd0FEek92VkNpQjR0TmcrNDVQ?=
 =?utf-8?B?ZkZhRGJDNkVhNnV4djlIN0MwU1RwOG9hbzUyZWcvZ3hVYmhPM0FXTVlFMUJu?=
 =?utf-8?B?ZVk0RUpPQWpMNFRFUGJlcVc5TFhyelBYaVdybVE2dXJRWDZmdzZFVFBTQzNZ?=
 =?utf-8?B?dEQ1ZmlucHBocUtRblQ5dWQ2OG4rK0VXcmxIRHJHZno2Wi9vZmw3elV0MGIx?=
 =?utf-8?B?dWRsbkpNWDl0ZnROcUhLY09id2RTaDBhTitJZlhxMW5KMHFhKzJTZUw5bzBW?=
 =?utf-8?B?MHAxcE4vcTlna3NXM1Y0RHNsbjAvbVJHKytPdUZyUlpsZUltN25EZlhBam9u?=
 =?utf-8?B?SDlzclEwMFRoS3MzWHVEV3pjY2RIcEtuM1ArbHpzaFIvWVlpNXpoR0dYSnpq?=
 =?utf-8?B?ZzVuK1NDSmowZ3JuMFJiei9PbWVCcU9UTU0wSklscE0vQll3aDI0b3M5bktl?=
 =?utf-8?B?V3VjcSswQ3ZVNlJhVCtVM1U4cmFwWjYvQ0swWDJxOEdZT0RRUWI5bWtpbFBZ?=
 =?utf-8?B?aXpLcWtTWVU5cDNxeFphQ1ZzL0kxYjhxT0tWN2xiR0hrK2pBWERpYjlnNTFN?=
 =?utf-8?B?S0gyaWN5TnZnemkya0JlNHd4Qi9ndk9yTENPajZCSXVkRnFITHpQT2JOb1R3?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wWQSVSL7BKw+SlGl1VmwRbTnVK8Jr6k0CyVV43TttOgALxbwc9psK2QHRRMc12bfKSAoDRSIZgYd1nW+ecGAdLZeOWEM7kqGdljGlQWJXb7feMP0GY0ua72w7coCoR5bte/nLhlkymuIh0vjLTT0Al5eZSZOqLlzajHrVria+yiA8T8dQgD/NCD1O49HjUL+sGZQ9fLxS8zHtIgZSEbeZg2TEMc7oBzQGMVH20QYlpHDoprbmncXwtVJb8u4ig7/ANHh8yGHNRzkiSrNd+fRUZsEUAc+Lg4j+4Va+sLTaRmkc0hksBftkn/F6pWwmjoR2G2a/A/+qz8z0VIwKAkElmdN/aUbintcDhg+I+LybjTtZhfQRpG1MmzQ5Dr5zxab8nAnw6dkt5TopXkkitje2HXoEJmSRueMO95aXXwgCT1HX8iatN63NKhNTsdJpXvWr7EdXD5A+NX6W0NwXIK1kzOH9B8/J90EyCxXs8T3leR2XKcr4M96HTsgNX3FM707gv1s5lkgFbbukoXPJ59JrHepxLG/IssM58pxYp2suszy5nbX3Qpv15Eemhwp5Dms6TNnobi1oSsxNfy3Y3GscU2pJ+UKB+la4cv7Dps4ZU8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a329e3ac-33b4-4d66-c77d-08dc84eab077
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 23:04:30.0096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QeydzdyZhPj70W+084gVK9Tbwuq+nns1jDigk0uhc/fHJn03DLxuwyxI7qBUztdm4i7hufmX3Pca+J9KF4PIJQk8Q9sUZmby6aK123SI4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040187
X-Proofpoint-GUID: u1uqOaelVb-YNDSrb5rcZ3GvnwFjgSpi
X-Proofpoint-ORIG-GUID: u1uqOaelVb-YNDSrb5rcZ3GvnwFjgSpi

On 6/4/24 3:50 PM, Jarkko Sakkinen wrote:
> On Wed Jun 5, 2024 at 1:14 AM EEST,  wrote:
>> On 6/4/24 1:27 PM, Jarkko Sakkinen wrote:
>>> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>>>> Curently the locality is hard coded to 0 but for DRTM support, access
>>>> is needed to localities 1 through 4.
>>>>
>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>>> ---
>>>>    drivers/char/tpm/tpm-chip.c      | 24 +++++++++++++++++++++++-
>>>>    drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
>>>>    drivers/char/tpm/tpm.h           |  1 +
>>>>    include/linux/tpm.h              |  4 ++++
>>>>    4 files changed, 43 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>>>> index 854546000c92..73eac54d61fb 100644
>>>> --- a/drivers/char/tpm/tpm-chip.c
>>>> +++ b/drivers/char/tpm/tpm-chip.c
>>>> @@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>>>>    	if (!chip->ops->request_locality)
>>>>    		return 0;
>>>>    
>>>> -	rc = chip->ops->request_locality(chip, 0);
>>>> +	rc = chip->ops->request_locality(chip, chip->pref_locality);
>>>>    	if (rc < 0)
>>>>    		return rc;
>>>>    
>>>> @@ -143,6 +143,27 @@ void tpm_chip_stop(struct tpm_chip *chip)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(tpm_chip_stop);
>>>>    
>>>> +/**
>>>> + * tpm_chip_preferred_locality() - set the TPM chip preferred locality to open
>>>> + * @chip:	a TPM chip to use
>>>> + * @locality:   the preferred locality
>>>> + *
>>>> + * Return:
>>>> + * * true      - Preferred locality set
>>>> + * * false     - Invalid locality specified
>>>> + */
>>>> +bool tpm_chip_preferred_locality(struct tpm_chip *chip, int locality)
>>>> +{
>>>> +	if (locality < 0 || locality >=TPM_MAX_LOCALITY)
>>>> +		return false;
>>>> +
>>>> +	mutex_lock(&chip->tpm_mutex);
>>>> +	chip->pref_locality = locality;
>>>> +	mutex_unlock(&chip->tpm_mutex);
>>>> +	return true;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(tpm_chip_preferred_locality);
>>>> +
>>>>    /**
>>>>     * tpm_try_get_ops() - Get a ref to the tpm_chip
>>>>     * @chip: Chip to ref
>>>> @@ -374,6 +395,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>>>>    	}
>>>>    
>>>>    	chip->locality = -1;
>>>> +	chip->pref_locality = 0;
>>>>    	return chip;
>>>>    
>>>>    out:
>>>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
>>>> index 5da134f12c9a..35f14ccecf0e 100644
>>>> --- a/drivers/char/tpm/tpm-interface.c
>>>> +++ b/drivers/char/tpm/tpm-interface.c
>>>> @@ -274,6 +274,21 @@ int tpm_is_tpm2(struct tpm_chip *chip)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(tpm_is_tpm2);
>>>>    
>>>> +/**
>>>> + * tpm_preferred_locality() - set the TPM chip preferred locality to open
>>>> + * @chip:	a TPM chip to use
>>>> + * @locality:   the preferred locality
>>>> + *
>>>> + * Return:
>>>> + * * true      - Preferred locality set
>>>> + * * false     - Invalid locality specified
>>>> + */
>>>> +bool tpm_preferred_locality(struct tpm_chip *chip, int locality)
>>>> +{
>>>> +	return tpm_chip_preferred_locality(chip, locality);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(tpm_preferred_locality);
>>>
>>>    What good does this extra wrapping do?
>>>
>>>    tpm_set_default_locality() and default_locality would make so much more
>>>    sense in any case.
>>
>> Are you mainly just talking about my naming choices here and in the
>> follow-on response? Can you clarify what you are requesting?
> 
> I'd prefer:
> 
> 1. Name the variable as default_locality.
> 2. Only create a single expored to function to tpm-chip.c:
>     tpm_chip_set_default_locality().
> 3. Call this function in all call sites.
> 
> "tpm_preferred_locality" should be just removed, as tpm_chip_*
> is exported anyway.

Ok got it, thanks.

> 
> BR, Jarkko
> 


