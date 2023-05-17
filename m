Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35F3706D5D
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 17:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjEQPxj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 May 2023 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjEQPxi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 May 2023 11:53:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1816596;
        Wed, 17 May 2023 08:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOsjVm/qRvb9EDo3OzvbpV8RfKFZoh1mFXS45E9/VWHvVwd49zSpJNFjJQymjOkOasNRs2QKNoTWQPxjQ8gVukLUpBBMErj0/wJmA51IEMrTRvhJ8qVbIEq50DUml2OLRFrMJxmLSjiDrQJH/T9fwM2H0YLe3YgC6TZBhoZKWiCdYS1ZJCnhxma71c5ZJhNRn+rz2QhnoDXnDr6/Wi5bsCgLS/bRqjXDc/juFSVzK3gD9OsairFWT250wtfSfg8XUnGzgQ572tGWfb8bSNyEPxpiRi2lHRllfXz0bPY0AAgoWHxp5tfUpvBAeycZXQgmIch8i4ZtrI/1RtmkdDK96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2cIJDctDdw7tliFossXPnrV3DS+U4xFF0dt4Nd6ss4=;
 b=CiEE0y2ylP0qbbx9gjcv6VgfT4F7AcXCgARSR+la6eRWExeheTAeksARyLJYuSf/Tsda2WOccjKXXi/I+4Hxo3vPiFs9soJXsT0nWkmZoGW2lORSkdiV89TEYMvLwZzOTuMHCTGw7FUryPBcP0yy37DExbDB6suMNTExFgEzpDayoOPB6ysHy6PSF+ONAeHO/sLT5Hfbt6Cha7/vouRrCCVRh5WPyYBQvWzYqUi74TSjWgWUBKlFRE3IKq8DmEIzapRxxHp3ubCnKu54zWhiicAG5f41VGV58mvvA4471rjmOwEO+mpwgFt0Yw7+Crw14DmX4GX5Lc5AfxUf6q2Huw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2cIJDctDdw7tliFossXPnrV3DS+U4xFF0dt4Nd6ss4=;
 b=zGu8o2OKy1PQaxwIHZxmsj6i1MMVc4nnVU/dJX2PYKX1HIl4KXoKY/R+Mq2jXxGWyOSOkYD8c993WmZItan6lTe7fnlRNTE8dpb5t1o3rUOA/jIwliQAyaZqD7RxrXNQp4KUrDBJR6jAjQeIeIBJuJW9Rg8+ZnVdSG//CJumulM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 15:52:38 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 15:52:37 +0000
