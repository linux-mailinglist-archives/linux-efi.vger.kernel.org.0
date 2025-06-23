Return-Path: <linux-efi+bounces-3926-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76566AE510C
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 23:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B077D441301
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BBD221FD2;
	Mon, 23 Jun 2025 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qfW/ITHx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q1cC5Fxk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C19224F6;
	Mon, 23 Jun 2025 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714221; cv=fail; b=C1MLsbz2kMzEBwnHG7f7027FmOAaXhhE4G3BvyldpGzpjoW4K9TM40dDLrSDnCpIdsmAyc7cLvos0AUaGu6Ul8ZBFVU2ZKEVVXDcXjMLUbXlYcTHlaEb6jBMwx4e3nWP0kZhFzQ2ylStG3VtorYdbnGjOCeICq3XeXsm2pxWL/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714221; c=relaxed/simple;
	bh=ai+ACi3pwfhpDFOTkazwdGvKgNn+M8g0NR/J6SbHVXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RMn5+7HaSnSonQ9Ir1O937bENGcm+WH9ujy4NUXMH8zCgvj2azAx+U8nGsXUllsydm/pI6o9mVkUoLDw7P/3EaRteCwa+gblvJJ03CGBqLaRX1u7e7k2Og0SRW/hNUid/W+SQem+VxZNPpfbDEWvlFv5nVg6ycKLcT9VTelYznI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qfW/ITHx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q1cC5Fxk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NGXWdZ001328;
	Mon, 23 Jun 2025 21:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/gUrwGQ08DMv6lzXcLtcOW63z7PfMelSzPNpfgwb6kM=; b=
	qfW/ITHxZTC86WUBQIGx6W1eR+NJKDayzbEPYm2qQIAxON5MJrK79UJsfFOkf3ma
	3TEklwRPsdkd1drFqzT/TmpquwKz9YbZRpHnQnXkLKxO/mC2x0ZOS484Nh68PuPD
	/+wUeeOrDMTE9sKPxOERX85MUDbV+ew2npjNuWfPjXW67uqwZjFt8wGUs5bqubmM
	Bja6SNnvjRg67rHLlJD2QuXyrMiW8RPpOEsqHQoUz4MUefxIsT+5TikNDLTIxeRt
	jCpxHOGpZDK60FP+4zeXMnH3/jioY3M9l7eXKHxgXrDttJjlcuqZd9+dexnpD0zL
	GJ4RNbRqMBjV4KX2mwIqqA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egumjpw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 21:29:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NL7I9r025256;
	Mon, 23 Jun 2025 21:29:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvvc5ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 21:29:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTVS4BVpuY7rYMJujVymHQnr1c8KgcCMNKELLW59xCCz/XILSHB9Vf0Kra5GJT9COG/7HcLKUd5NzWOHysiwMAGGK+3VzmRyS5aJxojBa5CbyuRYFmpbC1Ko3nknnuEVP8iehOJXtM/qs1t3zwAu0aJ5eVsMBpfjebJMpEkHV5afaw1B3iQ4+/6OMwwjSvh6Eg3irFUHVNUSs4eG3G5wD8G5o9RBJg0S1i/je9Bl4AWjCcjymFgryWwDvARTUEh0fBysytyeYO3YgUIfGtsaAlcH0BJ764weOnl6aKE2e3MH86+dxu0dTv3yhVQrqpJpv9L/ynykThRIwR9+qzBslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gUrwGQ08DMv6lzXcLtcOW63z7PfMelSzPNpfgwb6kM=;
 b=xyVrbPKhMLo7cc3ZGFn0xzmL+nA0lgD0UhtIvK+ecKPugCH+yevwrQj5YonmFSlIP4M78ma22L6TQwSfcWl+pzZ1ptFJ7wj9JRxtqTIxZZYKVcNFHO7fvLBNAzZ9mgzpE8u1pljz53AHZeuBGfut5Bv6gqNuMYJX00WUlp57fj4mqYfJnr0oegid/rZdlaHit4PLuKzrldzFMEPUBs26Wx+4i9kFmq8KBMlKNIuNUgwZTEDHuRwg2J/LQDh7kfV6sThdqUMlTxUf+h+QyFd9sTxr+loswZrg+JC3bSUo9plahWpv6C0Wke/EXGINVgKHaQDkcQeot/urLrhiY7XdLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gUrwGQ08DMv6lzXcLtcOW63z7PfMelSzPNpfgwb6kM=;
 b=Q1cC5FxkbLJOeCd6OqcZM0kC5QJ7vmNTZFPk15CqbeQc+0x3VkPqBmF6iTG3qnoXbRPnLmnngFJUajGenHweUZ4V88WzpDJuc4iVDXgkYgtA9MjF3+SJyMJ0DukuqCJbUkSgBZZLiUS8i0hA/XHCFaRvt9T9msF7NEmHPvGAo90=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DM3PR10MB7912.namprd10.prod.outlook.com (2603:10b6:0:43::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.29; Mon, 23 Jun 2025 21:29:22 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8857.025; Mon, 23 Jun 2025
 21:29:22 +0000
Message-ID: <4b989c05-0d02-4176-8840-edfae99a47bb@oracle.com>
Date: Mon, 23 Jun 2025 14:29:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 04/19] x86: Secure Launch main header file
To: "Camacho Romero, Michal" <michal.camacho.romero@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev,
        daniel.kiper@oracle.com
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com,
        "Fedko, Artem" <artem.fedko@intel.com>,
        "Mowka, Mateusz" <mateusz.mowka@linux.intel.com>,
        adamx.pawlicki@intel.com, ross.philipson@oracle.com
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-5-ross.philipson@oracle.com>
 <e538d06a-fb9a-4b07-9a00-33879ea5c1cd@linux.intel.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <e538d06a-fb9a-4b07-9a00-33879ea5c1cd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::40) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DM3PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e291fcc-cc58-4fba-5190-08ddb29d04be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bExNRS9CZnYyS2R6YjUzMnJ2YUxFMUNyb1hXNlRkYno2Y0hkTmhCdFBWN1RH?=
 =?utf-8?B?VzdtWnpQVUZTNHJSVHRodEpLbTlackFCR2Q5Rlhqb3BUR3VDcDYzUnhwbXhw?=
 =?utf-8?B?WEV1elcvMzRlVXVVcERXSHQ1RGpoNUtVbUNHcHd5UUZleFM2T21hTXVuWDV1?=
 =?utf-8?B?bUppQlZwbFBsWmNHOGdDb1BvUkZvbmE3cnRrOVJ1ZXVoY1B0UzFZUzdnTDJS?=
 =?utf-8?B?SmJYYWFFMElGam05M3FOalpCR2dxSzM1MS8wWkF4NVVlWG8zTmdmTHhla1FU?=
 =?utf-8?B?MHc3bS9uTHNqaFlqOU9iYTlqN2tYNnEwMWFuS2ZTY0VoL2JkdUFvTE4ySCs3?=
 =?utf-8?B?N2FFd2dZQ3JpYVpHRkZJR1ZnNkQ2dnpUSFVKTDZWNFlrK3FCV3NtZFlKdFhj?=
 =?utf-8?B?ZGpYTGc2UUFneTA4Rm4yV0NWUXFPZzZDQmtkYTBobW50ai9TTE9XT2hCZk1Z?=
 =?utf-8?B?TkNRVEt6c3dTa25qTS9VeFpFcktKbzdGb1daNmkvTjJaRyt4SnFFbHhZKzRj?=
 =?utf-8?B?UTNnWTdlNWJrdGRPR0ZFc290dEhzVHNSWDNGS1JPSng3UG5ITHBPYnhVcUhF?=
 =?utf-8?B?cjFaTkNzZ3N0MjZqa2lMTWcrcjUrNCtqUkZ2aDJIeEZDTUZNS2RPWHdUdGw2?=
 =?utf-8?B?VEovWThLKzVsVGhFMFA4ZzkvdXM4QWpsaXNLRG81OWJRK08vOVQ4RDVla2t4?=
 =?utf-8?B?aDU1K0xOU1lsM0Z4R1l3T0lwYU1xekZWYWJyZUpuZ1AwSDJMTFpkanJKNkhB?=
 =?utf-8?B?Sm9FRUpBb2lJeldDMTJwcXl6SzMvV09nOGNmWXNZSFVyaHhrQzBxYjNGY2Nu?=
 =?utf-8?B?ZitEMGtJTjlIL0hOTGNtSlhKZEtGT3gyVjBGem9aYjc3bTJqcTh5RlFQbVVD?=
 =?utf-8?B?VzFiV2d4Z2NGWEQ4WXJnN3Q0SGdhREQwc2xIdnEydlZ5Y21mNkNCVmc4YmdR?=
 =?utf-8?B?Nzgra1dLcDhNYndhYTh3VmZRaThoWXQ5bkg5QWI1Sm1kR0VnSDFubktScXJC?=
 =?utf-8?B?VnA3YzVENzNQZDZ0aEY1d2d3Z3V5SWRQaGt3Nmxua1hrNU8zNGZiSFE1ejFK?=
 =?utf-8?B?eXo3SEcxaW1DV3lSL3grdnpBR0p6YjRtNStGU2RreGJrbTd4TStzT1pxaFhi?=
 =?utf-8?B?NVFTSnZqQUlFQndRVjhOMWNoUEgxR3FwakNhR0ZkbU1BWVFpNDFZb0NaU0M2?=
 =?utf-8?B?RzBJTFVlNU00Ty9YYXRQYmdCbHZXOXBCQ1JqRFY5Yk9zUTRYNkJ2VEJKQ1hi?=
 =?utf-8?B?T28zcHJhTE4zS3psa3E0SFQ5TjJsTnord3pHSVg1YXprZW40UzhIOVlBV1c1?=
 =?utf-8?B?MEZRYmtLNjk5RFNHYm5LZCtVSnBtcHRXeVh6U21HQWEvVXdKd2ZmYVZhNWhY?=
 =?utf-8?B?YUlHQlY5RWNCMzJoZUVjdUlrcFZOTllFWmJ3MFZhWng4NXkrMEF4VHk0QUFD?=
 =?utf-8?B?a3lkaEd0SjdRbzlYMnNYR3l4NWJTR1hxaEFra1J1S0J5eU8yVmwvZGd0VlJ5?=
 =?utf-8?B?Q0JDaGVDamNyemJFVXRuUm9RT0xtSEUyUHQzTVpPWjArekxTZDNUdmdyZ1Bz?=
 =?utf-8?B?RUFmc0VFZjhJU2NnbE85cERLaXNnRkltak5HOG1zSVI2RmdiT0RZMWR1TFdN?=
 =?utf-8?B?RGRldldyY3lzOU5QNjBIN1BSY0VVdkUzQlRHYTJxaWZ4cXBUcXZmV1UybHl1?=
 =?utf-8?B?STg2SlFGa3VtV2dMOHlPYllNNHEwUWl0b2RpcC9BL3kwcnlWR0N2S010OFRh?=
 =?utf-8?B?dDQ4ZWRIT3huMy9iM3JlRDl3eHhLd0lIU2NReGswS0pJbzlrZHJKT2xOeTA5?=
 =?utf-8?B?MzcrMFVFQnFieWtsaXE2M0tsVDFvQ2ZnVnFETm51cWd1UjV5UHZWRjFtOXIw?=
 =?utf-8?B?ano2QUJsNVErUTNyT0ZLR1JKdWhUZ3BSMjlBd3RKbXhJZWl2QllnZi9JQ2M5?=
 =?utf-8?B?U2lERy9xZVZ3K2dIQzVYN0owTCt3ZnNwdlRXT1Vwb1ErSENKNGNBZXJDaU9K?=
 =?utf-8?B?OHUxcG1SNzBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUFCcFNTQ2lPalpyTVRQd01oajFKZk9jYUlTODk1OG1KeW55THRIRlZYUjdX?=
 =?utf-8?B?NE1DcTEwSXpPVTJGQ09ZQTh0VmFycVI2ZXl3c2dYWm5WTmxHSG84S1dkVktV?=
 =?utf-8?B?eDVHL0xNSVRYRDJyK1VwMFZoU2NWd0NoTUlETEp3NS9UMmdZMWhmak1LUnZM?=
 =?utf-8?B?cUU5YkRiUHkzc3M0YWxLN0hlNEZ0ZW5MbUdJVXRkSmdoUHBUdGxvTEgzdU0r?=
 =?utf-8?B?S3JvdG9hSjUzcEFFS0k2bEhibU00SXg5aEVGUFpIREdLTVNkQXpwblZyQURX?=
 =?utf-8?B?VUdaNUdvZUVwT1lKTk9RYjBhV0ZWa1N2MmJKU3MrR2c3U1dhc0tqOFFuVFBj?=
 =?utf-8?B?ajZVaVJ3YStWR0xETEswVzVKSDBOMitjMFpvSytUTm9VYW9hb3hqTWpYQy9O?=
 =?utf-8?B?VHRvMWp3U2RDV2pyL09tRU1KeGNVQnY5KzB5b3hPZ1VmQTRBbDJjSTRYd1NM?=
 =?utf-8?B?WmRpdDdxbDQ1VVpMVksrRzRzc29oK3RsWEZtQ1Vxd3BDdld3S3A0ekxlTVhH?=
 =?utf-8?B?OFZWQ0xiZTdIbzJlTFk1VnhkZDJBMVdWeWQ1d0ZQOVU0amJ4cnEvN1NkeXVl?=
 =?utf-8?B?NWJ1cktucWQ5QUxyVEEzM0cyNEQ3NDlWVDE1V1RWZVIybE1HMEFIaGpQK3gy?=
 =?utf-8?B?aE9xMjNvdld2NVhWTVBFbGpTcXU2TUR4TndNRzVTWHgzMGFSWUFzTHV0dFB1?=
 =?utf-8?B?bWVwWXRvNEdmR0kwSkpJM3VOS0g0T2VFekFGcmx1RWYzNHFZYWVVVk5PMnVG?=
 =?utf-8?B?SDhabktaTTJXdzMrb2NpUkxHWnV4c3ZVZTF4WkZDcmVBZ0lob3RUazdFK1pH?=
 =?utf-8?B?T2hMUVYyYlprQjIyaVZTREpuWW5NZ1hvQlBDNlo1dkZuSVp6ZDk0WUhRTmVt?=
 =?utf-8?B?YVBhNHdxMDdQWlF0Zmc2aytyVW9rbXN5cm5OZ3MycS9NRTRuTWRHYjFzVmg0?=
 =?utf-8?B?K3ZMREs1cGVUZGsyNFI0eUdtTEthWittZmdlRFM1Vy9NdHlZRFJWOC94YnRV?=
 =?utf-8?B?YzE0c3Nad09PMEhUM3RvSFNONHJhV3R0STFDZXBPeENDRTdwUzhwN0I1VDd1?=
 =?utf-8?B?bTRoYkRSM29WZ3VpUTUrNDc5cTR0eWN1TS96UXNGckp2bFhnVWJMT0JHMDlC?=
 =?utf-8?B?NXdZT0VnQTdkREhhUEpGU3lBZ1Q0N0JCN1NpTGN1TkdnVytvZlFJVWYyNnhM?=
 =?utf-8?B?ZWtDY1FNT3poRVpDRnl5SXVoNEJVYWZPVEFSK3pkWDdCRWtrZTliMVpVWkdZ?=
 =?utf-8?B?MHFzcEpteUlOUVBhN1QrSXczcmFseEhuUFVyUWZVaTJXdFJGMi9JM1FWV3Na?=
 =?utf-8?B?N1luMmlFUnh0RXFjdFpYWXNtK21nTEpGalBkcXpaU3BzQ1laanVxYmJEYW9q?=
 =?utf-8?B?V2NkT1N1T1VBNHYyN2FPTEVxWUVGVW9hRGZaNFhkcGV4ampuVGV3dDBIUzdD?=
 =?utf-8?B?Wkt0RVdQMjl6UStqWGlOZjVhb2FVWkZMMnRUUFpReUlNVXFZSmo4Z3VmNXhO?=
 =?utf-8?B?eTZwc01pTFR2cjBvNCt6N1k1UWVOWG5qZ3RtZ0RscVc0MTFQTE9UbnNUMWRO?=
 =?utf-8?B?UG1xQjRySkgwaWxQZ3FtK2l1Y0cxUHFrSTBzd1g1aFkzUWREOUczLytFZ2dz?=
 =?utf-8?B?dmhPekRSVGt1VHUyalVGWStKOU96QVlUNDV2U3gvUTdVMTVOY1pHTkxKRnRi?=
 =?utf-8?B?Q3VTRHYwaE5iQ3dlbm1JNnhDemlLRUU2bUxYNG1CU0RxV25GbUIwUnFLRXdj?=
 =?utf-8?B?ajM4TnZYQmdFQzNoQ1IvWnNRYk81R1J6aDkzWFdaU2dYb3V0akxMMzVwNW5G?=
 =?utf-8?B?eForL1RhYkFhS1NYQmtYZk9tb3FTRnlnc0ovdlFLNnlWdHQwRm9zMUhjcldK?=
 =?utf-8?B?SVd2cTkzcEpEdVhHUnE3QW9GSjNwcDh1ZDJXMmV4ZUtDcFVENUlCRnYraWJa?=
 =?utf-8?B?Rkd6OXc4REJ3VGw3bFFXaVc2cjIyL0VpUk1aU28yL2h3amFOQ3hYc0NDYmZS?=
 =?utf-8?B?dWVNMTltUWNzNjFHQ0hycDMzaURNNVdJZGp4aFEzWTk4d2dWZWhUbktsMmZN?=
 =?utf-8?B?UDkza2Q1cGh4czd4cG12amVPQjI1VUt3OXNwaWxZRkdqakRFQ2RFV2gzUWkz?=
 =?utf-8?B?SjF4RHZJell6cjhTU1Vad2FkQU1JeHEyRFJ5MjRJSEtwZHBBVmhVZ3BwTmVx?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nN8lTOahgprjDLFJPaYW3YTN3Ax7I2eCzHoeSl8+6An/hS3nuNpVbj2vsF+ODSGt9chrBXeJZ+aVov+RSPxgIRp+1IXcQyM6vTzbeVghg8smd+XrOU8q62F7fFSUzfMxirui2tBSpmvNh3s1Eq+481mXbSlx5tVYtV3dcw/EObg77PRDB4/guy3I7YjFLxlccs1JuJYaiNM8ab8OnZb1c++nDzsWPgQYLa2ZPsp28MgRT0cqTom3GcvvXfPM1JklGVtfTbjjzzSe7DaIDNpyIQvbY47KIEEUL0cDNRmAC9dNHWIzsFAByMk8b9EX/99JKd7fG6WJvuDTdZ0YRcd458ty/jyNx9Uiak+/fUwyxm9BOkux88qoexCX5L3vpHAwLhdjmIUss83l3Zd704TKJU3SzFmRq/2ZAjUfvu8IY/Fg/EU+PyvRFr24CyTfT2MmKG0DUjKaloJJ6V+kPUrxfiX3UX/k9rtA3G+6Gn1SX3QgFRWlCv2JrjT9tVr1vFkZFtf0FYUrSPRpWZ5Cx0H3tzO3AO35J89vnlwnBDr1dEKcTit0TX7afRyo9SeUPRwK3lvypfdkchPrPvc2hoZmgL7stePl2FVgOWgp91G81a0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e291fcc-cc58-4fba-5190-08ddb29d04be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 21:29:21.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Zf5zZ7URkW+xo2kn6TiA+IZFccG6lC42+6lWWZCV85dQEylSJQJSvOHMEbAGVoHfCywYa5Lh2ZLsK363+A2cRIlR4FtjMyfWQg8nzmJNAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_07,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230145
