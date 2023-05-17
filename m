Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074D870758A
	for <lists+linux-efi@lfdr.de>; Thu, 18 May 2023 00:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjEQWki (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 May 2023 18:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEQWkh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 May 2023 18:40:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A331A2112;
        Wed, 17 May 2023 15:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmyUCisiZQRadSMtc3trGyj6vmE/XuJWoUZAONXRBqB37L3MBpXESQbspZFzj18MF1gxwZCgOAV1BxUQD4EICVtDPx5ja2te3QVbQWqH6DR/TDLhcBIMkgBDQOMCJsNgpJ+vexK2sTuOWCS4VgANfoVB7y0+VVzsmcoQ1C/iTlm12W9ARKH+drtQA6C/QrZTqm1J7vOslVb74s41hYfnYRRpKeCyn8lxctCeuw45LbGQfAINybfTxL3FX4x/WPjCOe+9s2Q3I2421qfw+aU47fRRjDP7LPMWkQFaCVICAxJ2Q41PeZQF3F6Tvfm9RM2QRk+o6nYCm3pIq4dPaQTNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSXmemznnc8NPR/ApGhvbYClYorbjAPj/3eFalY1iWQ=;
 b=n8Q+k3qBk5/Ye/x7thLJnV+QI0DYXM6xXQhmTqeA9RqP8A+fzg+uusEbme3d/qgWa2hVqYeyPX3HeJyR9VcEWgo2ZfzG0lC9MojAowdTF+xpTJjDd2aU3YPVlEsT9R+7g7SQm7S/RZipMPQFPbg1ZIq5buqRetoaPO//rubJm7vjwEG+09/x8q8pfLc3VU5+F7LKArlx8F+8fuU9B1eMOjjRLgFE8KzomXBNgtCpnFiqswTChK+4aLb8c7g0fGskLGbO5d3MOPC8dNoeZx1xaofLJAKE/K//0fbmy6t1u9jPqBXNSkj3LB/qYR9SPH052VigyBdG3ZGsaynf93oH3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSXmemznnc8NPR/ApGhvbYClYorbjAPj/3eFalY1iWQ=;
 b=idx67fPxyHa0Piz+JxTuJU4ja+yn9skJbmzikEs9IBjBy+3ZWdxDAeUhl+Rm/0HwYCu3XQ0h/OmEzMnVsrsgoEeYJxQxQwFANNLLG931h+sfgH+/pRbxpHMox5uWe9IzoiL9bLa+YObE2etml6mwpN92KlEeTtfEJA8agqt3eYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 22:40:32 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 22:40:32 +0000
Message-ID: <6f858998-bb56-689b-76a7-0952d73f5ab8@amd.com>
Date:   Wed, 17 May 2023 17:40:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 05/20] x86: decompressor: Avoid the need for a stack in
 the 32-bit trampoline
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-6-ardb@kernel.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230508070330.582131-6-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:8:57::26) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b0b733-6420-4a43-68ef-08db5727b8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfEubXib1kITk6Ug4WMA+bj5G79SPBYG2mlsdlIa9841zo2ZPFXU9h+akuFmRtzJrBl4/MOd7jn9FQFANTx15ugiwtpDKy9nL7joyXCgvCzllqgDm1s6lOojF3oP2Mll7wg3ELcLBdqsG7un78qr6NsJs1VMUrBLEuF03/lSZoA2NG7bti07B2eswzpW2xQW01GGlw3s3qefjpJt+4+Q9a5CUNgDqKCdTa1pjh5gIdd2oPSW6FDiObjwNn3jHa6Y7Q/iTuQLpEUNDn5NLaickdm/hUhW3pPg7AUWSI1oRvsnfEGOGm/qQ5ISz7XnCswVc9pCirY6Oj+YDZPgvQ27ZgQLqEnAux9hdvyTWndjxV7NSoLyGinB9+761ktacONnuIn+ROwc2tbACptxIwhZVScNL1AosRRvjqe4pbZCImAahl94//2e02d+qC+Dl8jKlE+XnuKBZgn8vnidqFmmc2vP/R+DTZSrfDKSyNVViH/QsIugAlvmFA7tRu9GxMVU4cMC5cS3HzQA8eqGGgEHBec2KBZOjCumqRa0LtnxtR3+aYX7MnRcfIED9btT4cvZRUGGpNkpwnkpQQw8uNUlqcFuLDG+nFpCTB0cp/RGu1G8ZmGevGwQoDZ3pDldKBrifnZw1VEQOGm82zxkG79+OA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(83380400001)(6506007)(186003)(26005)(53546011)(6512007)(36756003)(6486002)(2616005)(316002)(4326008)(66946007)(66556008)(2906002)(66476007)(38100700002)(8936002)(8676002)(7416002)(31686004)(31696002)(86362001)(41300700001)(5660300002)(54906003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEVPVml3R3U0NkNHdTQzK0JmbHdwVUc3dGIydkxtSTAxOTIrdVFTUFg4MzI2?=
 =?utf-8?B?ZG15Tm5SMWFLQzVMa29NeVo4eUowM1V0eTdlWkZDeFRiOE5zbUJmVEFVWlVr?=
 =?utf-8?B?c0tkajkwRllMcGZmVjA3ZWQ2NXFaUnh0SmNJc1BmQW1aNGdNWVZzZXRTRTh6?=
 =?utf-8?B?U3puMDArUmxXcTFWU2JrMzkrUnN3L0FhOVVUZnJjUGlENmpRbGVJTU1QK09D?=
 =?utf-8?B?OWx2L0VQUklNdTlaM01UZTdodjN3eTFMT25XbVoyUHMySmRsS2hBekw3MWxC?=
 =?utf-8?B?RlFlanZKMHAwUzMxeXFRT1IrcWFJd201bHBQQ2s5a1NXMEptRlAxbU1pM3da?=
 =?utf-8?B?eVE1dFdiZnN3SlVjTDVqVzhYTEZzczlhQ1VCYWI3ZjZLdnArUnhlYUlFd2Ru?=
 =?utf-8?B?UkcvWUhtcm5vZE5aSkhqejlldWRoNTBmZXJwS2ZORnduNU9CcFJRTTRqWW01?=
 =?utf-8?B?bWdLeTljWEgwQ1pTYk03Z0xMZ3B3UnhSZjExc21lMmxYRHdtZGZ0ZCtJWFAw?=
 =?utf-8?B?eDBQVjNaekhIaDZYelJOdWJQMkNPdXpDRkdiTFpVSFcrTVRHazUwRVF1aWJE?=
 =?utf-8?B?cjVuUmZxcnQ1R3FLbFVzWDJIZ3hrMzErMTFXSVppRWcyVUEvTWFmL0tBSXRD?=
 =?utf-8?B?YjNtbnMwVTZPY2RueGlwZ25NWmZONXg2ajdPRGd4dE1CQmFaSHlJOTZ4WG04?=
 =?utf-8?B?bzhNRjhGNGg4c0tOMXFiQi82U2Q0Vm10d01HWEsxbFh1bkZYVWZkdk5MbkUw?=
 =?utf-8?B?UmJRRXJiaWI1TGl5V1ZYVnkyM2ptcHpJWVNyckx4MEdKdCtjREd5NDYzNmlL?=
 =?utf-8?B?TlVQRkltT29aZEYzOXJnemRpYkdoM0ZmTjJPVGZSSklqTjM1cVJJTzJxS2NR?=
 =?utf-8?B?QXlGUjdrOTgyMC9mb3pzWnZHL1NGMGptUHpxbGNjU1pVdGRiVDhSUkdpaERr?=
 =?utf-8?B?RnhpNWNFTHBHOENkZGZnMzNGdUZWWDNNVHMzWm1yVng3MnNtRU1ZaHF1a1Ny?=
 =?utf-8?B?SmNoZm10a3UyZ1lVS1hhMm5MWlNpYkxVclRYSVZWWlhJdUNRTE1waHZVdEgr?=
 =?utf-8?B?V2NTS2gxdXFQSmpmTmRId29NRmY1T0NwK1ozZXBDN3lmbDdGMkMxWURYSzNi?=
 =?utf-8?B?eVZFWEZ5bVlQVjlwemkxZE1laXI3OVlOaVlGVU9vNGFzMXhHN28zK1hwTmRM?=
 =?utf-8?B?eEpLd2RYUnFjQXI0UjFLL2lCTzdKcWhsNUdoUWU1aGdVYk5tSzhBTGVscS9p?=
 =?utf-8?B?VFRhcjcyMkk3dGR1WWkraDdHSWRkeU9vUXAzOUI4Vm5JMnFXamhEc1c3TGlP?=
 =?utf-8?B?NFRyYjNnUkVHS1c4bE91Vmt1U1BhT3A1QkpVNFYxYzVPb0ttNzZXSGFsSnFX?=
 =?utf-8?B?Q2JqK2pPT1BDRFMreDNlUUcvTytSKzBNSS9hWEdHZGtFSm5JSGNEdHczam5x?=
 =?utf-8?B?Q2VvWXpMTWtERGlSck5ILzVyczdnYitwU3VqVVZFTlB6MEJtYjZ2MXUyV3Az?=
 =?utf-8?B?Y0hVSTZYWjRieWs1Rm9SNjZCZjR2NVRpcWdsY1ZnZVIzNWJpWUt6TVRYbnhB?=
 =?utf-8?B?Rm1SeEhyTTF5dXdZcStDV3M4N1ZJMDBMTFFOTkJNL3FGc2xWc002Wm40dVJY?=
 =?utf-8?B?ZklYQks2Z0liMGJRd0NUbjlDMW14K2dUNTRrS2Q2NlYyUUpRbFNqY1h0T045?=
 =?utf-8?B?YVZGeEZjamt2ckpMZlY5SVdPem1obTQ2MURXZGJxUG44L01oeC9RZ2JPVzlQ?=
 =?utf-8?B?RVkwQTQxMnVxeVljOUpGc1N5VW9qWllNUS9pM1VsK0IyQ2gxQTQ1QThacmpZ?=
 =?utf-8?B?MkxYcS9sNEl2WjRLTlpzeUUrMWZtRWpObTc2WVpDTmVHUmtnNmJQTUFNRk42?=
 =?utf-8?B?T3Vta25HK2Q0MHBSV1hjRUo0QkdhMEFyYjdjdDdhVS9ySXdvZll5OGV3QVFu?=
 =?utf-8?B?bGRSeExaUTNFeUtVTmFZZ1l0MGFNRXpzaWF6TGxOVjF1WFNweWYvQWF5aEov?=
 =?utf-8?B?a1YxWDZkSHlUNlhOYzMrWTlxVEV5SEV2S2owVnJHWldKcDQwQmNvajJRVUMy?=
 =?utf-8?B?T0I2eVV2eDEyTmtMSGpCZlpLekJEOUgrc1k1R01rWlE3b0NzYmlROFJQMFpD?=
 =?utf-8?Q?XpJyMVg9shGSm2VLPFhSn6plj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b0b733-6420-4a43-68ef-08db5727b8d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 22:40:32.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRRZ8T+tHLXAMEGd9ZgZvPGJdABcAawyPvmuR4SeqwhD0MECSBbta08R0Wab1ADhgNgVHEzxrRFdf6jqPYDRag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/8/23 02:03, Ard Biesheuvel wrote:
