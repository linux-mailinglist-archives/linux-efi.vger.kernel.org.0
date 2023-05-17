Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFE1706D75
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 17:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjEQP6Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 May 2023 11:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjEQP6X (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 May 2023 11:58:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026BDE50;
        Wed, 17 May 2023 08:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6WA7IQqoPDQDa43kR1HAVjkuciLChzUxc5R72mzDmSaYDROmSg+N33Vp/dpY6fzy4O0xYNxnsSY7Gib7TjsWoshVr85zum7B3i8q3oVAVR6Xs3cVeeJ1kp2b74SiBq0NEvFmV7AEUpNBxESZ/c219IF3eIA4vyfBgQI3LTwF4e567cky507J7r+XLEpeYWpR4pOyGAWu/dEvnrmEqINWExNAp50N6InO/arlomqdhigYdSfKssXMYgh6U3cq7ewsveFZ5flzbxmoNX6yOBWVaqfpf11EJHUlnO5WvbEH4ENE+qi56gJ6HlHUI1Yy6cYpYwf8Ry3he9uY4KVnklA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKkFW3q01u2x2rVaaqQyEEf9SOp3xoux5SxxkNnfaMA=;
 b=ALHdV2Ufbnqi4FEJ/JI/MmIX49tLM1TuRyjTcwVORzyqJ80tjTkocromUSNwPt44kQkEx/R90pnYVq0mt5I0kLpSfO+jRIOXSIRoK3Kwo3ACoCXLN8VzJm0FrC04UbIL8wuTRMB322zCkCYp7PU6/i9UB3I9wIEaJsbc8/6NlvVWDb+w/Fg5MZkYoYAIlb2uilxbYVmo0mAGnPUUA6e5fuC7HX+CvoyCNheARjP3JXp9sTjKQJLK3Jbau1zWv/gYoI5SLHY/XpVE68rYPmr6WlXsTS9PVjqemJDWRRV8x29JC6E7FIfQZZNZckzrfYIWevfzfrr4lG6JLjNUkPLWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKkFW3q01u2x2rVaaqQyEEf9SOp3xoux5SxxkNnfaMA=;
 b=I5nOXSG2/Jaa4qDz66RDZqpjOs1PIZUcIT9vNFghm4LLzAjUSybyQ1CfIR9yJPuyuh3vdxhUHVdexenL/rrPLERDuo7oC9UsOuJ7ItGD26YyjDQlEwUkkVcqMt13BranPkN8ZpZtKzDm4hOJEHbsd3DbQ+NF+/Nys21YiudgOlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 15:58:17 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 15:58:17 +0000
Message-ID: <f28a6bd0-121b-8d16-5073-e2af1b6b2818@amd.com>
Date:   Wed, 17 May 2023 10:58:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv11.1 5/9] efi: Add unaccepted memory support
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        ardb@kernel.org, bp@alien8.de, dave.hansen@intel.com,
        david@redhat.com, dfaggioli@suse.com, jroedel@suse.de,
        khalid.elmously@canonical.com, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, marcelo.cerri@canonical.com,
        mgorman@techsingularity.net, mingo@redhat.com, pbonzini@redhat.com,
        peterx@redhat.com, peterz@infradead.org, philip.cox@canonical.com,
        rientjes@google.com, rppt@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tim.gardner@canonical.com, vbabka@suse.cz,
        x86@kernel.org
