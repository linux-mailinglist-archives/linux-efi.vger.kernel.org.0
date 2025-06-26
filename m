Return-Path: <linux-efi+bounces-4000-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A84AE9A42
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 11:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FB21C42C26
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C6E29E115;
	Thu, 26 Jun 2025 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z6QfoVcA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aD0JFkK+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A98F224B0D;
	Thu, 26 Jun 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930589; cv=fail; b=OsRrbGJ3WfXGDL67kdhkI3D6zZVC68GR2Vxpl0qxwTljhqynUNQbnh4HlqxtIRvKCXYPOU/vyR9qKorIptB6yYOjoQZXRJ5eP1QzUz2x0UQUJc1Yub8m2Zogd9ZfcQYBF+aJ9fD6JoZ7fHzhbD1k72xnzIT9vc7AQ/Uk0iyv4+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930589; c=relaxed/simple;
	bh=vkLCmIof6dE8G3Melt0eEAxJ3ZVuHeoPDpeK8thDXd4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tqRVevGlUIwXtek2RDnUgUgBd6IQIc/GtnIA+kPWSiSoUXRzjFApYgsrhiIzSJ/2d/x9rqbHF2KpvSyQ5l9dPvkCZ/pj6bSq9DifQiCYxCYFVeyyFW1mLY/Cs3ygKeCjckwUNqaNhTsLPwjzQusrzIDhFWl0ykmgyWZjltwoJ2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z6QfoVcA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aD0JFkK+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9BbVk009738;
	Thu, 26 Jun 2025 09:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rQEOJLrI2ihIO2Zrwv3Md9azoguaB0Y0uDZHLjX0KPE=; b=
	Z6QfoVcAb7aIGdbmI6Jm/UC/wG67TE+8VnPbICP/8xKiexxTbjbk4bat25qsPggM
	MxBc6ubo+QiqVNC3WDQwSdKW2Zql1iyN+AWcEOJSi9T8kP5wfyVoFJRK0VHXJnoX
	uykqCK0BkGzuuUomPClvOsUKIagonoAbGkscRLrW3+k/S6zO4eNAYk/YW877DmTm
	qDOM/EhgahOtjPgnCqJK7j9AB1nHJI51qBkooYeqGSgJYWCZI29pWNLh3e+ttEi7
	cmLrsqOQpIkzg0gYQOBGbPP/NNuLEI2hvWKv4wdrZlvEXR0U+AGOLYdDsaGhhPsE
	Dn7UzCoEBCsBOn2p/0+sWw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt7g8yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 09:35:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q92CcA038046;
	Thu, 26 Jun 2025 09:35:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehq69856-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 09:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5KFiULEyRe93U9zpBx5gzTBv4/g4+4pHCFK/GVQuEcQY7B3BgW1m3w/2Zy9MsxMOMt6ZdVTli1cyYDUJERomSBYE9T0UBxATB2h3mnRgKupIC773MpxHi8qs/lQQ1vQ1mJAQmGE7d619V/qIZR7r7Av8Vsm/75wN1Yf1ejGoUfRksDkx0u+yFTx1CZp3bedk03c/Ty4u8WfpKEbouKrqWO5/xj47A2ytll1izLWQdqnICpkpVzGydjmqMS3pSUV6kARRRq23VG58LqRBai8KHawFi8yMvMrcAlLDyZjdMWNgtX6iTt9r45gkU4y3th2J46Uaq/PYo0HFTN6KQ960A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQEOJLrI2ihIO2Zrwv3Md9azoguaB0Y0uDZHLjX0KPE=;
 b=WuM7cx8bc5qulTw3QKdBtJVRhTIAXCoZI5ElfkBdJyj6aA998qWWd/W5rGW2eD9jDcRT+1dckQ2bYmI2Guu2Jd+LN26xJOX8MTILPcSmvyFA8DP9eKUqCiNQYJgmZadlpH5z1rtlbmF6ZEpgA5uOOfnE4rQ9D4R+3fTK0UmmW326PyEU8i3NaHPVQZMs3knGSTG+XhUtqdT1ZQD9l5awvI6LbDdvY/0YyZkKXzhnzQx9Ni6hAUUy+YXmbazWqE5Ei9bCotj4guH1DcZs6DRENXqlAgk82qH4FUQxhH5QQODEndkA48I5VP+jb2JlMAzun2sd37bsUhHUBKbbubsyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQEOJLrI2ihIO2Zrwv3Md9azoguaB0Y0uDZHLjX0KPE=;
 b=aD0JFkK+1I7Ho4xfCNaCITBpOxQ5sxDvvmgzvGwxBvQSZZUI1eOf/akr/WUmMpUde8R4c0yOamP2f/855hGmWqWuQC2LKv6kGQ3Z3O33ZUt9IJEfQyFGmvzs1oyUOXEvtvnYBdT7g2SMMyFNuNpasqeHMPQcG+GvtcrlJOaKh3U=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by MW4PR10MB5864.namprd10.prod.outlook.com (2603:10b6:303:18f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 09:35:33 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8857.022; Thu, 26 Jun 2025
 09:35:33 +0000
Message-ID: <1b96b0ca-5c14-4271-86c1-c305bf052b16@oracle.com>
Date: Thu, 26 Jun 2025 11:35:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 00/16] x86: Enable Linear Address Space Separation
 support
