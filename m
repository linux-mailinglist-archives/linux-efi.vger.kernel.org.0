Return-Path: <linux-efi+bounces-3417-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF4BA9757A
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 21:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71AC440BA9
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D148230BEF;
	Tue, 22 Apr 2025 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fp/vSPvK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SgXS108o"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16172989BA;
	Tue, 22 Apr 2025 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745350386; cv=fail; b=Lx8yTHHDPXDaC81MtIV+pYck2ipbMNMvz04uZhbT9OvkuMPcntxAs3ZtBE5eEPHw8xP/3HYHsQyPykxa/Wtv1rsRMmp47Dq5h5OzFCM0rA96vTlYKRL/p4InMCxty/ydNKKultbfP+56IrTKMPjaiRygyQDhZvlpszSgfwzU7aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745350386; c=relaxed/simple;
	bh=R2w62ScB8P6vLAAUgmmHCMV+cvuWwaY3iV8QCY9qsbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fyvQnO09T7GIQymMjuQVgyXtWqOoex2tbqvEKh4kXefS90VyiUVulx7rU0sFAkFavof7/NWMMO93aUnK22TcHzOKDNGJokxjdJPvs5bqtnrfXsdhSothSWU6mdjHKsNyk0BsKlxviX/E6iGahRk2QoL94GEXmmMfvcFp28Gjvkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fp/vSPvK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SgXS108o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MFsp3V007691;
	Tue, 22 Apr 2025 19:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=iOyv8iw8CIX3Jr0GClcDIWoSSVkseaKsmHc60vyGLWw=; b=
	Fp/vSPvKq6wUAgaU6DugJbOPe93VYaR+dX19sGVn+zIQKEVALFw66t2DopHuhpO7
	PUr6YtYvczGk+VgGaLzNecAfrnW7gR8HiQpfqj/D6LLV2PHj5/+avwSTJGB+RmGI
	roDSuCDwktMmGwEUGy40RtTUyRF/Dtvge8R66zu49c9j0oUNvycsL3WdPdY0ZNsv
	CJyGtgn5DahK/0GHQOfEEbmJbt13cgPpqt14g67Wd+LxLibceYg5vpgG35R3bUik
	hk+uedPInGdbIMlXNHMxBbyP01tpwMDf0HpHw/h3Ubi9EKxMHs/6G2ZFiDK5+VU5
	tj3JNsZwahYHUeHpsx1uNw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4644cswbut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 19:32:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MIIv1s021185;
	Tue, 22 Apr 2025 19:32:28 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010002.outbound.protection.outlook.com [40.93.10.2])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46429gbmax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 19:32:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q13PwNxX/v9u7ULvudytGXBvepIjbTTdlOvbMEKQWIDuopQmC1WfNrO9HzF1b7LkNbrjHLLyOua0IrapT6jR0JuACUos6M8hHpM3Zye7oK6miDQlzWHxqHwASsV5nrIS5eCo8ciKHO0vDgURC+sYzdrp6KG8EhWLiUM4QActa6nBbmC3Qd78iIIU5tjHGJhuwnt2E4S86fMOUNkoUE9/88KrFWbtqzajKu0n85cED+pzV1mSZVicdgllzSVhGxlxllrI2p4mUPwAbRRjehju/qKvrFzu3YTRCaNqM7y9s0tNKOhGiMtRaI7+LVajHQGrVOHrl8hVuwMhGj+4Ro79XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOyv8iw8CIX3Jr0GClcDIWoSSVkseaKsmHc60vyGLWw=;
 b=waZa/7QzfC8JH4YextGjMpqvIEQIYB2asw6YIxNcJKS9TRkmbEn+wLFyqWidwIlVlptyHpTwkVq/76ADOugcrP1Na56PdotaPdr63brq5LQMOJZiiJOJ2kKraV+v2qL2SFf6+Ig+WftTjtMVqRI41SMEtUzbUiJgjyDVFHIGj0ve+lSoSV478xEwVBoPRegWUjR3aSEVAxPeQvldTHggZxTVh1XGXakBNX2CtQGSJZcUTnpnSR4LbTuzLlUntJZeCZJmdHFkNCkjXUSIdjUTQ6WUXJO8PqVhmqMr9kHujJCbT2f14acWTBf4JtDTZFRi+X2U1JkKa3Yb1FnZkzk+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOyv8iw8CIX3Jr0GClcDIWoSSVkseaKsmHc60vyGLWw=;
 b=SgXS108oVh+TOBIEOQ3Zz10wVPDZbvH1p7cBJJyA+hsIyMVaOuAVmaI4lEl7YqeztMXSquGGJVJi0wduwsvh448AHH5PiwByZSM+5KjuXmzam6vRMCGUhlmzUyIRQy/0z9mi1QiO6HPItZTfWlZncs21NMsZzicyvecP9RkaXCM=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 PH0PR10MB7064.namprd10.prod.outlook.com (2603:10b6:510:280::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 19:32:25 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 19:32:25 +0000
Message-ID: <227ab614-2d03-4ee5-9596-d515f9613dbf@oracle.com>
Date: Tue, 22 Apr 2025 12:32:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/19] x86: Secure Launch Kconfig
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
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
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-3-ross.philipson@oracle.com>
 <e1e3dc8f-ca16-4cce-a670-bb8ef566213d@infradead.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <e1e3dc8f-ca16-4cce-a670-bb8ef566213d@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0117.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::34) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|PH0PR10MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 46411b28-8488-4df1-170b-08dd81d468df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEdleUg2MkZoc1huU2ROL2RoVUhxVjM3VHlNQ1pjaExhSndWYjI1OWZGcEor?=
 =?utf-8?B?Y3JSbG9vcTgxcXhGNnF5NEMyQ1BhMTF4SFNFVlBzUEdyY01EWjRtdHNRemo1?=
 =?utf-8?B?TUtTREQ2d3pGZGJwaFVnZnM1c2xRbHdDdE5hR1g3ZzlJc21LdFlnTW0zYXpT?=
 =?utf-8?B?c0dTQWVXUzJkWGo5YXZyY1B1SHJWYkQxa01LVVAvRjkwbUg5MytaZ0U5RGp0?=
 =?utf-8?B?Rm5YS0VKd0YwTW9tMkgxNXFVcktoQnpGOE1kNEsrTHR6S3NneWIvTUtKK3NZ?=
 =?utf-8?B?cTVheExnUHREaTFzM2MyWnl3VXZlbkUxbi94UWc4dzlMZGFxcFZ3YTBmaklv?=
 =?utf-8?B?M3d4cVR4eElST1VXY2xMbjZ4aHlCYUx1QjBVTi9wRzIwV3VaVElFbFdDZmFn?=
 =?utf-8?B?bzJlWUVGdzNHRkRqc25pU3RuK3lqdmQ0dVZBOWJDM1BSMUkxc055UVFoQUU5?=
 =?utf-8?B?Nnd6WXBGVFMxbUVKbTdoV1M0eTZXdGx4azhIbkdwajNyWHFPbWppL3ZMeGRq?=
 =?utf-8?B?aHRBbDhBNE11M3RpQzZrRU9vcGJGNDlKcWpDUkJpbmZ5MHdiNFhZeWJSdWRQ?=
 =?utf-8?B?YVVGSzFncnFVU0llSVJrVGx5cjdwTUFlUGp1dS96NlVvNnM0aGhyeGcvWXpU?=
 =?utf-8?B?THErL2lFaVVnODQ4cHZheHJkeUtUay9YYmZwUjRpOEVhYkxVdnFDdDlUY2dj?=
 =?utf-8?B?QUtUcGtuTVFUMW1lTVBOenhqYTBnZ0Fid285VnJtaVN3NzBSWTZoV2pHS2xl?=
 =?utf-8?B?SGlPSU1JRVR0UStJQXpVRCtoSk91cFFWYUM1dFg0WitKM2x1am1nbXA2RTRh?=
 =?utf-8?B?M2Vad0R5RGRwcDFDeUJkdDJsM3pJaitSUTlTR0duSUZzOUExdVZMeTdyK2pZ?=
 =?utf-8?B?WHFrWFByM0ZKQ0kxVXFTSVlNeHh4amlnV3J4d05CNzN3UUVLMjVwNS93YnJS?=
 =?utf-8?B?cnQvcXBhTStWL3dZYkxPQnV2MWtYSkRUMDc0UHFuR0NNQlBocHRXTDhGb1Bv?=
 =?utf-8?B?SXhXTmU4RHlmeGNmNWxseWVSVnlVN2xYSTlWRitvUHNKWkpqMVdmYVFCQUxi?=
 =?utf-8?B?ekdLZWFoZkNiTXhMenYycTJSYXhPdDV0SElSTVNCYkY5amhxNm5VbFUzTEZL?=
 =?utf-8?B?ZC9hS1NPa01tK2wxODN1TFlBU0IzV1g3ZmpsU245bXFkTHhFY0tDMUJaYk8x?=
 =?utf-8?B?WjRLZG9TZHA4ZFdyek9LYmxZWnl1S0RqWlR0RmxaRzJtZktsalZtZmFQUlNH?=
 =?utf-8?B?VU9tK2R6NS9ET096c1l5YTJrT3BjeitabjJRS1BHZWRydDNLd3gyWUdDNlNt?=
 =?utf-8?B?bHN3M1dOSTh1TmxhWDBIUDhsdWEzcS9NWkc1OFFlL0JkdFcvYUh0V0E0OWts?=
 =?utf-8?B?ZnY5UVB5T2x1dVlhOWlHU005bnRoUVBmZE41ZzJySG9VS01xeW9Fb2ZNN0g5?=
 =?utf-8?B?N0ZaNzZia1JuTVRtdzNDcnhLaGptNGJ1NFVPeUwrQm9qenBnTzMyN2oyZDlW?=
 =?utf-8?B?dkVLdGtVL3kvaDF3V0MybUtlQkRwVWpCNTJlVERvU3E2R3YweXg4ZE9uejBx?=
 =?utf-8?B?UGQ4UHpaZVV0U1hIc3lmTWlZSEhQT3BPNUY2S3IrY0J1Qm9nR1pUenFPZnp2?=
 =?utf-8?B?OU1WRlVoaEthM0Zxd29RbVRuY2xMSlNwaHNjNWRHQXBldXJmRUQvMzZ4bnQx?=
 =?utf-8?B?M1ByUmV0eE5JKzlvalp6WW5QT3REamJYK0hSbnpFQVRJeFdRQk1LdWJFUTNo?=
 =?utf-8?B?dDV3OHFFeTduc2VLK0NEYndyMHRDWGp1Z1kyWmxKTFlWbGxVbmwrdDFqYTFS?=
 =?utf-8?B?ZkpJQ2k4YVJnN29iY29MTnhEd2dNcm13M2Y1UmZ4NXB3KytaNEh5RkhMZytT?=
 =?utf-8?B?RHN5SUoyM05rSDg2UlJyejY2MEhsckNBRHpkbzcvanFheW5UMFZnWjM1SGlk?=
 =?utf-8?Q?LIW/3PPqttE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUZFdnNCOWpSS3ZtM0Rvd0F0c1kwdDhpYmhyQ0h2UVpYTUZmc2dIazd3WlBJ?=
 =?utf-8?B?WXNzbW9sTTlObHdNVGR3S0p3ZmcxUHZESXJNMDNrTk9YVk51KzV3Tmd6UHMr?=
 =?utf-8?B?ZUhjOUQyaWVzVExIRFA0YWNzcS9LU0FtdnhtY3VtSkpPMy9SNWs5dHlmSm1o?=
 =?utf-8?B?T2xpNzQxRTI5YS9qMllKYmJkWHk5RTFMaHcveGRuSm9pQTE5cXQrTG5MaXlX?=
 =?utf-8?B?M0hXYk1sNDdPZmFnYzNTQXpQVXVZc2xNS1c2TmZBOEZrWHkvUnpyRUh3OXpW?=
 =?utf-8?B?R0phTWhGa3ZDTzM3ZktqOW82V1BscWFZampOUHRvNUJ2TGpOVTF2NUZjQ1Fr?=
 =?utf-8?B?bFlxbmptelorQ0ZRa0V2SndvWWo1Ym4zcG03ZHpyelBYNk1OaCtpaDZKM1lk?=
 =?utf-8?B?aDZVQzN0YmJKbkRlRXFqcitLR0l1dWROOHhNaHVxUEYxSzhrT2FTU0twUWhS?=
 =?utf-8?B?ZHRxTk1pUzFMamFkUFFaL1ZZMm5zUElRL2V1OUR3S1ZXYzdiZ1V0UWlCZjRG?=
 =?utf-8?B?QWZCMlR2RkwyN2EzYmdML3oxL3hVem13K3l4cnpRcTRhN0N3QUFEQTV4RFJK?=
 =?utf-8?B?eWwvcE1PdndyYk1sK0FpMHlGQVozUGRjRndZODBrUUNkYmpweURqNzg5bEVm?=
 =?utf-8?B?SzBleWJtcllPNmIwQXhkdHdhcjk2M3hJd3YzYjBMTzZJOEdocnp5N1B6by9R?=
 =?utf-8?B?YXlaRGRIcDRocVNLcERUTHhNd2w2VS9QNHpHVW9BeEhZS1o5QjJ4NDBXQm5X?=
 =?utf-8?B?dWRCT2dCM3ZGMGZFeXBZWEJpU3RQSGt6YjhBSFpsMUNmQlNza1JsWkU2VFh0?=
 =?utf-8?B?SVUyNzNJR2xoNWs3TlJwem9KYkN0MHB0T0FaWEZvYjRmS1FhNDBEKzErRGlM?=
 =?utf-8?B?QnRmVGNJVjI2dkp3b0R3cTRFY3RsamE4OEVDV0xuVWZSZWVUdkJaa3o3c2Mw?=
 =?utf-8?B?OGVhVmRnTFEzMVBYNWNYbGphM05PVm50WGpMOVE5SjdmejdEVTVzS1EraVdm?=
 =?utf-8?B?OVQ2VmlCK3NyYWZreTBVQnl0d3I0OE5ZQzBJeCsvMXFvWDVLQXpsTjFxalJv?=
 =?utf-8?B?VUxIMVVESVlTVFhxUzFjb2VaYk5xb3E2Qm5NaWFpR2lONVAwVXRrbGRZQUo5?=
 =?utf-8?B?OWQ0bjZ4bmt2ZjBuNTgyVkJBeTBoVHBtck0rNWFkYnE1Ny9vTGN6Rmtqck5V?=
 =?utf-8?B?amU4bWt5a0RQeStLMUtHZkoyRFBQdHU3V2tFY0FOVmVCZnRtbUg5Nys3K2lQ?=
 =?utf-8?B?aVdqRzZUY3k5V2RzcEQ5bUdNaEJyaGM0R3d5cEg0aHpBTUF0U3owZlFTaFFw?=
 =?utf-8?B?b1dMZW5tZW5XNGJES0N5MlJhVjdNbnlTWHpKM0NCU3A5SVVqbDcwclZCa3h5?=
 =?utf-8?B?VTNQSWl2eEJ1TG1BY01RNVdBTlhTN29sejI2eUErOEM1NG4xSCtYTm45YzZD?=
 =?utf-8?B?c1BYL0lQMmJDcS9BbUVTNmhQWXBTa3lpNy82a2pRVldZekF3N2M1Q3Vlenpm?=
 =?utf-8?B?TnpLUzZGaFFLZ3FwU1BSMlBkczZwOGF1YUtVMGQ2dVh6VGI3aSs0S3lSNUhm?=
 =?utf-8?B?UmxSeVZzTFIzbUxwbjdNR0o3R01HejM1UnNqYW5NL2d0SEFuQ0JLR2lwa3FQ?=
 =?utf-8?B?eVF3NTN6bU5wb1lGZkRPVThNc0ozeTM5WmtzUkxvVGF5V2w5NFRPNTBaTEcv?=
 =?utf-8?B?RHRSL3pDUHdCNmc2aFhDZEVVdVU3cWlBeDI3c29URjNRc1NhdHU3ZUdwUU9o?=
 =?utf-8?B?WE5UZG9IdGFvS01US2tmYWRKYklSandydjJlb2hZelBWeWpEMFZLV1JHalc1?=
 =?utf-8?B?aFh2N2VrdFFZQ2ZyWTZBTUxjeDdyZURHVDhzYXNmTlQ1U1J6NFFKSnMwTFpa?=
 =?utf-8?B?bVNSczRXQVp1WFByQXRMcG5QQkh1b3hjamZLQ2JLTFA5Z0ZVcTlnalVLT2gv?=
 =?utf-8?B?ZWZrMkpKaCtFa2VGUEwvNHRXbWZ6UW00aU9BelVCWHg4OWxvSnlFc0FscFlt?=
 =?utf-8?B?TXpKTUR5bi90ckJlbXM5ZmZtUHBpU0dlTmxMdDFCVm1mWmpFMVR0cTlhR2ty?=
 =?utf-8?B?YXlCb1JYWUtDMStUbGhQaHRkdHkxZkp4T09TQmZMaTcwdjkwQlFxZjVkR1hs?=
 =?utf-8?B?ZnJ5U1hwSldyZVgyWkJPNEtCM2ltenZrRWc5eEx1cndkU1NDbzgvSXYraEhR?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m+NN2ASpzk3uAVVvKEzzHDXs+tLxnxiBUGoq1ZcaxXF3Xu8Dv4KtN87zqBHlw4LGSMD6Y/pEcMxCIlkJKP4G2XOqX02dMQcYsfkFtC0ZH2XChOhl7zEscADlV2M+EysOtrqYjW9MF7b3a1N3NqEr7ExKw1WQDiJ4KafSnpEc5ANEhSHlPPIp9Cl13lYhC//4zeAWO4XX1qn12JRzt393HF7hkOGKK9jkWMqCz/6eakU980+ZSqMrYNgp2YSltZuuixFL6dtmiNA63S39eV9Ov5tQCic7o7QBbF1JXIlmcZ71xPGpJ+du90gnxcR0d4xp97Ty2IK6VS3pYgRrTgJOOio3Ae4d54Fr19Jy+GowsESJe3vFOzWeQazjbGvB9wMro72RXIYaqQekWsS1T+TKT5NUvqMjngMBovgfM/gvbZBBDN2MsjmyBetkxnKOe0jwGmmWyopnZTTYQP4IR1ln0Ote0mnyWuFRvu8POiqpKyCd6dz/i8+A73V9Kd2oQYj0a6EhhY1K1x6P3uOFE1gyGL3n3hmFNAO27AfXxImkOXWnoFkA85k5B1FTsuzir0Wx3IKH8FrxatkZxNjgGXBUGMbgywx5TzBIPH6NAzwMmUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46411b28-8488-4df1-170b-08dd81d468df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 19:32:25.0988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWskJcGL5BiscUIOFKwOreUwTqXq3/Sddz6ODjiYn+dWhMHWblCqeBxMTYZonY22pdnarvA4sOOQkFv8sv0PQnZq3pH9EKk0a/nG0OOdFVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_09,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220146
