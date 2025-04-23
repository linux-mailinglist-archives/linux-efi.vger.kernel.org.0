Return-Path: <linux-efi+bounces-3443-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B191A99988
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 22:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAB11B85432
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 20:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2930269AF9;
	Wed, 23 Apr 2025 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pefc2ul6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UqsC/qOR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C562676E6;
	Wed, 23 Apr 2025 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745440757; cv=fail; b=nl+FP1m9+/MI94jru+dpgA7JW4C5dLlr9+pWjCFzXKDyHsvjS3wdkIiQphXzT0mviJbWKWXglgYrjgaIdK0reOPp3OYXt8EskxNm74+8jQ/cA+FoFr9aqwxAi/QXsANj/ZOTbG0HBw+VyuYEcgqFOm/JruckSy4KbWQWl5Z6yqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745440757; c=relaxed/simple;
	bh=Vv21bd4I9AXKogDrINZ9cRiHNZaLBq3uFOSygW/JV7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L5Rs8PDunY7+IRwdyrC0AiomGMAoeXPU3+pBCFIUSvP9TFNOsllbOM8FPjji8sX+kLr1Syt2sA70upe34IfZC953sPGTA0IM4D49Z7c37PUhWqevEVlugakDOYSgmRMHGEOadFTSGP0ahgchwuepwd0WhouskwMZpgDSXPukvt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pefc2ul6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UqsC/qOR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NKBtio028552;
	Wed, 23 Apr 2025 20:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8KyaGIQYfZvHM3X6ksc+8DkNBXmRTR9g0vr22jYCnXc=; b=
	Pefc2ul6RsMbvv7u0y9xH9/rKIchyDvVUPnSNqbmqm3o7db2TH8N/CN5j1Zsai+b
	eMyLakI4WThURnfjK5Mwoy9KcPxVCzOMcP4w0apRVLY6c0RabiXfzavxuERO/DXi
	8KoklkhMIFpIIWQbpPVG/XClnm7rXwgYobb8vQL+2OUA8FO3PUuN5lXAU203oWOw
	DEXr1qt00l2cdvTt4bYtyp7N78RZ0PqhXMrRAKu1gaq3FRlMyhgRBmFpIKSvsFiC
	AICHU2kpMRh690scGaTtMGv24Ay4WuiX59Nhzq0URd1jbRE6ivmpzN61iybGzstb
	UEjcmWCefIxllBYSWGLFrQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha2bbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 20:38:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NJgHYC031012;
	Wed, 23 Apr 2025 20:38:35 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012013.outbound.protection.outlook.com [40.93.14.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k06cywj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 20:38:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGA8jVa9FlH6C04ZT73v4w7tSOT3IWVPha13HkzqybbrckUAUg44VcNLcRSNi2ufZuDoDf5S4LkX0FgknzZyc6VSuIrvlhB09tkiyxuKZYbnhOMYe7U34DmJlpJ61Bq+/hzAkQg0yiSblyMv8eLWtM9anesdsXpmhFVxlGl8p4kbzn6RoLogD7k9J2OR5VaM42P0yzjeDFKTspdg8H/5oHsz218wJekw2jAlOsPpWa+88w4kQY3iuwKwMYEo8n4xAnRm4o2DNR5aIMSQibPks8tYNaL1FXCcDsWd2aW3TIZ2xIqCWdITd2YuJwDkMd1unwh9cvcMrfv0vpOvGKS2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KyaGIQYfZvHM3X6ksc+8DkNBXmRTR9g0vr22jYCnXc=;
 b=IkCUEOUz7t8o745c0ve7ajvZKMqB/V1jKPdkTI2i1lTLl9X5vlzwaFNL3/igx+CZTXs/XnzmOSdTleT0kHT5c400U+r8dZON46Fp6aCXVrhVzapNRIxI5slZnb1LMEXyhPXoIDM18vVvmiL1PubO/xIC1ziPNatSpkPvoB+yGzgpW98ifzShXd7WssCLGLHjW+7fTtP0RcAjDBO82wzDn8RqxoCkLw0SizXehqwLm9AIMQlarDS29I3zxi7YG0FiPSkw6nIGgvQ5fR+7N9xzg/JQ0PfS/nR4m2cti6q0krNYQBrcMZa60yYe56AoJJGeF8imdlHQNz+tZhuOoVPbbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KyaGIQYfZvHM3X6ksc+8DkNBXmRTR9g0vr22jYCnXc=;
 b=UqsC/qOR2VPN780qQzZEP3OYPnZ3p9TEfM41bUnKBsiVWxYhqJbt9ZmRgSshXoPlZbDCbb+tYHaadFiaVJPBPHwPF9uwHuLD3s2KJ0XgDXwCyTujR7Iy16t4dKsYMrB/dbsE/iwLM9q0Ei2sHdqsRG7ykQ/3UOLbF9tX7Sqr3hA=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA2PR10MB4601.namprd10.prod.outlook.com (2603:10b6:806:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 20:38:33 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 20:38:33 +0000
Message-ID: <d1f86aa1-2e37-4cfc-b62d-7529ac58c8ba@oracle.com>
Date: Thu, 24 Apr 2025 02:08:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/19] x86: Secure Launch kernel early boot stub
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
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-10-ross.philipson@oracle.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250421162712.77452-10-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4P286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::19) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA2PR10MB4601:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b22f2d6-b016-4386-ef84-08dd82a6d03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG1oZnlRVHIwQnl5NmMvdVp4bkZ3VWdHZitheFpuK1lmQ1JnVG5Rb1VNRi8w?=
 =?utf-8?B?SlpaM1ppNTBUektzMGl4RkJ1Skg3NDhYRW83RnUzOStQRXQ0RGk0SEsrb2J5?=
 =?utf-8?B?R0V4SDRZVHFZQk5EMExVQ0R5Z2RmMmJIUnZOdjBGTjBoUHNWV3NLczhJZ1ZM?=
 =?utf-8?B?RlVvaTE5eE9hUUR4bW5YWWttQ2drUjU4c0RtdlF1UGc1TnphSTl1cE5qMzJ0?=
 =?utf-8?B?ekVBSEN4blpmSWNXSWFxL3hMUjNlc1JCUC9xNFNwczI2NlZXdG9lcnBnbHBT?=
 =?utf-8?B?b2E0aHZ4TUVOaE8reWRpZzI1RVlGcVRMSDlVWEpUVnVZOVp2TDlXWE8vNUVJ?=
 =?utf-8?B?d2N3THVqN2F5MmYzaUttTkc0c2ZIS3RpajkxNkEyd0ErS1VtKzFIQ0QrdjRM?=
 =?utf-8?B?NEJUUHF2dWFZa2pWRm8rTVl4SVJIYTJyb1J2eFh1N1dXVGFyQzJ2TitqMmJX?=
 =?utf-8?B?YVlmVE5hVFNTZ1J3U2ovRlJqQXh3Zjd3RlF2dE5PSlRheWViei94Ry9aaStw?=
 =?utf-8?B?ZDQ3ci9sZVlBcHRhRlZLbE5QWkVsdDBlMHc3aURKcmJNWEM1RW9VTEdQRXE0?=
 =?utf-8?B?dkZGUmc2WUViS3d3UGRuUndEMGhhd3RwUGlHNUVmUEY2L1M3NitjTlhGRU8x?=
 =?utf-8?B?VE15eGZYaE1jTkwvcHNSb1NNc0JVRWhTUkpPdWY0T2d6NWNPQzdqeGEzcTY2?=
 =?utf-8?B?bDBQTmNqSU9KQnk3NzVzWVMranhITlcrV2xvbnhrOGJkYnFKa1hCajltWXBY?=
 =?utf-8?B?d3Z6dmo3MkR6ekVDUTQ1K3V6WlFBSHdoYk96UjFPQnNRZU9kYmVDRk8rQnhX?=
 =?utf-8?B?MU5Fc1RQemU4ZVVuOEt3TzBUd0I3M3ZEeGx0RURTMVEyRGxxNzI3TmtrQnVM?=
 =?utf-8?B?UzF3UEpTL25oZWR4eURHeXJDMUN5cnlPVXdVMTdlOHFDb3N5bU41U3VuQWRN?=
 =?utf-8?B?SzRDajd6QmtWWjZCSytXejdDK055bldYdS84VFcycUdJQ0xMYTNOYktGMFhk?=
 =?utf-8?B?bEhSK0lPYkJiMmlrQTgzSkFFSXBQZ092OGI3dlVZZ2tPMTk2Uzk1Wk5wNlNh?=
 =?utf-8?B?czU0a3Q1dWhRWXNuelJkMVpnQXlsc1ZyWTBaRDQzbWlKTmZKNEhvSFNPOUVC?=
 =?utf-8?B?T1pvSURBZk9PbUFiSDd1T0NPd25GaE82bFBjTkVud1FrNlVDRDRFdXlSMHV5?=
 =?utf-8?B?NVZSaVN2QldXeW9DSkh6bTlUOW1NWTM0d0JqeHpEYUxPbFlPSUQ2UHllRllZ?=
 =?utf-8?B?eHhFM0ZudmJlaWRjYkVSUWFhbGJScWZrZEtZa0ZreEh6QTM5VWJFandiMFBh?=
 =?utf-8?B?MFBxK0pDSk9JcThsb1V6ZWtqd2VuRFQwcmNoZHVEWVpKcWlFMElUK2IvTGtq?=
 =?utf-8?B?ZGNRVDBXY2hzOGtHanE3dThleVVTVld6U2p2aS90a2lUaUdjWUNrV1o3NkJC?=
 =?utf-8?B?ZkJaa2paTFVMN0loc1pTZm1ZUEgzQU9senRMd01aOTVpd3FEYzdlbUhTckEr?=
 =?utf-8?B?SURFUUYzVm4zdmt0VXRvV2pwWjZrell2aENZT0Frd2JkUlRGOUsvZTVlREI0?=
 =?utf-8?B?RlkxTHM2UFBoaVQ4Y3BUQmQrNDh6aTk4c1lUQlRIa3diV1pnVWpLY3ZJalNw?=
 =?utf-8?B?N1hndi9lRDFkbjRSYldHZ0lCbDZPOHZ3bXB2RGRudjJLWHRiMTlYNWtYUTh0?=
 =?utf-8?B?dE02UW5jSWhZNjBUZUdvYjdldFZMdjV0K2pUWXhqdm83TE1rMDU2S2hCZDBM?=
 =?utf-8?B?eGpWWWh1ZFY2RWE2NXNwWFlMMlNhaDFGRkYzZVJNSjU3SHorVlJNRWhRcTZV?=
 =?utf-8?B?L0x3SVV4QzZCMUhJbFk4ekJUejhtRTdGMGpPZ3Ixdy9CWW1XckhxWmtVQTlo?=
 =?utf-8?B?bzNDMlZJNXFQRXZmN0xvb1N3UlZGZ2pDdFZzN1FkMFVMQUtPWGJjNlVwZTB0?=
 =?utf-8?Q?nZ3XZN8eQxI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXpxeEZDQUVTT1hvS2oyUnBPQ2pZditacmlBRXZSOE5lam1RS2hWMldZeG1w?=
 =?utf-8?B?RFVraTJ4Y0hNSVdpbXd0K2c3cWVTR0tFOVAwTkJvSDYwQ2xyL0pLYVd5MGVi?=
 =?utf-8?B?S3p1MlNYTVQzd2VJRE9FUndZdmJtcy90VXBCWDJrcXdWbE9JWlZWMlYwRGw5?=
 =?utf-8?B?a3BtMzhDT2ZSdE9tY0xCeW05dFFNUndRTWFkbHBYV2o1a0FMZkdUWVV0U081?=
 =?utf-8?B?YzhhSlZBRmttbU8wVWp0RGYxaXd4cU53WVZOcFk5dkxoREFnWkZvRTl3Yi9h?=
 =?utf-8?B?Qy81ZHczUk1CbXlhMVJMcEFpeUxPaWU4QW5UaU8zdkdBZXdtNjlINTRVNisv?=
 =?utf-8?B?Y0FqR1hsb05laHRyN2ZpNWNDdkJOcG1kQzhzN0huYUJSR2ZiQzBVeFBrLzd4?=
 =?utf-8?B?akVPakovemVPZHBTM2p6WGhTMmkxbjlUYUNjeUZBVE0zVUM0bkoySnp1bytW?=
 =?utf-8?B?VC9UT3lsWUJpTzRuNWtVTTN6S0o4UEtRK3FSUEo3bkR0YTZOaGMxaGVUN0ZK?=
 =?utf-8?B?UzVBS1lWU0RZd1BzN2pNMzhlVlFYN1dmNCtsVEhVWjJ1NHExUWF5L1o2NDlS?=
 =?utf-8?B?eVhZSDJqVDBScTlRYm01VGFFYkZidWJZWkxBeW04MWRON3hJNWc2cTJLU1cz?=
 =?utf-8?B?QmlyWHNYcXJMOGNmNmx5K21JVkdteExFZ2p3U3hMdkJOWE1LVXQzSVlsTmYr?=
 =?utf-8?B?OStPV3lLMFptemxac1llcXFIMExiekRTM2Jyd3AycXNEWDhTWENFcWVJVG93?=
 =?utf-8?B?SXdFNS9wVnZyNnZDWkFkalltbzg1MW9BZkExb0JwN05FSWxzbTh2WGdGT2l3?=
 =?utf-8?B?VDdqSkw3WGxwZDdrYWVhZzZQbkVUcDg2eFV0SWdCRkdCLzFYZ2hMSDUvYTZn?=
 =?utf-8?B?NXgvOGRFVHllNStGTHVWMXdJbmFZNFFQNld5R2c1ZWh5d3lKVzA5ZlJFVUpx?=
 =?utf-8?B?QUxFR0JqcGNiOVk3YjMzc1g5bGpvaDRXUlBseTJ4NGllYmxvQ3V1cWxTYUd4?=
 =?utf-8?B?WVV2dEVaeForUVNoMWFoMHZBcHFhSnVZMVZGRUR1NDZ3VkJHMXF2TFlSV0xZ?=
 =?utf-8?B?M1hKUjZnQncyNTR5Qm1kUkNqMVFZbUlhVEQ3aWUvT1NXSS82ZXpBMDFkWml3?=
 =?utf-8?B?a2tmS1pmbDRLSzRXZFVyckgxd3FFZW5SOWt4S2w0NGl2UTZ6UUxmeFQzWDAr?=
 =?utf-8?B?Rm5hZk0yVGhFcVpGdktMbUZzVFpTelZoRWFLaDBBZnBDUWxjVmR6YmwwWFlx?=
 =?utf-8?B?ejhwMlZ4WEZBS2hYS210VDNNdTIxcUkxMHNsZTgyamhOaXhERlkyM3FjcFZE?=
 =?utf-8?B?VTU2UXZWUm0xOWMrek9CcnpHRWc5MVFKMjgvWWc3YnI4QWluTXM2TWUzQWJT?=
 =?utf-8?B?eDJ1Q2h2NjQxNUlqTFltSnZrbzh2SjMyL2lrbUMzVExmckUzMEZxWGw1bDAr?=
 =?utf-8?B?QVFyK0lreThzQ1NBU2tTSkIwak0vajd3V1hHejNsblhhTzBMQzhEb2dmWkto?=
 =?utf-8?B?V3lITTkzZzRjamdqS05yMW9iT2ZVTFRuanMwaCtmWEFEbm1hZ0tFa00ybHhV?=
 =?utf-8?B?NEdNNHV6TVoxdUdRcWRTTDRGbjE4dVhwSXR1amlzdTM5NVBNN0hFbEk4SDQ3?=
 =?utf-8?B?ODhJNDVERURPSFFKd3RyRW9KNzFNWWlmOEVhVndBTUNYYlQ4THh4MjNCSDh0?=
 =?utf-8?B?Q3IvODN2UU52dnJ5dVhIQVZ4aFpNcm0vTG1rWS9IK2kxWmtGT1V4aUFZRFRp?=
 =?utf-8?B?ZDBYSTFIcW5GaHkweXFTSFFId29HMWJWNVVyWG5LTUd2QlpHcWw5THE4azY1?=
 =?utf-8?B?TWZCSXZJT1QvSzNJWHZZNjVqV0h1WHBFTXRMTjBIYlNjZDNjYStITVlTZ3lM?=
 =?utf-8?B?SU4xVUswdnpKcXNsd1BTTlZXVnRVSnpkN1NCSkNUbEZVeitWRGdJdDVFcUIx?=
 =?utf-8?B?c3hNQUhCek5KWEpYQmJ4WU9EYVpkT2J6b1IwMjF1aEdyZmY1STRRYXFmZFdl?=
 =?utf-8?B?WnRpYU1WZFRDc2srNWw0RFJUR0pJMU9LeXc2Z1YwZDRaVDVGVlRlS0l0WWsy?=
 =?utf-8?B?M25qN2MyVWpnQm9adnRheVloSVpZaHloVTEvbmdRZ204aHFVWDg3TFNBZlBQ?=
 =?utf-8?B?N0lPMStVZVhSQXZvTXBKbngwRE9oOTFaeStwclpHbnpvUDh6Y1dJemhOSXdz?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DeRzKyoUf56wrSWAacJzzwTlvaV+YaJOI8/qmIvDxPWKKfradtFkbxTMkN6pNUKKzsnSWKGBfDiZtP5aKFb0TCGYU0kLwvgAcOZ4zmFY//iOYZZsWcYtgNmntDwQrgW8aeXJpy4mihx61s+6tuXCD/VWiX23lxnI9cpMO7F92yb2d22UU2Gm7CaOEyj1CSMaIiRi8YaJc3fwkZkZlHKg7vrY+8nY96vTZutPtZ2a6Gb16Kmbec0Wg/w5MkXYlrkyg3fufBoGIGrrD+cUAQwewCuNSCXTUvO8z4xMCilSR1sWfhOn1U1jUMvnc7bnrPXT1DsodIgIgyenbS2og31uOMSbOTtqjB/dOKPCXdXbPlEKrvsVk34M4v3qdrT0+OWE6GJIr6i2K/GWDvmCYjKyiwW33T5Pnb/n2IrS79VPzCOAB4oy80lrINzzJxe00UKH69AmhGUnNjTFL3S6H/8gQlOso3cKs+6aXQoEcpmMbLcGX4Sy7LcZpwIZsTxkWl3gyUvtigEcWyS/k404sLHIQ7VFxon5hdmq2Xy8lUpiwYfFfFov2jL/yBNzbfPPROemWpub2YvLr0GU5O431+UjB1hj+yF67N+gdPeStwrHUvo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b22f2d6-b016-4386-ef84-08dd82a6d03d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 20:38:32.9111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3m5NkCzOkovgQ8rSa9yV+CPt8jIOABkAA5gNRC8ETCaKw0DhM3dnsUNLgljscsuZdcFuj1ppkXRAAf7Cys1OvibqYG/+9LSxhKW8Y9QOii8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_11,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE0MiBTYWx0ZWRfX4BzKNhsY4IyJ E7NSypb85rVk96gp4DNChZ3lg8m0z08BlfdXs0y92Lhawm9MMFkGpSgxoCRpFgQnEkeXtwVOTq2 G0Vh21x8dYW3yqphnuOmeCs+eiYQ0Sox6d1kuiwKbVOEo94TC0ASkbnpYan67zF4hnRoAxE+/uK
 cI5B33qbqjcs1n4YfCO05eZxFKp6TwAUL4NZRqJntbCEIBxye4XlDhqVQgRkybWOkh8t2Y6RaLp d5rR9rcBQ+FvBWBmDFStB6kYSbI5TvwHBm28z7jgvJML/tyd2C660mPbFPdbjxMI8h6Kk5sI0z5 5hpKkP59q3L5kz6nVKdbLlvFqAcqIU39Far/vuG6XTs0PCCgfmP3qjsyur9H2LE9q7kQzGnLRSe fvcbYCzy