X-Proofpoint-ORIG-GUID: ipOeYWQO3G2ULbIuejfYw3TveZRr1CrR
X-Proofpoint-GUID: ipOeYWQO3G2ULbIuejfYw3TveZRr1CrR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDE0NCBTYWx0ZWRfXyHaIBtTWbSoj ReM6vwgi1WOyDqROMicgUN0rku5/AIj5mVk0rmJ91YB8ns8MNhaiICmkaCpFrDjEU+MmImc5PFB CWYHLvi3JPHItqynm6zCZCKPjcs9TgYdGU2ZwnGBIUxNcaWB1o4aFFq3IymKuQ24ksfxgL8M2kv
 CNjbawWdzxILglMrVxKbQdtf9eNVV+NfYZYbpNiLhB/bdzXJl1epGipPN/omNUQ5mEA+Rg6w8vk gXsfBzkRXGRDdwiWTbuOiSIdLSL6E9yeZxB4rMCyfzO2tneFzg8WWFebVzhDUCeniBhCVt53ChL ZFeLAempZCBOmxz9tMwUMiSCeweFk0kZYWEsbtGymHYe1TcmNBIaNhXKolhKqSlLlZnFmQt+zS9
 UzKMe693WWpaEak95sUapiqYckbri79IDwZ/scu+us9gGKu/WNI1Gti4HPsMV2aIroOZZVYy
