Return-Path: <linux-efi+bounces-409-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C51BA82E92A
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 06:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ABF3B2159F
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 05:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FEB8820;
	Tue, 16 Jan 2024 05:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Xi/bOS7N"
X-Original-To: linux-efi@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182B848D;
	Tue, 16 Jan 2024 05:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaoEU9+XEhRAWhbQndt2EvbfCNMu90od9/LaAGJrm8jog+FnM4ANRZS7onG+UXDD+ojIjRPVrQv2/c5fkDAfx5lhExqrg33/2sZwdtNGZKAUiRrUzq4RKl7nMQrqkGZpk0DC4g+DdOqAh8fW1Czm39ulevMve5wI+kBxTsgprVM0/+CVl0w8YhQd3mVdScoAKihS9/HzZxGunT94c2t0nlYWETtsT2UmlBy7HBK72ibbOCpFjh0zY6IAMX8qH6+AdJD8mDy0OMcSOQ68BKEpJ1vqkt0wr6XDrVAYUmlvLVEYdkqQ/QT+/3ReEIw64BO/93GTfM5FBpe2l9Mp7LL3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM5EiZ218p5ZKoF4Yw+8FbuM2XLJ5L0Vwx6aU6mrrMU=;
 b=GHVVIE+El4RpLprn5EKyRmKYvp6lsvENBoFfbT0ZAbOTwFZpDu3R7ygOrQX4Eu7cc3j4ZEZIDnip4MBOuofGDtiVbRre92z/php1D6khvKmsqsLR/koQBgiTqW5FQ9g9AvtOD531Bk0/az17tbS63P18fE/qXZuRlJRY3cix5omb+AYAH8t6B38yyU4r7aF9N+uUAXLlCPzfg/kq8/xo44kgTtBTL+uGsQtSkVbAMkFwllYYsz30Xq4ri/FdL10DoXIP5Ue9pk6pW6bLsEuJYiyEFWRHMl/NgVaZKZU7wStkZukGx+/r84aQTJMHH9HMNAhUYJHhX7ITxQrzaAO8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM5EiZ218p5ZKoF4Yw+8FbuM2XLJ5L0Vwx6aU6mrrMU=;
 b=Xi/bOS7Nf4XpZvWP5L+kBMxY07F8kd0B7si2zfseeEw9PukbMvUn5+6kP4h1d6MRUt2/4HGdrjaaMayyS86zmhX9VMhLs3DpzFRq3Bjrw4nhuHz8Y4yJut3dpiTasSvWOLf7JtCuhO7OPAyaAlg1T7cGingz3wsZQL5Er/7ztubQFFADSXt/VGuRkSBQmeHSp1AziXixXZP4w3G+4fKj7UCIQeHWejTcrFVx7/WVZ4SoLTd1cCSK1z3xadC45caXaHm/qlsFewTHm9h1DQLfE9Y6EmxJtFCueTFZ2kRCgPLO4pheLOxLOQjof32hohIqwPXRhHxKCGMUkJSmGQKgDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5601.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:478::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Tue, 16 Jan
 2024 05:21:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 05:21:39 +0000