> The 32-bit trampoline no longer uses the stack for anything except
> performing a long return back to long mode. Currently, this stack is
> allocated in the same page that carries the trampoline code, which means
> this page must be mapped writable and executable, and the stack is
> therefore executable as well.
> 
> So let's do a long jump instead: that way, we can pre-calculate the
> return address and poke it into the code before we call it. In a later
> patch, we will take advantage of this by removing writable permissions
> (and adding executable ones) explicitly when booting via the EFI stub.
> 
> Not playing with the stack pointer also makes it more straight-forward
> to call the trampoline code as an ordinary 64-bit function from C code.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   arch/x86/boot/compressed/head_64.S    | 34 ++++----------------
>   arch/x86/boot/compressed/pgtable.h    |  6 ++--
>   arch/x86/boot/compressed/pgtable_64.c | 12 ++++++-
>   3 files changed, 21 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index b1f8a867777120bb..3b5fc851737ffc39 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -460,9 +460,6 @@ SYM_CODE_START(startup_64)
>   	leaq	TRAMPOLINE_32BIT_CODE_OFFSET(%rax), %rax
>   	call	*%rax
>   
> -	/* Restore the stack, the 32-bit trampoline uses its own stack */
> -	leaq	rva(boot_stack_end)(%rbx), %rsp
> -
>   	/*
>   	 * cleanup_trampoline() would restore trampoline memory.
>   	 *
> @@ -563,24 +560,17 @@ SYM_FUNC_END(.Lrelocated)
>    * EDI contains the base address of the trampoline memory.
>    * Non-zero ESI means trampoline needs to enable 5-level paging.
>    */
> +	.section ".rodata", "a", @progbits
>   SYM_CODE_START(trampoline_32bit_src)
> -	popq	%r8
>   	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
>   	pushq	$__KERNEL32_CS
>   	leaq	0f(%rip), %rax
>   	pushq	%rax
>   	lretq
> +.Lret:	retq

