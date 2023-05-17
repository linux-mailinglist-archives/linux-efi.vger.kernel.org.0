Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4947C70712F
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 20:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjEQSun (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 May 2023 14:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjEQSu2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 May 2023 14:50:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22C283D8;
        Wed, 17 May 2023 11:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZhiDI2yI5z9TJukLJ2fAfqVeEExCK6Cxcj4ADNZF+JotAKNJg/KjdPkcPBGKF+liTP+782AY9UtTuLov3+qvJa8DAx2cUDf8zYvSFYpnUPa8q4oTifgbD8zpMLXHk+Gakp6ZRDrV5tnvZgVcxhOxwv7Sy9MdipJsLqiu8XAq2CkgkJCr4phI7mCwb3FyEG08EjkSjRL2PXRX1aUzCYfQLbNn2kdBPgYjlTHqhrai4Qh6pb1oWSUt5oT65dAJ+484wirwFpBBcnU8BKy+3HI8bYpRTcKMXVW/dYRg4E2bHo01E4bLflPEWEqZ5kPEPXbABPrBqf6ivM1palFVUHSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhlSkO4Afmcr1hDy8VkNonTXlDfIShCdtVdzyf+OEZs=;
 b=NkdEhTkw0gNngICfPVpD3pWuew6fu/QN4au3wmH6HHzDh1nAUte11ZYKpa8aeSVmoVbDaKgrKyoa42eFBbLJ26pQch9pvqIkhZsdAkKoEhw6HDQaiCC/YBuV7UwOOoYxBmgTDpv4L8SNtqwKRahaoFWm2RsiJmymlmetgpEuklfbYNf22kOQygYJ+sEVy8DBURKiM8qlLEw05ee5qC0sVDQLjbiGj2gHkWSmFYBuqKglB6tTWbjmn+4nFLC3CuAKF4Vk5RCZ5QzRCHTDBkptpzBh3YbNsjY97vfqL6++J0FY08vF3Crp+ufZWSQ67nFcLz8oVavP5fAkz1bhBdsF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhlSkO4Afmcr1hDy8VkNonTXlDfIShCdtVdzyf+OEZs=;
 b=qCP4K9hwimN3aXX/Jixh6o4bPv795BaAYXwN340O2uiNp+t/zfgmpvuCifMm8GTYNNOkkTGbNrAlxXN2BEoTocnbMJjMVgDWjvvWR3hLdZxD4yDQq5poC/r1ZcMc+G2TblwaqONrL24/rtO63Pgc5YJRaegbmot9rY1kbZlFuEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Wed, 17 May 2023 18:50:03 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 18:50:03 +0000
Message-ID: <0bf8b506-00a4-ce3b-edbc-240d20fb9f27@amd.com>
Date:   Wed, 17 May 2023 13:50:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv11 0/9] mm, x86/cc, efi: Implement support for unaccepted
 memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
 <fe62b3a6-2c28-a069-d880-772fe6c13125@amd.com>
 <20230517183601.vgdnuchw3we2abua@box.shutemov.name>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230517183601.vgdnuchw3we2abua@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:806:120::29) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: b7960dd7-96ce-4cdf-6f0f-08db5707865a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exZvOeqkgqG1FmQzvLAfCV9bjUrYWDIB62vSbnFDjLAE7EiG23OBW14XEejONwgIso1PkGizyHybluR85IyG44ASKNjKV9XFf+6iexjxX1MYv1oKiEJQIlgF1tWZy8WGri/6aCYGRyDVsYGJYvQp0+JVH96aTJE29HZPUxJd/yK+0MKUd7BE8yQavXFQ3bLvHS8gOw5K8Wc7WzjlSg9qfDe33kEOZgW2mrXo5ViuVotvVcE11w20UNpevEOJZh5Ogd6zK2ln6vB292tK37Y+R1y4eh/rxGN+v0hzpc9JB/ogXSZlsE3YVjlP5XyDpS6ljj78eyXWrOAqhNOv4emtya+KkQeBZQZKjCtCkU8E6I08DwPQym2i5t+WKhRaWEESB1yOf0d88nLpCBd1yHXOG9bSSx2B92Uz7eTKUP0KrOiQT4fajUNt0JN+0ku66o7SyKTvPzRWkj9IpmFjA4n+6//s49Z51p3TSK2zJMh840JqtLebq7W4a/GmZgjJPoenTIUDsQniMD90MG1gxLwD1tEKP2AqY8WzvkdlplscHF1vmbbb8pDKwI2eq/UQdu/QbMW+x5D2JVwKQwyGFxDuqBa7RNtq7Jlok6357zwuj7pNlm/XpCCXfqVUzIBo1YSYrjBpya6a/tqmU9q39wiMMT63aweoJIsdFUciAI5U0AwZGHmUAP55kXe9wEQ2twBP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199021)(8936002)(8676002)(5660300002)(86362001)(7416002)(83380400001)(2616005)(6512007)(966005)(6506007)(53546011)(31696002)(186003)(38100700002)(26005)(54906003)(6486002)(478600001)(316002)(7406005)(41300700001)(66946007)(66476007)(66556008)(36756003)(6916009)(31686004)(4326008)(2906002)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlFhV3dFMmw5YXlqVnp5alFhZ2V2UHREU1VMSlRlUTRSZXpJQzdhdVArdWRk?=
 =?utf-8?B?S0d5T3llNjNyamRMenhnclIxNldhWWZYcU1zZVZhTHdmbW5YM1pmbkphQ2Zs?=
 =?utf-8?B?QWZTOUpVeGUvc0c2aTNNbFBVTUZWcllWU216RU1TZWtJVGZRYXBoMnIweTdz?=
 =?utf-8?B?V1o2S2VtT3pvRFQxd2ZEdXlQcFJtNnZ6RVppZFhLSVg2a0hXQlRHMjJGWmZq?=
 =?utf-8?B?alBkdFIyRmVEMWY4VEJtZzRwL2k0dm1LclJtRTN0SHNScVJxMUM3YndNSVNo?=
 =?utf-8?B?VWJSemFQUkxobDRHamVod1pmZlR5VFpjM1IrWjBGUzFXUjRQWTNWTkdCc2Mr?=
 =?utf-8?B?QzU5aHJLYTBSWkVZT0NFQ1Nmbjg4TWh2dFZ0UDJjZjQxM0k1eUpmNjNheTZT?=
 =?utf-8?B?QnhlTXEwTHJic2N0TXpIUUM0MjdKV3FUbUtpUWNRSFA3ZUdkRUtzcEZsT01S?=
 =?utf-8?B?a2FxbVl4TWVtNkRGOE1ndGRxdWIzY1RScytTcUczSDNCVHJRbFdVcWpEYlFK?=
 =?utf-8?B?UURvTjFXSUJlVmZjcHRPK2JCZjZ0YmIzMXQxZUlPV2hFc0dNTlYvNEFBM3RR?=
 =?utf-8?B?YXFRb2tjSS9jcDFtdjlQRE9paWdTRE1NYWxyTlhTS0pONE00ZXNreDV1TXpL?=
 =?utf-8?B?TGVoVEpXSVhETC8yUkFvYTNxb1V1VTl3dUROcFY0bkdCbmFrQ1NaUlFHSUJi?=
 =?utf-8?B?UmsrcDA0WXVuN1BjMmxwQVdGaWFvdDJOM1VOMzF3eFR6cHVVbE55VVM4Tll2?=
 =?utf-8?B?WGZOQ2NqYzc1MXJ0QVRmTm4rc2lsRldDZVEvMkE3eWV3clV1SG1iTGhuT0g3?=
 =?utf-8?B?U24waTZiY1FiWlFka1ZjWC9nbTk4alFaQ1JJVXFTTEdNN2xhamtPR2J2V2c4?=
 =?utf-8?B?ck1lQzdtUHJGV0h2U3Vsbm5TMFBqRUZIM1hJT0tidTlGazNuamdQOWJGK1NH?=
 =?utf-8?B?K3BKWS90UGdnMjlzeVltMnFvakFxL1QyNmo5QTAra2h6a0t2TXpZV2hMMDhB?=
 =?utf-8?B?VGZjcisxaU9STktWNjJpSkJ3SWR3TmFpZDI3c3RETFRrb2VWakhDb3pBREll?=
 =?utf-8?B?bHg3SjRtNmR1M215d0ZXT3ZyRDhMclJkRCs2bnRBaUpLYU81UDk3STBjU00z?=
 =?utf-8?B?cW16VVpheVB2cjlSWmNZOG43eXFLd1c1dDRWQk9yTzZUMFl6d0RoMElIVUl0?=
 =?utf-8?B?NWJiM2ZHNU1hYjVxYkRjWnB0bmh1bDk4Q3YzNGNGNjQ5cElZME9Hb2lwYkFm?=
 =?utf-8?B?ZVVnNHNFMnAvTGhIbVZaSVp0a25vbk1GempHdlduUFlmRkRJQTNrZ0VSZUZm?=
 =?utf-8?B?dVlzUWRNSi8xN0ZrQkxmbHh5QnFZMXVLVThBOFZYWmhsMllSUDR6VTFJbEI3?=
 =?utf-8?B?QTNUR1VqQ0FHWk4veGdUVlBuQ0VpcTdKQVYreWNhNXZQUTk4QjN4OXVSQjI3?=
 =?utf-8?B?QnNIZjNrVk5tR1B0NG1OMVB6L24yb2Y5RHY1VnNyeEEzVm96V2ZjRHhpdU83?=
 =?utf-8?B?ditsWG0weUF0WGdpQ3lUZE5TR2d6ZDBVcnM1N1piN1UyWGxudTd4SWM1cHhQ?=
 =?utf-8?B?Z0EyTHlkckxqejFtQjdKaENIeUVUZHNYVHZ3RmJOdVlUNFlnSGZWMFZwTnFX?=
 =?utf-8?B?bjZuZExJMUxpRFlOMHB0M0tYSHBtNnF1MHFWbFd2dTVidSs0QlhMOUd6S2pQ?=
 =?utf-8?B?QnBIQlJkR2NzbGhqNHQvZU9EbjdhK3FyVVkxTVkwTllKSU1YbkR5WlU1MzAx?=
 =?utf-8?B?VmR4bk9sU1hic2dMaTAwcE1hYkxNcEU2aWRMcHM4VGV2UWlsby9qR2U0Nm5a?=
 =?utf-8?B?TUxxOHRYa2FJUURRKzd0UkRrcW1SeTZtY0FUMUhNY2VpdnBxQVJYTUlDZmpY?=
 =?utf-8?B?Unl6aU9MVWxraFJGMk5Fbys4WTZZQTZLSFdGaDlkN3gxM3M0SHJsTjg0RlRy?=
 =?utf-8?B?ejk3S2lrK1VaUm9nREtXai9CUnBDZjNkbmJLbVVlUTNuaEV3Z1VEM2IxUGg0?=
 =?utf-8?B?OFdrN3FkK0VwYytMYW41bXRIOHBNK2I0ZjJ1MVBOZnFHYkd2YzBQdHp4SVg1?=
 =?utf-8?B?UkZ4ejNXOGwxZnA1NVprY2JJamhmemx2aXU5REpsWk5EUU43NGFiMWxyYkwr?=
 =?utf-8?Q?7u8WxkhxCn6veo4pXH6V6zKoY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7960dd7-96ce-4cdf-6f0f-08db5707865a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 18:50:03.6602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KL/JA1RjiR26EGiptsW/wOjF+NNrc2WfS/LHtDGP9NqqtDxnsrmGZjHNIeLxhXt0YxVttr51aMAVIL/QwXNq3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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

