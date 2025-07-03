Return-Path: <linux-efi+bounces-4103-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F8DAF75C1
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 15:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3C13BAB4C
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 13:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8370218DB1A;
	Thu,  3 Jul 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kHnPzJ22";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PFKJB9Bv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1F176ADE
	for <linux-efi@vger.kernel.org>; Thu,  3 Jul 2025 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549631; cv=fail; b=kFPgTCCyMOcxMpd+P4FUVXGIX3vKuJlOechJAxYRCD5Y+OVh9lvUIP1aKL7uzRY/GY8IkV64ceFhmjkd9v2bWiDe+JKVjxTv/E4oXfxS/T5h/PrJWaY8z7vVWDHkWINyz2BU4wa+KJPsoD9Z4NZONELFr3H23Ol5Gr8QEMAHQBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549631; c=relaxed/simple;
	bh=pR6wSECPy13msymhIxdIT1c1HrUry9leGuutPpZA11Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hZoZGMjvEP8l1LScGO7yokCZ2H0zNL2vyavj8NMkA/1VLtYSnURnkr4o1yIdj8qU6hmPT9KrtAo6zToRRaEFHu0KDeyYx9KOjCS43mk/i1J58xsC9cizlWueNREHieZG8hT+CyinDKG6P+yIfkZAdN8hAkYIAbyeeSlB0CgazS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kHnPzJ22; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PFKJB9Bv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5639YuDj006785;
	Thu, 3 Jul 2025 13:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pD2gj7jPNDhL0yNLIIOIENRyvJ1BclUtas2N3rLWvTY=; b=
	kHnPzJ22odBjoaKpQ9SvsjpC5jg/wmXUtXSkEvUdTyTaVES/72HcYi4f7c7YvQtW
	2+gvWsjNJqnSX9tsA5N0RWOqWiigTNfCgZs1uxALo57LWAECuCkyxnWWJFy9J0Pl
	eCO3sV4cmm89ED+zo8sWwbYCgtdVsdLfVvyMOB7IEcIWKk234/B2m/EfS9bo+3aU
	n9vvCe5TU263EclGFgBu+LS7FiM72TPm93GLp56BRnvj2tZz41CKjd4wcxxatOPf
	GqTZTx/t8eWou7hwG3PcyrrXnx8oqttqrJVH/y4Z2EE13mXd3Qw3qzr34/ewHkJo
	uGQC/0+b7rkJuMrIjH7K5Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef93gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 13:33:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 563CER44030179;
	Thu, 3 Jul 2025 13:33:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ucps8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 13:33:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7zsezESwu+7+JXXrD7tO5XX/uKjiHJ49Z5CGzNPTTuC1NVo/hE57Tb5vvwwle9XaZIxTLNw1mq7UY35x23EqVq49vdoF7EPFaokAA1mUQiDF95ysM+f0Bsr2uGM7ArujoxZITLBUxApNPADtvgxvpYhdDlV37bZgkf0zn2bOdXTcI4p6SSXsS38R/P/Sk9AOuqtKJlNpEQQ+evLTddfFfpUSBTtMISvqlsVI/jWmcBM37V8uwRi0qqRViFNoCB7Hm65wHp64rO/WTmvDGppmJCQD7lDRSxCwlIQrvQlXxxIk6oy7gsE8Dq2ypKD8TowXRJPl0sLxf8YY/5laovP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pD2gj7jPNDhL0yNLIIOIENRyvJ1BclUtas2N3rLWvTY=;
 b=x3wfyFZ7v2U+TWGM0O28C6MJkVVFD9iZoc6Er4AKj1Bs2QvN5AsglJ+UhFia1Iz6AWuwwu1y+09m1JLmwa/7GQHLbMVObgzRmZ7pINsAYoWLZSNyBYS8fmasRKgxJy8bS2LzC9HncLqjRvY1u5ngXvguXxtMcS/3jvhu6PjTNmFr/tZm5sZ8Y+9CQGqHhO5X9S1FURSU4pNniWzPvCxdZiiXtxcydY4ErOB7SbM9d1Sl+EhEmwc/C1zemkK7xE0LNMTZ4cZIa83j9FJQmmTiTE3Xc6b4A3tBmdCaYny5GTuWQKuBU4mERjuhYeA6KPoPGD4eKacs1GqoAGxegj616A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD2gj7jPNDhL0yNLIIOIENRyvJ1BclUtas2N3rLWvTY=;
 b=PFKJB9BvAnIHN27VpWIU3bcj+54jqAgjPYETBx2h2FMomS53YJhJNYjGSNcUo7MG7QR96YM1oD/txrBVD+y7nPyhAIg5//ZOID9GH/a4lqiPfjR9BxaL1kkFT5Z6gT6vDFlmgUUAhOx9h4KpZVj4LgCHXVBJvXz/mYoi38PRiFM=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CH4PR10MB8172.namprd10.prod.outlook.com (2603:10b6:610:239::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Thu, 3 Jul
 2025 13:33:33 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 13:33:33 +0000
