Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9973EF1A9
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 20:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhHQSTZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 14:19:25 -0400
Received: from mail-dm6nam08on2083.outbound.protection.outlook.com ([40.107.102.83]:10593
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233601AbhHQSTW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 17 Aug 2021 14:19:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLeXo2vKyZ93r8BdHMTB4AzMPVYwHmcSo6WVszjqNHwEyMHzxpPwJCoVTnQFxZD43ULKnyW7COoR0JlA1Q/mdnz2GdeKiPqFbz8ebAbm1Z5popWc1zKAvBRDSchxCxTZS2VRPNP1PwmgX5rWETGRHDQqQ1kRLsCv6x/5FHPE5tqH6VV8ZIUA6YGgOHqoQUpLgMjV9LygNNX2W1ulnUT/PpTLibPFaGqMRjvyVbXo0MRxa3wXI73HxLkSMT01MeURAhZZFizPjSssMDrpWtV5Pf3YI4Z68/8X4ixmPTUqbvOh0/wGGjuzzWVB9KVeMZSfeMrzTZB7KtVoyxCWtinFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dllxahy+nhoJbrk+ulokSSVyEvibrCKzCYB/KbdGAyQ=;
 b=hnaD9jVlk5ajk++wGTukZyr3yuPNJlRohJscQd3X2ELvNBS2HUWU3QO5/bzbEbh+eOozPw/Xo1PNqbHkXd8l4D/oEwXFQ9wbwxqz16wLK2pi7N4jcOkhKWM9RsCPVpjUZvVbVbR4NxqUei4bY2kDPSYNtMStmzwcTtenqCdAnfwoJyc9zNDC0kFVHwuG5vS7ywaT8AcNoSf67BZI8m5juWrD/sFjGXEWoUVjJu50f45MF3Km2dLXyT3/3sgziypHhU4ApeEX3GS0EY4BXX+NMV1FCOpr944qbtYL8rfLkmGZM0FTs2+Ckk85emoc+uzdh5ZgGm3VDl9FEtV0cdckGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dllxahy+nhoJbrk+ulokSSVyEvibrCKzCYB/KbdGAyQ=;
 b=cQeLI4tE/WPGn732Nee+Y3pMJGCqrK8U8arNCsHwaZ0aqeoZnAJr01UjoxLKSOD7aiWywjZadL4fOZ0CYDbMmknJndabxJTtULLP18DhqWG3YpWRtAF64DlHeXq/K8/fOn1zBDsmCWr/bPAKlTuuLHszLXq+WZcMZ+ZIRdbNs9E=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Tue, 17 Aug
 2021 18:18:46 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 18:18:46 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part1 RFC v4 15/36] x86/mm: Add support to validate memory
 when changing C-bit
To:     Borislav Petkov <bp@alien8.de>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-16-brijesh.singh@amd.com> <YRvxZtLkVNda9xwX@zn.tnic>
 <162d75ca-f0ec-bb7e-bb47-70060772a52c@amd.com> <YRv9RNfvB+4ikmkw@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c7e917be-ef01-3eeb-0e74-d94fef834cb0@amd.com>
