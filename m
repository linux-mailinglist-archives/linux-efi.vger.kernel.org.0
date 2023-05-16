Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C65C7057F8
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 21:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjEPTwu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 15:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEPTwt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 15:52:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2296FC1;
        Tue, 16 May 2023 12:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKY/oQmzy23TIY0i0EteDyajYKwNnTRzt2phW/fPsxy7tujlVTsewEyqAnSQC28oV5OBUFGu208bmGb8uPM6LHOlBHQ/APfTNouf2CUKbLYlaYPkj2n4iJfa9MnChyH/y24fkPnunwJHt0dJ1358Ftv9zOTv6asv2V2fyZz9eZEqSzus6RM2T5e5SpmOsl3wr83WvCvMnsJGjJQXhf+n6C6+augf2CHwyqfm7dfAY8XLUrchL/6V0OjulQN4J6945WQoTt0VPAn6bejIXsHjOQXyQXkShZEOTXLgK1vc6edtFT1f/f6c20WUJi2ryuJCLywXj0uTrEmyA+/IFbnYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JgeRyZQOMilJyl4L7hQF5MJ6hskuO3MwuHwx/zdKO4=;
 b=hXAfK6GAilHoytW6/b0M6NIh38VW+DmR/Iuo//2S0fHCU8qfz8Z9iXU4sNz4LRFB6Ub2YnBa4utTKtLuqsEcOgoySve7aMGDPBaV4l7S9g+aJU6MJ0Zag/XDUJ8VK0TYRGaCjHNndRuyD1zxW6He/U15IxUCC4jcVxS3cjQrNPr2YC/J0YfLYgf5TJ8Qmrvt+5rIjyn6ipLJgTiZHHR86uHQXOri6DWHEIUpJfb3WAOvZkG1JDA8I4RCP0WC6ZYV3/p5OvpQkD7NkdEMrFJp2d6+4nkVYsfUOLpLswHHi0y1qL6R7NTiGtLjfRBQptln/dMQpvH/U84uj72q0gq8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JgeRyZQOMilJyl4L7hQF5MJ6hskuO3MwuHwx/zdKO4=;
 b=mzsW4jNALl3ajqpne32cG+26G3l066KWUv9V+53huGTYUwKrJRYx5+UO/a+H38JnwTt367mlpMQ2fVSBR4c0XsuhcBTGFZAbZEffwTf/apoposzVNfIptjNNcpA8L0SXrWnoxWYboLLLyAlxuu51pFMJlLHEKYM65jZbNMFDCvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 19:52:46 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 19:52:45 +0000
