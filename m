Return-Path: <linux-efi+bounces-3344-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5348DA8AB32
	for <lists+linux-efi@lfdr.de>; Wed, 16 Apr 2025 00:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA8F3B2C9E
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 22:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BAC275841;
	Tue, 15 Apr 2025 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eNkRdyBA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tuM7rXcf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7611DE4C3;
	Tue, 15 Apr 2025 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755454; cv=fail; b=HwGaoB3Xg7eBq4lm+fwqsXEyjQHlDD6hRPuJ4lcu9bvttmeu5cFirB8XIveAWVWf4w0WCgG0fhCTxzGvSU8LoZTFYk600s3Q4s8ytFO91xEthuqN1rauFkUhhkcBey9oahPnH69gwFSIRPeCvuhfui1o39r0QlC0u7YVZBXAetI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755454; c=relaxed/simple;
	bh=5jmrIqQfdKM5Ver6L/Ia3XBJn/UJHJdxH9sdKxNhy9Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NPRuxZAvGUpICAmrvgy1m2SVXRUQb5GzK/CBOXbh2QFqMYxdE83OJOFxzlOrOmGJ8Mx9uEmLS+O1EJ3S6Iaku+0AyiKRJaZGCrXMILRYnWabyVhGpYSTSgOjMZbc5D0hTjrgWMrWCZ0fIxEjpSe/kLLCRImzvM1ke2GH0drMGE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eNkRdyBA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tuM7rXcf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FKu1en027997;
	Tue, 15 Apr 2025 22:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=O7Onn5V6bB4u9LDHpwd6ST/qIS3SmpdMDDk+8KHfaP4=; b=
	eNkRdyBAuAv0qsX/QK+gHbh7nPQpcnDqfcShsDt8MAlClbXpLtfCTNIn/SEu/w35
	TCQ0/jvO8t1fZ7gv0xGbOg2E9SehiDVNj0GCjbgZrLFnkbPwH9jPicV+6SkCOh6g
	ZzVCMZzvLHXiVpPSLbvF/J3qpBFrBd8LzSQsesRfpcY07WWJw3uf0WP7gfIhyYKV
	U8ZuewbJsJDzLI3t6GKobgp6Cnfs4tXxOvqC6bin/g296MeZ6W7OZKeR5jPowbXc
	lXCPAW/pwwm+orwf2aemIT7oMH1kSE6kSJs5fWbIue9/XC1r3aB6ZONWsYI9OkFe
	TaDgtU3+6cb6j5efGWpaLw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46180wavps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 22:16:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FKTvDX030983;
	Tue, 15 Apr 2025 22:16:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbb919e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 22:16:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnXe7fGcGX4PNk2VbA1yRASQnSYzbXzDxi9pja8i/rgyL7BRRsp07+ezeOc+ORpR1T7lOU7kiFS5vRLsVPBwJB5r9fem+iCz921NBVSM5HzEqxg7purBUtJr/Q9rOvEV7rpD1mQEEgTrTp8OOxP2Yra/ggpNqaeAtCBkHvOWKJsqB4I2EfKbwjNwssrKSh6VwGa3IBSPWBfxjkjV4diivw+Gk1+6K5YsaEgcr1aD/r7w61ccCGp8x1hUXSmU5/FCDuQgFpwYrsTYl4SOOaueJ7LPdODfZxjn3kiS17JI0aaMPCoYN9ANqm76/7Q42x6P9lv5obYRR85vmVjKAZe1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7Onn5V6bB4u9LDHpwd6ST/qIS3SmpdMDDk+8KHfaP4=;
 b=yf9lbkgdL3qwCRaVLuVc6f9PL/hTCmcauMhGnLLvYlmXlD15uAcASwJnKNuo0qTt+Fiees4q0ssRl0OtJ+LvuhAcduM9kUhtx5gwgcqFfZhGu9VEsKt+a3AB1i4AoP7Xp7G4khZ/I+DvbqVCLJIkU6PPN5mn4VDqHQx3JV+TbMhzhr3hwN1Sw3Amn3T3lEW7tABaS8ZmOcs5KQtPRMF/5qr61cLyaXXXwlldnlweW/Rvv5+AsEMSeoyONIl0j3kQwP2/AFF8Gz6WbFCmt43kyLINJlsp2iZJFTAEWlp5FjERnqhB5TS7UcX/PtsXgmvRkFc0pLMNs5kXivyCJ9jT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7Onn5V6bB4u9LDHpwd6ST/qIS3SmpdMDDk+8KHfaP4=;
 b=tuM7rXcfJqN8EWpfSRtyrcWU5bRS1162vI80vZpY9Thga4OyhREWu5VzaGfr1k07Y/WduBZlqvhdwVp0eoPwc7janikFrbA8oejTmmHjqC3hkeNKHo6oqK+UlrkKlGwJnTPYNtVZ58ndsymQU54TTGaMzjlHswlNWkMwa4CQbF8=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CY5PR10MB6071.namprd10.prod.outlook.com (2603:10b6:930:39::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.21; Tue, 15 Apr 2025 22:16:50 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 22:16:49 +0000
Message-ID: <981894aa-0db0-42e7-a18f-f9d73e75010d@oracle.com>
Date: Tue, 15 Apr 2025 15:16:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/19] x86: Secure Launch kernel early boot stub
To: Sean Christopherson <seanjc@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-10-ross.philipson@oracle.com>
 <Z_mMaAykU0IVKsjU@google.com>
 <e781cabc-90ee-48cf-9a09-116a8edace1e@citrix.com>
 <Z_7aeWAxBSdU6cvc@google.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <Z_7aeWAxBSdU6cvc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:a03:331::11) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CY5PR10MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1d9298-9a84-4285-6e6d-08dd7c6b37ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXhOOTYwYzIyVHpWUlpUUlJKRWV3dnUrL01jdFBldFh1Q3F6MUo1VDdnSlIx?=
 =?utf-8?B?ZWxSMno4d2JOTlNOU000OXZnZStWdzhRTEtWazFNSFM2bjMwTnBZdlBsQVpW?=
 =?utf-8?B?SUFNd0pYOHVFZVNuSUNBdzdBanBHemk1V2hqdHJubUZ4bVMrQXZ6YTUyS01Z?=
 =?utf-8?B?NktsVEVwSU9xSW5JS0FMNlJuNlNvT2Z2U2liYjJ4OUVNNVZJanEyMG4ydHdV?=
 =?utf-8?B?UktoUXpLVVdxS3dBbklVTllVRTNVV1c0aE1BemthWFVaYnhZU3FhSmFJZGlK?=
 =?utf-8?B?cDdpUWRLYnZnZG9La1FMT3ZGZzdiek1oUHNqaXp3SStGNDh5Z0RQeU5hS281?=
 =?utf-8?B?dUpUdG5vQ3hwckxpZ29ZZW1WMkxUbFJISFlVZGl0SnRma0taMTQ4ekk1cXN0?=
 =?utf-8?B?Z3p2Zk9aVlpaMkdEeHkzTnZRRmZDbm5tSGRBVVh5M2ZXYVB4TUprRjJ6M015?=
 =?utf-8?B?UG9VWS80dTVLYS9WSzc1bHFpajgrVWpTcjVzeHFXbW1obnN2MEM2bndRRFBj?=
 =?utf-8?B?QVBpeWVlaFB2YjFndXhKUERPbXRLY3Q4TFh1S2JoaHVFWDZvdVNWZTN4QjNZ?=
 =?utf-8?B?dVdBTjlEMHlXMitjcDJtdktGc2VjZzhWQWs4YW9iSEtyNDVLcFVtQ2pYUjZG?=
 =?utf-8?B?aytmb2JYTWRiUUVaMjd2WXRvOU1IS3VDdm5VVDZHTjhmSXg1MzJiNWsyWGdD?=
 =?utf-8?B?QitUcWZrVUhTYXFhNEd4SnNTQnpsdlVCcEQwYlp6bzVYOUErSXBwcDl6cCtF?=
 =?utf-8?B?aWgyUDEzYjJtTkkvNko1WVI1RGNzakFJeXlvVnN5aW5oWTdoUVNPTkFrQlcw?=
 =?utf-8?B?UXFXSnZ3bDhWak1KY2JRUk5TUXNBWkZnZTkyMnpMYUt0Tkk3N2VZUVFjNEtC?=
 =?utf-8?B?SUhVNTdtSG5KNTNTdGpLdUUxQWdsS2lWSGcwR0FPdkk0WFk4aE5OdldpNGVF?=
 =?utf-8?B?dkV3anFBNlJLVVBXYVkyMDczMjBOQnpnNDkzQ2EwaUhxaVBLNVRMTEt1NHpl?=
 =?utf-8?B?MW15SEhLNGxweEdQRmNSNTcvdEJPNGJaWEh5Ymg3OVhxTktHbWJnZnp0clgv?=
 =?utf-8?B?TUhsV3pvZXEwWWFvWEFENjFpWUlhaHlYVTNPNFVoSEx1UlcrYXVJRytBcXZl?=
 =?utf-8?B?VUxTc1JjdzZhQ0pyaGh1azhZNW4xUnl2N1BybWl5SmtaamJNeTUvNTZLNkkv?=
 =?utf-8?B?N1RFVDZkL3FWWHhYcnFDb084ZnNZQ3dyTDZYZmVsL3BOYjhtRDZVb2kxKy9y?=
 =?utf-8?B?NmdSYWFuOFlVUFhZUks5cURTNkJXdGkxWXM1eUJCRDcwTUcrd1BFMFduQnNH?=
 =?utf-8?B?dENEakI2NE56UnZCNXpQS1hFaTNnbzc0U096SXNPdVdSK3ZscWErVCtFWk9M?=
 =?utf-8?B?emtMSzUyTjlpT2ZxeTNhSEdSL3VRUUl4TmRnRDhxMkdaNlpvbzd1djFPR0Z2?=
 =?utf-8?B?VnJ1UXBsUk9YTU52RUJLTnVYM1pHZnFoOVZja0IzRGRYZkpncUdlb3NCSDlJ?=
 =?utf-8?B?MGpQakhhSFdwVWlqRk1yaUF4QjR4K1E4VGNVc09hcDdXMG5WdUNsVXMvT1Np?=
 =?utf-8?B?Y2ozSndhUmI5WDNDaUlXN3VPU3BjdTg0ZzNEUkgxZ3dudnc4OXZCVUpCTmha?=
 =?utf-8?B?VWJPNmtuVFJGL3dhbXFwOCtiT1VLR0xqUFUvL3JZVUxaUnBqMnVjeWM2dlVC?=
 =?utf-8?B?MnBVc3l4d2xJNHlTZ2YxMlliQ09ROFVIOWpzVVlBRk91d2h3eUVuUEVabHRj?=
 =?utf-8?B?OTY0MVI5MVRQQjhhenQ3NUppeVduMXhVbHIweEF1Slo0Y2lvUHF0Z0VDTDRq?=
 =?utf-8?B?cTlENXlUamE1QmtaZ1Q4Y2lsRnI5ZDdhUDgwSmlFb0xVUDc1aHNiMmVQY2NL?=
 =?utf-8?B?dDh6OVlTTXFDK1BUdjlYSzVVMlZjcThhUVdPdGdaVEZUK0ErMjF1eDhFRWxO?=
 =?utf-8?Q?TcXMWZb5fPI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG9HZjJlYmpPT2dTQVhXZFdiZEw3UXk3TTE4aERwUVNZZDBIOXhOWXpSQlNv?=
 =?utf-8?B?WGJlRGY4YWNiR3VkNjJqVmxXbFlGMytmUm8zWWNhdXZGSS9jMUlnTDhzTUNT?=
 =?utf-8?B?NWZpMEJhRS8zb3dyZ1NlRWVpSmRVOFJOL1o4ZWUrdTVvZ3B1akJ5cVdTRWcz?=
 =?utf-8?B?TGtGTUZKKzB2Qy9uSGZEZEV5QTVZcHZzNjNrRSttZElIbVdpUHY4VEFseFVV?=
 =?utf-8?B?MTZPQ3lIaHpFd2lJTU1kQTdpdURXeU5ZN3RMMnJnZUU2dzczbmg3VnI1MXV6?=
 =?utf-8?B?RFh6TlY2Y0thamRYSHBKdVRQalJvbjR5Y3Z3MEplTGZuUHgzcERKYjEycml3?=
 =?utf-8?B?RzhjMGhnV1hVREFGNlZuVW1ReVM2K1N4WnRBZWlKdzhsZU9UU01tc1NIQVVv?=
 =?utf-8?B?czVvbjh1NXBnN01aN3cxRXo1QkRxUGlZTW9NTklleUFtSXdVazYzK1NSby9K?=
 =?utf-8?B?UU4rVERCSHJqZ3NxQklqblF6NUJ4TWc3SUw2cE5ZcjEzdUxFMkRob3ZlQ3Vq?=
 =?utf-8?B?OE9kT044MnFFMzBPQ3JNMi9Ud3hMcituTGIyRll0REF2UDRxVkhHTnJLcHV5?=
 =?utf-8?B?K3hpek45QUVKdTcrZ2FYTGViRnZQSHh2ZnFnK1FzVmtCSlZMdWtzR0phKzlD?=
 =?utf-8?B?R2JWN25YV2Ruak1PaUUzRnBnZGdIWFZia1hNMHRBdjQxVVo3VkZOd0lkNFJU?=
 =?utf-8?B?MGJqRWFlQiswQUlCMlc5OUJHcG9GTVdNUnZ5OHJLNXUzdm0wUTludVVmbkM4?=
 =?utf-8?B?ZzFEN2NNbmJ6ZVdSVFprdjdJeXpTY3VMMkJIY2lNZDhhQURjYmtyYWczcVFN?=
 =?utf-8?B?VFBmV0t5RGpNUFo3NXdITkF6dzVnMVNtY1Y4M2RsL0RQbzRjemdlOTljeEMr?=
 =?utf-8?B?T1RpdjVpeU5XTjk2QUo1WmxiaVk4WmcxSXBpdzNHako5R21RaW41eHZTMHUw?=
 =?utf-8?B?ZjN3Sm9YdW8zbnRLVDh1ZVd1QTRER2g1NVFKaFowdWg2dDJjcm5lenM4aFRM?=
 =?utf-8?B?eXNSZFJQRCs0eTBXZHQyY0IraHRyaW1pZzlsSXdCenBvR0k5bjlGZ3J4alRW?=
 =?utf-8?B?RWV0WHBFZjE5Smg0Qndldnd2N1ZUQ1F6NUwrZDlJTVk2YTliRTlTZ1plUlJt?=
 =?utf-8?B?ODZ0bXpxTnpJeTZYeE9nTFRzR0Y5a1A3Q2pkVTZUMktzeC95MkdKYnRheHpV?=
 =?utf-8?B?TStjWk8wbzJTYkRwMEVmTEE0YU1LMmRPYWJhWlJaSnpzcHdHZ2tFcWw1SERY?=
 =?utf-8?B?cTJYeHJSZ3Q5eElBSVJWOXR0Nm4wQk1EUGd3Q0QvZGZaNnJGbU1VOEs1SS9r?=
 =?utf-8?B?Rld4VFBaNXJBallxN2x2ZWg2ZkFCTFhJOVlaVFNvVWtJZ0grdDdqUW5UTnNP?=
 =?utf-8?B?SkNhcTFLWjZlR3ltTDM2REZyaGdMQWl5aDVBQzRDcDlnamEwY1AyT29qaHhs?=
 =?utf-8?B?TjFSZTUydXZXcDkxS3I3c0FLSGs0ay9RdXFaRVhyTUVHUThNQkFLRy92cXJO?=
 =?utf-8?B?RTdZdTUraDJndWpWU3VFQ1lGcFMwdmVVN1pITHhpVXNiZDladURjQXpMZ1pB?=
 =?utf-8?B?aDlTQVpMWkc2eWFyRGt0RUlKMStRek5KM2hUSzBjT3UvZUFDVjlLVkdod3JJ?=
 =?utf-8?B?YWxubGN1a2Ftd1BLa2UrUzkzeUovdDltSGFqYktmeUpaRmZ1d3VsZnFic0tv?=
 =?utf-8?B?TUdhR3I2R2E5aDFtdzF6MmxlcWFxeXJpQ3FVRG9vMklwQitHeFlZZHBMeGJk?=
 =?utf-8?B?NmhvOHZ1aTg4OUdIcVIvMXRFQjBJMWdwK1ZoaXZ3emtsWFd5cHBZemFQUUJu?=
 =?utf-8?B?anlENkxrUTVWOVhnbFRDcUhWUGdveFUvNTVSUWVvUDRpUGNyU1ltY2RaSEpF?=
 =?utf-8?B?cy9nZUpUOWpTYno0M05pUms4cUo4eG1TMkhMd2RZUDVaN1ZnanVUK21sdnZ6?=
 =?utf-8?B?aS9GWG5WWkRucVhYSktLVFlZeGxYVURUemFNb3poa3RjbThxamJRWEYyWUU0?=
 =?utf-8?B?Qjc3RmNzb2NQTkN6aGh1WkFhamJQK0pDK2pMR3BTTjZLL3Azc0k2d0ZRNGxT?=
 =?utf-8?B?U1dLdEV6VlRzMHozTk55RVJUVTVQKzhDQ2k1M0RkK21tdXpOWUgxUmx3c2Uw?=
 =?utf-8?B?MC9GQVBJRVJYc0JEZHdTOHZGdGQwNkx6RlB5QlVRY0JBMWd1cExPOVdCcmRu?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	batsWyYL3JlnWyLIRrDdSB0JyVlPmssZASZGdKP+xQyIjaekZoWZ0APezujkRrZGMWjJsf17QXVLB5XtBeU0rUBY5E8PbqRNKvmSC+8qCsbca0Ual5uxRFrJCR+DIE/I2n4QZhXRjp74TTWTKAG4US4wDNvtLZpWO590MW8SVKpGF/3pZI8HLqQMv4ezxqK+jsPOyihrZz3bk7UJF1K2RdSH3mVjBiE8XJRZ6xZFDZJEdFGYFPLbJhN5mIrry9HrvOsadiJd4OgLU403Y15B/tG8wsKzj2xo7HNEwspoZG95hInnR9qNkVl6clhndPVpv/JDCR4sARYIoke1jKxFe5s3m01vqFlBZe23+boSUy18N91W4C8b9INstMB/JOM8J9728uF7evTqNgT5/1DWdweAR5IPeC+8vt2HVOhN5wM6xW2wuhRI9tWKJWkgHgO/QFPTckjLCxeHuMSHJ4imhLGhJYvohQwQCKRJVga0xlOHFN47TJul0kaygmA4OY2jebJEpR5cROs+zzN/PX9afrNeqIGERiPDE6hkNBuN93ADc9DfSGl9sVU8YiVxf8bGxqBEt1zdoUbV6+UXj79py7LWzjnztIgyTpFWA0tg0xs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1d9298-9a84-4285-6e6d-08dd7c6b37ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 22:16:49.7859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdpWlxR7ANMX+j3gPTxH2/hm3fPrdyMHMAU8Gc4sKrXwLstY8L2DIOfC50uDG2ni2DJOzALOOK57vGVZmX9G+2XoS31FjERt9IOS8mqL1ZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_08,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150158