X-Proofpoint-GUID: 0D-5UTGMlUZf7v4Aq2PM2bcZD1qB8FK_
X-Proofpoint-ORIG-GUID: 0D-5UTGMlUZf7v4Aq2PM2bcZD1qB8FK_



On 21-04-2025 21:57, Ross Philipson wrote:
> The Secure Launch (SL) stub provides the entry point for Intel TXT to
> jump to during the dynamic launch. The symbol sl_stub_entry is that entry
> point and its offset into the kernel is conveyed to the launching code using
> the Measured Launch Environment (MLE) header in the structure named mle_header.
> The offset of the MLE header is set in the kernel_info.
> 
> The routine sl_stub contains the very early dynamic launch setup code
> responsible for setting up the basic operating environment to allow the normal
> kernel startup_32 code to proceed. It is also responsible for properly waking
> and handling the APs on Intel platforms.
> 
> The routine sl_main which runs after entering 64b mode in the setup kernel. It
> is responsible for measuring configuration and module information before
> it is used. An example of entities measured on Intel x86 are the boot params,
> the kernel command line, the TXT heap, any external initramfs, etc. In addition
> this routine does some early setup and validation of the environment like
> locating the TPM event log and validating the location of various buffers to
> ensure they are protected and not overlapping.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>   Documentation/arch/x86/boot.rst       |  21 +
>   arch/x86/boot/compressed/Makefile     |   3 +-
>   arch/x86/boot/compressed/head_64.S    |  29 +
>   arch/x86/boot/compressed/sl_main.c    | 597 +++++++++++++++++++++
>   arch/x86/boot/compressed/sl_stub.S    | 731 ++++++++++++++++++++++++++
>   arch/x86/include/uapi/asm/bootparam.h |   1 +
>   arch/x86/kernel/asm-offsets.c         |  20 +
>   7 files changed, 1401 insertions(+), 1 deletion(-)
>   create mode 100644 arch/x86/boot/compressed/sl_main.c
>   create mode 100644 arch/x86/boot/compressed/sl_stub.S
> 
[clip]
> index 000000000000..5e0fd0d7bd72
> --- /dev/null
> +++ b/arch/x86/boot/compressed/sl_main.c
> @@ -0,0 +1,597 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Secure Launch early measurement and validation routines.
> + *
> + * Copyright (c) 2025, Oracle and/or its affiliates.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/string.h>
> +#include <linux/linkage.h>
> +#include <asm/segment.h>
> +#include <asm/boot.h>
> +#include <asm/msr.h>
> +#include <asm/mtrr.h>
> +#include <asm/processor-flags.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/bootparam.h>
> +#include <asm/bootparam_utils.h>
> +#include <linux/slr_table.h>
> +#include <linux/slaunch.h>
> +#include <crypto/sha1.h>
> +#include <crypto/sha2.h>

