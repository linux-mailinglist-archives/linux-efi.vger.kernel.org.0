Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EEA7C8C8B
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 19:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjJMRp3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Oct 2023 13:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMRp2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Oct 2023 13:45:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A8AA9;
        Fri, 13 Oct 2023 10:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZKFWuxT3GgMK8QXWcUR7W3aVuqXxLgKUQ5YiG5lWxvRsUBTDd7YaxPSkpWuQNGnux8eNjgg0yaKIrffxjb+WcTOatYJrTZHgAhCi/O6jYVNGrzFUEpAf6JlHwG5twkFtwlxRPuh17GD666P6C1dDOf13WVEyqU9sm9b9RDYlz0jW7Cbw+TQcyo2ez/IX4Tv+bk5uQYLUDh5794qM+rJDz9FHlCo5MaPvRQ7HFvofLYT0FSP6vialYAu0MPaM8WgTM3wpyMsNI0wiwkIqlJr/3VyqhCoGCeq74whZB7ivhuhKnSrgwakn9nlvEHfCebkVl4LvhhEN5HGNr4HA8JTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsJgqm2EmKIY047/+Gll0nH87bZ2rRFK/tV2aJMRVPw=;
 b=YbC8LnVG0Ax85lkP72lWspm9o0Pj+1FiNhufBGUayQuffyzZq9002WVFlF2a4nwHxP34i4T5JHCBQwDnayDHyr+RcxZfsBbaE+7kllwgrEqPsQyOX0lIipwfjdfwXpjs79OytVj/EPH0e/QfqnNp4kpImxd26HWHovPKsKJgaJCPOnie/th6oKmqnpZyza+sms7k/FfRRAb1wA4TaOfT59mU1RKPJNLIXlYIABEap/Itaxc/cMqgxiOEBTULbJjMH26YboQAa8h8S0S1ciE6Ihn3NASP8CCSnzEI4US0X+cm6+0aWCBSVxBX2tlU//MgV1LeXuBu27fPjG/H/KiebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsJgqm2EmKIY047/+Gll0nH87bZ2rRFK/tV2aJMRVPw=;
 b=WzIjCbRWcdFtDvHD7Hz8bRCJ29bm4MYMSPz+ZjbILUSe/CfKedehiDinmCc3hhm6o8ZzzfAEku9fNYfQpOpfNl5yv1IIYhpNXs6TXMcoAjYoFA6OlQtm7iODGXHpzwEDxGy3pSnMoeYWxwz67DhCEfpdzW6HW6R007CDYHZPktY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 17:45:23 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::a13:336d:96a5:b7bf]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::a13:336d:96a5:b7bf%4]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 17:45:23 +0000
