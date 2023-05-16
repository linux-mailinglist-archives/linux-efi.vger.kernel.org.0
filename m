Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D445705AB7
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 00:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjEPWmO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 18:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEPWmN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 18:42:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A5F7292;
        Tue, 16 May 2023 15:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfurirkFDB1Cam6507SZ6MCzJYObJAR4Zao9jE7Ar0KVAVwmfXcM6GwTyiWF/+2j/wQjEyV2rRh0VsJYULknfa6FSEa0S00QLhhleAHBtdYJV601ihRjPdXHTFiGEhc9M46MHXnlGN9sCEs1cZn8wUdSwyss3Jw21WqBpvoWDXhWmamMoBQ1Opy/2KMAPj86tGeZBbQ+jeZrk557hDyAqLk3qthiTbBvjKByhcpsSN1+G34l62NzaqJpGlzvuiveb1Q5x6Sgq0O5MKmSyn0fUakIAoz1Oy0wrevtPcFzhH3nAGxbKEQSy2TZj3NlJ0UenT8Q1b4AhSOpn63nvo2aiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/0JQ8gW+sy4bxgkiPSt2AOTp8KRdMPxYRenU4lvhcI=;
 b=Z0Y12UAVasvCs1pXrsFLn/KwOh8PZpOmW3wtuYSMbcRjCdmp7ZW9bJRTD6eHBmLmefDWtj/LtK2m0hbKojUi5bQTdeTVDIIWv3arSreeePE6w2i8sz9RUe+osKghkXLHJrmFCf9PQcpcc3VNScCgEdnST+HfSoyE1MaLnXR+mcT9ArvWckRlLx4h0E0kBEjOmGKO6+R+wLb1pLO5FmVsNd1aWFXiXmAYmN93lU8UdildOzHhxP7sHIk7T5hL2V7GR/Jl7esfbtp9vXPuCz/hFeWXlZoKS1JuapIQVGUtJG/p+8K8kSN1p3URUj02RJTFN8PVDkF4x5NHCxbiE1j3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/0JQ8gW+sy4bxgkiPSt2AOTp8KRdMPxYRenU4lvhcI=;
 b=yBRKU468Vkcbla9JH7CLZqqegBsLlBYCKPVlu3t9u1cwkVapImz+R23rB/hcQ5bH9iF4tTrajSPVZAX8ns3XSm6N8qIFasI5jlYYJbOpEWAaVF2y9Q2rlH4zPejKuWaBZktQsq8P7oIayg8iYnWsjqrHwO0qyUNEND3pV4AcHZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 22:41:58 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 22:41:58 +0000
Message-ID: <aa35a445-f410-b11f-bf21-3e482647faae@amd.com>
Date:   Tue, 16 May 2023 17:41:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv11 0/9] mm, x86/cc, efi: Implement support for unaccepted
 memory
