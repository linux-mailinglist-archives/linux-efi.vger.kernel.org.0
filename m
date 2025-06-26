Return-Path: <linux-efi+bounces-3999-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9046BAE99DF
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 11:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462301C2474C
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 09:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E520329E115;
	Thu, 26 Jun 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AtzfIok4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FImmNEjN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C802701C7;
	Thu, 26 Jun 2025 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929810; cv=fail; b=nSIw75KHfjvridiw6zv5mQ4oKi9JVRThsLSMeO4ElZITOSOQSAIEsDal4GffHgLWXUSVkV5hz2wXuFwF8a21SLymDZGwxXMo54msbfR0MhxMkTOhK7lsY7IvVIrwWfqmjKNttm2Q9aEC3pwTXSOTBSZJIVVmXGEe/mCjXswzllY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929810; c=relaxed/simple;
	bh=Eh5JzsEcA9LzwijHZ1ZrNhxG9EbI4YkLiXtinCLerdk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UZOzt4scB8AkVqgGNRf4SL6DhICeqMgF1lVLX5KbU0UJ9749VI8jsVuOLI2Igj7dBW83YKgeWjjDi/gcakB7gtE+gJv5UjvKghzjP5k2ULmIhTfqZGI5BTMLy1+gbRW2jEa14fqC1jopuHFE7Xh6u4W0mLkT1YXqJqCvylWGZf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AtzfIok4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FImmNEjN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9Ba32011264;
	Thu, 26 Jun 2025 09:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uFWiN5xKwoDDRI8wxytUL6YU3qKlvwmc9hDBFshpy4A=; b=
	AtzfIok4uGxBU6f7XeN3un/O44NQpdjsFLKOR1USc+sXbzfoOf++6wtNLWNRVMzr
	ST6AAaghnKQFoxm9AyY/fcXQXYY/pHYizVTs9D1PCk0nuog2JOmG3Fo5pqoA4+Jp
	09T09zm7jReMztn4LOyQcJUvuRWFnF6JX4OGqMv4EZtEbtD7QFxWeZWipOveaBbW
	zkEL5yDRCmN6RBLaUsyA0CsxXqvFI3+8mm06OBDzuUBtoqCQNNdzJjkLPlpCZiFw
	Wdq0plY1FWALmNfnoKHSsfKw+qCVQCrwrKWyaVUFsTfqcEMXSymZSuXzAlr/A9Q/
	bdp05aW+WXMZ3PaXm2JI8Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5rauk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 09:22:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q8xR08034491;
	Thu, 26 Jun 2025 09:22:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpsrafj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 09:22:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zk48Wsd4ZaisXg3nQo9rHMCgMbTy76hE0hOeqku7KGB7y4LG28rev+pNzS9bsLxzNOMOWuDeVcRv/+KSZhz7GaO9cmsyZC99dM6Kg4V1FtR74bs25lTRRrPiDhm5TlYDpaWYx2v7ufZseM2WsLbBDVwCx69npU0qKMJyXAdroyFWAf8bjvuxdXJzXCkQjYA1Gw2T+pZw0i/Fm8IHpHlqfqTwZ7Hr+7NPJnG9k6eHzIGu7BsYUjHnLP8O09NLxeCFZvRUfwpapCHjI5hkRCejlSq9h3cXX8Rkj1n++V1GPTmAqt83+ObAqWTxphXRUOP7wtLBfw1H5w897K7kpbTYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFWiN5xKwoDDRI8wxytUL6YU3qKlvwmc9hDBFshpy4A=;
 b=pu3NY29ry6tY4heNoMKx9a7dvPxtbWE0suXNgXQ6pfydBl8uWOgg9H/FveZ7XxAUTWYa0z3UlaoF0oYnIl+TrbrSHrajZ88PlUIK0x2nB+U9tUwAOpAtR3QScO8LbeZN/S1+rSIBChPfGCBDl6Qtc/+On7r4nc/j+M66H4fFC925ikXlPP4PM1zNyLDyxEhUlTUNgGN1JkjAvjdgIbGXHBs875rU5++MT8QXZBeBaACJ3Jr+jbFbvR41jcsY0Xk7d8/yEg9pMnMa7QMi9eeaDpRT6/gxe96sNrGeTda8IjpVFkhpW8Dn7Gjx17eg6+TxpduHHbJmtM+LqncnRj/B5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFWiN5xKwoDDRI8wxytUL6YU3qKlvwmc9hDBFshpy4A=;
 b=FImmNEjNwv1IR8deZtJGbeElbC+K0N6SyJhPpSOsKn3ffFEAGtAMi4NLrMoWoO5tjZ+PkFs/F1b6g8wG9YznoShwaynyFBoPh5jrlIA1wdXYv6iXf3xQfKgIYZLx8f1htPbq7IKwr7VR1LRjV3kHKFnkWhyEQqqNEd9OgJpdbk4=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by IA1PR10MB6170.namprd10.prod.outlook.com (2603:10b6:208:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 09:22:25 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8857.022; Thu, 26 Jun 2025
 09:22:24 +0000
Message-ID: <9b1c5e43-ff48-4af8-9ec8-1c1dc2b902ae@oracle.com>
Date: Thu, 26 Jun 2025 11:22:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 00/16] x86: Enable Linear Address Space Separation
 support
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>,
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
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0040.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::28) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|IA1PR10MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ab5d31-3b8d-4bb2-f048-08ddb492f637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHdWL3MyZlZSNVRQakZVUHhyT1V6L0xzZ1ltMW1ZQ3Fib2JERzV2R0Vyb2NX?=
 =?utf-8?B?S09Eck1RSXlBUWo4MWJZQWlHeHppT2hnemc5Um9XQXRpUEtNaldyYVhaTUMr?=
 =?utf-8?B?UDQ4ZFhha21OVHg0THhFRTErenAyR2ZZRVdjSzAySDRUN0l6ejVkbGUzcWdP?=
 =?utf-8?B?ZTh6clVGK0VsOVRONkoveUlacnp3ZUhCZXN6T05uZEorTHVBMTUxTkovQm93?=
 =?utf-8?B?bzllVy9Na1RTVkhiLzNobElFeDM1STZKeTNSUmN3Qkp4bWhoOTduQUl3RHV5?=
 =?utf-8?B?N01QSjlMUWVzVWpXT3VVMVhqRnFzS0RYVGlOYks1NGE4Y05rb29leVVUcWhv?=
 =?utf-8?B?SG9KVTBYUjNTNXhvcHRROUk1Y1pwcmUvWkkvYlVRNjJmWDR4RGVlL201dVBD?=
 =?utf-8?B?QTdPbzQxZlNWdVhaeFo5MVR1TXh2TVVMSHpENDZCYVp5dWlqWVVjUXJSQlZu?=
 =?utf-8?B?RFJnVHdoZjBGb2NOMVNUVEsxc3dlUzNva253aU51b2pWME5KUzBBTEU2eHZX?=
 =?utf-8?B?VzlhT3hTbmw3Y3dnRFBKR0pTSEc1dm9NbUlGVDJDa1lpUXJXWU1LZVUwcXN3?=
 =?utf-8?B?TWxRbS9yR0g5RldXOHdmQjVldHlxUTQ4dERTMmVOS2lQbzRGMlE1N0ZsZkJx?=
 =?utf-8?B?TUhnajRyUjVYelNIWDhCR0pTaTQ1SnBSNVhnL1RpVmVORnJQYUtKOXEzNnF0?=
 =?utf-8?B?MjRvVlA3OVhhS0xPZzJkd21EVzJ0aXprMWdnV2NzbjF2am9VV3RvQlh3WWlS?=
 =?utf-8?B?MTBXSFRLMDVDalhpdVpjWXJuV3A2YzAxekRJQmFYaHFiSStQdXlVOEZabDVR?=
 =?utf-8?B?N3ljZ25sWCtpeEFPN2NmRmViK2ZZdW9yK0FsU0s1REJNK0lwMXZwNFlqVk5M?=
 =?utf-8?B?VUdFdXpFTkU5NzBjS1JkOGFERXpselM1eGJWNmVzVEtaV1FFWU91QWM4Q1RI?=
 =?utf-8?B?TFBIa0hjVTV6TG5qNnZRaS9RTUhCMFdpL1JobVg0T0VDUUc5Z2YvdEJUb2I2?=
 =?utf-8?B?STdkZUlhKzEyc3p0ZUQ4cDd1TWh0c3dHcjRnN28wbnkvU3V4Wndmd0JBSGJQ?=
 =?utf-8?B?RmErYW0rZ0MxeHlXTTNVeWNCRzhrUkt3SWFKeFFudDluR0hyTnBhelAyaXI2?=
 =?utf-8?B?TmkyUTUwZWJXTEhuMFNicTUrTjdpemU0REdJRDJVMHlxdHpJWFpjRDJ1QnF3?=
 =?utf-8?B?T3BCcW03S0NKaXg4cFMxQXp2WnlSZlFsVmJub1V6aEpVYnlScHMwelp3V0pS?=
 =?utf-8?B?NzJRcE1sTlpjekxQL1c5V1BldFlPMzUwdG5uTkhHWmloWTBoWVNNQ3hKSENX?=
 =?utf-8?B?U2dUU2ltODdXRHIrWjhFbjlQT01rZ0R1TG00cXlDT01TZVh0MHpBcFIvblc3?=
 =?utf-8?B?REJad21icEthczc2TDAxcTBiTDZWRnQ5V0NodDRieC95bmV5N1hWVGNtVENw?=
 =?utf-8?B?NU8vbGsrWEFDL1k5aU1BUWtHVVROTHhOUlRCcXg0SlZGbGw4YzFkMERDQU5X?=
 =?utf-8?B?Z2w5cFpiMjFPMVJSbGVSZHZGNytpdVJBS0lIejh4M1oyblNKOExNd04yeWda?=
 =?utf-8?B?djEwazVZSUtadG9GNVdlOHNraVFSUU9zRXBsMG8yaWlmV1p5QldBM3pzWW45?=
 =?utf-8?B?bDdiQkdMdUpveXVUQU51TFFGaFdsRjkxMXE1OW0rNHZodzI4dDkrUUZyWjlt?=
 =?utf-8?B?U2NDRTJRUTRWY2hYbUIxOUl3a1A0ZG14UUF1NWtKdDZFcit4bFp6ZGNYeld4?=
 =?utf-8?B?WjFVb3Q5M0F0ZjF0VWJ6TS9FU2FhMG1mbzdlemNtWFZrb3BTOGR6UUY4VEFs?=
 =?utf-8?B?TERuQ2lEZHBmQXRkQk5zTUFjMkc4ZmtVVXcvd2k2QXZQSVpybTdwb2JmSytI?=
 =?utf-8?B?TUlRb3FEVi84cUFRbFA5MXJsRksvNVR3Vm1QZGhpeExJMjloZ1VNNHA4Q3JS?=
 =?utf-8?B?eTEydk00dUo0d2xnWDlvb1Q4dEZNeFlaNXdZeFR1RWR3VzQ0RThhRk9KVHl5?=
 =?utf-8?B?ck5RS3RaNkJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2FzYWVFaTFXZ1QveW95Z1pRVjZYeUdaK2xBNElSay9mbUhDZzlUaGhEWml4?=
 =?utf-8?B?Mm9VQ09YTXBlaUxqYllkZG51dDRjT0t3MUFvWkxCbW5YWDArTFdWZVlvbzk3?=
 =?utf-8?B?bE9ZNXM5UmlueEplQ0w5NWRFdVJLSlpGTWgvRElJLzF4eHNxTEczUzF1NTdJ?=
 =?utf-8?B?ZDlkVDZPMGNGdHBpMktEU1NUazF6SmdCTWJBSlAwNWZoMFk1KzRhajgrTFZL?=
 =?utf-8?B?SnlMeWE3SW5EN2lZTFBSY1RybnR6TW9ZYkU3WjU0SjBRV3dtYlZuazYvMG5a?=
 =?utf-8?B?RGtKS2VyRytQbUQ2Z0JXSkNPb1ZZdzJLLzVPQmZ1YXN0ZDgxY2xnV0VYdjdY?=
 =?utf-8?B?VUpodXNhdWFJTjR0U2Faa0UxN0FSMzdzUVJVTEFXTWd5TGtpQ1dmeXJnU2xQ?=
 =?utf-8?B?dTJ6M2ZsRUZka1Q4emNwTWJVSi9TNUlqcm0vSEJjNjQxWjJsVjJGck40cGNy?=
 =?utf-8?B?ZmN5SW83VEpvS3hKL0Q2MkJpSFMzcGFadk84VTZTN3VDTjlldENENk1HQzFr?=
 =?utf-8?B?YWRUVFhEZHhxaHVjOXJmbCs4SnVCQkt2WVVaVTJZSWE5bGlDVmYxb2I1S2tT?=
 =?utf-8?B?dmRMSGdTUFVwem5WQ3VGTlVuQVFvSU5Ha2R2bXZ0dGppanhkR0xZZ0l2WEFh?=
 =?utf-8?B?YmlKV3Z6ZmZlRVpXa04xLy9Fdm9YYUlMWEVEdThSVktvc3FjQmpSYlh5TVpl?=
 =?utf-8?B?Q0pOMjh0cXVjaEpqeHBrR0ZSTGtRc2o3MDdET09EZ3gwRjZFZ25VcGRGUXJG?=
 =?utf-8?B?WFBUYjExdi9PSXE1dS92OXgvQjlDQUZCdFdSbHJ4TW9BZDN5eURPY1lJQ2hO?=
 =?utf-8?B?c0I4aXNXUUJFZFN1REpjMHlMUjF2VnhHQVQ0K1hkd1FFYXBFdmFrc2VoRVNr?=
 =?utf-8?B?RlhnQVpnN1NCODBKcVE1Snk1cGVRdmJYZ0FKZlRxNlhVN0J2ZlFuK2U1U211?=
 =?utf-8?B?NmZwSWRlUHZaYnM1eHA1cU5RM2tXSlVlSkdVbmk4RFlmN0FkdllXSVZEMUVt?=
 =?utf-8?B?UEJpMUlBQ05KMDVMajdvZ3hhYTBxcUx5ZUxLQW82aWtxTnVWajJjUURDbWVx?=
 =?utf-8?B?MjBUWUhvSFBGSytYcW96cXM5TnlQK1NtN3Y1d3VrMGFUVXBWVUwvWlJQM0R3?=
 =?utf-8?B?Wkh1TDgyYVZJR0ZwSTUzUXRXVEZsQUI0QVdzdjhiZi8vNEduMFVRTHhmK0oy?=
 =?utf-8?B?MS8weWJQNFFiM1VKcThCb3c0VXR0V1NGbGNvOFgwK2w2QWNIL2QrMkZjWE1K?=
 =?utf-8?B?NlhzYitPM2VjSktLQXJPbzlCSkttOEkyZ1E3M2RSa0NQK095bEVqZkpIeVg5?=
 =?utf-8?B?YzBCcGVsbFhrQldWWWw0U2ZaZUF6cEw0NFdzV0l3VHJYVG4zQnBiM2xZVElW?=
 =?utf-8?B?cmFOVWRiMUlQdjdoU2NDMzc4VjVJejF1cTJPNHNaVkFraFVMcHgxZnQ1cDBn?=
 =?utf-8?B?R2F6NEdRbkdscVhndEoyeUhnTytIR0xJc0ZueDRML0NDSU5xNy80TFpQTzRv?=
 =?utf-8?B?N25COU1HSWNhNm82UUhReHFyem9abEpDYnZRbDVURDJLUVpndTkvcGRyenRS?=
 =?utf-8?B?QWtHYW1qLzRVaUplRThHNkZPZ1MyYW05WXhnRzhGVDdGUGJoVWJuU2tiend1?=
 =?utf-8?B?OTZpbXFNcjV4Vm9zd2lEL1Z0MU9Cb2dnT0llejNsOEY2RjFyZHYvTDJJQnRN?=
 =?utf-8?B?MzFpSi91RmxLT0VPRVdtalJ1eTRFeXNlL1hjLzg5d0gwS09yZ253Z3orWWs3?=
 =?utf-8?B?WmtmTkVERVNLTzBaWnZBL2J4Tml5d0FGdVZ6elhNK29XRjVqK0doVERxblkz?=
 =?utf-8?B?a0pIUC85dHgrRUV2YXF0YU01Kzg2eGRsdTBwTXpwZ3lLaVFqbzc3SGNuK0pE?=
 =?utf-8?B?NWhRVjZzdG0rYjdjdzE5M2N3dE9iaUhDc0czMzlERndhMlVFVzhUZU1CaGU2?=
 =?utf-8?B?STNqVHhOc0FVNlc5RDNBV0lmUTZVUmxTZ3FzZjNsY1BsNW5STXpJNjN0TlFh?=
 =?utf-8?B?Z3p4bXpPT1J3NWRpMC9OdFNXdlF0RGt6M1JVdCt0dnQyUUg1bVp4Z0wweUdt?=
 =?utf-8?B?TFFlMWhLY1M3ejd3QXhFMm5MNVFuM2YxV1pTRmxQWm5xVU96RU84QnVBVk15?=
 =?utf-8?Q?outdfDl8rsY28jvRD5/vJjHDa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WkPCQ0wGFqzZlJfcIH6rnhuq2glIAWiEKq5Gsz3zvABydNA6SDOnPeRZdBYWkyHZtYAHD2YSOUdwkwWS5dVvN6IF74Q8yLj704MqnwAu0D8TZSo9gdEIO3MQPRMywNu40D74h8WCm6+Ar/XzJs+H8KJS4wG/vkJ/U7fjN1oWzXqkxW/sJoz8VOARi6Oh2cwvCmvc0tf2hphGVUYVo+uB6mMKapOD7dPc1WuW+n7SE8XvLU1O7Ogh54JT6nZaadr76tj5kTYoAsf5lbMGVstAWg9IBP3ELTAzQyA9iHE2aj5xlN0B+zti6I9BTSdzSfTz436SdyQE8Z4/rFryg0B0yd/IFZhy93io26u8fVgP2KtA6ZDTYfffXoI2UcG+dNxJPGTQxZ5Msz9qfTEaxVq4SJye8O82JqOsnvFvv3eWkAh5Mfx12UqlyzHvh3iaJRozepV69/ataPsudScQGl/KDcykn51DktqdGJuew2rjee29FmRHWrCgLRjtK/6BkPLrWhK/oPXElOkwcpLyRpThw/lhwNY1d2IoQrCSoryXA+lG5Uh0YcQ07ChiSZo5rZTaawwLAdphf8J+OsEQiNPAkwYG/zIO178VLBcc0+j3RCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ab5d31-3b8d-4bb2-f048-08ddb492f637
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 09:22:24.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: da1LX0OXaWYaZOpfk9OzrmWTIURdmpKje9oQRWqVSNyigAkCoXPH99r/V/zQjnkO10vebbNXKu39mHt0VHJkl4Ikz9QORQYjSF4mBZwPz7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_04,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506260077
X-Proofpoint-GUID: syF-O5-Kb_zaqckKfWSBbeY8iWpqH6sU
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685d1155 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Ffz4T6hpCQBepAsO2J4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA3NyBTYWx0ZWRfXzp7iWKsbolo9 uoeKphdCHbmplUVAIBL0n5fzTeDrsmbPAiw4wA6XYu/1EnL17Tl/3rGZFQohRkqW/OWHlv9osA2 2OKAWrWb8zW1MXBxgERKEtb+e+/PnNnMTuFAWj8t6F0vD0FppvGZox+H4D21URBs00bs9gZA76Z
 0yrCRp2pHFjS1QgSNh6tfn6/tpCrMEmue3yr9s+Qwm1C9ompy1x/lEfrR33FQNrPpOLUwHrEHh1 l+sXQCAxAsk/OnWf9kB9B0dp0iGxQsD6rMXA2/TS1KYiYUuUOuebP5qRb0Mq/ELgI61FPdWr8+6 CAHWCVsx7zFW2tNZGsZKlqf3ME7LV8rL0FCTs0byz5OmKSRn0AbUbRmYumGq2B1Jr+bp3tEt7qT
 s6qPde27eYaEkPXlEuflYlndpTKtfVBePepq/AIrqpblPhagVEj1QllSMB0bOr6yErrJNsGA
X-Proofpoint-ORIG-GUID: syF-O5-Kb_zaqckKfWSBbeY8iWpqH6sU


On 25/06/2025 14:50, Kirill A. Shutemov wrote:
> Linear Address Space Separation (LASS) is a security feature that intends to
> prevent malicious virtual address space accesses across user/kernel mode.

I applied these patches on top of tip/master and when I try to boot it
fails with errno 12 (ENOMEM - Cannot allocate memory):

[    1.517526] Kernel panic - not syncing: Requested init /bin/bash 
failed (error -12).

Just using standard defconfig and booting in qemu/KVM with 2G RAM.

Bisect lands on "x86/asm: Introduce inline memcpy and memset".

Thanks,


Vegard

