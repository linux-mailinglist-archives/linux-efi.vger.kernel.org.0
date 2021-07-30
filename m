Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA9B3DBCE3
	for <lists+linux-efi@lfdr.de>; Fri, 30 Jul 2021 18:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhG3QKX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Jul 2021 12:10:23 -0400
Received: from mail-dm6nam12on2080.outbound.protection.outlook.com ([40.107.243.80]:8865
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229505AbhG3QKU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 30 Jul 2021 12:10:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fielg8jPwzljnKKMXAS5vhodGZ9UIa8rBEU+M0ykJWdroMNAQdT51fe+dPEmDIrNDHaE+N3fsvoJcTMbwKLghZhrzzGg4EVEhf3MNlo7NtPvqoYuscA/3Y7LwPVtuJntZpcmHkXsjtIWSYGPPLx5yNIAck0EQAHNVFXkSUzOKpxUdeANArSXXH1YSJELJXzGlhQMqE9psHChTW+UHVhBQVwo4oSr0ooFm9TJnG5VK7QrfhIGGcUB6mwAfaxEGpu09JavS/4z3dypQU+5pIxtkwuKlrPb+q26clvWKe592sDZ4XSq7R5UhBeZ4ql+rRHDnV7ktAyZ64BA7NQLvM2R0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFqFuulcnH5N9pF359cQNynyBzm64zf0zVOlnOsdurs=;
 b=bAbQHfntXNXBRc3mYTrg1vXmRb84zB3pmofT8O1fXTT5DrskEaBsamNZ2HgxRiEUDxzhNK0JRXvadnwUW7re0y0jQQaAOvltYiI+KBxEQYtxL07wjhbcEVrTlcC10hsXshkQS5/Xo1QIWcPTEvRuEsxoz0dXzjdq511ohqzTUX2AlmUljdTsaU/mVHIhDy/SjYut6nPPx8ON1yTup0BwL5P9Rn0CaTl5zCgDjnxE/Ubz0TNs2BSdw3UTH20YknO67j+kQMbsJCzhQFy271oNuxsaDR92OAL9I8yvcuAJ9fBKmsces8NYIy6PXxnZlwBxgAD/e6cStwBxtliMf+HooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFqFuulcnH5N9pF359cQNynyBzm64zf0zVOlnOsdurs=;
 b=mjt0t/9oA8yKxzc1omno0ue5wnSTHJaN1zt7nDnC6H8ni1OL1SU5JIjEOQOUTAW6mBVYyx/oPRWOhC8z6OqGyvEe2R+6qA1T6DU1eVFNQfFLne+X+i0GZMrDyOuLMHCAdpk1njNFLak9LN1PHzk46PngoIf5jnCYnoK2laGStCE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2768.namprd12.prod.outlook.com (2603:10b6:805:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Fri, 30 Jul
 2021 16:10:13 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 16:10:13 +0000
Subject: Re: [PATCH Part2 RFC v4 07/40] x86/sev: Split the physmap when adding
 the page in RMP table
To:     Vlastimil Babka <vbabka@suse.cz>,
        Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-8-brijesh.singh@amd.com> <YO9kP1v0TAFXISHD@google.com>
 <d486a008-8340-66b0-9667-11c8a50974e4@amd.com> <YPB1n0+G+0EoyEvE@google.com>
 <41f83ddf-a8a5-daf3-dc77-15fc164f77c6@amd.com> <YPCA0A+Z3RKfdsa3@google.com>
 <8da808d6-162f-bbaf-fa15-683f8636694f@amd.com>
 <b6793038-c24b-a65b-1ca4-ed581b254ff4@suse.cz>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <6c2eefa9-a7f2-399b-f38f-bfae580cdca9@amd.com>
Date:   Fri, 30 Jul 2021 11:10:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <b6793038-c24b-a65b-1ca4-ed581b254ff4@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0601CA0024.namprd06.prod.outlook.com
 (2603:10b6:803:2f::34) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (165.204.77.11) by SN4PR0601CA0024.namprd06.prod.outlook.com (2603:10b6:803:2f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 16:10:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a60af12-426d-4320-693c-08d9537482f5
X-MS-TrafficTypeDiagnostic: SN6PR12MB2768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2768D56DB795D4F26ABC2508E5EC9@SN6PR12MB2768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFRh0F3bQhG7Ln2f9alQot725+acdVmIbE/FHoz4U4IxlpXmLuFD2lz9shdpqlitw93J6Few+Wnszr4qDlYH5IrZBiOHWxtmRmsPjCcORxR8ihYvkPjMeGXZ2AxWw7HUqc1PnfHXoiD/zh98Oy4oPpUBNweVQ3nyvhRoEcJjma+aPVeI5sDdsOCFUbvpj2qDc5lvL+KLlcWtX4/Y6/4pw78qZqaMdluKQDmaTuRzHyJYdHdPyvv0JYtfgA+0yj6KOXbGrN5qb7N8hGGkYcisQ3N9z1wVC9tuNnk9nDUWTkPAjI8thxXz90/JumGX4o6e/Nt9WJG+PccHNi5rlWkbkSMj1IDOKrHYJvq2CJHpF2CMYo/HLe/rMTNJWlQNqk70YduN5YvCWmp1+lsrnMUkS+FPY+pof7XnTN4DdtdXRjnEL745W/mIPQvHDw8P3j3ZkyjXfRfkDS1eTCwJJNU3bsPXgBkNIkwXTOXXlTvMhuqQap78heTDwnVbcAyVrgDCFInT7sk0bM9PnKqE0M89HHKaAVHuoJx6qS6rhaA5SEiPFXUBHCcwA2JbzK4f+NRWGq70ehtrRB/ZBaGlL0ldsFi5uDoQIvhBBk8auM3gcLy9ViauS64yRSWu9CtbaZUOgcSNp90rXQbtEP2xZHqtAqUbj03G4iwdv9S5vfIWZirY+ve+SVthaChRzei7BLqR59cO25OZW8ZsekdO70f0K7EnJJPzY/R3jiGJuHjFihWUiCCTV5zMTvLWt82dvCucV+b5P2YKpR1KQHruXzmjYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(2616005)(26005)(7406005)(316002)(6512007)(4326008)(36756003)(8676002)(6506007)(7416002)(53546011)(52116002)(54906003)(44832011)(110136005)(38350700002)(86362001)(31686004)(5660300002)(2906002)(83380400001)(186003)(8936002)(478600001)(31696002)(66556008)(66946007)(6486002)(66476007)(38100700002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUloakVrTi9WUEpzSkhKVk1UcFhDaWZzUW1vYmEzWlBLWkpUWUlLd3IxaFlD?=
 =?utf-8?B?eEk0dmFkOEZsVHRFYXFTd1htSWgvZllGd0RMeDMyN2gyc1BPU0tidlJpTi9a?=
 =?utf-8?B?QzBRZElGcFNGd3RZc25nRzIySXNtV05jbldheVNjVlF6WXRHQ21ZbHlXUDhn?=
 =?utf-8?B?NWJmVnhtTS9mc2NDYzRXclFxQkc0MlMxS3I4dUhqMHpFRDRzMXFxZHRMa1RD?=
 =?utf-8?B?VmllRGJDQjN0RWFQQThDQkcyOW5CQ3dpMVROLytZbUpESDRwTmhSK1JObVZ6?=
 =?utf-8?B?Y3M2WHB0MmZxK0tWQnVPMHFHUDVLeWw1c1JxTWFLTEtad281RDRwWTVibFZx?=
 =?utf-8?B?Q1lSYTI2dm53NEs2eWtsRTVtRENRUmpxK3llU1NCTG1MaXZjOXozSlVUekps?=
 =?utf-8?B?UmhwTTRKRVNtaDZsWnQzWUgwR3cyL0xKZU01T1ViVkVkbzZMUWU1TXlLK0tX?=
 =?utf-8?B?NUZVaHB0Vnp6QzRuN3ZKeXg2ekx6Nmx3U2kzWU5Wc2NNZzl0RS82cXFzbWNV?=
 =?utf-8?B?Vmp3dUh1WjdJV0NtVzhoOTFqQVIwNENtNWJ4Q0FBZmFhRDREdGxyc25HSDRI?=
 =?utf-8?B?S2taaTV1ZXowakxMcUJuRWlubUU5eGNPQk11eHZRWXh4MkRyeHV2OTVGdmN0?=
 =?utf-8?B?bnhLZTI4MVFhSWs3eHhkNnVDaGZMRExBQ3V3S0o4NkJBN0szeTc4bSswd3pn?=
 =?utf-8?B?ejZybk9nUW40NURxMzd3ZHJ0T3BtbmVENUZxa1hRRjd1TWhHenYrKytZTmhI?=
 =?utf-8?B?cGZ5dDhXQUExSERIZU1ZOXVFNmNxay9HNmNuSUtNU1k0RTZXbnIrWUpCNjNo?=
 =?utf-8?B?WE1ESzRXanQyanRSMklyYjZPbW9YOC9iS09UVURYMmtlS3lGL3pDUWMxZWpp?=
 =?utf-8?B?RVlHNmlobmtTbEpJMzBsMUY0SEFoL3pxbFZWbjV4L1Uzb2p0VTUrbFNLWTBY?=
 =?utf-8?B?b0dXRm9JelBjekpHN3JYQ0FHUDg5Rmk4bXY3SU9wNXJMRUlCenQwaCtMcHZz?=
 =?utf-8?B?U01Xb3NvU0FQVFRaZnBHM0M3V2ZOQzN1UVN3KzlPVFZ4Z2RQZElwR0VTS1I1?=
 =?utf-8?B?OEY1azNMZ0h1MDdLdUpUcWxBSkJuZ2JzNFRLRTZXVjh2NFhxUmNDSllvdG16?=
 =?utf-8?B?WVlINVFXRVZDejl0WnpIdDFmclJHZUxTd3ZPeDFxYnZBbkVIK1dxek9nTWFl?=
 =?utf-8?B?dmZaeVBJczNyRmdQMUtUNG42N1ZDSFdkVkE2VnhkQjhsQ0NlMmYzbFcrc01s?=
 =?utf-8?B?ZEx6dVdndjZ1WVBsT1MvRTJEZFc0SXM0RU9ld1hZdXZyakRvUkthZDBBL3d1?=
 =?utf-8?B?MXVUVVdnNE1DOXQzUEtFaExHS1BSTk41WEZEY3BMcEQ2T3dkSEpkRGNkNXl4?=
 =?utf-8?B?MDVIc1ROVUpGSDFLU29iK2wxRkZWODdsemxKenZTQWJQelZCTG82UHhRMi90?=
 =?utf-8?B?TnlFZ3BqNWxWVk9DaWdTR0Y5dW0zb3pyMVUwM3dMeEliaWVvOVlaMFF4L0JG?=
 =?utf-8?B?M2VCZ0dqcURjbVMyMmdTeG1ibnEyZHVQOCt6UWV2VExkNlVVNlp5UHMzTG1Q?=
 =?utf-8?B?aTJ3S0N3R1NXNURzNXNoUWpPbVNrdkQ4SVRJaHpZZXRUZ0E0MGp5N1hlNlVY?=
 =?utf-8?B?b3FuMVlHYm1TODVrZ0YzSmFjVzU0TnFiS1JkUXVlM291U3MreFg2Smd5cWxZ?=
 =?utf-8?B?QVVhOGJWZEY3UnRsQW80eXFlSmhOYWt4OVFrTXRYMWNQZmhPa0ZpbldPZk93?=
 =?utf-8?Q?WgFQQ/EtkWj0V8o0pipoJwMNAlH2wDZQCmlItip?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a60af12-426d-4320-693c-08d9537482f5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 16:10:13.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gc0TZN++ZQUBfT3CH4tM77QxTyeWsgR7a7T1nwvHnnGBec+Q8ihItO5XaAOO9hsggUPNf/zTwtkL/050vwuEUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/30/21 6:31 AM, Vlastimil Babka wrote:
> On 7/15/21 9:38 PM, Brijesh Singh wrote:
>>
>> On 7/15/21 1:39 PM, Sean Christopherson wrote:
>>> On Thu, Jul 15, 2021, Brijesh Singh wrote:
>>>> The memfd_secrets uses the set_direct_map_{invalid,default}_noflush() and it
>>>> is designed to remove/add the present bit in the direct map. We can't use
>>>> them, because in our case the page may get accessed by the KVM (e.g
>>>> kvm_guest_write, kvm_guest_map etc).
>>> But KVM should never access a guest private page, i.e. the direct map should
>>> always be restored to PRESENT before KVM attempts to access the page.
>>>
>> Yes, KVM should *never* access the guest private pages. So, we could potentially
>> enhance the RMPUPDATE() to check for the assigned and act accordingly.
> I think I'm not the first one suggesting it, but IMHO the best solution would be
> to leave direct map alone (except maybe in some debugging/development mode where
> you could do the unmapping to catch unexpected host accesses), and once there's
> a situation with host accessing a shared page of the guest, it would temporarily
> kmap() it outside of the direct map. Shouldn't these situations be rare enough,
> and already recognizable due to the need to set up the page sharing in the first
> place, that this approach would be feasible?

The host accessing a guest shared is not rare, some shared pages are
accessed on every VM-Entry and Exit. However, there are limited number
of such pages and we could track and temporary kmap() outside of the
direct map. The main challenge is when a host pages are added as
'private' in the RMP table.

e.g

page = alloc_page(GFP_KERNEL_ACCOUNT);

// firmware context page

rmp_make_firmware(page_to_pfn(page), PG_LEVEL_4K);

or

// VMSA page

rmp_make_private(page_to_pfn(page), 0, sev->asid, PG_LEVEL_4K);

The page is added as 4K in the RMP entry; If the pfn is part of the
large direct map then hardware will raise an RMP violation and to
resolve the fault we must split the direct map.

thanks

>
>> Are you thinking something along the line of this:
>>
>> int rmpupdate(struct page *page, struct rmpupdate *val)
>> {
>>     ...
>>     
>>     /*
>>      * If page is getting assigned in the RMP entry then unmap
>>      * it from the direct map before its added in the RMP table.
>>      */
>>     if (val.assigned)
>>         set_direct_map_invalid_noflush(page_to_virt(page), 1);
>>
>>     ...
>>
>>     /*
>>      * If the page is getting unassigned then restore the mapping
>>      * in the direct map after its removed from the RMP table.
>>      */
>>     if (!val.assigned)
>>         set_direct_map_default_noflush(page_to_virt(page), 1);
>>     
>>     ...
>> }
>>
>> thanks
