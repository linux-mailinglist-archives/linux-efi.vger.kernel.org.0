Return-Path: <linux-efi+bounces-416-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CFA82F00E
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 14:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7C21C23373
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 13:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871B91BDD3;
	Tue, 16 Jan 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IkTpILmA"
X-Original-To: linux-efi@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE91BDC8;
	Tue, 16 Jan 2024 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCN+H8lzoecjkKZuxCZ/+CfMak4p7zM5jaWYSQ/IAWIrnyGfccg+LuWWddTAJkuwH13luau59CFk4KP5o/aLlCtMo4GrPvYWJfnZgUNUXBXhvcI//rPlQYzw4L/h6hmp/FeeaT+oFaj/15pB61lnqwMrsHnhiR10NxMGZkxL4/tmC4Lsi1pUb1O/I2LCoSTNy/FQrgdmTpNGELa+KJ56jgFSTyoLxsaQQ4P03V0C0bnGYczzIwWyUii/gSfX+iCfh3owyXTkLeBXFk31aOh9XXZSylvA2agZNaeNzOgFEGD16hQbCoR28NeQEUhMADAUcyj2L4SsrR202O5bY50Bhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDctSaT0YKynzLCmGOD0k6m4Nm2FH3sj/YDXcebpEL8=;
 b=LI9/lWwgU/N/W3b9dGhRfx7mWZfvx3qI0uJypu1ByjjDU1FKm5j64p1Pbcsw9RIxYKMNzB3vE2w383AEgCroPb+JrO3m+H00bLrF0noLSIHT/81N2yABAugirml/9iY1gSJ65Y7DmB66VIAiFutJnc/2+l5FtlgxNpboi7nIMqMs2NxWRyKpCL0S7qWPaRsyVRCFsQ7qUorHUDUY9RGALlmSYsDU99GEBH9h7rQGgwcOXNiILGBFD7FGIjU/iYvWS9ashawbXmWDUFQO33z5eU1PpjhGyE6eFPWCAwmxu2KnEvrZ/LIqIxTFAK0PNtjCz3P81BJ8l/3JkAkqZgS7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDctSaT0YKynzLCmGOD0k6m4Nm2FH3sj/YDXcebpEL8=;
 b=IkTpILmAET6vti1CK83n9UOwdNCC+I7emh4BNyRHbVePuPAIBi377bz7JpPmyl1kOF7mOQptzhTJlBYpxKwk0EyfnR1XBiCbe8UE6yhpE9Tr+sQrfb5dsc1S099TMj76Y3So6Wk9Ri/szzY4dNV8/YA4KMi2JbdDYIY3uWCwAz49NO2Y9rlDSLP5c/ojPIKCIojUk56iPCDytyJYHlAIgHwRo+tLbfMG0plTGQ2+JCFR5xbSeISloYbnIuJV4fuwBxQD2rDL66UuoM818GeLbk54agGVZOx+LC/vFWe/Lal9fr6Lk1aXbMXTcVZrFvc+LoYo/l/86oHpmsR0fS25Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3283.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Tue, 16 Jan
 2024 13:56:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 13:56:47 +0000
Message-ID: <f336c78c-0971-4494-bbb4-f0602cfdfb6e@siemens.com>
Date: Tue, 16 Jan 2024 14:56:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv/efistub: Ensure GP-relative addressing is not used
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <mhng-8a4a5f85-faf9-405c-95a0-78cd04ec6509@palmer-ri-x1c9>
 <56b52d4e-9dc0-400c-a141-7e70f5c72afa@siemens.com>
 <CAMj1kXGR1aQdvej+0drfim-ZP27ZhO9UR_i_PT6F+hsV0UvbJw@mail.gmail.com>
 <578aae7c-4069-4071-ba4b-cc86d3b516c1@siemens.com>
 <CAMj1kXEC4=j5zcSyo91jnUkYMoqBG5M2raMXm4DNdD5ZbS3U7g@mail.gmail.com>
 <5c077064-bdab-4796-9ed6-8f884669b73f@siemens.com>
 <CAMj1kXGTmmNX0E4DOcJvYB2FYopudmOnPnY33OoT2RcYF0EG0g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAMj1kXGTmmNX0E4DOcJvYB2FYopudmOnPnY33OoT2RcYF0EG0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3283:EE_