X-Proofpoint-ORIG-GUID: i3iyyxswUsSfxtjzkEKMKufhD-hoDCxa
X-Proofpoint-GUID: i3iyyxswUsSfxtjzkEKMKufhD-hoDCxa

On 4/15/25 3:15 PM, Sean Christopherson wrote:
> On Tue, Apr 15, 2025, Andrew Cooper wrote:
>> On 11/04/2025 10:40 pm, Sean Christopherson wrote:
>>> On Thu, Apr 10, 2025, Ross Philipson wrote:
>>>> +	 * instruction can return for a number of reasons. Test to see if it returned
>>>> +	 * because the monitor was written to.
>>>> +	 */
>>>> +	monitor
>>>> +
>>>> +1:
>>>> +	mfence
>>>> +	mwait
>>>> +	movl	(%eax), %edx
>>> Why load the value into EDX?  At a glance, the value is never consumed.
>>>
>>>> +	testl	%edx, %edx
>>>> +	jz	1b
>>> This usage of MONITOR/MWAIT is flawed.  The monitor needs to be re-armed in each
>>> loop, otherwise mwait will be a glorified nop.
>>>
>>> More importantly, the exit condition needs to be checked before monitor,
>>
>> after monitor and before mwait.
> 
> Gah, yeah, I mean to say "before mwait".

Thanks Sean and Andy, I will fix this.

Ross

