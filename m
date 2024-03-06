Return-Path: <linux-efi+bounces-742-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539F18736FE
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 13:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769891C215D5
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 12:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A412D767;
	Wed,  6 Mar 2024 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xtIKIIVC"
X-Original-To: linux-efi@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2040.outbound.protection.outlook.com [40.107.241.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75723745;
	Wed,  6 Mar 2024 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729567; cv=fail; b=TiTx9gt2jLOh1Dsa3m5jCVrdq7221Gb4LyjDAMJl+LR3FPtdGrV0qC6cdrRadamWow2kpVHrU0svU2hb4lWtaG3+s8Q8qWh56HN4/w4uttrc/M1/We7vtZd4nIXOar1Yl4oU17vXlqJb0/0f+Ldb+nXl71mUse6apmvENwR8tA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729567; c=relaxed/simple;
	bh=3UzIu7MG2OdoC7p2+adWUO5Db7g1VTClG4C/WCLLW5c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l10weS4IrUHdsZFoZhRO/s00KTxmA7XtvOBObQml+7DwWmJLJEkZjbbryG00EiWH0Fk/QF8l9qaAevUf9vjUfvdsIsygpqKfxPvpYye0ITCmMwrTmi6/m3HYP7R9g42nfX9CCfb4j9QOaxHwR5Gh1hdqz1hQhimruKohW6/mmr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xtIKIIVC; arc=fail smtp.client-ip=40.107.241.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+Xf/qwSzBqGpji149rhGbUvmYj9u1VWxWVukRqGDSmHbef6VH2YIhe+XApON/hZ+AolvAd3LtkbDJg8fv3b+diLdKfmZ3oEhpM8fpzn7pg690HyhiljdvkQE7Yt9Aa+WzXYq+AhzvUghxnAH8XynMr9F1rLfQIXvY5i46Xu0wlgyYF/VgofqRq3NfC2BfFPek/FWpWcVEIkvZCEWCsUsNmUF7AWDtzpxb6ukVLGoP3Y9kNe2dt5GhlGHgnAhyRTuTEvoBWUqYrI43uaTXxlCB/lcb/q54QMvy8R/28FuHYNe3xuGbu8RxawzDzCi+EgxyvkbSdae/GYbjEdsmmLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBwrg5iM9MolCyROI48IRiyfl0E3TNTWQA8inzQdeQU=;
 b=JAyaRNnc3HeH3C6Utr4lv7xResal6DpVkyRTIYIhM7Vp3Pd/SeMjpnw0Aj8u1L+FpC5VMLQFWwVYkWw9cd9VvvndjTLke3vTVXZG1CF8iRmePP0TZ3oCQe0izb62neCZ6Z/G45KFtBkR9RzGmdR2kOuQJZGdQik053VAGucoMf3FofE5HitoQ9aGBJNN3eLY0XT1X/ksaEGHrtc9IrurKgb3LxTnV+DUsMqK/bs8WpiAxJUOom3jztwcmX3zYwrtlK0wcFJJRPSaRutGqnmfLg9f3QF0AiMSLR9XNqNJySduzVEZotq565aqnPoCih08UyDRFVGU0Y/1ajqpGIxBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBwrg5iM9MolCyROI48IRiyfl0E3TNTWQA8inzQdeQU=;
 b=xtIKIIVCs/UJqCG2gZo7y7UYxw74594eIQSumSQFyYhQwXAAf9wsRk3QBLJeRaYtWEZxDx+GpWU+6oWMPU8q4MLg54SwEM1gNrwduK8RcbpDubL4dwrphHh3f8pfcP9rZyryrCvCvb032oZRvEoOr4J6h4CkqwrVc46FJqahabpuOlvuJGSCHalZ4Tps1nm/XAOV8BKnXszyuWrzgxapTdkdYyBGinHeWawILZ3UewK0LD3Mt5ZFeWrolDs7dusall6lw6ei5NHcnNQlsyvk8qCqjzd/yE3hpVMxPoeKYtf2wTXJlI9H0yGs3Hx/R4tK/rMVHF1koXuEpkc7Feh3Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7984.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 12:52:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 12:52:40 +0000
Message-ID: <26f3e99c-8f57-4779-a679-2085e469d9cd@siemens.com>
Date: Wed, 6 Mar 2024 13:52:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Revert "riscv/efistub: Ensure GP-relative addressing
 is not used"
Content-Language: en-US
To: Yunhui Cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, ardb@kernel.org,
 xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com,
 samitolvanen@google.com, bp@alien8.de, xiao.w.wang@intel.com,
 kirill.shutemov@linux.intel.com, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240306085622.87248-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f651963-77c2-40c5-3806-08dc3ddc4ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mjINldWc0VMLmE6yYwRXjWZJRfas3Lms5x1duXFtnrlsQuUyUAXCGD6Uwc4zrHQVvshc8VFmBFssOxNR20oLuAlwQy6PbqjCaGcEpvzHN73w34KTzMZr62qo1BBFyJON1pMLqiMiJIrZRE6cJk9jiFq61f6Mdrp9M28bZ/xL0/ybJzxpR4Fx3JTP+aEC0qytjsNaETyK5ZfDW8SkDcsen62Ljhbp2u/O+tatE3DpJtB+Q8OWHA6Q7Q6pqa0mUZBkJAkz7TfiAOp51EEssvzlUgJg1jcm79H/lPOd9u4UR9uD7jdrAoRGVQbZv+xH+zcNwN+s0HClkbg1/l6se98ESXBqQfctgrd3HdtsUjBe2RdPe88T33PtA/cRPZ4dOMgVOu2Iw8+hLmMo0UfqktP+lsSe74RoggdCixVPAsl0fQZQdqumCqtF6LBVZsKE3skFoRzYNi1NxxrOFNY5o5zLHnX4kFgP6MdFwIiAbch8136V7fmVh7cyum4oXKvHfhBqS5GbhG+H49eGNgfOzGf0PcpOUscrMdJov9yK60n6s4OAsMwmv/3bVgla5AoQ2tfhY399vNesDhBb6zzjFi8iikiARFBwwdrU0YnsdC/6iHDynRnVKNUFRsmkjWCsByLlkpEbK2YWr9f3G2tBWbLFupWBDyqFW7wltSKlkyQoPuizPTgYUU4+NqmNMwD/X9Yc332/wtdN27CvZR7HtOB4Xg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anpCa0xFcXcwUEZva21RZHg1S3V2MjlzYkYxWldpSFBvQWFrNVE2RmgycjVS?=
 =?utf-8?B?OW8wb0tsOWY4TEFQeGY0c285UXRhTnBLRzUwOHMyajdXa3QrcXYyV1lxMytK?=
 =?utf-8?B?VittT0J1K0krdWtDQ2lWQTRhZnNGbm5MYkdCeWxLVFZZbysraU4yUms0Tk8y?=
 =?utf-8?B?SUYwdFcxNWk2RktjcDFkTjRHeUJSdnJMdCtSeExBekxQZ0Q4eFVGcVB2Nmxz?=
 =?utf-8?B?UHowQkVQWDBrZDBFZ3hQaStVckVBV2pKUWRUTWF1eWwvWDJFSE1lQ3JJMWVo?=
 =?utf-8?B?T01rZkFrYW9zcm5aZkxnWmdVeEJKY2NiZGFIUTlQaWF3b1RnN3ArRm44SDdi?=
 =?utf-8?B?Z2hmVWduWkc5aWhHWG1MTGdQb3JJZmlkT0tyOTMrWS9mMkFVQnRuaGR4YzNU?=
 =?utf-8?B?dEFob2hocTRIcytLTUZvV1N5Z2kzZUxIbkRsbGkrdGxRR1RjaFpRWDRYNFg5?=
 =?utf-8?B?NGVObXRydGY3YTc4cW80Y3Q0WmZPSjhCRUx4WWxmdklWNU9JVktlRnllckhu?=
 =?utf-8?B?U0xTTE9TMEV2SW96cFRrVkVldVZIbEVGYndZUzFRSlptaFlQNzE4QnEzL2F2?=
 =?utf-8?B?QWNqdlpHeWlHdmpCdFFTL0VWd1RqMFZXNHdrQ0FJNWoxZlJkMTU3d000UTJV?=
 =?utf-8?B?UU1yTlJ0SkhIWEVxcWs2SHp6eUpuT3ptQStrQ3laODRkNzlSMHlyQzExM2ZW?=
 =?utf-8?B?NEtXQ3ZNeW5zdFpraEpmSXNGVDR3TzV0aVR0Yk5Xb3o1YThjeno3MCtMazk1?=
 =?utf-8?B?azdoZWdaZ1JjSElMQUo2ZlNPTkgrRTRDazRMMVNmRDNZNUlxQWhpQXpWYlU1?=
 =?utf-8?B?M1JhVWpNYXJQZzVFL2JxcXhMeWRqbVgyeUNnbVRTMzhqRWEwSGJjREI4OEZz?=
 =?utf-8?B?Qy8yRWY5aFkyNHlGOENKdWJlN2t1LytLTkdxSVZibWxtYkYyZ1pobkFkaVpZ?=
 =?utf-8?B?eG8rZ0RLa1hyUlg3V2xQZnhBejBBaTgzelkwZVpJcTNTNVlLMWVPS3Z0VXpY?=
 =?utf-8?B?V0pvOUlDQVdyNHozdGZMbGlNTXI5WkJhbDFvbk45RzRISkpTQ2VyTGU0RmEr?=
 =?utf-8?B?N25jZHgyVlg0am1UL25aakVQTUw5VkUzbEU4SEZWMDJsSXVUOWNzUk8vWk1H?=
 =?utf-8?B?N21IMi8rVFh3eVlHaU1zdFFBNzZIcVJISFplU0hFSkg3LzFveVVqMXdHVVlO?=
 =?utf-8?B?MDNFWVM2anFlcWcyVExYcEx5S0JoeXM0VlN5TmFQZ3p4UmxPL2NZUWtkT282?=
 =?utf-8?B?MWxOTTYwUHo4bjA5UzRXRDFvd1NXLytlVElOZDYzSzlGTFhheXBSTUoxbWVv?=
 =?utf-8?B?bHQya3FRMnQ5bDBnU1RlUUZYclJyUjVTNGlUT2U3K0xISnRqMGhydzNpZGt4?=
 =?utf-8?B?QjVsZjdDdUFSWTRvMjVlcFJvN0ZmRjQ1VEliNnloTmlsS1pPbDNyZmdKMm5y?=
 =?utf-8?B?OXUrbVFkV3NXa3pTOXY1UEhRdUxtMWNPYS9kbFpZL0N2S1E1UW1NSTZaQWpC?=
 =?utf-8?B?ZHFpYlZlZzVZbWRDcnRuQmQyQTV5Q2w1RWhVV0Z5ZVdiYUNVak1SUXAzdkVi?=
 =?utf-8?B?emIrNDJqNENyaTlOUFBOTnVvc0pYei8rbnlwZ0lNUlpDaEZBQVdaREROQUt5?=
 =?utf-8?B?NE1uemRjSmhDdXRjOXpNdTN1NzBNbWlvbkZqc0RqbWZ0VGRIWTlMdWRFSk1k?=
 =?utf-8?B?cnUxTzJaTFhZQVl6UU53OFc4QlFWaVZBV0M2WXlHVjhIVTdLTW1URU82MHhX?=
 =?utf-8?B?anpFYXpLKzNoeTlQSTN1dzU1anBVcXpZUXlVbzlwWDVPWit0dUdZQlBNOUZ2?=
 =?utf-8?B?ZlpDZjRoZjYwVGlVM2pmWUpZLzRBd2IzdW5BbGhkaTdjTnVKWmxmRm9rTDhN?=
 =?utf-8?B?bnpyazhnSFdjOWU3aUdyVWU5MUtJY3F2YUQzZnFYWlZvdE5iQi9VS2FuRWRq?=
 =?utf-8?B?OUlQRGlPSUkvQjRqM2NCczgxQngyb1VIenJRWHlqcGVhWWpWRFMrcjdXWEY4?=
 =?utf-8?B?YklTNUZaYklNWU9yRWJ0cFRWU3B2YlZYSXUrUDdEbmFiNHMwTUVlbmdoaUth?=
 =?utf-8?B?VExSMkJjOC92WDVaUUl5RG5ueGUxMm1ZNVB2djJIWXFBZW9GblVGNmltQWdo?=
 =?utf-8?B?Z2JFazhwN0tQQzZleWRsMmN3YlJERkdsRlpMZmhCOVRablRoZ2dwNjAxVFAx?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f651963-77c2-40c5-3806-08dc3ddc4ee4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:52:40.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hngz/CazQwvMNzzYoEBKRF5Yk37natODlOuw3Ph2S/Qnt6uwP6aFcpCwlzv8CwDToqNjdjdoBdxUCqVob8/pMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7984

On 06.03.24 09:56, Yunhui Cui wrote:
> This reverts commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5.
> 

This comes without a reason - which is likely something around "will fix
this properly later". But then you regress first and only fix
afterwards. Can't that be done the other way around?

Jan

> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 31eb1e287ce1..475f37796779 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
>  				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>  				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>  				   $(call cc-option,-mno-single-pic-base)
> -cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax
> +cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE
>  cflags-$(CONFIG_LOONGARCH)	+= -fpie
>  
>  cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt

-- 
Siemens AG, Technology
Linux Expert Center