Content-Language: en-US
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
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0117.namprd05.prod.outlook.com
 (2603:10b6:803:42::34) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aef08d9-5993-4011-1b94-08db565ec1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4QqRc3ybMaHXCp2QPIWfwlT2kNbclpo5sTJxARzrL8a1riv3ur3Xamy9eZb6HB7sYbWsTzZBhv90QvJLuPXeXgvQYWJwHW/HETzOreHINmRJ9jkAxJWMqJAr/3MVv1AbDmVtim5sYuGG4d0vKIWT+2okD2+U1tMr6a6FSkjMK368ngTWRitatpgvfpDnPaWpkMgCG2fnqkNtZ0KLMAp4Fr2xLbOfnZvt4/ZhsRVL1+eYKb1YpRY/JafC+lH+jztnGsvY1swxDdnzyxX+irD29f9gf0p0N1aW7kUUwH/clkBFM8bS1KbexGbYY3Y3Fm1Ru3HpILmS3uV2Pz+9qjLzoiECtjACCJPu9fQ+L1W8WSZfYqYdTd2cAdyTzP2B7sND1th7Vhrv8wge+o65kW3FULXR1MA4z3b4EiPbKeQVZbCF5rmeGh4aaeFKI7FlnfBX+dde7yyp9cExFCMW7Uc0bpIBkEwZ9Ughf/IkGpZSrdeJkx17X6gN+Y768aF//M77INt1mMPn7J58MmeGiwq3C689lAgt09jMKWGcTe0lyeOkWmZpjnhGcvJ2GmkJcjeys/Kw+tk2x6ghfjDZWpQggGcKLdCf15lIXbBMJStgUcr4ZUWh9AKGnG25tn89oekIR2Hl2zpI35spPhV79BCZ95+PYWre2PDI02R0wgaBwD/WeRNsPES3hwLLUeH2g8gs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(31686004)(478600001)(66556008)(31696002)(110136005)(6666004)(66476007)(66946007)(966005)(6486002)(36756003)(54906003)(4326008)(86362001)(316002)(186003)(26005)(2616005)(38100700002)(6506007)(7416002)(6512007)(2906002)(8676002)(8936002)(7406005)(5660300002)(41300700001)(53546011)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3pvbkhxaXltd0hzZmZDN210TFk2Q2dGSGRsNzFlaExJQXFmQTFYRGNzdVEv?=
 =?utf-8?B?MmtqUC94NzJwYnZqVUhLa2t1eVBIZkEvQWZPQnQ1cFFrcWVxdytMR3ZCd1V5?=
 =?utf-8?B?QllndUk2SzV4czJ4c1JmVk04VDVGMUxwQlVibnc4aWJweEl0cUZOYUhNZ0tx?=
 =?utf-8?B?am00RmJNb2lhaFRMd0ZrL21DNEdBRTdKeWk3RTM3di9WTDVxVUR5TkF6WWw4?=
 =?utf-8?B?RlhZTStDQThtRzRjWnpUOXZHamtNQ1NoalArVkFMZjZwamU4dHQzOVNDVmNz?=
 =?utf-8?B?eVJ3bDZmK3EyczJyamcwWUxsS1VSSENMWFltRVRFaHdTQnRrcVpLdzdUbmY0?=
 =?utf-8?B?MmlldGljd1FRZFJ5VGpTejVkbEdidFM0eUo5UWw2UFI0UnMrSm1TWG15Q3NV?=
 =?utf-8?B?ZERsY0FIY2t2WjdZYWFreXJBVCtTcVpuM3JBZjZtWnpIcHBhM016WFkzTWZ4?=
 =?utf-8?B?eC95N2ZzYXBlVUZnUndFY3R1QzNHcGJvOHhuS1dBRmRsMlQvRXVUc0JmM3dS?=
 =?utf-8?B?ZkJvMzRmakcvOUZHQ1cxNjBFa2VpKytuSEhGWm0wc1RxZGpPQWx6ZWtxWFp6?=
 =?utf-8?B?RkdvOEVyS1FhN1FhbCthV3BlOXBMYzdYMmJUbVk2UHVsSlVNRGpUVVoxaC8w?=
 =?utf-8?B?Ukp5djZPRWlYaEJManFlWnNkWVYzd1UrUC9WTHBXWDlLcG96d25Wbm90dkFu?=
 =?utf-8?B?ZEhQQUV3SGlXUjlTSWRwUytBM3k5bVlKWUZJMEN3VVVSMnJIRUxPaUxnc0Jl?=
 =?utf-8?B?MlN6ekltMlNMV0RTRldzQ3Ruby9TS3FsZ1NCNVI3UUdBc2RvenBHOHQxaWVa?=
 =?utf-8?B?Y0FJRjU5SUxDSWNrZkhVQXBqM1pYNUdITjV4YVZnNTNBejBzOVVocWo3Sjhi?=
 =?utf-8?B?UmpKUGk5c25BdkI3STl2TDN3SzVWVVQ1LzYrVE5HTmtYelhNaXMyUmsvYmpX?=
 =?utf-8?B?Rk9TaUt1MXdyWDFSZ3dKcmdhRVZWMFFVRWZ6ZTN2aFA2R25UTW9ZN2YrVi9y?=
 =?utf-8?B?REtIMkJxaGhXL1Y5RlpBZ1Y1Qk5Ya05nQlNoeHlHQ1dnbjBvV3VYQXVTdmpz?=
 =?utf-8?B?RWs1L2RwcGo5dDJjY2xmTS9lRk5kWlowcWFzUzdmTTY2UzhGR3lXbXdIQ1Rv?=
 =?utf-8?B?YjJkZStCT1hvUFRsUUxJZS91M3ExWm9lYmFYdmFVTVB3RnQ3NFpHQlhSRFQw?=
 =?utf-8?B?UVU4N2t5VmM0WWM5ckFmTlM1Zm5nbnVEN2pUMkZSWE92NU1aeTRRbGJHZDBW?=
 =?utf-8?B?RDBDbi8raFJyVndBc3hzSWdsL0ZIdUdyTlRyQjE1bUJNZWZQdVg4c0c0NTJJ?=
 =?utf-8?B?eWhwR3VvNTFQOHNMMlBuUkxlZDBjKzVESjVucGVvOFMwUW9DZ1ZtMkNXRFBk?=
 =?utf-8?B?TmdFZkNDbGRUMnRwMmFKK3ZpdVBwQ21UbWlJSEVMSkdmQkJ0bGhWcnpUTCt2?=
 =?utf-8?B?QUllK25pbVlRUTNHZ0xSWEFRbVVXVWE3c3JYOFlwUXBZQUQ0Z2Vtd0NjVW40?=
 =?utf-8?B?b3ZqaUN4RGg5bG1TWFBiYTN0cU5aNXRjK0g2QUJFamtvSzFtZ3JRT1JIS1Iz?=
 =?utf-8?B?cjIvQVFQbGduWkJvYlA0K0J6eUFLRW5GUU1SemNBdG5iSHdOMkdJNlNpQ1oy?=
 =?utf-8?B?UTFZaWExMEZxTHAwT0cxdGo2MDlzQVNBNjU5d1hteHFBbTZYZGJ6MUJ2Zmw2?=
 =?utf-8?B?MlhvNXkvQ01PNVc3Rnc2SVBuVDV4OUlwOUl6RXRnMThjU3BtWUVNUXRqdWt3?=
 =?utf-8?B?ekFseVk5WTBxVEZVajUzVzFJbTUra1o4LzM3Vm5BVSs4ZDlBbGhqdC9WOTBO?=
 =?utf-8?B?TmczZUd1Q2oxcHpQanR5UW00TTVwUVJwd01ndSt3TG1lRjVSQWU2VHZzTWEz?=
 =?utf-8?B?RHVJOTZMS3lCMHhyckdLTkV1UmZPWlF0WkxTZS9uMVMrdDlEdHdzaHRZSGxx?=
 =?utf-8?B?bHNSTXROM0RieTdCL2tDQ01XblZJYW9jNUVEVXpzQzZ2TzJISDhzc3V4SFlO?=
 =?utf-8?B?cWgwWlRHbDNweDlFQlFpS1YyMkZWSGE3ck5Tb216ckdzcXpGMWROTDYyYjhj?=
 =?utf-8?B?MDhERXNTY0xQRVFMYlAzVjNsMTBXYnFoZzFjeVFjQmdBRmNPTGQ5aTg1M285?=
 =?utf-8?Q?xnpc0ZyTwDKmhJM3ktAU5s1wf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aef08d9-5993-4011-1b94-08db565ec1d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 22:41:58.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASWPogP9ixIvOkQ54xXZAV67zPmYo371R7cG8CptGeVWWYOJ9uV4Xv2o2AjQV0JnIn6w9yCWXoNSMNKr9zwh/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/13/23 17:04, Kirill A. Shutemov wrote:
> UEFI Specification version 2.9 introduces the concept of memory
> acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, requiring memory to be accepted before it can be used by the
> guest. Accepting happens via a protocol specific for the Virtual
> Machine platform.
> 
> Accepting memory is costly and it makes VMM allocate memory for the
> accepted guest physical address range. It's better to postpone memory
> acceptance until memory is needed. It lowers boot time and reduces
> memory overhead.
> 
> The kernel needs to know what memory has been accepted. Firmware
> communicates this information via memory map: a new memory type --
> EFI_UNACCEPTED_MEMORY -- indicates such memory.
> 
> Range-based tracking works fine for firmware, but it gets bulky for
> the kernel: e820 has to be modified on every page acceptance. It leads
> to table fragmentation, but there's a limited number of entries in the
> e820 table
> 
> Another option is to mark such memory as usable in e820 and track if the
> range has been accepted in a bitmap. One bit in the bitmap represents
> 2MiB in the address space: one 4k page is enough to track 64GiB or
> physical address space.
> 
> In the worst-case scenario -- a huge hole in the middle of the
> address space -- It needs 256MiB to handle 4PiB of the address
> space.
> 
> Any unaccepted memory that is not aligned to 2M gets accepted upfront.
> 
> The approach lowers boot time substantially. Boot to shell is ~2.5x
> faster for 4G TDX VM and ~4x faster for 64G.
> 
> TDX-specific code isolated from the core of unaccepted memory support. It
> supposed to help to plug-in different implementation of unaccepted memory
> such as SEV-SNP.
> 
> -- Fragmentation study --
> 
> Vlastimil and Mel were concern about effect of unaccepted memory on
> fragmentation prevention measures in page allocator. I tried to evaluate
> it, but it is tricky. As suggested I tried to run multiple parallel kernel
> builds and follow how often kmem:mm_page_alloc_extfrag gets hit.
> 
> See results in the v9 of the patchset[1][2]
> 
> [1] https://lore.kernel.org/all/20230330114956.20342-1-kirill.shutemov@linux.intel.com
> [2] https://lore.kernel.org/all/20230416191940.ex7ao43pmrjhru2p@box.shutemov.name
> 
> --
> 
> The tree can be found here:
> 
> https://github.com/intel/tdx.git guest-unaccepted-memory