Message-ID: <578aae7c-4069-4071-ba4b-cc86d3b516c1@siemens.com>
Date: Tue, 16 Jan 2024 06:21:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv/efistub: Ensure GP-relative addressing is not used
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <mhng-8a4a5f85-faf9-405c-95a0-78cd04ec6509@palmer-ri-x1c9>
 <56b52d4e-9dc0-400c-a141-7e70f5c72afa@siemens.com>
 <CAMj1kXGR1aQdvej+0drfim-ZP27ZhO9UR_i_PT6F+hsV0UvbJw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAMj1kXGR1aQdvej+0drfim-ZP27ZhO9UR_i_PT6F+hsV0UvbJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: fbad8732-8d3f-4acb-3db7-08dc1653047d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WSRTu3UvDO7JFWVyrkfcne2RxoaKc2VrqDPWyaN6gHWJZ2koLv9wz+CIJLrzx50swY5XlpBVWQtKJcwL+BjJ51GbZOrUTaYhkGJ6HM8I/H3ShLh68RqtlTRJi93B3Ayw38IjGHaNSdbo20hklkOARizPQruXqkefY3uxGqYlfYhjiBPGCNeT6Buekwl376Qp4D8g73qoN4I5+9kgfTgkG7AyIRFAkH5Nf6vDUEktYhhtdcsHxBjcaQDW7LIFc2sO0CxJGRhv5q7QlKXvXZhsnnSMeKMKmvyZdH46aaMWDWrENdR77Z2J9EFX9zPspLhBD5+XYCj0hSIreCr4T/mMEKRdrrZG1PFB/tvrBj33u3aDRW9g9mSAQKFFWsGoSZR4D9G+VPXpCxlGcr4rjeuo4dNWVN2E3fQG8GdEioHvvnf8LCxfQ+CtK4qvJWKdCe7gKGA8TnSyjDOgQw0xFTmg9xkz8RFuWERZGCrUSMe4rYYBHhnfQQ6EpTqxkaS19duAlk8qz2l7lUp6x6MYcFRJ+GQRUWB3wmIwfLiAdz1VWM+aKsUg4GnlqEJZ3PLIt9niThvFFzbZ6ZzENpPAXpagQ+HxK92oPdt9ynM4Yi3zNp+BqsPeg0PaMRVIox5pFWI6okL8+vzobB7EBKLOcELG5Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(38100700002)(83380400001)(36756003)(31696002)(86362001)(82960400001)(44832011)(66946007)(316002)(66476007)(66556008)(6916009)(2906002)(8936002)(8676002)(4326008)(5660300002)(2616005)(26005)(6486002)(53546011)(6506007)(6512007)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk5jVmRXZ3crZkQrY2h1TEpVamxHcTdFTUYwbUEvUzV3SWhKcXBPMis4Y2dq?=
 =?utf-8?B?cENxVmY0SllTMEY2bjc3RElNdWxaWUNsWER1Y254Zk1YV3hLU1dHczFNalVs?=
 =?utf-8?B?TnZQVUk0MzVTNnVBQUtoUncyNG12TmRlZEZPMldvSHJNeWJkR1QxM0hldWpt?=
 =?utf-8?B?UDVDZmw1UkRCWGh3SCtZOHFiQW9jamN4V0w0SnRwNTUxZm5yVWZ1bnNGZ05w?=
 =?utf-8?B?Ylh4MGl5dmtaVmRQbjNRcDQzamxEMk5TWjRqMnVxc2tJSERyYkQrcHJCbXM4?=
 =?utf-8?B?ZDJKR1hxNUFEYW5GbmRCOVBpVUJ5YjE1ZjIrUGdBY2FHOENiWDAvajlHdGEv?=
 =?utf-8?B?UlVwMXkyTmx1OGRrRDdXMzV0ZmZ4YStqZjl2am1oTHJ0R3I2S09ZS3hFa2Qw?=
 =?utf-8?B?MTJKZXIrNThCMXNmYUM3Yk1ZbUNOdVIzOGlSNG9FRE8wRmRYYmNKV3kyTlpo?=
 =?utf-8?B?K1hpbG5TYXJqVnJGVDdaZGljWmlSOVA1RFFIZ0FXd3BXTWdjUjh3dkwxL2Rs?=
 =?utf-8?B?ckZrc055RDF2NitXQndGSW5QRUhseGRJQ3FpY0lwamZuODNSWGlpQk5WN0Vj?=
 =?utf-8?B?SitTRWVoa2p2eGlHMFRER2doK0htMVJKQkVTVHhtVFFTQ0VESjNxVDZOeXJG?=
 =?utf-8?B?S3hsZmpQZmpYR0NFa3Z4SzFzcThCZGNaeW9oTnZzdVZ6eUlrdGZ0S3BOS3R0?=
 =?utf-8?B?SmpQSTNMV3o3L3hMYzJxampmdVhQU0xCaDBZckhaRkd5d20zSElRL2lzYlNa?=
 =?utf-8?B?a1FKeWpSSEZpL3FLNFhQbVJ5aHBvRk85aHoxQUdiUUh0dndNSHEvY09xMCth?=
 =?utf-8?B?NCt2RWVJRnFHM3hqU2lYcXkzREtwd2E4d3NIeFllWFJWS1ZGUFZDSkdpRWN6?=
 =?utf-8?B?NHhCcFpnTjU2OWlKWURLR05LWjZwcTVUckR5NC9XWm5xS0tDSm14VEo5c201?=
 =?utf-8?B?K05UdlV1M3BDeEtEbURpTG05N2hpWHVBaFcwblJpL0dqUUwxODlZa25QMSs0?=
 =?utf-8?B?Ry9CYVJKNXpnVWRYbjlzdFE1RU5OQUQzd3NKRmxyakxLamFIYWxNeldDMk16?=
 =?utf-8?B?eGthYm9VWnBTQ2Z5a09DSEV4T3U3S0QrK1Q2T3pMbm1JYmFEaFVpcnVaQzgw?=
 =?utf-8?B?ekxrRHFyMkg4dTVKdXZFMi92aUViN1VxSHBDNGJ2NzFEK1ZHSk80UEFHT1g5?=
 =?utf-8?B?Q214KzdaYkI1NVp3elViTGZDTWZvbDVUdkN1c2J6Y3Y2bTVFcUcySmR2QTNR?=
 =?utf-8?B?Z2NGR0Y0QUpNa0Ywb0l1UENhYUtqZmRubEpOR1lWZkoveGo4M3A2dnRTNVNP?=
 =?utf-8?B?SDFpUFlMbU0yRGtBdHgrRG43MTc2K0JudEk3ak1RTkI4dkRZUHFKa2NOSW9p?=
 =?utf-8?B?QW9xRUV4bk9zTVk5V2c4UDRoQjZEZlVvU253Q0VqZ0VjSnBiY3RxdEcwNloz?=
 =?utf-8?B?bXI1Q0wvOVBiRm1wbXdCanRKK0ZEb1YrQm9KRmxlZTdINnErN0lOeVFFb3RD?=
 =?utf-8?B?akJOTVlkYXcvM1BqODJaR0JaZ3FjbmsxR1BHNUhNbXdZUzVxUVppY0lYUVBB?=
 =?utf-8?B?ajlOOGRBYnR2b29Lb2c1UlpaUGtRdEYyUXEyaklwbDZOelZuTFhEWDZjZmxE?=
 =?utf-8?B?TnVWS2t1dFc1SEE1aTA3S0RMNGpKSXZnbXNadWtlN0lGYWZodWdXYitmOXVS?=
 =?utf-8?B?bm5hNTdtMEhxaWppaDhhVC9paFVkY2NUczllUStzc2lZTVQ4R216bWNJcXMw?=
 =?utf-8?B?M1lnRlRBby94MlRaUzBMeGg4SklmbGI0OVk0QTlIZ3NwejMwUExIMWZpNVBP?=
 =?utf-8?B?a3M1SzJCRmR4bkZoWVh0K2dET0pQT3dsV3RKYVZSOGJoUFBhbXhiVzBRazZv?=
 =?utf-8?B?RzVNdEhEcytPa2xUM05IU3pvUzlJSmNiRjVKbENzbHZGeXBsTGgzTndTMEJs?=
 =?utf-8?B?TlpmVnRtWmJXem5XUm9OVUw1amRldEZqcGRCRWZyMlluQk5FWWNPam1yckdI?=
 =?utf-8?B?cTh3QlVINW1aeWtBQko5QjRQRCsvY2lIbnVBUExDZS82UG1BRkdFUjFmb3Fz?=
 =?utf-8?B?Q21odHpZbWJXM1g4TnExSnFVTXdYZmtsRWVZaUJ6RERVdHRPTEEyWFZIMXp1?=
 =?utf-8?B?ZE1hTnBFOWxYTEwxU293UWtORVV1VUlrWFFINmNOTVVyZlRGSXI5RGluSzd2?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbad8732-8d3f-4acb-3db7-08dc1653047d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 05:21:39.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IImCW02sKuqIvIGcfthuDZTUfmTWeXJSVIN+9u5pII5+WDUfpE1hQdkwye4+Q1UdlJ6BM62U4hXeX84rqP9QMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5601