X-Authority-Analysis: v=2.4 cv=S5rZwJsP c=1 sm=1 tr=0 ts=6859c737 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=t09DJH5cwicwRm6N0awA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714

On 6/23/25 4:44 AM, Camacho Romero, Michal wrote:
> Hello Ross,
> 
> I'm BIOS Engineer from Intel, working on the TXT-related security modules development, including TBOOT project.
> I'm leaving you my thougths and objections on this patch:
> 
> On 4/21/2025 6:26 PM, Ross Philipson wrote:
> 
> Michal Camacho Romero: Replace all tabs with indentations (4 spaces) in the file
> 
>> Introduce the main Secure Launch header file used in the early SL stub
>> and the early setup code.
>>
>> This header file contains the following categories:
>>   - Secure Launch implementation specific structures and definitions.
>>   - Intel TXT architecture specific DRTM structures, definitions and functions
>> used by Secure Launch.
>>   - DRTM TPM event logging definitions and helper functions.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   include/linux/slaunch.h | 559 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 559 insertions(+)
>>   create mode 100644 include/linux/slaunch.h
>>
>> diff --git a/include/linux/slaunch.h b/include/linux/slaunch.h
>> new file mode 100644
>> index 000000000000..ae67314c2aad
>> --- /dev/null
>> +++ b/include/linux/slaunch.h
>> @@ -0,0 +1,559 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Main Secure Launch header file.
>> + *
>> + * Copyright (c) 2025 Apertus Solutions, LLC
>> + * Copyright (c) 2025, Oracle and/or its affiliates.
>> + */
>> +
>> +#ifndef _LINUX_SLAUNCH_H
>> +#define _LINUX_SLAUNCH_H
>> +
>> +/*
>> + * Secure Launch Defined State Flags
>> + */
>> +#define SL_FLAG_ACTIVE		0x00000001
>> +#define SL_FLAG_ARCH_TXT	0x00000002
>> +
>> +/*
>> + * Secure Launch CPU Type
>> + */
>> +#define SL_CPU_INTEL	1
>> +
>> +#define __SL32_CS	0x0008
>> +#define __SL32_DS	0x0010
>> +
>> +/*
>> + * Intel Safer Mode Extensions (SMX)
>> + *
>> + * Intel SMX provides a programming interface to establish a Measured Launched
>> + * Environment (MLE). The measurement and protection mechanisms supported by the
>> + * capabilities of an Intel Trusted Execution Technology (TXT) platform. SMX is
>> + * the processor's programming interface in an Intel TXT platform.
>> + *
>> + * See:
>> + *   Intel SDM Volume 2 - 6.1 "Safer Mode Extensions Reference"
>> + *   Intel Trusted Execution Technology - Measured Launch Environment Developer's Guide
>> + */
>> +
>> +/*
>> + * SMX GETSEC Leaf Functions
>> + */
>> +#define SMX_X86_GETSEC_SEXIT	5
>> +#define SMX_X86_GETSEC_SMCTRL	7
>> +#define SMX_X86_GETSEC_WAKEUP	8
>> +
> 
> Michal Camacho Romero: Create a new header file, called include/linux/txt.h and move there the following code section (matched in the black quotations):