X-MS-Office365-Filtering-Correlation-Id: 40623a63-70da-4b07-d07e-08dc169afac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rZDnxun2j7sbhVTliX+1d/2Kj7m5xY/nAxKil+4aXhgPnbedFbANfJFrt6JLpyw1mnUnbQ9oUsnma0u2dkaWIdiwIq/Rn2NRK3g8q1TkjkADJVSoVNohqHBECbd4UUHo+SOaGv8ZHWhpwD/7T8iMNYz355fgiidC/c0sfti8VcukRuPsAz6OqTGtct5W2oJcHWXe5yKaLCDqF9ReK5KjjvVByRvDpyY4Dg29YZnx//ur6hSchif/fdbsLwIMESvbbhpGOgjVW3YGShjzNpeUDpq0/Tb5INfMurBaRkfmMtGSYzTeFZBj2bekd+h6Vx7tVgYmg5ruhjVDcuIsRc6pdMsb9w8D2UDaQz31CqEL2BWB8WAgf7h7BmStYblUELzETgifexBJ4c5CkfNjhCXB82/X6eWn8JS04XxwPFMszxiJ31JWAZTJw5wkyOEktup54aofygfXa2ZmOLaAfXHFaxM0rxgsTBFCxPNYydMUsR5ggoAYJ3MsKjxrCEDAPVauc9WchNxGs9/VKkVkt7lH351GUQ28b3ajkqnJH0Lj8BRSz4xBxc0Jirh/VQVT6jrM/issIHkv3q7Hf1I8mDkzwu4j/pOmhUCX9L7dfY0OkIEcXfyT8OxsN6RC3IkzR/YXq6PoGatOSLd6HHMzFHJ9uQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(41300700001)(36756003)(31696002)(86362001)(38100700002)(82960400001)(53546011)(6506007)(66556008)(66946007)(66476007)(6916009)(8936002)(8676002)(316002)(6486002)(6512007)(6666004)(83380400001)(478600001)(5660300002)(4326008)(26005)(44832011)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MktOeFNkaDh0NmEyMWM1djhNTXR0V25JT1NycnNFK0Q1MXBIRnoxb21LTUgr?=
 =?utf-8?B?ZXJVeGhOZDFrcll2c0NlTm5QbEVNV3FlaXgvWTJOTzE4M3o3THRYMHNKZnhS?=
 =?utf-8?B?c3V1YzNJck5LeEZFWGtOemV5RWVKSXZvaWFkaytXNjBPVFJtbWRpbndpcmY1?=
 =?utf-8?B?U05wQ09NLzFvUUVaL0JKeFRLeHo1QWszbUJnUG90d3czdmFGNGN4cW10aVdT?=
 =?utf-8?B?TDBHaG5RNnArVVlnTW5Iak54ZTFXUHdnaGxSNnR3K1N5cEhSbXV0Z0tIQ0lj?=
 =?utf-8?B?bzlFSkNLQy8vRy9HVTk0MW9QS3EwSk9va3lBeUJlMWtub01Mc0Z1ZDBOYlRW?=
 =?utf-8?B?dlF1SlRnVnRRT2JKTXA5allWY2xnelhWWHFlN2FqMHB0WmtiVExCdUYvMklR?=
 =?utf-8?B?REQ4Z201V09MOWFGSXJidmVWc2FTSDhXbjFsWmJLWmtFVmIxWm1xUC9raGNh?=
 =?utf-8?B?b2NabE02bjQ4T2l5OWwwVXdFWEZxbi9lOURNY0NHOXhtOTV2VUFYSkJ0c0VD?=
 =?utf-8?B?MjRuQnFhNmVWTDNEc1V4YTdKZVpjZVBjYjJRTW5JVGhvUVVkRVBCT0MvQzl5?=
 =?utf-8?B?UktNYzA4NTgwL3dHaHdSODk2RGJWOHhxK1FaOFJBOEN0RzNCVDIxbjJNN1pW?=
 =?utf-8?B?VWs5Tm9oSUpLOS80VlRLbTI3aWVvNWhJSVpHZ3dPVTNJQVhOYm95bC9DVUxM?=
 =?utf-8?B?dHBHeFM1K0d6akc1TzloeU9tdGZya0ZMYjJGdU5HRHphZjlScVMxNEtrUFBp?=
 =?utf-8?B?TlZjeWdVeUZWYzJ5LzB2YVVXZklMYkRGTC9UMEdEODVEK1QvRm9zR1Vwa3du?=
 =?utf-8?B?K3BLanp3S1EvSHhmSS90aHZ2a0x5SGg4YnRxeThWUTZ4UDQ0NlBYM1FEODJZ?=
 =?utf-8?B?WElteFNPYVU5OVRJVUEzajFyT0Q2TzhmSHlnMmdNajhlNnkzbXZlUnRYcDdn?=
 =?utf-8?B?SlNTQmJUV1pPU1U4U3ZmeHJtRDlmSGdSclFQemNoUGFBSjRmblVaZnNNYnFs?=
 =?utf-8?B?V01kc1RPOU9SejhaMGc3N1RBdmRISjFuTXRpUzh3WWo4ck1zYms4bTJ2eXVG?=
 =?utf-8?B?N3FVK1NzYUpxZzMwRk5Da0d2MG1qWkZ6RHdZaXZFTUhhOVVvSHBpdHNKVWw2?=
 =?utf-8?B?a01QM0pJSElKVFMyNzY1MXZuSVliaHhwQmJOUmZjZjQ4VFROREN4MjV2cW92?=
 =?utf-8?B?c3NndStYcWQ5U2lySXpDUGR4ejFERGxaTFlRWFFkUjNtL0JkR0p0bTZMYWRI?=
 =?utf-8?B?UGh0WGs2OEV3ZlFxdmh6T1B6ZmdWQmhOSjJPNFdxQUt0K0cwcFd4S0xiUEF0?=
 =?utf-8?B?b0RGNm1CVjVZM0FZeHJXMnZGWjc5anlOK1UxcG5UTTBXb2lHTm9lMEZMZEw3?=
 =?utf-8?B?dzRQK3lKNTlyNHVGWVJzb254VXprL3FKWm9KUzM2eXdOUVRhcllsREgrTGlq?=
 =?utf-8?B?d0xGZlNjbE1Ed0IrMEp1ZDBKeVVaZ1lrL3FtZ2F3NC9TNmNzOWpoNzdqWVNm?=
 =?utf-8?B?UjB2ZmZlMUYrYnB2ZjZWalp3TWtNYk9aVmJCQUVhU1lkZ21OaFFSZTI0QlVv?=
 =?utf-8?B?RFVLU0xmMzFRakczajVmUkxHS3hwanZORk1SMEJpV3J6SEhabmxwR1BNc0Fq?=
 =?utf-8?B?OE9nUGhnQjlDWTIxT0lDVS85a1BsV1JHa2laUXJuT0thYm1zbTFIYnowVFFC?=
 =?utf-8?B?NGthbTRSQU5TOU5HVWtLL25yR1ZmUUFtRjh5bVQvVTRzZ0tJc0c1VUVaYWlz?=
 =?utf-8?B?N0JobHoxMzdEZGdsSlc1YzVqZ1l6OVVUU0UyWko5NytORCtnaXkxdEhmVjZC?=
 =?utf-8?B?eXNBRmljUGVYZnBKeElEZ3FRUVBva0RvbitEWHU2SFZqSGtia3FVQWlYSTdq?=
 =?utf-8?B?eHI4Tm1GbEFwZTlpU1R3SkQ0Z2diMjArb3Z6cUhJVk1odHg1a0FrMjdhcTdK?=
 =?utf-8?B?aXFqZDhNTVdrbVZGS05VZUM4VDBKU2tuelpTRkc1VjVvWkRBMzlScDY5MlFX?=
 =?utf-8?B?eGVHRDhjYnR5YmxnOUZQMEVWSkVkSmVHeHptVzNON3l6YkZENzBIZEtRL0s0?=
 =?utf-8?B?RW9uc1AwT1c0WFVlUTRzOGJBWHcyWUhXSUl2Ri9yaExvRE9HNjVlZWJEeHZR?=
 =?utf-8?B?RHNhWmxYQjU2MmJ6clh4Z3dja1FPUG9oVnBqYjljWXkxaWdWcTlVMStDZ3BD?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40623a63-70da-4b07-d07e-08dc169afac9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 13:56:47.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9qoLhtHPVRjed7WT7U0v4DNP4C5bsdzAy28uVs4ahhPy/NqEgOBIKlA9BVmxKCZz5qO9r8VlLPJin3Y7NW/cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3283

