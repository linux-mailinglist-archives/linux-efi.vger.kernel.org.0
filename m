Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045AE706DA2
	for <lists+linux-efi@lfdr.de>; Wed, 17 May 2023 18:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjEQQHq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 May 2023 12:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjEQQHo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 May 2023 12:07:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028392691;
        Wed, 17 May 2023 09:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH1kqrb5A1GXJe02/R0Dwlq54y/1I7RnqHCAmgsKexTs06uTFT90W1iXz958Dxf7a9Zs3RNjxAMe7Od4Gp6iQFhTyclVLm1Id1kUz5o2H07nA/ieyurPvnSEJQ6RVesxn9I2G7hU6V0GYc66k/+ny1D6EW7sQLXT4EWlc3WXsgSVWHMJupsOUFpMz1SzwWvSPGr8kOAAQqkarjBcDHpE/qLns6stKuO95khnKmcyritNuAC3LwavTynf6zcs0rkP2Y35CXrEds9O2hcJm+FZvJg+kh36sczssa1MQUX3UTIqDfRio2v0BAEofvKKOD6rfudnG047yOIY3T7VJBx5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAt9fFoHWB1YevfNwALXh6vikrAD5FxXl9rcOVC2/Y0=;
 b=ZnUnirX8Megj3SxgN5A7uI9ZJs5XSsaHcOra+GQulSzL5KlrGQEZn2le5Ouh0Y64+WdrLnIhroGM3m/OjrZG7xu1CqB8yrKcPyd7K1ZqmkflLfd+kW3WzxxQhFAqypDLLwrSp71x3neoxe2vYUEj1EDlKTZ1+BbT1HGLy7wiLi6w2r3UUlmrpVEsr7LYxzFxwJVuCViXDCzQNRcQ8Fe3J2tBLOTEDebjEL8OHpxSQTV6HKPbRk2aMTnQoK0VcVfLDME6jHAoYctqKDhXQQ7+ETbMDJSj1CQc9VKc+KbYx0GwHCpSfdh+amUqYXjWeyW6jQIGwYHmdV7J9WNDBEkoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAt9fFoHWB1YevfNwALXh6vikrAD5FxXl9rcOVC2/Y0=;
 b=eUXxP5NponnxdInpaqs4xbT8Yj9BoB+0rrJylN/Z5O32LK7EbIJdKo2YTlOGFFeU4UeJGMl/pnCRPDZuCtBU7caLLSdMHSENrdssp7k7Wwb/mnkH/QMS4h/alkVnq9JmJMwSVS6BNch6ZW/D/dYr/j3wtkFtxsIrUhJGEBT6yns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:07:38 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 16:07:38 +0000