From: Vegard Nossum <vegard.nossum@oracle.com>
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
 <9b1c5e43-ff48-4af8-9ec8-1c1dc2b902ae@oracle.com>
Content-Language: en-US
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <9b1c5e43-ff48-4af8-9ec8-1c1dc2b902ae@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0077.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::30) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|MW4PR10MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 80685b5c-70c1-49b1-fdff-08ddb494cbf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDRjamFLUWZWcVdLWmRHNzdrT0ZvQjBVRlFYcXorYjlCcG54a1RsbGFDaExQ?=
 =?utf-8?B?K2d4cHB3b21RYm5qTy85andCbEc4RGZtTFdUSDFhUDQ1MXhhY3lWcm5oTEZS?=
 =?utf-8?B?NVNNVWV2MFRzQUJCOEYxS2xWa2orYzlUNnRPaXF6eTFYQnNwcEZVYllnbUlE?=
 =?utf-8?B?QmxMUmllM3FxQWIwRjcrcHp2SjdVSEJMSjlkMW9od2ZMN1M0OTBscTJadjhZ?=
 =?utf-8?B?c01od2o2Ui9GODV6dEJ2aUZZUHZVYWZkdWhFVVhiRFJBQzlOWkphb0NVU1Y2?=
 =?utf-8?B?WmpHaTUvL0pWL0pTSHYrczhzZEFZcW9raUozZ2Yxd3ZUWlpaTVdVTS9NK1Jv?=
 =?utf-8?B?YVZOTHdlUWVvREpUN3RGdFp1c0NlbVlMRFJCcWNwWHFQYWJLaDM5aGtjcUg1?=
 =?utf-8?B?cDUvcDNmejlTZzB2YnNSUGtuZkNuNzJMUFMzWHZHM2RjaHNXVUorajRwNytM?=
 =?utf-8?B?b29KVStEWitSZWpDNkxGM0Zic2hvUWROSWIrNnM5S0g1dmlITmdhVU5mWDlE?=
 =?utf-8?B?dFRiQVZMMUtXRHRCek9KcHo1ODRWQ3Y3Qm5hQ0VEWmJiTkJQQmtWb1lqdld4?=
 =?utf-8?B?dTVjazdDaXpmV3FXNFdPTHZQTFVyamlGdXE3Q0lnSXU2YnBSTi9xZUJaMTNM?=
 =?utf-8?B?RmhxblZPTnA1QlhiR2JnTHYvVXRKVk80SFF3ay80SkJwV1BoODhBS3JxS0Q3?=
 =?utf-8?B?TktDU0drcFlWMDMxdG9JWDN4cW5tN1h6Y1ZhNlQ4Q2xRSlJCU2hvY0FYMGpT?=
 =?utf-8?B?MEMyaERXektaQW5Mci9DcHlRY3d4a2NEMDFaRG1GU0N1dmF2OS9CY3plcEdi?=
 =?utf-8?B?MFBpQUI0eWE3YlNZRFE3S1pUUHB1dHF0QW82UUpwU1k1T05kYTA3cUpjNmg0?=
 =?utf-8?B?MUFDZU1aZ3ZZelRLNHZ4emJ0Snk3TEdVT0tQcHRzVjlxbWtJa25kYWN1c1BK?=
 =?utf-8?B?UUdNenZybnd3b2EvNFordnZ4REdFNHVWNGRNd0k3LzhyNkp3RnlhRytFYkVV?=
 =?utf-8?B?UjNJUXpFTURXTTJVc2VSWU44bE8wSERYeXhHaExKMExSWHduNkRGbGJHTEk4?=
 =?utf-8?B?ZmdJdGExOFdSTkgyUkpyZ0RERm5QSEIrS25xVXFkQk9HRS8vSkxWUkZuY0la?=
 =?utf-8?B?cE12SWtPY3l0OEppMk95RVoxSGw2KzM3bit6dDMyRVQ4aCtrZTh3V2V2RkIr?=
 =?utf-8?B?KyttUm1IQ1BFdlNDWGx4N2hHOXQwYVlwK0x0WjdvOXlCdFBSWEdHeEJXbkFp?=
 =?utf-8?B?QXR1b3o3OUFiMUkva2kyT2lZL1BQRHlOWUtjM0RWNEhlNm9HYSsrMG9rZ0d5?=
 =?utf-8?B?Q2ZoSHRuenNqK3RsQUlYZksrQ1JQUld4cElTcXlKMzU0VUVWYi85Sys5em05?=
 =?utf-8?B?ZVhlOFdFY3hkeUtPLzUxdXQxbXJIbnBPOWpKb00rMFZLK0poN0Z1ZGJKRFNP?=
 =?utf-8?B?dzIwNGVpSkIrck5UN0VaNWduTXhRM296NnNkNzdYNVQwZmhaWWQxOVczOGx6?=
 =?utf-8?B?VlI3TmNvSGZBMEZVWEdXVThiYnhLZGNkK3VjVTcwQXJURWpYVjQ5QnRZalZk?=
 =?utf-8?B?Uk1SNGFMNFBjZGpsWXNEUDR6MUVsWkpaVmtSdFhGQnM5RmdwTXVBRDBkTnpP?=
 =?utf-8?B?WU5xQURFWmpqZ3lCWUlnL2JyTnlrK01XMVRkNWhQN0p3dit3eTFVb0tkNEFK?=
 =?utf-8?B?OTV5UzJIaWxZdFgwQWNNb1l5M05UcEYxcXJFNFk4N3dSbXdUQWMwc0JPeDlI?=
 =?utf-8?B?dStLdm00Vm8vVEZKejNDblBTbTVoRjdRQU9qaTAzOG1yKzlhcEQ4eG9IQTFN?=
 =?utf-8?B?WE11WHIycm1DNlowWVZzZUtBWVlKVTZHaldlSGt5V1NPeE9SVGl6d3krK01Q?=
 =?utf-8?B?ZFJNLzV1K2JZRW9vZUJ2RVdyMDlzNjRuRmVTMGFLclVqVVNXM1FRL2MzNDRH?=
 =?utf-8?B?RVFlbDlYUHRrVUpJT0l3TUFlUytRTWVEM2RmSGVrb2ppWWxyVzV6YVRCb2tZ?=
 =?utf-8?B?MTJoU29qWXV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzhMQ1BzQ2k2R0lvdHVVbWJHZ3d6OHNwSThkUEt5OFJNTUcvN0pCVG9MZEdS?=
 =?utf-8?B?YWk5Q3htUlB0aUovS2FvTlRnYkRqVk1lbXcyQ2wyYW5iVk5NUlNRYTdTcmgy?=
 =?utf-8?B?cG9nZTRLNXFTUFVSUjg5MDF2My9tNWRPM2JRRTVlYVJIR0RTN2NBRjM1MUp3?=
 =?utf-8?B?angzeTg4R0dHcTZmQjlrelRNK2UvTVo5M3I0amliTXNaaXI0YUVlY3RSWlFM?=
 =?utf-8?B?WDYyUkEzOUNETDNzeEloT1U3VEc2L2FtSUNLRGFyOE1ycHd5OUVhU05SM3pV?=
 =?utf-8?B?aEwxdXZTUUYxNGVRdXlzdEx0cDk1RjFTSUVYNE5Ua2docW8rMXFEcmVoQlFo?=
 =?utf-8?B?M0hzbjdxUFJsZnVoWCtMaGZaMlRWclVMODI0K2w5eml2bkRmQTVNQnhxUXgv?=
 =?utf-8?B?ZDZZYmxSVllZbG5rZkU5MlRSdm5zYklxUHNvakVLWkQrQ2xzSjZWUkxzWm91?=
 =?utf-8?B?RVhqdm5wNEY2SVVWUklpZEpZaFhFTENtcU5xVVZoVEJwcXBWdXJOUU5YY0ps?=
 =?utf-8?B?VXRCS2VDQWgydGNQdFg3ZnI4NlF3ZWIrWWdMbitGQzd1bVBXVUR1MndkV09J?=
 =?utf-8?B?b1JSMTM2Slp0UTEwdEE4cWcvbmcvRVd5K0lIOHNBL1dmc2NaSGloaHdrR1pq?=
 =?utf-8?B?OVBacFF4d1RKZGZOcTBaWTZNZnh1c2pKMWxUSmVZVDlYa1N5UDBsRnU3bE15?=
 =?utf-8?B?QkVKR2RXaUwwUHorTGQ0bzNQeEhXMlBOQXRpYU0zd3o0dU5OYVRFSVA2UWM4?=
 =?utf-8?B?dUc3cExVVnkvTUw0c3FNeDZQNDYxd0xlVU4ySldQOWZaeGVWcEZ0enlkTzFm?=
 =?utf-8?B?SDYzRGo0ZTRQeDBiOEFYeTk3bTlKNld6ZU9kRTZ6aVM1bkNKeHkxYStKcEo4?=
 =?utf-8?B?OWhqYWRWVVJnbG5jY2Q1bFdLRVA5V2RtVVkxKzAzc0tocEZ5ZWdWSzVsNFRs?=
 =?utf-8?B?ZTlyY3B5MzNGMEFtcXRHMWVaM1hOQUE2V0t6VUJTaXM4SVhLMHluYWg1WUYr?=
 =?utf-8?B?VGh2a2NpVk9mRGxnS1hraXFZRGRhVmhvUWxwZDBSY0hLSXNEYTR0S3pITTl4?=
 =?utf-8?B?T2NQUHR2d29CT3pRMmZqaFh1NGVyRjdzYmpFQWUwK2hzZVNsN3lIQmNBSzZj?=
 =?utf-8?B?a1FvMXl2bmRuV3BPdmtXTWFFWm5zWE01TnpsTXprZGEzMmR6dEo5RkFFeTM5?=
 =?utf-8?B?MWZLZkczQTVSK29LTm15dXRJYmtIMXI3ekRMZDVQRDR2RGxJamVtUVRzZnNa?=
 =?utf-8?B?QnBFamRwSTIzeWxvdi9DMG51MnFFeHBHaUFiYmlBQnZ5S3hMays4YVY1WXhw?=
 =?utf-8?B?NGhkVUVtU05HYmZLWnBMcWgyRHIyVGNramxXT20vcTljek56ZktoNU9kOXBV?=
 =?utf-8?B?enBiN0tGa2J2ellsLzBtd1VhZHUvVElhZFFqQU9VYVZyOU5zTTJpSG1OUGpk?=
 =?utf-8?B?dXoycFRxSTJPZE1Fdks1QWdaQ0cyOGhqV2JzNE04MWpVYmN2RFVrZUNvNnlD?=
 =?utf-8?B?OUVDNU1oemg1aDZIa29QdDRBSDBxb2dJU2R5UHppT3h6dDdIYUVvc1BFaFZR?=
 =?utf-8?B?QXJ4c1IvK3NMNnVIS1owaWhqZFE0RmJpSnQrOVY0YlNCa2JTMEdITk1ISStv?=
 =?utf-8?B?em9JWUkrajJ6VnNaU1JNK1Z2RWZtN2VTaHVSZzVUWWFPTkJGdENzYmhmbndm?=
 =?utf-8?B?Y29zck53R0wvK1MzSkZoeXRmYW50cm16VkNoZ3Z3ek1tY0VyWlRvMTdQUVBL?=
 =?utf-8?B?SVZCMzZLbm1TSWZFclFkK1I2V3ZJVXRVUkhjMEZkQ2gxYXBoMDBwZ3kxYkxv?=
 =?utf-8?B?VU9Id2VuWnVUc29jL21xdis5dzZ0T055c1pZT2w3VHU0Z24ycEZEL3BEMExB?=
 =?utf-8?B?NEpudWk1OFh1elJPN3hiRTBYY0xvRktFMC84Yy9RazhJNDFjMUJZSDJmVGU5?=
 =?utf-8?B?bkduR0dQeWg4bm03bFZudlJQREpBdE9ldVgrZ1ZnMlhObVNoU3JJN3JRaTlC?=
 =?utf-8?B?eWJWYURFTUdBYnpMZ0dDN1hha2xVTWNad0crVUtUVGw0a0hMOHQ4VE1OMlVQ?=
 =?utf-8?B?U2lXQ3duN2xteUttMUYxYU1UWGJNVHM0MG85blo3K0dUZVJucm5vUjBZTy92?=
 =?utf-8?Q?dbpwNuzYHfDtT3VGGRQ9bbYKY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IJ/gTCKbkk2kbXZ0FJSRi5qPXODbOGi6bHjHVOAIk3DLT6yuo+mcPGaqgtWFa5HuYYRh9zK4FuAn0kfGaIaA2j+CMAiTIk9obSotHPKqHsHfk8NF4HKvDX+K3TbOXEx+sd6XbOStEbDxhALRD7sV+pktXt1I26VUkbACHiakfprPlD9m9PdOV0A0j3HzgIerInfZb+ixDJ38a6JzOdGD+fOHlelKniK4B5b3wR5ZZEHMCmGWU1Rc4DXzqTiuT/QD/C2dH6EzgUMQTSv1vuSDzxiPPKZgGJ6YOst200mFvTH+uf7PuUE3/My23LDWLhZOvU/m1emurRlyM9w2YHGp6gH+z71OgGrbIGsiIa7O/4W6XsbRCjtXn/abqnAubI4RPV86Mg4IBCGyqaNxm5Ig0aOBmf0b6ihEu4fdHrXhwmuc1Kr1+cbb4ojhZ8+ILsQkf5QPhW6562B7LqAmqfbKlS5v5qHq5fQ9H8cymyghgKJWjm7Yi+rATgDbriwZCvlL5DayYI8oKJjEy3ryg9Rg59+FexpWDjT54eLBD2cSMygXCxC4dJYkjdTw4Kc7oT4ah2DmNPvZ6dZoxTBRKC+db/zSohXTBBsqa8xHAtggeNE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80685b5c-70c1-49b1-fdff-08ddb494cbf1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 09:35:32.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W93rad/PuCYfSiJFusLyCX3sZwoTAlW+SRzaVFfBmqsU8hWFlKHqjKDxmMTS/iOocCWBSHPKSLNeMMInbW9o/7MdoagLnGyLJaPe4mCtfNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_04,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506260079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA3OSBTYWx0ZWRfX2q0iMeHw7E4p mzG21EdIvpXsAjWwxlBU7Dg/Db4lwYRigekMmPnMgJbVEjBfxkz2rpvyL6UY0EUB1kEn+hO5mpG QI9H4WoqH+IQFItUNTqvJAtzLtURVig1If+lNFXLb+5+hc7Gt6X2cLYwCu/hAn40YSt+z6eFR0e
 Y1e1VhCHboNhFkKaFE6IdPns4aW6Fa1guNhN8P9kDPm28tPk7g+bNUr6YVO9qSycHkh0qkTUqH5 EYceW6Be9Sox+0kJxFOmVwcksHy0YI3CoTnMD5/7IhUuhFMCBiodVe11Z8ggYXkwVkg7ufTXC39 CypCcmeHIo8IHRDznTCXard6T8bybsLJr35qzJ4CXhciRZZDBkvHZHFOsICxLt3PY0ApVBhetb7
 5FVmjbyfpwlWfNU9Rlprll4coU1qRWN1rCxzf8707kWABQMTT6jPtSaAgrRlc6CYMMnAfEux
