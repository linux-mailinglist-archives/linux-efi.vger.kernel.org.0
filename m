Return-Path: <linux-efi+bounces-6226-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JK8KNOUoGmvkwQAu9opvQ
	(envelope-from <linux-efi+bounces-6226-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 26 Feb 2026 19:45:39 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FF51ADEE7
	for <lists+linux-efi@lfdr.de>; Thu, 26 Feb 2026 19:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78CA63081F5C
	for <lists+linux-efi@lfdr.de>; Thu, 26 Feb 2026 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9067A37417C;
	Thu, 26 Feb 2026 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VRXs9fjE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WKfSiVrO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17683C1960;
	Thu, 26 Feb 2026 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130793; cv=fail; b=k54mMkydvbzdvkRZCpjG8QYXiFfBPWqPDu/ZsCQc1mwddJlOS2kGNHKbczP8anFbbd1ZPuVZ7o2YMunQ1PZVwobZJtUBDHhfamKBM5Zd1Qc1Di/YPrAYT2HJryX1YafpnVSVOMB0FgzEbgkFLMWCKmT8VhOpVRSrhD6WdLt2RWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130793; c=relaxed/simple;
	bh=Jp1I6ZkkKuiURgA1F6rvC+tySw0jukW7DVpezLi60j4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fMwGMG5XGGFRyaZJnxXEOCva0Hs4gSeCTvVE2uu5XJAW5Z96j4PjASpxEBjqc8mz19URGtVXmSxaTCj1T/xDjXyS6ipypMZ5KyHFE3f1KC7MHDSm42rrEwwrIhZZ1bas2lOi0yFX4KiL9UM6nJ4hPrGufQq6F0NWPsDL9PN6Zqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VRXs9fjE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WKfSiVrO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDNEEx763759;
	Thu, 26 Feb 2026 18:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3+X7JoPbftCmEN9Ej8RXkpVKTRh+dBBAGJg4ml2onxk=; b=
	VRXs9fjED7cyKphwpfnIsTHj/lAeJIq429YxvtgBP2MmA6TGDV7Q5hLU9bpzs6Aj
	E8xgwAtqyuZhjjtx+ZeFnikmziJceSbyN83uEZ7EGHGr42ZFbsbdsKP7n8E2RxKX
	iHrmhhglporBLsYDfKJ/DOdCzOK2E4DOCye/fxRLJle5nYHlhjGOZVS3LUqvqlQ1
	dpHm3zYIAjv/vhoUxnB7DEVZnG1w6XhHavkkn6YDY5iQZbsGHd2yrRoDvD/BCqsK
	l/W9a+E2mbqO8+T1BRaewt5vgC3dwHBNUyzK2nuHUR/WVY1cVdJjoeunfqSZ2DBU
	wRxOEz/IDkfTek1EbtfFXQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k60u0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 18:32:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61QIV9Ql027931;
	Thu, 26 Feb 2026 18:32:01 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35hv2m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 18:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbQ4EiwDPnLz7cICBzMsiDrGGRGUFIFNBVrxC3mMpoXj1P4YF8Wn0jIKZPNIIi9d7OwPmqlQRnkCnvLeIFzAeow7WK0lHv40HVxIoKoPUYutNp3BXaJODVP9mg3cP8D59sDpCTfckrQQIe0u1z5qn8kRK5kMoBGrUqvPKUHAoISCM/May7Qd1oBoIlsaIC1ndCIAjg2elHpsYyJOhWfs9TH1un5p4aXW58TVlZN+FbArvHVephs2vD4QlPQO6ev1lM9GXwKs8f7dk4gRtQ81Q56FexHwgpyT3AeQWmTfWjxnD/r8MTKcy4RCYvVXnM0OzOvzv1s65bgmFjTDKkG6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+X7JoPbftCmEN9Ej8RXkpVKTRh+dBBAGJg4ml2onxk=;
 b=Y7ANNQZbUOJEnLDnnqE/OSshl6WFiJPnhdwR23e8tG2lgjkVcZlLJK/1lDBS+KCLznfXZNHlyToaFdYZ+TfNkbfyHjndLCMGjnYoUjyS4ebHcPSQ+HJCUpR5HY8DNkVj4RcEq/6bNA/reB4OepeasvvOU+bz6TcgSkZQUP5pmlYxisB8LFWOSltA3L2ManadL/slv+7Q0gzC/pjMVEeBabDz3+2zJaadvpsw8hpUNwLIXRYMB9Nz7uKUg62Hk7/HRVuIZgOyj40gk8Aw4tLKjwpDbCmKj+5t4VvX4oIG7WHg4joRT9+rLSiZ6m4Z88pB+eXzNeN9MJeMnU7wXqWP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+X7JoPbftCmEN9Ej8RXkpVKTRh+dBBAGJg4ml2onxk=;
 b=WKfSiVrOFz/69Hv+vYM9cqSZIzcP5Qbsh+kjLb8kVLTN3sZbgVxzLXGpLw8GDZBRuuZVs+Cgi50urDC30XorRsnmnA1CiZxCgOOv2fovLw1+AsXaVjQHVmtPjwg8NEw69LvQsaVe4KGPee7l4cleH/Uh7X2biHGob7mMVjhFv7M=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SA2PR10MB4716.namprd10.prod.outlook.com (2603:10b6:806:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 18:31:55 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::30d0:8be0:725b:3e0e]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::30d0:8be0:725b:3e0e%5]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 18:31:55 +0000
