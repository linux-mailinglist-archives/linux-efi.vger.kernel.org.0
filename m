Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F134C3CEE79
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354257AbhGSU6H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 16:58:07 -0400
Received: from mail-dm6nam10on2070.outbound.protection.outlook.com ([40.107.93.70]:13537
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1385308AbhGSS5A (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 19 Jul 2021 14:57:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEyNQSeZgtuwFSRnUJ1aaAedIRZVFQ8Gl/QgCSbKUvo+YBKRjFw3vL+53VkDtalxWtVu6/ckakLp8F7lxTzgCwz2waQc2DwWrBmONWf0nNTp+9sxV5dmSZD2iiGdtZv7Jz6fm34w+LzCsweMglpGxDRE2iV2SpyXu+jCjb60fNlsGCmaL9RvdX2VhTvrsZCSMjDYOnZeBLlHZlSGanc8GtKHb/W7pxdKL7ivs1ZSIYIQ7kblvThoA9jE6gLseTRFplbgBJkZgvYVp4leE1aTogS3KTIODi4VAXNSaklr/+q4afmrkwptJ74JwEGXb1dYRDvccE/W6dw2qKHTZYZ+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wMvZTV5rPjCUuUZAYdwVG8LX3dNsIAM4G9dWOGLqt0=;
 b=O4ZGkFbJlEarAiHI9sJwyk+xybJFgtjxcA0TUK+9ZRzRT8lNILL40+28qgzdQXlNwXCoCKuN1eKWMjRPBzEmF4d5UQ0uhKulupH90Iwrz9SRQbPJs4oqmJVXCyz6f22GqqaB6vyQkU9NTlvlye+IK/PcmB7dGB3KipA6TeygtGycLhWDZiwnEWAtHJn3EV1CKUM/aW9fPbifbidTXMwwgukutBobUO9lpiMlQ6UghHx3I76GM6Ih4AFBe5zayMwLLTqKvW/X5Ncor9RoSrZoakrpeHD54ampjLyw1g3wjKw++5Bjh9vF1EXvT5+nPUEBtZbbIVVuuzn2BUCg0zcNPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wMvZTV5rPjCUuUZAYdwVG8LX3dNsIAM4G9dWOGLqt0=;
 b=Q5XBNuIqwYaN8ZRIqVV3a+IovD3akwVFEQtep/dkbTIHeUk/ACQMPn/gNltj4pc1/BtYnKyREaESaGmuwL4gY0HIEOX229gMlQIcE0sJl5SWK+7ps/8RDNsXuVC2Fn2D7IvzlziLvbRvVHWKNdvYm8SYe6y5DVHTYcTJhE9C3Ms=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Mon, 19 Jul
 2021 19:37:08 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 19:37:08 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 25/40] KVM: SVM: Reclaim the guest pages when
 SEV-SNP VM terminates
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-26-brijesh.singh@amd.com> <YPHnb5pW9IoTcwWU@google.com>
 <2711d9f9-21a0-7baa-d0ff-2c0f69ca6949@amd.com> <YPIoaoDCjNVzn2ZM@google.com>
 <e1cc1e21-e7b7-5930-1c01-8f4bb6e43b3a@amd.com> <YPWz6YwjDZcla5/+@google.com>
 <912c929c-06ba-a391-36bb-050384907d81@amd.com> <YPXMas+9O1Y5910b@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <96154428-4c18-9e5f-3742-d0446a8d9848@amd.com>
Date:   Mon, 19 Jul 2021 14:37:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPXMas+9O1Y5910b@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0801CA0021.namprd08.prod.outlook.com
 (2603:10b6:803:29::31) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0801CA0021.namprd08.prod.outlook.com (2603:10b6:803:29::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Mon, 19 Jul 2021 19:37:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3abf014-8626-465f-5c03-08d94aec9891
X-MS-TrafficTypeDiagnostic: SA0PR12MB4510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4510E8325701D2072FC0D877E5E19@SA0PR12MB4510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOTrrlGNp3jmUiXs1U23F1cd8W5L36eWlyngAmjAJ7FYrWMpmaLF25kUpH6+ouFpiDMHTXYp67IN8TH7N/ToGBLDiF8M+tF8SUPzEn5s255nU3/pWBA6wpWhUBbd9JOuG/XhXTArLx/Hl5IdQZ9B0/RL4bKW0CTlSpshxWmcNL0pO5mj9QufUyg/89byThyOpovIRbGEWc1j5aIcq6CeBNhvTnlbK6okUa6YWog01fSPwp0+JOPVaBltrb5JAt4Ymcc02J8rMFwmuTOZUtGNYp58ANdFAcPaINZtyOhtEbB1FLXR8jMq8+QwwC7LTAetmjFQ4knqFMltR8cfMDv2AdxSjVGdIrmcA5SmvtuCrYFd2ckuGFXr13W/9Xk6Xf3Wt23UJeSlXvrgo+a+jJM8aeFDIfRZLPmoQj+4071YF2eJ7FQ55PQ25IT6e5L1/lfZhJPp/axC53ifX66uuY6SkopIbXQ9ct6w1lGbWW6lc2DGce0Ok7N71Eic3bbyH1mAXl8t2or2U4smW628GmQJMvgFcJxeDAAXcCnPdrRSafwHYhgIJzkznPQLrgEBkIrwhkZ004b8nabOakf06zy+B+06RZoe4EnE8G3JCGIU2dAEBg6OzrE6qG6rCOzMI+wH1xFLRAwK5ZBWAdsS33Pev0yhJvEYzRjH/ZNjDe2hsDX/OrUyEft1JSs75D7E/8q6X3F0PZ08Jp6zhxtM0a3pXhWOSyEK7cwil6gkXmHPAeLsbXNyiWhy5gO6EKcm8ONzH/6L/baFuExnZ9tSeTGS9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(186003)(5660300002)(4326008)(36756003)(26005)(16576012)(38100700002)(508600001)(86362001)(2906002)(316002)(38350700002)(6916009)(2616005)(7416002)(53546011)(66476007)(66556008)(52116002)(66946007)(7406005)(956004)(8676002)(31686004)(8936002)(44832011)(6486002)(83380400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlI1MUVEOFNid3ROOVF1eTZrM0RvUlZ5bHJCZTRtMWRudjdnd1JuUWkwVVR5?=
 =?utf-8?B?Um9acHpaRXVHUHBYZjlnU3pRc0sraXk1am1ndmpOL2hTd0txWFN1NGRMaFdS?=
 =?utf-8?B?SDZBcm1qSjgyM05LbTlCOVRtSEhydHR0Y0pxOTcrbExGZGJvSUZBYnpCYlN3?=
 =?utf-8?B?ZFc0d3VETldMVzNxeC8rejJDaWxvWUIyV051a25MNWVrNlhkbmdRS2JRUy8z?=
 =?utf-8?B?WlFKRkVsUEFJTlloazBrN1RzRGovc2xXbDZKa2JTQlprY2FrVXV6MUVkWkhT?=
 =?utf-8?B?NDM2emR0bTdmRmNxQUhranlMbkM5RmZKeUx0QXNpSkRaRnl3ZmlHRmNhMzZl?=
 =?utf-8?B?QVRRZkwvTFFZVTFWNHExemJzQzZiZkJLOE4zUGJYUVUrdlZhMWFRelJ6TGlB?=
 =?utf-8?B?NGY1emxtUDhnazJqZWZlRHduclo4R2l4dnlNdzZRSXlXZk80VjR3WGxmUG9l?=
 =?utf-8?B?ZHlSZU5mMi9jYUFSUjk1TmN0ekU4QzBJRDFTdFRtazJoZHNjbTFOQjlQS0Np?=
 =?utf-8?B?M2szN2RSb2lzUVJaNmhJWkdDSllqQzN6cFNyUHdBQTY0UkxhalovTDVxM3RP?=
 =?utf-8?B?b0dUcVR6MXFLbHAxV0N2U3BZcUJ2WHZUTjhuaytWN1lMc3VKR05aLzlqcUZ2?=
 =?utf-8?B?Rnc0T3hGSVV1UGVaYU4wTExpY1F2WE5Ld1p6cExqL2hDamVmcVFmSFhFT1lB?=
 =?utf-8?B?aVJxR2k2eFJ5cXJtK3N5eVNpbi9KM3JnZXdBMzNWSFdqcWV5YjNzV0lkTlhX?=
 =?utf-8?B?bExlS2ZKdWVPSlQ3QzNUbnRVZnZybG40NWFKUkpmT2V2WWh5b29ubkdNOEFk?=
 =?utf-8?B?UmhDMmxKaTVYL0tGOEMwRWtEREs4YXNEaEdHN0xUbWlYTW56VUVnY01tcDRI?=
 =?utf-8?B?L1lWZTByU00yVHVkOFFEL1A3VUNiTmRLSGxjSUhOUWFKekZ2V0N0TnhjTHBS?=
 =?utf-8?B?bTVEcnJ6SEt1NmJycm5tcEhyNGpxTFkrN3JtZDltWG1ySkFFV3B0UmVhZUVY?=
 =?utf-8?B?YWlBYUhUZk5aS3cwSm00aEZYcXBlUkExRU00NmVEUVFkSHU4M08wN2JnZ29p?=
 =?utf-8?B?UFdoaWxsakpSZ0Y3TGEra0dkcjgwZCtlZWJ2ZGFyZHBvRHZrUlFabjljMnFi?=
 =?utf-8?B?RXJjdnBXNndOMXlPa3F4ZXora3FJSFQ3N1lQUFZCQ1VtL3VMSjdjai96L1li?=
 =?utf-8?B?cGNTbk82Zkt5U2JyQnQ2QmV6QU5KR0UxbGRhdWczWVlFZHFJdlJjSTFGWmRV?=
 =?utf-8?B?TzNaZElhUGhLdTM2MTdBbzF4SEZZNHRaSUJvT1hLZSt4QjBVYlc1WTU1QVBx?=
 =?utf-8?B?cFVKMmNoemxYeHUzRTJZN2xNQzRQc0pqbTNyd1BJcHZjMmRJQ3VCbkhlL3g5?=
 =?utf-8?B?OWI2Y253NXJQOHBMM3F2b2M3MklLd2RXN1hPdjJGa2xIZWwyZjQvTHI0TlZW?=
 =?utf-8?B?QkdkS1pJemtlR01ncmJYSGkwSTdtSCt1S0pDSm5xU1NqZFdFQ2UyS29lWVF3?=
 =?utf-8?B?M3VFY05lWEhqU1kxeE9wdEl4eEduR2ZPa1BmTnpTdW90U0dKRS9mUEhYWWhw?=
 =?utf-8?B?SEtCWU9idkIxbmJEV3ZVaVhBUm5KblVxZ2w3cEExNjdBaVZvaVdiSm5yYmNt?=
 =?utf-8?B?UVN5OXQzTmVpWTNEeXR2ei81dU1rc1p2NE1OdzNTak1yOXFMbmhsYzNhOUpx?=
 =?utf-8?B?U3lKalNwSXVPZHQwbnB2d3N6dkRqWHhZOEhwOWNRb2k2dTByTHc4ZkRRQWdq?=
 =?utf-8?Q?GMGLAnHjBG1kU35YzuVyBTm6hVbT9BfWCekUirr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3abf014-8626-465f-5c03-08d94aec9891
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 19:37:08.4814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wrc/7VncIRCsrkmJ1ENQKaaTauxr97qriORKcf3W7CiXRQFibDrecXueoUB3WLNR7dusfFP5B+NmNlKEZmnyhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/19/21 2:03 PM, Sean Christopherson wrote:
> On Mon, Jul 19, 2021, Brijesh Singh wrote:
>>
>> On 7/19/21 12:18 PM, Sean Christopherson wrote:
>>>>
>>>> Okay, I will add helper to make things easier. One case where we will
>>>> need to directly call the rmpupdate() is during the LAUNCH_UPDATE
>>>> command. In that case the page is private and its immutable bit is also
>>>> set. This is because the firmware makes change to the page, and we are
>>>> required to set the immutable bit before the call.
>>>
>>> Or do "int rmp_make_firmware(u64 pfn, bool immutable)"?
>>
>> That's not what we need.
>>
>> We need 'rmp_make_private() + immutable' all in one RMPUPDATE.  Here is the
>> snippet from SNP_LAUNCH_UPDATE.
> 
> Ah, not firmwrare, gotcha.  But we can still use a helper, e.g. an inner
> double-underscore helper, __rmp_make_private().
> 

In that case we are basically passing the all the fields defined in the 
'struct rmpupdate' as individual arguments. How about something like this:

* core kernel exports the rmpupdate()
* the include/linux/sev.h header file defines the helper functions

   int rmp_make_private(u64 pfn, u64 gpa, int psize, int asid)
   int rmp_make_firmware(u64 pfn, int psize);
   int rmp_make_shared(u64 pfn, int psize);

In most of the case above 3 helpers are good. If driver finds that the 
above helper does not fit its need (such as SNP_LAUNCH_UPDATE) then call 
the rmpupdate() without going through the helper.

-Brijesh


