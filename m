Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E49347D42B
	for <lists+linux-efi@lfdr.de>; Wed, 22 Dec 2021 16:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343682AbhLVPRG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Dec 2021 10:17:06 -0500
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:62336
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234907AbhLVPRG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 22 Dec 2021 10:17:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msxZrcTn8KyjlKZQFzVVF+XiAq0RIfykAtaCZyAyVrL/LeQF5sFyztPFoqPE0UBJiP8AmvdwTfxkdv6X9uyQfd0wie67sg32cqfrAVaeqqxcRQpk1Mj7NHJ+4nKwPog4gH5dC++7yVae91WZqaQtJjREd7a+NqUo6QQEbspYPNgjj1HfOO+pcguIumIY4vmGIVKp3WU4Bf7gjuz1vDm7q5Ca9rxeK00hhcRy+FuKd+DDAxDCwPysHCZO1FN2sG9+2rZ82Ct9DnKQJZ731KTOqj/LOKox0q9NCbkgSC/aiNH3bU8Jz9v+F0hdbkB4XOY6s6DZ7WyC/UY14mopEbNULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIspO+Xru37NtcSTf2uQVpSGeEn8lH8hQ/vi/jEQ+XI=;
 b=Jjz8H3zqBUEqrgkjl2AHpvgqsJ/IDf/zqL5rmNOu2newe7snYkXGDPNEO4WbvYmu9lz5+xQgyEwChUW229uUv8d32S/dO2/AaHZY44B8sUFUjyGEBo7NnIHrhb5Fgoyp7Yqeav60bSSukecrVF0Abu2Dz4Jiw+Slov6ypVSM2dRtvnwSJZOxxUMNqdBZjlA5P1T3+6clf0j6FW1jNtMmeqcKnKhYXzaL7bZ8jSusSDQS3T1bXpNkOoTvlf2to5ng/3/aKn+UMhU3jLsLBHzXQ5i1vIs+OjQ15zkCPtm9f8sNhGbis5WHjS6+vSZ7qIV85R1Ho57AOYoLLdOkVsSPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIspO+Xru37NtcSTf2uQVpSGeEn8lH8hQ/vi/jEQ+XI=;
 b=whDFyuweNFxBusGUeDx5l0HMPzBK7GX6Z9SGNWyLO7PQvIsx2YM28J9fS89jG7m857q9Y+DkT8G/oeF9VkEvKN8YQ5Wpmbq3G806NFMmOySbU4xFvDuNGTRFdXghZIxAMS7Dtbh3qIZK2mjR5YUdJkuAk0XdNOKBm+vnUzbQC9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2784.namprd12.prod.outlook.com (2603:10b6:805:68::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 22 Dec
 2021 15:17:00 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 15:17:00 +0000
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
Subject: Re: [PATCH v8 11/40] x86/sev: Register GHCB memory when SEV-SNP is
 active
To:     Borislav Petkov <bp@alien8.de>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-12-brijesh.singh@amd.com> <YcMlOOPp2rTFKkeW@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <7cedae5f-96e1-cb37-1ed1-6f8e7a23868b@amd.com>
Date:   Wed, 22 Dec 2021 09:16:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YcMlOOPp2rTFKkeW@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0021.namprd18.prod.outlook.com
 (2603:10b6:610:4f::31) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45d970e0-2a05-45d5-769b-08d9c55e19c5
X-MS-TrafficTypeDiagnostic: SN6PR12MB2784:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2784353C69FB2C77AC6C2041E57D9@SN6PR12MB2784.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWFUamf/OCfGJI0WB1RJVmvE8tBz4gQBqvTEmHMZmy/dvSxP0vnu4Btkq8OhcSIUOfUjSKFVqYwiRF7JUGSYX7nJP2pSAztJ4HNp1M90JPBmNv5/mVMFyXzHvGMyRqQuBQkMmPg0KP+7g7xDQhZ4s43Sfj7xWCRbEZ9bo54p82zZ6fYirrUkmWa9X8MmB5thfuSq+YLPRnTRSgtbNv1aXlpxsFQbyj48bsWsSIXWmpQAgnNx27AADb/jOWXvZzbaVF1UigLfz3Jk3G8ppNftVD3dnbuitDF2fiGkaZFxppemktuEL7F/yD0TFTscI25N9OmI4snEw64QxPezRhqh2vBj3WXBm7jayqVAqzqVRFkVK6sfhBH7q9sAg0gpekH1jmiwooE1DtbI0/dK4DOj6jxPJ6u/wkP0H3934Tnd7Dzgm7ytXlyX/f377mGzzf825RbOvJIqgQZWf3FbkGnFG19ShQXbByn0nYKPLnu9zcJKSX8GR6Dus+YyKrkUAIHTJFjE+pIiH2FeQ1t1QB4G5IcsovNHELeeDnCummoNjrSJ+ZEzfIXdIV4zEe3aj4dC7Tvqqx3O5SppBtNvtCzsnlQeZeP8ooWDV8DOOgGZ1+Dasx3Q9ZeaX7ZebbHv9+hyWBTXIxPTSnS/wFvlhXgXd58ZXc5h0YDFKPsyOIoS1bFMAPtgd9mHIAZjdUoaMkzN/0WzeN0oub2G9GX/1YhqnbzlckZBZl3YWv5LFOOIwyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(66946007)(31686004)(8936002)(6512007)(508600001)(66476007)(66556008)(54906003)(6486002)(26005)(316002)(7416002)(44832011)(6506007)(31696002)(2616005)(38100700002)(7406005)(83380400001)(5660300002)(86362001)(2906002)(6666004)(8676002)(4326008)(53546011)(36756003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a21Wa2R6MEtacGx3czc3bndJYmRJSzFmNG1RZ1YxQzRLdWJFN09IbHJZcGND?=
 =?utf-8?B?MmZ3N05kMEpaNlQxbFZ6Q3JYZlhHck83ODJaYWV4TXNtWExsOTlKYW5OSCtL?=
 =?utf-8?B?SWFpK1NDKzQ2dUpxSkhJNkpoSFhnY1k5ZFdEaFV1cVViUjdIL1pCVW5SZUtF?=
 =?utf-8?B?Skl0TjVlc0pUNkZPOVhBN29CdkE3NktKanp0b3E3cnp4SUV5L2pWN2ExVll1?=
 =?utf-8?B?M0F3cnF5TG00dDhmdU16NGRWME5YWWRWVFQ2RkFLMDlJRlpoYnRxNXZFV1Zm?=
 =?utf-8?B?eTBPZUthUEN4WGNVY0hNVnRlS2hmYllaRmh1Mk5jZXdOL05vd25FdDFheTVr?=
 =?utf-8?B?U2M1M2o0OUdNR0lRQS9KS1ZhTjN0a2g5c3g4K3JXQzVHQ1VKUUg1WXdVbXBs?=
 =?utf-8?B?bGhPZUYrYWpFMWlKcGNSTFFqK2p2d3NPL1h1WVJrZlBpTThyMXpaZmxrQ0Rt?=
 =?utf-8?B?a3VkajhOa0psQ0hRK2l3cUFvRUtPQ0ZkZkw2N2VIZk93Ni9hN0pNNzNzTmxV?=
 =?utf-8?B?RVNqSGFJK1h5RzRqaU5TdisydllPa0I1Rm40Z3RINnRQL2Nsay8ydHRYTFFT?=
 =?utf-8?B?Mnc2OW9QNVVCT3Bvak10alVYendDYnRzZFJKdHFRYU5jNi8ybnh5ODZSQXg0?=
 =?utf-8?B?emExSjJ4Y1ZPaXozanJqaWVrb3JDNExtWUk0QnBubkluS2tHYVk5QXQ5SkFV?=
 =?utf-8?B?R09ESHpFdDFUWStpcDZuRjByRUprWnVGN1EzMUZJQUkySVhLd2I4RzFmZmlh?=
 =?utf-8?B?bHhpUmRiTncxTFR4Z1U0cGF5VGVIUnhvTEZpb0ZacHVlNG9iWnZyM2VjRWdz?=
 =?utf-8?B?K0JOVllzWUVIWXZwT3NINUFUY2ljWE01VFFPVkNGbU1lWG93cWJBTkYrT29G?=
 =?utf-8?B?elcvYnYwc2hVd3hsWE4rbHpyS1U1Y0x5TjdQUlB2NGF0TVN1b21GazdHMDlG?=
 =?utf-8?B?UE53NnR1RmxvZUhnT2hsMFJuaVp5WEVRcHlCaXl2NENFRzNmVlIzZTlZVkRG?=
 =?utf-8?B?VkR4NnJNa2N0cGFrZGZKdGFVVUdDeWVFdGx6bWpMVDRZREpPb3YwYkdlS0Fv?=
 =?utf-8?B?enVmZklKeVZIK2tWQjQ5ZG1abGczdUhxZ2QvZG1LU0l2RDQyUnVKZ291cnZn?=
 =?utf-8?B?RGhpSk14SFg0am05SjdmNXlQb081dTdROEJCMUFlaUhJRVpySXRjdjRWN0Jx?=
 =?utf-8?B?M2JNOGhtUWpURi9wdHdqVjJPcllkLyszMFdvMGtFeEJtRXVoam5hcm5ia0JE?=
 =?utf-8?B?SHQ4d2tGdGVrb29FMlRrUW5YdFUralZtQjdyQVdIcGg1Q21tOWhLRzJyclVv?=
 =?utf-8?B?QU1YeTV2U2QzcGFMVVNVVDlMcjMwODBLZVBuUW5BS2M3ajdYK08rdStCNS9S?=
 =?utf-8?B?aEI1b0RySDRwWG5vc1U2SGtLNDBiZEtlYko5UGdSb2FIUW03R1NUUHZPRkc0?=
 =?utf-8?B?R3R5RStWZzQ0Z2xGTll6b2lpdXVNdTdpbEEycm1TWS9ESWgvSjg1NytvTElT?=
 =?utf-8?B?MnRocFpmS09CY2F0M0dJbXE4R3hVVEFDZVJpRnZDNDF6ZXZhWDFvS2NqRWdq?=
 =?utf-8?B?UE5YWHFnVTJ2NlZPYUt2Qmd4aUtaTlp0SDVqRHhwdENRNzBORWxCUExTclow?=
 =?utf-8?B?SFM3Zm4waXMza1JHUWkrYmE4bFhjNFRYcnlsUzF6QjF3Z0EwbHRkNlBGOXhR?=
 =?utf-8?B?N09qNHpONWdJalFneDdNNTIvcmc3Z1A1dENmSGZhY1ZGK1BJREdTZXZiME0y?=
 =?utf-8?B?VkdxT2p2ZFUwckZxQktGcGJTUzMwWVQzNGhOdVRCYk53cVhOSGFEWjdwMFo4?=
 =?utf-8?B?eTlyRFpZY0ExdTVoc1JoTXlneE4weG9aNTRoMEgwY3NEbnBhazhrUHNxU3dW?=
 =?utf-8?B?dzJ6ZC84cklsQWV2eEhwaTRGTEJtcENxT3NQMWkrZnRVTGV6aXlNRHBqTThv?=
 =?utf-8?B?NGhYYWpOVE1zMHl5VVNzci9WTUdkZU04emloaFhjQ2x0WTU1V2w5N1JpRlJn?=
 =?utf-8?B?SUhtSm4rM1JHK3lxOUd6VHNNczN1dmtLTS9STXJ1YlZEN2l3dHBxeXJnZWp4?=
 =?utf-8?B?WkhKRFhhTGdzM2VTYXEyTWJMZVllU2RkSy9pbDl2R3lIUXdlRHhxYnowRXgx?=
 =?utf-8?B?RWg3VUcydXdYd1VmMjRyd0NxQnRmZkJ2NXZZdk1hNEJoaVJTZ2wyN3dyS0dR?=
 =?utf-8?Q?+XhNefrjgjdcavrTcJ6JaSs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d970e0-2a05-45d5-769b-08d9c55e19c5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 15:17:00.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2QVGOzfyn1RbeVj+md0/bZwKik3QGWABT241WiWvBPgff0qpRcNKokLTDrZ0oX1ZB1I+V1M/lLq3tLROHu51g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2784
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 12/22/21 7:16 AM, Borislav Petkov wrote:
> On Fri, Dec 10, 2021 at 09:43:03AM -0600, Brijesh Singh wrote:
>> @@ -652,7 +652,7 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>>    * This function runs on the first #VC exception after the kernel
>>    * switched to virtual addresses.
>>    */
>> -static bool __init sev_es_setup_ghcb(void)
>> +static bool __init setup_ghcb(void)
>>   {
>>   	/* First make sure the hypervisor talks a supported protocol. */
>>   	if (!sev_es_negotiate_protocol())
> 
> Ok, let me stare at this for a while:
> 
> This gets called by handle_vc_boot_ghcb() which gets set at build time:
> 
> arch/x86/kernel/head_64.S:372:SYM_DATA(initial_vc_handler,      .quad handle_vc_boot_ghcb)
> 
> initial_vc_handler() gets called by vc_boot_ghcb() which gets set in
> 
> early_setup_idt()
> 
> and that function already does sev_snp_register_ghcb().
> 
> So why don't you concentrate the work setup_ghcb() does before the first
> #VC and call it in early_setup_idt(), before the IDT is set?
> 
> And then you get rid of yet another setup-at-first-use case?
> 

I was following the existing SEV-ES implementation in which GHCB is 
setup on first #VC. But recently you recommended to move the setup 
outside of the VC handler for the decompression path and I was going to 
do the same for the kernel proper. I have tried moving the GHCB setup 
outside and it seems to be working okay with me (a limited testing so 
far). I will check Jorge to see if there was any reason for doing the 
GHCB setup inside the VC for the SEV-ES case.
