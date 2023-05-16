Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C887057BA
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 21:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjEPToY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 15:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjEPToX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 15:44:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEE9448A;
        Tue, 16 May 2023 12:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSqy5wY6sy0I/KeUtOtZQEys3IET3Ze78epzJbPqjyrRFoQABXbja13OoWaZJ/q0rTECXdATlJfkHvzn//he5acqu7bwpRcuQiqAhlrl3Ldb9ZxF7d2CIIGjRvQpMGETpoCyxmXnXJdyQaHwGxsvvmt981vuKelzgXSpnwa+IMW1rYuOsZb2wlDsC7v2gu0NQSwJ5lhrgmUWBVx3xXZJ2pb+vRTdWJW0kI3Q5mZXvax1I+WRKPeDU1onzWRLEwL72hJ/tj5OSSx9Euu4cbYSCuNw7sLYNGWTUisnDd6+8retbZ4/npx+z8zgWrYT/s1/riaEN6aBD0ZBQsgWW8FK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Txp0xb73gz4c66bbZXfkz6aOePIMQ94FTyT33LUH4M=;
 b=UGTuMV4+wrLGEa5vKnhEiwfnXe6o13B5ZT6F8wq5VBWDQ6bUSo25H+tG4XSS4EfUnpK9PrzVh+u1ICClUn1dGca26dZMJES9TTz0g+G0W+9SJWp2O3LPZwawPF2aGno9uxl1a6HD4X8srV1kuE78wtsZxUTI0N5+BYZzbIZw9ygeidSpwtB+4Tv0uIzi4dk3ZVgouXUI/jDejOOBX/q8LU8Tt/q+zh3Tf2YZt42pumqxl0NHZomJiC651x3cFuSxERt/S43RUwxQMTvj5hP7TOlcko7tFrWe/f8RZfijW8FTeC9VHxDVukDuGDGHlMGR/EsTbE1pEJE5S+J5c6Xbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Txp0xb73gz4c66bbZXfkz6aOePIMQ94FTyT33LUH4M=;
 b=lJU+8QxzxFwr4yvN6gZlIXYXB3+tXfnixAS7Y5nYPwMvDdQaLlpWYAOtSyB7q01Ymg/UZ4ssDDr4rAkUL2mWOuQPOXHP8EDyWq12wydFYdE+UbCFKALxtrQOvw18c14lwslnECDjtubKJx7L8L5HWYCdsofPcDxL8Bl7P52v7Qc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5494.namprd12.prod.outlook.com (2603:10b6:8:24::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Tue, 16 May 2023 19:44:04 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 19:44:04 +0000
Message-ID: <f8fb2b4f-305f-6873-3ef8-e8d5d45e862d@amd.com>
Date:   Tue, 16 May 2023 14:44:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv11 1/9] mm: Add support for unaccepted memory
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
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-2-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230513220418.19357-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0043.namprd12.prod.outlook.com
 (2603:10b6:802:20::14) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM8PR12MB5494:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b6d100-91da-4ac5-9b61-08db5645e741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJ5Son5CCmGQMcFYfsTy7GMj/E/Y5S9+hhIo5B6v6oRqmz3Nu2HIzgexznuz+syqQfPItoJ/yTdg/yUsllVDqpGtRrq5Wdq3zeuf85Oh3Yw96CPpv2vzYpmM9deF53liGPznk2E34jczkbmBSr+VAZQmUk5IbWrHrJkK4O4hyfukdiJ9qw7uFt9+EzPF4mBYGzxw4U68MnjrL8gvZvrXrrapkF2+24wIpLk1Fiw1fTai8pdDayYEW095AfQ6a4lbDBZyOrYXEv0lyj3ib6105OzXXf1XOgiQP17Ct9NFrmXOD8WXjeUHk7yceszbWW3DS6UUH+KMP/nbd7ENmtoA5wjL5HiqfIaoWw76V8aHI1t+E1l/pjnAokRD92sgm351kSHTejBa+Z4zxJIOFgY0TQwRa9di84KX8vw0YHSTQIUCyQVKTG/Chh4ktTntmYRHQMSgYBcskVK64xiziM960eKYQwBxkkXVn27em7G9Cf+EcRs/kaLq3nfeaLJrM2+eHU6P+j2O/qsyhw0M1g89uC154++kCb9nK2KNo5pkb4EtNwG7qzyLLFrA8rPmfTLzg5zULPYa8iwK2Ue8cfbFC0DpY0raIjtRAnOGPEu9Az3e9xZ53QMmoyAzzSp519RNhalRCOm4LSleSKgBdoH0yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(31696002)(36756003)(86362001)(54906003)(110136005)(316002)(66946007)(66476007)(66556008)(4326008)(478600001)(6666004)(8676002)(8936002)(5660300002)(41300700001)(2906002)(7406005)(7416002)(38100700002)(2616005)(6506007)(6512007)(186003)(53546011)(26005)(83380400001)(6486002)(66899021)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M21tU2pGTEZaZTZtV0lVTEJqaE84U3ZSbXVpZThRbFR1WEUvUTUzaHFUUlM1?=
 =?utf-8?B?VFdhbE9ER3NxWFRxdFBzNnlKSU8zdENqRXRFWTBxdXFjWlpuUi9ZclNWVlFu?=
 =?utf-8?B?SThINWZrUWtFemJXakdiUktsNXRnd0RjSE8yYW1GTzJxYXJ3aUJxOU92bmQx?=
 =?utf-8?B?N3Y4TkVqQy9CSzJpb1JKVjUvc1FweU5iV05vYTJwRHJIZmNCS09VR0ZLMWNO?=
 =?utf-8?B?QmR1d1FIdENWMEtsT1krcTVOT3JYaU52SGNYcm1reTVOWUU5RUR0NVBjL1JS?=
 =?utf-8?B?alI1S2Ira3kxKzd0MFdRSVdhTUppZlJNbEVYQ1paOGFjQytSMnJSSGluOE5r?=
 =?utf-8?B?cStNY1Y2d1Y0VzYvOExCYThCUUZvZUNTakZaU3VQTlFnOGpUT0svVUxBRXlC?=
 =?utf-8?B?MnUyMWMyVnFEZHp3YXJ2SEV3L1ptb2VzYXY3NkZwbC9ETmdDRzJLYStPdnRl?=
 =?utf-8?B?Q0pCZGRma2JMUXVTbTVKWUFrTDI5U1VoZ2J5VWtzd3FXdkVTR1FmSGxOZ3lH?=
 =?utf-8?B?SHlQQXNTa09Kejh0TlZodHBRUUlBdXFsK01FR0lKdDhGWk5FYnFsR2VWTE1N?=
 =?utf-8?B?TDZUeXFlV0NWNG1pZnRsbENlMVVLTFU1ZnM5aWliQ3J5ZVF1UmpjTjRQQzVN?=
 =?utf-8?B?dldwRTE5dklWWFBzY3p4Uk1zVTV4Rm5IZ1NuTzB6UEMrYVdhenZiSzJkWHJH?=
 =?utf-8?B?TkRPMWd2ZXEwUUtxNGJRc0VCcG5iNU12K2J0cVU4VmR0TG9OOVpzWW13enVZ?=
 =?utf-8?B?ZjZNQnQ3TElNZEU5WXAxejFTR3ptblFSRmN4bGhjM2FoV1AvMjZIbldsVFNp?=
 =?utf-8?B?TzdsMHcrd2pZSExrRFEzK3U3S1l3ZDRJb1lySkdmNDhOUm8rWDFicWh4d1hU?=
 =?utf-8?B?Tm9ZTUtVMjQzb3NIaENPbFhqMkdWN3VnM09XMGg1aXcvNVA4WWJ6dEEwTlVv?=
 =?utf-8?B?dFJzQTV0OXdkdVByZjZHMnNEK2IwZThNY0kvck42R3N5Uml6Z3dOR0VTY01C?=
 =?utf-8?B?ZkpqNjVpUnFwazlmWFZDNk5ROFM2TXliMWZ1cFR2aEtBOWVVSUlyZCtzV1d0?=
 =?utf-8?B?emtWTkxkRlZINkRXVTlYeWxzNW5zSEhGYmlHeDViY2RCUHQ5Wm1DSmJWOWNW?=
 =?utf-8?B?VFlsNk1YNzQrTGFIb1IvbUs3RGJoWGdBbjU3dHRaSnM1TlkvV2ZvQUpjZVBw?=
 =?utf-8?B?VHZkdjVWVjZPcWVBZGR5Sm5MMzRHYTJJZGZ2TkZ5SDA0S1pyMHVyOG5RMEdW?=
 =?utf-8?B?d3V4dCtnenU5R2p3bmwyTk5jZlBrL2UwSmdXbGpvdEU3N09GbkVoa2pQSVUw?=
 =?utf-8?B?MGx4TG0vT0dmSm1PSXVsWUVzNGFLNUZzdStPVVBhR1M1eVMzZy9uZ3lXbWRa?=
 =?utf-8?B?UVEyTHovOGNRajFMOS9MQitkYU1reW53MERPd1oyeGJtdEhhODJ0c29kaUw5?=
 =?utf-8?B?NS9kUVdOOVkvVkMyUmpYL2NNSmN5VDNFMjlmb29xcktYNExjNXhGcEZJNTVN?=
 =?utf-8?B?ejBzeTkxWGo1MU5VREZkN2tlaHVURlVvTk5hV1NHR2Z1K2ZBN0RCY3dHb01P?=
 =?utf-8?B?VzNYT1hzZzR6c2g1VzBodmwzMUpEYUxkU3JZNHZTRTY3dEd1MTZpdEYrd2ti?=
 =?utf-8?B?WEVFdDhUdCsrWTV3OXRXZ1VsTDliVUxjaEdTZUlRT1hVYkYzREdSRjhiak9R?=
 =?utf-8?B?QUZIcVpaUjQyZEp3R0VsZmRmTGdVdDArNlR3Zk9pbTM1eE84dlhzNFN4Mzky?=
 =?utf-8?B?YVBFMGZDc0RPaEs1UzRYRkhwWlRXU1pWTjBsbE5JWUlSYS9xeThVZDdvVG0x?=
 =?utf-8?B?eUJ2eXF4RlNNVzVjMkRHMEpvbVVQdzVLbmVPNGYyQSthcnpKSmtZNXUxeTFR?=
 =?utf-8?B?VG1reTNxV2hjUnVyaW4wRmtxc1E5cXFBYVUwSlpyVDk1bWs3Z3RldFlUdk9G?=
 =?utf-8?B?cHhZdHppeFk0RlBVT0RGUHJZMUxtTVdKcnh1dVl2ZElxTlVET3Ric1FiakF2?=
 =?utf-8?B?Mjd5UWMyRis3Yld0WEF4YTAwVW9xZjIyRjZ4V3phVVRoRDBJb3o3bk1lN0FJ?=
 =?utf-8?B?cXZFK01yWmwwLzl4K0M5Wm0wbW9aTTEvZlNXRDk0clZlekxZTi9KZ29MNDgz?=
 =?utf-8?Q?guTH77tgQd6w8LOpo865HXv92?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b6d100-91da-4ac5-9b61-08db5645e741
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 19:44:03.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfvOy6NXbi6GJGbdJosBsss950tcCqSpgDmqoyB19GZFuTKMWMNmzLVQ6xJWjID4VxPRK6oCO4T4IZCyhUIE/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5494
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
> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
> SEV-SNP, require memory to be accepted before it can be used by the
> guest. Accepting happens via a protocol specific to the Virtual Machine
> platform.
> 
> There are several ways kernel can deal with unaccepted memory:
> 
>   1. Accept all the memory during the boot. It is easy to implement and
>      it doesn't have runtime cost once the system is booted. The downside
>      is very long boot time.
> 
>      Accept can be parallelized to multiple CPUs to keep it manageable
>      (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
>      memory bandwidth and does not scale beyond the point.
> 
>   2. Accept a block of memory on the first use. It requires more
>      infrastructure and changes in page allocator to make it work, but
>      it provides good boot time.
> 
>      On-demand memory accept means latency spikes every time kernel steps
>      onto a new memory block. The spikes will go away once workload data
>      set size gets stabilized or all memory gets accepted.
> 
>   3. Accept all memory in background. Introduce a thread (or multiple)
>      that gets memory accepted proactively. It will minimize time the
>      system experience latency spikes on memory allocation while keeping
>      low boot time.
> 
>      This approach cannot function on its own. It is an extension of #2:
>      background memory acceptance requires functional scheduler, but the
>      page allocator may need to tap into unaccepted memory before that.
> 
>      The downside of the approach is that these threads also steal CPU
>      cycles and memory bandwidth from the user's workload and may hurt
>      user experience.
> 
> The patch implements #1 and #2 for now. #2 is the default. Some
> workloads may want to use #1 with accept_memory=eager in kernel
> command line. #3 can be implemented later based on user's demands.
> 
> Support of unaccepted memory requires a few changes in core-mm code:
> 
>    - memblock has to accept memory on allocation;
> 
>    - page allocator has to accept memory on the first allocation of the
>      page;
> 
> Memblock change is trivial.
> 
> The page allocator is modified to accept pages. New memory gets accepted
> before putting pages on free lists. It is done lazily: only accept new
> pages when we run out of already accepted memory. The memory gets
> accepted until the high watermark is reached.
> 
> EFI code will provide two helpers if the platform supports unaccepted
> memory:
> 
>   - accept_memory() makes a range of physical addresses accepted.
> 
>   - range_contains_unaccepted_memory() checks anything within the range
>     of physical addresses requires acceptance.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>   drivers/base/node.c    |   7 ++
>   fs/proc/meminfo.c      |   5 ++
>   include/linux/mm.h     |  19 +++++
>   include/linux/mmzone.h |   8 ++
>   mm/internal.h          |   1 +
>   mm/memblock.c          |   9 +++
>   mm/mm_init.c           |   7 ++
>   mm/page_alloc.c        | 173 +++++++++++++++++++++++++++++++++++++++++
>   mm/vmstat.c            |   3 +
>   9 files changed, 232 insertions(+)
> 

> diff --git a/mm/internal.h b/mm/internal.h
> index 68410c6d97ac..b1db7ba5f57d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1099,4 +1099,5 @@ struct vma_prepare {
>   	struct vm_area_struct *remove;
>   	struct vm_area_struct *remove2;
>   };
> +

Looks like an unintentional change.

>   #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 3feafea06ab2..50b921119600 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1436,6 +1436,15 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>   		 */
>   		kmemleak_alloc_phys(found, size, 0);
>   
> +	/*
> +	 * Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
> +	 * require memory to be accepted before it can be used by the
> +	 * guest.
> +	 *
> +	 * Accept the memory of the allocated buffer.
> +	 */
> +	accept_memory(found, found + size);

I'm not an mm or memblock expert, but do we need to worry about freed 
memory from memblock_phys_free() being possibly doubly accepted? A double 
acceptance will trigger a guest termination on SNP.

Thanks,
Tom

> +
>   	return found;
>   }
>   
