Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539C472046A
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 16:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjFBO1F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 10:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjFBO0y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 10:26:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA871A6;
        Fri,  2 Jun 2023 07:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrijfq+15ey7ujfHwohIml+ABoTPsVVnh49LZe7u2kL4zxiXTEPQWnjw9nK9BuTFiAVM6xpmrRHc7pd/T6f7jQXF76MGAkIOSSaXY6r8pO7guYuZAlHRy7P9GaKozDE/KWKtjy9NXT7KmmcYJUJaf6aHQaZ27kMLjTA1MAPY6JKIHMgl00yZyt9ng9L+fFuOFvJ7U1d+DaNShi5OYpXJJOcyW76lfDRi1D/Bq9hnsvfpkvapuEUpBrdLr7j7KFd0vvyBm6eLr4LHI3wYktlSgRlZpi+VSMyY9H453mSsDnGdyE6vXs7W9mXYLZdy/JEawjbqwjmXByat6bKyPTBhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqtR9jahVTHmcSUP4gvXga04V942vveKWDuM6KIttYk=;
 b=HIfCkO+tbdmyZVS7WfE47P85GE/bD2MYEhyE7AXI/mcYJQmXivNofEJ5dcMOpxFrusIqfk8rUUOmySm9GcbVlrS3Im6EDCD3Isb4vuYdK5QREWP78K2qpVQ8ZtUhXIMDyldHBYBtCq/Jpt2QaSySnQTCwGxqYC8Q6mHC2jZ16qhgpRHxyXqMaqxwBelGYK3QxAkxStZcGuc5ixLwmqZfa9Tn0EsehoIXzCQLG2q5kjCmeP+wSeuFDnhDDsRNCg8OGsxuHSkoKUc70Itn1nleh2QAmtU19rsKzXs1I2Utl2ua0WUkHUOMI9SxWJpuhILETZlPs8WooZanv6Ol/+95+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqtR9jahVTHmcSUP4gvXga04V942vveKWDuM6KIttYk=;
 b=CMybiZQWSKtvdybXIjTPIMNgof2bRmjTqYotXJBbzXcoosfVEZLCuuO9NUGW9lXZUIIvy9n/rtovbgv+RHN8vg3HDAL/tsbjTKxNOfAzuIMWzeVpSjzWLjGOnvIdmQCpaYLMJ5ReQ2hk2t/izmsgOGizGTrjAKKUUgUPqP+LPHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 14:26:50 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25%3]) with mapi id 15.20.6455.026; Fri, 2 Jun 2023
 14:26:49 +0000
Message-ID: <1d24355c-3922-d5c7-4c05-f5ef0adaf5d2@amd.com>
Date:   Fri, 2 Jun 2023 09:26:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv13 9/9] x86/tdx: Add unaccepted memory support
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-10-kirill.shutemov@linux.intel.com>
 <4d8d6fc4-99b5-29ba-7f81-12e7d57907ea@amd.com>