Date:   Tue, 17 Aug 2021 13:18:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRv9RNfvB+4ikmkw@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:806:20::35) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SA9PR03CA0030.namprd03.prod.outlook.com (2603:10b6:806:20::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 18:18:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4aa4823-ae68-46de-d974-08d961ab7414
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB436586DE32450E4F5B6B56BFE5FE9@SA0PR12MB4365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQDmMxZqiHOrA0puWcqRV3Euu5h3W4N8nwQtMS2KweSs0xKGc1RQ0HQpIW0cJ+LY0mMtaXv28N86yfXb0lksIXJ4x+aFNtuv9uhRpXmmHVVCsEtxVT0UOomWFNSm9EMaKLCer32TL7OiCt7MXF1TXb3uD0m5+FzB6NSpkXlHWA8lrf+w7XJx1y/qMhUUXHgcqfIjUAe65JRePGYvdvlYOx6eUCBzh/FijXAQtI0YqrZbHyoSEgRvjN6e9pLf/NuZUc5UkEToHeG9+w1ZJNGGQ9IIPZIlDtq7/DGXcYd3wV8Bcis/mbzYOD/H5mkC/xf7gjeKG6m6N45evfvk8xrDahTQOUSxGWJQi37K5PzJnQpKi0Gz1oQr5yCeeIYIMESvbNeq8Z7gqU8ddCWz8Q1RmIJR1kJHLTItEIIwmzj/j6CyZ49XEyNFFlgVR1qw6X9Ce1dz0er0bOF+TckR+lmsHXv4NjnG0y12X1PyhAKG/YwgNY9EzG6iR5JMXawn+UsqBHc8UuZ/vqAXEJN80XIQVT9nh38w+4L0OOZGs3BM0JltKV9/NiMbtcR/LwPvqHbVjOlEdM6K13t1C8MSzwAsKjAnTgXg3OHs0tLncvbUBvTBMj86+LNSJ7yySStC8p0YrvTjSAS4h7XRuEbk9yJMtPQP+L9UetH3LxYDvuDB7R0Tj5ttQDYw0sG0TGosL9KckwroTI/O6zj9VRU3wJkyu4ELtEvtqZV8KruM6VEW+aOT2ecuUUZsVX3fsQXKpiB02s7oH4ETTNkwJP4sI01pqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(7406005)(53546011)(38100700002)(38350700002)(16576012)(4326008)(15650500001)(44832011)(36756003)(478600001)(7416002)(186003)(31686004)(54906003)(4744005)(26005)(83380400001)(31696002)(6916009)(6486002)(52116002)(66946007)(66476007)(66556008)(86362001)(8936002)(5660300002)(316002)(8676002)(2906002)(2616005)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTROeXArSVYrMG8xQXlxbzQzVWRMdnl4blRweFEwY2tKRVY5dk03SUt6aUxP?=
 =?utf-8?B?ZGkyMXk4Z05DOGhlWFM0dy9lSUc1bmNNVDFyQSt2V0VKRmx3NWlBdjNxbDBX?=
 =?utf-8?B?M2RTM2l4L0xBUElPcWdrMEFYYjdvM1ptblNiM1pRS0MxYjdTRWF5R2JEM3hi?=
 =?utf-8?B?N1FaSCtQbDIwSmhPaUk3OUZWdWhYb1RZcDVQM2w3TkhYWEhCQm5TUlNzbmUv?=
 =?utf-8?B?V08xV3F6WkxGczQ5clJLWEd6Z2lSWmJzOFlVZE5uc3I4QytMOXh2ZWRtcmla?=
 =?utf-8?B?V2szd1FuUkkzOEJETXdsMENmM3MrOEc1bUtvcGFJQk1DdmNGSzRodHBiZU1O?=
 =?utf-8?B?b2ZRbzEreHlrSE9YY1FQVzZoSnRrbzhrOTFpb2RrTnV0WkNLd3lUeUhjWVZL?=
 =?utf-8?B?QUtwY2NhWDlhRHBNd2ZzUG1YMHNtbjFzamV4d1RQc0t1ekp0b0VPdFpzRCtw?=
 =?utf-8?B?S3BJTUVyaTdjak83bmhVY3I0R1JLNzd0L01DMDVVV3B3Mmg2QTV4aDhzZFNI?=
 =?utf-8?B?endKdHU0OWFyU3BBU2gzMUtqY2wxN25ZZmNCeGhZdTFCeXA0aDlNMzRhWlJ2?=
 =?utf-8?B?SDVFKzJVdEtjVWVLdkdsc0UyYUFXVXlFeFc5bUNpamd0K24rWllQemVwY21v?=
 =?utf-8?B?dU90aFNjc08xeENUSWUycE9EVWN4RkFybU9kOTRyWHllSTJTRHQyMCtYamMr?=
 =?utf-8?B?ajN4ZTB5WXFNZWJJRnZGR1hWWHkxWkJYVHB4Z1FCQ2ltR0NkM1FOa1ZLbzBG?=
 =?utf-8?B?NThQYjVlUlFldFJvd2dtNitJZFFJOC9hNVdiQ0c3d0FqenFGNTJ3SjFNZXlH?=
 =?utf-8?B?UkdBd0Z6eCtaWEc3eTRsQjNvNmIrQlpLaXFkVW9vVUZzd3pkRWtyNy9uM0ZW?=
 =?utf-8?B?ZHMvZ0pFajRFRlM4OEVIK2g0UnNXZ1JiWjZVQ1FCN2NHUE10ZFBlZDYvekZl?=
 =?utf-8?B?eTFDekQ4LzVwMWNpU2dCemlBMU8zNDQ4NFRva25DeFBPVlhTdml5YmQzVUVn?=
 =?utf-8?B?akVvNWd2dGsrSnlLSlpkNGxjMGNJSk9jZUpuUmFTYVpHTmFLZm1JTUZhczVq?=
 =?utf-8?B?TVBTdkJPQnFiQTVlY1U3RlRUYU1uYisvbE92cW53MmNpbGNtMWhuNTc4NGkv?=
 =?utf-8?B?QkNvUmZ1UlBtNzVtcXhQbFUzQWlBWFI3SmZWNVNaL2xJcTduNlYrdC9oM0Z0?=
 =?utf-8?B?TE9WQmRZaEZ6c3IyekRrQUltYkd0VjBYZkRoMzJQeCtoV1JjUjdwczNGQWsv?=
 =?utf-8?B?WG9aTzJFN2w3eXJpYVR2S291b0V5SDJSa2w4bERPbG5TM3lvUS9DM1NrbWhQ?=
 =?utf-8?B?dnhLcSt5NTJ6ZVN1YUJCZGJVRmNpRHlZMUx4aXV6QW9uaW41RnFYM0FBV3Bp?=
 =?utf-8?B?ZlVwSStOdjhHcXpoc0RWWWhUdGY4UkhYdm5wdDZ5TlNyVTJwcy9mMFlyb0Ey?=
 =?utf-8?B?RzNSZzFQYW9OSVVUb2dsWFVhamlQQ05Wb2l0M29GRGZ1c2ZoVzA3SzEyRHNT?=
 =?utf-8?B?TWhBeGpYcDQ5WVQyQ0R2MHJpK2g3dm9oMHZrMFQ1TkdjZ05SNHhYRkxDa1gy?=
 =?utf-8?B?ZjFlWFhDTW9wUXVBYmlrUVJXN3FVc014dWxWRklLNG5ESVBUMCtxR25CNmVK?=
 =?utf-8?B?ZlE2QStEaVhldmFKWVpRazZ2UzNPTVFnMmZhbWh3cVBQSkY2S0ZTQUloaTNw?=
 =?utf-8?B?ZTM3VjhGVFF2SVVqMklyS2R5YWtNZHVwMGZHOEhuUjAvc2E5TW8ra0FCbGh3?=
 =?utf-8?Q?1olUr4EBU7E+gbTm3u4LwvXOUIuLkpRDlEdgztl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4aa4823-ae68-46de-d974-08d961ab7414
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 18:18:46.6819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuL4E7d6qgEyHTqedMycvBT90UeNTDYnfyJ6+J5Y5eNdtq6iCYW0l7xne0MPVzz9grZbBoJ5ROqd16bnE0uNvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/17/21 1:17 PM, Borislav Petkov wrote:
> On Tue, Aug 17, 2021 at 01:07:40PM -0500, Brijesh Singh wrote:
>>>> +	if (!desc)
>>>> +		panic("failed to allocate memory");
>>>
>>> Make that error message more distinctive so that *if* it happens, one
>>> can pinpoint the place in the code where the panic comes from.
>>>
>>
>> Now I am running checkpatch and notice that it complain about the message
>> too. I can add a BUG() or WARN() to get the stack trace before the crashing.
> 
> checkpatch complains because there's a kmalloc before it and if it
> fails, the mm core will issue a warning so there's no need for a warning
> here.
> 
> But in this case, you want to panic and checkpatch doesn't see that so
> you can ignore it here and leave the panic message but make it more
> distinctive so one can find it by grepping. IOW, something like
> 
> 	if (!desc)
> 		panic("SEV-SNP: Failed to allocame memory for PSC descriptor");
> 

Got it, I will update the message accordingly.

thanks