Message-ID: <ae0bee7f-0fa1-caec-a4c9-10170b1b38af@amd.com>
Date:   Wed, 17 May 2023 10:52:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv11 4/9] x86/boot/compressed: Handle unaccepted memory
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
 <20230513220418.19357-5-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230513220418.19357-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:806:126::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: ce73d274-e496-4cf5-4dde-08db56eebce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRqJKTeAiB3wtF73aNKwC76W6UAKoHZxz4UpbSOnFw5QbW2Nvh8VnPSHo+tKi4hSOJc+ZQtRVeGlnCBhRJ/MosD93bJyu3B3H8fLMc/cYHONNDFOld/Z6SmAZkPmi+lNfuZTztwxNKHFdJoH3emt+b5EJbVqukqdIQ82LqN3lu8cEYtV3YaDz/asTnapuFFhYXbPQotkMAsH9R07QlMhAQw3u/R5l64CR9AkWnQyUA+lluq9BZm9BI4eu27hZp+jpGkDtkf4CtMGfkKJGZCvUTwYAdCPto3CRDhx4YZHYBUwBue3LcR6mASNLKsqWfrzxwNRQb3llXHh1g8jfY+Jz2cAsge+FIpmYzP2K3KMITpZvS09hOtXqBdJZ/j3SGnjIb5RdpLY21AUpy0l9Ljf4spBQK6IAoC+pPDyeX0sCRxX4tH7192N38LD75ZAydWYWQuiZ8We9pgotp5NLTYIUaQiuslXeS1LAdTYJz2PmxMDF3lRiNJ3Gc8/8BKN4eRoEUaFQGSGREedegBj+EuOZs1NdEc8JikJC+lkegM18N8oYfvprXHNCTPiXIrfDf2mrcXkEypGiP9CsWWxwRj47w5MzPV8NTv4Jk63JbUPB9YQmZi6mBX80VBiwAaP6rJK+Z1jxPNiBeO55qfUFP/EyA5d7PL30CuRPEEAigEnoXcDfcZIh7fY6wqaPjVsFwoaLoCpgTK97AztNxXBq3JlHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(31686004)(4326008)(66556008)(66946007)(478600001)(66476007)(316002)(110136005)(54906003)(36756003)(31696002)(6486002)(86362001)(26005)(83380400001)(6506007)(6512007)(2616005)(186003)(53546011)(7406005)(2906002)(8936002)(6666004)(8676002)(41300700001)(5660300002)(38100700002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWZhS2ZwMkVBdVl3OUVWajBUbVR0T0VqcHpIMlRWbEVyRHcwdnl3SmxXKzM1?=
 =?utf-8?B?ODNMT0trMEE1c2lWclRtYjFYdnM5ekpYSDZYMGJDWnFwejJKKzYyTkIwb25a?=
 =?utf-8?B?cklTUVdXT2dDMzdiNzR0VkhFVTRVVGltUTR4UGt4SGxaVFhVNFVHY3lDS1ZY?=
 =?utf-8?B?bU1SNmUybUxWdzVMVG8wSFRUbFZSUHMrN0U0MXdjRWJqNk5jdUxmSmtSQ2ls?=
 =?utf-8?B?RzhhblFpdUthN0Y0TC9vVTBvRW5DYUdRZGY4MndlMm1lcXZtemcwZGpHNmhP?=
 =?utf-8?B?RFRENksxeVNqM241MGtEMXlqN21uYVRDV1F3eTJkY3RoMldGa2x1WG0yMi9G?=
 =?utf-8?B?ZlAwRTIzUHBaSW90Q2JRaHhrbDNjMDFKdDlGa1BSUzdmL1Q5SXgwTHdiYTgy?=
 =?utf-8?B?RmRtU29McngxR09HdHhHVHladDNQV0NsMVc0VGxoaXdXSldIc2w1MmpDVlpN?=
 =?utf-8?B?cVk2U0tRKzdSdk9TVUF1VG5MQXliM0VjenQ5TWExRmMzcEcyK0FEdjhaSWV2?=
 =?utf-8?B?M0tlMnpMTFMzOGdzSjQyOHU1THljemZCUGl0UnI4Uzc5VTk3M3M4T0ZsdEVi?=
 =?utf-8?B?eUhjekhGbTR3eW43dzlhS0pVV3hYR3AzRGQrRmkvR1k3a2hTcm5SM1V5UkVl?=
 =?utf-8?B?R3FpblF1b2ZJMS94SnZEZ3lOTmF5cVFEd2J4WWZSZnRqMXZjWG93OElJbnVk?=
 =?utf-8?B?YUFta2FxTzh5ZGpRQ2RPSHdMNDZXamY4cjdjdHRXOXd1ZWtJMU1YUjI3S253?=
 =?utf-8?B?M0txc29sMlRzOERoWWVtMVdHVnpkb05ndjlBVWdENkRaVVNubTVna1hHbExN?=
 =?utf-8?B?L29qQ0U1aTlOTFNycm13Rkp3UG1veEYxZndpOHoveUxKWmV3N0JETVBzQlJE?=
 =?utf-8?B?VXNndHhseXdYTUJSZUpwdzgzTy9FUGxQK0NUMXVaRVJzamh2aHJndWdJTEpr?=
 =?utf-8?B?QWNHVGVaUlpLMnZHRitVblN2Q3FydmtNa2drOEtDM1JMMXVzQVd1V0I5RC9M?=
 =?utf-8?B?bXEwYWRmdkhyNGxzN1drb0dOTmdaWEIxeDhQZXVWaE9uaHVza3RqM1dFNVpC?=
 =?utf-8?B?VDlXWmJKYVFDK3k2dGw5Y0FRSHFMKzdLV1hFNEJxN0R4d2FmQ3Zjbms3dFJs?=
 =?utf-8?B?RUNnUnBleXphdFk5UmtSQkJFcUhRbmlPcmxWa29hV0Y2bVpXSmFKZEJTOHc5?=
 =?utf-8?B?RytSTk1VbnlTcXh5Yit6VnVDbjlXbDVLUjFyTjN6Y3VUdXNaMWhsbFdiWkMw?=
 =?utf-8?B?WVJyZzlpSU0zeE9xRnFCa29FMUJZNGZiRXYrTHUwaXBEc05nUms3K2JwbjdD?=
 =?utf-8?B?Y3Z6a1FHWnZEQXpDMlZBdEJYZVgrZW95aERXVTdUWTZiVnhxZ2ZIUjdWYTdK?=
 =?utf-8?B?S2s1Ti9JWkZ5VFVlZFU1ZGl3eGJYVzFHQ3BzWFp1VVBMdGlBL3BLR3I4N0FL?=
 =?utf-8?B?TVFpdWd1UXBvczU4YjlWUGxQck1DelNqMGZDUHA4ZFZCSUhEbXJrVjFEQnpj?=
 =?utf-8?B?aFpwTVhFSnBva1lqK011UTZhdXdlY0NadHU4bUE5RThJc2V5Q1ZmYU5Eelhy?=
 =?utf-8?B?UFUvbERLbnlvc01PeUpzMnhhZG84UEUrcGlnS2FJMncrMzVRQlBSVUhlYjV1?=
 =?utf-8?B?cnhGVUQyR3dra09wWGdaaEhjQjVza1MydElHOXhOZUc4NEhWOFlDYWZaK2ZU?=
 =?utf-8?B?K3FRMTRCbldYYTNHRG9jQ2krVmY1L2ZmWkRhamxYSmtOdGxFSWk3WEhncyt0?=
 =?utf-8?B?VnFGQlBUdkVIMnhhM1V6U0F1RncvSXpveitqODZvOWQvS0ExRThkMGVBTFQy?=
 =?utf-8?B?VE5RaytaVURBYi9Ma2hsb0tIcDBhMk5Ndmkvc2ZZVkhoY3FTOTBYcVZVNWx2?=
 =?utf-8?B?L1AzeDFBSGticjVnRUd4RWpNU25YY2VsUTFmU25CaTdHWDF2cktvb25LK1pO?=
 =?utf-8?B?S0xsQjhVcHlXeDJkUEZMYUR1T2RWM3gzN3VucFhpMDUyelNwOEdVT1cxMzJ5?=
 =?utf-8?B?eTUzVWJjRnZlZEx4SE1SQ2hLVjU4WmF2ZkRBcEM3TjJveU9TbitkSXlsRm9v?=
 =?utf-8?B?WVFKeHFDTm5CM0FQRUl2Rys2eGQ4MWVKUzVpeVpJTTVUQk80TG9pNzJ5NHFz?=
 =?utf-8?Q?2TTM/PExVO1npFca+wTRPILXA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce73d274-e496-4cf5-4dde-08db56eebce9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:52:37.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5StAnk9LsYBL9LcMsqeAlbSYoZcEHErN+XLKT2EUl5EF2OmbirenVGu0UJzc2e8YAeZQA1SZZ3VUzKT9aLQKNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/13/23 17:04, Kirill A. Shutemov wrote:
> The firmware will pre-accept the memory used to run the stub. But, the
> stub is responsible for accepting the memory into which it decompresses
> the main kernel. Accept memory just before decompression starts.
> 
> The stub is also responsible for choosing a physical address in which to
> place the decompressed kernel image. The KASLR mechanism will randomize
> this physical address. Since the unaccepted memory region is relatively
> small, KASLR would be quite ineffective if it only used the pre-accepted
> area (EFI_CONVENTIONAL_MEMORY). Ensure that KASLR randomizes among the
> entire physical address space by also including EFI_UNACCEPTED_MEMORY.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/boot/compressed/efi.h   |  1 +
>   arch/x86/boot/compressed/kaslr.c | 35 +++++++++++++++++++++-----------
>   arch/x86/boot/compressed/misc.c  |  6 ++++++
>   arch/x86/boot/compressed/misc.h  |  6 ++++++
>   4 files changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
> index 7db2f41b54cd..cf475243b6d5 100644
> --- a/arch/x86/boot/compressed/efi.h
> +++ b/arch/x86/boot/compressed/efi.h
> @@ -32,6 +32,7 @@ typedef	struct {
>   } efi_table_hdr_t;
>   
>   #define EFI_CONVENTIONAL_MEMORY		 7
> +#define EFI_UNACCEPTED_MEMORY		15
>   
>   #define EFI_MEMORY_MORE_RELIABLE \
>   				((u64)0x0000000000010000ULL)	/* higher reliability */
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 454757fbdfe5..749f0fe7e446 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -672,6 +672,28 @@ static bool process_mem_region(struct mem_vector *region,
>   }
>   
>   #ifdef CONFIG_EFI
> +
> +/*
> + * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if supported) are
> + * guaranteed to be free.
> + *
> + * It is more conservative in picking free memory than the EFI spec allows:
> + *
> + * According to the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also free memory
> + * and thus available to place the kernel image into, but in practice there's
> + * firmware where using that memory leads to crashes.
> + */
> +static inline bool memory_type_is_free(efi_memory_desc_t *md)
> +{
> +	if (md->type == EFI_CONVENTIONAL_MEMORY)
> +		return true;
> +
> +	if (md->type == EFI_UNACCEPTED_MEMORY)
> +		return IS_ENABLED(CONFIG_UNACCEPTED_MEMORY);
> +
> +	return false;
> +}
> +
>   /*
>    * Returns true if we processed the EFI memmap, which we prefer over the E820
>    * table if it is available.
> @@ -716,18 +738,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>   	for (i = 0; i < nr_desc; i++) {
>   		md = efi_early_memdesc_ptr(pmap, e->efi_memdesc_size, i);
>   
> -		/*
> -		 * Here we are more conservative in picking free memory than
> -		 * the EFI spec allows:
> -		 *
> -		 * According to the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also
> -		 * free memory and thus available to place the kernel image into,
> -		 * but in practice there's firmware where using that memory leads
> -		 * to crashes.
> -		 *
> -		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
> -		 */
> -		if (md->type != EFI_CONVENTIONAL_MEMORY)
> +		if (!memory_type_is_free(md))
>   			continue;
>   
>   		if (efi_soft_reserve_enabled() &&
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 014ff222bf4b..eb8df0d4ad51 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -455,6 +455,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>   #endif
>   
>   	debug_putstr("\nDecompressing Linux... ");
> +
> +	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
> +		debug_putstr("Accepting memory... ");
> +		accept_memory(__pa(output), __pa(output) + needed_size);
> +	}
> +
>   	__decompress(input_data, input_len, NULL, NULL, output, output_len,
>   			NULL, error);
>   	entry_offset = parse_elf(output);
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 2f155a0e3041..9663d1839f54 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -247,4 +247,10 @@ static inline unsigned long efi_find_vendor_table(struct boot_params *bp,
>   }
>   #endif /* CONFIG_EFI */
>   
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +void accept_memory(phys_addr_t start, phys_addr_t end);
> +#else
> +static inline void accept_memory(phys_addr_t start, phys_addr_t end) {}
> +#endif
> +
>   #endif /* BOOT_COMPRESSED_MISC_H */
