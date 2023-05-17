Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F329706B27
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 16:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjEQOch (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 May 2023 10:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjEQOcg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 May 2023 10:32:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9157293;
        Wed, 17 May 2023 07:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvZP6LgLisrMPRqA3j1Rvf+DGfmUUXjo4xilAcUohRQjlGf9XrOSj/eUgela9abf9jjW8DIcrthsLqQCWuaYnRf5X0hx5+auvVqJ8wlzVImD6sFfyS4kLR2ldVwQI8SyzEzk79r8K7aZS4mGiQnEKKflAuFOdOSL1GeZincSYC+QcadVDHwDPAEx/7He6rIxyvlmsJR3yQfxAyW7qz3RcwPm90/plV8IgjJ4BxG+pVBtY7W1vwQNi50I1U2XHvfq8fyFHzVOWlgzVA52Qz7yvdU809HTTUaTuEmjiCGmMyTBxNDrN/0vKcFOgXEJ/WE2X4QA4E2NPz07wvqsw+Llvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGH9/afE197hpRD9BqpOJMbtxYlyPKJe89JDipVHiOM=;
 b=CdxdG5Trg2esH2op3+OpJD5xoDyVErU+FJ9YcjRAq638lTIvzT3t+hsKJNjCF5I3dV+xaRpaEVOjoZ3nHyT3A0tw6oiJcYRoSV98XW/QTNPCvexEHBartFs4dxqQJaY7BaYLApFkbRdFDGBHqSOsO7Wwc1QFETxb+3wJwzQFZ9PLHnSW0BMcvRI0qH8/gRelbjFYHgy5FleVcgs2u6jCv/PJAedKZATVfXsX1RKZXlC50Ig8UNYbKuEnCsw0t+2opgfkaRyKSVowJjZlGKIbswYHzNVv54rSJfevr4DzfFu1sAjaCpwwYU6DkfrW6r4d/XB56wjucZIQDL6NK55Nzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGH9/afE197hpRD9BqpOJMbtxYlyPKJe89JDipVHiOM=;
 b=JU7ZvpFyJzLUvvsPyZWfeCYqD+zxOCvma87uDojUePQYVHAVNR14k+y71YoqtZ6YLEPx678mSPQFwuPGNlvpwOYxCk9K/D3PN8gVUnwnSyd3YfMGMtppV/C9p1pr2vn6azTdJWdAroUIUMrcCW306sX5+++d6if/I8EcgvQXL1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 14:32:31 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 14:32:31 +0000
Message-ID: <fe62b3a6-2c28-a069-d880-772fe6c13125@amd.com>
Date:   Wed, 17 May 2023 09:32:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv11 0/9] mm, x86/cc, efi: Implement support for unaccepted
 memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
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
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <aa35a445-f410-b11f-bf21-3e482647faae@amd.com>
 <20230516232204.3k53vh6pdnimdrhi@box.shutemov.name>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230516232204.3k53vh6pdnimdrhi@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:806:130::7) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 567dd25e-6994-4bbf-f912-08db56e38c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asQ3vAS5j+jc0aY+C84cFgE/lEWN246cEBY3sKDyFYZ2ndr5QMWHAulXnliwMGJ8HLEuQ3C9Ze9Z7o57v2RS4sKvb7TG4geRopQI/FvC+h4UuLVodcC8INaBhAeVLMRfL2HimzNdl2u3Eieo4lsO49riPA2n4Mkrx5bWxb2r3pc94Y/6daG/GEJui0md6v/6lloBUw8jsJTpPCq0Q/8qf3KZ/IXDyUZvXmaju87wCieJxkXhgD87ncNiGjCnfpW9FUULDkyHxbmq1hnS9NsfsVwpona6hrk2sJX1CHRsNPnX7UjxJ/3ypSZIn30LpgSEM8K6P7Q9/2JPq3YdWiR6pKPlzNEiSHzFQrYdupHX7Q9OFd0h3Awer5ktjgLH6w6fTzEgvwexUoZbyeDez1834XqEDk28wOU22OnYAD8gvBKnwoDD773CF7l9e1P1vjPEZYxn7g8+GrUdr4sbp/fT55EJ5u+2G3zkVxy4IAK3tsNAEvij9YspEIvT1HSWQ/XAobdrvLGXTTGmV+0BQYGXVtX5W3yVBr6noXr6KCyRJXkD1tEOiFCOvmCOqXJNIgw7TABBN6q1B8t/2gyvO1I8M7xlBrPyTXLnYGXveYtCKwZWo4K4e6sk0qxupvQ5feL+vV9gxO4LpRK2Rw/wWY9SkmJNK0kbg64br1IT4BntwApFpthPpFjMgFTlGYZ7qUr3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(31686004)(83380400001)(6916009)(41300700001)(8676002)(7416002)(7406005)(2906002)(8936002)(5660300002)(36756003)(31696002)(86362001)(316002)(38100700002)(4326008)(66476007)(66556008)(66946007)(966005)(53546011)(6512007)(6506007)(26005)(186003)(478600001)(6486002)(2616005)(6666004)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0p0emxvb1ZCRDg0cWh0V1NhRDRFQWt0QlptbmVSaldzNnBHNEZEbDRjNnkw?=
 =?utf-8?B?ejVabmZPQndWWEJGSDUwYlZmamo0aGJRRjdKZEpJekg3VXZJbWVzbmJhazB2?=
 =?utf-8?B?dUZJdVppdjJEN1ZwSFlhWFhGOWlRY2VKSmxhM1VhYURnNTg3dklBekJEdWJH?=
 =?utf-8?B?UEZhbFZKYWkwZ0pBdnFnQWNISjJ3RiszNUNzTTQvdEs3R2hlcjhMQXhzTGZh?=
 =?utf-8?B?Rm1hWnkvNDI0LzVhdWFkRitRUHlINzBmMFVvS2U3YStvYzI3OUZBb3Urekxw?=
 =?utf-8?B?bSt3cGdpNUVvdTYyRDVUdUtaNDhkMHJ1RXhxYVFBK0NjZ0RIS21aUGFCaHJn?=
 =?utf-8?B?YlF2TXEwZi9DeEZhUUppeVpwYnJ1OHN1Q2VXak1ZNjhMOWFGV2t4TXdJNkZU?=
 =?utf-8?B?YVFncjQyelZIZFFGSEJjc0liTDNWOVg0UGtOQ3FUd0p6bER2Z2llR2t1WmhC?=
 =?utf-8?B?eHo0VEJvamEralZrbVFnRmEvMkhDa2l3S3NxbkZDdTd1aFZFMjBHNHpiOE8y?=
 =?utf-8?B?MXAwczIrRDBqWGFMWnB2NUp5MVZ2RTNoU3ZBM2piM1dBVFh5dEZJNzNQSnh3?=
 =?utf-8?B?M1k3ZTI1OGJnK1V1NUdVUEVDbkVHMjl6amJ4aFJhTWFkNDFTMDdKbGpXSEdC?=
 =?utf-8?B?emttNzFoTXlpd0diakIxL2FXK2xlOFRFTjF1M0o2aFZlbWUwUzMxN2ZYbGxu?=
 =?utf-8?B?OEFMcmNwZHZJWmd6eGRtRXpyZStucEpjNS8zYWxJb3pFY2Uzd0VwV1lPbnFn?=
 =?utf-8?B?UGRyZW1MaUhRd0w3dkhzMkRWcWE3NXVOOEVscmU1NGdidW5FUkVVa0FNYlJS?=
 =?utf-8?B?c2FCaUllbjhrLzREbGtNcHp0bzN3QUhTNGFmeUZNcWovREhhSG8yRWJqQWNj?=
 =?utf-8?B?U0UwUCtFVEpTbjU0djRuR2ZTaGZlU1hnT0VtbldPVFhUanBtWmh6V0hZU0sz?=
 =?utf-8?B?dnJOUTJDR0JkRzZKU3NLQkdvT2V2U0phOFZEWDF2ckJPU2J4K2dvbzhZT0gx?=
 =?utf-8?B?b2IzM3duNmVva2FoNTZ5SVpkN3RpWmI5N3NvNC8wVWdqUHR3ek8yb2x2OVN1?=
 =?utf-8?B?TzZwR3dvQkg4UUdKTzh6SktNRTlHczVQUFI4dzA4NDArRU5qUlZZaERxTUF2?=
 =?utf-8?B?bTU1QS9leVRpR2dmY1QrVGU1SnJsbGp1dGt4NkJRa0VWY2d3SERobDhwcHlx?=
 =?utf-8?B?NUxTNmFqdWJlcDY0ZWN2b0NMbVZIVGJVajlxOUhwaEFJcG42MU5SbDFtbnNW?=
 =?utf-8?B?S0VVSENGVVFxRDdaTW81UXRwcHV4SzJ1SFdYTUs1ZGI5Ny9YRTBEUXU1bG93?=
 =?utf-8?B?QmNSeWRWbm1xaVhVa2hTVFFsWjZkNzgrbjIyNHJJa2JTZHhraWZwSU51SXVC?=
 =?utf-8?B?VlVzRFFhYW9IcDBXTW1HTEFrTUd6L0UzbXN4akFuUUIybGhjVllkYTBYaTh6?=
 =?utf-8?B?cVVJYWdIRmV2LzdtNHRWdlJSeEc5MW43aVY2ODBsU2wvdHFVL3ZUNnpJUU1w?=
 =?utf-8?B?VGRYbUZTQkFFZjVjbnhCZHVOQ2FMV0lRenFXNEFhM0xpVTNoRElNRFhna2JF?=
 =?utf-8?B?empvSGFrR0pzd25DcENlTWtXK2w1VnVadGk5SS9GNFZSMFhaWElEQkVRbHFa?=
 =?utf-8?B?a09IK1M4c3hpbFAvMkkycWkvNFdtbmNUTlZtUnlNSXZpVlROZW5IZ3l5S1d2?=
 =?utf-8?B?UW5Jd1NrRzN0OTd4RzJNL0xjQWp1V3lRWHVwS1dlem5MbEU1ZmgzRkcyVWR5?=
 =?utf-8?B?d0FnaDVkSVNidVk5RnUzVTZ0M3hnSmdUSnFleGdGaGhySlkxRUhHRWFDaHNn?=
 =?utf-8?B?cThhZWIraWx2TktpZzlvOWFhYitNTk50SDFaNGY4SFVOVklpUFY5bmU3UGtM?=
 =?utf-8?B?ZSs0b1FYaG04NUpYdmtZZkUvNStWL3JzSG9MREpRTUMyWUR4TlhnVWZ4aGkv?=
 =?utf-8?B?UUVBWnA0aHIrSWU2dUo5QmFPVU0wcXQ1ZlRSWkFpTnZjQWpQTzNld3h4eDIw?=
 =?utf-8?B?cjRkK3hLa014dkhodkhiNE45Y0gyRHZjVHVSN0xOY2gyb2tIQklzZ29aQlJr?=
 =?utf-8?B?Z1pKOHpjb0g1aHVmS0xtMjNLNUdlVEkyZkxkaEw5eTlxc3dKc0dkdlg5Y0xr?=
 =?utf-8?Q?krMM3S8p09f82rzmULnWCVaVq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567dd25e-6994-4bbf-f912-08db56e38c3b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 14:32:31.5360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECSwRAcLCwmGUng8Dl0sc5L4Esww1BbZCfO2d4gieQlLiPrBuXI6ipu8GwZZbay4F6e4tExPh1iJm7e5Zr4HHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473
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