Maybe just add a comment above this to explain that this is a target of 
the long jump below to get back into long mode and be able to return 
without setting up a new stack for the 32-bit code.

And then a corresponding comment on the long jump itself. I think it would 
make it easier to understand what is going on in this part of the code.

Thanks,
Tom

>   
>   	.code32
> -0:	/* Set up data and stack segments */
> -	movl	$__KERNEL_DS, %eax
> -	movl	%eax, %ds
> -	movl	%eax, %ss
> -
> -	/* Set up new stack */
> -	leal	TRAMPOLINE_32BIT_STACK_END(%edi), %esp
> -
> -	/* Disable paging */
> +0:	/* Disable paging */
>   	movl	%cr0, %eax
>   	btrl	$X86_CR0_PG_BIT, %eax
>   	movl	%eax, %cr0
> @@ -634,26 +624,16 @@ SYM_CODE_START(trampoline_32bit_src)
>   1:
>   	movl	%eax, %cr4
>   
> -	/* Calculate address of paging_enabled() once we are executing in the trampoline */
> -	leal	.Lpaging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%edi), %eax
> -
> -	/* Prepare the stack for far return to Long Mode */
> -	pushl	$__KERNEL_CS
> -	pushl	%eax
> -
>   	/* Enable paging again. */
>   	movl	%cr0, %eax
>   	btsl	$X86_CR0_PG_BIT, %eax
>   	movl	%eax, %cr0
>   
> -	lret
> +.Ljmp:	ljmpl	$__KERNEL_CS, $(.Lret - trampoline_32bit_src)
>   SYM_CODE_END(trampoline_32bit_src)
>   
> -	.code64
> -SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
> -	/* Return from the trampoline */
> -	jmp	*%r8
> -SYM_FUNC_END(.Lpaging_enabled)
> +/* keep this right after trampoline_32bit_src() so we can infer its size */
> +SYM_DATA(trampoline_ljmp_imm_offset, .word  .Ljmp + 1 - trampoline_32bit_src)
>   
>   	/*
>            * The trampoline code has a size limit.
> @@ -662,7 +642,7 @@ SYM_FUNC_END(.Lpaging_enabled)
>   	 */
>   	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
>   
> -	.code32
> +	.text
>   SYM_FUNC_START_LOCAL_NOALIGN(.Lno_longmode)
>   	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
>   1:
> diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
> index 4e8cef135226bcbb..131488f50af55d0a 100644
> --- a/arch/x86/boot/compressed/pgtable.h
> +++ b/arch/x86/boot/compressed/pgtable.h
> @@ -6,9 +6,7 @@
>   #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
>   
>   #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
> -#define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
> -
> -#define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
> +#define TRAMPOLINE_32BIT_CODE_SIZE	0x80
>   
>   #ifndef __ASSEMBLER__
>   
> @@ -16,5 +14,7 @@ extern unsigned long *trampoline_32bit;
>   
>   extern void trampoline_32bit_src(void *trampoline, bool enable_5lvl);
>   
> +extern const u16 trampoline_ljmp_imm_offset;
> +
>   #endif /* __ASSEMBLER__ */
>   #endif /* BOOT_COMPRESSED_PAGETABLE_H */
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index 2ac12ff4111bf8c0..09fc18180929fab3 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -109,6 +109,7 @@ static unsigned long find_trampoline_placement(void)
>   struct paging_config paging_prepare(void *rmode)
>   {
>   	struct paging_config paging_config = {};
> +	void *tramp_code;
>   
>   	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
>   	boot_params = rmode;
> @@ -143,9 +144,18 @@ struct paging_config paging_prepare(void *rmode)
>   	memset(trampoline_32bit, 0, TRAMPOLINE_32BIT_SIZE);
>   
>   	/* Copy trampoline code in place */
> -	memcpy(trampoline_32bit + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
> +	tramp_code = memcpy(trampoline_32bit +
> +			TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
>   			&trampoline_32bit_src, TRAMPOLINE_32BIT_CODE_SIZE);
>   
> +	/*
> +	 * Avoid the need for a stack in the 32-bit trampoline code, by using
> +	 * LJMP rather than LRET to return back to long mode. LJMP takes an
> +	 * immediate absolute address, so we have to adjust that based on the
> +	 * placement of the trampoline.
> +	 */
> +	*(u32 *)(tramp_code + trampoline_ljmp_imm_offset) += (unsigned long)tramp_code;
> +
>   	/*
>   	 * The code below prepares page table in trampoline memory.
>   	 *
