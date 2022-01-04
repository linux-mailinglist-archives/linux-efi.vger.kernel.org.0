Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860644844AA
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jan 2022 16:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiADPdc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Jan 2022 10:33:32 -0500
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com ([40.107.223.40]:61472
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233544AbiADPdb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 4 Jan 2022 10:33:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUX/8j6khENMY5vzsw5YoiMy8LfjT3YE+1K4d1UjSSEwfFmUOAd8TqT4Ubo/2674JfGSl2yxkVI2SDE4ebS5QZsUpZflOWxnXe313tTkI10YMvpprRxWynxidGXHRNGGTJFUHlEAaTI8NKdV3idiPUyUHSWt8RgErlHfhpoB7B6uXalLdrXDOLX6NnqiE9+9+yeoFlQNQ/q8CqMHbzq2N/PU7/XkoeAm/H0I3WT1fGrQ4R1siFGgDlt9bpBTLvmGTBFZNsxU3K1hdPIeQZW+W8ol4vKo+kghWNuIFGpr8XLA3gCEYginwZsnQ/aidkWiD02woelLyDq8TyE/wR4iqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5upEG5wlxxPh2WyZC0l7LSoL5LDx5adQymmbhhJ7h7k=;
 b=ogM3XLjUK8X4E8QPrbLn70cLx/Nt0OfX5BANlnV3UHpdNfGhXajIGjrFCNeUlLUETTwFda3eaIexFYFhxjVKmQQlmaA7KtBm6xdzrSeS4kx5fxjey/VhIlmvHI4hYKbIAYk5Y4tVFvnVD4vQbPAy1uWA0D8jR0hXZ72m1iV7iDIbRLapIZOVyb+mQ45R/74NoCvnkgy30wMH4e7Hoa3cq4BE/90+9i4VEnd/y26T6LkFiRAsoPfRdbZbC3zrt6rCoWKleICOFNClpX+bvBK+7jE+UIlLA7eAWWFIX+FXtv2/ybjHHa9NZwy7haXTpNiPI0JS8oJb1T0fGlSHyCDdKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5upEG5wlxxPh2WyZC0l7LSoL5LDx5adQymmbhhJ7h7k=;
 b=mugbfHGDm+T/mQuUN8xc5HdSygVOUzS1E77fXb28bp5beGcAKTxzQGJR7U+l7p81zpWtGzjBQu3wKtolb9dndVG+mU+iUIdW4zKLyfh1wz72t2E2Gy0QRQUQr3g/2/S5neTq0RSdBLyi4JfzPcVWZDJP9P/6wry/C5C4lMO3EAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2511.namprd12.prod.outlook.com (2603:10b6:802:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 15:33:29 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 15:33:29 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 12/40] x86/sev: Add helper for validating pages in
 early enc attribute changes
To:     Borislav Petkov <bp@alien8.de>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-13-brijesh.singh@amd.com> <YcRifo82cGk+wP+a@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <31826b30-a320-8392-96ce-829b7216e588@amd.com>
Date:   Tue, 4 Jan 2022 09:33:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YcRifo82cGk+wP+a@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0442.namprd03.prod.outlook.com
 (2603:10b6:610:10e::32) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c26f549-3feb-4c70-24db-08d9cf978ef5
X-MS-TrafficTypeDiagnostic: SN1PR12MB2511:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2511281B076D88632FFD4776E54A9@SN1PR12MB2511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmsQaGFQo9rezs41GqNSoOz74jsSPYBBN1rVp5axFpA9BwY4qYYBYY49RvIKkFQIdQ73pfLZzDacwBYBVteHolTxQtKJS2pb3XHQA2iqUOgadSuIvNbJooj1Aw0ac3JOe6zj6fxwzQrv+eE7RWCr6afYASZ2AH2i2mtNb5PMqztI/6hHHIUVevwcpLEZE4Nu97yNP5Yz8EJhfVq1zGY4fi68wVEFOKQZS74x+Tyuix8HdEdJw66fvtP0h1vzZp1z4hCrjoMkOT/3TchPRoRh60elQgnOsC7F7l7kqdWBzkTt0T9E2jPZUyY0eO1Ta530nBU209bYFuF04sVDX2pZrbngjLJQwSGcnyO7qQMRGDuFca4Jj8PC7ALpcFQC24XDtsuOipTcBPEfdIFYFDpQ+hR2aGRuJEV+lHZ7dUk0eqpMH+TwHtNQ4piVOnYlCeyldnL0rWDMb0gzDsH4QQTr2RkTP0aD2qrfhIJc/O+5i7GMZqLXOnpGAX6hBICPiXAPWMus3X17yT1Cbe80iefOlNSSqNnHyJwbGMrbVTVWC1QyL30uhwfHHKR3OitguXubdjwJFzuxKxoL5L1UHgaP4Ed9qEhajDahCYzlukoglKiv/0Mj9mE2F+6TAoGzw340hmfYaTIJBvI83yELtf3fBf99Pd3jJ/Qd1awKwOS8CFvHrxrHD6gVkY8FvyQEbRu0vMFiYgilNIThv9WKltGerwXUPTEQxpYv97pPqfIlcKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(38100700002)(44832011)(6486002)(2906002)(6666004)(7406005)(8676002)(66946007)(5660300002)(66556008)(54906003)(186003)(31686004)(508600001)(6916009)(53546011)(7416002)(2616005)(6506007)(86362001)(4744005)(31696002)(66476007)(36756003)(4326008)(316002)(8936002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVNzdUhCbSt4UUtqdlFCVGxZSHJyd3NtUjlIQzU3WFY5OFpCNEpzYUxuaWR6?=
 =?utf-8?B?bE5BaHh4RmNlSmw0L29YcnRsQ2NMcDVxZU00aDloR1Z6TWkySk5JbFV6ajRK?=
 =?utf-8?B?ZlU5UVBLYmk3Nmt4eTdkQWdVclFGbmozVUFkYml1dlNHeEdMZlJiVTc1NGth?=
 =?utf-8?B?dzByUU9MRXZ6MXJGTi9TQyt2UUdDOU5Wd2RIbGFncmlmUms2QjlaUytYakQw?=
 =?utf-8?B?R1pORTd0UnhZdkI1QkpKL1IwOWRFVFBOVzdUMTE5blVnTmZISUlSMEJ3VEJR?=
 =?utf-8?B?U1c5RUtTOFJmN2p4SnZEeU1sYTlINVd3QTUxdW1QNXpCMGR0ZWIvdmxiQWk0?=
 =?utf-8?B?R0NoOTRMQWNST3lkaGFsOWRGVGFCMEc0elp2QVVHQWFpY3U2QVM4UWtDa1Ux?=
 =?utf-8?B?bGFnKzhrQVEwYmxTcFZ2WHk3a1ZrNkdTRHdTNnczSXpZL1JUcjIreldKenNR?=
 =?utf-8?B?dWZPbFBzczBTWjNFNWpvRWF6ZWFIUWJGRi8vd2huRFVXZklIUmlPMWZpYXdO?=
 =?utf-8?B?czV2TE5la3o0Vy94WjBrYnZ1TldadEZkUVBocVRTSnBvbEJMdmR5Z3Q0WFdx?=
 =?utf-8?B?aFVVNUd2Qm4zTGZjRkdyRFlIekdQbXR5eXlGNHdUVjZ4L1FjcnhXMWFSRFRl?=
 =?utf-8?B?YVpFNHQvcDBqUTJPcHdXckdPL1B3bjZCYlNXWUw1QzlrNFVlYTVoaCt3MkxZ?=
 =?utf-8?B?eFJIdjgzRkJJRXNBVE5MMWNoQzcxSTRBSm5JR01rS2docFdzbk1uSjlLaWpY?=
 =?utf-8?B?OFZPR0NZZFNoT0hWbDMxL0ViVGJObXdmY0JUYzBYbHV0cUlZazZ5aWdDMmRy?=
 =?utf-8?B?aSt4aE05T0RWcWsyOExWQTV4eVFFU0ZKVGVmNTFORE9UZWZ1NmQzYy92R1hn?=
 =?utf-8?B?QXR4V2p0czhUbUNKMHRUQVpuWitIeEZub0dGck9xZWRWMFA3UzNMUXh6d0xv?=
 =?utf-8?B?d21VMHoya2tWNE1TNW9sYU9VL2V1bzMxZ3hkejVqZGFhdG9sTThEV1htK1JO?=
 =?utf-8?B?bEVYZUFoNnBWck1pcTR6VmdOYVVGMWNLWDJ6YWxWRGJqeW44NFFhS1VGYUtQ?=
 =?utf-8?B?NnpQeHdkd1hScnppNzQ2QTJ4elJvL3FRdXlUalNVdlVRV3QxOVgxUHBERTlz?=
 =?utf-8?B?c2cwMlZPWHgyeUVXZjlqcFd4WHdmaUhURWJteXVwSEZrVElXZFFUNFcyL0J0?=
 =?utf-8?B?MCtBZGlMUVJPYmdhWDJkSE92U1ZwcmhHbDlSZGZVVnNGY2lOUkVwaEpjZ1dT?=
 =?utf-8?B?TWVQZS9lY2h0QlNIZy9DQVpFWHFRYzVHZDlVMzdCR2k0UU9ETGxNTnpWcWVU?=
 =?utf-8?B?WW54VUlKQnhwQTVvcm9WUlpERkpkSkhWbk5Bb3E1T2tGT3oxY2ZTclFwem04?=
 =?utf-8?B?MysrNXJzMzc1SWpPajdBa2s0ZXEyakRFMU1hTmV1K3dxL0VPOHI3NDNITEdp?=
 =?utf-8?B?TTlVZkYrcUZUbUU1NnRsWWJUbXBOMk5BYXZpT1U2Y0p6OFlEWEMvVW9CT3hE?=
 =?utf-8?B?Z0UxcTBabVRMOFlKVTEwdFhiWUtYVWdabHVEV0t6MWlyRTFmZzIwNFNZaFNz?=
 =?utf-8?B?NlJZblJ3c3ZaTk10M2dub3JUSTNrbVVzRlA5U3dLazZpem41TkdhYjhndi9L?=
 =?utf-8?B?ckh0dEo5a2krRkRSeFlEN2YyczRXNVZ0R1QrLzB0aXhWTGJYSk1MNW82YldL?=
 =?utf-8?B?UEJOdWN1Vy8xcnRqeGZHQzY3akw1U0dPVTZ5YlZZOC9pNlBqTmViaStTK1hP?=
 =?utf-8?B?WlZLTkZlOEZQdDNCN0QrZGZFVXNjMnFaM0NrZU1QZ1J1SVRLVkdkM0s2SEY1?=
 =?utf-8?B?MTVrc3ZrVGZhR2NLQnZQaUM0VFAwU04wbHlhRVBkS1ZRMlZWT3M0L0RkWUNj?=
 =?utf-8?B?UjJncGx0V2VKc0hQSzZmaXZmVmZ4L000ak13Mk5hQ3RMbUY0Zzk0V1Q3akhD?=
 =?utf-8?B?WUsySFBiQWxLUVBHcEhQcmY1WlBEWWUrTmpBYjJlV3NkNE5xYXA0NEVTRU5L?=
 =?utf-8?B?WG8vdHk4M1N4UmhUMVN6VUltd3orMTN1WHpTL2RtTElSeGx1ZitqTXpaSW5L?=
 =?utf-8?B?RFZCd2t1b0llWlduQmd1cW04dGRQTFhIOWxiU2wvTWxFUUkwd0hodUJ5QlZm?=
 =?utf-8?B?TEpPZVYwc0t4SnZuOVRlV24rY294Wk84NFR1OEVCK0Joemk3Tjl6TmlrVTFw?=
 =?utf-8?Q?7yt140JRxuZMflNVlV5QDZ4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c26f549-3feb-4c70-24db-08d9cf978ef5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 15:33:29.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAVRPpFGEiPHG9wgyyTnXrFSiuv0cdOh8W45s1Gw1Zy+oK/Qde9jKXkem7mfyZcxL64Z28tuXIYhouJ4H2cxtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2511
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 12/23/21 5:50 AM, Borislav Petkov wrote:
>> While at it, add a helper snp_prep_memory() that can be used outside
>> the sev specific files to change the page state for a specified memory
> 
> "outside of the sev specific"? What is that trying to say?
> 
> /me goes and looks at the whole patchset...
> 
> Right, so that is used only in probe_roms(). So that should say:
> 
> "Add a helper ... which will be used in probe_roms(), in a later patch."
> 

Currently the helper is used for the probe_roms() only but it can be 
used by others in future. I will go ahead and spell out saying that it 
is for the probe_roms().


> 
> Yeah, looking at this again, I don't really like this multiplexing.
> Let's do this instead, diff ontop:
> 

thanks, I will apply your diff.