Message-ID: <78aab15e-5bc2-47cc-ac1c-5a348bff0e17@oracle.com>
Date: Thu, 3 Jul 2025 15:33:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 02/17] x86/asm: Introduce inline memcpy and memset
To: David Laight <david.laight.linux@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>,
        Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>,
        Breno Leitao <leitao@debian.org>,
        Rick Edgecombe
 <rick.p.edgecombe@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>,
        Juergen Gross <jgross@suse.com>, Kees Cook <kees@kernel.org>,
        Eric Biggers <ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>,
        Huang Shijie <shijie@os.amperecomputing.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mm@kvack.org
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-3-kirill.shutemov@linux.intel.com>
 <20250703094417.165e5893@pumpkin>
 <uvvh6qfpan6f56fdvuch67nss2h5nqxbmocztf6v2lfbvnihbg@vtzbr6anzqnl>
 <20250703131552.32adf6b8@pumpkin>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20250703131552.32adf6b8@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0179.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::6) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CH4PR10MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: a4650d31-38a8-415c-ac65-08ddba36314a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEUvenhyaExPb1FVUlZvSW53WFIvOHFvWHJLMmFKVXk3R2JpVUdxYVFML1h2?=
 =?utf-8?B?OEphYXIrcStSd1BxRFhKWjVmRmJRUzdVUmdmU1c4L1ppc1N1V0dUd09ZaXlz?=
 =?utf-8?B?TTRQaC9jNXBsQjF2RTUxam1DS2pTRHovaDdia0hkQlVDZ2NZM2FaRnFUVWRR?=
 =?utf-8?B?NHFMekNwTTJtYkNXd0VkSzkxaEdDVlROWGFtQUxKbnNFOTFoVExwcHYzS2J6?=
 =?utf-8?B?YVRnakhpcXY3NThvSlhoWXZTNmJvVXU3RlFla29ZZGN6RnhBazV3c25pWlRV?=
 =?utf-8?B?aThMYWxVWlZyQk1tV0NCT3dZbDFja3BiQ0hmdlptMUtYNUJJSms0YmZSZjBv?=
 =?utf-8?B?T0RZSUsvSU4zVmd3a0JIUHF2dGN6a0VhUG1mWDdnbzN0QkVLUzgyYlFmTEMw?=
 =?utf-8?B?bVBnbU5taEZIcnl5dTRDQWtHTEwxSlhGcmdaekJYME1kSmRWSGRKcFFpZ05q?=
 =?utf-8?B?SWRra3o1UU9USEQ2ZW1hT2V1b2l1SmVrSlQwbXhnMVJTTkJvTzBQV3p4ZjZY?=
 =?utf-8?B?VlZwQjdVUEhNTzBBL0Y2V29NS0d4aTlLRGtmZEZMWWlHWkNOajZHMjZHSW1T?=
 =?utf-8?B?ZEdnSzc1RXBGUmcvUCtjMHNyVjdwNk1JbDdNN2dzeTVWUEk5T083VGlka2Fs?=
 =?utf-8?B?WDlyU1VZaXk5dUEyRzZQSGlEdlltcExqUFltb25Dd1llNVV3WU9pVURkUk84?=
 =?utf-8?B?UCtQMktCaUNGbER1aHRhNGx0L05UdWs5UWRiczVjR3JZVHJ2TDdHUFFpdGo2?=
 =?utf-8?B?N2EzZnNSV093MmN3TE5FYm1GS3d5S0cvNXZzaUxQRHZBcWJYZUp2aWhQK2po?=
 =?utf-8?B?MHliR1hwVmRuVDBlKzE5QmZVK2Y2VDh5OEdjSDdkWXVPV2ZwdnhEb0dMNUN4?=
 =?utf-8?B?TGNqOXF1anpDT3R3NkxKdEJncURoM2syYXdvbkRYeTZuSERuWnBiaWF1Z21z?=
 =?utf-8?B?L0JYcng4L3U4Snc5L01qdklVaEg3WmppeTduNUlhYnk1SDh2c3dCVVhMVzh4?=
 =?utf-8?B?bWhtM2ZtdldtN21hSEhCZVRyUmRUNDNFcnJpYkVaNTVObW54S2JvaUZDZXpv?=
 =?utf-8?B?N0ovQXdwekZzcjNMY1VnaEp3ZVdEWktNbTBGcjFTNFF1cTBYSUJnQ3RjOW9M?=
 =?utf-8?B?TStxaGNDKzZvby9uMVlaYWxKbmxIRW5rNVl2UzdwYno5TDQ2aWt3VHB3aHVr?=
 =?utf-8?B?UWtXNEJaajljcFVmNlFqUXVJYjVsUFB0NVBwZmdPNUk2c3IxdUsxMk1ZUncy?=
 =?utf-8?B?ME03Q3dTcFAvaHFEV0o4SEVmZUhiRjR2YW1MSzRoMENvR1gwYTB4V2lwOFhn?=
 =?utf-8?B?citsYUNLOFRBdmdIbWd4SExCaTduM0JkdlRqOUxVSThHdERWZFU0cUsycEc4?=
 =?utf-8?B?ZWpPM3laWklpNENoREhGNEtJd3NUcWtRSDNvcWdCZVNUVjh4c0IxVDd0YUpY?=
 =?utf-8?B?Y3hYRVIyLzQrOHViMEFqbHVpMlVCZUlMUVpvTkE3NUEvWjQxRWdkdlQ5VFdn?=
 =?utf-8?B?U0RkK1g1Rld6ODFrRm1WRThYL3EyQUtaNzJ6MVVvTlI2Wkp5ZzZsSkVGamhx?=
 =?utf-8?B?dEtqM3F2UnQrWUtjajF1VWVzSUU3aTQxcjdaanAza2wrbGE2eUdiS296RTlF?=
 =?utf-8?B?Z3VPMjdxM05Ld3A1WENLa25Rb0RNZnM3VFVTa256UE1KN2tGU1RORWc3dXY0?=
 =?utf-8?B?dHJydDN2dHorYmN5V3FYazdEaVEzUWhDT2ZqczdUTHJsdk92UWtHa3JrR1Nw?=
 =?utf-8?B?OEVYTk1nbHczcE5GSTJaN0UyRWdPSEFRREZqdWdwZUh6TFlXNE4vSEg0OG5z?=
 =?utf-8?B?Yk9raTFPU2ROQzR3Kyt2bnA3OWt3Slhnc2x4aTRNNHpxMitMVFFYbTVrZkZx?=
 =?utf-8?Q?TcDzcl5mUek9r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3l2eTdOeDlHOWF6eHFCcGFLT3k5K2FqNDBUSjJNaUU4NW1nMnBqQndsUVl0?=
 =?utf-8?B?YnovZTBVdmxlY2hacnFOaWtqQUI4T25qcTgyOUxHbnJ0Mnk2UkVpVWR5TitS?=
 =?utf-8?B?T0oxemVBcjRWREdxd2FzRXFpaVdWWkY1end4VlpFMnFjZ1RHUFRiS2puRis5?=
 =?utf-8?B?SVNzcWNBRTFybWtFSElwUTNoekpCd2lZNEZ6SDY5U2ZXRzZyRFgyY3VuaS9q?=
 =?utf-8?B?WnFia2RIOS9hUEJEYVdqVWtLUzN5SjBQOWtsVmM5VFdhWk5hNnJBTzJURXVl?=
 =?utf-8?B?VUk0VHlnM2RxU0pkZWFVZU1sZTR4dXhoemRLSGs5TzBOdG9Td2hKVG9aeDRY?=
 =?utf-8?B?ajNSUHlteEY0V3duSnQyTWpCRVNVeVA1dW9Gd3ZTY1kzUUd3clpSNW5FNTBP?=
 =?utf-8?B?V254Z2VUZ2E3bnZlcjNVNHNSU2pKMFFkWDBQYjlKa3dYbTNENWd6a285aHEw?=
 =?utf-8?B?R1pyV1MybFRiY3NSTmE4dmJNWUJNOVNVSWZRaGcza2RRNmJtRjh0SitJN3Ry?=
 =?utf-8?B?bDFtd3pKRm1nbDZiSzBReTloVnpSV1NXeUhNVzdOR0FvNkhVaHdKWDFQRGtB?=
 =?utf-8?B?ZEVldi9tQVZlcXFtZXlTVmo5L0tSS3g1VHFQbUp4bVJvV0haZVRUVzFYckMw?=
 =?utf-8?B?VjBHeFJwSTk3SjRhTTlvVG0zK0ZZVlhuWGpHSlQ4S3hSc1JQdndiMDQyY0JF?=
 =?utf-8?B?RmNEck1HYkYrQ1lGdWlnd3BTWkxuVkN1UjFhNGhVYnJualBQOVc2N1RZTkFT?=
 =?utf-8?B?WURoZExGM21peElEVnM1L21vcmdDZThWaE1YVU1OV3psK3ZmY1g4VkVpdDJR?=
 =?utf-8?B?Vks0YkcvdTRBbW45Sys1eGFZaXhMSkUwb05XTE5STVhXREkzVzVmNTQrK2tS?=
 =?utf-8?B?NURramZvOFdSSG1saUNuV3RCUDJmcjhmUnZvYTluRURRWGxyT1BuZ3JYUUUy?=
 =?utf-8?B?YlBhZ3JoV2FFSEhvZFBzaUdIRWRGa0pyWlkyUVRxemNQNXByckdrQ0ptVEpN?=
 =?utf-8?B?UmlyNU1LcnViaitSLzZDUS9hVUoybGNoVG5yc1VoVnBadVRtSW9IVENzckw4?=
 =?utf-8?B?V09QRm9NcHFNREpzU3hjMUhYY2Y4eWl6amh0c0dHcFlVUmVKRkEyalFYQlJ0?=
 =?utf-8?B?UE1VaU5tTm9EZXNVODJ6bGVNa3U5MHpUN1I3cUQwRzB6NjlvVjNiNWN4dTR4?=
 =?utf-8?B?d2pFQ0swQUZzOHlDc3IvaHBHYmZUaWo3S3FsTXJ6TXRFeThSZTdYek9ub25P?=
 =?utf-8?B?OW5uKzRIUEFCZVpoaGU1Znd0cDNwQmFOMXU2aXFpUVFKS1RYa0lCa0tEdFcw?=
 =?utf-8?B?SW5ITVRzTTdmOUhGbXUycGJNMy9JRkwxVlg2MitXb0pYMmRqQnVKT1dWN3J0?=
 =?utf-8?B?MEk0SzNHS2U5T1Z3K2UrbWc2V0w0djFFc2RCdFV4aWlWUXdYVlk2aHpIbUhJ?=
 =?utf-8?B?Ri9YakxQNkkySzRBTWx1Wkg0Q0RLZUtlV0hHaGN5bmFvQ0Q0bVpqVDhxWVhC?=
 =?utf-8?B?emJ4T1lwQ1hVbVBkTmwvbE9vVGdONThUWjR0K1ExbzlRckZ0dk5oMEhtUy9v?=
 =?utf-8?B?R3MwT2luWEJ5aitsc2h5SGFwaUhVRnNpb2hBQ0pHUHJUMVlHQXBIci9FL2R0?=
 =?utf-8?B?Mkg3MTBrNFFYZGF3emliSC9Ccm1KTEptWlAzSUlNUlhCUENySnhxNDNqdnJZ?=
 =?utf-8?B?T0JtMFdGQnpKYmdJZ0U1a3pFQi90bU5teTlWaXhMTk9keVc3WjVCdWNtOVNl?=
 =?utf-8?B?cnRSU1dGQ2xnNWNtRTlXd0EvSUJIKzEvelV5YWJsTHFjNTBmMS9OeWRLUjkr?=
 =?utf-8?B?aHVaeFJOYmlXcTRaTyt4Y01vODhRLzFvOWREdlhmQXNpRXFqaFZRYmcvSk1r?=
 =?utf-8?B?KzFDZDZnN0VRZnp5d3FrOHRWY0lrYVJNVktqM3lXb1g1RTFxNnVOOU9ldEhh?=
 =?utf-8?B?UlZFbWRpbUpJeTVhQmw5TitpaEl5S09VQjlDcmlmanhYMVZKQW9tQ0VTdVFq?=
 =?utf-8?B?RkE1Q2xFazFyNjhQd1lkN0ZwWWtHM1JOT3FMMFh5aEhMUGhZbmZER3gwN1BQ?=
 =?utf-8?B?N1RYa284eVhNNmZLMWtySTNmanVxWlpuakVhRVRIQXdCVkFmZkZCQ045Z2FQ?=
 =?utf-8?B?b0RZUnR1UE5MYlMrUzNnK2lvWDdtcE50ZEwrOHFSU1hmUEZ2cmJ1d0cwVUps?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	haFz4vX9CKpwqysozDzX+uXZ+FeTnmzRpiY/q52PJ01XHZ/mdHFTfL1zlll/DmBGfmsTBeyDCrXPbQTKDmdGHx8z4GzQHIIrbn2r37expaU9lb/s3Ei1W8jKY116/wHBIM81bSujTPJ/tKVqTUW3EVvw2H+FwfEXcS2q6D5jXIUH3+TUiqvQrpQwHm6spMvk4mg6xjCEBTrotqVQMXgmXKJk1o5+9Wyqm57e+DmQoKdVYeeFPKNU0WiNGMispPC8x/TGz1RXLvye1BpZZzoxqmRqBBcqGlUjnq2blhP/FBewIsfj7zVPu+3bkq4IrjZUqQv5Z4ZwhL4PEokDyNGcyzxJZCB/982b/pYKA+sBZcmTO7Xuwzu47j9DIcOaIHV0Cfq856P1HuoSemBeuqgenOEMDKjrnMgYV6nvJ/wtq/0U+Ejm2CCYEiddCcirUGX7wK6glsjRn2poYmZorYhZXMYVZ552rTxTtYZVPKGcva6tVp5pz9xw2P1Wucg/r07KwnDLNo5FZcIf7ziswfWvsf7NbqFNR7SbYar4w4NHiIH7FCVI5Lfyp38l79z8L6F+xy5Lzy29JIhU9VrfrRyC8FxbTgSzsJnvSKzXJ66oAMY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4650d31-38a8-415c-ac65-08ddba36314a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 13:33:33.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxBAL4g19+bPaBftIXOZiui+yI2wV9vHSmrUzP4XpUq98z2FGiX0UcOBuIL+8iEnacNR45MAK0XMlOsZZ1zAEsuaNHaFBtv521gBLR4xC+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507030114