consider header reordering For clarity and consistency

> +
> +#define CAPS_VARIABLE_MTRR_COUNT_MASK	0xff
> +
> +#define SL_TPM_LOG		1
> +#define SL_TPM2_LOG		2
> +

> +static u64 sl_txt_read(u32 reg)
> +{
> +	return readq((void *)(u64)(TXT_PRIV_CONFIG_REGS_BASE + reg));
> +}
> +
[clip]
> +/*
> + * Process all EFI config entries and extend the measurements to the evtlog
> + */
> +static void sl_process_extend_uefi_config(struct slr_table *slrt)
> +{
> +	struct slr_entry_uefi_config *uefi_config;
> +	u16 i;
> +
> +	uefi_config = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_UEFI_CONFIG);
> +
> +	/* Optionally here depending on how SL kernel was booted */
> +	if (!uefi_config)
> +		return;
> +
> +	for (i = 0; i < uefi_config->nr_entries; i++) {
> +		sl_tpm_extend_evtlog(uefi_config->uefi_cfg_entries[i].pcr, TXT_EVTYPE_SLAUNCH,
> +				     (void *)uefi_config->uefi_cfg_entries[i].cfg,
> +				     uefi_config->uefi_cfg_entries[i].size,
> +				     uefi_config->uefi_cfg_entries[i].evt_info);
> +	}
> +}
> +
> +asmlinkage __visible void sl_check_region(void *base, u32 size)
> +{
> +	sl_check_pmr_coverage(base, size, false);
> +}
> +
> +asmlinkage __visible void sl_main(void *bootparams)
> +{
> +	struct boot_params *bp  = (struct boot_params *)bootparams;

remove extra ' ' before =

> +	struct txt_os_mle_data *os_mle_data;
> +	struct slr_table *slrt;
> +	void *txt_heap;
> +
> +	/*
> +	 * Ensure loadflags do not indicate a secure launch was done
> +	 * unless it really was.
> +	 */
> +	bp->hdr.loadflags &= ~SLAUNCH_FLAG;
> +
> +	/*
> +	 * Currently only Intel TXT is supported for Secure Launch. Testing
> +	 * this value also indicates that the kernel was booted successfully
> +	 * through the Secure Launch entry point and is in SMX mode.
> +	 */
> +	if (!(sl_cpu_type & SL_CPU_INTEL))
> +		return;
> +
> +	slrt = sl_locate_and_validate_slrt();
> +
> +	/* Locate the TPM event log. */
> +	sl_find_drtm_event_log(slrt);
> +
> +	/* Validate the location of the event log buffer before using it */
> +	sl_validate_event_log_buffer();
> +
> +	/*
> +	 * Find the TPM hash algorithms used by the ACM and recorded in the
> +	 * event log.
> +	 */
> +	if (tpm_log_ver == SL_TPM2_LOG)
> +		sl_find_event_log_algorithms();
> +
> +	/*
> +	 * Sanitize them before measuring. Set the SLAUNCH_FLAG early since if
> +	 * anything fails, the system will reset anyway.
> +	 */
> +	sanitize_boot_params(bp);
> +	bp->hdr.loadflags |= SLAUNCH_FLAG;
> +
> +	sl_check_pmr_coverage(bootparams, PAGE_SIZE, false);
> +
> +	/* Place event log SL specific tags before and after measurements */
> +	sl_tpm_extend_evtlog(17, TXT_EVTYPE_SLAUNCH_START, NULL, 0, "");
> +
> +	sl_process_extend_policy(slrt);
> +
> +	sl_process_extend_uefi_config(slrt);
> +
> +	sl_tpm_extend_evtlog(17, TXT_EVTYPE_SLAUNCH_END, NULL, 0, "");
> +
> +	/* No PMR check is needed, the TXT heap is covered by the DPR */
> +	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
> +	os_mle_data = txt_os_mle_data_start(txt_heap);
> +
> +	/*
> +	 * Now that the OS-MLE data is measured, ensure the MTRR and
> +	 * misc enable MSRs are what we expect.
> +	 */
> +	sl_txt_validate_msrs(os_mle_data);
> +}
> diff --git a/arch/x86/boot/compressed/sl_stub.S b/arch/x86/boot/compressed/sl_stub.S
> new file mode 100644
> index 000000000000..6c0f0b2a062d
> --- /dev/null
> +++ b/arch/x86/boot/compressed/sl_stub.S
> @@ -0,0 +1,731 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Secure Launch protected mode entry point.
> + *
> + * Copyright (c) 2025, Oracle and/or its affiliates.
> + */
> +	.code32
> +	.text
> +#include <linux/linkage.h>
> +#include <asm/segment.h>
> +#include <asm/msr.h>
> +#include <asm/apicdef.h>
> +#include <asm/trapnr.h>
> +#include <asm/processor-flags.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/bootparam.h>
> +#include <asm/page_types.h>
> +#include <asm/irq_vectors.h>
> +#include <linux/slr_table.h>
> +#include <linux/slaunch.h>