Message-ID: <3577c8a5-3f88-45b8-9b41-2fb5cb6dc53a@amd.com>
Date:   Fri, 13 Oct 2023 12:45:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv14 5/9] efi: Add unaccepted memory support
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <20230606142637.5171-6-kirill.shutemov@linux.intel.com>
 <20231010210518.jguawj7bscwgvszv@amd.com>
 <20231013123358.y4pcdp5fgtt4ax6g@box.shutemov.name>
 <20231013162210.bqepgz6wnh7uohqq@box>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <20231013162210.bqepgz6wnh7uohqq@box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::9) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ea073c-de46-4ac2-6b88-08dbcc142d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hbc5e/d3ADRKNqTc3brbq2S3VFVJg958FBbFtgHIsopb5lN/exj6Os8v6xOojbf5V0FPHWq/Iw7HxdUcNeiK9j3pK3pe4Hbyp5uhscGeq/YcXHRHQV3NIo16vu2H1I9PopkFVe5zCyEpH+l8fzE3JDh9XwlmcX/OXHuN4iENI5cnjtdYyBU3kXWTHvdq9YNP4st8f4AF3/O3XOo2kQwN3dgLyPdDncczFo1G63Yl2LmRUbbU/yOBY099ugqfjKJQbtPPFwxz2UnvNjEOfTjBip4pP7k3dLeKKTz2CccX6ytjKVzRUAu5qgiDsm+uVmTFsODWSUF/BvfMOmCZIcszEwbyiZ3xgT3oPI0rXk/+LN33CY62+UbMhMmMQgvRnZ5DTTCuEg4blaPGrQT8CBiTZkvXz8DZtWzPz6Eec2xej1nBPVFBsoWXhqIAaKENHdP/vvT6Adz2tr3RnqjCXpjf/+RZkVqJ8VSSCKYPpbcTT2eR6+WrboituKs9/BDr8QCYDZN+zqveOjWWJt1sFNzF7eZcx3hl9HNbtTZbUkb5S6EvOmeCEjcTm7wQWSTIPdbsahbayxrXVQic270g5eYG7GH0jImrmpv1un7vpZ8/7jhO9qu56c84Ht6lQzn9RMwKg0D8W1kcB4yHY24B5zwzbSzal5SvkuAy9PGcAB0vNoNjivyhJPZTwTnsLguIQtL8t84LbXhxbWkYb+6s6jYuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(7406005)(7416002)(478600001)(2906002)(6486002)(31696002)(41300700001)(4326008)(8676002)(8936002)(5660300002)(66946007)(66476007)(54906003)(110136005)(66556008)(316002)(83380400001)(36756003)(6636002)(2616005)(26005)(6506007)(31686004)(6512007)(53546011)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEsvODRMMGtmdUwzSklFS1hEajhWbGVPall6YlhGOGZmb1FtQlJTTXpmaThn?=
 =?utf-8?B?Ti9QVm1JSHJQbVZvS2N1RmIwVmtTTVkwakJmWUVMZmFsQnVZN2pVMkZFdFpG?=
 =?utf-8?B?S2JKbm80U0dMSDRmTXNZZzZ3WmJzdjFlQUp0dWErMEV3Y25EMlo0Tm4vdHlZ?=
 =?utf-8?B?WUpZZlluKzdQRlFWemVhVGVrNlg3Ly9JTGZYemt6cTJHMFZULzRhOW5Rcnpr?=
 =?utf-8?B?dzBOR3E3T1dodUxyWmlscmtuQXNRajkyWFc2dnhERjZsZ01WdWZuS2M0dHk2?=
 =?utf-8?B?aUpuNTc3RkNTY05PajkzRllMY1FrYmxGRlgwVmNWTzVyNjJEbEduSlNlYWVM?=
 =?utf-8?B?N2J1N0lZU0xHSTdKL0pWU1dCRGljM0t6bllGajNTWFAyckZ1bzArcDVqci9G?=
 =?utf-8?B?ZHVZTlRxMmFKdlBPakIxUXNKTG95eEw0a1pEaHpnNjlWVCtLd3VuVXR0Z2VV?=
 =?utf-8?B?YWlUYi84NS9wUGdYMCtVa1k0dWlGQkIrbUxqa1ZYOFZ4OXpXTXVydEM4WHVv?=
 =?utf-8?B?YUJ3SmNlUXpOdVpLdkJaV0hyNHdzU0pnSHNyK0ZnaGlmWjVqWG9NcU5QdVZC?=
 =?utf-8?B?QnY3eEJEVEZIbXdsazJQVWpVS2FUN2J2b2NqNmRPdU56aFBUbFE0a3RRNE9N?=
 =?utf-8?B?ZnFTc0FQdnlzRFVMZ1pSUzVPSTJTNTdpRll4QUlCM0cvdTRnRllJQVFLYjI0?=
 =?utf-8?B?aFkxOXo4Z2VPL3BkS3N6R1MzRS9FeFprdnRzZzZHbFlqbk9YdWdNVjNKN29V?=
 =?utf-8?B?SXYvN2ViM1RYNU1YY3NzVVBjb05BYUlQUnJGeS9hdWZUTkZ2STZucmp3bHhk?=
 =?utf-8?B?enRpWnRqQ2pFT2sxUHp0VHNGQWE5ME4rQjl4ODN2RHkrZG53UXM0QzZKK1F1?=
 =?utf-8?B?dnNtTktGb2NOTUNGVjBiR3NoTWxtazNPK21qZzJPUld4MklEQ0kremxTNmVx?=
 =?utf-8?B?RHBkM2ZDclQ5T0pPQjZHVjlCaHo1cy9jSTVJeUlUamxKU2JzOTNIYy9SZDRT?=
 =?utf-8?B?aVpXRitBcUlIenc4bnYrdmh2MXYzZEErZWp1NTdkSlIxaS9Rc252bkVuS29C?=
 =?utf-8?B?WlozN3JhRCtUcHNXY0RsUTdldDBoU3NHQzRZK2NWT3k4Y0dOQTUxcTIyM0M0?=
 =?utf-8?B?UHZ5VmxyQU9TOWtQYm5JYVc5MFE2QlRWOGxHQUM5VTlwc1lwTTBkaVBMT2xE?=
 =?utf-8?B?OEVJcUtoYWZkUUVvL05idmJUa2V0YXphaWN2dXpVVS9Rd1l4QXV0cU5MNno0?=
 =?utf-8?B?cGljd2k2VzdvNU85U0tyd05MbUJ4cGxzME1CQ1lRU1ppKzVHUHI3QkxWQmcv?=
 =?utf-8?B?OWVKVzNYZVVBdmFTa1BRdXd2eUNlZlBzWGs4a29sV1BVeW5pMkpSalFNQU9T?=
 =?utf-8?B?My9DNkt5aHNwZmxiQW1CYS90U3lJcmJxZ0hVZVlNTmw2TGJuenpQK3dMYyty?=
 =?utf-8?B?akJXaXhJR3Zsb01PdWgrNlBtelZPTTVyTkl6Z1hSS2pET3c0NVBHL2NwcUow?=
 =?utf-8?B?QXIyamZablR5cExxRkZIMG1KS3gzRVY0T0EzZ3dGRjAwS0FNK0dUZEZuSUQ3?=
 =?utf-8?B?RnROdXdaUWFBNkFkUFdyNEFQMmtvUGxyOXRNTnRzV2tnN1Urcjc3dHVVUlZG?=
 =?utf-8?B?VThiQjJ2U2ROWXUrS3V0ekdoNmVOd2E4VDVuelFmczNWZWwxbmFzRmlWQUxP?=
 =?utf-8?B?dGJEV1dhRDNxaDkvVWkwYUtDRFN2enovQlNrNWxBRE9GRUZDTTcyeHhpQXI3?=
 =?utf-8?B?WVYxSnY2SnE2MWxMbGp5U0RXd01UYjR5VEZ5RVVqbGlzdnNETzBVSGhVbHFZ?=
 =?utf-8?B?RlFNN2w1WWRuRHVqT042R3h4ZmtHNVMvbHVBNGlNWU05aXkwZDBVa2lEMUJR?=
 =?utf-8?B?d2VmS0dpWkkzazgyWHdGR1VrTXBqb3J3V3pKNHE1bDlqb3dvbFg0UXJ5QWVy?=
 =?utf-8?B?MEF3d3RRMVk4RGZEakh3SHBvWE5CM2daQVIzeFkvSXl6K2ZGSWt1WVJxQVI2?=
 =?utf-8?B?QU9Wa3h1Vm5td2prdW9WVlRnRGxpNkhlRzN3N1Mwa0QvS2RsaTV5dTJvTWFo?=
 =?utf-8?B?bEh0TTNjelcwMzdBMHpEbU5ud0xPNWV0S1EwQklxak1pZTlUZkhFVjQ1QnZr?=
 =?utf-8?Q?2889BJQL8w2d3GbSkHhtaaBOR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ea073c-de46-4ac2-6b88-08dbcc142d55
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:45:23.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SngjWU2R43FTysx65msH/iIV0acqa27BX0WVYYAdZyWJ9xz+VOwnxVheUoMRptMu0C2tvcXNOpP2vjqv1QqKQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/13/23 11:22, Kirill A. Shutemov wrote:
> On Fri, Oct 13, 2023 at 03:33:58PM +0300, Kirill A. Shutemov wrote:
>>> While testing SNP guests running today's tip/master (ef19bc9dddc3) I ran
>>> into what seems to be fairly significant lock contention due to the
>>> unaccepted_memory_lock spinlock above, which results in a constant stream
>>> of soft-lockups until the workload gets all its memory accepted/faulted
>>> in if the guest has around 16+ vCPUs.
>>>
>>> I've included the guest dmesg traces I was seeing below.
>>>
>>> In this case I was running a 32 vCPU guest with 200GB of memory running on
>>> a 256 thread EPYC (Milan) system, and can trigger the above situation fairly
>>> reliably by running the following workload in a freshly-booted guests:
>>>
>>>    stress --vm 32 --vm-bytes 5G --vm-keep
>>>
>>> Scaling up the number of stress threads and vCPUs should make it easier
>>> to reproduce.
>>>
>>> Other than unresponsiveness/lockup messages until the memory is accepted,
>>> the guest seems to continue running fine, but for large guests where
>>> unaccepted memory is more likely to be useful, it seems like it could be
>>> an issue, especially when consider 100+ vCPU guests.
>>
>> Okay, sorry for delay. It took time to reproduce it with TDX.
>>
>> I will look what can be done.
> 
> Could you check if the patch below helps?
> 
> diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
> index 853f7dc3c21d..591da3f368fa 100644
> --- a/drivers/firmware/efi/unaccepted_memory.c
> +++ b/drivers/firmware/efi/unaccepted_memory.c
> @@ -8,6 +8,14 @@
>   /* Protects unaccepted memory bitmap */
>   static DEFINE_SPINLOCK(unaccepted_memory_lock);
>   
> +struct accept_range {
> +	struct list_head list;
> +	unsigned long start;
> +	unsigned long end;
> +};
> +
> +static LIST_HEAD(accepting_list);
> +
>   /*
>    * accept_memory() -- Consult bitmap and accept the memory if needed.
>    *
> @@ -24,6 +32,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>   {
>   	struct efi_unaccepted_memory *unaccepted;
>   	unsigned long range_start, range_end;
> +	struct accept_range range, *entry;
>   	unsigned long flags;
>   	u64 unit_size;
>   
> @@ -80,7 +89,25 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>   
>   	range_start = start / unit_size;
>   
> +	range.start = start;
> +	range.end = end;
> +retry:
>   	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +
> +	list_for_each_entry(entry, &accepting_list, list) {
> +		if (entry->end < start)
> +			continue;
> +		if (entry->start > end)

Should this be a >= check since start and end are page aligned values?

> +			continue;
> +		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +
> +		/* Somebody else accepting the range */
> +		cpu_relax();
> +		goto retry;

Could you set some kind of flag here so that ...

> +	}
> +

... once you get here, that means that area was accepted and removed from 
the list, so I think you could just drop the lock and exit now, right? 
Because at that point the bitmap will have been updated and you wouldn't 
be accepting any memory anyway?

Thanks,
Tom

> +	list_add(&range.list, &accepting_list);
> +
>   	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
>   				   DIV_ROUND_UP(end, unit_size)) {
>   		unsigned long phys_start, phys_end;
> @@ -89,9 +116,15 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>   		phys_start = range_start * unit_size + unaccepted->phys_base;
>   		phys_end = range_end * unit_size + unaccepted->phys_base;
>   
> +		spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +
>   		arch_accept_memory(phys_start, phys_end);
> +
> +		spin_lock_irqsave(&unaccepted_memory_lock, flags);
>   		bitmap_clear(unaccepted->bitmap, range_start, len);
>   	}
> +
> +	list_del(&range.list);
>   	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
>   }
>   