X-Proofpoint-GUID: Qp1Xs3K8pC7lz8RNX-lxAUiW-gUzm5Ba
X-Proofpoint-ORIG-GUID: Qp1Xs3K8pC7lz8RNX-lxAUiW-gUzm5Ba
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDExNCBTYWx0ZWRfX7gTYnfl3Z2OE 6mjvwVd9mJuIWfFumLiJeYJfE9HD0JvNhOwZ0ElqBeKRcvw2kYU4qCUrbt3aIfhLMNcId1eFHlg 0dEd4reAaIzche7jv7lnap1i5AztdUVqq8k/1418nrerzoF9/xGZQjHv2Fr/DZN7cMe+WlU71EX
 JT62wOQox3CPLf2uouYLMBiHCMD9YBtdskeq4xtfey85ZN9EJcVLiCDHa/EHFpeYZFSEYSscXXa LMJgxixoTHWlUpLZeai8jgV3s16WNEETdnpZJJoiDUFG5s6oCe6SvwS6wOl/stmyaBrKl3y67Le RzQccqRGaDKHOuD2x2PwazmzBXv7oZ2xEeGNT0uTFEx66tlJq4T/ybHKWUDuHK/C2L2W1PB0wSD
 yTK+b1vAQ3AgIDtaB8Ms1qqUiDMkWOaLpMJoXHMwBwFmyVG81f8WfkTTTxKz+gu+sXlnqkGt
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=686686b8 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=PeOOapuUAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=fgeo-aampgiuIPYjM3wA:9 a=QEXdDO2ut3YA:10 a=0BaqRfgCL6CLbWgV2pdm:22 cc=ntf
 awl=host:13565


