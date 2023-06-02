Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B7A720A6E
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 22:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjFBUkB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 16:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbjFBUj7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 16:39:59 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7E5E52;
        Fri,  2 Jun 2023 13:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfX9VYKMZttKWQ8sosLNb41zqlo6gbtl8rS8czlYixLlquX0aqSnglPnRDxmFRpCfMhnH8NoCuEJ1K0evBJJgJlqfz+OX3iYQbfinuvDRcAyFerVPlw09bslknGFW7TsFNfRSdOwkwqe4UWkPT/5JURRxIT2h6kF2rp9OjJwahiMvfwwPC8oguB4snjIFrD0z5ugR+Z+7ynqiPnI9/VS2GWFlLc8hooossBaTcpwLA5O+p1xYYbiSVkkcL5TqWFXwLWBjpmbwBpcfJfS7sorXAxGQGcUX0ZcoCzV3E2a85E8BITJJ0itx9rUY5r6GLj1Uz5MZM17WwZQbdBN8FinlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX08GTaq8SXQvbhdo1BhdgN7nSg261NMA/lh25VVhhw=;
 b=YFGMxwjaz5v5zmHKXEw7aouaX7suFuL9NZVWly644moBKC4UM2NKJaKdzVivd94agAxODejLnSktumyVbsokM9Y5oWwRaYYkSjjNgZsrbUxFfyBO74KyenMptTuHSg6TuXGz91RmhIIQY6QZEG48c0M5/+XUp+0BJTd+i2odWhYx/i/ySTYkCrQnb+KJsKUCbc+snXPJ2nIs0ZYM0lN666wSktNEaxIVR5Rp6TsHRwFMg4Y5qODwvxEFCPyGH6pDovADfcanvdmDg6/9FO5NF2GXPkrXGzIvhcGOrH6PatT+obsg37deaQWmoSwCpTh6/P9PGByFEUzH5QdVQJgaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX08GTaq8SXQvbhdo1BhdgN7nSg261NMA/lh25VVhhw=;
 b=hAAgTCCmVgYWhbEoXYOY2CEqBVTAoYpTKoizbi3sI6CQlz83iTzJ3nFzBMEorSiqrDZk2TqsRKs0jHZUogJs3y3GFrPkc0FbhaTUWR+cNM1PxpDPo5j87J94p8KOrO6JIsEoVhkyPxLvbnnS/9TJ2AylWJvoiZizRPDgryQEFo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 20:39:54 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25%3]) with mapi id 15.20.6455.026; Fri, 2 Jun 2023
 20:39:53 +0000
Message-ID: <849a65c8-a320-a8a8-8784-0ee3737eee9e@amd.com>
Date:   Fri, 2 Jun 2023 15:39:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 20/21] x86/efistub: Perform SNP feature test while
 running in the firmware
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
References: <20230602101313.3557775-1-ardb@kernel.org>
 <20230602101313.3557775-21-ardb@kernel.org>
 <bfe5bbac-37e2-6728-606a-c652bafad6b6@amd.com>