On 5/16/23 18:22, Kirill A. Shutemov wrote:
> On Tue, May 16, 2023 at 05:41:55PM -0500, Tom Lendacky wrote:
>> On 5/13/23 17:04, Kirill A. Shutemov wrote:
>>> UEFI Specification version 2.9 introduces the concept of memory
>>> acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
>>> SEV-SNP, requiring memory to be accepted before it can be used by the
>>> guest. Accepting happens via a protocol specific for the Virtual
>>> Machine platform.
>>>
>>> Accepting memory is costly and it makes VMM allocate memory for the
>>> accepted guest physical address range. It's better to postpone memory
>>> acceptance until memory is needed. It lowers boot time and reduces
>>> memory overhead.
>>>
>>> The kernel needs to know what memory has been accepted. Firmware
>>> communicates this information via memory map: a new memory type --
>>> EFI_UNACCEPTED_MEMORY -- indicates such memory.
>>>
>>> Range-based tracking works fine for firmware, but it gets bulky for
>>> the kernel: e820 has to be modified on every page acceptance. It leads
>>> to table fragmentation, but there's a limited number of entries in the
>>> e820 table
>>>
>>> Another option is to mark such memory as usable in e820 and track if the
>>> range has been accepted in a bitmap. One bit in the bitmap represents
>>> 2MiB in the address space: one 4k page is enough to track 64GiB or
>>> physical address space.
>>>
>>> In the worst-case scenario -- a huge hole in the middle of the
>>> address space -- It needs 256MiB to handle 4PiB of the address
>>> space.
>>>
>>> Any unaccepted memory that is not aligned to 2M gets accepted upfront.
>>>
>>> The approach lowers boot time substantially. Boot to shell is ~2.5x
>>> faster for 4G TDX VM and ~4x faster for 64G.
>>>
>>> TDX-specific code isolated from the core of unaccepted memory support. It
>>> supposed to help to plug-in different implementation of unaccepted memory
>>> such as SEV-SNP.
>>>
>>> -- Fragmentation study --
>>>
>>> Vlastimil and Mel were concern about effect of unaccepted memory on
>>> fragmentation prevention measures in page allocator. I tried to evaluate
>>> it, but it is tricky. As suggested I tried to run multiple parallel kernel
>>> builds and follow how often kmem:mm_page_alloc_extfrag gets hit.
>>>
>>> See results in the v9 of the patchset[1][2]
>>>
>>> [1] https://lore.kernel.org/all/20230330114956.20342-1-kirill.shutemov@linux.intel.com
>>> [2] https://lore.kernel.org/all/20230416191940.ex7ao43pmrjhru2p@box.shutemov.name
>>>
>>> --
>>>
>>> The tree can be found here:
>>>
>>> https://github.com/intel/tdx.git guest-unaccepted-memory
>>
>> I get some failures when building without TDX support selected in my
>> kernel config after adding unaccepted memory support for SNP:
>>
>>    In file included from arch/x86/boot/compressed/../../coco/tdx/tdx-shared.c:1,
>>                     from arch/x86/boot/compressed/tdx-shared.c:2:
>>    ./arch/x86/include/asm/tdx.h: In function ?tdx_kvm_hypercall?:
>>    ./arch/x86/include/asm/tdx.h:72:17: error: ?ENODEV? undeclared (first use in this function)
>>       72 |         return -ENODEV;
>>          |                 ^~~~~~
>>    ./arch/x86/include/asm/tdx.h:72:17: note: each undeclared identifier is reported only once for each function it appears in
>>
>> Adding an include for linux/errno.h gets past that error, but then
>> I get the following:
>>
>>    ld: arch/x86/boot/compressed/tdx-shared.o: in function `tdx_enc_status_changed_phys':
>>    tdx-shared.c:(.text+0x42): undefined reference to `__tdx_hypercall'
>>    ld: tdx-shared.c:(.text+0x7f): undefined reference to `__tdx_module_call'
>>    ld: tdx-shared.c:(.text+0xce): undefined reference to `__tdx_module_call'
>>    ld: tdx-shared.c:(.text+0x13b): undefined reference to `__tdx_module_call'
>>    ld: tdx-shared.c:(.text+0x153): undefined reference to `cc_mkdec'
>>    ld: tdx-shared.c:(.text+0x15d): undefined reference to `cc_mkdec'
>>    ld: tdx-shared.c:(.text+0x18e): undefined reference to `__tdx_hypercall'
>>    ld: arch/x86/boot/compressed/vmlinux: hidden symbol `__tdx_hypercall' isn't defined
>>    ld: final link failed: bad value
>>
>> So it looks like arch/x86/boot/compressed/tdx-shared.c is being
>> built, while arch/x86/boot/compressed/tdx.c isn't.
> 
> Right. I think this should help:
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 78f67e0a2666..b13a58021086 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -106,8 +106,8 @@ ifdef CONFIG_X86_64
>   endif
> 
>   vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
> -vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
> -vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o $(obj)/tdx-shared.o
> +vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o $(obj)/tdx-shared.o
> +vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
> 
>   vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>   vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
> 
>> After setting TDX in the kernel config, I can build successfully, but
>> I'm running into an error when trying to accept memory during
>> decompression.
>>
>> In drivers/firmware/efi/libstub/unaccepted_memory.c, I can see that the
>> unaccepted_table is allocated, but when accept_memory() is invoked the
>> table address is now zero. I thought maybe it had to do with bss, but even
>> putting it in the .data section didn't help. I'll keep digging, but if you
>> have any ideas, that would be great.
> 
> Not right away. But maybe seeing your side of enabling would help.

Let me get something pushed up where you can access it and I'll also send
you my kernel config.

In the mean time I added the following and everything worked. But I'm not
sure how acceptable it is to always be checking for the table when the
value is zero is.


diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
index f4642c4f25dd..8c5632ab1208 100644
--- a/drivers/firmware/efi/libstub/unaccepted_memory.c
+++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
@@ -183,8 +183,13 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
  	unsigned long bitmap_size;
  	u64 unit_size;
  
-	if (!unaccepted_table)
-		return;
+	if (!unaccepted_table) {
+		efi_guid_t unaccepted_table_guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
+
+		unaccepted_table = get_efi_config_table(unaccepted_table_guid);
+		if (!unaccepted_table)
+			return;
+	}
  
  	unit_size = unaccepted_table->unit_size;
  

Thanks,
Tom

> 
