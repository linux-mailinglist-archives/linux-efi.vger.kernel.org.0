Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39351470BC6
	for <lists+linux-efi@lfdr.de>; Fri, 10 Dec 2021 21:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhLJUYl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Dec 2021 15:24:41 -0500
Received: from mail-bn8nam08on2065.outbound.protection.outlook.com ([40.107.100.65]:22421
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234163AbhLJUYk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Dec 2021 15:24:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9yzkgDlC1oQWS4FfFEImE4AP83ujRHjTK1PZiDEumyqnVKjbh79M7QJiEb7uAf8plQySPYtrrDgiQFacAEu6Zg0s5+QJRcRDBOwyp97gohsDB8MP5kYF9xLGEz6Fix4DLIM1mEWvSHMlvANk/b6P+dbI0zLoWaHdRAJesOhk92b+yzGiT5+lbGeDoDVKI5HrrFq94MREorfYcor8lOKKIce+mzcZsf0DntpYVE3i1DVlJpn52khZvaHv0Tu7iSCjIEBaQggY4ksDVfwM5ZINC8Vyxr2hL2PupdzJFmUF23U7GdLwxeKhkM2rsj1qeIsTJbu7EkERd8BQ+kKQllYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udK3nWmADeiqNXArDAgTl4IreXxPvwMw9TpNtzEi/eQ=;
 b=oKwQ3LCF6k8fHiOqL1qXSubGQR6INVmQdYSMbkN/nFXriVGRYTHVMwb54LC3Tl+YF61jSR3A9ydM0vwhhCG6ZPUBXlNyNqIozMnTC6mVFpgECIoMUVdsGPHo8jJdQt1tb4EGdXh0tvvR9atZl2VHrjea8lTA1a7ZaoM32hoILlPxyB3rCxqiMSyit+uAGY++f1T+j7X+BDQ74MNPGmgUvbXvH9OPu8mtI0t68UBy0MOVOPeRNGk0mMIUMkXbps4ciaNwGGp/vk6Th8F+h8e3L8TRC+FBoswNRk352drmN4neLWr3h5SFkwC9W98dz8q5lDUO6b7C3opYXZ3tx8vlGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udK3nWmADeiqNXArDAgTl4IreXxPvwMw9TpNtzEi/eQ=;
 b=ArJ/6uRntjZl3acKUdENWe71MVIjrsrB/UHhjPRTWVvSD7EPH+MJEEMwhqiGAXheIzXC+6c0u44U9sYTkvo8JuFIanIcIxpwbrM7pZt1Y4cVezHm/EXgSeMip6g78w4mYQaZm0uOi7PXnGkQdZ+QGBPdinZFPhuuAjoAUfuGDLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2541.namprd12.prod.outlook.com (2603:10b6:802:24::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 10 Dec
 2021 20:21:02 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4755.021; Fri, 10 Dec 2021
 20:21:02 +0000
Message-ID: <16afaa00-06a9-dc58-6c59-3d1dfb819009@amd.com>
Date:   Fri, 10 Dec 2021 14:20:59 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 00/40] Add AMD Secure Nested Paging (SEV-SNP) Guest
 Support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <b22e13f3-aaaa-812f-da8f-838da9cd2e92@intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <b22e13f3-aaaa-812f-da8f-838da9cd2e92@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:806:24::14) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.0.0.6] (70.112.153.56) by SA9PR13CA0099.namprd13.prod.outlook.com (2603:10b6:806:24::14) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 20:21:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27a2a81f-268c-4070-cc12-08d9bc1a960f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2541:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2541BC3B7E0F818EC2CB34F6E5719@SN1PR12MB2541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zSfzPiK5JUTMoCtBVRXU+tqsw3ShXQyhrst7t5gBkkM3XaoZ+dkfZYkwMPP59PktllmMnoaIkq+ZlGgMEqD0WsHYCAqE5lZTwIL2KqSGTJzJv31x4tu04Tf2Lj1QRistvWXYP3rbPiYgA3XDF0V25dWVreW6vGdzoh/fmo0fA7UiSf+n9XqVCNOFe7e9KzPAm2mvENedmD16cXdurtZag6GTf+nH++Fk4uDrgMbv1DnPSS4RHy+laIZRaB4ASemWcbDYFkK/PqiCANyQLqACROn3/s2yMtDX9Tvfg1wGsO4bbl4p8YgRN2GO6B9YMN10OIC5OW2NPYmB3i3aXLQ5+xy+e9b8rIRraZMzJW8e+6SSxlhxuobAmMyZn9EBA//rexCmbGZa6Ji1Fivyf0OLgT3ZMSlAXQSJLp0UfTz7qkwbXFDNNZCNOcMlyBHiaFQmcXLTagTSHISuKKwOJa4ic6o6rdStpagj+Yr19TGGuIaC9CIjLXYDKQmHQ996bn/LTPfbFDyehPiYo8k6V9K0IPDnFklkz3SU2UaR9mk1LxV7pCnSALgjdvzKmXiFTZRvYEgzVsVarG3o5EIxOlSsUP9+6LabMySWqNaaaNtTzxx4rRixjqxCsBcd+MaXICEZi+shs7GsXrSRawQz/klMwPeZLcMNvj6GZrrOfLAxGswCoL9ovLJw/AUdJWd601owFPsXxd04G2um4iin3kVbLb2uQXkOpwfpZqinchGuLBtbkdYIboJ2aN7puJeu+ufwAifBXZtsaE+lEXal0NybiP5XnG9tIcQYtLDGtA6kIoeDAeZFrFof7ajKQ1Essg+Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(2906002)(86362001)(2616005)(4326008)(8936002)(31696002)(8676002)(36756003)(44832011)(26005)(38100700002)(53546011)(16576012)(316002)(186003)(6486002)(54906003)(7406005)(7416002)(966005)(5660300002)(508600001)(66476007)(31686004)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N29CbXhKcWREM3BteUNZMHZaMkN0cnM5TXN6U2Y0L25hR3pEVUl3eWNCVWR3?=
 =?utf-8?B?UTdGdEhEOWxMZmNLR29QSU44UDI5MkxudUErL01Bd3RHVnExMHZyNC96V2pL?=
 =?utf-8?B?ZlRrLzJteUpabUpqTURWTHhNT2ZodE80SFpicXNCeUl3OHUwcjR2VmRKODhZ?=
 =?utf-8?B?bTlHNkUwdS9Qc3dqd0hQc2RQWG85dmNndFZtOC9pQU1zSk5YaEF0Vmtwczdi?=
 =?utf-8?B?WkRTZGY3UTRwV3BYYTNibnRvL1VRUEZmQThjTC8rbDNvam1yZi9IWGorbmFZ?=
 =?utf-8?B?dVhZSCt2dzMzUldROU1jTlZwS1F6Z2tNUG5zNlNEa25Tc3VpRzdoS3dGbGpX?=
 =?utf-8?B?RVc4dmZCZ2wvZUVYU2U1MnJwZUN0VXMwM05SV2NmdS93SS9oNFY2Wk1HWm52?=
 =?utf-8?B?aDFkcWo3L1gwa1NGUE5DK2RqV2NYa2lGRFB4cTAvcGU3T0FrSmw3R0pvWkNy?=
 =?utf-8?B?QU5URGJKU2lpV2JQaklFTi9lQ1BBL2xZd3VuWklHY2pnUnN1a3J1WmhBUy9s?=
 =?utf-8?B?b2t5NGRrclRCdjhPbk1UNktKNmp4QjVlREh1SC8vY3ZRV04ybDBIY24yM09N?=
 =?utf-8?B?ay9GL2twbDkvK1F1SXMrZVh3OFZLc2pTOVQzNWlOM2pFbmJabW5xREF5dmIw?=
 =?utf-8?B?a2x5cEpwZDladjZtQk5TcC9BZFd3N2pzcWR5SnMrV1haLzY1WFF2MUc3akxK?=
 =?utf-8?B?UEZWZjJTcmM2VG41eGVxYkhBKzd5VUVLNXpxNkxybmxMMlZ2dysxMkxwK3hF?=
 =?utf-8?B?d21nbW9rcmZtUlRuS2MzcU04ZCtXcit4cGpJdzFIUFJKVVRiaDM2YTFYY2Iz?=
 =?utf-8?B?Nmg1SWlhN0h2NnhmRUovdHlyU1VIT003bmxub0NQb29iTnE4MHhGeUoxeUpq?=
 =?utf-8?B?Yk5PVE1OZFhHZCtOYVNRaHpLNCtaOU1MS1VxMHc3Q1dhYUFGRnRhWjdzWm5s?=
 =?utf-8?B?bE8yTFNQQkN4TzNtQlFHdS9qZEcyallnQWlKL2ZNTWphTURmRUxUQnQzVWJF?=
 =?utf-8?B?dVUrYVUyNlhaQU1mT3BMREh3Y1d0aC8wRXBCYTc2bldEN2FVWjZ6RW9xWVFB?=
 =?utf-8?B?bGpSREYwV1hxTld1M3RlazlGRmhpZUVyM0swbnBWVzRKdklNWmp3OVNWL1JI?=
 =?utf-8?B?cnFHbzJmc2MzKzEydFBlQkt5Y0dYa3Q2VHMrak9EMkpGYTE1dUpYQ1hkbS80?=
 =?utf-8?B?b2o3TmN6N0JvZ29BVUQ3alNGeVIvTjg2QS9jQVpBb2h4dm9hMTFGbVczUG9Z?=
 =?utf-8?B?TXBTaUV0cUVuSlVlUUYzVTczNWVqMmtFYmg3M25XYXZoTnk1aDE4OFIyeXBq?=
 =?utf-8?B?R0RwUEFjZERyQ1ZQRDU1VSs3cnZCd1NxUWdSTzRFek1tSHk5dHk5MklaTG1J?=
 =?utf-8?B?bWpYQ1M4MnlGN1F3R01BOTluTVJaK0NSSmJHNmVIT05vd2dHd0NRU2JwQVZ2?=
 =?utf-8?B?cGl1Qnl0c2I0SE9yb0tpN2VoVlBPUXRpTlltakJQVEdZQldSZlpMQXJKbXlx?=
 =?utf-8?B?eWNzYTV5eEJVNHNHQUJaR0h6enFCSjNpdE5jSTc3TWJaeU1hWDRHVittWHIy?=
 =?utf-8?B?T3hRU0ZqeEJsOG9najYzZUJXK0VJNlNWY2dkVk9PdmdaVXN1aUIwK0N6NDVL?=
 =?utf-8?B?WDNqaUpPeVlxNGVhVHh1Q3IyK0lEazkwZlRXb2dHd3dFaTVYcHdqZ1pqaVJD?=
 =?utf-8?B?TzVRMmxhSytDYjFsdml2ZXgxQ3JhdXp0Wm51RTQvV1Z0cXlCSklYRHZLV0hB?=
 =?utf-8?B?SXY4eFU0UDl5RnJuZ1JUYm1CR2M5SEhhd01IWE1CbklUbXhWZ203NDZ4ZDA2?=
 =?utf-8?B?SGtyWDA4VVlJKzZ3S2dTUk5lS2VUTlhwYVRiMGpHZjhabzdlT3FmNXRqb0tX?=
 =?utf-8?B?SXBNWm55SlB2RG54RnRxOUliSWVKSytSWTJlcGdMWnBoUzRkdnJHb2I5Y3pr?=
 =?utf-8?B?bWNvcHR3MTM0NjYvdWVDdjA1eXRVR3QrYzdzd0xoeTM3WTFOTStSWHI0VVlH?=
 =?utf-8?B?UlA0NXpjZGtZTTBSdEVTOHloTENtYithUkhBbllrYW9DZ3NYbnZpTEtsMkJn?=
 =?utf-8?B?aWt5YlNFSGpMZ2h4c3lvaDVnWVBpUGNqdHkvcW4wOEtwNGJvL1lUcy93Z2dG?=
 =?utf-8?B?dFYwU09lTUdjNEkvM0E4YytUR3ZBSk5QdUhHRmRvK3k5Slg2aGFLaUJ1aVlG?=
 =?utf-8?Q?Nir3zIU14HzEQuIXvJroXmY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a2a81f-268c-4070-cc12-08d9bc1a960f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 20:21:02.4144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y5lRQPYVcI8Nqor7JB+lIwCCDIsVP3W7mTVSaqSK3LbqhfSdkw4k99sN+1mods3/N8JdN0JZLcAREIMhiANFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2541
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 12/10/21 2:17 PM, Dave Hansen wrote:
> On 12/10/21 7:42 AM, Brijesh Singh wrote:
>> The series is based on tip/master
>>   7f32a31b0a34 (origin/master, origin/HEAD) Merge branch into tip/master: 'core/entry'
> FWIW, this is rather useless since tip/master gets rebased all the time.
>  Also, being a merge commit, it's rather impossible to even infer which
> commit this might have been near.
>
> Personally, I like to take my series', tag them, then throw them out in
> a public git tree somewhere.  That has two advantages.  First, it makes
> it easy for a reviewer to look at the series as a whole in its applied
> state.  Second, it makes it utterly trivial to figure out where the
> series was based because the entire history is there.  The entire
> history will be there even if you based it off some tip branch that got
> rebased away since.

I thought I mentioned this in the cover letter, but I missed including
the below information.

The full tree is available here:
https://github.com/AMDESE/linux/tree/sev-snp-v8

-Brijesh