I get some failures when building without TDX support selected in my
kernel config after adding unaccepted memory support for SNP:

   In file included from arch/x86/boot/compressed/../../coco/tdx/tdx-shared.c:1,
                    from arch/x86/boot/compressed/tdx-shared.c:2:
   ./arch/x86/include/asm/tdx.h: In function ‘tdx_kvm_hypercall’:
   ./arch/x86/include/asm/tdx.h:72:17: error: ‘ENODEV’ undeclared (first use in this function)
      72 |         return -ENODEV;
         |                 ^~~~~~
   ./arch/x86/include/asm/tdx.h:72:17: note: each undeclared identifier is reported only once for each function it appears in

Adding an include for linux/errno.h gets past that error, but then
I get the following:

   ld: arch/x86/boot/compressed/tdx-shared.o: in function `tdx_enc_status_changed_phys':
   tdx-shared.c:(.text+0x42): undefined reference to `__tdx_hypercall'
   ld: tdx-shared.c:(.text+0x7f): undefined reference to `__tdx_module_call'
   ld: tdx-shared.c:(.text+0xce): undefined reference to `__tdx_module_call'
   ld: tdx-shared.c:(.text+0x13b): undefined reference to `__tdx_module_call'
   ld: tdx-shared.c:(.text+0x153): undefined reference to `cc_mkdec'
   ld: tdx-shared.c:(.text+0x15d): undefined reference to `cc_mkdec'
   ld: tdx-shared.c:(.text+0x18e): undefined reference to `__tdx_hypercall'
   ld: arch/x86/boot/compressed/vmlinux: hidden symbol `__tdx_hypercall' isn't defined
   ld: final link failed: bad value

So it looks like arch/x86/boot/compressed/tdx-shared.c is being
built, while arch/x86/boot/compressed/tdx.c isn't.

After setting TDX in the kernel config, I can build successfully, but
I'm running into an error when trying to accept memory during
decompression.

In drivers/firmware/efi/libstub/unaccepted_memory.c, I can see that the
unaccepted_table is allocated, but when accept_memory() is invoked the
table address is now zero. I thought maybe it had to do with bss, but even
putting it in the .data section didn't help. I'll keep digging, but if you
have any ideas, that would be great.

Thanks,
Tom

> 
> The patchset depends on MAX_ORDER changes in MM tree.
> 
> v11:
>   - Restructure the code to make it less x86-specific (suggested by Ard):
>     + use EFI configuration table instead of zero-page to pass down bitmap;
>     + do not imply 1bit == 2M in bitmap;
>     + move bulk of the code under driver/firmware/efi;
>   - The bitmap only covers unaccpeted memory now. All memory that is not covered
>     by the bitmap assumed accepted;
>   - Reviewed-by from Ard;
> v10:
>   - Restructure code around zones_with_unaccepted_pages static brach to avoid
>     unnecessary function calls (Suggested by Vlastimil);
>   - Drop mentions of PageUnaccepted();
>   - Drop patches that add fake unaccepted memory support and sysfs handle to
>     accept memory manually;
>   - Add Reviewed-by from Vlastimil;
> v9:
>   - Accept memory up to high watermark when kernel runs out of free memory;
>   - Treat unaccepted memory as unusable in __zone_watermark_unusable_free();
>   - Per-zone unaccepted memory accounting;
>   - All pages on unaccepted list are MAX_ORDER now;
>   - accept_memory=eager in cmdline to pre-accept memory during the boot;
>   - Implement fake unaccepted memory;
>   - Sysfs handle to accept memory manually;
>   - Drop PageUnaccepted();
>   - Rename unaccepted_pages static key to zones_with_unaccepted_pages;
> v8:
>   - Rewrite core-mm support for unaccepted memory (patch 02/14);
>   - s/UnacceptedPages/Unaccepted/ in meminfo;
>   - Drop arch/x86/boot/compressed/compiler.h;
>   - Fix build errors;
>   - Adjust commit messages and comments;
>   - Reviewed-bys from Dave and Borislav;
>   - Rebased to tip/master.
> v7:
>   - Rework meminfo counter to use PageUnaccepted() and move to generic code;
>   - Fix range_contains_unaccepted_memory() on machines without unaccepted memory;
>   - Add Reviewed-by from David;
> v6:
>   - Fix load_unaligned_zeropad() on machine with unaccepted memory;
>   - Clear PageUnaccepted() on merged pages, leaving it only on head;
>   - Clarify error handling in allocate_e820();
>   - Fix build with CONFIG_UNACCEPTED_MEMORY=y, but without TDX;
>   - Disable kexec at boottime instead of build conflict;
>   - Rebased to tip/master;
>   - Spelling fixes;
>   - Add Reviewed-by from Mike and David;
> v5:
>   - Updates comments and commit messages;
>     + Explain options for unaccepted memory handling;
>   - Expose amount of unaccepted memory in /proc/meminfo
>   - Adjust check in page_expected_state();
>   - Fix error code handling in allocate_e820();
>   - Centralize __pa()/__va() definitions in the boot stub;
>   - Avoid includes from the main kernel in the boot stub;
>   - Use an existing hole in boot_param for unaccepted_memory, instead of adding
>     to the end of the structure;
>   - Extract allocate_unaccepted_memory() form allocate_e820();
>   - Complain if there's unaccepted memory, but kernel does not support it;
>   - Fix vmstat counter;
>   - Split up few preparatory patches;
>   - Random readability adjustments;
> v4:
>   - PageBuddyUnaccepted() -> PageUnaccepted;
>   - Use separate page_type, not shared with offline;
>   - Rework interface between core-mm and arch code;
>   - Adjust commit messages;
>   - Ack from Mike;
> 
> Kirill A. Shutemov (9):
>    mm: Add support for unaccepted memory
>    efi/x86: Get full memory map in allocate_e820()
>    efi/libstub: Implement support for unaccepted memory
>    x86/boot/compressed: Handle unaccepted memory
>    efi: Provide helpers for unaccepted memory
>    efi/unaccepted: Avoid load_unaligned_zeropad() stepping into
>      unaccepted memory
>    x86/tdx: Make _tdx_hypercall() and __tdx_module_call() available in
>      boot stub
>    x86/tdx: Refactor try_accept_one()
>    x86/tdx: Add unaccepted memory support
> 
>   arch/x86/Kconfig                              |   2 +
>   arch/x86/boot/compressed/Makefile             |   1 +
>   arch/x86/boot/compressed/efi.h                |   1 +
>   arch/x86/boot/compressed/error.c              |  19 ++
>   arch/x86/boot/compressed/error.h              |   1 +
>   arch/x86/boot/compressed/kaslr.c              |  35 ++-
>   arch/x86/boot/compressed/mem.c                |  42 ++++
>   arch/x86/boot/compressed/misc.c               |   6 +
>   arch/x86/boot/compressed/misc.h               |   6 +
>   arch/x86/boot/compressed/tdx-shared.c         |   2 +
>   arch/x86/boot/compressed/tdx.c                |  37 +++
>   arch/x86/coco/tdx/Makefile                    |   2 +-
>   arch/x86/coco/tdx/tdx-shared.c                |  95 ++++++++
>   arch/x86/coco/tdx/tdx.c                       | 118 +---------
>   arch/x86/include/asm/efi.h                    |   2 +
>   arch/x86/include/asm/shared/tdx.h             |  53 +++++
>   arch/x86/include/asm/tdx.h                    |  21 +-
>   arch/x86/include/asm/unaccepted_memory.h      |  23 ++
>   drivers/base/node.c                           |   7 +
>   drivers/firmware/efi/Kconfig                  |  14 ++
>   drivers/firmware/efi/Makefile                 |   1 +
>   drivers/firmware/efi/efi.c                    |   7 +
>   drivers/firmware/efi/libstub/Makefile         |   2 +
>   drivers/firmware/efi/libstub/bitmap.c         |  41 ++++
>   drivers/firmware/efi/libstub/efistub.h        |   6 +
>   drivers/firmware/efi/libstub/find.c           |  43 ++++
>   .../firmware/efi/libstub/unaccepted_memory.c  | 222 ++++++++++++++++++
>   drivers/firmware/efi/libstub/x86-stub.c       |  39 +--
>   drivers/firmware/efi/unaccepted_memory.c      | 138 +++++++++++
>   fs/proc/meminfo.c                             |   5 +
>   include/linux/efi.h                           |  13 +-
>   include/linux/mm.h                            |  19 ++
>   include/linux/mmzone.h                        |   8 +
>   mm/internal.h                                 |   1 +
>   mm/memblock.c                                 |   9 +
>   mm/mm_init.c                                  |   7 +
>   mm/page_alloc.c                               | 173 ++++++++++++++
>   mm/vmstat.c                                   |   3 +
>   38 files changed, 1060 insertions(+), 164 deletions(-)
>   create mode 100644 arch/x86/boot/compressed/mem.c
>   create mode 100644 arch/x86/boot/compressed/tdx-shared.c
>   create mode 100644 arch/x86/coco/tdx/tdx-shared.c
>   create mode 100644 arch/x86/include/asm/unaccepted_memory.h
>   create mode 100644 drivers/firmware/efi/libstub/bitmap.c
>   create mode 100644 drivers/firmware/efi/libstub/find.c
>   create mode 100644 drivers/firmware/efi/libstub/unaccepted_memory.c
>   create mode 100644 drivers/firmware/efi/unaccepted_memory.c
> 
