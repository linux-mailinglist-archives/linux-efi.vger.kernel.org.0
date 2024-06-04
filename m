Return-Path: <linux-efi+bounces-1154-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12858FBDEE
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 23:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF2F286536
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 21:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD6142E8E;
	Tue,  4 Jun 2024 21:16:56 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCD75B683;
	Tue,  4 Jun 2024 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535816; cv=fail; b=EdfZ4MYkcLfIPtkoQELYU+w+3k4a6uhgy4Zrwgx01dMPHnOBPbaZgBoPr7xyqArwgqqPcwm4Xpy7Ly5Kdn+RQBjsBuNmRVuyniHvpxePWWojpVg8zoH9fPSSNGvl1G3ENvh/Qkrk38P3diiZTguOzZ1dJo6GxbjAiAs8TwO2eMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535816; c=relaxed/simple;
	bh=ghlkrMbMA0cgXT1rbfBmrxf79tsihGvckO2ogPxqIok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kHASK2VCLNP3c/4OYnSeKN/X6TIQgw5jh9zaAywyVj3+ceaJazMo6AkdY3onNSgJ+aFf/5WQEo1xgFCrzkVFdWHCj5ynDqwZbO1rk7vizveStidrc6J9XJqePdOaVwfssPYPvlGq8CrQH/GQKSO1/dBU3Uk68MKPEX2Khb5TSI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454JCUtu005876;
	Tue, 4 Jun 2024 21:16:15 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DTgwFoMUaiKgjxWK/KnP57uVsHRGtYgNGOybgJCBwohw=3D;_b?=
 =?UTF-8?Q?=3DWS2Zrtn4ijcDrR4YqRCeBiT5304nbvgw8FE80HiwHeTLhsGHTdTxiqn6M6UE?=
 =?UTF-8?Q?b25Ac71i_/2poC77z0w/8pUYE+plbJ8pHdk10bHiI4JXVkbkoRQsv3GMo4r6ZbQ?=
 =?UTF-8?Q?DhmF/AjmTv2aNK_VhfTWLpUq1jV3+v+F75RbfGIsfgkT3cu1zqJQ3IBTJE8pAGP?=
 =?UTF-8?Q?6Zpw1remiEjt+FcTx0xW_dKLHJViYOpmj/ZWlBEki59gOoLy4JXaiXIbRlZQubu?=
 =?UTF-8?Q?WZnrJo8GEGKEijNLa6QzYA2x6X_/utwoQch1GgwOpGZA4J/XQNCiLAlSMhbHbuC?=
 =?UTF-8?Q?rt8RWmgASg9pnVH5oVtdGTyQe66cQ2by_ZQ=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuvvwwfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 21:16:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454JPWn0025263;
	Tue, 4 Jun 2024 21:16:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt962xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 21:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF189bYUy3TzV47r2ire8WM6dspgvbF9KNJ1Gcw6mEVo6xRXcZ+Ls1KAbrFa/SfsZW+2DWaBraCMkN0ta4MdQqlF57a3tVfg7XY3TfJICmhiAC5JV4smGnksFDncp4pC9R5eselyAMWqM2FpuOY9jr18bh40Zro/dP0dX7OlG14lDQ1l1Dt5+dF2oEl84SvkuFSNEvlGjCeZUYXULOw+UvGsVCycYD36DQKn32KEo5g4hqSq+QUljk1UBPVDazRme+9fBISv4nUP5dYeBE8j2lD/Li1kO9MTyC50dix3ID6DkPQeF1aYLP0ubCln7jdqU89/Of3NqwhlD73wK5aBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgwFoMUaiKgjxWK/KnP57uVsHRGtYgNGOybgJCBwohw=;
 b=fx1p9tMKrXEZ+tR4oA2SjOfYDANH6rrE+sDPJYbg5+UPCsYBCRWe4caytTOLxVnPnmIBXk8Ukle2IoVTp/7WH72Pn9BxHlKRMj5qt084Zlan0flROX08QI88cG89GcERrntP/Jnv8JwWJOgQAtjpSyISfTGF6b1IsJq/n90CM8hnV9RtfTzftnfedn09IYJLv9Cz6/dyUKIXofZo2E+kye3gCt2YGF7ZLA3jWH5ZmVsK0onDxnrTMKPr+ZkIYa9qeRjRMf4mfD7PBoZKsEmhC4SLXiTVPXPPjTG5xCE6kUOrnwm2CQ1QmmK0DnfD1XMmnH65RaMGl2YzJ4KrULDKVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgwFoMUaiKgjxWK/KnP57uVsHRGtYgNGOybgJCBwohw=;
 b=ijlwyhpU9G/hpht73YhQ5ZiZXMNFtOaxf8CcJndCvC8StFDfGCaE71aLyp45LJWjD0qDB5vOnYsjVY0i3MrQN1XRyYSgt37q+ucLs+iOg0i6/a++LNwp3SVQqATTJV/SlN2GnmOhWNgJpNckmEG9xuwnOy57djjgt5GBSHffk20=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 21:16:12 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 21:16:12 +0000
