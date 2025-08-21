Return-Path: <linux-efi+bounces-4583-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742D1B2F94E
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 15:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC8BAC749F
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B752B32254A;
	Thu, 21 Aug 2025 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="N+ofnowf"
X-Original-To: linux-efi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7393218C9;
	Thu, 21 Aug 2025 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781032; cv=fail; b=T3/6tqmmJFtFUWf6iERlrApSvF98zXwH9z3MpHXotjojfGrdjpdtO/z6IGj2JtEaomXLHmNEoTkRq01ZWijwD3yZa4i5xQBGeUYasls+P4KxyPU5oCKnRBSbJ6yNST52AhuWNDv2kNTKvAodEiD8HRm+scZNdOVl2Swe4d8vsJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781032; c=relaxed/simple;
	bh=kD4I0f7AJRI74s8sVQ1JGKUM8FSpX7FLwmFiPeE91IE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zpv9dyno2YC/77tI3NNFtXuKL7mB4Snr2j5mxTKUjW5QotdL229tpZtigkRmWcf4MJbPpo6IuG+cZtSE8J94C7f1tiZuIzzZEPpUVdfmHG7xXt6c9sYUImqtdIe6rWUIYh+v9rF0sZq5G1Rqe7aiXZapohvuTJ8nf0YxaFglpkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=N+ofnowf; arc=fail smtp.client-ip=52.101.72.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4nFQjyj8o/GW6oNtYRHxE2BIoBR0y5yN5XCJ2zN6wypwmxA7gSP9eVv1Wc6zPXGjas4Qg9e8Y+7PnAnMThLtPL2yKyhsWRma13ee7U0HJkLb2BaqpgzU79wR/4aMe90uUtCmuoajWpwH1TN3BnT1FX6R1Hj5nn0KvxK5PQmY7/gYo9qrX+1Fu5cJPdS9j3ix5sNuPCPbaN62hA2j547eWpeqvtefVtv+i/Ht0Zse1JyD5Lc65uu65lFaGb+rOVEdWK5pJ+2wnyrPXHsKtH6vpz7I+TQMQVQBTUFtPGzIRMc03ngg174iNuvJOEUHGU/wydqvjuNdLBuEEydFlPk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiLabV+Yu4ghIjRE4X4UOagqtztMeIP89jvGxsW91qg=;
 b=b1GM/QFVXMiOU0Ulyx+lnEEPYQG582p2zGuYrf79MIgo2j834YsPyX+AV96BcHDDgL6KCCstkIjwAmxd+7DFvprwjYB0ko0DtvTjfzPwZlrxnfbmEBjQE0U0EaYQ1id4eUAE31tzsedWHj2FPJJxx0DWfL606TbBaRqxmAh75AFkhgQuu4XawK5vshwekJ2q9oZ5LM/VAkHb4ycXmKNs/G70SMyBAvbUBk6PGeJ39WyCV9e6WQwW0XU4QDwFWUrVH3s9grH7jknzynIMZkXfvgep6Q0ZguhlW2Rf3jSku+Fv4pPeqnbaD2dQDz3j3orDevBbuDHlQ82vHLESNnkHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiLabV+Yu4ghIjRE4X4UOagqtztMeIP89jvGxsW91qg=;
 b=N+ofnowfWb6jVFjoYVSSOf77D5vXEemBWWcwTH6WPb87t7jJTGXNFddaGsa63SZp9IFbLAKqhQhdp6T9GqJpgWgVJJk3KSJWN2AL1toUv8sFk7N5Sf5AAdK5ADGMR7u0kEXv4oAE8/e3RAHSRrI1vC86zIrp3UtDZOT+6r31Pk/w9yt+xKipnPGYbZ0iOSQ2oIK4rRqSbFIZoCJnJ34VR8xZPan+6C5bApZWEadPtH8oqUlgtUSxsA7UGRHSQxxnCZkBDUQ3uvJWzcYCB56l4pNaUd+KoorPuVjElTqAijZPlNYbc8A/uT/6t9VyyK1oYO/4VjrotnsfR35/HixTHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PRAPR10MB5202.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 12:57:06 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 12:57:05 +0000
