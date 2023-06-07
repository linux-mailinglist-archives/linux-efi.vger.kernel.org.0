Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CA9726751
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjFGRaL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 13:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjFGR3p (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 13:29:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFE11FCF;
        Wed,  7 Jun 2023 10:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hL4LMQnpsuX0zLjpqqlFKE5r6kxsQaO1VRIHx7jESVzxrFovO64rz/7Da9vAS1a0Fv03T5Vkccmn8FN6QMbHE/twDcj/LISKPw3//3VMImFa37v6EKa86jOIzZ7CL1Kxsxsoz7hBl8sz1amqJIfNSytwqkCH2L3WU2UMm45mTLVAhtxishwscfXAt6bcoe6PXYQspAXftY9pNzVO1to6MloQh+i5VTZ+K2TzrpN181RSHixr3ISicXJvIBA0Eb6bYDOP70cgLYTJ9uErY1EtpEfKidY8Nx53IxerkjNG2cXA71jArRvVHdyLBaYmlXg3hSEPnnPHuPHPks3z3oX3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbIZexk6fUU1W6zls3P6lgWekClv8a86spEfOzeJCOc=;
 b=fAFrve1YP1a7GJ7DR9qEeRe4b0PZgTre0I5qzq920U4Ah2U0RMX7PO2PAVchWQ7zuAykQjeme13TBBP/Q30KnzN9ykH78750p1JfpK7TnMmgzdN+fhxLfYxdAzIZTiYXsSdAppeUkBqEoTORsJYfXIu/tgtHsDpYu8WIUnnLv3189gAndPuSx7vfYD1iFFN5KHiN9ntqJSmI8vgVQTVfNLK8X1VPL8uM01L5J8cdcApvIzwwN0l1C8qsqcXPZ6icLJfNcTqmbZ4k4CgkfzKfvmfq12/Nw4F2d5sesmDA+NjfkwN91W8Kr16BFinw3kmNo7eOaX2HbRUE3lIYj23QGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbIZexk6fUU1W6zls3P6lgWekClv8a86spEfOzeJCOc=;
 b=vtfkXkbyk5uXITwtheLSnmZuZJX3LjQKOnIxI0rQz+d/Xn3E+2m6WX8Lg1/paX3LOWqWomdABUurYFB4UyjG+cp0EEAjTEqrxlA6Bhuf/5lsP7cCABM9PedlNFMVZOZ5QbjdcoqM3MSBnQTJFVnIS8XdDQLjGpbTECzx3yImdyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 17:29:40 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1629:622f:93d0:f72f%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 17:29:40 +0000
Message-ID: <4610db60-6fa0-a0ae-8c74-23f14236cff7@amd.com>
Date:   Wed, 7 Jun 2023 12:29:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 19/20] x86/efistub: Perform SNP feature test while
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
References: <20230607072342.4054036-1-ardb@kernel.org>
 <20230607072342.4054036-20-ardb@kernel.org>
 <46f93827-630a-32f0-555d-aa51a2fd2a60@amd.com>
 <CAMj1kXHpxqvbo_NcgzAAHsE71GohoCcttatMXZsjVvXqPBO33w@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMj1kXHpxqvbo_NcgzAAHsE71GohoCcttatMXZsjVvXqPBO33w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:4:ad::33) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: f262063d-efc6-4165-d0c2-08db677cc601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 860ftsszYa07tbpO+TW3L71mwewkLl2R+BOeerbxbx7SHI+6hSbU1qa8BWNVW3k90w1Z7NJ1aTXgXuxMxqLDV7RK/SvMSn0sdIWPcDCwz9U7vNfHPjV4k3fZCGtOx4Zn1x5MZDAMnNV11gnvDCitOxEeRRl3ht3GAz1Yzjse7dN1zyn3bOdOvEfzXilM7tDVLm69PxrFtrSAlOZ2l3GmdDJJvVCZjIsCWxO9eCf1JzrXD3aQ6ZobL2idypTKvT01EY4yKImu5JObZbjPAP/3VCB3AGSHTgUpHldmhPnfW2RElcF5adUKrjGvWdP2vt2/P5aKT74Ot/xG8AhiwXIX9Zd1A/0GcLd9x0KovMSFhtIyAzuPBxoScGQYErjQsNDU7fZd3+0S6AqMu/+vpR1oaxL5sOzmUn5E8/cb0kITAnhIUJXEBHozJAcqSMgNDGlV+vlkWj9pudQrLSnh2jSl2qioiKwOjpOouKLbAXOj4YdLHZXZ8+RoIQB+BJ6udrikfhUCG/uwxp+yLkuBVZMpzHodDz3Czwup/v5Mp12k2tgFOaeZHYc6664JKm9VfWiUjDmkg60c9mDZPiC8ciKr6RuyMmtI3cRo1DyHkFCBPgGflQyXFD53pMSfA9jKsnJQxOZ3rk8GuJxXl2q/zhxD2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(31686004)(26005)(6512007)(186003)(41300700001)(5660300002)(6506007)(53546011)(36756003)(7416002)(4326008)(316002)(66946007)(66556008)(66476007)(6666004)(8676002)(8936002)(83380400001)(2616005)(478600001)(54906003)(86362001)(31696002)(2906002)(6916009)(6486002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG9TTW1jNzh3cm1Sa1BINE1tby8zYkFkcmtyeDNaUnkwaE1tWGMreTY1NExN?=
 =?utf-8?B?TklWWjFBcHJ2Q3hNVzBBWHRUOU16bE5QQWIzem1OZFluRnRJR050cmkxeHpW?=
 =?utf-8?B?cUh3MjZwa2FMZXdFYzdjdnZtOXZLWGVPaXYxSVpxTzZBRWI5L29jRUJ6ZWdV?=
 =?utf-8?B?NENnNnZ6ZCtaUC9XSjZodksvcFZjZFVjanBPTjBWUVkyUDZPWWtSK3VQOHcz?=
 =?utf-8?B?SUgvOHQvc21JdHVuRXpPUW1SMzdrb1hUZlRHUzBXM3BhWWYzTkIzaUhUY3JX?=
 =?utf-8?B?Vm9MT2tSZnhDNGdzL1hHdHhKTWU3ay8wdVR0UTljbE9YQkhrWElmZDhIWjJE?=
 =?utf-8?B?SFFsWGZpQ0F1YjNUZ2xWUG54dlVmOS93UkVVS3piOHk4d3BxZWZXMkxKRHJ5?=
 =?utf-8?B?cUV4UHVNTHc4UjNVbENYc29yRm9LRHhKRThCbnY4NHRVWWZwamVCdjhRUU1H?=
 =?utf-8?B?OWpjRms5WXdLS3JkZ1VrVDJrck1vZkpwWVRXM3ZCTG1kVlo2QkI1dytQcjNz?=
 =?utf-8?B?Y2dZS0VYb3pPQXVWUTZ1eE0vb3NWU2owVTY2cWQxS0FzakFQcVd6dkRPOWI4?=
 =?utf-8?B?YlM0QUNmNXVEcXFYRGRnYU1TcStGOTVBVmJQTStKUWNXZ3NWamxqWnlESHdN?=
 =?utf-8?B?TnNiRFZiWDJvaC8wSVJHTW90ZHl1QXBsc0FMWWowRDZ0VUNUQW5UeHRKait1?=
 =?utf-8?B?RkprUzkwMVJqMDRRaDFqMHEwc2dSYUZYSzJNY2RxdWY5OXZBMTNNYXFsWW80?=
 =?utf-8?B?d215V2x0ZUZ1QTc0TjhPaHo2ZTlBeURiTS9pV3RqczdibjNBNm5WYjFsTGl2?=
 =?utf-8?B?RlU2KzYyanAzYis1YVU1UVl3YkdCOXdEbHZiTktZLzE1YWJoSmovUkFZZ3lh?=
 =?utf-8?B?SFRRNURqcGsxSHk0N3lYbUxRNkV6T0NDNDYrUVBVVW5QTFhkTGtmMitQQ3pD?=
 =?utf-8?B?SE5BbmpQY0RrV1lYdUhPbGxLQm0zVXRPcE5ZVFkwakgvaUhmTkNjYXRQa0pL?=
 =?utf-8?B?UWFPb1ZRL1ZHNVlSZlFVOUZBOW81OEM1SHBsWVFBWDZCaHZkakRsU3dmbUVY?=
 =?utf-8?B?VmZvM1JjMzN1U0Nwd2cyVVByUDlwV2JORVVsV092VnJHd2ljRTZJTUFsdDY2?=
 =?utf-8?B?cmFQY0dFbDJwYU9pVTVERTJHeGpIcC9iOG8zTlhuVkQ2SjVLRUVCcWxCRlpS?=
 =?utf-8?B?SFEzMGcvNzVndWdqellKZFNwUFd2di85emhGdmpnNU90dnpLMlFwa0pvdkdT?=
 =?utf-8?B?U0s1UW9JVXRYbnlQNzFWQkcvcncreUpVRFlSNWtHd090dDQ1VUhYRUNKdXA4?=
 =?utf-8?B?VHZwVXV6RzNKbzFpQ2gxMmVwMTdXOGxjeGd6akVNZFpVSHJRcEc0N0JtN3dr?=
 =?utf-8?B?S1lRRmx2VlBEVEw2c05kNXVnU0dKY3diSjlhdHRQdEtwUXBBSEQxcldwamxz?=
 =?utf-8?B?NXZrWUlOK1JJQ1Exbk1TbndvcWJEb2lrWEhWcG1tL3V3MWVuN2UwNFZzYzVp?=
 =?utf-8?B?Z2NoVEF4UHl1WWkwNVloMUYzT2pMWDEyYlNGR3dkWGhMcDNtOHNvRWdrNVdN?=
 =?utf-8?B?MkdmRnJNK3ZDenYzN0tXN1Y2ajVnTmF6a3BKRU56YmJZeE51enlXcVA4Rnky?=
 =?utf-8?B?czdYMys4a3U0SjBHSU9ZRURBbFUxdyt2Wm5HSXRJOWcrZkIxamYrNVhldnln?=
 =?utf-8?B?ZDloc2tEK0U1bUh1N3V2SktzWm1FMUk0TzZSL2lGaWpHVkJ6TStPMXdGanA5?=
 =?utf-8?B?MGFiWnJsWGZoYkNpQTVHbXNXVlNzNm9kVS9uNmZVZXo3UVRRblg1ajQvVlV5?=
 =?utf-8?B?dzRLY0FUdHRwV1NDb3RXd1hNaVN1cXg1TUtiNDY5NWkwQUN3RkdPZVFHbVZ2?=
 =?utf-8?B?aThCcUpLaXc4Z0VqdHRodHhsY0FHcHp4V2ZyR2ZNR0Jscm1iNXZLck1KbHFV?=
 =?utf-8?B?QUhldnFCSkZFRlBZbmtsSWxhcUJzU2JNSXNkTS83L0NmRUV6K0cvQ1lrclpY?=
 =?utf-8?B?RmtIYmtjWHBYMDRZTitOTHFWMVRJVzlaWWNJNkZXWXllTDhGdTJqWnFaTkNy?=
 =?utf-8?B?bXVKYkRrTFZVOHlSSE04RlJOSXJwcjRJT0ZRRnY3Wkk5N3FQSGV4eE5KN1RH?=
 =?utf-8?Q?9O9PCnOYCV0miQMwlCXw0b6zI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f262063d-efc6-4165-d0c2-08db677cc601
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:29:39.9997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYAJ+S/iTv2mZMk/YV2f0w6n5iBIUvJ7XHXQNE0IZXZqg51HSfzVZ/3zlLdXu5c/EPmjBr9gELQKoiSIRZIzOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
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

On 6/7/23 11:51, Ard Biesheuvel wrote:
> On Wed, 7 Jun 2023 at 18:08, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 6/7/23 02:23, Ard Biesheuvel wrote:
>>> Before refactoring the EFI stub boot flow to avoid the legacy bare metal
>>> decompressor, duplicate the SNP feature check in the EFI stub before
>>> handing over to the kernel proper.
>>>
>>> The SNP feature check can be performed while running under the EFI boot
>>> services, which means we can fail gracefully and return an error to the
>>> bootloader if the loaded kernel does not implement support for all the
>>> features that the hypervisor enabled.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>    arch/x86/boot/compressed/sev.c          | 71 +++++++++++---------
>>>    arch/x86/include/asm/sev.h              |  4 ++
>>>    drivers/firmware/efi/libstub/x86-stub.c | 17 +++++
>>>    3 files changed, 62 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
>>> index 09dc8c187b3cc752..9593bc80c9c6b89d 100644
>>> --- a/arch/x86/boot/compressed/sev.c
>>> +++ b/arch/x86/boot/compressed/sev.c
>>
>> ...
>>
>>> -void sev_enable(struct boot_params *bp)
>>> +u64 sev_get_status(void)
>>>    {
>>>        unsigned int eax, ebx, ecx, edx;
>>>        struct msr m;
>>> +
>>> +     /* Check for the SME/SEV support leaf */
>>> +     eax = 0x80000000;
>>> +     ecx = 0;
>>> +     native_cpuid(&eax, &ebx, &ecx, &edx);
>>> +     if (eax < 0x8000001f)
>>> +             return 0;
>>> +
>>> +     /*
>>> +      * Check for the SME/SEV feature:
>>> +      *   CPUID Fn8000_001F[EAX]
>>> +      *   - Bit 0 - Secure Memory Encryption support
>>> +      *   - Bit 1 - Secure Encrypted Virtualization support
>>> +      *   CPUID Fn8000_001F[EBX]
>>> +      *   - Bits 5:0 - Pagetable bit position used to indicate encryption
>>> +      */
>>> +     eax = 0x8000001f;
>>> +     ecx = 0;
>>> +     native_cpuid(&eax, &ebx, &ecx, &edx);
>>> +     /* Check whether SEV is supported */
>>> +     if (!(eax & BIT(1)))
>>> +             return 0;
>>> +
>>> +     /* Set the SME mask if this is an SEV guest. */
>>> +     sme_me_mask = BIT_ULL(ebx & 0x3f);
>>> +
>>> +     boot_rdmsr(MSR_AMD64_SEV, &m);
>>> +     return m.q;
>>> +}
>>> +
>>> +void sev_enable(struct boot_params *bp)
>>> +{
>>>        bool snp;
>>>
>>>        /*
>>> @@ -410,37 +447,13 @@ void sev_enable(struct boot_params *bp)
>>>         */
>>>        snp = snp_init(bp);
>>>
>>> -     /* Check for the SME/SEV support leaf */
>>> -     eax = 0x80000000;
>>> -     ecx = 0;
>>> -     native_cpuid(&eax, &ebx, &ecx, &edx);
>>> -     if (eax < 0x8000001f)
>>> -             return;
>>> -
>>> -     /*
>>> -      * Check for the SME/SEV feature:
>>> -      *   CPUID Fn8000_001F[EAX]
>>> -      *   - Bit 0 - Secure Memory Encryption support
>>> -      *   - Bit 1 - Secure Encrypted Virtualization support
>>> -      *   CPUID Fn8000_001F[EBX]
>>> -      *   - Bits 5:0 - Pagetable bit position used to indicate encryption
>>> -      */
>>> -     eax = 0x8000001f;
>>> -     ecx = 0;
>>> -     native_cpuid(&eax, &ebx, &ecx, &edx);
>>> -     /* Check whether SEV is supported */
>>> -     if (!(eax & BIT(1))) {
>>> +     sev_status = sev_get_status();
>>> +     if (!(sev_status & MSR_AMD64_SEV_ENABLED)) {
>>>                if (snp)
>>>                        error("SEV-SNP support indicated by CC blob, but not CPUID.");
>>
>> This ends up checking the CPUID path because if SEV isn't advertised in
>> CPUID the returned status value is 0. But it also checks the SEV_STATUS
>> MSR as well. So I think you can remove the SNP / SEV_STATUS check at the
>> end of this function (since that check is identical to this now) and just
>> update the message to indicate not CPUID or SEV status MSR.
>>
> 
> But that one checks for MSR_AMD64_SEV_SNP_ENABLED not
> MSR_AMD64_SEV_ENABLED. Does that matter at all?

Ugh, my bad, I misread that last check. Ignore my comment.

> 
>> The sme_me_mask should probably be cleared at this point before returning,
>> too. Or, alternately, in sev_get_status(), you can update the setting of
>> sme_me_mask to based on MSR_AMD64_SEV_ENABLED being set in the SEV_STATUS MSR.
>>
> 
> I'll go for the latter, seems cleaner not to touch it in that case.

Sounds good.

Thanks
Tom

> 
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -422,10 +422,12 @@ u64 sev_get_status(void)
>          if (!(eax & BIT(1)))
>                  return 0;
> 
> -       /* Set the SME mask if this is an SEV guest. */
> -       sme_me_mask = BIT_ULL(ebx & 0x3f);
> -
>          boot_rdmsr(MSR_AMD64_SEV, &m);
> +
> +       /* Set the SME mask if this is an SEV guest. */
> +       if (m.q & MSR_AMD64_SEV_ENABLED)
> +               sme_me_mask = BIT_ULL(ebx & 0x3f);
> +
>          return m.q;
>   }
> 
> 
>>>    /* Search for Confidential Computing blob in the EFI config table. */
>>> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
>>> index 86e1296e87f513b7..081c39b0e8d0d208 100644
>>> --- a/arch/x86/include/asm/sev.h
>>> +++ b/arch/x86/include/asm/sev.h
>>> @@ -207,6 +207,8 @@ bool snp_init(struct boot_params *bp);
>>>    void __init __noreturn snp_abort(void);
>>>    int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
>>>    void snp_accept_memory(phys_addr_t start, phys_addr_t end);
>>> +u64 snp_get_unsupported_features(u64 status);
>>> +u64 sev_get_status(void);
>>>    #else
>>>    static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>>>    static inline void sev_es_ist_exit(void) { }
>>> @@ -232,6 +234,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
>>>    }
>>>
>>>    static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
>>> +static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
>>> +static inline u64 sev_get_status(void) { return 0; }
>>>    #endif
>>>
>>>    #endif
>>> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
>>> index abcd5703e9f3f980..1015ef883f5850a4 100644
>>> --- a/drivers/firmware/efi/libstub/x86-stub.c
>>> +++ b/drivers/firmware/efi/libstub/x86-stub.c
>>> @@ -15,6 +15,7 @@
>>>    #include <asm/setup.h>
>>>    #include <asm/desc.h>
>>>    #include <asm/boot.h>
>>> +#include <asm/sev.h>
>>>
>>>    #include "efistub.h"
>>>    #include "x86-stub.h"
>>> @@ -790,6 +791,19 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
>>>        return EFI_SUCCESS;
>>>    }
>>>
>>> +static bool have_unsupported_snp_features(void)
>>> +{
>>> +     u64 unsupported;
>>> +
>>> +     unsupported = snp_get_unsupported_features(sev_get_status());
>>
>> This will also set sme_me_mask, but I think that is ok, since on error
>> things will terminate, otherwise sev_enable() should update appropriately
>> later.
>>
> 
> OK
> 
>>> +     if (unsupported) {
>>> +             efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
>>> +                     unsupported);
>>> +             return true;
>>> +     }
>>> +     return false;
>>> +}
>>> +
>>>    static void __noreturn enter_kernel(unsigned long kernel_addr,
>>>                                    struct boot_params *boot_params)
>>>    {
>>> @@ -820,6 +834,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>>>        if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
>>>                efi_exit(handle, EFI_INVALID_PARAMETER);
>>>
>>> +     if (have_unsupported_snp_features())
>>> +             efi_exit(handle, EFI_UNSUPPORTED);
>>> +
>>>        if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
>>>                efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
>>>                if (efi_dxe_table &&