Message-ID: <e066d250-b657-472f-ad27-585a64a51a9f@oracle.com>
Date: Tue, 4 Jun 2024 14:16:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/19] x86: Secure Launch kernel late boot stub
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
 <20240531010331.134441-10-ross.philipson@oracle.com>
 <D1RHYMFSVGSW.39IL7KFK8A47N@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1RHYMFSVGSW.39IL7KFK8A47N@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|BN0PR10MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: d27c4f2c-baa1-4536-6d92-08dc84db8f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZjJyRkNrVGlJcmx2YkkrRlcwUk12aEw2MGo0R2xreWw5ZituMEtiNUdwNXdD?=
 =?utf-8?B?c3Vhc1l0SGEzeVZtVlA2Q3hSM0xFbFhPRHRVR2JFaVRwcURHWlJzWERVcWJK?=
 =?utf-8?B?Y2Jib0NSMWlrT1NKc1BNMDd5VVRnRHI4L08vUFc1L2VUL3BOalprM0JaNTZU?=
 =?utf-8?B?MmFjc0hVZk1Kd1FFbG5VQXNqT3l0UGZJTTNqdTJ6VTdLMC8rdmxHOHhKTGJs?=
 =?utf-8?B?V1VvVFIwZHFtcktGWjFPdU9SWFpEN2lKNjRSWXpOWnhINFNiOHphVzF2TzRh?=
 =?utf-8?B?eDJjeGdrYVdzMCtiVzhNTHRUcDNqa3Z1aWtvQkJtYytEZy9INlVBUCtxSGNy?=
 =?utf-8?B?VU5yUk5IK05NUkw0KzR2bWZ6b0hBTlpoc3FmbFZsRHlhY2ZoeUxOOUtHcTdw?=
 =?utf-8?B?TTNtV0FmT29xOGh5YkVEa295Z2hNQWt1K1MxZGpUWlRKSEtOa0ZqbC9FSkVT?=
 =?utf-8?B?VTl6QllCOFl2THNUemtRYmVYTHNKUXJhb1FtcE1hZTU5Y2dpd25FMVVDV2tz?=
 =?utf-8?B?WmpOdC8xRjF5SGpwdmJzNFQzV2NqUEJUWVYxR0xmRmVsYU4ra2tRbjlxRVZ6?=
 =?utf-8?B?ZlFUN3RCTmlvZVBzeE8yWVFzdnJhVUlnd3NyMkREa3phV2NJWFJhR2NQNDBM?=
 =?utf-8?B?TjFxS2dVWkgxa3N1UTRUUTNYM0k2MHlOVVlsVURpamhoWWd3MGxGNkpiMzVq?=
 =?utf-8?B?cWV3V2phdDBraUpXcXZwQzRMczVSVGpnZm1DRmZtT2hMNFVVKzFZd3gzaWxo?=
 =?utf-8?B?bVFMYjdkVGNpQUxpNkRZbEo1VVRMRCtuRDNYd3V4YXp3emhXWHIvUDhoRDBG?=
 =?utf-8?B?Q2VmeTBGbUNWTnMrNUt1MG0vYnJxcDQyK2xOMHBDRER6cVBoMjFxTXdBd1ph?=
 =?utf-8?B?cFd0bEIzOUcrVmxzKy9QSFEzMUtoeDJUYmppU2I5MUthUlRIRGc3SldSbU9h?=
 =?utf-8?B?TWVTV2RMQXUzUklDMFRsNUVqdXc0aDdNbmVwRmVDTTZXQTRsZHBpZEc5U3NW?=
 =?utf-8?B?QmhRUWdzQ00vM1JCNkJ6ck1CQ1phN1kvQ0xRcCtRNTlVeFRpWDZ5Vm9DZ2wr?=
 =?utf-8?B?bU9VUmpBVyszelNzQmZnWTIwak1KYWZ1SHBHc00wZG4wbE5naG1iR0JWb3ZP?=
 =?utf-8?B?SklIbFh6WTVBa0I3SEtINGtqc1ZqN1pZZEVXRkJQM1NMNnVwQ2ZsYSt4Tit2?=
 =?utf-8?B?S2lSeXhJK3NYRTFZSVgzUGV4ZFQ3T3NTeGltRWJUSnZVZyt2Y0tPZy81TklX?=
 =?utf-8?B?Tm9YT1UyT0FSWnlSZXZSMFJkaVp0aGFVQnNGUVVERnhLNnlnR3VqTEN0bEQ3?=
 =?utf-8?B?eVdic2dwVzEzNVBxQVV2SnRZNDhQKy9PQ1lWYmp3UWd1NU0xWWU5V2ttdkMz?=
 =?utf-8?B?dUF6UXY3TnBkbGNYM0ZrelgyTk53bFpMZnRSTDdCazgrVGw2b2NIenR3UjNa?=
 =?utf-8?B?a2VXU0QzNWhSWTJNaXNHWS9Qc3hGY2hOb3Mzb0d1dEo1L2tLL1pJNWhJNWZv?=
 =?utf-8?B?QUk5MWZMVzhsSHZ1Z2VPY2FLOStFN08vT3JhUGt5aXBCT3BBdzNuZlJoOWxw?=
 =?utf-8?B?bXZTSjF6MGRIM1U4VC85alRPa2xBT0w1eThEdTNEVDRwSGZOTlJhN1VWODEr?=
 =?utf-8?B?MEJMczVCK0xqSWtEZW50QUtuQzAxS2xYTngreWd5OXE5aUZnNHZMTUNmQlY5?=
 =?utf-8?B?V05CNVpsUUpFMDdXUk1VRGlvbE1KRlR5NDJhaFVpdlNXQzJLVUZiSVN3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MWRwTHhXdy9CaHh1M2hpK2JCSmdsRlo4dmVPYVQyY0orUDkvUFlTRVQzd1BK?=
 =?utf-8?B?cFQ3VGozaU04c1VwQU9nNG52bkJyUmg3eVB4OEdXZTZxVHd4N0NIQU94OW03?=
 =?utf-8?B?VzFtN0dzc01XUXBNL054NS91cGk4czVoSC82VXhGZ1NGaFNDZWxBeDY2WjA5?=
 =?utf-8?B?clUrOG5mZ0RRa3VSOVBPODVSNmZxQmRTMDNrK0JqcDJHdGNmQWdYU1NSeGJT?=
 =?utf-8?B?NFNRaGJjbVlDcDFiNkt3czNYazhNMHl0N1ZPSEc1WExkajdZWHVROHJTOU13?=
 =?utf-8?B?amQxTXZsbkRYdU4zdWJGb3VoemJIeGdiWjVXZWwyUzlUekFZSFVhWFAvQXBz?=
 =?utf-8?B?cEFnbko4V2VWT29PSWR1bE9KYXU1dDVQMnJZY3hwU1l2V1RBWFNQSE5JZUxl?=
 =?utf-8?B?aDA0aDVJbTRJUklmYmxwdHhNalV0U25OdXI1NVQwRVM5LzgyM21kYldIRnpH?=
 =?utf-8?B?OUk5SVBGQ0haWjhhYWdMVS9yNTU1YjlJSVVVOW04M0VIS2lJQWg1NGtGMjFB?=
 =?utf-8?B?V2Y5YUtNcFNCMEY0L2dEbGdIdDFkT0ZhZ1M4OExGSnZCdDNsMENYWk5kZG9j?=
 =?utf-8?B?Q3d3VGZQeklWODB0T3V1Y3lDV21KbnJMbmN5bkFhaUNMalM4MlZzb1NTeDAw?=
 =?utf-8?B?bUJkUmt0UXYveC9oT3dWQ1lEWk54ajhYV1E0OUQ4bk1veUs1amVNODhwTWxJ?=
 =?utf-8?B?NDgvWEhOODBtTWxkUmpMZllTOVB5bDJ0S1hab09CMFRaV3lwR1VhUTlJNFVV?=
 =?utf-8?B?ekNaNWw3Wk5Qa3czUFkyTFJ1WkFIUG1CZDNlYThyUDk5c2pyMkIzTlJ4b2Nt?=
 =?utf-8?B?aWdDUy9kT21rM0YzSDR5OUZ0ODUzemdDMTNWbXordDhaKy9GL0hyNkdpbUNq?=
 =?utf-8?B?L05OSkhkQzZGQUw5K2t4bExDTFpzS1Z5aEs1aEljZHdsTWIzRytMODdHb0Jr?=
 =?utf-8?B?SmQzTEZOczF5dWxTcnNCV2kwcytUNkg5aklCQkN4QkNBQTVpZ1ZQSklueHZU?=
 =?utf-8?B?S21NdHVVZElOcXpUVnZQWEFMY01QbGMyMXRpTnRxUHlUNURzMmxlMUhJYzE1?=
 =?utf-8?B?ekRMV0JpNEtGWFpYdTk4VHozV29UWStUM0RFWkxwbHFPSUFHdXpJTzZ0bmNs?=
 =?utf-8?B?QWJ3Z1BwUGp5WTljQVdoVjc2U0t2cDVUU1d4aFExckhIajc2NHE1R2NBOUxz?=
 =?utf-8?B?WklVSmNUbkUvakVzb2cxUzBYRUVOTWRPRExuMmQ3QTJsRHg2Qm04aTB5dEdV?=
 =?utf-8?B?aW9xYUhzazFHTVRlNkRRMktML29LcDNDS2hCZDk5SXJJUzFBbVNIdm4xbHJO?=
 =?utf-8?B?MEJlMnZtK0xPUld1VDRuMG9wSmJzbWs4UWZualNiTENCY1F1eWhoMUFEVzFr?=
 =?utf-8?B?VU9HcXoxL3JFQndyOXRnWVFpazk3cUxWNzBBdzJWVm1NanllQWZzT1g3SlJx?=
 =?utf-8?B?NHdJblpyWldDTDZ2MVNFNitJd1U1NmoyN1I1aUgwTFVCblpDbmJkVk8rRUt1?=
 =?utf-8?B?WG4wSWo3SS9FU1ZHeGRkeFV1NmNNVkdYT0VsT0FjQ3kzUzVJMnNsT2tnY2Yv?=
 =?utf-8?B?dkFLRCtLMC9NTWJ2QmYrWVM1dk1iU3ppTWkxWXUzMnp6dS85ajlLL1RiZklx?=
 =?utf-8?B?WWkyeitlbDhscllxdjNFdnlNT0tTa1R1bnpXN3Vxd3F2bHc5ZUM0ZHM3QnRi?=
 =?utf-8?B?VzlJSnV5ZUxvQlNMZlc4a0JTQTVLUnptTDFaekVIMHZmMG9rOUNzeWlKQSt2?=
 =?utf-8?B?MFJwQlpZSWpKQ21RWWprbld3R0xpOVVPdmhzTUFiYlpjaURsa0RSM1V4WmlN?=
 =?utf-8?B?aDF5UFBtY0FieW1ibzArcklvRmwzWDM0ZzVVb1c3MWo3LzF2eDJTNkJsa0s4?=
 =?utf-8?B?R2gxVHZjUTZWSm9FcUdtaFdvcXM4OFVHQjg1cnQ0UEovTnNGQVV2LzRyVjk4?=
 =?utf-8?B?SFhGOXJqSEdhdVgzck04QzdqbG5odkhzRVlRai9CVi9FNFlYL2tOS2NsQVJE?=
 =?utf-8?B?c2NXR0dQanF6ZFIyVFlDek9VUDVJN0hPMitiTktZaWFKQjgxckZaeVkvUWdt?=
 =?utf-8?B?RzlrYjdHTHliOEJFTkozNkExN1dRUjQxZ2RXNm5ZaGtOWCs1aHRpaTVpNjl3?=
 =?utf-8?B?QzJTbzA5S0V5MG16Kzh3ZHg4QWMzTENyamVKSlc4YnNvVUVNVzE1QVdJSDFn?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CSynnrypXcWd9cOfD7OIYr1L7GLKIWP9kIbnJ+UaCCi1CMGiu1WiOl4IiOiNiHIAioqRQUSg/PghPdz23eui8kayThMpo2zUn5vezSW0blAbwiycyPB/I0jd1HWjk6k5nscOVXJcjxYhN28SLO84p9VjNy2F3x52I5a1NZNssp4eRi+cgNbTeZ6OQ88ooxDNlhYX3KcUrGTDTvxT3pzyQBTgiwWgdBCT+ut4fYHQouHo6q6Gw8UcJYIMrIomvtLmTmt0g6P9skNfQn/2+MltHbKFI3Tvf+f4qAo3KccdiTRhyHjpEgANmqgZo8KUCJvbCJFNCPbWxBTdJ/vqaagA6+lp5GOCP4KUR/s1pp5LLrP6EBcjYrMRKsgeTvsbthLNh9LEWsSpAgkBKBNbSHUtGSXGqywUGxHH5C79YpN/0I6YMdbqyzdJyRsXfsyuv0RSaOTgvTafT5LuHvlofz3/HWi+yVe8B35kAljrW5B209rTlxXUJx3CStqosy3avUU7aJEs037c0vXI/8pVlYXK7DzX/7Rqd9UgHQAa/ntlafgt3y/eOLWISJHbBIvJnB6Ssgh2Mpn45U1ruBvihpGWI2z+VSVQiOjIVlG+qTdTsIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27c4f2c-baa1-4536-6d92-08dc84db8f81
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 21:16:12.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPn+oLwGTN8S9g578lSzBnKvfvzzlSZgx+m+nwWH23lgIc76PpE86t13oqJmIJtA9l6x5YAMGnT89fsWXq6Py4W9Zkj+mtq9f7byTSTsMSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040171
X-Proofpoint-GUID: gf0CHlnt_FT1pRAXg1lvODrSxE44Q3cY
X-Proofpoint-ORIG-GUID: gf0CHlnt_FT1pRAXg1lvODrSxE44Q3cY

On 6/4/24 12:58 PM, Jarkko Sakkinen wrote:
> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>> The routine slaunch_setup is called out of the x86 specific setup_arch()
>> routine during early kernel boot. After determining what platform is
>> present, various operations specific to that platform occur. This
>> includes finalizing setting for the platform late launch and verifying
>> that memory protections are in place.
> 
> "memory protections" is not too helpful tbh.
> 
> Better to describe very briefly the VT-d usage.

We can enhance the commit message and talk about VT-d usage and what 
PMRs are and do.

Thanks

> 
> BR, Jarkko


