Return-Path: <linux-efi+bounces-414-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDDF82EFE9
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 14:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D951C21035
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jan 2024 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DD91BDC4;
	Tue, 16 Jan 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HrsIVBSj"
X-Original-To: linux-efi@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9411BDC3;
	Tue, 16 Jan 2024 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKAEHAIylEISomyjmDP99JY7YztYnykkGsYXoZ+JBQc5oES85BO/3lXab5S6+pu14kqB8K2AjJN9d1qmMuju7fEdRJ7MKqVHWWuo2cXewoBA2ivv6eQnfCvJuzL/HA5UptpWocjge0kcxHtcW5nuPKrj+d221K4sB74RaTiEAhuivHZFbFCI3r6sbZ9/saqeRsGmUqNeD81HtgKjYI7iNxugkA2g9NvrAmZDaUqVOGeLxDOYuHzVaD/jdcK56H2CQubzQCRgS7Ug/FaspYhsfMkO9FclrjcWQ2KtIILLRy8eDH5B21CQHwRtK3UQGJKkT/rasIu9sm23stnp802SOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2gU+I0k+jMrWfuR/zcU5FCugkM93tJPKs4llGtoAek=;
 b=dcBynpGibFw4NhcF7Tuj2FezgiDfEaCUE+guAlo+ZJa9XlXAphT7eecwBMLqNTaW9ww/3n69QCfVT7aWuLcF5Z3ugMBQjiehDIAsxgd3C3S0kvPTuvndbKJlteGtRKl8GgFqc3L043IgyuP18BbewSRfrU0eO8k62YyRLA074eq4lnmt8Yj1QLgwa0+pVLijjtWlFFyWeNGuSNY2iPxTBrfDLEEWclyDInYkFvihkbg/0rEayX6o9V1EjwFqlJ/s++qPV6O1fJY4t+hpUkh5EQDUkrCJOreQvGQZlyeGrf5pMX5ACd5/43zN3U6bTbT9jokOWQLdgKzaDg2iiSjwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2gU+I0k+jMrWfuR/zcU5FCugkM93tJPKs4llGtoAek=;
 b=HrsIVBSj7yVCUUz7JVYLxgKUdJ/X25DlQg+FDgNybKi+hILRs+UIF7/aEgC7yftxrpdvFwsakX7U6TSW2IiEiXwbDhmLS3vNRNSDj+kYbwbYhUhGLGwF1/2jdCJplJ4JG/tUsM9A0+soOWiTx9zbsVD5XKWd606ttOkBCXLAmXfq8qup27451u7xZn0OlrNvx7hrrFGMKudLC4wjy7YGrKwggcKqVmckitCvOR8D1wcfPfK0JHJwmE0T3Yzq15xBgeJVGi4OGw09UrF41trSyGlIzvbWn+t3rWSRBJW5BveGx82ESa0wgoKhLuuqDGpbosgPiyG/HCY8Uys8dYeSfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Tue, 16 Jan
 2024 13:44:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 13:44:37 +0000