Message-ID: <2acfbc7b-5222-425b-a1f7-83fc47148920@siemens.com>
Date: Thu, 21 Aug 2025 14:56:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] efi: stmm: Fix incorrect buffer allocation method
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jens Wiklander <jens.wiklander@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
References: <cover.1755285161.git.jan.kiszka@siemens.com>
 <37ba67b97d55c49a7c6a1597f104b30b31a4a395.1755285161.git.jan.kiszka@siemens.com>
 <CAC_iWjL84EFiKh0ETb7LwYjMRgLAZA8hFKy-YDS4=YQ1LRwg9A@mail.gmail.com>
 <75db5f5e-9e0c-4c48-a3c8-034414276036@siemens.com>
 <aKboY9oBmHJJb2Pc@sumit-X1>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aKboY9oBmHJJb2Pc@sumit-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::18) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PRAPR10MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f85687-bed4-4785-458f-08dde0b23afe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnJZQWllRTJCUFVWdzFRcGRkQ1VZblpPblMxcDMwVzc2U09zdzNMSzhiYXZ6?=
 =?utf-8?B?eis3eUV3a014dFI4bE9PcFpPQ3U2Wkd6QTd0cTA4bUtzTXd3d2RCNlFNUWFB?=
 =?utf-8?B?T2lGYms1RUsvSWJtYzA1dGZJaWFTNm1CaEZjMWI0a29tNUhWSDY2dldDVzRD?=
 =?utf-8?B?TzNZMFVRUnZLUU1EdG9WTGs3Y2I1M2lsRmJzSEdKTFhScHBENUc2ZFd3OUdo?=
 =?utf-8?B?bWwvY3FVNW5CL1JTN3R0SU4ybmxIRFI5bCtZODYwSGhrTDEzamFMb3ZGWWxU?=
 =?utf-8?B?NVhHL21mN1lrODlkZExhcjBxc3laNXl4OXh2SVZQRmRCeTlxSTNISERFVU43?=
 =?utf-8?B?dDNDckhPR0pTbDgvekxINUx4ZWJGSE5FQ21BMTY3LzR2YmRROVdvLzV3eVA4?=
 =?utf-8?B?eVV1ZzFlaXVFWkdIOUtOK2drQlEya3FDd1NWTSt1Zk1Ra295a2xqT3RZdTRN?=
 =?utf-8?B?Tk1id203dGFuSG5CWVF0VS9EWkwzQUp6cDNtbGJudGJ6Z2dGMHZYSTRYVHBT?=
 =?utf-8?B?QXlPZmZ3RGlVMVZHT3YyNTA4K1RVWTRQOWNDSE9yUEgvckE2MzFuYkJQQ2Nx?=
 =?utf-8?B?cGxnV2lxNHZZM0xtU3owellYcmFoOWlVTnNqRUswa2JhSnVHK2NUbVFVMHdi?=
 =?utf-8?B?SndLekF4OVA2MjM4aGJ2cGRUeXFsUkd0elVFWC8zQnQwY3RHYmxkZTkzVEVE?=
 =?utf-8?B?MEl5ZWZXQU55SE9Qdk5zZkUrNk54alRGQldKZ1dnYmpJUlZEWVpzNnBhdDgz?=
 =?utf-8?B?OGdBWXQwWE8yMWVRV1gwM0lsZlI5UXlpaWpaVG1MRVMvTHdBMVc0NkdTQlor?=
 =?utf-8?B?alFlUmplRVVjQkwzV0V5NVFqRU4wYmc1TlQ5dXlIYjRJcVVuS05MNUJxU3hB?=
 =?utf-8?B?QnJyNjdxZlVDV2Fpek1Jc0RoY2RRcWZ5K04yLzIxMWZIVEFFK3BaajhqUXR0?=
 =?utf-8?B?REw1amhJbFhwdVFMRktLRXlXdFJ0YTRHQmJtaDVuVnFnNUZlOVo4U2haaXp2?=
 =?utf-8?B?TUNQKzk4SHFJOFp2aVoycktieVZMMjZzZFU0S21nSWhtcU5ESkczNVFiejY3?=
 =?utf-8?B?NlhldnUva2M0ellhSzgrZ0xUQjVhbks2REJqakNtc29qbU0wV1NoSTBuajVa?=
 =?utf-8?B?cVdaT2cvbUN1TE92bWJjNlkrRDFFRTR2NU9kV0I0L21iRFBxdkllKzYvSXEy?=
 =?utf-8?B?T0RoSFNNalJoblg0TXU2TXhZbDJEQ2l2UzF5d3gyQkcrVUJzTmZkTGtQWU9r?=
 =?utf-8?B?NE41aS9hakEzYVVYcWhDaWRac2hQa2xta2dkSkdQTXc0eVQ1YkxUVHFpNTZk?=
 =?utf-8?B?OEFLTnBOYzZjUGlzbUgrZ05EaU5xdnlFeE1vcDcxU2FzZGdVaVZIWld6QUFP?=
 =?utf-8?B?bFE0QlNBdG9URnpLRTVkTUZIVXIzL21FMFpVWEhnMk5RSzVMWmZGMGtTdU9t?=
 =?utf-8?B?ckFxTnJrdkx1NjlYN29qL2krajBFTkQreEtUODZMeExXWDZHV1J6YS9DaEp4?=
 =?utf-8?B?VmxjQmV4RjM1RHU4R0tVZ05ZZzZwU2oyMzlHc0FQRWJDN2V5cy9acTJIbzA0?=
 =?utf-8?B?Q0RTaXh2TjRITkI0emJGbVgxYzRrSE9PWmxSZ1NwSFRNRmJhbVpDby85Q2Js?=
 =?utf-8?B?NnVBazlNSkgzNytpclFySlFVenppREpzUDhEd3I0RUJvMXNibTZvQzMxMzVz?=
 =?utf-8?B?UytBWkdIVHpIdHBoNmR3YVNZa1laRXVmU3V6NTNnRFhSMENkQW5tVGprYzBM?=
 =?utf-8?B?eFF4MGlhT05pRHlNVnFSMmxaNC9xbGR4WWNzcnAvcHNtdVdsdG01SVBlcmZR?=
 =?utf-8?B?aDcxSzhhTU5YemFoQTdOQ3dGL0JEdzZDVERDSzM1c29tMUUxL0IxMTdvQXV0?=
 =?utf-8?B?M0M3T3JQYnRlQ2VPTDgySnVjdjh3dWQ4a1NyTnFoQ2tQV3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVJ3aXZsbEx0S1FXUjc4U25USFVaYU9jcnR3M1ZZZXN3ZWZlNVhjM3hsMEtv?=
 =?utf-8?B?WDl6SXAyWWlITjZ6MWpxeEZEbWxxYUVjaGdGNkIvcFQ3c3VaVmk1ZW9NSlN4?=
 =?utf-8?B?T1FCajJhMTNiZXhwRGlzMzQ4RDNBblkyQkh5Q01EUkN5aGlhMFlPcXpSMDRp?=
 =?utf-8?B?T2dzY3VDcm1Ya1BiZnBNN2lNZXNMbDhYMCs2VlVMTHU4STg4K0Z2UCtIK2tn?=
 =?utf-8?B?c25KbHRmbG5UdGE4N29CeGp5NXBmVnVhVmVzM2NtSGZneTROTHBiZ3ZHKzBp?=
 =?utf-8?B?enJvN1FKcUh3YVNxMThWVDRnR0RYd1U4eWJmMzBmWGduVldwZXIyNURrdU5l?=
 =?utf-8?B?STZFNTF1T1NTYW9EZFdXTldkVUxwV2g0YUx1TG03VHdyakVYUW5JMEE4R0RX?=
 =?utf-8?B?a1hvMWJ3S1BlWjlKVlhQOEk3djBIT2FVazd3TmVIU2ZMV0FGeHlaanJTZ0Nt?=
 =?utf-8?B?aUFOTXBKU1VWc29uWE1JZEJpYkV3N0x6NVhGd0Q5cFFZR1V0YjY4TE1ncy81?=
 =?utf-8?B?NGhTWWZ2T0xLbXlaWDluRFNQRnl0dFB2VDhGVmxQdUJMWEtKazVCQlF6N1lN?=
 =?utf-8?B?ZWEvWjVYVnpUOW1rSFNTQW5Gb3VYU0hXdmVNd0xsM24ybDBpNFNka2lJRmR1?=
 =?utf-8?B?Z2hxWG9xc0ZKcWFVbXI4bE1oVXZ1MHhkdkJlcFRqR2w3M1kyMUFKRVlTbDls?=
 =?utf-8?B?SWtsTDl3d1pLb040cTNpbmZTSjhhWlBQR0toaUhqaENDb2F1V2kwVHM3K0d1?=
 =?utf-8?B?MFdqRnkyV1FCNDRORnRyWkIySDc3RVJWVHE1NjQ0Q0cwdS9ZVTEreXpNZjdw?=
 =?utf-8?B?d2ROQWFscTRELy8vTWhwUmc2L3lESnF5RytTV0hBRG9OU0dOZS9lQVhvWXJa?=
 =?utf-8?B?NlFpNnhHSHlxVmVpRlpwRGdvS1lCVjJvZGJ4Y0Z4eSthcFJSVFRhL3VSK3F3?=
 =?utf-8?B?VUlRTWs3RFJ5anZCRVlGbXBxa3BQVHo0NnhJRzh0TVhvRloyaGRvTjRoYW9O?=
 =?utf-8?B?RzJsaEM4Vkg4bHJTdElvZTZjSlVscGlLMjA0WnBnRjFpNGFnSjVsWEZNL1pF?=
 =?utf-8?B?WkEvYnFQM1JkOGI1Znk3dTltSEZKZnkveCt3TU9SdUJaMVYwZFdQbVNDUW1C?=
 =?utf-8?B?KzM5dUFjMEk5V0REazFmbmU4UjE1NzE3YlRqOXR6MTBOS2F5YU8vMjlhb2U2?=
 =?utf-8?B?ODRvWlRsTW1JaThQa2lFcFdQZ1hKbnZMd1RSUktMVm1ET2xJamtQM2xSYTJV?=
 =?utf-8?B?elVWYW1YTDZlRFAybDAyUXZ1d3JmSU5NaVhCMklVNXlobnBzTmtRZzMwMmc3?=
 =?utf-8?B?OUFkOEhIcWlhUHB0akpDVks5ZEkxdnFvWjE1Q1JkZUpZZVowcHVzWDdUQkEy?=
 =?utf-8?B?aGphK3J2eDBsa1BiK2F4Y2Ftd0d4ejhMOEpWYmhhUFdlSERBTlVoRkF1a0VZ?=
 =?utf-8?B?QkNVZ242b0MyVElmQ1NzbEZVak5QaEovRUVtaWV4Sm0wUVBMbHIza0ovWjQ0?=
 =?utf-8?B?WDNDSzF1MEhWMmdWN3djTFZuckx0WmlzUEI1WEdON2FDMWdtU1BKWUJJSWpX?=
 =?utf-8?B?Z2l1WDZhMGVqR1cwOUVlajJma1JFSnlOQ0NpalA2YlNWQ3JCcE1pd1B1Vk00?=
 =?utf-8?B?blhyNGptMzNpYUtNaVBUMGM3QTJxN2htSmczUEJDMVZJcnRuWWlEVHMySVJ0?=
 =?utf-8?B?SjlMMTdmVktEd2xKc2Rmek0vdmcxN2RMVGlHMExUbWsvQnNZdWJtQWljV0JV?=
 =?utf-8?B?U1pQNmlkdURpakprb3BGUmpNWVR4bEh4VlEwSXAxeXpCeDJXYWVTZTJJSU16?=
 =?utf-8?B?NUl3YWNkc0wxdm5KNExJWFdBbDNJUlRnK2QvLytQKzVmRk1Pdk1tNU9jZlZL?=
 =?utf-8?B?MGR6VlYzaGVXSTB6VHdoVGFMRm50L2V4WDhMUU11cTVFUm1qZzNJanhRQ3Rq?=
 =?utf-8?B?L2sybCtMSjFyWmptUi8yenhqaC94YkUyMGJLaDRlQWVwNnNrT1RoNEhNbFh2?=
 =?utf-8?B?MkUxa2R0MVFsSEFJTWpTaldzVXZZbGVNeVp2WXBXamhmM2tSQmRLYit5cWlY?=
 =?utf-8?B?emxuMEgyK2diWm9OMENuNWtKTytNQ2ZPVjcwamRzOTBjUEw3bHl5RkZza2FL?=
 =?utf-8?B?WU5Ebmg3eVVidEJFUUJyOFZXWDRmMmlueXZ5aU9zZVUyajNndXNPd1k5ZFlI?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f85687-bed4-4785-458f-08dde0b23afe
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 12:57:05.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yait5tVQCSSVGJPgsNnIu56q5CG5XwXvsSXbKqLFCxhrYRf3yHPZcSutwMISAHttREnDnaTVZUcETSzjTH2gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5202

