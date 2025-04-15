Return-Path: <linux-efi+bounces-3339-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A35E6A8A9B8
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 23:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1498189F5A6
	for <lists+linux-efi@lfdr.de>; Tue, 15 Apr 2025 21:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47990256C8D;
	Tue, 15 Apr 2025 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QwDQGStI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ym4/TjbU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6D25745B;
	Tue, 15 Apr 2025 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744750835; cv=fail; b=DqzDViVwx5zupfVkQ/yv4nKp+zYpljDpF9LJ7MBTdvjq/JAwzGLDt4ZXUcyMCZ7WN9QUc1fFho9yTsBzGtNe3TisTjNJykHvKK5mwz/yesUUexDuTbh1omNoBU/k74CNF4alywdxI38IBpgMT3SUzyvwW8YuS9/OB9iFF13/PGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744750835; c=relaxed/simple;
	bh=l+pnI96PUNBTZg5HTbWA49jsE0YUokpGzQPsWqVv3go=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PugQPTmoPyTPgKs+3D2djKASPKDNgVd83dbG0+tn2wT6NzcKEUueK+iEVwyU8rRgde7QZZbqsW1WXn5Q8M+7zpmalKaTq5z9vhxOVLLkpmqv2keazKY7vEdpgSNw2a53t7tKkE92VbAOJQ88rCtTs1yf4yJHNsW2exqF5xaAqmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QwDQGStI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ym4/TjbU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FKu4jO000899;
	Tue, 15 Apr 2025 20:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2x7VM3ubmcmvFlMCKncP0i5GxTYeOIp2OU4+dt3tq/w=; b=
	QwDQGStINmOd4jRfFmgLfM/rS5wJIvovwFV1R8LEtJPZYPSPRsp1OhKtrbSByj/v
	rPOxUpVqRZuO7REcWBJ+matuGjq0r9XUIA2O6v4vA8x44xDsnYlp9sBQ2V5lQYas
	zMQSM+T03fwd2a4mGWsBQZHPvg3rIbbAi83mDcEXWqwC5vpkjpi4kel+J1RWykFm
	KncfkGRMoEK7veriDfwR58JyYgThzBFxPjYWDMWIAp16uP19Hiyn5ZRkQAkzA2C7
	mEYhBRInI6KgVq1I5Q6R1xZFwnGXCpjcZKrkEzhOVXtdKmPH/YpF1o5XQsrCNGbr
	sMDS5X8rU8otLTQsczJNiw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 461944agye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 20:59:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FK8AUf009161;
	Tue, 15 Apr 2025 20:59:45 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010001.outbound.protection.outlook.com [40.93.6.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d3jnjbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 20:59:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdXinvdzIIdbDgIs6b5lmCBJ7Pl+hQMDIy+q4Be7oy1OTNK0bnNU89cw4DluRucxMEtdfG/V7Y+t491DuunHJDbRrhHWm30gKk01Z47XacNmB33UXWfEPgLCBJ9d1Y0Snw/2I7tiXDBz0IDjg1/K/AbyjakxesXiqtag6q/18Mvv95fuNgLCLh2UeyIldsh3W0LWKIAExn73a0ckA9DT9mAn43FuoHpXcKQ6iGg69gsO8L469NzFRjVwoj3FmCAz7qxzIC2yYxdwmwlw/d6MuOjpmgbp9Kv7eJDCywL+mWvZgU8SgmjkLbXKZm8Rk+oNPAO5IWLcsw51s9HTICa0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x7VM3ubmcmvFlMCKncP0i5GxTYeOIp2OU4+dt3tq/w=;
 b=oWnVRNFYL4b2EU8jhBEMkHpBYymnfmOQo3nkCA19fNInm8LGWyy9vj9fmqPHHeG3G59/xYHyD4pgImaVPnqG/l95dG+jRhvgSPPcC0k44r7u4qLNdVjcPKivsn1ZhEyWRlK/67ex0EyKEjCVJvWQqTd3Ad+EkzanQF7DnPf6FaqK4f1P0uOnnejV2sdyLvFZMr+Rr6aoR0xif011xoA67qDEgsCrwku6bDvZqfFpTtUrBnP/8kRhXqbh5f1kB8h1qfVNtfVIpKhgHFHVC/Swc0OekRVVsWOZ9KiyGN5slljPIgv1hIcqQdZdN8A5c+q5HY5meNPA0tNkemYTky9s1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x7VM3ubmcmvFlMCKncP0i5GxTYeOIp2OU4+dt3tq/w=;
 b=ym4/TjbUwnk1HzU1Mc7Lvt2cDu1Ipp4O/3em+SdMUS2jY67oUdZYPrvQ8AtLI0idC96mlvZvg8kmdm986gKgnhEFvX0pSyr+Gri6SkLkLnPC9fQZTSOu0zD9yCpH+is1qZfOlMfRqHBCJwiIalmhaSLm7x1LjXk9AiOm4c2eKPI=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 PH3PPF898A57FC1.namprd10.prod.outlook.com (2603:10b6:518:1::7b5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 20:59:42 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 20:59:42 +0000
Message-ID: <6f9c3f91-527f-4923-b2ff-f5703d91daac@oracle.com>
Date: Tue, 15 Apr 2025 13:59:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/19] Documentation/x86: Secure Launch kernel
 documentation
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org,
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
 <20250410204149.2576104-2-ross.philipson@oracle.com>
 <dbcc870f-123b-4505-831c-bc779bec231d@oracle.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <dbcc870f-123b-4505-831c-bc779bec231d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0710.namprd03.prod.outlook.com
 (2603:10b6:408:ef::25) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|PH3PPF898A57FC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fafcef8-9d5a-43d2-8892-08dd7c6071b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azd5eDRlcEJjdCt1alBMVElHZ1dsUjlWMVMwTGhCNnBLbkFxTi9DQ3JKendP?=
 =?utf-8?B?TXdSd0JKalQ3L2dFNDA0djN5WVNLbGo2eENwWmpEMTQ2aFJjUTErdTNFdTRS?=
 =?utf-8?B?ZkU4elNCSUNqMGs2SHFDcjJma1ZOY1FFZ0tPTTJPcXFCSmUrbVpMOXh1Mitx?=
 =?utf-8?B?Z0pRLzBpS2hVNEg4S3BJUGNRbTVWMkR3TXhuMmtxbXgrWmVtODU0ZFMvVWFt?=
 =?utf-8?B?TFIzbnJLR05VZ3RZeHZZN0xYL0xncE9nd0ZvQUpsVEtiMUh3N0VzYVlGbmJZ?=
 =?utf-8?B?V1o1Yys2SWViR25wWGtuTnlYVE5SWW5NbzFzd2kveFNiL0gwYWFITjdsU3Zo?=
 =?utf-8?B?MzQvTHRDQ1ZKemQvUFRwRGZuOGx2YVNwUzVEc0NMdndFM3lHT25WMmx1ZTZ0?=
 =?utf-8?B?TnltSVFBdU0ycm93aGVnazdVOC94V1NQalJvMTE5dnBLSXFzakd5SHJWUk1P?=
 =?utf-8?B?QTg0RVUrM2o5UXBMbUU0N3I4OFFaUU9ReVVBOUd0eDJpWUozVUNXRHprcWFk?=
 =?utf-8?B?dGN0RTlhRTc5WW83WGtNeENUN1Z2bTlHOUsxOVk1SUhyVXBrRnU5dmw0cFRp?=
 =?utf-8?B?WmVCRlpJTXh3TWMrZG9FdGtROWZ2d2VLN0JKZk9wZktTSGtHTEt2bUhIMnlR?=
 =?utf-8?B?ZGtlbVhuaEhtTFpDdzVUeUF4dTVuWnFWcUNpTURQSUJGUkpuMHFmVzE4ZXNu?=
 =?utf-8?B?YTZicXlZd1JUZHlwa3pxeUJkZkFnUE1abjNZR09RL3BSZkZscStrTUdKMnhs?=
 =?utf-8?B?czVJL21Lemd3WE12RjNGc2NWQU92UkFJWlA2eGhZc1dxYTlCeGZYcVZaWDVC?=
 =?utf-8?B?a0UrcGYxdVRlUlRmb0NwY2dLTlo1d1cxOWIxQ0g0ZW5oUW1SaXd1YVp1anoy?=
 =?utf-8?B?SitWMXpCbmVYTjNoOEdEdm1DODZKcElOVU5kdFFjVU5ReTQ1Rk82T1NZNUpl?=
 =?utf-8?B?WHBPODJja2hBbzZBNXEzTktjYXF1dnZUWFZTOVVDY1NGQlB2Nk1pY1VKOFFy?=
 =?utf-8?B?NDhNRCs2Ni9QNDhnS294OGdOK25wYmk2SW9LUjl5UDY0ZmhRUWJoZ0J3amZ2?=
 =?utf-8?B?dXNHZm1yc0o4OGZjckpxWnhOaHlrWVlhU3ZEenFRSm9iU090L2dzRkFFajVY?=
 =?utf-8?B?dHN0ZXRMdVFZdThPNUJiUjg0MG5HUk96L01hY1JvNFZRMWdKSERQd2ZvV003?=
 =?utf-8?B?MG14LzAxT2E4UE45Y0ViOC93S1hHcy9UdjJ4OXdOMmg0TS9uL0xXNzU3UG9Q?=
 =?utf-8?B?SW80aVlmanR5QnVhTDBsd3l1UkdHNEIrSjIzWFE5cDM3TzhzQlcrSWdVZGJZ?=
 =?utf-8?B?K0pGTk9kd2dsQjhpcVh1clVCby9mOUJ3L1U0b1JvT0VhVWZYWXhTVXpNLzh6?=
 =?utf-8?B?MFU5N1FvMGV5MURyMVZoTFVSYWtJSW1KUGw1RWoxK0JUZmhpKzU3UGpXeERZ?=
 =?utf-8?B?ekJjbWdQR1ZnWXZRVkpoRUtIdWt2WmlvbzhveDVZVFZPaTNqbFY0YlZoUFEz?=
 =?utf-8?B?TUwwcmIvSHh4dXVPbVplcmxwaFUxdSthUDVKUzVOMmFnQ01TNDBLTy9lRVJR?=
 =?utf-8?B?MnF6c0JXMGNjajR6dHhJallXVzdoTHhkQ0ZtMWJRRi9Yb0lYb0RTaWNvaHNh?=
 =?utf-8?B?SmpuWWlaKytOU3dudEpkRmpveDJQNWlpSVl4dFFzMHRoL1gwemJKU3Vhb21o?=
 =?utf-8?B?eTM5azc5c3hxQXpLNnJVaGRYb3dMMG8rUlJ1RmtEeHpaczc0UFhFem95ekgz?=
 =?utf-8?B?Yk1TeXU1T2NaL0cyQUhJOHFIdWxYVkJHZGZkVU9DcVIyT1kxcFZydE1RM0Ir?=
 =?utf-8?B?M1NkL1pkR3FuOGFSdWMwWWlJZTBrOHU5UmNhbEdCd2RkL2RaZTBkR3V4Q0lG?=
 =?utf-8?B?UGN6WFNHVDZCYW9lT2x2aGxLazZOQVduZkVoRHlSZWxvOEtscjJtcjloeDN6?=
 =?utf-8?Q?gCc0X3bgZQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUFFRnp0YVFuanp1VjlQeVU3RkFQTzFaRmpMTWlRYzljTEV5TVovWEU5Nitl?=
 =?utf-8?B?dk1QSk45VHdsRVBpRUtENFNrOXgweDR2RlN6N0FKRStMOUJyN2VyaVFWYWxP?=
 =?utf-8?B?S2xtV0hrTDJEcloxeXlKczR5aXJEa2V1ZElhZTlGWDZaMGFWSU54eHRUdEU3?=
 =?utf-8?B?VUhlUm5vTmFxQ1RGMUNFNGdRMGY4a08rZlJiYVc1eXJQUFFvckhBTm9iVnps?=
 =?utf-8?B?RGIreG9jY0cyYVA2dmw2K3BMQ2p2QkRWeFFoaFVGYTBhek1HSWw2T2tUYXNX?=
 =?utf-8?B?TXJMV1pOYm1SVkpuOW8zbngwZHJxZkphb2t5RTdkeEFZc2FoYjRVMlprSXQ1?=
 =?utf-8?B?NldDYlFjb2F4eGVQNkZOTUU4Y3FrUGkvaUxqSFNvNThweGh2TlF1WU9JOU5m?=
 =?utf-8?B?ekdOZzhudFlpWlpUMkdMMnFrSUVFSmllbzlrWGhtMXl4SGd6dmlreHRLa3Nv?=
 =?utf-8?B?YW5BeDNPei9rSTFJVk1yTkxDSHYwYzdtN2o5UTZIUG9sMzhYN1JKRDI2NGhV?=
 =?utf-8?B?UUJHdDRySUdCenE5MCt3TEJHRXpHdWJWTmdBQVNzb2UxZTIrQytpTmRGOW1E?=
 =?utf-8?B?ZEgyYk13QWlOdkxjSmtLTW5BVll6dWx1WnhLM2pJQURLVzk3RkhaYUNubWc3?=
 =?utf-8?B?c3hJdzNnbE0zOTJIN2VReDhQeTQ5VG93b3lESVBDWjBENmtJODJUbllIaXh0?=
 =?utf-8?B?emZWWlIvaU1FdmU5S0dpYUpBSTRQTG42cEQ4aHA4SGRacjVnYzRZa2N3ZytV?=
 =?utf-8?B?NTEyWTIrVGloUGU1TUozTWdLWFhOdzh3aXVEMjhTNzBudWNHYU81cHBZZnlK?=
 =?utf-8?B?Y0N4L0JEZjJUMExiU0k3VGhFd2VvK2c4VE1ra3JhMS82dFM3SkdiL0VPOU91?=
 =?utf-8?B?ZHJTMXVXZ1JkYWRxYzlqekpLeVdwRnIwSys3K09aY3dCR3JEeHFiQmdpRm1T?=
 =?utf-8?B?bkpXODhyT2tRbTA1QzdZaUMzaEZtRUVaTFJJWVU1THM2WXZ1ZzQzS05FUnhJ?=
 =?utf-8?B?cWI2ZEhyMGtyZjJyblZSQTJ0SDdzRGt6M2R2L1gwMm13TUxGaWR0cHRUSHZM?=
 =?utf-8?B?eWo2N3ZFWXIwUUtBWCszaGtqU2ZTTUtLL0JuUVY3MGptVWNIakZ5dDVHUndJ?=
 =?utf-8?B?NU5LdDJZYVpVWWVFbXJVRWZsSERzV0NjMFlIak1MakF3R2cxSGxaY1NZYk1X?=
 =?utf-8?B?cW43Vk5XRHlnamJNOVlaL0VjSXMwSmtQWVFhU2lyL1ZnQjU1NkprS2FjVWRw?=
 =?utf-8?B?SUNtMjFIcXVaS0ZwRUp5SERZSE5OaVpGQ2tlaGttT0ZLdkMxZ3RjYWJEVVlG?=
 =?utf-8?B?cjNjWkJEUC9lVklQZ1FTY0lWbzZXOUJVUll2TU5OQS83a2UzSkJLYUZCTWlP?=
 =?utf-8?B?dGVlY09HYm9tM2Q5QnR6L2cwUE0wZFVtRUNMZXl5dkVGZlVmM1gveklheTZ4?=
 =?utf-8?B?aEE2ZWlidW5RWXF1b2hFWFhhTWM4Yk9iVko0Y1hrem9HZWJKWXQwcm00ZTJB?=
 =?utf-8?B?NkN5djRTQVlveFRDc1JQVHFIR0lKdkJnNmZ1eFNMNmFwbTVtMHJoU0E5dVNs?=
 =?utf-8?B?NjFFTEpCaWk1ejNzT1VXbTJrN0Z4ZHZVS1dxaTFFUXNCSXAwTjBKY2g4TlFs?=
 =?utf-8?B?WW91Z3I1ZGQzNmxPUVYzdGZ2V0pyTnlzWjAxbzlDS0MxZURPTDF3cVdxT2FW?=
 =?utf-8?B?VTdpUVZ0RGpkdlpYYmhxbkQvMmRnU1plWmNsRTZTaWloVGU0L0pJR0RmUXBv?=
 =?utf-8?B?TjhyOVNrU0RXelhaRWx2dnpGdzNRelpvVG9IMEY1d3BIMURyWnl0N1FSeHBP?=
 =?utf-8?B?VVhocWdNY0E3c3EwaUJjK3k4ZzgxWndMVGVuOTNWaFVoR3M1Nm5JMmhUR3dh?=
 =?utf-8?B?SmJwN0dQT2ZvdG1QUTI3bXBsUkNRNjRNeTNRZ0Q0Wm1yUGR4N2hmWWtiRVRw?=
 =?utf-8?B?V1lHUXEyL1Y3NjVMWS9rakdHQVpOeE9rZklxdGxRVmZWK3IvSHpRMmd6T3k2?=
 =?utf-8?B?MFRkMUhlcUFKV1k3d1NQRC9ERUlWNzl3UGcybTd6SWI0Mnh4N0NaZ0ZLRml1?=
 =?utf-8?B?U2h3VmxyVmhiY0V1UnMxT0dUSkxNZ1BqSzlDWjkwNHpIay92Q3ZnMTJvV21k?=
 =?utf-8?B?UDRYTllHZVQ0ZEFTRm1xY24yNi9KTzVvdWo1OVZ3RzMvTWdqcGpBWi85Rmpv?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0EcNvOnRAVTnlYQbQDYz2+3ELB0v6QPuPPqeQ1U7FGFhd1L0q9c7bJ0Gog8ZI5bGE++jZmbSNTjHx8QZbDImHGl1r0YkWfUQ4WDkzR0hWJdn932/bpapq2bwTlnVlf0j18Z8/+YRw/bPfa2sEuYwCHFujciLMdpHmndRmCH/zmQC+eq50kR217/uRpC4Q7TSGvUux6FOuhLRcOjRubkAWOxag05FjB28cHv6/cZkgZSbMnUxrCNffi3JG6/rzkVY0VuAb3Y34LeU26Jfrw621WPL1JCegdte1RBdCoYi7GGVJmlY1CA21QIZa+/YVfhuxPaEZYtOiGCZZbkbvVOhzwvcqGPAWO/z+2l2yqGzb8adfhylVoBkxdqPF+TFVo2JLecooq4XBm2Tn2/XLJmOwgWJYs68UZMamR1t/gRFfa6TaY1JfbhxgcQk6yLDeIB00G4IdoiGkPubd3TA1gw+xwRaaypRola1cF3OudA/zuokhOOLrTvAXITjWxkcJiUQmWogcteF2bRFdYqXq4wI9YIA81BcBtJ82ABuaLsgGmuHvzUlejAXh2hX+JY/JewcGVRgs0JEq8vTzFmJaOb1d/09/7Gl5TKXf27vqpjagaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fafcef8-9d5a-43d2-8892-08dd7c6071b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 20:59:42.5602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvPd0ivSjr/KW2WShPlKgVAFkw/ThPvuKiSEAo/PxtOQz3Ye6db4bpMfhEY3uGJY8Bi3a2ebX9k42iQdhBFDyJZdyPikotgMpvuL483D04E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF898A57FC1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504150148
X-Proofpoint-GUID: 32YUEwoKIZ0yvsRprBCT3EH2ju3V2cIO
X-Proofpoint-ORIG-GUID: 32YUEwoKIZ0yvsRprBCT3EH2ju3V2cIO

On 4/12/25 9:07 AM, ALOK TIWARI wrote:
> 
> 
> On 11-04-2025 02:11, Ross Philipson wrote:
>> +.. note::
>> +    Intel TXT pre-dates the TCG Dynamic Launch specification. In the 
>> Intel TXT
>> +    documentation, Dynamic Root of Trust for Measurement was 
>> abbreviated as DRTM.
>> +    When Dynamic Launch was codified in the TCG specification, it was 
>> given
>> +    the acronym D-RTM. There is a similar situation with Static Root 
>> of Trust for
>> +    Measuremnt. In TCG documentation it will be given the acronym S- 
>> RTM but it is not
> 
> typo Measuremnt -> Measurement

Will fix thanks

> 
>> +    uncommon to see it as SRTM. For the purposes of the launch 
>> integrity documents,
>> +    DRTM and SRTM will be the preferred acronym.
> 
> Thanks,
> Alok


