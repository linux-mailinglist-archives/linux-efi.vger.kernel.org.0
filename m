Return-Path: <linux-efi+bounces-5897-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 393B0CC9431
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 19:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEBDD303D3E1
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 18:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B9829B8E8;
	Wed, 17 Dec 2025 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XCvv/x/P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pwiiBIFa"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE02264A7;
	Wed, 17 Dec 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995394; cv=fail; b=kQ5tRNN/xUusiEE8bk3hjvf6unav3UVq9Vn3/nvHemGMnwH4aS45V8cR/8fXrIQVtSVTCcuSMeA72ecIRnCUPG98poNSLIlmzymde/S72vxJ/eBvJynixexdFARs5FN6XSgHuhxAlPpIQHiZKeEaSO67ljo00FB6UCQpctAlObM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995394; c=relaxed/simple;
	bh=8FbwE8JHDqzKrz+7xTqDjB5PwuSIMPVdyfn2DbccwdI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P7Lq2FBakJZEU3QG/ip9QMHZAS+5PyOASJ+V5vrhZwFC9RuCSJLsxHgFIX8rT6lbO3xytRRgkR9db8QbgFKGizYg4F5TZFaAVgh6hi6xmokLqUDZeJj+CxfJTBnLCEZQO8Oz2pBLM3OPZtrcyK7Ibf8rnnntERJkUS5rRJSyjyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XCvv/x/P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pwiiBIFa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHH1s2K3249027;
	Wed, 17 Dec 2025 18:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HWiaZ8yOKn7nMVQbOA0U1HIkKqrJosdjWGYYBdox1z0=; b=
	XCvv/x/PInPmKmLUhuRBZoCr/pDXWMj5cRRRpj2AglLI/JA+MADOE5/XqDMmoo5W
	Obpr1O8nhm2Vi7T5jACR76XN90ioGWpjm/yUoNP+PMNMZMxJ84RleKz3UdPwKJmI
	W40S834j6dzG2AhzVqIJKKHiQz/SHUvMf3Ov1x1VI+xD7mtaJ9on3f94X7yztHXs
	1L9dcX8azFxt8kO4OL6YEkL7Xz5m/WuQl+NxRgFzpr8DEX0+Do3u1eJBU1DoTo0l
	VVYC3QoRvcbTtB1ZzOb3xTH7Mk2vq2eKF1xq1GWgJtm6lHtrJpAhvyjTSX8jIXY4
	Fo1TkDYtDQGyIhiRsavEqA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015xbqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:15:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHGvhWJ024739;
	Wed, 17 Dec 2025 18:15:46 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkbuy3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 18:15:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOkdWw7DiWvGzK4/HugKfUSX0v6tWX1+5u3CtL26bV4tB0oV90EWTH19Y9wnidoXqiEL5815D8QlxoUc1xwWTJZCZ6xTZBNpFzHs6DVmpQgN91qLCZ0rN0+if+Jo/6phOJtHcwmRPzhUrMrz6WpenFHjmYgWQTsN6/ajv7xfOr9Px7amxrSCWNoe1p3Hn8A0B5jFRx5oN3TJgrQA/HcNUfvuI7WL6qjxLYMLgteWx2vRIs1t7hVPZzSaf/sxJJRjg6VqRCww61CnK3vEAekIwKQU4Tczlj14+fX1RR6+j0HwZ/5K3SHe90DgNtpb11SsTRgBRvTDUBxhUrAGd49T9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWiaZ8yOKn7nMVQbOA0U1HIkKqrJosdjWGYYBdox1z0=;
 b=ZzrnXtG3YuQYuX92SV+nbSZ6CB2A5YRcxnPxsv6KqZTAg6qPQkzkqnqvuuoGSb0NtcFSBtu8JnsE0ciw4WgcgOKbR6cwrTip1cwu9s6q7F/YF/mT1YOw5kAv5gf3O3nC3xzhsmSmCnVFLxkMvyZNZ9TgBFZYBCMEn0OpjLYhRj2um3Fs6DAG2PJjrOo5twVYtP8vxt5v/OFe5ovsyO/nwQqqqmR59ebXFzlSRvUGYfvj/lBImSt6rdq6R1BNGBR8G+AXHKrttLuMLBXl3z/O5T1HXbTCmfIR6o4Psj8RUGJrH9GKxfqU45VCUf1fRyPO2NMiUuXtgxbmoxVFkBC0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWiaZ8yOKn7nMVQbOA0U1HIkKqrJosdjWGYYBdox1z0=;
 b=pwiiBIFa4s9hoTXrbSXRNX1pjmGd6oPP3ZzxJqDlKCYkLTbkB7aQD+AnIiJa1WkO0RVGVZFUJlMMmbwKE7mDJVi+qYQLHTfhAMJeJf4n8z4tld69FT8PtlWPLg/joLqj/qkb2V2iHNmzzZrr90Beak4Ip6jS4t5cIRnt2XwsQ2E=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DS4PR10MB997551.namprd10.prod.outlook.com (2603:10b6:8:31a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 18:15:43 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 18:15:43 +0000
Message-ID: <3175a76a-4279-45b6-a67b-2ce398d9e779@oracle.com>
Date: Wed, 17 Dec 2025 10:15:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
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
        trenchboot-devel@googlegroups.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <aUDV_e19I0I3GIzN@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <aUDV_e19I0I3GIzN@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DS4PR10MB997551:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f434b2-d6af-4ecc-fb5e-08de3d984ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUhBY3F4S3YrSlJMWWVYcDJXUXBiVHVXekpxeHFMUFppd09tVGk4VFhGMGpL?=
 =?utf-8?B?ZFVTSzBSMXlnNUZ1ZVRyUWhNRGJnN0xlYTJNRm45b0Q2eWdMODRZbHc1Vmp1?=
 =?utf-8?B?UE1pa3htUkIybmtyU3g4VjlPemloZVVBakk4M0RvaGFwaWJKUW5wU0Z3azFx?=
 =?utf-8?B?cHVGUzE0RkE4UWhVc3QxUmlQUFdpVmh6MkhkN0w3YUFyM3I0bUk2YlpTZXFG?=
 =?utf-8?B?R0Z1VFpSbEhrRGFsS1dDVE16Ti9SMVNvMjZsM2hJTnJaMk0xeFJEQXRkQUUr?=
 =?utf-8?B?cERDU2pWZ2tCUERKY2pQaHB1Q2FWR1J3VVh4V0NBNFkwbkU3c3IyZFlqc054?=
 =?utf-8?B?eFBGM2tEWWNIWXdJUHZvdGxPK1dsRVhBYTBTQVdLaVhncFJNcDk5NHJuTVRF?=
 =?utf-8?B?NkM1NXZ0aWhnbU1pdWtzTm1USnZRek5CNGNTZmFXQ1J1ODBKcHppenhhL0Y4?=
 =?utf-8?B?ZUNEQTh3a0N5T3QrS09jUnMrb2MxZGZxdUVIcmxHUkRodEFLcUMyaTVZb0Jw?=
 =?utf-8?B?b0J6NkFtelllMmRQU1pNY014dVluSVBMWmhhdlhRQkZ1TGxTRFdPdVEvMWdr?=
 =?utf-8?B?RlAyUi9OSmV4dUZXbUtjb1MxSnRqNjc0UXpXK1k1OFAyZ3J0NGVKR1B0NSt3?=
 =?utf-8?B?RWt6OXJoOVZ2dkhrRVplOVZPV29URzRrS2xhQ2QyWjB2Um5DMnJsZS9iTEUr?=
 =?utf-8?B?YS9VaW1nOFFvRzJOYWZvaEZuL25OalY5TzNjbDc0SDl6TkViazBreTA0eDBK?=
 =?utf-8?B?MkpJSzdvU0t1VjNrQUJrNjJKVTF1LzYxN05oUWpsRFdFWkVQZ3hKYUpVbGFG?=
 =?utf-8?B?RHM1dkY1OXFzRDI2dStQNWJQYUs4Q1dadEZ2SU51K1RNeVhlZzV2emlDYUFa?=
 =?utf-8?B?WDdtazB4Wm9JeHVPdDFJajZDMGIzejAyQWJSb2ttS2gzMmc4YmVzT2swVTdJ?=
 =?utf-8?B?eTMrV0pRbTl4RVRBVkpRTzJFV1QxY0V3cWhsN2tGRC9JT1poVWIxTmFQTmRL?=
 =?utf-8?B?NnJrYlpaTTMzZWZQTXMyT0R2bUFRSU1LTjQ4cWNkOXZmM2VrVkdWT2MxQklL?=
 =?utf-8?B?dHQ3U0pETDU3cyt1UGNVWERqQzgvc2l3UndIdXAyZkcxem40VzJ4UzBYRlJU?=
 =?utf-8?B?bHVjdzVaQWdYc3VyT25SaUt3dmFHeGUrVzZYV2tRVVI3aTBVOUlSaTFlUTZy?=
 =?utf-8?B?R3ZUU0J0ZEFFYTJWQUNUSkdidmd5cnQ5NDI0S1hFVngySXdoUXNyQWxTS1VX?=
 =?utf-8?B?dWRXaERQZVRXZER3UnR1cmI4MnpJQmJPTXArOFlQdFF5QS8yWElOWHhnc1V0?=
 =?utf-8?B?QlJydjRWNy9xUFozOXFyNDNlcHVjOElUVFlwWlFOTThMTHBKNDAyVWkvVkJ0?=
 =?utf-8?B?ajdkMjh2STdCcXJXdzJ1YUFlbTNpT280UkpRc2RVY3puanJuL1JQRzFCa0Iy?=
 =?utf-8?B?KzhsekJkT2dqN2VQVmNnNU9qT2NBMHBzRjBVcmhjQ2MwKzdlYjhiMlpMU05a?=
 =?utf-8?B?clo5dWNCWHEzL2w3QUU4MjNWb0Fxejl1elB0ZHkzOU1LbnAvdDNJdCtROUFX?=
 =?utf-8?B?THVtdHpiQkZnY2tkdDBtQVg5Q24wQTdZRzlDNDBTZ1VkK2FCVnFIN1p0NGo0?=
 =?utf-8?B?cWVEMmN1REU4eUxCeTM1ZEcrS0wycFBLOVc5WUZ0SENINExEV0Z2RnNmV0xR?=
 =?utf-8?B?NCsweE0yYUlyMzJKa0kvWko0VTBJUE94LytiS0hLd3lMOVM1amhZL1YrNVdV?=
 =?utf-8?B?V0NOWE9XZlFMU0x0T0dqKzZPelo0aEo5VXhrN0U1dFY0YkhGRjhrR2FlR1Jp?=
 =?utf-8?B?Qm1LbHd0RTd0RG9yelk1UTdRMnp6bW5DdHJwOTExbmZEbUZ5UnZTU05aaDNW?=
 =?utf-8?B?bkdqdThhNjFTWWJqYjJtSlhkNVR4MFpQb25KaWlxQ0VsNUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE8rTTA5cEp3d1lJOGY4SWphMm40Mm1PbW9TVXorRFlPczhyU1ozNk5rd25q?=
 =?utf-8?B?aXdyWnYxQ291bFhkdSs0TG0xU25PaENPbUxyVmJUQnZLN3h6eGJ4MFN5V0ph?=
 =?utf-8?B?SVdNOFVwS040c0hpZlhMRk9IcWdqcFdmTnJRM3lEd0RHN0xGQVF1NlF0TjEx?=
 =?utf-8?B?QmltNE1vckIzTUJ0MWxWTEM1ZFgwN3FOemN6QTJ3SXlmeWpsQVZOcUhrTlV0?=
 =?utf-8?B?eUg3UnFmb3dWUTlkcFRsc1RhZnBVdW9CbU1uRVJxZmtRY3E0S0dvZ2N5Ni9a?=
 =?utf-8?B?VjFzdi9hK0FOWkdtZ0Y5SnZjR09iNU05bThOVGdsOUU5S0J3QWg5Rjkyd2Fw?=
 =?utf-8?B?cC90eExtMEVDUHlTakk1QVVIY0pJYkVsUFlGQzJYRCtEZ0NCV1dnVUlOWGhO?=
 =?utf-8?B?SzRlT0E4RTRaa0d6eTdBejFkTWZqMTFQNFluRm9oM0orbkZwb2c5T2dxSmtM?=
 =?utf-8?B?RnByMms5QVdvckpCdERmVSt2YXZCV0MrSkJwMlJnaEdpWjN4RExDc1RhUE5R?=
 =?utf-8?B?NUlIc1d3VThiOXVYNms0bVJwUVJleDh5OFhsQTVMSk1XSWV6R0hXblZVMm10?=
 =?utf-8?B?Y2pTQTJPd0ZwRzR6UGZNWCtBeVhRMDQzejBPL3ZYSW5hYXRjSkpibURZL05t?=
 =?utf-8?B?R0JKdm1hOHpQQzFBbUhjUCtlcDhNTjE5QndJSzUxSnFPaG45VFdub3YrOHVh?=
 =?utf-8?B?WFQwU0RnYlJUWDJwMjJKR2VaMDltRjNUWGRja3ROdjAzLyt1eElPNzlDVGdU?=
 =?utf-8?B?bHdDUjdHN2hNWHJZMXdTTGNjT3VKeG53cjA4ZWRGb1J6eDEyLzAyL1lFVFQz?=
 =?utf-8?B?Vkppa1hnWmp2b25IQXkvNmt0dFpsNmlkWlFsZzNtOGRJQ1NGd3Y2T0hLNjBy?=
 =?utf-8?B?Qm92RVRoMHhGMG5zZWRmcmhVNEllZDU5RTZXS2dkcWVvdW9WeGZsejFoSUtI?=
 =?utf-8?B?R1JwQnIvYmV5SWs4cW1uaXdpVzNpN1RZODVvYUVLenR3bFlVR2wyQTVkaWhi?=
 =?utf-8?B?UUg5MGE0cFhiQ2s2WFo0TlJMY1NRZ2JJUm1VelAzTzRvK0phWDI4NEZJV2Rw?=
 =?utf-8?B?elVpTWIraEFJbjBLZjRNUGhQRHBWdnBhU2xBZVRhdkFCNXNlcUd0NG5GTDVP?=
 =?utf-8?B?Mm5XcTBkSExQRWN2ZFpCcW4xU3dzckJ0bjN5b0p6MzRFeXZONm1WRC9oYVN1?=
 =?utf-8?B?dm5CRG1aVk93Q245M0grTmNOT29BaEVLdGZnZGY4UXhDakdneFJZb2FIMkdv?=
 =?utf-8?B?MGhFQ1NlN0Qyd1pMTDlIdXN5RWNwUis1Q0ZxbUV4UkN4YUE0cEUzQno5TWNP?=
 =?utf-8?B?UFZCWTlrQVZVZUZBcEkvWmhCSzFMVThjeEhsUTQ3MGFXWlAyU3lUK3RTbFFi?=
 =?utf-8?B?WFVCKzN2UWxSVHA4VE1nSkdxSmNGWndDcE95WTdjd0hQT1o2MTk4UjZuV3hT?=
 =?utf-8?B?UHJybEVaNzdhTFF0WDdpR0Q2dXlydGhPTGtIK3BOWFF2cFFnNjBmbnJKY2RG?=
 =?utf-8?B?VElxQjluSXhjMVhjeXQ3THI3WG9oTlNpdWtKZnR4UEdqSTlQK0hOeXY1UTZB?=
 =?utf-8?B?M3dnbVZNUitaZ0VYWmdsOTZ1bjQ0cUh6L2hJT1ppa3dWOXpnd3dJWk1xMHBI?=
 =?utf-8?B?dGxnbXJlM1A1RnBBQlhsYVNNc3g3RWhsbXNvRjhrQXpFTkdDVzYrVi85RlFE?=
 =?utf-8?B?NFh2bTh2eUlscXErNjF3dWNCNDZZa2x1Q3g1QlBhUklTTFVjdm9najU3OHcz?=
 =?utf-8?B?VUo4bVZ2SEN4TCtDWWZFSTAxVzd0TmFkSHV3OHpoLzdxSjFONnBpM0RiUkN4?=
 =?utf-8?B?TUtpWFh6ZWlyUDFxQ1o5N1ZGTm1iU1dUZmhiNnMwMk1ka1hVS2lQMUE1bEI3?=
 =?utf-8?B?ZDBJRjNBU04wOHI4WkVKMlpBejZXbEZSU3lCMmVER0x3UlRUSXR4bjgwd2xX?=
 =?utf-8?B?ajVLMUVxcStKbVppcVpsZ2VjSWRmZHVPQkt5d2JremhGbloydU5yU1FYclQx?=
 =?utf-8?B?Uzl4bndlQ3M0UldzMGRNQ0tXb0FmeDdoZzhDWkVreEVyVXR3RTN1QjBZVVdo?=
 =?utf-8?B?YWtZOFdpeDhEemVMVlgvbkplczlWSTFlZmlaV2FHdVd5SitxQU1oLzBEK2Zi?=
 =?utf-8?B?b3FhbVZvaEdhSU4xZjZCYjY3WXppNlBpNHR6V1g4L2cvOFp6UUI0em9KVHc5?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PmFBAjlOHL/ilFk2QbIlrjF/jR95THS44ZIKhRzaCP+SoLLFW9RV/5ldfVDletrUWCIUKLFSsUF6ScPjRPjEi2yYIbe2gcDs3nC7G89AwgewCbb26NH4BqDZCNmr4P0KH+WKU4hLXSlML1E90CX6R62YS+Ejp3cBlswiVuPBVHrf03I/1am0eYyIHigfAHNT5va8fiKM0YGwY95JDu8cwnAqPY3zI7C0GSWLVbkt2YzlcUBAe7WWWtMi6uherIo6VX41WN0y/2L8yLqK74h3ThBbYk6uEEpSnWnEnKcczXmRW/RJw4r0lOIorW03838VXc/fMc6OpPgBI3u2786XcMBUfiR2D8avd7GuVD0vKrPwoCwUs1JUFW7UpRnEKw/YNEzoYtek/WBm8xdwGtb+cgxzj28LmJU2zZzh2Hpe57RO1oT1eFDVsmbnSd8h502BIrJi8b4N3XynZvt9rJ1U/IRrdKDNEuneT0UQ2DhL2rUgwkCN7ZKOfmLBCPZ2km7zP+qYs2wm3WtElgzI0psMzzN/lNXbOOlDod6wP7nsBboovBum7LWn+K1PQgLfSS9DSWlVQJo1Nis+A4oju6m6LiuhkI2BUZO/oZ71F/9/RWU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f434b2-d6af-4ecc-fb5e-08de3d984ad4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:15:43.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dgki5RmgBLgLFYp1ZBbu2NOXl6mzQXiRisNhXgPq8Er5A5QkX+mB/wwGD7aCaE1q2feEZ8rcyitxkgBFb1QksFL6mDBDHzFV9AUBoCY01DU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170145
X-Proofpoint-GUID: CVbQ-aft7JcaZrb3ADhF_rhNpHD-HkgE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE0NSBTYWx0ZWRfXxoS81LH3rpd1
 2VsVeBycLa34PTugJC3X1/GFf4/c/ssxlwnucZB1VfzvyeBo+mBC5uA3PqlGXinNbkUzBKCOVYY
 QOmZeB8p4Rep2x4hlaq8mGuUPhdHtYph4KOXy4vtTXVcCcccY2HttbLP19sP7MiNXb6FwmBdL1b
 hEJydOmnHGMtFFIb7h3JjxLULTEloKQxt4Njtk/nyTHN8DGQ2Ng/6YT/gEel62JDHQQF/T/y32k
 qGTaxqPMT82r5bYUxMskA4rkld28JUoQ1XZSMzREgOyi6pCNmUUOLuhZTPQXbAWmvx8AkGRhCEb
 XbekBkw966pgEWsb42ofRoaVstKt2AP32woDK5P8OI9gBUxF6Hh3hZaMKn0tsd3njZTyc288laI
 kI2GaJs7oIHPfmkUh2WguhgZxmcOew==
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=6942f353 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nwmgzXUKAAAA:8 a=VwQbUJbxAAAA:8 a=6LEC0VUKZO2M76essDAA:9 a=QEXdDO2ut3YA:10
 a=8YVojpJ189lmoD23kkcf:22
X-Proofpoint-ORIG-GUID: CVbQ-aft7JcaZrb3ADhF_rhNpHD-HkgE

On 12/15/25 7:46 PM, Jarkko Sakkinen wrote:
> On Mon, Dec 15, 2025 at 03:32:48PM -0800, Ross Philipson wrote:
>> Secure Launch is a vendor-neutral approach to implementing TGC Dynamic
>> Root of Trust (DRTM) support in the kernel. This is complementary to
>> better known Static Root of Trust (SRTM) schemes such as UEFI SecureBoot.
>>
>> This series provides the common infrastructure along with Intel TXT
>> support, without needing the tboot exokernel. Support for AMD SKINIT is
>> pending the common infrastructure getting nailed down, and ARM are
>> looking to build on it too.
>>
>> Originally, tboot were approached to see if they'd take support for
>> other vendors, but they elected not to. Hence this approach instead.
>>
>> Work is being coordinated by the Trenchboot project, https://trenchboot.org/,
>> organising Secure Launch support for upstream open source projects including
>> Grub, iPXE and Xen. The goal of the Trenchboot project is to make DTRM easy
>> to use.  e.g. for Grub, it's simply adding "slaunch" as a command in the boot
>> stanza.  See https://trenchboot.org/user-docs/QUICKSTART/#linux-quick-start-guide
>> for more details
>>
>> Patch set based on commit:
>> torvalds/master/fd57572253bc356330dbe5b233c2e1d8426c66fd
>>
>> Depends on v3 of the following TPM patch set (note this patch
>> set is being actively worked on separately):
>> [PATCH v3 00/10]  tpm: Decouple Trenchboot dependencies
>> Message ID: 20250929194832.2913286-1-jarkko@kernel.org
>>
>> Finally we would like to thank everyone for their input and
>> assistance. It has all been very helpful in improving the quality of
>> our solution and in reviewing/strengthening our security posture.
>>
>> Thanks
>> Ross Philipson and Daniel P. Smith
>>
>> Changes in v15:
>>
>>   - Rewriting and reformatting of the cover letter, commit message and
>>     code comments per requests from maintainers.
>>   - Introduction of a early TPM driver in the x86 setup kernel to allow
>>     TPM extend command very early in the boot.
>>   - Remove previous TPM extending architecture that attempted to update
>>     the TPM PCRs later in the boot process.
>>   - Split slaunch.h into 2 files, with a new txt.h. The former contains
>>     platform agnostic definitions for the SL feature. The new txt.h file
>>     contains Intel TXT definitions from the public specs.
>>   - Split TPM headers up following the specifications where the
>>     technologies are defined.
>>   - Include set of split up TPM header files to allow TPM driver reuse
>>     in other environments (e.g. early kernel, x86).
>>   - Fix code formatting and type-os.
>>
>>
>> Alec Brown (1):
>>    tpm: Remove main TPM header from TPM event log header
>>
>> Daniel P. Smith (6):
>>    tpm/tpm_tis: Close all localities
>>    tpm/tpm_tis: Address positive localities in tpm_tis_request_locality()
>>    Documentation/x86: Secure Launch kernel documentation
>>    x86: Add early SHA-1 support for Secure Launch early measurements
>>    x86: Add early SHA-256 support for Secure Launch early measurements
>>    x86: Secure Launch late initcall platform module
>>
>> Ross Philipson (21):
>>    tpm: Initial step to reorganize TPM public headers
>>    tpm: Move TPM1 specific definitions and functions to new headers
>>    tpm: Move TPM2 specific definitions and functions to new headers
>>    tpm: Move TPM common base definitions to new public common header
>>    tpm: Move platform specific definitions to the new PTP header
>>    tpm: Add TPM buffer support header for standalone reuse
>>    tpm/tpm_tis: Allow locality to be set to a different value
>>    tpm/sysfs: Show locality used by kernel
>>    x86: Secure Launch Kconfig
>>    x86: Secure Launch Resource Table header file
>>    x86: Secure Launch main header file
>>    x86/txt: Intel Trusted eXecution Technology (TXT) definitions
>>    x86/tpm: Early TPM PCR extending driver
>>    x86/msr: Add variable MTRR base/mask and x2apic ID registers
>>    x86/boot: Place TXT MLE header in the kernel_info section
>>    x86: Secure Launch kernel early boot stub
>>    x86: Secure Launch kernel late boot stub
>>    x86: Secure Launch SMP bringup support
>>    kexec: Secure Launch kexec SEXIT support
>>    x86/reboot: Secure Launch SEXIT support on reboot paths
>>    x86/efi: EFI stub DRTM launch support for Secure Launch
>>
>>   Documentation/arch/x86/boot.rst               |  21 +
>>   Documentation/security/index.rst              |   1 +
>>   .../security/launch-integrity/index.rst       |  11 +
>>   .../security/launch-integrity/principles.rst  | 308 +++++++
>>   .../secure_launch_details.rst                 | 587 +++++++++++++
>>   .../secure_launch_overview.rst                | 240 ++++++
>>   arch/x86/Kconfig                              |  14 +
>>   arch/x86/boot/compressed/Makefile             |   8 +
>>   arch/x86/boot/compressed/early_tpm_extend.c   | 601 ++++++++++++++
>>   arch/x86/boot/compressed/head_64.S            |  29 +
>>   arch/x86/boot/compressed/kernel_info.S        |  50 +-
>>   arch/x86/boot/compressed/sha1.c               |   7 +
>>   arch/x86/boot/compressed/sha256.c             |   6 +
>>   arch/x86/boot/compressed/sl_main.c            | 638 +++++++++++++++
>>   arch/x86/boot/compressed/sl_stub.S            | 770 ++++++++++++++++++
>>   arch/x86/boot/compressed/tpm.h                |  42 +
>>   arch/x86/boot/compressed/vmlinux.lds.S        |   7 +
>>   arch/x86/include/asm/msr-index.h              |   5 +
>>   arch/x86/include/asm/realmode.h               |   3 +
>>   arch/x86/include/asm/txt.h                    | 330 ++++++++
>>   arch/x86/include/uapi/asm/bootparam.h         |   1 +
>>   arch/x86/kernel/Makefile                      |   2 +
>>   arch/x86/kernel/asm-offsets.c                 |  20 +
>>   arch/x86/kernel/reboot.c                      |  14 +
>>   arch/x86/kernel/setup.c                       |   3 +
>>   arch/x86/kernel/slaunch.c                     | 615 ++++++++++++++
>>   arch/x86/kernel/slmodule.c                    | 348 ++++++++
>>   arch/x86/kernel/smpboot.c                     |  47 +-
>>   arch/x86/realmode/init.c                      |   8 +
>>   arch/x86/realmode/rm/header.S                 |   3 +
>>   arch/x86/realmode/rm/trampoline_64.S          |  32 +
>>   drivers/char/tpm/tpm-buf.c                    |  10 +-
>>   drivers/char/tpm/tpm-chip.c                   |  34 +-
>>   drivers/char/tpm/tpm-sysfs.c                  |  10 +
>>   drivers/char/tpm/tpm.h                        | 180 +---
>>   drivers/char/tpm/tpm1-cmd.c                   |  18 +-
>>   drivers/char/tpm/tpm1_structs.h               |  97 +++
>>   drivers/char/tpm/tpm2-cmd.c                   |  32 +-
>>   drivers/char/tpm/tpm2-space.c                 |  13 -
>>   drivers/char/tpm/tpm2_structs.h               |  58 ++
>>   drivers/char/tpm/tpm_tis_core.c               |  21 +-
>>   drivers/char/tpm/tpm_tis_core.h               |  64 +-
>>   drivers/firmware/efi/libstub/efistub.h        |   8 +
>>   drivers/firmware/efi/libstub/x86-stub.c       | 100 +++
>>   drivers/iommu/intel/dmar.c                    |   4 +
>>   include/keys/trusted_tpm.h                    |   1 -
>>   include/linux/slaunch.h                       | 251 ++++++
>>   include/linux/slr_table.h                     | 308 +++++++
>>   include/linux/tpm.h                           | 240 +-----
>>   include/linux/tpm1.h                          |  87 ++
>>   include/linux/tpm2.h                          | 247 ++++++
>>   include/linux/tpm_buf.h                       |  57 ++
>>   include/linux/tpm_command.h                   |  30 -
>>   include/linux/tpm_common.h                    |  99 +++
>>   include/linux/tpm_eventlog.h                  |   4 +-
>>   include/linux/tpm_ptp.h                       | 139 ++++
>>   kernel/kexec_core.c                           |   8 +
>>   security/keys/trusted-keys/trusted_tpm1.c     |   1 -
>>   security/keys/trusted-keys/trusted_tpm2.c     |   1 -
>>   59 files changed, 6319 insertions(+), 574 deletions(-)
>>   create mode 100644 Documentation/security/launch-integrity/index.rst
>>   create mode 100644 Documentation/security/launch-integrity/principles.rst
>>   create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
>>   create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
>>   create mode 100644 arch/x86/boot/compressed/early_tpm_extend.c
>>   create mode 100644 arch/x86/boot/compressed/sha1.c
>>   create mode 100644 arch/x86/boot/compressed/sha256.c
>>   create mode 100644 arch/x86/boot/compressed/sl_main.c
>>   create mode 100644 arch/x86/boot/compressed/sl_stub.S
>>   create mode 100644 arch/x86/boot/compressed/tpm.h
>>   create mode 100644 arch/x86/include/asm/txt.h
>>   create mode 100644 arch/x86/kernel/slaunch.c
>>   create mode 100644 arch/x86/kernel/slmodule.c
>>   create mode 100644 drivers/char/tpm/tpm1_structs.h
>>   create mode 100644 drivers/char/tpm/tpm2_structs.h
>>   create mode 100644 include/linux/slaunch.h
>>   create mode 100644 include/linux/slr_table.h
>>   create mode 100644 include/linux/tpm1.h
>>   create mode 100644 include/linux/tpm2.h
>>   create mode 100644 include/linux/tpm_buf.h
>>   delete mode 100644 include/linux/tpm_command.h
>>   create mode 100644 include/linux/tpm_common.h
>>   create mode 100644 include/linux/tpm_ptp.h
>>
>> -- 
>> 2.43.7
>>
> 
> Most likely I'll review this after the holidays (for heads up).
> 
> BR, Jarkko

Thank you Jarkko.