Message-ID: <5c077064-bdab-4796-9ed6-8f884669b73f@siemens.com>
Date: Tue, 16 Jan 2024 14:44:35 +0100
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAMj1kXEC4=j5zcSyo91jnUkYMoqBG5M2raMXm4DNdD5ZbS3U7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c69806-1a42-4640-e2f0-08dc169947be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V45G9SMKnoc+3es/6xkJcsZAMMMulQGdWhrGvZex8siAe8ed2VAhEM5Gifh0VVzlgeZwgriklgSfLkXWG2NT3zubGqzacx3Ew/DPjp2UCp9W2AuAFvGFssmDJ94sxZMpfH6TgOKrVX7RAjjAly6IPDQ/qZHycjfW6eaBNh8vX7fEg0NG3aiz0RhQfJFrfxkR1Uypb95ICi8Z0skKxG3wA3Te6GY0KXEt2C3Rmu7yTIClizDw+VIO8Q8Tb4o7NKbCzYpBhpqL91Guxmma7WvRy89kaO1kx+crJZ0nn3kAYbIa+JZ01WjvrQLqfyWoCN75ZWW8j1KkEO9zxGQl/yk6aZjpDaGERCQkC/0KFg3lJRdaihKcY4xecnXFyg9j7YvEOiY7VZ1kDcI8iDu3xIYB8FHSM8k6tVGzdjpWQjJ6FSqQic+0OrjcI9kw74WqRzJobEJq1alWdlsNZKmGcmQO3e9cwfDL0+cnBrpleKRyksxbkfDU8cf2J+G6AQiI79q4U5ATVyLDFzARdGoWJx75lqoXW6OWyVla6TkSrlP0xGOX5IRF9KS+YCUTsnfN6gCTJimo6P2bZNy2l6prhKqbtWmYyK7CZxR0VcFFA6++V4QFlEFNQhsuUPWaE+YCI/zX1H2km+v1LxCUNneXYg82Kg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(38100700002)(83380400001)(36756003)(31696002)(86362001)(82960400001)(44832011)(316002)(66476007)(66556008)(66946007)(6916009)(2906002)(4326008)(8676002)(8936002)(5660300002)(2616005)(26005)(6486002)(478600001)(6506007)(6512007)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHJubUlQSTMzM3lla0NweG55RkFWNXNOaXBZMjNSVi9Cb2dROVlsZ2dsL0Zn?=
 =?utf-8?B?QWJST1hWVm9kcFdST3I4WjI1cUpzekdnbThkNS9PNFR5VXlIZW9ra1ZkSk9r?=
 =?utf-8?B?a0pheTU0Zm1pV3ZjOFNjQ3A1RmVQTTdwMkcySyswQmxSdlV2bStOUDRwaWgx?=
 =?utf-8?B?dmk1SXpGTTVxUmhnU3ptaFdielg4Z2VMTWpKM04zYmxnSFNIZTdpOG5TNDc3?=
 =?utf-8?B?QTEwU1NXdXcvUmhQMmxDVlZETWdsU3ZOL1NRbTBUMnI5OFc3OUdNckczRm9q?=
 =?utf-8?B?TERqY3QzWWk0SDFjU1pqMnY0OTFxZG1meWFSSG9XNlZYd1c1UzFJak5vNllT?=
 =?utf-8?B?MnJySjVZbzFkcEdldEFUQmhUOC9rSDhCazlPVjhnTDFUTG1iMTNKM1lkamkv?=
 =?utf-8?B?N1NQUUNiZU1vZEFobTJPQ2t1b0F6Wjcvc1RtT052Y0IrNjJuSjdUWWNSM2J2?=
 =?utf-8?B?MEpKMkdUYTU1bW9JaDhkTHNkcVJtaHUxZ2xrb1FncCswYzhVdElYWlRJdVdH?=
 =?utf-8?B?RU1mcXlRUDhvbyswMWc4REs1SW4zRyt0dTRSVzFzTUlFelVZUU5Qd0VCM3A2?=
 =?utf-8?B?L01LUkV1OVhvZ0NvVXJVc0k3bUNGOFJ0ZVA4RkI3WDBpSzN6Skt1YS9SZllH?=
 =?utf-8?B?MExXY2F2cnY4eEd4d1ZDdnN6d205L0wrblFpaTIybEN3d0JaL2tPVURQbk5O?=
 =?utf-8?B?RHZrRHg5Zmg0WUZLZXJEMU13QXQvUnl5REJUYWNZakJzRnM5aXJsTEhOZ2hm?=
 =?utf-8?B?SUc2RUFzRTFIZFJQVWxxRkdzd0VSbFhFMHlBRXJJbFNSbUYzdmNEcUd6V1dl?=
 =?utf-8?B?cEhMYnZMaWlQRXlINnZVa2tYb1F4OVYvc09VUzFRRHo0R0hzVUVFdjBmOUhQ?=
 =?utf-8?B?bjNuZlZwVVVPWW1aeFFmZFlxUGxaRWJZYWgvc1J2SVpIUVBFc1dTZDgydld0?=
 =?utf-8?B?N2F3aFJVb0VxbmdTR05LMlg1NnZHbm9GQ3JCU2NDeFBIM1pWOXp5SE10ZEFE?=
 =?utf-8?B?T3BFeDJ2NDdCY1BQcGFZRSs2eGJOS1U0azBUekxvb3U5SlVhMzB0TkhGQVVZ?=
 =?utf-8?B?MSt5K2JIQVpnRGluNVhoM1B6MUJoVVVBb3NtemcyUTdBTWFBNVhuT3NRRUJz?=
 =?utf-8?B?UjdFMk9YSWlXYjlRdENqaFUybE1VODhzMHkrNjdEK3BDay9WRkZhdUlLMFNB?=
 =?utf-8?B?eG9UdFNnUDBuTThJaURGMzJ1VjZGdEEwb3JPYjBFczI2V3VlcTRidVVCTURD?=
 =?utf-8?B?Rk5mMHZrSlhJZEVSSDFkQ3J5eGd2ajRLQ2plQnU3RHpEYnliMlNYbG81eHoy?=
 =?utf-8?B?MURGR2dkbDZZU1E5U3dubHVwcFlPZmRxQjdyY25CVWhlYU5iWXFqZGNWTjNO?=
 =?utf-8?B?OXF4SmR3OCs3cUMrL1dEc01Qb0ZYYklGbjREMlRZdC9IUFJzb2dzK1JzRGJh?=
 =?utf-8?B?Z3FsVEVEZ1RqaHRpaUpUeVpyR0tpN0FuZzA1RUdRSXJzVEJLYlRobVhVN1hk?=
 =?utf-8?B?T1JoQWYrL3F0RE5XY2tObUQyT2FKTXpadzR4VTBnTXQ3NDR3dEFnTVNSL1NC?=
 =?utf-8?B?c3FmRmJDMXVKS004ZmppYnd3NncxdnNuSHo5dGZLb1c1RGFoVXZiU3VRWUc0?=
 =?utf-8?B?MHFDNXdoWmJ4ZHJOUFEvbHRUMUdzMFUwM0d5UklrblhwNEZYRlByRXpaM2pa?=
 =?utf-8?B?S3A0KzlPRm9aMmRtQXJLcndJV3ZzNzhUZG1TUGRSc2R3TjU2S3cvWFdYYnZi?=
 =?utf-8?B?eWtnU0hMNXplOGFROWUzYTgrbnk5WmxqOWlNTUVRYVhMNG1jcDROd1AwMEVH?=
 =?utf-8?B?Q1pKWXRtc0FVRUZZbHlYRDR6UTdveGVFbWxCK3VmcG5XdVRKclVKWnE0MDV5?=
 =?utf-8?B?emZ2SXhXMklBVFFKZnU2Q1lyTk5IaWJBQmlGVk5hMDhrSGJZSkpLVHdIQmVz?=
 =?utf-8?B?b2VrL1hhbEpIVzQwc2FkclpaWkpiYkkxQk9qS0oyS2p4S2QxSksrQUF5a3ZR?=
 =?utf-8?B?TS9Wb281WGg3VGJrRGtDVnlMT3JVYnNvOGNmSU1kUU5vMDh2UWlySWZFeHA0?=
 =?utf-8?B?ckQyN0ZhRjIveHhNZ2lzc211TmN3Y2kzZWxnUXZqd1lTNDJuei9GaXhSMTBz?=
 =?utf-8?B?SGZhTXN0Z1JlL0lXa0RzWDRUM0lGQUs1Wk1HZGRkR0FMZWhBd2ovbjlpTUtX?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c69806-1a42-4640-e2f0-08dc169947be
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 13:44:37.0606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKlUyCYf15uDr3ZQaxGCDxVDfYTPirl49uxs72P0zUCw2F87F2mA/BJtVccf3nSR9cRjdMXToofSKZPaQmrfAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7037

