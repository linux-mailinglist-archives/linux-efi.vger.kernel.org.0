Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F21720BA2
	for <lists+linux-efi@lfdr.de>; Sat,  3 Jun 2023 00:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbjFBWB3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 18:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjFBWB2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 18:01:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75CB1A5;
        Fri,  2 Jun 2023 15:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWVKH2w4hRL0yyjctoIPi/1OfaQjS6sgZi0q2d/B99F9hPBsn6bQj8Pj2Kqj4YiEiug/H0M0IrvLtJbEyt3iuqR2N7R0Aewv3kFCEfReMaBfNVuhUag1LAnDzTrkNz2hR4g0SyptJRAVNkV1qa/ptKAxI/Mxk9zACykEDmZHycG4DyoWK9k42UlPlADpcyQ5cX94AYhmAFh0zKc5nOOHCf+7YaS/I1wGn0rIE+9Z3h5Lb+3Z3UCFZjBiWRPryy+S1/FhOVjgDzw0MIZumLYDf0YuJ7fLHbFnn9VoCHuZR5fooBHEBX4AQx9RuUilxV5WVy68tLX6Exim990pTjh+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWxrddmo2wG+0zV7pIxfPt5kNaHC17v5mRJbZRPQ52M=;
 b=bxMpNe/flmo61CLL7gII1nd8ZzGCArOXRkbILioAOWu/1pDyoFsbdweNWusBhKXgDpXm7XfA2sqksVVtkZVh4TTPWVRpwKVWHsmu2aVIwFXZY2NR0pYXVOFDrtRnxd5rSjsKMViD0BWwazYSjpRXDuyhGDv19ngcBNTGU9tLPneMxbKYS9yOqe25rCpXaNtGezlqmirGyJljV/OWEOQIIz4mvKNbOHAZgi/Z9079CVV6Uk/xaBhSElCVWmJqKxR9PxGpOndoNZpz7cMOOxum2nhpS0QmPRXwCP+S4JfvBATyW0srd6IZxW1u1gy2i6xgSke7p8ar8R8VCalzgmGwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWxrddmo2wG+0zV7pIxfPt5kNaHC17v5mRJbZRPQ52M=;
 b=XjTjKJJSCCO8WfBWCQfy3sfVwog4JY4aBl/AsgcUTPr7ZrIaglDYLyT/LpBBFoarckKb8sKJEgiE15JJkvk5ympUucpFmjLbrebWdO2uuEs9J4iGDIUQToiJCO7kE0V1mZi+YyQ5pTk1wIEXS00BL+LTbmt1zKFBUEz11gSdmDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Fri, 2 Jun
 2023 22:01:19 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25%3]) with mapi id 15.20.6455.026; Fri, 2 Jun 2023
 22:01:19 +0000
Message-ID: <16830132-f270-5c3d-37ae-6bfbc0e7c13d@amd.com>
Date:   Fri, 2 Jun 2023 17:01:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 20/21] x86/efistub: Perform SNP feature test while
 running in the firmware
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
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
 <849a65c8-a320-a8a8-8784-0ee3737eee9e@amd.com>
 <CAMj1kXGwKfbX+tvch0OiyN69jhOOi_zcUdkzXf2ipQ4Gd++3FQ@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXGwKfbX+tvch0OiyN69jhOOi_zcUdkzXf2ipQ4Gd++3FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::12) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL0PR12MB5508:EE_
