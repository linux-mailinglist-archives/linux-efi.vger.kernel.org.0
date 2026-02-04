Return-Path: <linux-efi+bounces-6088-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LCLNNqFg2llowMAu9opvQ
	(envelope-from <linux-efi+bounces-6088-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 04 Feb 2026 18:46:02 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A59EB176
	for <lists+linux-efi@lfdr.de>; Wed, 04 Feb 2026 18:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B81343002D11
	for <lists+linux-efi@lfdr.de>; Wed,  4 Feb 2026 17:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ED134C816;
	Wed,  4 Feb 2026 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fIirhGdx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jur0Kupw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D23491D6;
	Wed,  4 Feb 2026 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227144; cv=fail; b=pZMkfRdshFvVewN1tidswKziHMlmqmp7SPcQ7jLwdowb/32z7kEqhTeg0Raojdm/VdDoXoJ5AZLtDVBKjvsX6cO35pqQugvTHtrUAcdcpkPJbSvEOiHCAAYXt3P8aj4WYFxfdzSfhCfx/RN0iqZxsu/k8pnkx26oYK2rkl5L8es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227144; c=relaxed/simple;
	bh=AtIQwPJdWP5XCHEk2BM65AMPHziyaFGUCDZhFJ/GhXg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KdQFSE3ASkV4dHD/u92g5AUTwA5StfpyHeY5cE9yld7CtuV4UoS5qZVGu2nFfsydxsH4MnA8VoMnDN8wulod0SsStG1rfCO1nbAK2i36Wv9inFie5vW7gEDaU6bitchZAURUkygi3h3QNcO5zF3d+a/NgoXJmv2MF/T+a4BqvWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fIirhGdx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jur0Kupw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614DOE0M3258017;
	Wed, 4 Feb 2026 17:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mToUCRbwFhC5I9O8hcT3wFa66d0BnnJXnag524t6Lek=; b=
	fIirhGdx4X0/DxEyyFhQzup+8Qzd7dE/pXfWxuwQ4KZ+gVQOdaMqfIrw5tZV7lLu
	4JVx07bW64MmcCdpVUjKNESUnKDprQpMxeSl4hmdmqj1EvVVgswJjwNMwE/ag5F5
	h1pLG8JU6iGIR3n13vFZvaUzVia/EsS3kV9dAucsqDcSaWhZaaHYMQrD8VMC2xnD
	P4LfuKq7Z08Sh5XARJ43jl8sNazISWK2xoY8Hu4l9zjxq6Zh179hS3JyQL0w/jvl
	OMPcspdK4D044/tgT5Zy4fHc4LBmX3EeL4Gp+Q31sqYEpd1gYZCmOiwsEcMl5z2a
	KwVrbeYTBWB/BPVqpAIS8Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jsqjakw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 17:44:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 614GHa1V025788;
	Wed, 4 Feb 2026 17:44:46 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c257ac60e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 17:44:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+r+2qyvR2e650BpV7+1aQtvNGfyUQy8bP9c7WIKnLBdr76TYH2ChK5tKhVrWNkn9gl3Q+uEbISGgdaKbpRX81gKA1ZQfj13W/uckL/2hjxJqLuLynmFBziOwcHU+EsWOMDDDCcwOeshLKzk5bIrU15Tj2lbB+lVz6YpHtwFPZ3H5vvhOncv0oxDVtwHiK1bUBqwcWSPB4LviEzVGXCEHzpJHPcGRccGDostsGt7Kj9U+d6ZDfpnqSA1FQfhb69GPf8HNGzyhDyFfG9SVqggCbWyAyk0PZ8LhACFKClxl9kIH71UnUsW1xfnmDCbqiCLgMEX6smNPkvRFIMcTvLvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mToUCRbwFhC5I9O8hcT3wFa66d0BnnJXnag524t6Lek=;
 b=Oh9w9K5LorKkgH9PIZx3xC/Fr9UNOPuC4ahDcF9zlCmzMwi7F7BCsYshO4eEYOxyGcv784+VgpaF33AjGUkg59wvNR6ea2LkUG5lsGhwD/KnMDM1HkbEmjrpAZeg8PnOnzaDOt51E0xotWLWByXgMeTTqo1UE05ckm4OehMdS3qPxIloNDzRew39Qc2g693/1q9cptzbkMLBPaT6uBwV4zJWoH2kCVG8w9VVwFLS9K4wdgY9MN5NTvGtc/ZLANIzFm1oHRodHwmf9wjESWRuHwIywgr3mmSEsvZxoryakqbEnnmI6VrmeJjrgGpkIhHo02Cs63hKuN0jKGFxTvsjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mToUCRbwFhC5I9O8hcT3wFa66d0BnnJXnag524t6Lek=;
 b=jur0KupwooYDry5M6l49hUTGrtAQQSVZ8rdOlOp1Poo6YWySllZs/0gZifx9CUhm+sbzpfIHsIKzhuL8OWYDUKZaS/ea9jP2rQpj2fQZ6/vxJeH6FbS7eTIwtbJVHVKT8hsUP8kdSQiVOjsUe69YstN+QL3AvvrSm58pxzkzP40=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 PH3PPFCA9331432.namprd10.prod.outlook.com (2603:10b6:518:1::7c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 17:44:39 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::30d0:8be0:725b:3e0e]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::30d0:8be0:725b:3e0e%5]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 17:44:38 +0000