On 21.08.25 11:35, Sumit Garg wrote:
> Hi Jan,
> 
> On Wed, Aug 20, 2025 at 05:05:43PM +0200, Jan Kiszka wrote:
>> On 20.08.25 09:29, Ilias Apalodimas wrote:
>>> (++cc Sumit and Kojima-san on their updated emails)
>>>
>>> On Fri, 15 Aug 2025 at 22:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> The communication buffer allocated by setup_mm_hdr is later on passed to
>>>> tee_shm_register_kernel_buf. The latter expects those buffers to be
>>>> contiguous pages, but setup_mm_hdr just uses kmalloc. That can cause
>>>> various corruptions or BUGs, specifically since 9aec2fb0fd5e, though it
>>>> was broken before as well.
>>>>
>>>> Fix this by using alloc_pages_exact instead of kmalloc.
>>>>
>>>> Fixes: c44b6be62e8d ("efi: Add tee-based EFI variable driver")
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>
>>> [...]
>>>
>>>>         const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
>>>>         struct efi_mm_communicate_header *mm_hdr;
>>>> @@ -173,9 +174,12 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
>>>>                 return NULL;
>>>>         }
>>>>
>>>> -       comm_buf = kzalloc(MM_COMMUNICATE_HEADER_SIZE +
>>>> -                                  MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
>>>> -                          GFP_KERNEL);
>>>> +       *nr_pages = roundup(MM_COMMUNICATE_HEADER_SIZE +
>>>> +                           MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
>>>> +                           PAGE_SIZE) / PAGE_SIZE;
>>>> +
>>>> +       comm_buf = alloc_pages_exact(*nr_pages * PAGE_SIZE,
>>>> +                                    GFP_KERNEL | __GFP_ZERO);
>>>
>>> Rename nr_pages to something else and skip division, multiplying.
>>> Unless there's a reason I am missing?
>>> Also doesn't alloc_pages_exact() already rounds things up?
>>
>> I was looking at tee_dyn_shm_alloc_helper and the dance it does to
>> calculate the pages from the size parameter.
> 
> The rework of tee_shm_register_kernel_buf() is directly accept kernel
> pages instead of buffer pointers is already due. If you are willing to
> fix existing TEE client drivers and the API then I will be happy to
> review them.

I'm currently testing the stmm quite a bit but I have no setup/use case
for the trusted_tee so far. Testing is eating most of the time,
specifically with these seriously complex firmware security stacks.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