X-MS-Office365-Filtering-Correlation-Id: 22dfb3fc-2bac-4c20-1dc7-08db63b4e4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjogxZAhQOz682WInU4nUTrPuswyJ/aa3fAxf1NMXRmaI+39rDntg1YKLlU5FNNvl4eTKCJPmxy5eLHhB8ffxeVfA/28n2f/pwDJhpEeAyIGjSlIRdugcOq1AlVLa6DrGGEhEd08VcTmOCOG4M5iwyJDTjpOpe6H6x9TWnwCzNDlgNo8R0gogc3mpLCesW7vOQKB1DVYqfTEB9M0nWksi3OVYQjh1Q39hKlAesjGMlWWlwdMiS3rxABQPA63cYVGSYI998DvBZkfmuZHpf2+mVmxt2zmuAeWt8c1D0su4xZIp8dN0MggpvyKob4jPMZzrnoC5BCkMWc1wGY0IdI6ndCnFt2PmvyfMvJTFRn1rDfEHZKHuD5QKVsjEwk88GReikppQxcQ6n+j8w5TwVDXmvA/GRSpuLhR6U2yKWvs84f3OnRAZatAX/U/3t1ZhiVDQasartDHspyynq0xJvCA1xh6g6wpiTuDNZPis1BlH7cpX2rPkUn3Nnfpym1pFlW16eheZvzACr6Z9fRwUxQLI2jowTP6fhKXi577tFeZPIZNo1cdASTxOkV5XVLxGilzlGeUEY8UqwVACRnGeh+Zl4V8E+8ro6e4jbaY58n9TK7R6TdZxuakIHfOXQWGpTETaLRHE5vLfnMu89elNCNm2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(6666004)(86362001)(478600001)(31696002)(2616005)(53546011)(6506007)(26005)(36756003)(6486002)(6512007)(186003)(5660300002)(31686004)(2906002)(316002)(38100700002)(41300700001)(7416002)(83380400001)(4326008)(66946007)(66476007)(66556008)(6916009)(8936002)(8676002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmN6VkU1eTJzbmR6SnJDZElKVGJuQmNTcGpUbmdvL3Q1SGZDMGE4bFFGSXJU?=
 =?utf-8?B?TXdFYWU0dG9BR2owbTJoL0RjWW9EK0NjcjNIbXJEaUhJNkk5R0NoaHJJZ2dn?=
 =?utf-8?B?MXVST29HK0lpbDB2ZXdKb2JYNHV5WkZxTUExclIzVXBPY1l2clJNN1VTTUxR?=
 =?utf-8?B?bS9YbmNEaGVFOHR4cnJ5ZnJCRStEV2dkeHA1YTZZMXZESHpTM1RZbXhvb1ZD?=
 =?utf-8?B?Y2ZmajJrWHFFT1R2N09QaC9tcis4dHpSNWs0Y29XdlpBNng4UkVlTmR5dUVi?=
 =?utf-8?B?TTBYbjNacWlNMmpiZ2hrMW1ZR1g2QW9JREdiTUtlOXNBM1V2YXd3WC82MmdF?=
 =?utf-8?B?Vk9SOXNqZnJVZGNDSzY0TTA0cjNHRlBWYUZSOUluODMrNStDRW9FZjBFKzB6?=
 =?utf-8?B?SGYwTzMrU0QxUVZUNGwwMHA4aVQxbFBJWkZMQlVJSDBxT2RoVVU2R2RhdkEw?=
 =?utf-8?B?OGMvMy9XK25GMUdvWkNYTVpTWTd3UmVyKzZJM1BXd2g3Q0F4eDB1Zk1Bbmwy?=
 =?utf-8?B?T2srekF5a0dHUlkyZjB5MktsdkxQVnJJbkNWVVR5NlhyajByUnp6M1J4TUFl?=
 =?utf-8?B?eExGL0crdW4rd0ZkNGFNWDQwVFF3S2FWNUVIV0p0UjU0MmhQY3FzcVNnSzRR?=
 =?utf-8?B?VGF0ZlVYQ1JobENEUk9hQ2UrZndrcTc4UjVtRzFwUE9JazhHc0ltZ21mci9j?=
 =?utf-8?B?VitSMEFwQkZrbzdqREtFOXJQZzVLUjMzb2RWOG13OEp0QjBxSklzYUpYdXMw?=
 =?utf-8?B?dWt2c21oOHNKUUF2MlFLbUN4QVliN2k0RjFoV0F2YUdkWE95a1lOR2I5NFE4?=
 =?utf-8?B?THBVNkpoRndpTUZhKzYwTlZRMXJ1UnZyalEzM3YxL0RpYk93dFFiNU91dDIv?=
 =?utf-8?B?c2NlYWpWTENEckxyUUN6cG90eHRoZlloVmRzVjc5ejRWdjBGLzkrb2c3M1lk?=
 =?utf-8?B?eTFTazdPK0JVM1pscDdjR1RjYldCbU1zSkpYaFBxZFk1akVvaWZWQlhWZVo3?=
 =?utf-8?B?c2podDNmRzBZTGdOK240M2Zjbm9MZ3AyM09nNjlXZ0R4a3pxMUlVSHBxUHFq?=
 =?utf-8?B?dm10eDdRVElxTXpsTzNXd0hSejNXRnlDTjhESFFMMS9yUFFHcnBBcm1JcHZW?=
 =?utf-8?B?RnNKWUpvMDZWdEp3TzUrN04vUGpVaWkyYVpHT2FzbXJjVU5UTW1NeUMxbkR4?=
 =?utf-8?B?bG8raTIyd0NSdlVHejlUZmxNVTBiNE1JSkJQa01sV2JhYmVUR0paTGxiNGVK?=
 =?utf-8?B?QXMzTjluVFBRcE94OEdIQ0NMR3pZTzJDYnV2SGQwMmRoM0dpbGJTaFZOcDl5?=
 =?utf-8?B?QXQ0ZnRoa2JhK0wrUy9KeHFTbWVWRTJFMzZqVUc2WTZoNXlVN0FWNVpiOVNk?=
 =?utf-8?B?Q0d3N2k0bE1MNHJuUTRNSVV3a3orOGgvdjU0OGx5c0NNZmF5dDZ0c1FZZ3ZO?=
 =?utf-8?B?TlVKZkFGL1V2M2lnZ0NJUkkxQlNxalB4QTlUSTVKMHduQlZhd2ZsKysydG5L?=
 =?utf-8?B?ME1WOGFBRGs2SktEZHBadW1ON2FnVkl1dEJaWmdhUDM4WGFlcjNBbkJrU3py?=
 =?utf-8?B?VkpmTnFiVm12bEYxZ3FGbVVOV2VEUmo2S3RwcUo5blVoZnhxTjBXbUhSckhK?=
 =?utf-8?B?OTlHRkl3VDF5bHpuYTNTM1d3UUJsSDJEZmp4ZGU2ZEFXT0RCcDdoZGNzcWpD?=
 =?utf-8?B?V2hrZ1FLSTB1N2RLdTFrSjhzZ1ZFTzJwYmxGVFpiVW9ZUFFWZ0lkTUZCV051?=
 =?utf-8?B?TzBKdnd0RHVTU2c2TmhubGV4STMyQnZ0MDZ3T0RKLy95ZzZZTlRJWEpoNFF4?=
 =?utf-8?B?RnZJTWxNUDFOa3E2YzREbHJ3cll2SWxMdXlHU1FacHNGc01jMTZuZ3Y5VHNW?=
 =?utf-8?B?MncwU2V0aXhXeWt5WFVPWXZVcVhQa2lTRElyTEtMTUpEanBqclVlbm81UHov?=
 =?utf-8?B?RHNMZGpMUE1FekNpazFzQzFUM3FsWHpiZVA5TWdMd2xUM3dXVExySkd5Uk93?=
 =?utf-8?B?SU9CNG15NHZBSFhCSFVPcXJTazY1QklEZDFVWDI3UkRidFhYR29XTERxemRV?=
 =?utf-8?B?NDN0U0FKMFN6YmRsOUNKMTZDUG03WHBuQSt4cDY3REhvK0Z0QW9DTjVrNk1G?=
 =?utf-8?Q?SKX51OYu9RbSG7SfcLstZ0877?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dfb3fc-2bac-4c20-1dc7-08db63b4e4ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 22:01:19.6572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1UkiYKiRe8xZ9V6wUuef6gvB6hkfCWZUwfPTgOD3nVGczGmLMHWpLWSyMXp5i7MrhUov6t12UttlUCqaZd+hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
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

On 6/2/23 16:29, Ard Biesheuvel wrote:
> On Fri, 2 Jun 2023 at 22:39, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 6/2/23 15:38, Tom Lendacky wrote:
>>> On 6/2/23 05:13, Ard Biesheuvel wrote:
>>>> Before refactoring the EFI stub boot flow to avoid the legacy bare metal
>>>> decompressor, duplicate the SNP feature check in the EFI stub before
>>>> handing over to the kernel proper.
>>>>
>>>> The SNP feature check can be performed while running under the EFI boot
>>>> services, which means we can fail gracefully and return an error to the
>>>> bootloader if the loaded kernel does not implement support for all the
>>>> features that the hypervisor enabled.
>>>>
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>> ---
>>>>    arch/x86/boot/compressed/sev.c          | 74 ++++++++++++--------
>>>>    arch/x86/include/asm/sev.h              |  4 ++
>>>>    drivers/firmware/efi/libstub/x86-stub.c | 17 +++++
>>>>    3 files changed, 67 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/arch/x86/boot/compressed/sev.c
>>>> b/arch/x86/boot/compressed/sev.c
>>>> index 014b89c890887b9a..be021e24f1ece421 100644
>>>> --- a/arch/x86/boot/compressed/sev.c
>>>> +++ b/arch/x86/boot/compressed/sev.c
>>>
>>>
>>>> +void sev_enable(struct boot_params *bp)
>>>> +{
>>>> +    unsigned int eax, ebx, ecx, edx;
>>>>        bool snp;
>>>>        /*
>>>> @@ -358,37 +391,14 @@ void sev_enable(struct boot_params *bp)
>>>>         */
>>>>        snp = snp_init(bp);
>>>> -    /* Check for the SME/SEV support leaf */
>>>> -    eax = 0x80000000;
>>>> -    ecx = 0;
>>>> -    native_cpuid(&eax, &ebx, &ecx, &edx);
>>>> -    if (eax < 0x8000001f)
>>>> -        return;
>>>> -
>>>> -    /*
>>>> -     * Check for the SME/SEV feature:
>>>> -     *   CPUID Fn8000_001F[EAX]
>>>> -     *   - Bit 0 - Secure Memory Encryption support
>>>> -     *   - Bit 1 - Secure Encrypted Virtualization support
>>>> -     *   CPUID Fn8000_001F[EBX]
>>>> -     *   - Bits 5:0 - Pagetable bit position used to indicate encryption
>>>> -     */
>>>> -    eax = 0x8000001f;
>>>> -    ecx = 0;
>>>> -    native_cpuid(&eax, &ebx, &ecx, &edx);
>>>> -    /* Check whether SEV is supported */
>>>> -    if (!(eax & BIT(1))) {
>>>> +    /* Set the SME mask if this is an SEV guest. */
>>>> +    sev_status = sev_get_status();
>>>> +    if (!(sev_status & MSR_AMD64_SEV_ENABLED)) {
>>>>            if (snp)
>>>>                error("SEV-SNP support indicated by CC blob, but not
>>>> CPUID.");
>>>>            return;
>>>>        }
>>>> -    /* Set the SME mask if this is an SEV guest. */
>>>> -    boot_rdmsr(MSR_AMD64_SEV, &m);
>>>> -    sev_status = m.q;
>>>> -    if (!(sev_status & MSR_AMD64_SEV_ENABLED))
>>>> -        return;
>>>> -
>>>>        /* Negotiate the GHCB protocol version. */
>>>>        if (sev_status & MSR_AMD64_SEV_ES_ENABLED) {
>>>>            if (!sev_es_negotiate_protocol())
>>>> @@ -409,6 +419,14 @@ void sev_enable(struct boot_params *bp)
>>>>        if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
>>>>            error("SEV-SNP supported indicated by CC blob, but not SEV
>>>> status MSR.");
>>>> +    /*
>>>> +     * Check for the SME/SEV feature:
>>>> +     *   CPUID Fn8000_001F[EBX]
>>>> +     *   - Bits 5:0 - Pagetable bit position used to indicate encryption
>>>> +     */
>>>> +    eax = 0x8000001f;
>>>> +    ecx = 0;
>>>> +    native_cpuid(&eax, &ebx, &ecx, &edx);
>>>
>>> This causes SEV-ES / SEV-SNP to crash.
>>>
>>> This goes back to a previous comment where calling either
>>> sev_es_negotiate_protocol() or get_hv_features() blows away the GHCB value
>>> in the GHCB MSR and as soon as the CPUID instruction is executed the boot
>>> blows up.
>>>
>>> Even if we move this up to be done earlier, we can complete this function
>>> successfully but then blow up further on.
>>>
>>> So you probably have to modify the routines in question to save and
>>> restore the GHCB MSR value.
>>
>> I should clarify that it doesn't in fact cause a problem until the final
>> patch is applied and this path is taken.
>>
> 
> Could we just move the CPUID call to the start of the function?

I tried that and it allowed sev_enable() to complete successfully, but 
then it blew up after that.

But I noticed that the patch to apply the kernel CS earlier is no longer 
part of this series. When I applied the patch to move the setting of the 
kernel CS directly after the call to startup_64_setup_env() in 
arch/x86/kernel/head_64.S, everything worked again.

That patch hasn't been pulled into tip, yet, and since you dropped your 
version, the CS value wrong and the IRET from the #VC blows up.

So as long as you pre-req that patch, unless Boris or Dave would prefer it 
to go in with this series, moving the call to native_cpuid() up to just 
before the GHCB protocol version negotiation, works.

Thanks,
Tom