Message-ID: <6e1e771c-ecd4-4ab6-ba9f-900f34c5d89d@oracle.com>
Date: Wed, 4 Feb 2026 09:44:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 02/28] tpm: Move TPM1 specific definitions and
 functions to new headers
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-3-ross.philipson@oracle.com>
 <aW7E2dVlmjZIUivW@kernel.org>
 <7aad3461-f0a5-42ff-ba9b-b52edd7d36db@apertussolutions.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <7aad3461-f0a5-42ff-ba9b-b52edd7d36db@apertussolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::12) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|PH3PPFCA9331432:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c5671b-a13e-426f-0af4-08de641511a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0ZDeWdYOTVGK0VyT2FWb1IxYkpZOXhZYU96MUlRUVI4Qm4zK1Qwa3lvNENS?=
 =?utf-8?B?U2RwZ2dVQmVmcmh1TTZUSjd4Q3VqMThZNEJIWGN3L0F2Y21BL0VvMis1YTRm?=
 =?utf-8?B?U1pGdmU3SHZGbVZOVFlNSGN2YXp2YUo0aHl3VkVlUll4bDJyd3ZQK1NYcXYz?=
 =?utf-8?B?UkJudExKYk8yaDFvZFNlbENIeWxwNUFJMWdwQjRpV3N5TmZVK3drMlAxQVoy?=
 =?utf-8?B?VDd4SUY1QWdUaVdKQWhVT1htaVdCT1pwZ2ZPOXhsZ3l3Yml3RExtaTl5dkZn?=
 =?utf-8?B?UjRNWVA3LzZpUlFCVTJ5Nzk0V2tubi84aVoxdXZDRUJMaUJaY2lrYUc5dm83?=
 =?utf-8?B?TjV3clUrUnVySjRkcW5TYWZ0Z3k3WFhTV3ZtVnJBNlByTFErcVBsR0d1ZDRV?=
 =?utf-8?B?RmFjRlgyb095bUQrUUFvK2dMb1hlUXFNbGZ6dmVBWUIycjhMRVpBQm9WcjhT?=
 =?utf-8?B?RHNPNEErbTJ3bnJZaVNhMEwxRStsWEpVSTNoa3BQOEJkdFU1K1lTcXVHMDQz?=
 =?utf-8?B?b0s2NFZYSG5EQ2lDY1EzeDF2NWpTUHZrcnFTd2kxZm9pdEVCdzd5bzB4UmR1?=
 =?utf-8?B?ZDBZaUlkejBZOUhjNzZIQWVlSFlOaEFlbGlnb1hnRkZYWjJOOTRsbHdvOW01?=
 =?utf-8?B?aEQrenFHQjJYdHc0SHRrbUpkZ2YraWQ3Qi9hc3l6Ky9KeHdmdktaTDFkVzFz?=
 =?utf-8?B?dTgvYWdVbkZ0OG9ONkkrQlF3VGxiTGpEeFRWSDNTM2YxR3Y2RHI1WWUyWTlR?=
 =?utf-8?B?dS9MWGpMMDlXcDZHSE16M2hUbUZVQWo0S1R1QlgxK09VeUxzSnRwb2YzWHI2?=
 =?utf-8?B?YUpraC9Makl2MFRMclQzRnJUcjVrck1xNUgrTGl6ejF6bFQwL1krbUdMa3VH?=
 =?utf-8?B?a013ak1jOW9uT01kSXUxa3ZJRk5XSDIzTVNkZEcyeVY5QUUzRlA5UXNldmVX?=
 =?utf-8?B?TlRGY1hPNGxjR3kreTNob2xTOWlmdXBOMlpQRm0xd28yN1JLQnJOYnRnYVRx?=
 =?utf-8?B?K1p0azd3YTNKcnE3Rm91SmJFd1luNHBNRTdweUZNbkpub295bjJ3ZmtJak5U?=
 =?utf-8?B?MzhWVlJCREVkSDhML1NQd3FhdWVrajIxczNHb3NtazhqZmpFS25xVk5ic3pW?=
 =?utf-8?B?YUh3NEtJQnZVVzRvdExxdDRSUzVwMzFVWk5IdG1pN3NGSE9ycjg3L09oQTVJ?=
 =?utf-8?B?eENRVXduOUl3UXByb2MzaXl3ZUJTcnFVc0thYzJrbkUzZDdTVVM5b2RONDlF?=
 =?utf-8?B?TWYxODZyQlZJYmJIRjVvbDIvN3JyeXo2Zm5JSWR2TWUzNzFVdmVuMVd2K3h3?=
 =?utf-8?B?WnN6WEw1eGVad3hldHNEbE1hcnBTTVF5cjkyNTh0S1VmcUVmdXNYcEN0d3N2?=
 =?utf-8?B?YmlSM3B6bDNCNXVyNmNmTnc5U0hNenhJS2t3UXZ1S3Q2NTNYWU4ybDNKMDhO?=
 =?utf-8?B?MzE3d2hwbXQrM3hNb3NhdFdtSjZMb3hTZ1VhbjcyWnQzY1U4ckpSZkZaZnlD?=
 =?utf-8?B?Q0VkN0pyTXBSVDdhM1JjYXVJcy9TaVhpb1V3aVpHdWQ1MHpReXpsUlhsdWtw?=
 =?utf-8?B?QllqaCs1eEtoMTE4NzhFeklQQk9PZDRXL0FNcVNVMkViakVxMnFybWphSlo2?=
 =?utf-8?B?QXVzV2FKQzNjMUFLb3lzdjcxY1d6VHZWUlpZWFZkbzZ0bk5MdFJLZDB6c2Ex?=
 =?utf-8?B?b1lQZ0RSb3pGNTZQSmNiVTB2emlsU21uN05RbE5xTDlleVRmZ2daWEFCelIw?=
 =?utf-8?B?aEU1WWF2cExaVllVYjBFTFhBRjExSDBUNTUwMWhPZnFnMDNoZVh5dkwxYzc3?=
 =?utf-8?B?MEZlNVRlbkhhQ1hQRThZY1FvMXpwdkZMRFpURWsxUjAybU1hU2ZYdnlnSlcy?=
 =?utf-8?B?OUxTTkVQMFVzbFFpWFlkaDYzVHpBbnJsdXhXeWJJaFNTUWs0RXk4ZG8xL042?=
 =?utf-8?B?UGIrLytVR2xDUGlRYkNjRllvQWplNlRRc1RQNEVna2t6Q1dPdXlpdDY0R3NJ?=
 =?utf-8?B?THNyR1g1T05QcWNWZGpHcmFDdGVqM1k1Syt5dDczb0ZxaC90NTgyZnNRL2dB?=
 =?utf-8?Q?u+b/9X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzN0WVptVHVtNUswMzhidDlqTjNrb0YzWUw3VzU0TDVXRlFwVjRXNzZGRUF6?=
 =?utf-8?B?UzFQWEtSeXRMYUpJN0ZFRVNVTjBhY0xyU0hobWhzS2tuak1FYm42ayt1TTZI?=
 =?utf-8?B?d0pPa2VydXB1QlIxeWFVOTVGTXhHWjFhV09HTU4xc2cvN09taGw3RjZNMTNa?=
 =?utf-8?B?RVBVcllPYnpoaDJiZEFObk5Xd21kSWQxdjBSS0RXRXBJa3dpTEcxQ1h0a1Mx?=
 =?utf-8?B?WTZKeUtaVjE1M0ZuWjlKY1lZcjFZZ3prQXdzcDZEelZTZXh0R3UzcGl5MWJC?=
 =?utf-8?B?dzlzSU1iZi9TVW5Xd254c2VaRTQyUnJ6TXc3L1NvUm5nM0RuWWE1Y29Xd1JB?=
 =?utf-8?B?N0Z2TVBXM0lxNTR0RG4rbXo3VFM0KzMvZTNLdmUvemhDVVB3N1Iwc3RINEha?=
 =?utf-8?B?eTA0aUE4WCtLVVBZbitPME40bFc3aklvRkRYcnhPY2plSU5qbmRrZllzN0lY?=
 =?utf-8?B?NE9keUZFMlNXV1pUNk1SQUNYcEtBYkVDRFVHbmdMUjBYaUJiV3IrVHd0Q3ZP?=
 =?utf-8?B?NG9nbkpQc0p1QSt3N2l2TytadFowR24rdVdzSTlHbE9sM1ZNYWxseHp3NzZ6?=
 =?utf-8?B?eTYxYkxjd1ZLcTBOcEZSdkFIcVN3TGZSRGNLSUZLVzQ4OUhRS1E1VnFOTWlN?=
 =?utf-8?B?cktVQ3U4UTRhNHZST29BS3Q5cWRMTHU5QnVKUnNmVnorb2dkUW1zNDRBc0ZM?=
 =?utf-8?B?aFpjaGJIZG4wTFNSNWQ1VEpHQlA3b21CQXVublZEdHowQ2JxL1k2RnRmaEtJ?=
 =?utf-8?B?MmNZVzdPTW00Qlc1UFhmM3RpUnJpTi9naVYyY2Q1aWt6YWFKK1Vab1lBb0gz?=
 =?utf-8?B?aDJIRk5aUW9XOTdYZHc2ZGJpeElBQTFQQ09kbnB2d211a3dkeTdoWmxwZEZO?=
 =?utf-8?B?cU4ydkxHYTVVVzhINm9kSU9oem1LckNqWjhJbXVrZTBhWkN0dTZoR1hsTDlI?=
 =?utf-8?B?aDhhQ3lKK09wVFJleXZmSjY1ZmRYc2o0UXVmQ1hRSVNJalpxczEyT2U4MEYw?=
 =?utf-8?B?dXp2bHVRakxjcWFkK09Qd2xOS014SksxK00wVU1GVm9KQUZXTjJLOCtMbS9y?=
 =?utf-8?B?My9JL08rRjhPeEZUQWUzRnpTNVZYOVR6TVpkUTkwb0RXanpQVmw5SzlSZnp6?=
 =?utf-8?B?N1k5N3BmTko4SkVMSVpVZ3JzWFdoT3ZrUjlLbjFSSFMyQVU4ZGhvczFqNGZ4?=
 =?utf-8?B?d1hmL0lheWRzSU5FV3NXQlF5L1JJYTdiRGNGdzM2dUoyRmsvTit0bHJlYlgz?=
 =?utf-8?B?S0oxblRmTlRzQUFtU1hzUGRyT0VETzdsN09pazlHdHhMTHMwYm1kMGhvWERB?=
 =?utf-8?B?UkpiMEtzL2dacnI1KzYwZFBzUEdvRDVwbG0rUHc3WVRlb2dTa1RMSGdrdk5U?=
 =?utf-8?B?bXNmWFA4Nm5wQ2w1cHZ1bDVDSy9Ia2JFQkpUYUhlNGYweW04akZIcWJFVU11?=
 =?utf-8?B?NCtBU09ncTNORzRxaUFhZkVYOFkwMm0xaTJXQmQyZllZaDdOZVZ6WStjTElp?=
 =?utf-8?B?bmdBN0RQZ21TU0JPbG9RTjQ2TXVHU1JzS1QvaytVb0VRVmlSM0R0TmVMOWVO?=
 =?utf-8?B?SWNTcjE2aU04Z3JjTFdCVEIxRzJpdnZINDdNOTFBcUlTcFh2QnJYOXExL1hL?=
 =?utf-8?B?WWVRU1g1aWJIODBkejhWcUE3aCtYZ3NIVVhQbzNpRkFtMXR5d1c1c1hmd1JP?=
 =?utf-8?B?L0tnbWxHQUx4Q3pGUFgwRVJmYW9BcnNOb2FkNVMyK1U0VmxVMEhsVnVTTms4?=
 =?utf-8?B?UkVJRkV2YmVXSm41U1pVcU9DZllNaTBQYmZHVUxRSnZuMzIwcXpZTGJWSlNU?=
 =?utf-8?B?bXdwZE5jM0FRNjIrNWt0RDh2MXJERVpjNEdiMHVNRStkYTNDbER2RXI0alJ0?=
 =?utf-8?B?VHh5MW52Y1V4U0UwbVg5dSs5VnVhUHgxZWZFYms0MUFFK0svblVkTW03OFhG?=
 =?utf-8?B?Yk9ibmNpUWJSQWFRSXNLQWRtUHpwNWdqWWhrejhvL0VyMkNjcllPeHllaFdQ?=
 =?utf-8?B?dmNhUStOelp1ZytvWlY4VitCY0xaUTN0Ri8rTVNKdC9BTnNJWTZTVkF6UjVk?=
 =?utf-8?B?OENPOGQ4am1McW9FdTZka2p4UUkvTWlIbGpwTDdVWHgvQWNkOVhSZUlCck1h?=
 =?utf-8?B?QjI2MDYwdXUrZWZuNHdOY0VlSEVMZkY2K0VCUmdxU0c4eERZT0hZY2kxanJs?=
 =?utf-8?B?d3FGMmFXUXlRalpZcEZLTlEzMlBURnNMYUlUQUlXclpiL2JQRlIrbGtxM0lt?=
 =?utf-8?B?a3ZXekt5NjEwSVB3c3Y5T3MrL1RXV0MyWkk2ZkJhZ3ptNENqWWxCaXVTV1hv?=
 =?utf-8?B?cWcyOUVNd2FCSnBUVkliNjQ1NnlOUitnMTloNlNML3EwMWQ0M0ZDSWp5cENt?=
 =?utf-8?Q?lDNtEMi4utHvwC1A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Za2jj2ydW+ERdmtT/Eh4OEgpKwwtdl8c9ex4qP7+jXRAHUHbwrlZgRYTv9GraA2xv4mP15GKJZPWrKreFgxFahV2oO3Tt2pY8PFmPvyN2LtoCt2IQXFDKeejjwWZ+EdrhRdYQeGC+rooTpa3Wyq7zMqMQ6oIgUD7KcZKUuzI33aZ2cHLO6KBORicIp4w20sEAaH1lMnnPWS51ZWVBmuf1x+VCmciAbj08/fUNhzG7q9T1QzFuDiWUfLXcog8o9yjss4f7a1quzGKCjIaCMjTnnWPUOp69pz5sAmIaHQMwRMVFNgYCZbhKVWMZ3Y0pag6nlzRRMAOsutxk/KHPLcYRr+j0CfVIXeMZj6KIMOr+K+AiXmgjXZjT8INUHKtMRbKhCUUIQhZpAeJCEszS5udHi8e2Bf+GhH0n/68KbjWg+6TofBacndZqtrpzYdQaYDfu4QK5wKK5Dz7CtVraAZcRhEVkXrVIGDo4vLaTBeVe2Ev6JU5F0KAKWA5mX0/WRAYfyFzG4GZX0ER8Ye9qKc2RHDRB/tTbbc64fceXn5fMucPWoQaHSFYRNBesdwhN8/HUc7LjJpnB7dAUQ3QPtAIDhoT+2unKfqtG1H31DAlbek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c5671b-a13e-426f-0af4-08de641511a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:44:38.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9TdV4OvN59iCKIU1yTGYJ59EbyzI1J8Za+jS052XLnv4Wt+w1UcPVk9vddaO1lc+F8Ba0Fo4fXRE+Z/Kkh1/N4ZbY3dH9/nh53ZHEYq/0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFCA9331432
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602040135
X-Authority-Analysis: v=2.4 cv=Db0aa/tW c=1 sm=1 tr=0 ts=6983858e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xt6ew7UTAAAA:8 a=UN5060LkAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
 a=FP58Ms26AAAA:8 a=IFuHbMLi-Pw2QU87uAwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tn93DeGZTgJ6DdWMtdD4:22 a=E6eXv-vVeS7VqOnxGRGn:22 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: Lv7Gcblx3MkUZSQQF7P_ZP0gDxy838eq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEzNSBTYWx0ZWRfXwgXxTG6zdceI
 BrtVHmBHpBUmdZU73XKXy3y+wcT/U6HwzCE0WUOugpc8Y12FoysjwEncNMvfZSRPqIu+sCVihrP
 wIF0OMsrpY/pAiFLYnTb0dth/jGz01Y+zZqGcxcsGU4VQ8qrBzslHieP+XDriEwLaqYMs+ENvvN
 kgD30Rcj43HH+jYWXzLme3DKumW8LAg7m36sya5nw0BITRJG9CY1kwsjgokN3k2c0bn7L5DZ2eD
 ARME1kB9plmKMLMOszOlstyYDdap+DRieQtMHd556SM4TJL+xhsdmI3MtMFasw0dkMNURnMLkY6
 cnHIVW7qeUFm6EVfDlmyY3VQkl0ZArwShT+czWFTsMu06M5NaMJIiHDneZlEeUKKiyG3ZpE5HE2
 La8qcPpNlL7k40P7KRaANPaAAqe6V/6TfzRWJsBad/9RH2P9Rj8C4rlSaA4y9qhTQKH/TPaSG+E
 FODZ+tmTTomfWzLBGzdsbEIo12wGPsEkhQuQwjNg=