Message-ID: <b58dd2bd-4eb9-7efc-f6ee-3074d2bea579@amd.com>
Date:   Wed, 17 May 2023 11:07:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv11 6/9] efi/unaccepted: Avoid load_unaligned_zeropad()
 stepping into unaccepted memory
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
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-7-kirill.shutemov@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230513220418.19357-7-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:805:de::26) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 61af4214-89cd-49bd-46f8-08db56f0d5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLnmybtU2lKiCW6nbCVMgaEwJIhmydMBJHseqVHsrN7lbnum2v/RUGDHjydyJLmp7HGRnSn8YU17SzXRCvBRhGqh7cGG03K4+X2/R8chjfXcIEmXIYmqmmdIhGaNJH6IfSpqhl5g9f0Js+He1vzAmNPiZBBY/QhlqKTYz0v5jJEPr4Me3iHHePHXieKT0uLnZ2xS67NoLFx2o8T7sHOri59BmEoHAio7m7CfivBNtB99PNtXXthLVrd/05XfgqhVd1AZ6r7vzDjIZK5Amx44quKJB9hvkJKe204hdRXnM7kEgVV74YrFoC4miMf/vDqojPh2CX91U/CrRG7P1NAWqwRtjWV2dRenRohfMTi5X0ET3ZQKgZ8o6YYZ1T9ROwU/2Pq+2eGaRFGgw4oUP1zEzAgAO7kiT1t4em9BGqytmTeKPPVg4GlXGXBRFJU04/6RQvg8wM25f7oS0zyIFPMyJkv0Z1Bnx4xRj7QObB/dB3hjKuMATV8laENe/Du8U1GSxz2Tb/ilgT8bFutgdc7W4ucscPP4/hufZzt19z8K51N4fJCCutopiwSErbUiskn2HT+r1kZ90pIeuIjTQ2DjLL/S1IIGNl9TTHJfoIKZlKziJDhPHpbCqIyPN13ToWhgP4tdlbKX4UBR5IF2SPgqYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(66946007)(31686004)(2906002)(7416002)(7406005)(83380400001)(5660300002)(8936002)(8676002)(66476007)(110136005)(54906003)(66556008)(41300700001)(316002)(478600001)(6486002)(36756003)(4326008)(6666004)(2616005)(53546011)(31696002)(26005)(6512007)(6506007)(186003)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmVKTjA5Yzg1blJ1REtjNzJlRjdZZzRROTVHSTZ3T1Z2VHBRdllaL3lNaUt3?=
 =?utf-8?B?MENrTi8vR3NVRXQ1L2hmZVJKamZHQml5WWd1Y0RoL2RrWTUrd2x0ZTc5YmJz?=
 =?utf-8?B?NE1rSGp5WXZoRXBDTWlZY3ROanpzcEZ4VnBQQnBUQkNzbHBVbmZldXdLNVdy?=
 =?utf-8?B?MTQxUEdMMWJmN1JIS0F6VGhIbXpScjI2bmhUZWZBZEgwQWRkcUI4cmF5eGp3?=
 =?utf-8?B?N0RCZFpwSUZicHh5SEVLRkg1T1FTNG4yU0R2OFkrb0Q0UEJoQ2l3VzdOVytm?=
 =?utf-8?B?REpzUTZtdkdZZWdqTURCVmNHaGFvQlZEb3dJUEp3a3dpOEFmYkFtQWljYm5V?=
 =?utf-8?B?ckJJS29yWldwdFMrMzBZNjF1WEJKSlRaanIyOVFkSjlRRU90SFRMWnNUU3V5?=
 =?utf-8?B?OE03QWNxeFNmZ3hJb3k3QmFvd0tkT0RRa0s1RmVXckpaR1l3VlB6aFh2T3kz?=
 =?utf-8?B?THVRSGVzK0xmVnpNTDZmR1BiNTB6T1Vrd0huTnRDbHhGUnU5ZWRneE1zZDZa?=
 =?utf-8?B?ZHlDc2hGaXE2cTFicW9kd1d6ZlZFUjJhZWdXLzBoT3NnN0o0Ty90b3JzbU1q?=
 =?utf-8?B?M042VXZUc2tTb1JSWFlDY3BIQnJCaXEwb2d5bG9Hb3RCK0paSElqQUd5TTBZ?=
 =?utf-8?B?TlRVemVPeVRXV1FNek9odW0yYS9NMElJL0ppaG9pUWwwc3RmRDUrNmsxaWhD?=
 =?utf-8?B?eXhFU2NtR2ZlS3EyMzN6ekpkeHVxRzNpa2llRTRNcDVrdmVGb3FzVzQrVG9J?=
 =?utf-8?B?TngvZFZyN1VwUU9YR2Y0bHh4cGd4a2RiVzdwVUdtelhMUFNDMU5XTTF0RGxU?=
 =?utf-8?B?NXZ6YzJwZU1Tc3JQWmNDMHl1VFJKb2s4YS9yQ2FIdjJUTWplb2NNamp0VVo3?=
 =?utf-8?B?a3NIcUFqT0ZYTWtDK3p2Qm9sTGpKNFV2anliRVoydERuZDNneU5XbXlSb2JT?=
 =?utf-8?B?RDNMYjh5NTVzMGNjUGlCZW5jOHdhU0J4cXEwYVA3NEpUekRLa3Z4TTF2eDZx?=
 =?utf-8?B?SEpvOGJabkRNaXV1RnZONWplcmpoZEE0MG1TcWR4UmRBcTAxY2ZXbFFhaHZI?=
 =?utf-8?B?bjcxTkFTdWZZT001Wk5YVkpRMHNhMER1b01EcGh1N0RwNmlYTGxYRVdQbzRk?=
 =?utf-8?B?REQ1bzl5cUhQVDFzVjNiWSt2MS9OeHlndm5YUWpodXJ4RkJmTXc2NFNSM3VL?=
 =?utf-8?B?TWVYQ29peDlxMnRzUC92Z2d3UDJzZzZKeWcwaFBwOXp5QVl0b0NTUlJIWmhU?=
 =?utf-8?B?dm9PS05HTjNubm9GcVJkREtLa3dQTFRlV1VQVTRjbVpXaGV1Q1owZytDN1Bm?=
 =?utf-8?B?SFlIaFc2WkVsbFdwdUxSd2gzUHhiTFNBNytJY0J0RXZhbXQwMUxFVmwxU0x3?=
 =?utf-8?B?WVNHWjI1clNRZEZkT1NxdGxLc0VkQ1RKbmV0QlhOdUFpMmdGVXFxZ2xpK3ZS?=
 =?utf-8?B?ZUQyS0pkZWpHdkxnQTFReEVadUY1Z2hPZ3NJUTVEd2E1bWJWOS9zcUszalVt?=
 =?utf-8?B?a004THcwM1ZsbGU3NTl5ZmFPZUYxVjVBTFhiUE95Z1hGeGdLSUpQYkVBdTAw?=
 =?utf-8?B?NE9qck8ybDZLNDdtWmg4U2VST3NBbG14a1RmaCtkbUh1NUQwWmlEVUYyN3lw?=
 =?utf-8?B?U0dNcnVZMVZGN3JOaVp6OC9idVVnNTloLzhVODlKVmxKcVYzcGR2Qm43ZGJu?=
 =?utf-8?B?Z0lrZVg1OUc1RXZuWlM5ckk1bHdiZFczQlNiTzRzRUp4VEg2UlJDd1Fzd21X?=
 =?utf-8?B?RklWb3BPZklxc3k5a05zSFMwOTRHNGJHaWRUek45bXZHeHBMYnBUSDkwMnVp?=
 =?utf-8?B?ZmxFNWcyTnR3UFd6SVZWSEZEeGRGWEJpSWx6NjNTd2hpOTV5SC9CbFZVMDdn?=
 =?utf-8?B?cDVNbWNISkhjY0ZZdmtTYXl6RU5KYWw0Q1JYRDRHbzlFNUo2ei9UdEZOM3ZI?=
 =?utf-8?B?TE5qRHVYMnB5SlR4U3RFWW8ycnpja0wzVEdkVU90TEtBWU5uak80THZKb1Av?=
 =?utf-8?B?eGhnVlZsNXhKN0NZWlI2M3MwUWp2eGlXcEJ6L2xSanpvTEhEYU50Vmc0Y1Bw?=
 =?utf-8?B?MEZiMVlMd0dRUGplWmFvWHNNR3Y0dlMvZlRkTm1IcXJSTHRUeVJzMVFiZEJQ?=
 =?utf-8?Q?37scOVuf4PftyG/y8uTojm0xg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61af4214-89cd-49bd-46f8-08db56f0d5ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:07:38.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lv4xJHu3F3YF7ehtmve+xdjqrWb4qxvDeQXeLGE7TPYLHzvNiP85bOsRr73jQH+Z3W7Xww9SwG834SPNEIHMvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662
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

