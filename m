Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC9C63499B
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 22:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiKVVth (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 16:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKVVtg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 16:49:36 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E80468C5C;
        Tue, 22 Nov 2022 13:49:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxlFA4DqDZBuZ1vVONNdKDBH/tFup6gTOLGLwfdvTdh9H98hHz5JpWtSN4L10X9DssnFSe2Qfa/xNtANaSKTG+LnIetjjVjhpaxt8JiiTikzQnK7imEP0j/IozavswcFzG+pIxa6fhNEAJ5EnbJXzyNXZatLeB/v7WZ6su4ivY28tYCBRgwJFebz8F3wDdthtz4egjD8tEYSSWBqG9NGZVeKX/A2cnUQ+nuloyDM6/2pyVT0vp6bYmax/8wub2NKQXVuMaSEPSQCUGZhCCbkJ7nxHMRVrjW1kThzU1B92rILfWo95GO/mNjWaB0YX9qX76jRyvRYpk7gxNUgMtZJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjeLnZuVwkkemV/ovswa6JzrG4WSMW8E3vfW4SmF1pk=;
 b=F5SZZw2Fqihq/CBd6N4lnbpUDVAi8wRGbbTPK4JNSaO3+Gh64jtpCOhQrvrhlQS4seytxXXwk77kT0giiXWrjGHtFXdXy4lG4Zc4RUJGUQH7SUDG/X+MD67zC97yPR4qWtJ8nqi/J/b+N0FFmO+nGyX6vGVTQVKwtfv9hF4Fx2xbitGXABMtlOFCCLhJ/YGxZLfJX1Px0V0G9HVoBTIIMPWWvlSTuQ/HoDnflV6rtkeJyNgL9kNd6d1Wzx+prYQHQepnxZhrUNw8Z56QEMThQrqBUZVdB5cFVxKqJ2PN0lNKAuU50brVaBUK+IrFGaPz2Onr6u0jfOJl35WIdxSxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjeLnZuVwkkemV/ovswa6JzrG4WSMW8E3vfW4SmF1pk=;
 b=2v2pV4YXEg28oSG2E3s/Q42L4ZypebSHdpL5C2jY44o0r/suu66fOMGpf26XxJaB+jf48L4o75+dkKZdmY859rPfHn+t26FP6Mt/s4e1ta/tMcqCDtWPfx1Ry306OHNot+6dxhRRA860KCEQysiOHo8uA9QgnLTosfROzsvoofI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 21:49:32 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 21:49:32 +0000
Message-ID: <26c34f9e-3b09-7b10-09a2-993a50790447@amd.com>
Date:   Tue, 22 Nov 2022 15:49:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 00/17] x86: head_64.S spring cleaning
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
References: <20221122161017.2426828-1-ardb@kernel.org>
 <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
 <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:806:24::25) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f7b579-700d-46e3-9b30-08daccd37067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCdp8bAxHFeJ2UgfQo2iLJpMd29q9C05DXjdApcbz8asoWkETeNvlSQkniIH7+7APxnAafaXkU0UCR42tFYBINTXJsC6VVdd9WNZtiSN9cJvVaQhK/3ciYhygJgPuvPiXYfkJ/oJhAauUSpkSzj3zNuFWun7iRIrwWv3jt27rcBFF9mo5fdUpDLsigou5LNVIyXCWi3/lXUHqLWsID5FurG59R9/hRef8GrDFrpvEpuK0XIuHqQFoQX28UQ8rbjKkz21+NgPleDRphUV1TP/y7EjP2ZS/3MHE1cXHzM4r4i2lc2bvl+abnhWwC9f0Aw2v3uYArrY+TEHQN3I1uNsAh6EE7DZ1WAE8jdkm+Vv/Jp112loVxI1tArwgIDpxDQgXqDFuhbVgJ+WPDcJGwYUBD4oMqbZBvwsIvgzinutV+2RyGBUzcl/wQpbVBV+b14xp9nyZN7cXAFUeTIF+O8ct5LOAv+KPxSU+yI9aXM1C8hvox0aKki69bKi5ti1ceqUwhOrOqvfb1is2GWQ2iPeJfLA0OmnjiPfe/64iv2QcBIoQqqTPlWwinoC1oq0kzvoF72a2tnQ+wtZbP/3moxFZRzAFFksLoajvCMun6mMo+Bg+gOIQL/aSS4WI4duEH8eFFLGcUAR2ekE/E3ypF18ARQSW/quTLbT42wouLrJpPBak0Hv8ADRIFUEMTwr9/TB7xhr7LIvrfJ7VMTXOkr/15MsBW0/HPKxoJE0g9bUZSE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(2906002)(8936002)(31686004)(36756003)(6916009)(41300700001)(316002)(66946007)(54906003)(478600001)(6486002)(66476007)(66556008)(4326008)(8676002)(2616005)(53546011)(6512007)(6506007)(6666004)(83380400001)(26005)(31696002)(86362001)(5660300002)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmY5TWRERjZUSndERjNRb0pGU2Y0OStDbEVQWGwxdDUwODhsSDdBQjcvdTBm?=
 =?utf-8?B?ZjdqK214N1hNbUVxNjJTb3JBY1laOGdyVXY2VWVCbjNHWnErM2VZVCtRT3Vx?=
 =?utf-8?B?YmNnVkdaSklVS2IwWkdHVmNsazFPYVZZdDZFeVFKZkZwZ3c1K0IzWE11ZXNx?=
 =?utf-8?B?VTJtdnNBODNWa1BDWGd6dDV5M2NROHh4am1NRlI2OEsvdFM1UTltaWZEVmRZ?=
 =?utf-8?B?T0ZMVHFDa3REQmJobi9SSE1oWWppQTExejR1YmlNZkZyOExuZmsyOEUzTlU2?=
 =?utf-8?B?NDYwNHQvME81TWl4SFRXMXZCRE9MRWdGcmpJdittV1ZOd3JvYmhOUWVKdE44?=
 =?utf-8?B?T29JVTVvSzZjSG5vZEFZMVpDWU9NeUVBa1ZrM29YTVdPbnlHVGtOWlBrbytt?=
 =?utf-8?B?SHZsM2NGdFZjRnE1NnM3Q3duQUlSai9LN0ViYnUvYm1zMVJKUEZ2a3B4RXFV?=
 =?utf-8?B?QnVrZWNBSHZwQ0xXaWdTYzZ4eS9DRzk0cG9RaDQyUGhWcm4rY3pHT09id29R?=
 =?utf-8?B?b0sxenI3Q1pJZzJUR1hLZ2ZOY3pOVGhOUUdSc3ZsOGUyTSs1NmZaczRaa3kw?=
 =?utf-8?B?QTNZakpkNGZhdDFiTFN2UHpRRUh5U3R4WTByOTRITE1LSURkUCtwU0JRTTRO?=
 =?utf-8?B?M1YxQ1ZxbWZyWUlMaEQxV29ZZzdkRzZWeGJSNW5ZZGs1NEZ3VkRVODkxM2Jh?=
 =?utf-8?B?VDNqSkZzU25OVXFWRForRjFGUkJRamRGZnRWcThudnc3K1YzM2U4S0ExYWRz?=
 =?utf-8?B?czZJbjl4L0xWQWRCSEdvZHIrekk5bHc5R2dQcXYzVmIyRStoc0JXTG1aaWta?=
 =?utf-8?B?eUE0cDRJdHF1TVJaL2ZCZ2RLNVE5QVVxMlMvd2JkWkN0c3NiK01wby92bDls?=
 =?utf-8?B?YlFhSUpsRUkrRUNEWkdFYXI2Q2pUc0FkODRGVnJCRU82NjlLV2I4MTgyV2Ux?=
 =?utf-8?B?UWh1enFGeE9JaDVtNmNpODdFelA4eHpSWW1kTWZPR3lwRXVzbTFmdnpram53?=
 =?utf-8?B?NUNJd21yTzA3ZlJuZS9LT3BEb0ZpblBSR3JBZTE4RUVZazN2M2hxTUg2MktF?=
 =?utf-8?B?Z0Z2ZkpsbTh2RUdPUU1yWVoxcldIWXFnM3dkTHhYMUx6TzhaZUw5b2ZLcmtP?=
 =?utf-8?B?aGd0c2w4Z0FQVzE0S0tOUExtTHFXM2FEQ1VwcnVXbjRiMU5pRHdIVjV6S3Y5?=
 =?utf-8?B?T2UxSXN1OTBWMDJ4OUI1SGwyeVZIMnNObTViYlludTB3bGw1YTYvU3lMZDll?=
 =?utf-8?B?U3V6ODhUcVZORCswTzVnbnRaQmJsRzlVeUtabXZDekVZTmtaL1QxUUlNbHdD?=
 =?utf-8?B?RGl2YXNxK3A5VGlubUtQbFBRYzZ4YnR6S05keVQ1K0hhakdwTkNPb1k1Vm9Y?=
 =?utf-8?B?Zm5Dc3VsdjhudnZ3SW4xbi9tazMwTzgwbFF3VWtXQjEzSjNPOCtOaXVXbWNZ?=
 =?utf-8?B?d1k5WXowdU03Ylk2bVV4S0picWt3d0lqZGZLd005ejMzNCtweDhRTEJrYW9h?=
 =?utf-8?B?aUUyS1FXZXVrRHZ3R29VOWRuVWJHZ1pYd3l1VWI3ekdKdmpzM0twS3oydUgv?=
 =?utf-8?B?Qnd6L2E5SElBOVNZMER4RnAzTEZnYXkrZEdUV2NhQVBXRGNGNjY1bFEvNk5P?=
 =?utf-8?B?T0FsMUNPUGV4czh5d1lMeE5RcHhjMUFuSnZMR3djQktOajR6R0puRGFwUW9L?=
 =?utf-8?B?RW9BZ3paWFhvZmRXUmtYeDJWaTVLVkw2R1VqWW8yTDBwcDdVRkpjM2cxYWJo?=
 =?utf-8?B?WHVPMFhmenpGaVFhL1RZQ0RFTHkxcFdvc0VLSlFtcVUrR0FEZExEekgrYVdG?=
 =?utf-8?B?OXNERjhjZTJwZW54QU4zcFFManh6aFJPT280eUJxbXpOV2VYcU04My9CMWZj?=
 =?utf-8?B?ak1rTDZ1VTJmN2tIWCtDTFBaWW9kR2VlZlZidWxRd2xGMFBsdkh6RXpYck91?=
 =?utf-8?B?Zjd4SU44SElURHBpWURGY1lHQVdHNllTazltOG5xUXdnRytLcEdWNjRDUVFw?=
 =?utf-8?B?bG5VYjRiSFQzNWQvYXY0MTNkODZzK3lnK2N6eXdmR0lpamRYaXpKWjB0aWpJ?=
 =?utf-8?B?TlkvdmMvcmUrR1VnZTlmcUxrQjYxWHVxWE9QZkx4bE5mTVk1Vi9Fa09Sdmtj?=
 =?utf-8?Q?UCiO2CEhEbuSYxwJqyxXUQ2aU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f7b579-700d-46e3-9b30-08daccd37067
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 21:49:32.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGESXSweGPuM3t+0N+re1acNA777AfqgUfrarcVH4A/ci/PqAG3OXR13smXqepMPwUb8JpFGlTFVkNZ68+JAIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/22/22 15:37, Ard Biesheuvel wrote:
> On Tue, 22 Nov 2022 at 21:48, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 11/22/22 10:10, Ard Biesheuvel wrote:
>>> After doing some cleanup work on the EFI code in head_64.S, the mixed
>>> mode code in particular, I noticed that the memory encryption pieces
>>> could use some attention as well, so I cleaned that up too.
>>>
>>> Changes since v2:
>>> - add some clarifying comments to the EFI mixed mode changes
>>> - include patch to make the EFI handover protocol optional that was sent
>>>     out separately before
>>> - rebase onto tip/master
>>>
>>> Changes since v1:
>>> - at Boris's request, split the patches into smaller ones that are
>>>     easier to review
>>>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: Michael Roth <michael.roth@amd.com>
>>
>> This causes an SEV guest to blow up on boot in the early boot code. It
>> looks like the stack pointer is not valid and it triple faults on a pushq
>> instruction (pushq $__KERNEL_CS in arch/x86/boot/compressed/head_64.S of
>> startup_64).
>>
> 
> Thanks for the report.
> 
> So the mystery here (at least to me) is that all the changes are to
> the 32-bit code, and startup_64 reloads the stack pointer from the
> symbol