X-Proofpoint-GUID: Lv7Gcblx3MkUZSQQF7P_ZP0gDxy838eq
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-6088-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,urldefense.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,apertussolutions.com:email,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ross.philipson@oracle.com,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 89A59EB176
X-Rspamd-Action: no action

On 2/1/26 8:23 AM, Daniel P. Smith wrote:
> On 1/19/26 18:57, Jarkko Sakkinen wrote:
>> On Mon, Dec 15, 2025 at 03:32:50PM -0800, Ross Philipson wrote:
>>> This gathers all the TPM1 definitions and structures into two separate
>>> header files (public tpm1.h and private tpm1_structs.h). The definitions
>>> moved to these files correspond to the TCG specification for TPM 1 family:
>>>
>>> TPM 1.2 Main Specification
>>>   -  https://urldefense.com/v3/__https://trustedcomputinggroup.org/resource/tpm-main-specification/__;!!ACWV5N9M2RV99hQ!OivTxO-R0nvBJYXIV-T0n0fq0wY64MTgdaecPzAauxrFkRxTcQ6CuBEcXmZZYY1KfZlqmfLTZBbPaEr7Y8k7hJk9_mQ$
>>> Note that the structures were pulled into tpm1_structs.h to allow their
>>> external reuse.
>>>
>>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>> ---
>>>   drivers/char/tpm/tpm.h          | 98 +--------------------------------
>>>   drivers/char/tpm/tpm1-cmd.c     |  5 --
>>>   drivers/char/tpm/tpm1_structs.h | 97 ++++++++++++++++++++++++++++++++
>>
>> I think you are overcomplicating the patch set and doing more
>> than you really need to do.
>>
>> I.e. structs could go also just as well to tpm_command.h. We
>> will deal with if/when that file ever grows too large. It's
>> absolutely not a priority for this patch set.
> 
> Ack.
> 
>>>   include/linux/tpm1.h            | 34 +++++++++++-
>>>   4 files changed, 132 insertions(+), 102 deletions(-)
>>>   create mode 100644 drivers/char/tpm/tpm1_structs.h
>>>
>>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>>> index ca391b2a211c..1f9f8540eede 100644
>>> --- a/drivers/char/tpm/tpm.h
>>> +++ b/drivers/char/tpm/tpm.h
>>> @@ -50,105 +50,9 @@ enum tpm_addr {
>>>       TPM_ADDR = 0x4E,
>>>   };
>>> -#define TPM_WARN_RETRY          0x800
>>> -#define TPM_WARN_DOING_SELFTEST 0x802
>>> -#define TPM_ERR_DEACTIVATED     0x6
>>> -#define TPM_ERR_DISABLED        0x7
>>> -#define TPM_ERR_FAILEDSELFTEST  0x1C
>>> -#define TPM_ERR_INVALID_POSTINIT 38
>>> -
>>> -#define TPM_TAG_RQU_COMMAND 193
>>> -
>>>   /* TPM2 specific constants. */
>>>   #define TPM2_SPACE_BUFFER_SIZE        16384 /* 16 kB */
>>> -struct    stclear_flags_t {
>>> -    __be16    tag;
>>> -    u8    deactivated;
>>> -    u8    disableForceClear;
>>> -    u8    physicalPresence;
>>> -    u8    physicalPresenceLock;
>>> -    u8    bGlobalLock;
>>> -} __packed;
>>> -
>>> -struct tpm1_version {
>>> -    u8 major;
>>> -    u8 minor;
>>> -    u8 rev_major;
>>> -    u8 rev_minor;
>>> -} __packed;
>>> -
>>> -struct tpm1_version2 {
>>> -    __be16 tag;
>>> -    struct tpm1_version version;
>>> -} __packed;
>>> -
>>> -struct    timeout_t {
>>> -    __be32    a;
>>> -    __be32    b;
>>> -    __be32    c;
>>> -    __be32    d;
>>> -} __packed;
>>> -
>>> -struct duration_t {
>>> -    __be32    tpm_short;
>>> -    __be32    tpm_medium;
>>> -    __be32    tpm_long;
>>> -} __packed;
>>> -
>>> -struct permanent_flags_t {
>>> -    __be16    tag;
>>> -    u8    disable;
>>> -    u8    ownership;
>>> -    u8    deactivated;
>>> -    u8    readPubek;
>>> -    u8    disableOwnerClear;
>>> -    u8    allowMaintenance;
>>> -    u8    physicalPresenceLifetimeLock;
>>> -    u8    physicalPresenceHWEnable;
>>> -    u8    physicalPresenceCMDEnable;
>>> -    u8    CEKPUsed;
>>> -    u8    TPMpost;
>>> -    u8    TPMpostLock;
>>> -    u8    FIPS;
>>> -    u8    operator;
>>> -    u8    enableRevokeEK;
>>> -    u8    nvLocked;
>>> -    u8    readSRKPub;
>>> -    u8    tpmEstablished;
>>> -    u8    maintenanceDone;
>>> -    u8    disableFullDALogicInfo;
>>> -} __packed;
>>> -
>>> -typedef union {
>>> -    struct    permanent_flags_t perm_flags;
>>> -    struct    stclear_flags_t    stclear_flags;
>>> -    __u8    owned;
>>> -    __be32    num_pcrs;
>>> -    struct tpm1_version version1;
>>> -    struct tpm1_version2 version2;
>>> -    __be32    manufacturer_id;
>>> -    struct timeout_t  timeout;
>>> -    struct duration_t duration;
>>> -} cap_t;
>>> -
>>> -enum tpm_capabilities {
>>> -    TPM_CAP_FLAG = 4,
>>> -    TPM_CAP_PROP = 5,
>>> -    TPM_CAP_VERSION_1_1 = 0x06,
>>> -    TPM_CAP_VERSION_1_2 = 0x1A,
>>> -};
>>> -
>>> -enum tpm_sub_capabilities {
>>> -    TPM_CAP_PROP_PCR = 0x101,
>>> -    TPM_CAP_PROP_MANUFACTURER = 0x103,
>>> -    TPM_CAP_FLAG_PERM = 0x108,
>>> -    TPM_CAP_FLAG_VOL = 0x109,
>>> -    TPM_CAP_PROP_OWNER = 0x111,
>>> -    TPM_CAP_PROP_TIS_TIMEOUT = 0x115,
>>> -    TPM_CAP_PROP_TIS_DURATION = 0x120,
>>> -};
>>> -
>>>   enum tpm2_pt_props {
>>>       TPM2_PT_NONE = 0x00000000,
>>>       TPM2_PT_GROUP = 0x00000100,
>>> @@ -229,6 +133,8 @@ enum tpm2_pt_props {
>>>    * compiler warnings about stack frame size. */
>>>   #define TPM_MAX_RNG_DATA    128
>>> +#include "tpm1_structs.h"
>>> +
>>>   extern const struct class tpm_class;
>>>   extern const struct class tpmrm_class;
>>>   extern dev_t tpm_devt;
>>> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
>>> index f29827b454d2..02f20a0aa37d 100644
>>> --- a/drivers/char/tpm/tpm1-cmd.c
>>> +++ b/drivers/char/tpm/tpm1-cmd.c
>>> @@ -505,11 +505,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>>>   }
>>>   EXPORT_SYMBOL_GPL(tpm1_getcap);
>>> -struct tpm1_get_random_out {
>>> -    __be32 rng_data_len;
>>> -    u8 rng_data[TPM_MAX_RNG_DATA];
>>> -} __packed;
>>> -
>>>   /**
>>>    * tpm1_get_random() - get random bytes from the TPM's RNG
>>>    * @chip:    a &struct tpm_chip instance
>>> diff --git a/drivers/char/tpm/tpm1_structs.h b/drivers/char/tpm/tpm1_structs.h
>>> new file mode 100644
>>> index 000000000000..ad21376af5ab
>>> --- /dev/null
>>> +++ b/drivers/char/tpm/tpm1_structs.h
>>> @@ -0,0 +1,97 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright (C) 2004 IBM Corporation
>>> + * Copyright (C) 2015 Intel Corporation
>>> + *
>>> + * Authors:
>>> + * Leendert van Doorn <leendert@watson.ibm.com>
>>> + * Dave Safford <safford@watson.ibm.com>
>>> + * Reiner Sailer <sailer@watson.ibm.com>
>>> + * Kylene Hall <kjhall@us.ibm.com>
>>> + *
>>> + * Maintained by: <tpmdd-devel@lists.sourceforge.net>
>>> + *
>>> + * Device driver for TCG/TCPA TPM (trusted platform module).
>>> + * Specifications at https://urldefense.com/v3/__http://www.trustedcomputinggroup.org__;!!ACWV5N9M2RV99hQ!OivTxO-R0nvBJYXIV-T0n0fq0wY64MTgdaecPzAauxrFkRxTcQ6CuBEcXmZZYY1KfZlqmfLTZBbPaEr7Y8k7HW5iz_w$ + */
>>> +
>>> +#ifndef __TPM1_STRUCTS_H__
>>> +#define __TPM1_STRUCTS_H__
>>> +
>>> +struct    stclear_flags_t {
>>> +    __be16    tag;
>>> +    u8    deactivated;
>>> +    u8    disableForceClear;
>>> +    u8    physicalPresence;
>>> +    u8    physicalPresenceLock;
>>> +    u8    bGlobalLock;
>>> +} __packed;
>>
>>
>> Don't retain alignment.
>>
> 
> Okay.

I wanted to clarify what you are asking here. Do you mean to just not pack the structs? It seems some of these structs define the responses from the TPM chip and I would assume they are packed this way.

> 
>>> +
>>> +struct tpm1_version {
>>> +    u8 major;
>>> +    u8 minor;
>>> +    u8 rev_major;
>>> +    u8 rev_minor;
>>> +} __packed;
>>> +
>>> +struct tpm1_version2 {
>>> +    __be16 tag;
>>> +    struct tpm1_version version;
>>> +} __packed;
>>> +
>>> +struct    timeout_t {
>>> +    __be32    a;
>>> +    __be32    b;
>>> +    __be32    c;
>>> +    __be32    d;
>>> +} __packed;
>>> +
>>> +struct duration_t {
>>> +    __be32    tpm_short;
>>> +    __be32    tpm_medium;
>>> +    __be32    tpm_long;
>>> +} __packed;
>>> +
>>> +struct permanent_flags_t {
>>> +    __be16    tag;
>>> +    u8    disable;
>>> +    u8    ownership;
>>> +    u8    deactivated;
>>> +    u8    readPubek;
>>> +    u8    disableOwnerClear;
>>> +    u8    allowMaintenance;
>>> +    u8    physicalPresenceLifetimeLock;
>>> +    u8    physicalPresenceHWEnable;
>>> +    u8    physicalPresenceCMDEnable;
>>> +    u8    CEKPUsed;
>>> +    u8    TPMpost;
>>> +    u8    TPMpostLock;
>>> +    u8    FIPS;
>>> +    u8    operator;
>>> +    u8    enableRevokeEK;
>>> +    u8    nvLocked;
>>> +    u8    readSRKPub;
>>> +    u8    tpmEstablished;
>>> +    u8    maintenanceDone;
>>> +    u8    disableFullDALogicInfo;
>>> +} __packed;
>>> +
>>> +/* Gather all capabilities related information info one type */
>>> +typedef union {
>>> +    struct    permanent_flags_t perm_flags;
>>> +    struct    stclear_flags_t    stclear_flags;
>>> +    __u8    owned;
>>> +    __be32    num_pcrs;
>>> +    struct tpm1_version version1;
>>> +    struct tpm1_version2 version2;
>>> +    __be32    manufacturer_id;
>>> +    struct timeout_t  timeout;
>>> +    struct duration_t duration;
>>> +} cap_t;
>>
>> Don't retain alignment here.

Again to clarify, do you mean none of these structs should be packed (and thus the union won't be either)?

Thanks
Ross

>>
> 
> Okay.
> 
>>> +
>>> +struct tpm1_get_random_out {
>>> +    __be32 rng_data_len;
>>> +    u8 rng_data[TPM_MAX_RNG_DATA];
>>> +} __packed;
>>> +
>>> +#endif
>>> diff --git a/include/linux/tpm1.h b/include/linux/tpm1.h
>>> index 54c6c211eb9e..5fad94ac8d15 100644
>>> --- a/include/linux/tpm1.h
>>> +++ b/include/linux/tpm1.h
>>> @@ -47,7 +47,39 @@ enum tpm_command_ordinals {
>>>       TPM_ORD_UNSEAL            = 24,
>>>   };
>>> -/* Other constants */
>>> +enum tpm_capabilities {
>>> +    TPM_CAP_FLAG        = 4,
>>> +    TPM_CAP_PROP        = 5,
>>> +    TPM_CAP_VERSION_1_1    = 0x06,
>>> +    TPM_CAP_VERSION_1_2    = 0x1A,
>>> +};
>>> +
>>> +enum tpm_sub_capabilities {
>>> +    TPM_CAP_PROP_PCR        = 0x101,
>>> +    TPM_CAP_PROP_MANUFACTURER    = 0x103,
>>> +    TPM_CAP_FLAG_PERM        = 0x108,
>>> +    TPM_CAP_FLAG_VOL        = 0x109,
>>> +    TPM_CAP_PROP_OWNER        = 0x111,
>>> +    TPM_CAP_PROP_TIS_TIMEOUT    = 0x115,
>>> +    TPM_CAP_PROP_TIS_DURATION    = 0x120,
>>> +};
>>> +
>>> +/* Return Codes */
>>> +enum tpm_return_codes {
>>> +    TPM_BASE_MASK            = 0,
>>> +    TPM_NON_FATAL_MASK        = 0x00000800,
>>> +    TPM_SUCCESS            = TPM_BASE_MASK + 0,
>>> +    TPM_ERR_DEACTIVATED        = TPM_BASE_MASK + 6,
>>> +    TPM_ERR_DISABLED        = TPM_BASE_MASK + 7,
>>> +    TPM_ERR_FAIL            = TPM_BASE_MASK + 9,
>>> +    TPM_ERR_FAILEDSELFTEST        = TPM_BASE_MASK + 28,
>>> +    TPM_ERR_INVALID_POSTINIT    = TPM_BASE_MASK + 38,
>>> +    TPM_ERR_INVALID_FAMILY        = TPM_BASE_MASK + 55,
>>> +    TPM_WARN_RETRY            = TPM_BASE_MASK + TPM_NON_FATAL_MASK + 0,
>>> +    TPM_WARN_DOING_SELFTEST        = TPM_BASE_MASK + TPM_NON_FATAL_MASK + 2,
>>> +};
>>> +
>>> +/* Misc. constants */
>>
>> These constants should be relocated in a separate patch.
>>
> 
> Okay.
> 
>>>   #define SRKHANDLE                       0x40000000
>>>   #define TPM_NONCE_SIZE                  20
>>>   #define TPM_ST_CLEAR            1
>>> -- 
>>> 2.43.7
>>>
>>
>> BR, Jarkko
> 