On 03/07/2025 14:15, David Laight wrote:
> On Thu, 3 Jul 2025 13:39:57 +0300
> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
>> On Thu, Jul 03, 2025 at 09:44:17AM +0100, David Laight wrote:
>>> On Tue,  1 Jul 2025 12:58:31 +0300
>>> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
>>>> diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
>>>> index a508e4a8c66a..47b613690f84 100644
>>>> --- a/arch/x86/lib/clear_page_64.S
>>>> +++ b/arch/x86/lib/clear_page_64.S
>>>> @@ -55,17 +55,26 @@ SYM_FUNC_END(clear_page_erms)
>>>>   EXPORT_SYMBOL_GPL(clear_page_erms)
>>>>   
>>>>   /*
>>>> - * Default clear user-space.
>>>> + * Default memset.
>>>>    * Input:
>>>>    * rdi destination
>>>> + * rsi scratch
>>>>    * rcx count
>>>> - * rax is zero
>>>> + * al is value
>>>>    *
>>>>    * Output:
>>>>    * rcx: uncleared bytes or 0 if successful.
>>>> + * rdx: clobbered
>>>>    */
>>>>   SYM_FUNC_START(rep_stos_alternative)
>>>>   	ANNOTATE_NOENDBR
>>>> +
>>>> +	movzbq %al, %rsi
>>>> +	movabs $0x0101010101010101, %rax
>>>> +
>>>> +	/* RDX:RAX = RAX * RSI */
>>>> +	mulq %rsi
>>>
>>> NAK - you can't do that here.
>>> Neither %rsi nor %rdx can be trashed.
>>> The function has a very explicit calling convention.

