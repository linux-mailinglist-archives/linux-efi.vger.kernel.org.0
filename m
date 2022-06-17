Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687F954FEF2
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jun 2022 23:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383578AbiFQUxy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Jun 2022 16:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383583AbiFQUxu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Jun 2022 16:53:50 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345C65E75D;
        Fri, 17 Jun 2022 13:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxCGGce+61W5IXnpFr2Dbpw3eh/3QztDnEN1L0Mg8POR297ytNZxyK4DwkGoh1NiCgL5GKLKAmZpEoWeKeb1rNLbF5iHqve5ZLRVUkV6Bk8YeXL2Kt2nEGlwhGs+SU31jpH/RkB2Z8rWWJvmwydQK3uxrn5knJjm6tDSn5xHtIQNk+PC2+hyFpSbWW/0jtKQ4714Da3fwwD8NHmKvIKaBJnwW79bbBbjSUC2J+2IRwgR+WivtJvqH6val9Lx/rCJrQX3LBk1rkExkp83E6T45FI/XjqF3JCzCMNHHLJ933jqKAlVwxIbqASPXSrGYeR85fTXlAD/VRtgb9Db0niqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6CGEExG2ia6hlfkCJo49L5b5uztRGb502RJwuxLAuI=;
 b=WnLVGCMXm/iArx1UMFJRpKU8euBrYbFXcREdOwXgjN3/D46Eg8CFom7nnDQUPdMMnNK/lopk9MWN0sNmEmSKB+1m17gK1siAzNCfJB+wbRceC2le1you3YAQtqPm/zTDn7a2TY1/rIzwj4D3pV2O3NKkeuLlovYuUtz41JtTfeSinZ9zLfdmnLzbpe55UZkBtuzmo5h/xlQuw/FaKX+48bdVLqijR7LZuQiok00IE22B3eujTHIgOY505GFScPkxDrXjsllC5wGJ/LXZzo7erdo8YDuyh0QQRkFwt/FFsKMBKqJLkHbxPwxaz081pjXdDebicjuz/mwYGVsz3rCVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6CGEExG2ia6hlfkCJo49L5b5uztRGb502RJwuxLAuI=;
 b=1/j/3P50w4hyDlN6QDDP2EBvItakQGJyQxpxhagEP8/h+tGs0BtkNqfO0tENqeB/bQQCKesarTDSE6OCM2x4yisk2bAy4RlSGXWS56iOWusO7Q46nFRDmuwjnjdFW7vOUT0vZGjPNajcaOUn/Aznm7exLGQ+1Qc1Y//JCh7fr5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BN6PR12MB1892.namprd12.prod.outlook.com (2603:10b6:404:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 20:53:47 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::9084:a97b:ab5c:6642]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::9084:a97b:ab5c:6642%6]) with mapi id 15.20.5353.018; Fri, 17 Jun 2022
 20:53:47 +0000