consider header reordering For clarity and consistency

> +
> +/* CPUID: leaf 1, ECX, SMX feature bit */
> +#define X86_FEATURE_BIT_SMX	(1 << 6)
> +
> +#define IDT_VECTOR_LO_BITS	0
> +#define IDT_VECTOR_HI_BITS	6
> +
[clip]
> +	jz	.Lwake_getsec
> +
> +	/* Wake using MWAIT MONITOR */
> +	movl	$1, (%edi)
> +	jmp	.Laps_awake
> +
> +.Lwake_getsec:
> +	/* Wake using GETSEC(WAKEUP) */
> +	GETSEC	$(SMX_X86_GETSEC_WAKEUP)
> +
> +.Laps_awake:
> +	/*
> +	 * All of the APs are woken up and rendesvous in the relocated wake

typo rendesvous -> rendezvous

> +	 * block starting at sl_txt_ap_wake_begin. Wait for all of them to
> +	 * halt.
> +	 */
> +	pause
> +	cmpl	rva(sl_txt_cpu_count)(%ebx), %edx
> +	jne	.Laps_awake
> +
> +	popl	%esi
> +	ret
> +SYM_FUNC_END(sl_txt_wake_aps)
> +
> +/* This is the beginning of the relocated AP wake code block */
> +	.global sl_txt_ap_wake_begin
> +sl_txt_ap_wake_begin:


Thanks,
Alok