In-Reply-To: <bfe5bbac-37e2-6728-606a-c652bafad6b6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc7cfe1-42c7-4ea7-cf1e-08db63a98522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXSef96bdIiPIw1cFjB0oBB+6QWEu/Pj9llZIOw/LSrUWL923/3EOLoUyZ8TdXO35CFi83viXXAUAYYd+v39ElhUbVsr7bBUTYO2/KqVhoxoT255TvER+0JR1NpnjjqnSOxsTu2SdO2x2ixht7u6jTcdXvzWFMQftAcuR+BsB/oXs63juItp4Wm1dmyxEW2zPrNkHdiqlcg1pIxB28eVsyKMjIniisqnOxAyM++Ss0WMAFJQCb5YUid5HH2MiyJ1wA36KWacNpY4+yZDNDkisPTp71leg+eBvFkpxzBia7ZPpuhDtaBUwQlgp5bIHjTRXzDvzo4BeX+lrf8dA/F6+gvTfnu/YTH+T9mQYgA2VgnfbHoTHV0RKIlI/rMMFz76AunJFTvEfJFLxqNJsm9T2FPYaKSk4EB3moFtkQavb4Lv/qAgUHdjXeh0oeIFzzgorBWX42IYUGnSHDIIkMQuxg4V/HRq+tLTSKR25TMbmpSK79lIusqb/VJgFe0YigA84LCi0LcpQzM1qR7NUlp3b3IpNmchqi2kbwYORTMFiTVd5gv7DDYw6tHOUZEgkyB/ebUCG9j4RAVJ79tsJC6s3ZLTIC1AM7GwJH61oKMMTYwMXU9PEVu2Y0OIi5O+0iuzf+PCV/Wto+gRN7nXS9bbbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(66556008)(66946007)(66476007)(7416002)(316002)(4326008)(41300700001)(8936002)(5660300002)(31686004)(2906002)(8676002)(54906003)(6486002)(478600001)(26005)(53546011)(36756003)(186003)(83380400001)(6506007)(6512007)(86362001)(2616005)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnF1WGI1MEF1N2Z6OWphamFva3dnUnNwM3ROUTRxRGxYYnFmQWVMTTAvajdm?=
 =?utf-8?B?Tk0rMUJTenV0QjA3YnFFdVlBR2JoMVlYWm5aQ1ZMdEEvSzFVS0hxMXlNR1Z2?=
 =?utf-8?B?N2FKZXNrZUx1WDZvM1Q4UHBraTI3TmtoYWZUcCt3ZkFXbkNreEhFT1RsaG13?=
 =?utf-8?B?Tm8xS013K1ZLdGZIQzc4d3RvTG9ad2JRWWJDTVhkUUhtUXJNQkJtVHBCZUFF?=
 =?utf-8?B?bktIV0Nrc3Y2bE1Ta3gwMmwvSHByT0VuRDZXd3VRS1JaMjZaZzBWYTlJZHhr?=
 =?utf-8?B?MUM5QUZmcmtJWTZLMmo2L0xlcnozd1NGUHo1clBnZHpKSnRwUjZXU3VXSzdG?=
 =?utf-8?B?d1JFOXF2eHZoTHRSU0xGMXlqR1lSQlY2SlNRaDBGL21qOWhTTjI4d2tzTGlK?=
 =?utf-8?B?WGJUU2p5NnJxVEZMT2F4RUNBUjBvYjRhMlVUOEFNZmh0dXJldzJWUFV5eklr?=
 =?utf-8?B?NGlVV2x6NXNYRXp3YVh3dzhEQ1ZDMEtKS2gweXJLb1RzMWdMaVJydThLa0RU?=
 =?utf-8?B?Y3dRcTg4MmQzcjVyQjdSR0F1RGl6V21jZXYyL0szd05kcFFLVmxIbmh3UHlq?=
 =?utf-8?B?Q1VZdXJ4bVBzL2ZmUFlLUFQvZjg0dTBURm9SQXhEd2pyeENueGNnY1dBc2ND?=
 =?utf-8?B?cFErbno0OWVyNURKbk9jMG5xU1ZnSXlXQkhwTWtBbElVTk5FYWJhNkt3NXVE?=
 =?utf-8?B?NnVTWDJWdjIzam1DRmw3dFo5S0JtQmNYaWlhUDMyZEhaWEwrNWR3YmlmSGVL?=
 =?utf-8?B?MlNkWEtXYlNvK1RQYWM0TjRoTjhDZmxsUzJhaFo3OGhKSm9PYXhtYXBqL21Q?=
 =?utf-8?B?RHBadEFKQ290ZlBZMjFyeTUvd1JKZjZHcGZHYmVJaU5rRUhuVmo2ekxETXcr?=
 =?utf-8?B?c1RwZUlJRUxIR3RKZVlHYlYyYTVMOVByL2kxTGhJUGx2SkxGbCsyWTd4bEpy?=
 =?utf-8?B?YVNkU1dIVVBVQVp3NXlXMkR3ZTNUV2ZhbGNBbDk0L05BU2U0Rks1RE1YMlhy?=
 =?utf-8?B?ZlZoNVVXR0M4VVFaenkyTGJ6SHgyTDR5aU1XWCtPQWgwcWZ3ZEswa213ek5l?=
 =?utf-8?B?QjFKRkhNUXVEWWd0bitIV2kxYjJ4S2kwS2d5Wk5YREYwOEZ2cGdaejJ5K2R0?=
 =?utf-8?B?WGJBQ1N4SG5mSC9LVFpWc2JhbkVMZUdmSTVLMlFVUHNidU15aTdKSFdrK0FR?=
 =?utf-8?B?MDEreVZTbnJWbmpRbnpRTWNOeEV1V0hWL2ZmeEZBM25NdmRNckVxWTJDQTNn?=
 =?utf-8?B?WUkvbXEzTGtMam11a3BvRTQvT3dWOUcrOHJiczVrWEJyUUtvcjJENU1mSDdh?=
 =?utf-8?B?VExuaHhsN2ZFQmVCb3FQQUJNcmFZVDc1Tk1nVzg1Y0hzclNDZksySzUrUHFP?=
 =?utf-8?B?aW9mV3kzbDhRT2NqRUtnZ0UrZDg0RXBqSjU3UWJiemwzbTZOQUp4eEt1cTQr?=
 =?utf-8?B?T2tpSVNXQlpNeE4vTjdzNXhxQ1VqOGxCcUNiRHN3bFZHaVVySnArVDJNanFn?=
 =?utf-8?B?UEdGUTJ4azFkYjZOM3BJc2NzOXN5bWxuaTRSeXkzQVZNbkdhMGMyUHlHT0g3?=
 =?utf-8?B?eXIxeHB6RUhwVW0rRkFpRDBVd2hGRGtZSkpqeExzKzZyM0NLZmF3NEU5bzVH?=
 =?utf-8?B?WWtjU2NQbkNIc1hQR05DeE0zeW1TdWVEdVFlK0ovTUNmeVNNRGZkWUU3dFhI?=
 =?utf-8?B?N1BLSXI1UkcweFZtcytVK2toc3JLZGx0RlBGbnF4L3FxS0N2bWJKZzJ2TTNi?=
 =?utf-8?B?RHhXakVSa2FqZ1BDcmNIRDlFang2alBNM0M3K3QwMXczU2tNaTdzL2dqSUZR?=
 =?utf-8?B?bWIrbFhmSEFmZW5xUG1HUnJkQ0tyZWNhUkU5R1FNdWMzbWwvVzljY2NCOEIr?=
 =?utf-8?B?L1BLOGovdFIwaXVnaGxwWmdaZHdVb3RjZ21xOHhHTGdybzd6d0dZVmR4V1hs?=
 =?utf-8?B?dW1ZQ1VLZzF1UFJBRHhkeFZpWGNkalJGS3JSWnpUa0JxN1JGaDY3dTNVb2pw?=
 =?utf-8?B?OU1DNnY5N1BvT1VRSTVVUWxTcldrUy8veUxqNTJWREhGbFJrVWRNTEY1dyt2?=
 =?utf-8?B?V3MwYTJ5U2hBMmlaWDNIV1pwbk5tbWZXUFdqb3VvS09JS29HblQxOHJjQkUz?=
 =?utf-8?Q?gmc6b3Hg3yI33foCconsGZBEu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc7cfe1-42c7-4ea7-cf1e-08db63a98522
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 20:39:53.9028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1rokWeNoYJjQlMvPgMdHl5/7p7ViKo6Iyy0oeaxI/A1pSUtlNB2mgbfRYin5WNxgSdp97m8Iar+t/r28dLZyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/2/23 15:38, Tom Lendacky wrote:
> On 6/2/23 05:13, Ard Biesheuvel wrote:
>> Before refactoring the EFI stub boot flow to avoid the legacy bare metal
>> decompressor, duplicate the SNP feature check in the EFI stub before
>> handing over to the kernel proper.
>>
>> The SNP feature check can be performed while running under the EFI boot
>> services, which means we can fail gracefully and return an error to the
>> bootloader if the loaded kernel does not implement support for all the
>> features that the hypervisor enabled.
>>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>   arch/x86/boot/compressed/sev.c          | 74 ++++++++++++--------
>>   arch/x86/include/asm/sev.h              |  4 ++
>>   drivers/firmware/efi/libstub/x86-stub.c | 17 +++++
>>   3 files changed, 67 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/x86/boot/compressed/sev.c 
>> b/arch/x86/boot/compressed/sev.c
>> index 014b89c890887b9a..be021e24f1ece421 100644
>> --- a/arch/x86/boot/compressed/sev.c
>> +++ b/arch/x86/boot/compressed/sev.c
> 
> 
>> +void sev_enable(struct boot_params *bp)
>> +{
>> +    unsigned int eax, ebx, ecx, edx;
>>       bool snp;
>>       /*
>> @@ -358,37 +391,14 @@ void sev_enable(struct boot_params *bp)
>>        */
>>       snp = snp_init(bp);
>> -    /* Check for the SME/SEV support leaf */
>> -    eax = 0x80000000;
>> -    ecx = 0;
>> -    native_cpuid(&eax, &ebx, &ecx, &edx);
>> -    if (eax < 0x8000001f)
>> -        return;
>> -
>> -    /*
>> -     * Check for the SME/SEV feature:
>> -     *   CPUID Fn8000_001F[EAX]
>> -     *   - Bit 0 - Secure Memory Encryption support
>> -     *   - Bit 1 - Secure Encrypted Virtualization support
>> -     *   CPUID Fn8000_001F[EBX]
>> -     *   - Bits 5:0 - Pagetable bit position used to indicate encryption
>> -     */
>> -    eax = 0x8000001f;
>> -    ecx = 0;
>> -    native_cpuid(&eax, &ebx, &ecx, &edx);
>> -    /* Check whether SEV is supported */
>> -    if (!(eax & BIT(1))) {
>> +    /* Set the SME mask if this is an SEV guest. */
>> +    sev_status = sev_get_status();
>> +    if (!(sev_status & MSR_AMD64_SEV_ENABLED)) {
>>           if (snp)
>>               error("SEV-SNP support indicated by CC blob, but not 
>> CPUID.");
>>           return;
>>       }
>> -    /* Set the SME mask if this is an SEV guest. */
>> -    boot_rdmsr(MSR_AMD64_SEV, &m);
>> -    sev_status = m.q;
>> -    if (!(sev_status & MSR_AMD64_SEV_ENABLED))
>> -        return;
>> -
>>       /* Negotiate the GHCB protocol version. */
>>       if (sev_status & MSR_AMD64_SEV_ES_ENABLED) {
>>           if (!sev_es_negotiate_protocol())
>> @@ -409,6 +419,14 @@ void sev_enable(struct boot_params *bp)
>>       if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
>>           error("SEV-SNP supported indicated by CC blob, but not SEV 
>> status MSR.");
>> +    /*
>> +     * Check for the SME/SEV feature:
>> +     *   CPUID Fn8000_001F[EBX]
>> +     *   - Bits 5:0 - Pagetable bit position used to indicate encryption
>> +     */
>> +    eax = 0x8000001f;
>> +    ecx = 0;
>> +    native_cpuid(&eax, &ebx, &ecx, &edx);
> 
> This causes SEV-ES / SEV-SNP to crash.
> 
> This goes back to a previous comment where calling either 
> sev_es_negotiate_protocol() or get_hv_features() blows away the GHCB value 
> in the GHCB MSR and as soon as the CPUID instruction is executed the boot 
> blows up.
> 
> Even if we move this up to be done earlier, we can complete this function 
> successfully but then blow up further on.
> 
> So you probably have to modify the routines in question to save and 
> restore the GHCB MSR value.

I should clarify that it doesn't in fact cause a problem until the final 
patch is applied and this path is taken.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>       sme_me_mask = BIT_ULL(ebx & 0x3f);
>>   }