Message-ID: <00774604-258c-4e88-80a4-fd8f60fcd0b3@oracle.com>
Date: Thu, 26 Feb 2026 10:31:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: Ard Biesheuvel <ardb@kernel.org>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev,
        dave.hansen@linux.intel.com, "H . Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com>
 <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
 <242a0462-7fc5-4902-b71d-22cf8360239e@app.fastmail.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <242a0462-7fc5-4902-b71d-22cf8360239e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::6) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SA2PR10MB4716:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b785e5a-1226-4f38-a857-08de7565517d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	OIdUAi8/2RSks5H3XkqCnE6mPFnjcLlIl2RVBwmOxpXD8URHrhQND8XMwEKIDqCIOjb6/mvhCZoXCyggMuqrlqr9J/mbgL86rARYQe+ssMMI7fv0tVspraw+vyvY+0Wa7rrcXiUeb1QYuFjrzqjd80OWAeeVgLD8OqPsdKKImg/1kLmYbGikLu8xn9tIjyzyUfyA181Qqlhf9L5r71ELWVMD25Eu6SlBmDwNS205K1NT5yqq3vRHudIshnARVkF5CxIkUOuXCuMYc0X52QQNYdOJt4V4TfXLpozFKH2/k3u0lhDvw8cOTJXPnHXW4BMs1zuI2lzDzxoZUGp0E/6y+ORtSzhWflIRUA5szT2XeeqIP896myOL46JcLuWu24ebeWBv24Yt1+KIRRONRo8NEqlkZfNw5QJsTIQZVHguVPj1Rtp/BBAb5XRHBaZbZVtrAEqLHThQS2GzZcTVem9ETmcakNu36RI9gJuLFBVoZCmAsoVYQN4kXQbpbb8FFpLogIO4hWMV7nc4NCJK2dgdNj16v8YQthCSfTZJFNoo2FIiUVsg6PI7JTRphgEsJqdxHVSZAgO4jqX9YwHVpUqlPuOVSvW/Z2iB8GgVIm9YmwZxQV1oY6QeeGRd1C5/LF/ipaCZx32v7X5JBl9rUTlplXH59j4gnf87ZuonjeHPpJHO/oLAumFeWmwzoXUm7Lztf87ec3oQ3IZvviz50K861d6IdOri8Kc/uUF/67O3fNfv5gz49wzXuLWXGz+r0Fo7PaNjdatVoko5i5ZCu1Xbfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0JjY2ZiUjZHclpmTmN4elBJOUlrRHFxTlIveWFiNUtERVpQbWN0S0dIK3Jn?=
 =?utf-8?B?RnVMMUk5dHNEWHZzTWFGcGVub1loYk1qTzdIczFid1E0cnRkV2xjQ1c3VGx1?=
 =?utf-8?B?YVlLb1pIcWtuRlBueW1aMWdVOHZNNEFrSkM2R09nd3gxbDZ5bTR1UGoxelJX?=
 =?utf-8?B?NmtkYlM2UHI1RUo0VUtDbUR2aWRzY29kZkN4U2xqVm9HQnJOU2ZYRUUycW1X?=
 =?utf-8?B?T3ZSQjRwL0REQ3N4K2YvRHhVc1hWd0tESkpHbUUwYzZ5eWV2UTlwSGdXZnFF?=
 =?utf-8?B?UkkzTUwxcmhxMXEvWHZaU0o5QXVZYkgzTDI4dEpkb20vcHRManBXZHlmeDhm?=
 =?utf-8?B?eHA2WTY2dWRoTlFXVkNGV0k3OE1ldVZwYXJra3dWUkg1MDNxVXlYUVpTMjYv?=
 =?utf-8?B?MWlZY0tUZHR2UzFtQkI0MmVaRnRpZDRyTkt6Y211YWJmMkpORURFOFVlbjN4?=
 =?utf-8?B?ZEtDd2JBZkd6RE92a2E3eFAwaEwzN3I4VFpWTDNheTI3Qy9sZ0ZIekhLU2Qy?=
 =?utf-8?B?eWowbHRyVVMvN045Ry9WdXJYeEV5Z0FjWC9GTFFJT016UVZKRnRqQUl4ZkJW?=
 =?utf-8?B?cWloVkgxR3BYUUt1MXJNZ2dxSnNZcU1SSG9EdktXRTR0bXF5Wmlwa0h6dHZD?=
 =?utf-8?B?Wjlkb1VJL3crQzBTVFlzRkYyakhPczI1KzQwckovQ01GdG5kTnhLVGsrUE1w?=
 =?utf-8?B?VkgrUXN4WndDTElRTGRncUZnRkpwQ29ZZUI3WU1IczFQVVBiRkhETjduL3NF?=
 =?utf-8?B?QndFMUVzYVlqVWpmcERETXdYZlBxMmdjbzlveVJRdnZaWlFtVUwyemNISFlQ?=
 =?utf-8?B?R0toSlNnVzRNRE1uYitUYjdHQVFsWnNET09TK2F3U1RTR1dsZTR4ZnFRYkhj?=
 =?utf-8?B?cUhZWUhkeWZKSDRBSStVUEpFNkVtVklSL0JGUUZvd2pBZDdIT2NwNmowczFr?=
 =?utf-8?B?aVY1RnlPbytwUUVYMHRWc21rUTZuZ1hLWGlFWFhySnpQZklSU2lwYW9RNHcw?=
 =?utf-8?B?c1BUY1VHTnFQWVl2SDJVL2RkbGp0eXlDSitBSnJLMDVFbnoxOU8rUytZc3BY?=
 =?utf-8?B?QTFNUUJBSWVmMWpKVGwwSWlxRUg3eC96K0dtZkVKVzdaL1QyWWJaVjR4SU04?=
 =?utf-8?B?RUo1RHBHays1eHVhNStWVmpZYno1NHRhcTR6bE9lRXdZdmgxSWJuMXNPM3Vu?=
 =?utf-8?B?QVZDMDhjdVFFTHRSRFdtSEozaDVNa1NKSGU0UU93Q0FsWnY2M2NTUDkzVmNF?=
 =?utf-8?B?amp0cUN0V1FVK1FjMjJaQTJtNEZsdXpiajlkdFlZM1BuZThJZlhwdndPa25i?=
 =?utf-8?B?a1g1YndCRzQyc2M1NUNFcjFpL3ZiMEhPaEJudEM3VWc0Uno4endMczdTNWpo?=
 =?utf-8?B?TUJIWlQ1SGRHUkhhSUJ0MWNPR0JVb3dvMmNUYXNEa0wzRUUvVWFmcGtNUkIx?=
 =?utf-8?B?SnF6TUR4UFlUQjZEUUFMRlROVTN0Yld5emh1R1ZOT3JyeXV0LzZYK0pLYXN5?=
 =?utf-8?B?QitabTdGNlBNSEh0b3BMRGFvVVduMTlaTlpMMUx1SVliRE1wUDBHa3R1ZFg3?=
 =?utf-8?B?dE4rK2tOZ1RrZU5qK2REaWNKMUI0YkRNUFRzSFIrOVViR2J2enBPNTQ2NDdx?=
 =?utf-8?B?UHp3SHlCQXhYQmdWUy9mcjRLZWpyaExBOXk4WENydFozb2JOMlBOSVZyaFRQ?=
 =?utf-8?B?bXA1bzVOa1pWSm83WlRnOGhxT21Tbi80MjFWdm45SDZKYjdIMXdIMCtqMXZH?=
 =?utf-8?B?Rlp1SHdKWlNjRlpGTEN2NnpyUGQ0d0xONmZIbkJyM0VxVmlwZGdJNnZXYkNs?=
 =?utf-8?B?NC9jZ3NTYlpSZDRQSkNYZTQ3TjVvcHByYU9xRnNsc0ZGU2o4Z2lHN3N5dFJ0?=
 =?utf-8?B?Qld6bnI5d1ZEVzB5MkNwc0h2RWFsVlE3YStxSVZRaHZlL1FESjZUWWVPRFcv?=
 =?utf-8?B?WUFUd0ZuL0Zpb0VFdzBwOXBQeFhFY01UOXkrL3JDcXRTNkptWmRtL0NqWWNv?=
 =?utf-8?B?enJMbzNaMFNvTG9WTU9IVngybjVGTWhPL1pDdEdhWXZqRUxFUnlBMzNtZVRL?=
 =?utf-8?B?K0dyT0hXNksxRTF1VForcnhGN2ovKys1N1F5ZHdoMGg2OW5OQXB6OUo1QUd2?=
 =?utf-8?B?amhGekp0N3BlOTdnZVo5WDJWRkRscmY0c2NjVkxYZG1EeGhSZDJKb2k3bW10?=
 =?utf-8?B?cGEyMnJudGRmRHpmYkE3K1cwNzR0cko3WTdTWnRRZ2JxMTVpT09qZEwyTTFq?=
 =?utf-8?B?VXRqTFRXamRTa282eDd5a0VoQXpiQ25hQ0tUNDlzeVUxbW5GYnpGQWQvdUY1?=
 =?utf-8?B?UUhQQSs4RnU5MHJqQ3RXYkdKNHRET3REV1JCM1ZQdHVKQjBzUDJXd2xjcDJX?=
 =?utf-8?Q?oCdHUEbBks9XGf7w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BuR2xl2mTuN5EHA2cCKX9XYweOQCIgJOTwFgWebkDsSNJ0xn+2uXrJWmi5CMw3Hqpm5u0o3FyiZaFzUKGinTIIiffZ58hITV+S70bJleNpx2D/1b0+R+DESi7tUN0F0d9O31UYKNy1/tZI6vP85EwfIKy7x3xmSZn5u9PLMrxnwQVPtTm02yuFr354wK2XR+A4khEmmECez1llNPq4OdJ7CwwVQWhRet9nCJekPlKzaBFPObb/gyKDsOCFiZ+WBB2lUIfPYPdZxkVZj44mH8q8csmH4l92rYQmCNTuLqHS8C4+4lNQXD6H9OBEaQTyAXnmP5T4oavsPywgpzxhY0Ov2vgNPm0/smrq/vZOtSK0uq2iO7sGCzaZhnVORAFL6faIcpIgPI0gGW+28Hsmcyn74z0b0MZH2fqN7/9icwQdSw2gk0LUou9pFynOUEMJb0B/7ljrKJJ/n5+T8tVnfGgoo9X8MPrrnAU4NLKc2tbxT10v7j4CkSCYhyTvWXuVJm9bOlHh2kP1Ej9A+h96Yv25DmsgGTRuMek7EIJJcDBzxIgfh20w9P3pqNmhD0Besk7+wCC0DrNVowTTGTJTzmRonW71IEixbCSRFIgc277GE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b785e5a-1226-4f38-a857-08de7565517d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 18:31:55.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNZXcT47YR61WpSdpQMuSNxz1GLJPORTfyW5Eqq77rC1tyQE3yyrf5nw1oYKVMrWK+umZ6CpbHW5AS/ICvIVqK3tTuzah+t/q1ipB1MwLR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE2OCBTYWx0ZWRfX4X6NXEiYXO+b
 PNbjD+E63U3n6zx4mVmh1QSla2EmIXdtG1Ru9osZpAn2wya9YjVTCsl/hR11LvjUasjmhl+/LrQ
 iE9G9kRDPWTtua3eBvMfUn+ITumvFngs8URG0l8pRnyCxclKV02suxcccGl+XS37zgaHu+MvYNj
 HDFquoWQ8zzCl3aRWDEuQ4lELCZMR96F5wywnH/zWc3gZeglNMM3yQUahjT5K1WZZ0FyLTX8Dj/
 xpUHR6mcONy/7G98mtHpzmsEze6FAp2lpoRCk/s8txVkq60jq/NB68tDJR549NvIVMCf7zyc/EZ
 +IH9dFI4HEUQMOdfhUzDhButTFz064Iog6nnz+Cd5yz4hDYAJIqQdYOE1TPpEtm9i17KszQJR1H
 R9MD6D5iEDzP0cliDx0hdv5h3bjpzjBJALnQKnq18PS3G+UtrCE4XWRnjSDaqUmN1GFuNVnVGqx
 umLc95bkycj4cNTn9rCiHU+S99zF/uQC2uFbe5z0=