References: <20230513220418.19357-6-kirill.shutemov@linux.intel.com>
 <20230516120646.31195-1-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230516120646.31195-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::25) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 17382d12-2ec5-4a8c-23f2-08db56ef8700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPzLL0+V1QzaDQucEWlNSJauxbf7z2VxOODshLwFWTpkwLbypEdUB2mH7z5otHhcGJP2UphBqael0OeiAbb6lm8C9khXWYRsVKdcx+lXNsVmyt1wF/JZNbAaS6H6cFhgndk8HWAgPcB9wGyPpA2kKtmXaWzoejdA5/z/ZaHL44UL6wDzC83xwQeTW8T2WrfUIMmBiE5y9kvvidBzWkBV7Sx5jEKElDcjuSpyBGsaGGsapOM7qFBx6HYLBg6huGBVgBto6b7Pg+hMsBchxxCRBtqJ56gHhRNevi93pk7wioHwo0i2n/oGx6FtX2SyyCqLRZgzQ5KTWPdHo4SgtEwwTOQWRq8UsOcoulhQBic6iLWOwJiSDEv/f+bm36S1gdXaukWqUyeCNAd/aaIlx02VJeupFccsChsYNSdje6MxHENY6ljvVH5pqK84dAAUWeNLZq2ZMuFRRWrsSO8r81VcXFQixUgA7GaQ0H352RcTwxyspFb101hKhOTEI35D1OwtGqJfiXkczsDW9joeyPAIwzstzf3QBDOdE4lDNS/0s+bCzsUVlolMsgyLVp8jNsi23zp528XK61yORvuaIOUu1i+9637uD/3DBTeLpgox5Bo0lnYDav498ZIAB+77BvVDTPdjHT49/eXFJ3ZWEdvKVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(38100700002)(5660300002)(31696002)(86362001)(36756003)(7406005)(7416002)(26005)(53546011)(6512007)(6506007)(2616005)(186003)(2906002)(8936002)(478600001)(41300700001)(8676002)(6486002)(6666004)(66556008)(66476007)(66946007)(6916009)(316002)(31686004)(83380400001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akpHYVN3WXp6VGxNQitjRUV0c01LU01xWmNvL2d5ZndCV295aVBhcWdUTklR?=
 =?utf-8?B?QWxSQXgwcEI4YjNxOTNKN0ZiQllVWlVZNTdYaThzdCtmVHc4VU9CZm53Q2FH?=
 =?utf-8?B?a09acjBQVFA5aXJXY1ZTSlk3RndPeVNmNjRyWGQyRUc2alJ4OEJjN0pkTmVr?=
 =?utf-8?B?QVBoRUkrN3RTalJTY3pWbUZsTTlpMXJhZzZiZmFXWWZXQlRPN1dlSkREY0U3?=
 =?utf-8?B?SWY0emh2OXJyUHRuRlFyZUtpZFVvQlNlVDA5bUdnZWFBa1VVaCtKMVBUNDVu?=
 =?utf-8?B?dXJBcXg1UkRUZ05VaXh0NHVaT2s4MlVYMktzQThYMmE1K3h4SGV5VWJUVnl3?=
 =?utf-8?B?eVU3RFlwZmlWanFWU1RDc0d1MFZvTkJkdlNIV25kc3AxdTZPd3dBNVB6SnFs?=
 =?utf-8?B?OWdWalZMZU5Ick0yR0wxQnJKVFZQd1FzTWQzbnRPQ2hYd3R0bVhva0k1QnpI?=
 =?utf-8?B?dHNrQk96aHVEdlNZd3ZzOTk0T2dCbkV5U1YyOTJrc3A2dXhVSm5pTTM4NTR6?=
 =?utf-8?B?UHZaNVhmL29CbHpnTkJON0daNnp0dkpUT2ozT1hKRW93bzkxUGRZdXluU1VC?=
 =?utf-8?B?L2NiRkp2ZXlESGhLQnd4UDIzUDZiK2JGQXE4dGJGd3BaTWoyTjFCWVhHMEpW?=
 =?utf-8?B?RmJTWGYyREdZaGZSSkRMbW5PZVh6VjFCdGNQWVZ4Z052RGhDcDFmOHo4elV5?=
 =?utf-8?B?dTVnbFJreExISFFDbE5Zb0lwZXJ3NE9hRE53a3hyOVMvazZoYWdyL0Fhb2E1?=
 =?utf-8?B?d2tiaUlua2haZ0FDTU1oSGNIaytEQzY5UzV6dEVZcjUxQVlGWDc4K2pnczNH?=
 =?utf-8?B?THFiMWxnMTltdVMzWlVuQkh4YW82STQ5eFNTVzhkeUltbnQwK2lMQUpXR3Ra?=
 =?utf-8?B?K2F5RmpNSkJscGowa1dLTjZqcUVIZnRZUThQNk1zZ3orbnJ3L0ZMN3p2R0FO?=
 =?utf-8?B?clZoY3BOS3RMZlRuVDJ2eTBRNG5RYnZJdmJTMEpTYlZGLzV2aFNDQ055eXdp?=
 =?utf-8?B?b29oTjUza0tYU2ExU1hIMVcydGZWeDJpbG90eTBuYzQzSHBVYmJIZnF4WWF1?=
 =?utf-8?B?WVNLQ2Y5OVpCSTgycE0wY1RFYjRqelZ0OGFtMjQyWG5JYVM0a1Z4bzhtbDhY?=
 =?utf-8?B?ekZpdUwxTFRDQnE5SCtMdldQMytRSHlKdUVjc0dhRm9LZ3VCV28zeng1M0RU?=
 =?utf-8?B?UUo0NjNLZnh0dEtHNjlDSXMxUXA3dEU0MmcvTnNBQW0yNEg5eW5ySE5DaElX?=
 =?utf-8?B?QTA1SnZmemNrcDBDdWJLY05TZ1J6ZXpxTGtNVHB3WXc1R1hpbjhrMVRZdGxm?=
 =?utf-8?B?aGNIc3AwbXQwSmRRTU1CK1VDYllTKzl1RkVqMVBOZTlFeGFheG8xTDhUNTVK?=
 =?utf-8?B?Z245WGNGRFptRWU1NUIwVytsZkszUk1tQytybXhuT2MzTmdGZktBYUYxQUV2?=
 =?utf-8?B?TjEzSGZYL2JBMHl6UU1qZDBMZzl5ak5pa25xcmdmeEQwV1ZvbDNGRGdCRUJM?=
 =?utf-8?B?cDBqU3NjWC9ydll5Y0w1Z0hRMnc2UkNKRE1rRzV1MWRpbm51a3loVHRLOEZM?=
 =?utf-8?B?STUvQkJsWURCbElzQTdnRWx1cktuaEVBMlNSaXJXZ0hJVy80QUh6d0ptbFND?=
 =?utf-8?B?bURYLzQvQUQwTnRjS25jOXdEdmxmR2lGVE1XZ0F3NVlsUHA3RjFNNUNHU2V5?=
 =?utf-8?B?cmxKWnp3dGFhK2p0K0o0T0FybW9aMEoyaGtaaDZKTnBHUFRqdy9GOU1zV2dK?=
 =?utf-8?B?aStXSDlOcEI1WENJc2YxS2pSdlJjLzFDN3ZXWG50WHl1M1lESFlpVjdCeFZN?=
 =?utf-8?B?M1dtVnFzSm9qRnBjWkxmWllJeVFVajFrU1c5dTBPWUFMUVp4ZnRDQTVsQlF1?=
 =?utf-8?B?NFNYd1FyRDJURXZjdFBENy90aklMTjh4NER2ZDNQVHZkeldqclFtdjdKOC8y?=
 =?utf-8?B?dU1TbThiT3hpWW90QkFydFQ3ZkpCNHlvUkh1clB2dlMxenJVWm1TTUxTVDRr?=
 =?utf-8?B?NFl6bEVXSlA0dWlmT0NrZ1N3V1RxM1NhTlBvbVdyeE96M1hyM1NBUFV5dlJ5?=
 =?utf-8?B?NmhFZHRDZWZUWko2Z1I2eThWNG9pcWZsSFkrODVNVFd4b0lPZHQ5MmhJN2Ew?=
 =?utf-8?Q?xRcP1T41RGjK0hACZ+BpLnGjb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17382d12-2ec5-4a8c-23f2-08db56ef8700
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:58:16.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajm7FmF2/QQ3G/xUQsdZ0sHrZ7SK2zw66ngiEsJHo3HpOOPHBeCxK8SXmHGUPm/51lPncxY/oFTHC5ewvkLR1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
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

On 5/16/23 07:06, Kirill A. Shutemov wrote:
> efi_config_parse_tables() reserves memory that holds unaccepted memory
> configuration table so it won't be reused by page allocator.
> 
> Core-mm requires few helpers to support unaccepted memory:
> 
>   - accept_memory() checks the range of addresses against the bitmap and
>     accept memory if needed.
> 
>   - range_contains_unaccepted_memory() checks if anything within the
>     range requires acceptance.
> 
> Architectural code has to provide efi_get_unaccepted_table() that
> returns pointer to the unaccepted memory configuration table.
> 
> arch_accept_memory() handles arch-specific part of memory acceptance.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Can you also add the efi.unaccepted table to the efi_tables array in 
arch/x86/platform/efi/efi.c?

With that...

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> v11.1:
>   - Add missing memblock_reserve() for the unaccepted memory
>     configuration table.
> 
> ---
>   drivers/firmware/efi/Makefile            |   1 +
>   drivers/firmware/efi/efi.c               |  25 ++++++
>   drivers/firmware/efi/unaccepted_memory.c | 103 +++++++++++++++++++++++
>   include/linux/efi.h                      |   1 +
>   4 files changed, 130 insertions(+)
>   create mode 100644 drivers/firmware/efi/unaccepted_memory.c
> 
> diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
> index b51f2a4c821e..e489fefd23da 100644
> --- a/drivers/firmware/efi/Makefile
> +++ b/drivers/firmware/efi/Makefile
> @@ -41,3 +41,4 @@ obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
>   obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
>   obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
>   obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
> +obj-$(CONFIG_UNACCEPTED_MEMORY)		+= unaccepted_memory.o
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 7dce06e419c5..d817e7afd266 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -50,6 +50,9 @@ struct efi __read_mostly efi = {
>   #ifdef CONFIG_EFI_COCO_SECRET
>   	.coco_secret		= EFI_INVALID_TABLE_ADDR,
>   #endif
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +	.unaccepted		= EFI_INVALID_TABLE_ADDR,
> +#endif
>   };
>   EXPORT_SYMBOL(efi);
>   
> @@ -605,6 +608,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
>   #ifdef CONFIG_EFI_COCO_SECRET
>   	{LINUX_EFI_COCO_SECRET_AREA_GUID,	&efi.coco_secret,	"CocoSecret"	},
>   #endif
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +	{LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID,	&efi.unaccepted,	"Unaccepted"	},
> +#endif
>   #ifdef CONFIG_EFI_GENERIC_STUB
>   	{LINUX_EFI_SCREEN_INFO_TABLE_GUID,	&screen_info_table			},
>   #endif
> @@ -759,6 +765,25 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>   		}
>   	}
>   
> +	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY) &&
> +	    efi.unaccepted != EFI_INVALID_TABLE_ADDR) {
> +		struct efi_unaccepted_memory *unaccepted;
> +
> +		unaccepted = early_memremap(efi.unaccepted, sizeof(*unaccepted));
> +		if (unaccepted) {
> +			unsigned long size;
> +
> +			if (unaccepted->version == 1) {
> +				size = sizeof(*unaccepted) + unaccepted->size;
> +				memblock_reserve(efi.unaccepted, size);
> +			} else {
> +				efi.unaccepted = EFI_INVALID_TABLE_ADDR;
> +			}
> +
> +			early_memunmap(unaccepted, sizeof(*unaccepted));
> +		}
> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> new file mode 100644
> index 000000000000..bb91c41f76fb
> --- /dev/null
> +++ b/drivers/firmware/efi/unaccepted_memory.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/efi.h>
> +#include <linux/memblock.h>
> +#include <linux/spinlock.h>
> +#include <asm/unaccepted_memory.h>
> +
> +/* Protects unaccepted memory bitmap */
> +static DEFINE_SPINLOCK(unaccepted_memory_lock);
> +
> +void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	struct efi_unaccepted_memory *unaccepted;
> +	unsigned long range_start, range_end;
> +	unsigned long flags;
> +	u64 unit_size;
> +
> +	if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
> +		return;
> +
> +	unaccepted = efi_get_unaccepted_table();
> +	if (!unaccepted)
> +		return;
> +
> +	unit_size = unaccepted->unit_size;
> +
> +	/*
> +	 * Only care for the part of the range that is represented
> +	 * in the bitmap.
> +	 */
> +	if (start < unaccepted->phys_base)
> +		start = unaccepted->phys_base;
> +	if (end < unaccepted->phys_base)
> +		return;
> +
> +	/* Translate to offsets from the beginning of the bitmap */
> +	start -= unaccepted->phys_base;
> +	end -= unaccepted->phys_base;
> +
> +	/* Make sure not to overrun the bitmap */
> +	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
> +		end = unaccepted->size * unit_size * BITS_PER_BYTE;
> +
> +	range_start = start / unit_size;
> +
> +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
> +				   DIV_ROUND_UP(end, unit_size)) {
> +		unsigned long phys_start, phys_end;
> +		unsigned long len = range_end - range_start;
> +
> +		phys_start = range_start * unit_size + unaccepted->phys_base;
> +		phys_end = range_end * unit_size + unaccepted->phys_base;
> +
> +		arch_accept_memory(phys_start, phys_end);
> +		bitmap_clear(unaccepted->bitmap, range_start, len);
> +	}
> +	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +}
> +
> +bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	struct efi_unaccepted_memory *unaccepted;
> +	unsigned long flags;
> +	bool ret = false;
> +	u64 unit_size;
> +
> +	unaccepted = efi_get_unaccepted_table();
> +	if (!unaccepted)
> +		return false;
> +
> +	unit_size = unaccepted->unit_size;
> +
> +	/*
> +	 * Only care for the part of the range that is represented
> +	 * in the bitmap.
> +	 */
> +	if (start < unaccepted->phys_base)
> +		start = unaccepted->phys_base;
> +	if (end < unaccepted->phys_base)
> +		return false;
> +
> +	/* Translate to offsets from the beginning of the bitmap */
> +	start -= unaccepted->phys_base;
> +	end -= unaccepted->phys_base;
> +
> +	/* Make sure not to overrun the bitmap */
> +	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
> +		end = unaccepted->size * unit_size * BITS_PER_BYTE;
> +
> +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +	while (start < end) {
> +		if (test_bit(start / unit_size, unaccepted->bitmap)) {
> +			ret = true;
> +			break;
> +		}
> +
> +		start += unit_size;
> +	}
> +	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +
> +	return ret;
> +}
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 29cc622910da..9864f9c00da2 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -646,6 +646,7 @@ extern struct efi {
>   	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
>   	unsigned long			mokvar_table;		/* MOK variable config table */
>   	unsigned long			coco_secret;		/* Confidential computing secret table */
> +	unsigned long			unaccepted;		/* Unaccepted memory table */
>   
>   	efi_get_time_t			*get_time;
>   	efi_set_time_t			*set_time;