Message-ID: <7c4834e6-5d87-80ed-06c1-6f4c8aa489cf@amd.com>
Date:   Fri, 17 Jun 2022 15:53:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <af8038c6-d14e-a327-7685-14bcee778c96@amd.com>
In-Reply-To: <af8038c6-d14e-a327-7685-14bcee778c96@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0053.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::27) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75efbeb5-ac4d-4a87-b9ad-08da50a378f7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1892:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1892CBB2C4241D68E9B97CD1ECAF9@BN6PR12MB1892.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kg1kuzsD6XKo8IXGJB/tonaxzZPFxtLBmNJsAu4xdlPj3gKBDNHGybmLXD8INjNBO8XCwyM5034UlIqIbYEBuA3QvoG7YJN224O1QbheKfPx1Cb0oSc4wxHzc4mmai0/aF54Gcy9ha8TLJo2yr3ihlQBwbfulYtUdwMr0rz2iwT+D03Ngz2pPrWCnkaqLPEr3N8vT2dxS/TVvmue71xl3JBhkZ3qJGTWAhNxIWZYBfx41VPQLKws8iBevQe3HKNrwlvxu0PDMdXlTNzLUZ1zX6LsOGuFyHUG18+Uda9HLJum8XPlRG20WNiwce4tvnV5tVTrSzf7OyO+p8lEOXKuofmU41Ah2vRO/gONFg5P8vzy8mweUrdf+t8bPECpbKrK6pX0VDqRvH3ZBx9rd70KYBxxIYUlM+tCThAGflmWIiYFfQpwL+P2JPA7sVSU1K4gIpkyRe6WHYjlMv0/GG2DVC1MGMh618GgBdpF7R85VBwjyYxfc4dUiOv2X7ZApKDSsbVsL/vcxLv4GeddrcmfE9EptumqS61RaegRyqhnoJlg2hpsHBO4JV6h8ytqzW1V9h85bK5fXFYbBFVqAuw3D3AP/Dm89i8mjLMUdTpCKY5KGV3azuClaH4K9oMlIny5l8V48O2ow2H3pYwqjteFz8lyFWruaW0wlgjEEBfrCD6lTzFDkVL0m2UqgMrPg98Yx5QHi8U9gAJQjQjcf0A0JIWwJW1ud073Fd/d0uOTeTFsAmuQDC/w3KbnrMOXxf9T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(7406005)(86362001)(36756003)(31686004)(31696002)(8676002)(7416002)(6486002)(66946007)(66476007)(66556008)(4326008)(8936002)(5660300002)(110136005)(2906002)(316002)(54906003)(26005)(498600001)(6506007)(53546011)(186003)(2616005)(83380400001)(38100700002)(6512007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STVSbkFTRTJZNytmYzBEK29BQVdUZERQUnN4d2phVG1OYlI1SWd5L1ZrWVcy?=
 =?utf-8?B?YVFiMkNWYUdGZ1hkb2xmaHJVTkhlK3E4NGZuOWoxODIwQlcvUjZta0Z5OGNr?=
 =?utf-8?B?M3VXSkk4R1B1TklJTExWV1Q2TU53M01PUC82ckovQU44ZXExakxjd1VSUnJR?=
 =?utf-8?B?bWI4MTRyQ3cveUo5dWpHNG41QjJnNys2enhHQWhrMTMzbGptRW9RK1RyNGdM?=
 =?utf-8?B?VlFiT2c0M2VsNVhUZkQvUnNOd3ZVb1ZTYUt3SFRibUl3OS9XTlRQcmcrZ21y?=
 =?utf-8?B?aTF4azJ5bnRwdEJZQXNwRXdLM1pOckdhUnc2UHA4Znlxdi81cjVZTGtEK0Jm?=
 =?utf-8?B?bXM0WWg5Y2VlSFJIbzlFNXlES0dBMHJQQ0I2bXE5UVB0NkVZMVJyOEtraXFS?=
 =?utf-8?B?UitLcTZVNVJXdnpQS043QlVLRHgwVDh2Zkd1M29jaXY0NGJwV2FJc2RXdHNu?=
 =?utf-8?B?aUhDaGkvaGhLZEVQVGNsbjh4NzAyV2RsV09Pdk40NGg1TXpWRDVQNW9xOUhB?=
 =?utf-8?B?bUpveHJxY1IzaUNYWXBWa0JjTy80bHp6VmIyWmtGS1dGMzRLSUsxMlVCU1Np?=
 =?utf-8?B?TTFlSHFEaXZzc04zKy92OHBIcGxveWRwSEY4WmgyNHhpZnJDOCtsdy8rOEZQ?=
 =?utf-8?B?ZFhZZm84UmoxQ1hGZlJkQ1NrRnNvU0xoanV0WS9zSHBZMEJDWERIWGNGblBO?=
 =?utf-8?B?a1hnc1I3SVpWbldCcm1iWTFYSW5lODdFZXkxWGxmQ05hRTE4WWE4VENqaGs4?=
 =?utf-8?B?aGNLQ281Q01TZjh4N3lnSmEybUdKYTIwMVhzLzQ5TEJtMUd5Y1R3c3d2WSs1?=
 =?utf-8?B?enZqc1ZaQnFTbUdzSzV4NGFZVlhsZEQvMkVONk1wcGN1QmFpTytkQjV4SlJa?=
 =?utf-8?B?VGJQK1VSNmFsdkJxNDFyaTk1T1FPQ1VESzNCaTIwYjdLN1U5eUp4M050RFBi?=
 =?utf-8?B?NTY0ZmVobFB3KzNiZmJ2MW1WSFE2VHN3aXBjeGNONHNFUmZtYVRmbENBeGJO?=
 =?utf-8?B?cU9sdzk5dDBIZFc0WGVyTXJodi9jK2RtUmtaWmp3cTRTU0g4L1A5R2hudlV1?=
 =?utf-8?B?Vk1EbUhPTGVsK2FKMlRoZTkvb2tkYVdlU2lRTXhPOG5IVzlqcXMvUTNOMWtz?=
 =?utf-8?B?b3N4dWNyenMvS29GeWVzQXdYTXNhVWJmcUUzTkU3VkJWTGdON2U4ZHJacW5D?=
 =?utf-8?B?bngwK0VoQXVLYmhURDJ6YnZCdlp6VkFHYXllellhSGFlM0EyTllWQXp0c3Mz?=
 =?utf-8?B?K3lJbXpRY3crcWhOaEhsbVZUdjduU2pKd2lYaDAwekYxNnpuam9DRXRjWisv?=
 =?utf-8?B?Y0pLZ2M1Z0w1UlpwUWs3NTZTaU1aOHpWeWNscFFOdW9oN2ZscHczQnM2QzR4?=
 =?utf-8?B?bHpNckg4aG5iNnJ0UnVqaVVzOGs1bHpLUDg2L0pEYnBsN2ZYUXg4ZlM0MHBB?=
 =?utf-8?B?c1QwVENrVVVkcmpoRlVvZHRldWlORTBSL0NnRWRxOFozL3pPYkNVMklhZWdk?=
 =?utf-8?B?TmFkYVYwVVNsNWVzdFZWaXYyVWh4UlNSaXpLUzFNN3NlbEZrUHkxaVpNTEVs?=
 =?utf-8?B?OElkM2w0OFRGOFJZK0JQZktsT3IwNTZKbVhKaUVqNkk5RE1ocmdZSzRJUjdK?=
 =?utf-8?B?ckl6NnhCSkR3bG4zbWtzcW9vR3psM2JnMVNPKysxcEZHM2ZZenFyRHVFdUp1?=
 =?utf-8?B?YjV0Q2F5WEFzZlAyZitUZU9BRE9KQ3RHNkZHRGtkZ1ZoN2g3UTRsdFRWN2Rm?=
 =?utf-8?B?bmJXWkJPZENFcDl0VXNTSGhPbm5XNHhiU0VyR2RHQmsyeEM5aGRCOTNjYjBh?=
 =?utf-8?B?c0pKWDZVbzhHN2NZSUpndmpDdGdrb25jUFBpYlVES2wxRzVyemV4V1lSU2VP?=
 =?utf-8?B?U0JDVzdIQWF2MitBb1pIYThNNnFFSkE4NklkWkRHQVZhTXdVUE56OWUyZHIr?=
 =?utf-8?B?Q1J6a0Fta2pXOWdOYWc1Y0FpTkNmb3FKZGxLTXdIWHF4a1RiQ1pTTHFZZmp1?=
 =?utf-8?B?TDR5dDIvMld5RkRhSWNiTitGeVl0YVM3OHNxMmFkcGJkL1FUcEJmS3hMcVNT?=
 =?utf-8?B?OFdwNWt3RDJUaDBBTmsxcDFiMlFpQUJVR3dmTDhscGo5QUs4MWYvQ0s3RUNn?=
 =?utf-8?B?RFBPVTlCc3Q3elNVVS85NzFyZmJyWklZRm9yVkt2Rng4bVcxL2xBbmx5KzBJ?=
 =?utf-8?B?dkYyTFdkSlFXMG1CZzhXYkVMZm1PK0tUZGNCTFNzYmgycGtRQXorM0NKWEdh?=
 =?utf-8?B?aExtNG8zcDdTVzlDY0VlUzNkN1h6ZVA0cFNZcDZOYzZBKzk3L05QUDdLaGda?=
 =?utf-8?B?ZzRaQlR6NHd2WS85SW1PbEFIaWRpK0xvbGIrTjVxMlVSS2N6RGpVUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75efbeb5-ac4d-4a87-b9ad-08da50a378f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 20:53:46.7613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gE9HrcRG3VmTEieu/02vNAUpWx0n3LSLwUmNONBBu5Fn6Tku6l8TVdRagc4X2a9lC3h5suASnqr3WD7vMM15IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1892
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/17/22 14:28, Tom Lendacky wrote:
> On 6/14/22 07:02, Kirill A. Shutemov wrote:
>> UEFI Specification version 2.9 introduces the concept of memory
>> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
>> SEV-SNP, require memory to be accepted before it can be used by the
>> guest. Accepting happens via a protocol specific to the Virtual Machine
>> platform.
>>
>> There are several ways kernel can deal with unaccepted memory:
>>
>>   1. Accept all the memory during the boot. It is easy to implement and
>>      it doesn't have runtime cost once the system is booted. The downside
>>      is very long boot time.
>>
>>      Accept can be parallelized to multiple CPUs to keep it manageable
>>      (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
>>      memory bandwidth and does not scale beyond the point.
>>
>>   2. Accept a block of memory on the first use. It requires more
>>      infrastructure and changes in page allocator to make it work, but
>>      it provides good boot time.
>>
>>      On-demand memory accept means latency spikes every time kernel steps
>>      onto a new memory block. The spikes will go away once workload data
>>      set size gets stabilized or all memory gets accepted.
>>
>>   3. Accept all memory in background. Introduce a thread (or multiple)
>>      that gets memory accepted proactively. It will minimize time the
>>      system experience latency spikes on memory allocation while keeping
>>      low boot time.
>>
>>      This approach cannot function on its own. It is an extension of #2:
>>      background memory acceptance requires functional scheduler, but the
>>      page allocator may need to tap into unaccepted memory before that.
>>
>>      The downside of the approach is that these threads also steal CPU
>>      cycles and memory bandwidth from the user's workload and may hurt
>>      user experience.
>>
>> Implement #2 for now. It is a reasonable default. Some workloads may
>> want to use #1 or #3 and they can be implemented later based on user's
>> demands.
>>
>> Support of unaccepted memory requires a few changes in core-mm code:
>>
>>    - memblock has to accept memory on allocation;
>>
>>    - page allocator has to accept memory on the first allocation of the
>>      page;
>>
>> Memblock change is trivial.
>>
>> The page allocator is modified to accept pages on the first allocation.
>> The new page type (encoded in the _mapcount) -- PageUnaccepted() -- is
>> used to indicate that the page requires acceptance.
>>
>> Architecture has to provide two helpers if it wants to support
>> unaccepted memory:
>>
>>   - accept_memory() makes a range of physical addresses accepted.
>>
>>   - range_contains_unaccepted_memory() checks anything within the range
>>     of physical addresses requires acceptance.
>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>    # memblock
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/page-flags.h | 31 +++++++++++++
>>   mm/internal.h              | 12 +++++
>>   mm/memblock.c              |  9 ++++
>>   mm/page_alloc.c            | 89 +++++++++++++++++++++++++++++++++++++-
>>   4 files changed, 139 insertions(+), 2 deletions(-)
>>
> 
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index e4f03a6e8e56..a1f7f8b304d5 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -1405,6 +1405,15 @@ phys_addr_t __init 
>> memblock_alloc_range_nid(phys_addr_t size,
>>            */
>>           kmemleak_alloc_phys(found, size, 0, 0);
>> +    /*
>> +     * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
>> +     * require memory to be accepted before it can be used by the
>> +     * guest.
>> +     *
>> +     * Accept the memory of the allocated buffer.
>> +     */
>> +    accept_memory(found, found + size);
> 
> The SNP support will kmalloc a descriptor that can be used to supply the 
> range to the hypervisor using the GHCB/VMGEXIT. But kmalloc won't work 
> when called this early, so we are likely to need an early_accept_memory or 
> some kind of flag to know whether this is an early call or not in order to 
> use a static descriptor in the file.

Then again, the accept_memory() call from mm/page_alloc.c can also be 
early... maybe I can check system_state and make a determination as to 
which SNP page state change mechanism to use (GHCB vs MSR protocol). It 
might not be performance optimal, though, as the MSR protocol is one 4K 
page at a time.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>> +
>>       return found;
>>   }