X-Proofpoint-GUID: qD97Fwop97M_Cq37s1VFJc7a4t06izTU
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=69a091a2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=FAVAGTpLYozwHQZKLccA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12262
X-Proofpoint-ORIG-GUID: qD97Fwop97M_Cq37s1VFJc7a4t06izTU
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6226-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,redhat.com,alien8.de,srcf.ucam.org,hansenpartnership.com,gmx.de,kernel.org,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,linux.intel.com,oracle.com,citrix.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ross.philipson@oracle.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 56FF51ADEE7
X-Rspamd-Action: no action

On 2/18/26 9:30 AM, 'Ard Biesheuvel' via trenchboot-devel wrote:
> On Thu, 12 Feb 2026, at 21:39, Ard Biesheuvel wrote:
>> On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
>>> On 2/9/26 09:04, Ard Biesheuvel wrote:
>> ...
>>>> I've had a stab at implementing all of this in a manner that is more idiomatic for EFI boot:
>>>>
>>>> - GRUB does minimal TXT related preparation upfront, and exposes the remaining functionality via a protocol that is attached to the loaded image by GRUB
>>>> - The SL stub is moved to the core kernel, with some startup code added to pivot to long mode
>>>> - the EFI stub executes and decompresses the kernel as usual
>>>> - if the protocol is present, the EFI stub calls it to pass the bootparams pointer, the base and size of the MLE and the header offset back to the GRUB code
>>>> - after calling ExitBootServices(), it calls another protocol method to trigger the secure launch.
>>>>
>> ...
>>>
>>> I think this is a great approach for UEFI, though we need to reconcile
>>> this with non-UEFI situations such as booting under coreboot.
>>
>> There are two approaches that I think are feasible for coreboot in this model:
>>
>> - just unpack the ELF and boot that - there is already prior art for
>> that with Xen. We can stick the MLE header offset in an ELF note where
>> any loader can find it.
>>
>> - stick with the current approach as much as possible, i.e., disable
>> physical KASLR so that the decompressed kernel will end up right where
>> the decompressor was loaded, which allows much of the secure launch
>> preparation to be done as before. Only the final bits (including the
>> call into the ACM itself) need to be deferred, and we can propose a
>> generic mechanism for that via boot_params.
>>
>> I'm working on a prototype of the latter, but GRUB is an odd beast and
>> my x86 fu is weak.
>>
> 
> I've managed to get a working implementation of the legacy entrypoint, by repurposing the dl_handler() entrypoint you added for EFI [which no longer needs it in my version] as a callback for the legacy boot flow. This /should/ work for i386-coreboot too, but I have no way of testing it (I only tried 'slaunch --legacy-linux' using the x86_64-efi build).
> 
> I've pushed the changes to the branches I mentioned previously in this thread.

Hello Ard,

I am working on incorporating the changes we have been discussing. So far everything has been rather smooth. I noticed in the legacy support you did here, you introduce a new boot_param. This is something that we tried to do early on but changes to the boot_params layout is rather frowned upon. We worked with Peter A. on the kernel_info scheme but this parameter you introduced is not used that way (kernel_info is meant to be RO after the kernel is built). I guess my first questions are whether this will be an acceptable approach (per the x86 maintainers) to add a boot_param and, if so, whether the spot you chose is reasonable. E.g. will it survive the sanitize boot params step.

Thanks
Ross

> 
> 
> 
>   
> 