Message-ID: <bd3f2162-6a6e-3334-4448-4075b90edd51@amd.com>
Date:   Tue, 16 May 2023 14:52:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv11 2/9] efi/x86: Get full memory map in allocate_e820()
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
        Borislav Petkov <bp@suse.de>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-3-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230513220418.19357-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0087.namprd06.prod.outlook.com
 (2603:10b6:5:336::20) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4c45b1-59b5-42dd-8f9a-08db56471e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXAxI6pCMNu01Ch/NcNUsmtAg1gtvwSxv9sHf0wHfRmhogy18j1fZHhdp732gaB64vZY76if6M4XTJXGS61D/sdNBvSobqE0qmvGQ+1yxWiQEBsiS1Vw4jEOyJfSYzBVolPhvRSmtHvNq4+jVDIZ1rAlvrBSJJUc0e7FYe/FXtocBcs80gAzgr533NX8g706NDB+3evUn/q8/Bmh0e0xTLQv+0DYioO8YWUV00PmP+o9S9yfoL0BrXENgC7zf6/DAAJU1Q6ZJao8PXysG1njAiZmw69L7UKq/OnniyYitiXToGsmAzETgSzVw3i+5Jlpv7m/rnSiRPKNI4Qz9u73k7542IrkZGSvCDCjgFJw7p79W1L1V5XM3s4kliSN/G91qFWMXZSAmn61+vP/lAm/Vzmj/Co3C0yyanVG1PAETqbJeCRUKyy+wAEpJS52dpQL1Xe+UHVpaOa3LG2P9xJC7274KFkvcd6HYGk56ibl3otqX1g8PzoJ1CCToXW7YRip2SfxtC+K7olAzidM61Ym1n5YahetOU3oYMOJSsxe4q3GysMFIYv/NFXk2dWrNY3zG7Qp5Bz3XfXynkcyWYQOSX2PDTg3B63gGrJj4Rg2CTfeJeX/om6+WVYA6Ze7uTCc62WL4ZwNgzdMBOGdBajC0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(31686004)(66476007)(110136005)(66556008)(4326008)(66946007)(478600001)(54906003)(6512007)(6506007)(53546011)(38100700002)(186003)(83380400001)(2616005)(36756003)(41300700001)(8936002)(2906002)(31696002)(8676002)(7416002)(6486002)(316002)(86362001)(5660300002)(26005)(7406005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0s1V3IvMlorS0lBdXdvNWZXNEp6d2ROT1Yrdm16WTJGT0YzbXpycy8xc2lO?=
 =?utf-8?B?NVZ0UnNxdy9kaitKMEFRTFJyZW5Va0ZvQWtvTnFuWXdRWDVGYnUxVFBuMkg3?=
 =?utf-8?B?d293dHpzKzVoQUdFVjN6bkk1emh5dnNmUWE1QVhoZ0Q3MTdmeXplaXZDZGlK?=
 =?utf-8?B?WHdOUlRNMVZYVzlKS0xFMDJkaldGS3Z1bkI5Sm80M3diVEJqUmx6c1E5K2hy?=
 =?utf-8?B?L3pMcUJjV1BwN0JhSVg0VmJDN2RKaWZQUUpYWWluU3JxcUdCcXBsSXp5SU1I?=
 =?utf-8?B?UUNZSFRFcURZcGRyV0xDYnEyNDFLSmVIWk1xVk55N3hVanhLVE54RVdFb2tv?=
 =?utf-8?B?c29ZTlNFK0JHblFUYkh2ME8rZUdMekFhcUQxRzRLaFUxMWlPblpFZlEvMmt1?=
 =?utf-8?B?aDlURy9vc1lxRXNEUHMzMUVVdHdybHNxeHYvR1RZeDNIdTNPTC9wbGJmRVk4?=
 =?utf-8?B?Wi9za0tHLzlPSGNNenVyUURPMzRyMlpZdXEra2J6cUg3TEZ1N3RtVGlNVG9D?=
 =?utf-8?B?T2RqT3NJdDRQSHJRNDdRMjZCazJtcFN4TjVQTzRKN2g3dGI3MGZMOUpvZEk4?=
 =?utf-8?B?eVorbDQzUEw1S2IrdHVIWTczMmJBdU9WMmlZemgvZlhqL3RnUUFZRnMyWXBP?=
 =?utf-8?B?NmZjVFBUWDJ3cE5vRXJWVEFWcmxTMGtmdTRjdEI0KzYvR3FYWlk2NzRKN0VH?=
 =?utf-8?B?SkVBTzZqaFJ3UW1URU1BWFY5VGZKY0RaSjR5YVhUT3JRb00vUmx2K2N4Nm96?=
 =?utf-8?B?T0N0aFcvMG9Jei8rNThUQXVQK0ZVbnp4Y2VhMExYb0dFbzNSM1I4L0EreVBE?=
 =?utf-8?B?U3hFeFpkeVR0M0tCLzNBcHFWNm1WOExERU5hK3RqdUw2cDRNSVZ6NGh0K3dQ?=
 =?utf-8?B?cTkwWlhxY1FkM0pnV0twWjdkNDlnSEVIemM3UDA0MTkzYUlNeVFBa3BmekdS?=
 =?utf-8?B?aTNWL2RNWUJCYUZlTGY1MVFiYWxXcmpuT05rZitQdy9MbU91dEp6YUN1S1o2?=
 =?utf-8?B?VVpxSDZHSVZ1anRZSnpsQ2FCOURFV0VueDlxaGlKUXpTS2ZNL1owY0Z0V1Bq?=
 =?utf-8?B?bkpTUnpkNGc1MkpBTGVCNEZHeUVicWNGKzEvM0hBNTZwUU5zVWF0NThFV0xN?=
 =?utf-8?B?NjNkalR4WFoxanFuSXRLV1Vwa1JTUVYwUWk1ZUpRVFhvWEZ4SXBSbXVhU1g1?=
 =?utf-8?B?ZHlvZ2pLN3JaeFZmMVF0UU9jVlFCN2MrNWVuTnZ1VXlKWlRzS0pQU2J2OHVn?=
 =?utf-8?B?VEZld0hQTUF6TUhUWTJ6cVM5UlVhSE9YYVBIYVl1NEQyZkREODVBckVFOXJG?=
 =?utf-8?B?MHJvRk9DdnpXRHVWN1pYLzc2UnZnQVl4QTJDY1FVZEpQVTlwZmtUVnlXaTc0?=
 =?utf-8?B?c3c2RVk5aDFHTXVvQk5NOGZUQXdmL1pCWWNRdHlMeHh5WkY3dDgvZXR3Y0t6?=
 =?utf-8?B?THhYQzh3Y01SNWlwMUkwMlFyK3ZwMi9MV1NtRGw4bU5ueUFKekFiTzNkZUkv?=
 =?utf-8?B?aFJKVms2Zk5mTkZScGltek16QldYaHg1eTdIbEtaWmlsd0VYT3YvMSs4RUs1?=
 =?utf-8?B?UU9BMnlMeHlWVUtrNHRQaHNPdE9FR295bU1Pb3dRTjIweEZtZHNlYkJMdHdw?=
 =?utf-8?B?NFh2c0ZheDcwQ3ZHa3F3eGNuSTFyTm5FTXhxQ0phemRoenBvWkNyZXk2cmxs?=
 =?utf-8?B?YVRGYWdhVXZvbWJBWFFOUnltOU9CemlCZy91cTJRa3pNTGtXVUNSSjZ2Z0M4?=
 =?utf-8?B?Q2Ryd1IyTC9jSW9JdUlwYXBYUytMQlNCTFhFelZkR0VNNGFhMnFSZ3FsVnhk?=
 =?utf-8?B?VXY0WVQ4UlRUV3FuWW9yR25EbzhpTElucmloY3BaZEhkVUR3bDZYemhnTHE0?=
 =?utf-8?B?d1hCQWh5UGFCMkRMSmwvVXRtNTUzd3lEVnpoU0s3eEhyUlRaMUF0cStYV0Qz?=
 =?utf-8?B?ZTRUV25VdU9mSG00ZjVQTFdqeTVWbnlTQlJlc1A3WldVR0tZQXFZN3BvbXhL?=
 =?utf-8?B?cnB2Z2JKMmhNTlF5aUcrbEZiS3ovY3ZVUnBRbU9aQ3NDVmdzZ0l5QThodjcr?=
 =?utf-8?B?Um91bklIbzhXalRUZys2R2lnSk5od3ZTM3BKUDNIN2kvdkJGSVY1bkg3cmZx?=
 =?utf-8?Q?dQRSg+p+KpfLPPt2N62KbZq9W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4c45b1-59b5-42dd-8f9a-08db56471e69
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 19:52:45.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70yB6Os66WZhNelAYH/AN5T4G7enp5vs+AIYbPy0DOfMcpjqcp1ur3AFcHfXk3thTWYAkbDhuQhjjaLjRIXiwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
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
> Currently allocate_e820() is only interested in the size of map and size
> of memory descriptor to determine how many e820 entries the kernel
> needs.
> 
> UEFI Specification version 2.9 introduces a new memory type --
> unaccepted memory. To track unaccepted memory kernel needs to allocate
> a bitmap. The size of the bitmap is dependent on the maximum physical
> address present in the system. A full memory map is required to find
> the maximum address.
> 
> Modify allocate_e820() to get a full memory map.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Borislav Petkov <bp@suse.de>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/firmware/efi/libstub/x86-stub.c | 26 +++++++++++--------------
>   1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index a0bfd31358ba..fff81843169c 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -681,28 +681,24 @@ static efi_status_t allocate_e820(struct boot_params *params,
>   				  struct setup_data **e820ext,
>   				  u32 *e820ext_size)
>   {
> -	unsigned long map_size, desc_size, map_key;
> +	struct efi_boot_memmap *map;
>   	efi_status_t status;
> -	__u32 nr_desc, desc_version;
> +	__u32 nr_desc;
>   
> -	/* Only need the size of the mem map and size of each mem descriptor */
> -	map_size = 0;
> -	status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
> -			     &desc_size, &desc_version);
> -	if (status != EFI_BUFFER_TOO_SMALL)
> -		return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
> +	status = efi_get_memory_map(&map, false);
> +	if (status != EFI_SUCCESS)
> +		return status;
>   
> -	nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
> -
> -	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
> -		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
> +	nr_desc = map->map_size / map->desc_size;
> +	if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
> +		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) +
> +			EFI_MMAP_NR_SLACK_SLOTS;
>   
>   		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
> -		if (status != EFI_SUCCESS)
> -			return status;
>   	}
>   
> -	return EFI_SUCCESS;
> +	efi_bs_call(free_pool, map);
> +	return status;
>   }
>   
>   struct exit_boot_struct {