On 16.01.24 09:36, Ard Biesheuvel wrote:
> On Tue, 16 Jan 2024 at 06:21, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 15.01.24 18:34, Ard Biesheuvel wrote:
>>> On Sat, 13 Jan 2024 at 11:35, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 12.01.24 19:56, Palmer Dabbelt wrote:
>>>>> On Fri, 12 Jan 2024 10:51:16 PST (-0800), Ard Biesheuvel wrote:
>>>>>> Hi Jan,
>>>>>>
>>>>>> On Fri, 12 Jan 2024 at 19:37, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>>
>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>
>>>>>>> The cflags for the RISC-V efistub were missing -mno-relax, thus were
>>>>>>> under the risk that the compiler could use GP-relative addressing. That
>>>>>>> happened for _edata with binutils-2.41 and kernel 6.1, causing the
>>>>>>> relocation to fail due to an invalid kernel_size in handle_kernel_image.
>>>>>>> It was not yet observed with newer versions, but that may just be luck.
>>>>>>>
>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Something like this should go to stable as well, but we will need
>>>>>>> rebased patches.
>>>>>>>
>>>>>>>  drivers/firmware/efi/libstub/Makefile | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/firmware/efi/libstub/Makefile
>>>>>>> b/drivers/firmware/efi/libstub/Makefile
>>>>>>> index 06964a3c130f..d561d7de46a9 100644
>>>>>>> --- a/drivers/firmware/efi/libstub/Makefile
>>>>>>> +++ b/drivers/firmware/efi/libstub/Makefile
>>>>>>> @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)          += -DEFI_HAVE_STRLEN
>>>>>>> -DEFI_HAVE_STRNLEN \
>>>>>>>                                    -DEFI_HAVE_MEMCHR
>>>>>>> -DEFI_HAVE_STRRCHR \
>>>>>>>                                    -DEFI_HAVE_STRCMP -fno-builtin
>>>>>>> -fpic \
>>>>>>>                                    $(call
>>>>>>> cc-option,-mno-single-pic-base)
>>>>>>> -cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE
>>>>>>> +cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
>>>>>>
>>>>>> Can we detect the presence of these references (via the relocation
>>>>>> type)? We already do something similar for ordinary absolute
>>>>>> references too.
>>>>>
>>>>> If there's no `__global_pointer$` symbol then the linker won't make
>>>>> GP-relative relaxations (because it doesn't know where GP is).  We
>>>>> usually define that symbol in the linker script, but I'm not entierly
>>>>> sure how libstub gets its linker script...
>>>>>
>>>>
>>>> The stub seems to be linked together with the rest of the kernel, thus
>>>> the regular arch/riscv/kernel/vmlinux.lds.S is used.
>>>>
>>>
>>> Indeed - the EFI stub is part of the same executable as vmlinux, we
>>> just mangle the symbol names to ensure that only code that can be
>>> safely called from the EFI stub can be linked to it.
>>>
>>> If the effect of -mno-relax is to stop emitting R_RISCV_RELAX
>>> relocations, we should perhaps add those to the STUBCOPY_RELOC-y
>>> Makefile variable? (in the same file). BTW R_RISCV_HI20 doesn't seem
>>> like the right value there to begin with: the idea of that is to
>>> disallow ELF relocations that evaluate to expressions that can only be
>>> known at runtime (like absolute addresses for global pointer
>>> variables)
>>
>> How to do that best? Simply replace R_RISCV_HI20 with R_RISCV_RELAX?
>>
> 
> We'll need to keep the HI20, in fact - I got confused between HI20 and
> PCREL_HI20, and the former is actually used for 32-bit absolute
> addresses in 32-bit code.
> 
> This seems to do the trick: it disallows relaxation relocations and
> native word sizes absolute references. AFAICT, those are the only ones
> we should care about.
> 
> STUBCOPY_RELOC-$(CONFIG_RISCV) := -E
> R_RISCV_HI20\|R_RISCV_$(BITS)\|R_RISCV_RELAX

I would suggest to do that on top of this patch. Want me to write such a
patch, or will you? You can probably more fluently explain why
R_RISCV_32/64 is important, I would first have to understand what that
is exactly. :)

Jan

-- 
Siemens AG, Technology
Linux Expert Center