On 5/13/23 17:04, Kirill A. Shutemov wrote:
> load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> The unwanted loads are typically harmless. But, they might be made to
> totally unrelated or even unmapped memory. load_unaligned_zeropad()
> relies on exception fixup (#PF, #GP and now #VE) to recover from these
> unwanted loads.
> 
> But, this approach does not work for unaccepted memory. For TDX, a load
> from unaccepted memory will not lead to a recoverable exception within
> the guest. The guest will exit to the VMM where the only recourse is to
> terminate the guest.
> 
> There are two parts to fix this issue and comprehensively avoid access
> to unaccepted memory. Together these ensure that an extra "guard" page
> is accepted in addition to the memory that needs to be used.
> 
> 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
>     checks up to end+unit_size if 'end' is aligned on a unit_size
>     boundary.
> 2. Implicitly extend accept_memory(start, end) to end+unit_size if 'end'
>     is aligned on a unit_size boundary.
> 
> Side note: This leads to something strange. Pages which were accepted
> 	   at boot, marked by the firmware as accepted and will never
> 	   _need_ to be accepted might be on unaccepted_pages list
> 	   This is a cue to ensure that the next page is accepted
> 	   before 'page' can be used.
> 
> This is an actual, real-world problem which was discovered during TDX
> testing.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/firmware/efi/unaccepted_memory.c | 35 ++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> index bb91c41f76fb..3d1ca60916dd 100644
> --- a/drivers/firmware/efi/unaccepted_memory.c
> +++ b/drivers/firmware/efi/unaccepted_memory.c
> @@ -37,6 +37,34 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>   	start -= unaccepted->phys_base;
>   	end -= unaccepted->phys_base;
>   
> +	/*
> +	 * load_unaligned_zeropad() can lead to unwanted loads across page
> +	 * boundaries. The unwanted loads are typically harmless. But, they
> +	 * might be made to totally unrelated or even unmapped memory.
> +	 * load_unaligned_zeropad() relies on exception fixup (#PF, #GP and now
> +	 * #VE) to recover from these unwanted loads.
> +	 *
> +	 * But, this approach does not work for unaccepted memory. For TDX, a
> +	 * load from unaccepted memory will not lead to a recoverable exception
> +	 * within the guest. The guest will exit to the VMM where the only
> +	 * recourse is to terminate the guest.
> +	 *
> +	 * There are two parts to fix this issue and comprehensively avoid
> +	 * access to unaccepted memory. Together these ensure that an extra
> +	 * "guard" page is accepted in addition to the memory that needs to be
> +	 * used:
> +	 *
> +	 * 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
> +	 *    checks up to end+unit_size if 'end' is aligned on a unit_size
> +	 *    boundary.
> +	 *
> +	 * 2. Implicitly extend accept_memory(start, end) to end+unit_size if
> +	 *    'end' is aligned on a unit_size boundary. (immediately following
> +	 *    this comment)
> +	 */
> +	if (!(end % unit_size))
> +		end += unit_size;
> +
>   	/* Make sure not to overrun the bitmap */
>   	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
>   		end = unaccepted->size * unit_size * BITS_PER_BYTE;
> @@ -84,6 +112,13 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
>   	start -= unaccepted->phys_base;
>   	end -= unaccepted->phys_base;
>   
> +	/*
> +	 * Also consider the unaccepted state of the *next* page. See fix #1 in
> +	 * the comment on load_unaligned_zeropad() in accept_memory().
> +	 */
> +	if (!(end % unit_size))
> +		end += unit_size;
> +
>   	/* Make sure not to overrun the bitmap */
>   	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
>   		end = unaccepted->size * unit_size * BITS_PER_BYTE;