On 16.01.24 14:47, Ard Biesheuvel wrote:
> On Tue, 16 Jan 2024 at 14:44, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 16.01.24 09:36, Ard Biesheuvel wrote:
>>> On Tue, 16 Jan 2024 at 06:21, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 15.01.24 18:34, Ard Biesheuvel wrote:
>>>>> On Sat, 13 Jan 2024 at 11:35, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>
>>>>>> On 12.01.24 19:56, Palmer Dabbelt wrote:
>>>>>>> On Fri, 12 Jan 2024 10:51:16 PST (-0800), Ard Biesheuvel wrote:
>>>>>>>> Hi Jan,
>>>>>>>>
>>>>>>>> On Fri, 12 Jan 2024 at 19:37, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>>>>
>>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>
>>>>>>>>> The cflags for the RISC-V efistub were missing -mno-relax, thus were
>>>>>>>>> under the risk that the compiler could use GP-relative addressing. That
>>>>>>>>> happened for _edata with binutils-2.41 and kernel 6.1, causing the
>>>>>>>>> relocation to fail due to an invalid kernel_size in handle_kernel_image.
>>>>>>>>> It was not yet observed with newer versions, but that may just be luck.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Something like this should go to stable as well, but we will need
>>>>>>>>> rebased patches.
>>>>>>>>>
>>>>>>>>>  drivers/firmware/efi/libstub/Makefile | 2 +-
>>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/firmware/efi/libstub/Makefile
>>>>>>>>> b/drivers/firmware/efi/libstub/Makefile
>>>>>>>>> index 06964a3c130f..d561d7de46a9 100644
>>>>>>>>> --- a/drivers/firmware/efi/libstub/Makefile
>>>>>>>>> +++ b/drivers/firmware/efi/libstub/Makefile
>>>>>>>>> @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)          += -DEFI_HAVE_STRLEN
>>>>>>>>> -DEFI_HAVE_STRNLEN \
>>>>>>>>>                                    -DEFI_HAVE_MEMCHR
>>>>>>>>> -DEFI_HAVE_STRRCHR \
>>>>>>>>>                                    -DEFI_HAVE_STRCMP -fno-builtin
>>>>>>>>> -fpic \
>>>>>>>>>                                    $(call
>>>>>>>>> cc-option,-mno-single-pic-base)
>>>>>>>>> -cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE
>>>>>>>>> +cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
>>>>>>>>
>>>>>>>> Can we detect the presence of these references (via the relocation
>>>>>>>> type)? We already do something similar for ordinary absolute
>>>>>>>> references too.
>>>>>>>
>>>>>>> If there's no `__global_pointer$` symbol then the linker won't make
>>>>>>> GP-relative relaxations (because it doesn't know where GP is).  We
>>>>>>> usually define that symbol in the linker script, but I'm not entierly
>>>>>>> sure how libstub gets its linker script...
>>>>>>>
>>>>>>
>>>>>> The stub seems to be linked together with the rest of the kernel, thus
>>>>>> the regular arch/riscv/kernel/vmlinux.lds.S is used.
>>>>>>
>>>>>
>>>>> Indeed - the EFI stub is part of the same executable as vmlinux, we
>>>>> just mangle the symbol names to ensure that only code that can be
>>>>> safely called from the EFI stub can be linked to it.
>>>>>
>>>>> If the effect of -mno-relax is to stop emitting R_RISCV_RELAX
>>>>> relocations, we should perhaps add those to the STUBCOPY_RELOC-y
>>>>> Makefile variable? (in the same file). BTW R_RISCV_HI20 doesn't seem
>>>>> like the right value there to begin with: the idea of that is to
>>>>> disallow ELF relocations that evaluate to expressions that can only be
>>>>> known at runtime (like absolute addresses for global pointer
>>>>> variables)
>>>>
>>>> How to do that best? Simply replace R_RISCV_HI20 with R_RISCV_RELAX?
>>>>
>>>
>>> We'll need to keep the HI20, in fact - I got confused between HI20 and
>>> PCREL_HI20, and the former is actually used for 32-bit absolute
>>> addresses in 32-bit code.
>>>
>>> This seems to do the trick: it disallows relaxation relocations and
>>> native word sizes absolute references. AFAICT, those are the only ones
>>> we should care about.
>>>
>>> STUBCOPY_RELOC-$(CONFIG_RISCV) := -E
>>> R_RISCV_HI20\|R_RISCV_$(BITS)\|R_RISCV_RELAX
>>
>> I would suggest to do that on top of this patch. Want me to write such a
>> patch, or will you? You can probably more fluently explain why
>> R_RISCV_32/64 is important, I would first have to understand what that
>> is exactly. :)
>>
> 
> Sure, I can take care of that.
> 

Perfect.

> For your patch,
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> 
> I'll queue this up as a EFI fix.

Thanks. Will you take care of stable, or should I once the commit was
merged?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