In-Reply-To: <4d8d6fc4-99b5-29ba-7f81-12e7d57907ea@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0001.prod.exchangelabs.com (2603:10b6:805:b6::14)
 To DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d912eab-9efe-411d-62a2-08db6375671f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /w546bzQGy6pBEguqGHtgkvYb6mTeEWIB+CWqPvr8dRRBdJTPU0qUbdepGvj/GbOsp67Sk5kbSuYjfmtG2JAHuhhfY6gRPxmK7MtkgSpcvIN8kiz/L81RCCQyprBn2TO+Ij6nvHMlcfjUV5skqRIIH4towm76HzAlTEw67R3L6ld3NiYKwicO25XEf2C6EDrS6KrtcpI30v7j0z4SZ7bCr6J5nkkFVdtuMBJgUhTdjsZIzRiksApDZgFUHdvbcptkBeeHF6iHQYMn934sj6gD6kDoAI0um5XtWDrk7L6TKeA+CVhAOngdH6yUrqxD436wNXSM7lZ1ZwFLDJH8DSZ3jR8XJf6SJvLD64s3nZfm3j+OB7NDcIU83BxDnR7gYdZ227RF34Xmkxp+YyApdCq+2PzBt3BJ5AbkFlae7QnU3NCWIW6li3pHe0+x0Wt0Rai6+5DhV8opYGvatZ3C2bsELNdC+pHaXQzEnD5+O8TTqVoLUod0MS6mnKmBawsdRi08pqrmZQInIBEnYUKTF187KyIpIiRfed7wtMzHkH22eqZoxg6a1BPpf8FcWBcdSp3yYYSZVcEZbjJ06qOsdJ3PUc106yJpYZUqFQmPOy06Ox2l2W3hcdJ9CAX25FllWer0F+YrVkLkATcLXxepK3GZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(31686004)(83380400001)(6512007)(26005)(186003)(53546011)(6506007)(41300700001)(38100700002)(6666004)(2616005)(6486002)(478600001)(110136005)(54906003)(4326008)(66476007)(316002)(66556008)(66946007)(7416002)(5660300002)(7406005)(8676002)(8936002)(31696002)(2906002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1lDOHIyQ2pqWXBqMnFOaFJ4Rmpjd3RtdlZiT1NJcTN4a0pLUDRiWUhQUlBw?=
 =?utf-8?B?MXN5c3B4V2ptWU1LRUV6czhJS1ZRVjdweHNlZDlDYU5oUDJTZ2I3VFdUbTdH?=
 =?utf-8?B?UWxlRE5VRTJhRTQvd09jaUlXMmRSY1FLL2cxajBscFAwK1FqcEg2S013SjRi?=
 =?utf-8?B?VUdmdEd5K0x6TEFUWUFraFpIODhXbm1NN09PV3YzeDZJVlNyVi9EWmp0SXZB?=
 =?utf-8?B?eTk4ZGZGNXlJcFFSWkdQK3pNWWpMcnkvcVM3MmZZMVVTOEJFRWN1VGNRQnZE?=
 =?utf-8?B?b283aDVUVm5Xei8rSkxYc0kwbTVQaUdueW81NUlsQmZiNzBkWVp4eFJaTjZl?=
 =?utf-8?B?V2dOd1VlU3VYbkdlc0pOMy8raExkYkhlZ1FnbFZpRnQ1bmltT3Rqc3daclZr?=
 =?utf-8?B?Q1dzRjNsRW1KRnQyWnhYZlVBQ2Z4TklMZzJTakFubnpHMS93V2czeUNoUzFm?=
 =?utf-8?B?WDU5S2QyQkN2UzVUYTJxVkZkZmFLREMzbldRdmkvbTR0VFRvOTdZZTBmREtQ?=
 =?utf-8?B?WUNsRzVLUitTcFcwVnlqaHljdmRwYlgyVHAzVzJTNE5FRmFBTWNvUlp6cWR6?=
 =?utf-8?B?YWNWWnVtYi9ka2xvUnhUT0g5a1lvbmx3bXcyWFRkUjVLencweGdDQWRTcVl5?=
 =?utf-8?B?MEdYQ3oyRkl1VktIY05aWDVCZWg1NVFBRFEwb2dlMFMyRzM0VzViQ1lhNjIy?=
 =?utf-8?B?TTNUZ1BObllIUmxQa0NqZnA5YTR1MjB2U1hwSmJWYkh4d2lVUlFrWXFkU3p1?=
 =?utf-8?B?bklybjI3ckNudlNKSG5kZktvbHFPZ2JKdE0rQ3NPZTNvYXNUaUdNamJpUGt1?=
 =?utf-8?B?SEQvSUp0cHpka1NTNHRZSFlkTjh4c0sxUUprN1FlVFovUCtFRjN2Z282Yi81?=
 =?utf-8?B?Qyt1TVpHY1hjQ0U3Y3RRNWlVWmVoZGV1a3dIdWVkVjYxUGExZEw3V3ZXOHlk?=
 =?utf-8?B?bjc0S0prZVRtb3E2REdFMFZNWStuWUcrYy9pbmVaN1lNYTc2VmZOaFJ1Umo4?=
 =?utf-8?B?dUk2YW9yL1VlblJkRmZ6ZDYvYVI5cFk5aEttOGdVQkx1MVNGZW4zN2dGMllq?=
 =?utf-8?B?OUlEM1UrTFROaXIrcG0rTW94aksrejJoa0FvWXJ1bVBjZS9qRlphMUhyZXhh?=
 =?utf-8?B?SVgreTZNTzQ0TEh1bC9uMGVRNkdnRDZsTEdUbjdIYTY4ZUVKaTNncHJLNmIz?=
 =?utf-8?B?T1VKaWpEM2dkZXNxUTdJQzVzV2RsTFdiaXB1R1RjVUlaTERQbEJxOXVoVkww?=
 =?utf-8?B?RGtDbnptd09lc0UxaTZMRmZBVFVWd3djL3RkcmRVcUl3V3hObXVNWWZ5eE9m?=
 =?utf-8?B?cUxxTHcwbXludE1GV1pTUi9ya2hSdTJ1ZGJKM2duK0NwNlV4ZkpWT2YvR01s?=
 =?utf-8?B?SzlQRmo2dE5IVVErUzNzL2VhZWk0Y250dHQ3eGNsdktVTnA3Mk9IYkExRWdC?=
 =?utf-8?B?L25ReEQvWlBiRjRhSnJuV3IyMlBGR1IwQUZEVERhRzZiK29WVjA0eGlBKzd1?=
 =?utf-8?B?bVZIaEdSQlJkWC93RG1CT3VoVDJkcjRza0prem5oeGpqSy9uUDM1Q0FLdDUy?=
 =?utf-8?B?RFR6Q2NidTJlb3IrUGxTdkxaSXRySXpTQklsZXFnVjNYdENMSzhvK2xidG13?=
 =?utf-8?B?bElXeFhteUZLL2x2SE9TYXFvUWE3MS92UVFCYlE0am9zeVdHK1ZnQkZlcS9C?=
 =?utf-8?B?UXBNNklLZG5oSCsrcDBWZFR0VG5uN1lVMHhhSGFyeml3WjFaMzdCclhoNEJU?=
 =?utf-8?B?VGFFWExvbWNnYzBtbTlDREc1TmlvdEdPQlYwazExSXhDZDRKdnVsOW0xcUIy?=
 =?utf-8?B?QU5NaHFMUVNRSTlBWHdIdUFNUE5YQlpReGliV0l4NjBnc3MrZjVPbmRHenVV?=
 =?utf-8?B?a1RqNEJXTG1Id1dBbWRTVTRWb1paaXZXT1lyZDRiUjVpMmdyZmxkb010T3dE?=
 =?utf-8?B?NTI0TXpOQnVVNCtsSjlxdGNGVGRBRVN0N0NjdjlLTDh0SzhXTXZ1eE4vZENv?=
 =?utf-8?B?YWJDYmVvVnhXV0VPNVJVSmpQWTlBY2M3T0FENzBLRGhlSEpodGpQeVJwcWpW?=
 =?utf-8?B?RUc1ZHlPYXN6Yk9YaEhoaUwwZUJUWHJ4MkNPcC96bjJxRGRmSDV4MEMwc3lR?=
 =?utf-8?Q?auhvXebWDffXxUEN09vZku36k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d912eab-9efe-411d-62a2-08db6375671f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 14:26:49.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8ItlHTT2NFlGd+C/bKCGYpxbJ9uO4mNLE+m5to7E/YxxUupG4QRpNlHfxF+WyG2lbxF6z5Ex94i4MWh7ZEHIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
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

On 6/2/23 08:22, Tom Lendacky wrote:
> On 6/1/23 13:25, Kirill A. Shutemov wrote:
>> Hookup TDX-specific code to accept memory.
>>
>> Accepting the memory is done with ACCEPT_PAGE module call on every page
>> in the range. MAP_GPA hypercall is not required as the unaccepted memory
>> is considered private already.
>>
>> Extract the part of tdx_enc_status_changed() that does memory acceptance
>> in a new helper. Move the helper tdx-shared.c. It is going to be used by
>> both main kernel and decompressor.
>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> ---
>>   arch/x86/Kconfig                         |  2 +
>>   arch/x86/boot/compressed/Makefile        |  2 +-
>>   arch/x86/boot/compressed/error.c         | 19 +++++++
>>   arch/x86/boot/compressed/error.h         |  1 +
>>   arch/x86/boot/compressed/mem.c           | 35 +++++++++++-
>>   arch/x86/boot/compressed/tdx-shared.c    |  2 +
>>   arch/x86/coco/tdx/Makefile               |  2 +-
>>   arch/x86/coco/tdx/tdx-shared.c           | 71 ++++++++++++++++++++++++
>>   arch/x86/coco/tdx/tdx.c                  | 70 +----------------------
>>   arch/x86/include/asm/shared/tdx.h        |  2 +
>>   arch/x86/include/asm/unaccepted_memory.h | 24 ++++++++
>>   11 files changed, 160 insertions(+), 70 deletions(-)
>>   create mode 100644 arch/x86/boot/compressed/tdx-shared.c
>>   create mode 100644 arch/x86/coco/tdx/tdx-shared.c
>>   create mode 100644 arch/x86/include/asm/unaccepted_memory.h
>>

>> diff --git a/arch/x86/boot/compressed/mem.c 
>> b/arch/x86/boot/compressed/mem.c
>> index 4ecf26576a77..d2b6948a7801 100644
>> --- a/arch/x86/boot/compressed/mem.c
>> +++ b/arch/x86/boot/compressed/mem.c
>> @@ -2,11 +2,44 @@
>>   #include "error.h"
>>   #include "misc.h"
>> +#include "tdx.h"
>> +#include <asm/shared/tdx.h>
>> +
>> +/*
>> + * accept_memory() and process_unaccepted_memory() called from EFI stub 
>> which
>> + * runs before decompresser and its early_tdx_detect().
>> + *
>> + * Enumerate TDX directly from the early users.
>> + */
>> +static bool early_is_tdx_guest(void)
>> +{
>> +    static bool once;
>> +    static bool is_tdx;
>> +
>> +    if (!IS_ENABLED(CONFIG_INTEL_TDX_GUEST))
>> +        return false;
>> +
>> +    if (!once) {
>> +        u32 eax, sig[3];
>> +
>> +        cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax,
>> +                &sig[0], &sig[2],  &sig[1]);
>> +        is_tdx = !memcmp(TDX_IDENT, sig, sizeof(sig));
>> +        once = true;
>> +    }
>> +
>> +    return is_tdx;
>> +}
>>   void arch_accept_memory(phys_addr_t start, phys_addr_t end)
>>   {
>>       /* Platform-specific memory-acceptance call goes here */
>> -    error("Cannot accept memory");
>> +    if (early_is_tdx_guest()) {
>> +        if (tdx_accept_memory(start, end))
>> +            return;
>> +    }
>> +
>> +    error("Cannot accept memory: unknown platform\n");
> 
> So this is a change in this version. If tdx_accept_memory() fails, you'll 
> report unknown platform. Wouldn't it be better to have an error message 
> that indicates a failure in the accept path?
> 

Maybe you can keep it similar to the v12 version with just a new error 
message, something like:

	if (early_is_tdx_guest()) {
		if (!tdx_accept_memory(start, end))
			error("TDX error accepting memory\n");
	} else {
		error("Cannot accept memory: unknown platform\n");
	}

And similar in arch/x86/include/asm/unaccepted_memory.h.

Thanks,
Tom

> Thanks,
> Tom
> 
>>   }
>>   void init_unaccepted_memory(void)