X-Proofpoint-ORIG-GUID: FqtSthI14_OrG16x7PuaVPfwnR7bgGsV
X-Proofpoint-GUID: FqtSthI14_OrG16x7PuaVPfwnR7bgGsV

On 4/21/25 10:41 AM, Randy Dunlap wrote:
> Hi,
> 
> On 4/21/25 9:26 AM, Ross Philipson wrote:
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 4b9f378e05f6..badde1e9742e 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2001,6 +2001,17 @@ config EFI_RUNTIME_MAP
>>   
>>   	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
>>   
>> +config SECURE_LAUNCH
>> +	bool "Secure Launch support"
>> +	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB && CRYPTO_LIB_SHA1 && CRYPTO_LIB_SHA256
> 
> It's normal to select needed library symbols instead of depending on them.
> Nothing else in the kernel tree uses depends on for these 2 Kconfig symbols.
> (CRYPTO_LIB_SHAxxx)

Yes good point, we will address this.

Ross

> 
>> +	help
>> +	   The Secure Launch feature allows a kernel to be loaded
>> +	   directly through an Intel TXT measured launch. Intel TXT
>> +	   establishes a Dynamic Root of Trust for Measurement (DRTM)
>> +	   where the CPU measures the kernel image. This feature then
>> +	   continues the measurement chain over kernel configuration
>> +	   information and init images.
> 