On 5/17/23 13:36, Kirill A. Shutemov wrote:
> On Wed, May 17, 2023 at 09:32:27AM -0500, Tom Lendacky wrote:
>> On 5/16/23 18:22, Kirill A. Shutemov wrote:
>>> On Tue, May 16, 2023 at 05:41:55PM -0500, Tom Lendacky wrote:
>>>> On 5/13/23 17:04, Kirill A. Shutemov wrote:
>>>>> UEFI Specification version 2.9 introduces the concept of memory
>>>>> acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
>>>>> SEV-SNP, requiring memory to be accepted before it can be used by the
>>>>> guest. Accepting happens via a protocol specific for the Virtual
>>>>> Machine platform.
>>>>>
>>>>> Accepting memory is costly and it makes VMM allocate memory for the
>>>>> accepted guest physical address range. It's better to postpone memory
>>>>> acceptance until memory is needed. It lowers boot time and reduces
>>>>> memory overhead.
>>>>>
>>>>> The kernel needs to know what memory has been accepted. Firmware
>>>>> communicates this information via memory map: a new memory type --
>>>>> EFI_UNACCEPTED_MEMORY -- indicates such memory.
>>>>>
>>>>> Range-based tracking works fine for firmware, but it gets bulky for
>>>>> the kernel: e820 has to be modified on every page acceptance. It leads
>>>>> to table fragmentation, but there's a limited number of entries in the
>>>>> e820 table
>>>>>
>>>>> Another option is to mark such memory as usable in e820 and track if the
>>>>> range has been accepted in a bitmap. One bit in the bitmap represents
>>>>> 2MiB in the address space: one 4k page is enough to track 64GiB or
>>>>> physical address space.
>>>>>
>>>>> In the worst-case scenario -- a huge hole in the middle of the
>>>>> address space -- It needs 256MiB to handle 4PiB of the address
>>>>> space.
>>>>>
>>>>> Any unaccepted memory that is not aligned to 2M gets accepted upfront.
>>>>>
>>>>> The approach lowers boot time substantially. Boot to shell is ~2.5x
>>>>> faster for 4G TDX VM and ~4x faster for 64G.
>>>>>
>>>>> TDX-specific code isolated from the core of unaccepted memory support. It
>>>>> supposed to help to plug-in different implementation of unaccepted memory
>>>>> such as SEV-SNP.
>>>>>
>>>>> -- Fragmentation study --
>>>>>
>>>>> Vlastimil and Mel were concern about effect of unaccepted memory on
>>>>> fragmentation prevention measures in page allocator. I tried to evaluate
>>>>> it, but it is tricky. As suggested I tried to run multiple parallel kernel
>>>>> builds and follow how often kmem:mm_page_alloc_extfrag gets hit.
>>>>>
>>>>> See results in the v9 of the patchset[1][2]
>>>>>
>>>>> [1] https://lore.kernel.org/all/20230330114956.20342-1-kirill.shutemov@linux.intel.com
>>>>> [2] https://lore.kernel.org/all/20230416191940.ex7ao43pmrjhru2p@box.shutemov.name
>>>>>
>>>>> --
>>>>>
>>>>> The tree can be found here:
>>>>>
>>>>> https://github.com/intel/tdx.git guest-unaccepted-memory
>>>>
>>>> I get some failures when building without TDX support selected in my
>>>> kernel config after adding unaccepted memory support for SNP:
>>>>
>>>>     In file included from arch/x86/boot/compressed/../../coco/tdx/tdx-shared.c:1,
>>>>                      from arch/x86/boot/compressed/tdx-shared.c:2:
>>>>     ./arch/x86/include/asm/tdx.h: In function ?tdx_kvm_hypercall?:
>>>>     ./arch/x86/include/asm/tdx.h:72:17: error: ?ENODEV? undeclared (first use in this function)
>>>>        72 |         return -ENODEV;
>>>>           |                 ^~~~~~
>>>>     ./arch/x86/include/asm/tdx.h:72:17: note: each undeclared identifier is reported only once for each function it appears in
>>>>
>>>> Adding an include for linux/errno.h gets past that error, but then
>>>> I get the following:
>>>>
>>>>     ld: arch/x86/boot/compressed/tdx-shared.o: in function `tdx_enc_status_changed_phys':
>>>>     tdx-shared.c:(.text+0x42): undefined reference to `__tdx_hypercall'
>>>>     ld: tdx-shared.c:(.text+0x7f): undefined reference to `__tdx_module_call'
>>>>     ld: tdx-shared.c:(.text+0xce): undefined reference to `__tdx_module_call'
>>>>     ld: tdx-shared.c:(.text+0x13b): undefined reference to `__tdx_module_call'
>>>>     ld: tdx-shared.c:(.text+0x153): undefined reference to `cc_mkdec'
>>>>     ld: tdx-shared.c:(.text+0x15d): undefined reference to `cc_mkdec'
>>>>     ld: tdx-shared.c:(.text+0x18e): undefined reference to `__tdx_hypercall'
>>>>     ld: arch/x86/boot/compressed/vmlinux: hidden symbol `__tdx_hypercall' isn't defined
>>>>     ld: final link failed: bad value
>>>>
>>>> So it looks like arch/x86/boot/compressed/tdx-shared.c is being
>>>> built, while arch/x86/boot/compressed/tdx.c isn't.
>>>
>>> Right. I think this should help:
>>>
>>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>>> index 78f67e0a2666..b13a58021086 100644
>>> --- a/arch/x86/boot/compressed/Makefile
>>> +++ b/arch/x86/boot/compressed/Makefile
>>> @@ -106,8 +106,8 @@ ifdef CONFIG_X86_64
>>>    endif
>>>
>>>    vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>>> -vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
>>> -vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o $(obj)/tdx-shared.o
>>> +vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o $(obj)/tdx-shared.o
>>> +vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/mem.o
>>>
>>>    vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>>>    vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>>>
>>>> After setting TDX in the kernel config, I can build successfully, but
>>>> I'm running into an error when trying to accept memory during
>>>> decompression.
>>>>
>>>> In drivers/firmware/efi/libstub/unaccepted_memory.c, I can see that the
>>>> unaccepted_table is allocated, but when accept_memory() is invoked the
>>>> table address is now zero. I thought maybe it had to do with bss, but even
>>>> putting it in the .data section didn't help. I'll keep digging, but if you
>>>> have any ideas, that would be great.
>>>
>>> Not right away. But maybe seeing your side of enabling would help.
>>
>> Let me get something pushed up where you can access it and I'll also send
>> you my kernel config.
>>
>> In the mean time I added the following and everything worked. But I'm not
>> sure how acceptable it is to always be checking for the table when the
>> value is zero is.
>>
>>
>> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
>> index f4642c4f25dd..8c5632ab1208 100644
>> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
>> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
>> @@ -183,8 +183,13 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>>   	unsigned long bitmap_size;
>>   	u64 unit_size;
>> -	if (!unaccepted_table)
>> -		return;
>> +	if (!unaccepted_table) {
>> +		efi_guid_t unaccepted_table_guid = LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
>> +
>> +		unaccepted_table = get_efi_config_table(unaccepted_table_guid);
>> +		if (!unaccepted_table)
>> +			return;
>> +	}
>>   	unit_size = unaccepted_table->unit_size;
>>
> 
> Kudos to Ard: if efi_relocate_kernel() triggered, it copies the kernel
> image to the new place before the variable gets initialized, so it has to
> be initialized explicitly by decompressor.
> 
> It also covers the cases when bootloader doesn't use EFI stub, including
> kexec cases.
> 
> I think this fixup should work.

Yes, this fixup takes care of the problem I was seeing.

Thanks!
Tom

> 
> diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
> index cf475243b6d5..866c0af8b5b9 100644
> --- a/arch/x86/boot/compressed/efi.h
> +++ b/arch/x86/boot/compressed/efi.h
> @@ -16,6 +16,7 @@ typedef guid_t efi_guid_t __aligned(__alignof__(u32));
>   #define ACPI_TABLE_GUID				EFI_GUID(0xeb9d2d30, 0x2d88, 0x11d3,  0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
>   #define ACPI_20_TABLE_GUID			EFI_GUID(0x8868e871, 0xe4f1, 0x11d3,  0xbc, 0x22, 0x00, 0x80, 0xc7, 0x3c, 0x88, 0x81)
>   #define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
> +#define LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID	EFI_GUID(0xd5d1de3c, 0x105c, 0x44f9,  0x9e, 0xa9, 0xbc, 0xef, 0x98, 0x12, 0x00, 0x31)
>   
>   #define EFI32_LOADER_SIGNATURE	"EL32"
>   #define EFI64_LOADER_SIGNATURE	"EL64"
> @@ -105,6 +106,14 @@ struct efi_setup_data {
>   	u64 reserved[8];
>   };
>   
> +struct efi_unaccepted_memory {
> +	u32 version;
> +	u32 unit_size;
> +	u64 phys_base;
> +	u64 size;
> +	unsigned long bitmap[];
> +};
> +
>   static inline int efi_guidcmp (efi_guid_t left, efi_guid_t right)
>   {
>   	return memcmp(&left, &right, sizeof (efi_guid_t));
> diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
> index a4308d077885..0108c97399a5 100644
> --- a/arch/x86/boot/compressed/mem.c
> +++ b/arch/x86/boot/compressed/mem.c
> @@ -1,8 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   
> -#include "../cpuflags.h"
> -#include "../string.h"
>   #include "error.h"
> +#include "misc.h"
>   #include "tdx.h"
>   #include <asm/shared/tdx.h>
>   
> @@ -40,3 +39,25 @@ void arch_accept_memory(phys_addr_t start, phys_addr_t end)
>   	else
>   		error("Cannot accept memory: unknown platform\n");
>   }
> +
> +void init_unaccepted_memory(void)
> +{
> +	guid_t guid =  LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID;
> +	struct efi_unaccepted_memory *unaccepted_table;
> +	unsigned long cfg_table_pa;
> +	unsigned int cfg_table_len;
> +	int ret;
> +
> +	ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
> +	if (ret)
> +		error("EFI config table not found.");
> +
> +	unaccepted_table = (void *)efi_find_vendor_table(boot_params,
> +							 cfg_table_pa,
> +							 cfg_table_len,
> +							 guid);
> +	if (unaccepted_table->version != 1)
> +		error("Unknown version of unaccepted memory table\n");
> +
> +	set_unaccepted_table(unaccepted_table);
> +}
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index eb8df0d4ad51..36535a3753f5 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -458,6 +458,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>   
>   	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
>   		debug_putstr("Accepting memory... ");
> +		init_unaccepted_memory();
>   		accept_memory(__pa(output), __pa(output) + needed_size);
>   	}
>   
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 9663d1839f54..e1a0b49e0ed2 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -247,10 +247,10 @@ static inline unsigned long efi_find_vendor_table(struct boot_params *bp,
>   }
>   #endif /* CONFIG_EFI */
>   
> -#ifdef CONFIG_UNACCEPTED_MEMORY
> +void init_unaccepted_memory(void);
> +
> +/* Implemented in EFI stub */
> +void set_unaccepted_table(struct efi_unaccepted_memory *table);
>   void accept_memory(phys_addr_t start, phys_addr_t end);
> -#else
> -static inline void accept_memory(phys_addr_t start, phys_addr_t end) {}
> -#endif
>   
>   #endif /* BOOT_COMPRESSED_MISC_H */
> diff --git a/drivers/firmware/efi/libstub/unaccepted_memory.c b/drivers/firmware/efi/libstub/unaccepted_memory.c
> index f4642c4f25dd..fd6a3195c68f 100644
> --- a/drivers/firmware/efi/libstub/unaccepted_memory.c
> +++ b/drivers/firmware/efi/libstub/unaccepted_memory.c
> @@ -6,6 +6,18 @@
>   
>   static struct efi_unaccepted_memory *unaccepted_table;
>   
> +/*
> + * Decompressor needs to initialize the variable to cover cases when the table
> + * is not allocated by EFI stub or EFI stub copied the kernel image with
> + * efi_relocate_kernel() before the variable is set.
> + *
> + * It must be call before the first usage of accept_memory() by decompressor.
> + */
> +void set_unaccepted_table(struct efi_unaccepted_memory *table)
> +{
> +	unaccepted_table = table;
> +}
> +
>   efi_status_t allocate_unaccepted_bitmap(__u32 nr_desc,
>   					struct efi_boot_memmap *map)
>   {