That's why we have the clobbers... see below

>> What calling convention? We change the only caller to confirm to this.
> 
> The one that is implicit in:
> 
>>>> +	asm volatile("1:\n\t"
>>>> +		     ALT_64("rep stosb",
>>>> +			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRM))
>>>> +		     "2:\n\t"
>>>> +		     _ASM_EXTABLE_UA(1b, 2b)
>>>> +		     : "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
>>>> +		     : "a" ((uint8_t)v)
> 
> The called function is only allowed to change the registers that
> 'rep stosb' uses - except it can access (but not change)
> all of %rax - not just %al.
> 
> See: https://godbolt.org/z/3fnrT3x9r
> In particular note that 'do_mset' must not change %rax.
> 
> This is very specific and is done so that the compiler can use
> all the registers.

I feel like you trimmed off the clobbers from the asm() in the context
above. For reference, it is:

+		     : "memory", _ASM_SI, _ASM_DX);

I'm not saying this can't be optimized, but that doesn't seem to be your
complaint -- you say "the called function is only allowed to change
...", but this is not true when we have the clobbers, right?

This is exactly what I fixed with my v7 fixlet to this patch:

https://lore.kernel.org/all/1b96b0ca-5c14-4271-86c1-c305bf052b16@oracle.com/


Vegard