On 15.01.24 18:34, Ard Biesheuvel wrote:
> On Sat, 13 Jan 2024 at 11:35, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 12.01.24 19:56, Palmer Dabbelt wrote:
>>> On Fri, 12 Jan 2024 10:51:16 PST (-0800), Ard Biesheuvel wrote:
>>>> Hi Jan,
>>>>
>>>> On Fri, 12 Jan 2024 at 19:37, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> The cflags for the RISC-V efistub were missing -mno-relax, thus were
>>>>> under the risk that the compiler could use GP-relative addressing. That
>>>>> happened for _edata with binutils-2.41 and kernel 6.1, causing the
>>>>> relocation to fail due to an invalid kernel_size in handle_kernel_image.
>>>>> It was not yet observed with newer versions, but that may just be luck.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>
>>>>> Something like this should go to stable as well, but we will need
>>>>> rebased patches.
>>>>>
>>>>>  drivers/firmware/efi/libstub/Makefile | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/firmware/efi/libstub/Makefile
>>>>> b/drivers/firmware/efi/libstub/Makefile
>>>>> index 06964a3c130f..d561d7de46a9 100644
>>>>> --- a/drivers/firmware/efi/libstub/Makefile
>>>>> +++ b/drivers/firmware/efi/libstub/Makefile
>>>>> @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)          += -DEFI_HAVE_STRLEN
>>>>> -DEFI_HAVE_STRNLEN \
>>>>>                                    -DEFI_HAVE_MEMCHR
>>>>> -DEFI_HAVE_STRRCHR \
>>>>>                                    -DEFI_HAVE_STRCMP -fno-builtin
>>>>> -fpic \
>>>>>                                    $(call
>>>>> cc-option,-mno-single-pic-base)
>>>>> -cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE
>>>>> +cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
>>>>
>>>> Can we detect the presence of these references (via the relocation
>>>> type)? We already do something similar for ordinary absolute
>>>> references too.
>>>
>>> If there's no `__global_pointer$` symbol then the linker won't make
>>> GP-relative relaxations (because it doesn't know where GP is).  We
>>> usually define that symbol in the linker script, but I'm not entierly
>>> sure how libstub gets its linker script...
>>>
>>
>> The stub seems to be linked together with the rest of the kernel, thus
>> the regular arch/riscv/kernel/vmlinux.lds.S is used.
>>
> 
> Indeed - the EFI stub is part of the same executable as vmlinux, we
> just mangle the symbol names to ensure that only code that can be
> safely called from the EFI stub can be linked to it.
> 
> If the effect of -mno-relax is to stop emitting R_RISCV_RELAX
> relocations, we should perhaps add those to the STUBCOPY_RELOC-y
> Makefile variable? (in the same file). BTW R_RISCV_HI20 doesn't seem
> like the right value there to begin with: the idea of that is to
> disallow ELF relocations that evaluate to expressions that can only be
> known at runtime (like absolute addresses for global pointer
> variables)

How to do that best? Simply replace R_RISCV_HI20 with R_RISCV_RELAX?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