X-Proofpoint-GUID: _5qE63OeVxb6ztIv92UEM3yWDy-aavBr
X-Authority-Analysis: v=2.4 cv=QNpoRhLL c=1 sm=1 tr=0 ts=685d146a cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=A_dXyxYjlAxBYGtoLNYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _5qE63OeVxb6ztIv92UEM3yWDy-aavBr


On 26/06/2025 11:22, Vegard Nossum wrote:
> 
> On 25/06/2025 14:50, Kirill A. Shutemov wrote:
>> Linear Address Space Separation (LASS) is a security feature that 
>> intends to
>> prevent malicious virtual address space accesses across user/kernel mode.
> 
> I applied these patches on top of tip/master and when I try to boot it
> fails with errno 12 (ENOMEM - Cannot allocate memory):
> 
> [    1.517526] Kernel panic - not syncing: Requested init /bin/bash 
> failed (error -12).
> 
> Just using standard defconfig and booting in qemu/KVM with 2G RAM.
> 
> Bisect lands on "x86/asm: Introduce inline memcpy and memset".

I think the newly added mulq to rep_stos_alternative clobbers %rdx, at
least this patch fixed it for me:

diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
index 5cd0f18a431fe..bc096526432a1 100644
--- a/arch/x86/include/asm/string.h
+++ b/arch/x86/include/asm/string.h
@@ -28,7 +28,7 @@ static __always_inline void *__inline_memcpy(void *to, 
const void *from, size_t
                      "2:\n\t"
                      _ASM_EXTABLE_UA(1b, 2b)
                      :"+c" (len), "+D" (to), "+S" (from), 
ASM_CALL_CONSTRAINT
-                    : : "memory", _ASM_AX);
+                    : : "memory", _ASM_AX, _ASM_DX);

         return ret + len;
  }
@@ -44,7 +44,7 @@ static __always_inline void *__inline_memset(void 
*addr, int v, size_t len)
                      _ASM_EXTABLE_UA(1b, 2b)
                      : "+c" (len), "+D" (addr), ASM_CALL_CONSTRAINT
                      : "a" ((uint8_t)v)
-                    : "memory", _ASM_SI);
+                    : "memory", _ASM_SI, _ASM_DX);

         return ret + len;
  }
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index ca94828def624..77cfd75718623 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -64,6 +64,7 @@ EXPORT_SYMBOL_GPL(clear_page_erms)
   *
   * Output:
   * rcx: uncleared bytes or 0 if successful.
+ * rdx: clobbered
   */
  SYM_FUNC_START(rep_stos_alternative)
         ANNOTATE_NOENDBR

Thanks,


Vegard