That makes a lot of sense. I think that it has come up before. Since it 
is arch specific should it not go in arch/x86/include?

> 
> """ [START]> +/*
>> + * Intel Trusted Execution Technology MMIO Registers Banks
>> + */
>> +#define TXT_PUB_CONFIG_REGS_BASE	0xfed30000
>> +#define TXT_PRIV_CONFIG_REGS_BASE	0xfed20000
>> +#define TXT_NR_CONFIG_PAGES     ((TXT_PUB_CONFIG_REGS_BASE - \
>> +				  TXT_PRIV_CONFIG_REGS_BASE) >> PAGE_SHIFT)
>> +
>> +/*
>> + * Intel Trusted Execution Technology (TXT) Registers
>> + */
>> +#define TXT_CR_STS			0x0000
>> +#define TXT_CR_ESTS			0x0008
>> +#define TXT_CR_ERRORCODE		0x0030
>> +#define TXT_CR_CMD_RESET		0x0038
>> +#define TXT_CR_CMD_CLOSE_PRIVATE	0x0048
>> +#define TXT_CR_DIDVID			0x0110
>> +#define TXT_CR_VER_EMIF			0x0200
>> +#define TXT_CR_CMD_UNLOCK_MEM_CONFIG	0x0218
>> +#define TXT_CR_SINIT_BASE		0x0270
>> +#define TXT_CR_SINIT_SIZE		0x0278
>> +#define TXT_CR_MLE_JOIN			0x0290
>> +#define TXT_CR_HEAP_BASE		0x0300
>> +#define TXT_CR_HEAP_SIZE		0x0308
>> +#define TXT_CR_SCRATCHPAD		0x0378
>> +#define TXT_CR_CMD_OPEN_LOCALITY1	0x0380
>> +#define TXT_CR_CMD_CLOSE_LOCALITY1	0x0388
>> +#define TXT_CR_CMD_OPEN_LOCALITY2	0x0390
>> +#define TXT_CR_CMD_CLOSE_LOCALITY2	0x0398
>> +#define TXT_CR_CMD_SECRETS		0x08e0
>> +#define TXT_CR_CMD_NO_SECRETS		0x08e8
>> +#define TXT_CR_E2STS			0x08f0
>> +
>> +/* TXT default register value */
>> +#define TXT_REGVALUE_ONE		0x1ULL
>> +
>> +/* TXTCR_STS status bits */
>> +#define TXT_SENTER_DONE_STS		BIT(0)
>> +#define TXT_SEXIT_DONE_STS		BIT(1)
>> +
>> +/*
>> + * SINIT/MLE Capabilities Field Bit Definitions
>> + */
> 
> 
> """ [END]
> 
> Michal Camacho Romero: Change TXT_SINIT_MLE_CAP_WAKE_GETSEC macro's name to TXT_SINIT_MLE_CAP_RLP_WAKE_GETSEC and also  TXT_SINIT_MLE_CAP_WAKE_MONITOR macro's name to TXT_SINIT_MLE_CAP_RLP_WAKE_MONITOR then move them to the newly created include/linux/txt.h:
> 
>> +#define TXT_SINIT_MLE_CAP_WAKE_GETSEC	0
>> +#define TXT_SINIT_MLE_CAP_WAKE_MONITOR	1
>> +
> 
> Michal Camacho Romero: Move the following code section (matched in the black quotations) into the new header file include/linux/txt.h:
> 
> """ [START]> +/*
>> + * OS/MLE Secure Launch Specific Definitions
>> + */
>> +#define TXT_OS_MLE_STRUCT_VERSION	1
>> +#define TXT_OS_MLE_MAX_VARIABLE_MTRRS	32
>> +
>> +/*
>> + * TXT Heap Table Enumeration
>> + */
>> +#define TXT_BIOS_DATA_TABLE		1
>> +#define TXT_OS_MLE_DATA_TABLE		2
>> +#define TXT_OS_SINIT_DATA_TABLE		3
>> +#define TXT_SINIT_MLE_DATA_TABLE	4
>> +#define TXT_SINIT_TABLE_MAX		TXT_SINIT_MLE_DATA_TABLE
>> +
> 
> """ [END]> +/*
>> + * Secure Launch Defined Error Codes used in MLE-initiated TXT resets.
>> + *
>> + * TXT Specification
>> + * Appendix I ACM Error Codes
>> + */
>> +#define SL_ERROR_GENERIC		0xc0008001
>> +#define SL_ERROR_TPM_INIT		0xc0008002
>> +#define SL_ERROR_TPM_INVALID_LOG20	0xc0008003
>> +#define SL_ERROR_TPM_LOGGING_FAILED	0xc0008004
>> +#define SL_ERROR_REGION_STRADDLE_4GB	0xc0008005
>> +#define SL_ERROR_TPM_EXTEND		0xc0008006
>> +#define SL_ERROR_MTRR_INV_VCNT		0xc0008007
>> +#define SL_ERROR_MTRR_INV_DEF_TYPE	0xc0008008
>> +#define SL_ERROR_MTRR_INV_BASE		0xc0008009
>> +#define SL_ERROR_MTRR_INV_MASK		0xc000800a
>> +#define SL_ERROR_MSR_INV_MISC_EN	0xc000800b
>> +#define SL_ERROR_INV_AP_INTERRUPT	0xc000800c
>> +#define SL_ERROR_INTEGER_OVERFLOW	0xc000800d
>> +#define SL_ERROR_HEAP_WALK		0xc000800e
>> +#define SL_ERROR_HEAP_MAP		0xc000800f
>> +#define SL_ERROR_REGION_ABOVE_4GB	0xc0008010
>> +#define SL_ERROR_HEAP_INVALID_DMAR	0xc0008011
>> +#define SL_ERROR_HEAP_DMAR_SIZE		0xc0008012
>> +#define SL_ERROR_HEAP_DMAR_MAP		0xc0008013
>> +#define SL_ERROR_HI_PMR_BASE		0xc0008014
>> +#define SL_ERROR_HI_PMR_SIZE		0xc0008015
>> +#define SL_ERROR_LO_PMR_BASE		0xc0008016
>> +#define SL_ERROR_LO_PMR_MLE		0xc0008017
>> +#define SL_ERROR_INITRD_TOO_BIG		0xc0008018
>> +#define SL_ERROR_HEAP_ZERO_OFFSET	0xc0008019
>> +#define SL_ERROR_WAKE_BLOCK_TOO_SMALL	0xc000801a
>> +#define SL_ERROR_MLE_BUFFER_OVERLAP	0xc000801b
>> +#define SL_ERROR_BUFFER_BEYOND_PMR	0xc000801c
>> +#define SL_ERROR_OS_SINIT_BAD_VERSION	0xc000801d
>> +#define SL_ERROR_EVENTLOG_MAP		0xc000801e
>> +#define SL_ERROR_TPM_INVALID_ALGS	0xc000801f
>> +#define SL_ERROR_TPM_EVENT_COUNT	0xc0008020
>> +#define SL_ERROR_TPM_INVALID_EVENT	0xc0008021
>> +#define SL_ERROR_INVALID_SLRT		0xc0008022
>> +#define SL_ERROR_SLRT_MISSING_ENTRY	0xc0008023
>> +#define SL_ERROR_SLRT_MAP		0xc0008024
>> +
>> +/*
>> + * Secure Launch Defined Limits
>> + */
>> +#define TXT_MAX_CPUS		512
>> +#define TXT_BOOT_STACK_SIZE	128
>> +
>> +/*
>> + * Secure Launch event log entry type. The TXT specification defines the
>> + * base event value as 0x400 for DRTM values.
>> + */
>> +#define TXT_EVTYPE_BASE			0x400
>> +#define TXT_EVTYPE_SLAUNCH		(TXT_EVTYPE_BASE + 0x102)
>> +#define TXT_EVTYPE_SLAUNCH_START	(TXT_EVTYPE_BASE + 0x103)
>> +#define TXT_EVTYPE_SLAUNCH_END		(TXT_EVTYPE_BASE + 0x104)
>> +
>> +/*
>> + * MLE scratch area offsets
>> + */
>> +#define SL_SCRATCH_AP_EBX		0
>> +#define SL_SCRATCH_AP_JMP_OFFSET	4
>> +#define SL_SCRATCH_AP_STACKS_OFFSET	8
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <linux/io.h>
>> +#include <linux/tpm.h>
>> +#include <linux/tpm_eventlog.h>
>> +
>> +/*
>> + * Secure Launch AP stack and monitor block
>> + */
>> +struct sl_ap_stack_and_monitor {
>> +	u32 monitor;
>> +	u32 cache_pad[15];
>> +	u32 stack_pad[15];
>> +	u32 apicid;
>> +} __packed;
>> +
>> +/*
>> + * Secure Launch AP wakeup information fetched in SMP boot code.
>> + */
>> +struct sl_ap_wake_info {
>> +	u32 ap_wake_block;
>> +	u32 ap_wake_block_size;
>> +	u32 ap_jmp_offset;
>> +	u32 ap_stacks_offset;
>> +};
>> +
> 
>   Michal Camacho Romero: Move the following code section (matched in the black quotations) into the new header file include/linux/txt.h:
> 
> """ [START]> +/*
>> + * TXT heap extended data elements.
>> + */
>> +struct txt_heap_ext_data_element {
>> +	u32 type;
>> +	u32 size;
>> +	/* Data */
>> +} __packed;
>> +
>> +#define TXT_HEAP_EXTDATA_TYPE_END			0
>> +
>> +struct txt_heap_end_element {
>> +	u32 type;
>> +	u32 size;
>> +} __packed;
>> +
>> +#define TXT_HEAP_EXTDATA_TYPE_TPM_EVENT_LOG_PTR		5
>> +
>> +struct txt_heap_event_log_element {
>> +	u64 event_log_phys_addr;
>> +} __packed;
>> +
>> +#define TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1	8
>> +
>> +struct txt_heap_event_log_pointer2_1_element {
>> +	u64 phys_addr;
>> +	u32 allocated_event_container_size;
>> +	u32 first_record_offset;
>> +	u32 next_record_offset;
>> +} __packed;
>> +
>> +/*
>> + * Secure Launch defined OS/MLE TXT Heap table
>> + */
>> +struct txt_os_mle_data {
>> +	u32 version;
>> +	u32 reserved;
>> +	u64 slrt;
>> +	u64 txt_info;
>> +	u32 ap_wake_block;
>> +	u32 ap_wake_block_size;
>> +	u8 mle_scratch[64];
>> +} __packed;
>> +
>> +/*
>> + * TXT specification defined BIOS data TXT Heap table
>> + */
>> +struct txt_bios_data {
>> +	u32 version; /* Currently 5 for TPM 1.2 and 6 for TPM 2.0 */
>> +	u32 bios_sinit_size;
>> +	u64 reserved1;
>> +	u64 reserved2;
>> +	u32 num_logical_procs;
> 
> 
> Michal Camacho Romero: Put the comment /* Versions >= 5 with updates in version 6 */ under the sinit_flags struct member. The sinit_flags member exists in the BiosData struct since version 3.

Ack

> 
>> +	/* Versions >= 5 with updates in version 6 */
> 
> 
>> +	u32 sinit_flags;
>> +	u32 mle_flags;
>> +	/* Versions >= 4 */
>> +	/* Ext Data Elements */
>> +} __packed;
>> +
>> +/*
>> + * TXT specification defined OS/SINIT TXT Heap table
>> + */
>> +struct txt_os_sinit_data {
>> +	u32 version; /* Currently 6 for TPM 1.2 and 7 for TPM 2.0 */
>> +	u32 flags;
>> +	u64 mle_ptab;
>> +	u64 mle_size;
>> +	u64 mle_hdr_base;
>> +	u64 vtd_pmr_lo_base;
>> +	u64 vtd_pmr_lo_size;
>> +	u64 vtd_pmr_hi_base;
>> +	u64 vtd_pmr_hi_size;
>> +	u64 lcp_po_base;
>> +	u64 lcp_po_size;
>> +	u32 capabilities;
>> +	/* Version = 5 */
>> +	u64 efi_rsdt_ptr;
>> +	/* Versions >= 6 */
>> +	/* Ext Data Elements */
>> +} __packed;
>> +
>> +/*
>> + * TXT specification defined SINIT/MLE TXT Heap table
>> + */
>> +struct txt_sinit_mle_data {
>> +	u32 version;             /* Current values are 6 through 9 */
>> +	/* Versions <= 8 */
>> +	u8 bios_acm_id[20];
>> +	u32 edx_senter_flags;
>> +	u64 mseg_valid;
>> +	u8 sinit_hash[20];
>> +	u8 mle_hash[20];
>> +	u8 stm_hash[20];
>> +	u8 lcp_policy_hash[20];
>> +	u32 lcp_policy_control;
>> +	/* Versions >= 7 */
>> +	u32 rlp_wakeup_addr;
>> +	u32 reserved;
>> +	u32 num_of_sinit_mdrs;
>> +	u32 sinit_mdrs_table_offset;
>> +	u32 sinit_vtd_dmar_table_size;
>> +	u32 sinit_vtd_dmar_table_offset;
>> +	/* Versions >= 8 */
>> +	u32 processor_scrtm_status;
>> +	/* Versions >= 9 */
>> +	/* Ext Data Elements */
>> +} __packed;
>> +
>> +/*
>> + * TXT data reporting structure for memory types
>> + */
>> +struct txt_sinit_memory_descriptor_record {
>> +	u64 address;
>> +	u64 length;
>> +	u8 type;
>> +	u8 reserved[7];
>> +} __packed;
>> +
>> +/*
>> + * TXT data structure used by a responsive local processor (RLP) to start
>> + * execution in response to a GETSEC[WAKEUP].
>> + */
>> +struct smx_rlp_mle_join {
>> +	u32 rlp_gdt_limit;
>> +	u32 rlp_gdt_base;
>> +	u32 rlp_seg_sel;     /* cs (ds, es, ss are seg_sel+8) */
>> +	u32 rlp_entry_point; /* phys addr */
>> +} __packed;
>> +
>> +/*
>> + * TPM event log structures defined in both the TXT specification and
>> + * the TCG documentation.
>> + */
>> +#define TPM_EVTLOG_SIGNATURE "TXT Event Container"
>> +
>> +struct tpm_event_log_header {
>> +	char signature[20];
>> +	char reserved[12];
>> +	u8 container_ver_major;
>> +	u8 container_ver_minor;
>> +	u8 pcr_event_ver_major;
>> +	u8 pcr_event_ver_minor;
>> +	u32 container_size;
>> +	u32 pcr_events_offset;
>> +	u32 next_event_offset;
>> +	/* PCREvents[] */
>> +} __packed;
>> +

Should the following accessor functions be moved? They are specific to 
an environment (like protected mode paging off or x64 identity mapped) 
and thus this implementation.

>> +/*
>> + * Functions to extract data from the Intel TXT Heap Memory. The layout
>> + * of the heap is as follows:
>> + *  +----------------------------+
>> + *  | Size Bios Data table (u64) |
>> + *  +----------------------------+
>> + *  | Bios Data table            |
>> + *  +----------------------------+
>> + *  | Size OS MLE table (u64)    |
>> + *  +----------------------------+
>> + *  | OS MLE table               |
>> + *  +--------------------------- +
>> + *  | Size OS SINIT table (u64)  |
>> + *  +----------------------------+
>> + *  | OS SINIT table             |
>> + *  +----------------------------+
>> + *  | Size SINIT MLE table (u64) |
>> + *  +----------------------------+
>> + *  | SINIT MLE table            |
>> + *  +----------------------------+
>> + *
>> + *  NOTE: the table size fields include the 8 byte size field itself.
>> + */
>> +static inline u64 txt_bios_data_size(void *heap)
>> +{
>> +	return *((u64 *)heap);
>> +}
>> +
>> +static inline void *txt_bios_data_start(void *heap)
>> +{
>> +	return heap + sizeof(u64);
>> +}
>> +
>> +static inline u64 txt_os_mle_data_size(void *heap)
>> +{
>> +	return *((u64 *)(heap + txt_bios_data_size(heap)));
>> +}
>> +
>> +static inline void *txt_os_mle_data_start(void *heap)
>> +{
>> +	return heap + txt_bios_data_size(heap) + sizeof(u64);
>> +}
>> +
>> +static inline u64 txt_os_sinit_data_size(void *heap)
>> +{
>> +	return *((u64 *)(heap + txt_bios_data_size(heap) +
>> +			txt_os_mle_data_size(heap)));
>> +}
>> +
>> +static inline void *txt_os_sinit_data_start(void *heap)
>> +{
>> +	return heap + txt_bios_data_size(heap) +
>> +		txt_os_mle_data_size(heap) + sizeof(u64);
>> +}
>> +
>> +static inline u64 txt_sinit_mle_data_size(void *heap)
>> +{
>> +	return *((u64 *)(heap + txt_bios_data_size(heap) +
>> +			txt_os_mle_data_size(heap) +
>> +			txt_os_sinit_data_size(heap)));
>> +}
>> +
>> +static inline void *txt_sinit_mle_data_start(void *heap)
>> +{
>> +	return heap + txt_bios_data_size(heap) +
>> +		txt_os_mle_data_size(heap) +
>> +		txt_os_sinit_data_size(heap) + sizeof(u64);
>> +}
>> +
>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
>> +
>> +/*
>> + * TPM event logging functions.
>> + */
>> +
>> +/*
>> + * Find the TPM v2 event log element in the TXT heap. This element contains
>> + * the information about the size and location of the DRTM event log. Note
>> + * this is a TXT specific structure.
>> + *
>> + * See:
>> + *   Intel Trusted Execution Technology - Measured Launch Environment Developer's Guide - Appendix C.
>> + */
>> +static inline struct txt_heap_event_log_pointer2_1_element*
>> +tpm2_find_log2_1_element(struct txt_os_sinit_data *os_sinit_data)
>> +{
>> +	struct txt_heap_ext_data_element *ext_elem;
>> +
>> +	/* The extended element array as at the end of this table */
>> +	ext_elem = (struct txt_heap_ext_data_element *)
>> +		((u8 *)os_sinit_data + sizeof(struct txt_os_sinit_data));
>> +
>> +	while (ext_elem->type != TXT_HEAP_EXTDATA_TYPE_END) {
>> +		if (ext_elem->type == TXT_HEAP_EXTDATA_TYPE_EVENT_LOG_POINTER2_1) {
>> +			return (struct txt_heap_event_log_pointer2_1_element *)
>> +				((u8 *)ext_elem + sizeof(struct txt_heap_ext_data_element));
>> +		}
>> +		ext_elem = (struct txt_heap_ext_data_element *)
>> +			    ((u8 *)ext_elem + ext_elem->size);
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * Log a TPM v1 formatted event to the given DRTM event log.
>> + */
>> +static inline int tpm_log_event(void *evtlog_base, u32 evtlog_size,
>> +				u32 event_size, void *event)
>> +{
>> +	struct tpm_event_log_header *evtlog =
>> +		(struct tpm_event_log_header *)evtlog_base;
>> +
>> +	if (memcmp(evtlog->signature, TPM_EVTLOG_SIGNATURE,
>> +		   sizeof(TPM_EVTLOG_SIGNATURE)))
>> +		return -EINVAL;
>> +
>> +	if (evtlog->container_size > evtlog_size)
>> +		return -EINVAL;
>> +
>> +	if (evtlog->next_event_offset + event_size > evtlog->container_size)
>> +		return -E2BIG;
>> +
>> +	memcpy(evtlog_base + evtlog->next_event_offset, event, event_size);
>> +	evtlog->next_event_offset += event_size;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Log a TPM v2 formatted event to the given DRTM event log.
>> + */
>> +static inline int tpm2_log_event(struct txt_heap_event_log_pointer2_1_element *elem,
>> +				 void *evtlog_base, u32 evtlog_size,
>> +				 u32 event_size, void *event)
>> +{
>> +	struct tcg_pcr_event *header =
>> +		(struct tcg_pcr_event *)evtlog_base;
>> +
>> +	/* Has to be at least big enough for the signature */
>> +	if (header->event_size < sizeof(TCG_SPECID_SIG))
>> +		return -EINVAL;
>> +
>> +	if (memcmp((u8 *)header + sizeof(struct tcg_pcr_event),
>> +		   TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
>> +		return -EINVAL;
>> +
>> +	if (elem->allocated_event_container_size > evtlog_size)
>> +		return -EINVAL;
>> +
>> +	if (elem->next_record_offset + event_size >
>> +	    elem->allocated_event_container_size)
>> +		return -E2BIG;
>> +
>> +	memcpy(evtlog_base + elem->next_record_offset, event, event_size);
>> +	elem->next_record_offset += event_size;
>> +
>> +	return 0;
>> +}
>> +
> """[END]
> 
>> +/*
>> + * External functions available in mainline kernel.
>> + */
>> +void slaunch_setup_txt(void);
>> +void slaunch_fixup_jump_vector(void);
>> +u32 slaunch_get_flags(void);
>> +struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
>> +struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar);
>> +void __noreturn slaunch_txt_reset(void __iomem *txt,
>> +					 const char *msg, u64 error);
>> +void slaunch_finalize(int do_sexit);
>> +
>> +static inline bool slaunch_is_txt_launch(void)
>> +{
>> +	u32 mask = SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;
>> +
>> +	return (slaunch_get_flags() & mask) == mask;
>> +}
>> +
>> +#else
>> +
>> +static inline void slaunch_setup_txt(void)
>> +{
>> +}
>> +
>> +static inline void slaunch_fixup_jump_vector(void)
>> +{
>> +}
>> +
>> +static inline u32 slaunch_get_flags(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)
>> +{
>> +	return dmar;
>> +}
>> +
>> +static inline void slaunch_finalize(int do_sexit)
>> +{
>> +}
>> +
>> +static inline bool slaunch_is_txt_launch(void)
>> +{
>> +	return false;
>> +}
>> +
>> +#endif /* !IS_ENABLED(CONFIG_SECURE_LAUNCH) */
>> +
>> +#endif /* !__ASSEMBLY */
>> +
>> +#endif /* _LINUX_SLAUNCH_H */
> Regards,
> Michal Camacho Romero (michal.camacho.romero@linux.intel.com)

Thank you for your feedback.
Ross