I bisected it to:

99b7f4b23d9f ("x86/boot/compressed, efi: Merge multiple definitions of image_offset into one")

And doing the following fixed it:

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cb5f0befee57..a0bfd31358ba 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -23,7 +23,7 @@
  
  const efi_system_table_t *efi_system_table;
  const efi_dxe_services_table_t *efi_dxe_table;
-u32 image_offset;
+u32 image_offset __section(".data");
  static efi_loaded_image_t *image = NULL;
  
  static efi_status_t

I assume it has to do with being in .data vs .bss and not being explicitly
cleared with the encryption bit set. With the change to put image_offset in
the .data section, it is read as zero, where as when it was in the .bss
section it was reading "ciphertext".

Thanks,
Tom

> 
> Does your config have CONFIG_EFI_MIXED enabled?
> 
> Can I reproduce this fully emulated with QEMU? Or do I need a SEV host?
> 
>> Here is the Qemu register dump:
>> RAX=00000000029cc260 RBX=ffffffffdd98c000 RCX=0000000000000010 RDX=0000000000000002
>> RSI=000000003dec1000 RDI=0000000000000000 RBP=ffffffffdb000000 RSP=ffffffffde36e000
>> R8 =000000003dec1410 R9 =000000003dec13fc R10=000000000000006c R11=0000000000000000
>> R12=0000000000000000 R13=0000000000000001 R14=0000000000000004 R15=000000003eacdf44
>> RIP=0000000002000263 RFL=00200002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
>> ES =0000 0000000000000000 00000000 00000000
>> CS =0038 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
>> SS =0000 0000000000000000 00000000 00000000
>> DS =0000 0000000000000000 00000000 00000000
>> FS =0000 0000000000000000 00000000 00000000
>> GS =0000 0000000000000000 00000000 00000000
>> LDT=0000 0000000000000000 0000ffff 00008200 DPL=0 LDT
>> TR =0000 0000000000000000 0000ffff 00008b00 DPL=0 TSS64-busy
>> GDT=     00000000029cc270 0000002f
>> IDT=     000000003f55e018 00000fff
>> CR0=80010033 CR2=ffffffffde36dff8 CR3=000000003fc01000 CR4=00000668
>> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
>> DR6=00000000ffff0ff0 DR7=0000000000000400
>> EFER=0000000000000d00
>>
>> Thanks,
>> Tom
>>
>>>
>>> Ard Biesheuvel (17):
>>>     x86/compressed: efi-mixed: rename efi_thunk_64.S to efi-mixed.S
>>>     x86/compressed: efi-mixed: move 32-bit entrypoint code into .text
>>>       section
>>>     x86/compressed: efi-mixed: move bootargs parsing out of 32-bit startup
>>>       code
>>>     x86/compressed: efi-mixed: move efi32_pe_entry into .text section
>>>     x86/compressed: efi-mixed: move efi32_entry out of head_64.S
>>>     x86/compressed: efi-mixed: move efi32_pe_entry() out of head_64.S
>>>     x86/compressed: efi: merge multiple definitions of image_offset into
>>>       one
>>>     x86/compressed: efi-mixed: simplify IDT/GDT preserve/restore
>>>     x86/compressed: avoid touching ECX in startup32_set_idt_entry()
>>>     x86/compressed: pull global variable ref up into startup32_load_idt()
>>>     x86/compressed: move startup32_load_idt() into .text section
>>>     x86/compressed: move startup32_load_idt() out of head_64.S
>>>     x86/compressed: move startup32_check_sev_cbit() into .text
>>>     x86/compressed: move startup32_check_sev_cbit() out of head_64.S
>>>     x86/compressed: adhere to calling convention in
>>>       get_sev_encryption_bit()
>>>     x86/compressed: only build mem_encrypt.S if AMD_MEM_ENCRYPT=y
>>>     efi: x86: Make the deprecated EFI handover protocol optional
>>>
>>>    arch/x86/Kconfig                        |  17 +
>>>    arch/x86/boot/compressed/Makefile       |   8 +-
>>>    arch/x86/boot/compressed/efi_mixed.S    | 351 ++++++++++++++++++++
>>>    arch/x86/boot/compressed/efi_thunk_64.S | 195 -----------
>>>    arch/x86/boot/compressed/head_32.S      |   4 -
>>>    arch/x86/boot/compressed/head_64.S      | 303 +----------------
>>>    arch/x86/boot/compressed/mem_encrypt.S  | 152 ++++++++-
>>>    arch/x86/boot/header.S                  |   2 +-
>>>    arch/x86/boot/tools/build.c             |   2 +
>>>    drivers/firmware/efi/libstub/x86-stub.c |   2 +-
>>>    10 files changed, 533 insertions(+), 503 deletions(-)
>>>    create mode 100644 arch/x86/boot/compressed/efi_mixed.S
>>>    delete mode 100644 arch/x86/boot/compressed/efi_thunk_64.S
>>>
