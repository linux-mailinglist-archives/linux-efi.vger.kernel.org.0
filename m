Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E823FF028
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 17:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345767AbhIBP2n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 11:28:43 -0400
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:52353
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345689AbhIBP2l (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 Sep 2021 11:28:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYjl0F70/bFR3Zrpy7eyYutN3YbLSgS8qebTyMOVPTNbWHcUomhqxRZaJpLmdWW9pcbE22PAzH5jlGl0lHwFGdBwARw9sVUYiTbo6lG4Uhouq8WbZOgO+Hr7ANPoUPY+H5s+VZuF7HO8JhBjFktJBiuv5ST3Vrcdw051ZYw++qZaaujyXAaKzwjTKwsBt270wDnwuhv6nPjV0xbxkL8BsAWP0A+QEdegK/QYKJ1nVqZJlrOq9RFUGAEuQuYUSZTXqFzdQ2yqNKGW2rJh6itnvUuD/GwYLqhPuY6nq25U7xhDjihzHZ118fbZNuNJw1PbOvPmyOOGmq1O687IUr663w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MjlRa9KJVbTROiW7pY0odste8AGb+qLpZ2D2029ws30=;
 b=e7bTAIshV6Qavh7Nalpp8gtmSikLh0+fytrIbwoDlc8xRURAa1HFZsaVIOnwXlslQjT8jQXpK1kjGKAex0PAwe2ROM7HFUCkE7zCJUZ/VyxhAeB1blzueQNY0GrxdVIWcZFsJN0y+vk++T4pn5vA8pJrsZ4bDa+zSw/4r6PRctQVJ3b1oSYgMlXOjWdjFCAy3ZYtMIrtFmo53TjjrqnbiC8py8gvSyvB/xrbdBMz6BG01Wo+xue6ZuXjj1aABJ9fDMFmVsBMnpbO6dJriglBmVt2yXcE1vH/sM9xLPJy2GQe9N1Syqmt6HGCcRoqRHe8p7ZUHYMMbPyv93T79mmliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjlRa9KJVbTROiW7pY0odste8AGb+qLpZ2D2029ws30=;
 b=NvcDZhpgEPONOBos8LB1h+ICkOb+R2j6pWbX5cg5VeT6GI3DsgapXZ5jjwfCiYeawpbfolLjOs/vXUP46zc8p1pbg08X6iNsFuhsimTqqlpuX5XOX4q58E1rhnhASKefVAmMYlasCm51YnHrr50TR7h+j390FGsQk0WcjZbkE7E=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 15:27:41 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4478.021; Thu, 2 Sep 2021
 15:27:41 +0000
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 34/38] x86/sev: Add snp_msg_seqno() helper
To:     Borislav Petkov <bp@alien8.de>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-35-brijesh.singh@amd.com> <YSkxxkVdupkyxAJi@zn.tnic>
 <9e0e734d-7d2f-4703-b9ce-8362f0c740f4@amd.com> <YTC1ANx81eQeGN4o@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <01b9c0e8-a808-83a7-214f-ea62136ffa0b@amd.com>
Date:   Thu, 2 Sep 2021 10:27:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YTC1ANx81eQeGN4o@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:806:d0::34) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from [10.236.31.95] (165.204.77.1) by SA0PR11CA0059.namprd11.prod.outlook.com (2603:10b6:806:d0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 15:27:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77610795-2842-4a2f-43aa-08d96e2633f7
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4525C522CA751A5EB764ADB2E5CE9@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMNaJ1bFdJtglbTSWYUHz8usGmD4BXLJY+jFZueYcGiZPU4HfPF/DTj7PB39H6Md5T2bqTNJeq8Y+/dNXx15GF11kw37uGEGVxG/QV31G0vyy0KA8jfFA2sxapStMwkXeDzTVLFmVypei4dEeyIqqd4kGNGsOFK5r5GlzrQdo2mNLmTDx6vWVpaqFQTLMp/946tG3vn4BrqK5L/RldZbmx9NjSWp5uzVElrqrFL3ZmICQ2ktD6AFUqagtPqp5BvEliobcdPp65JeSmuDvYQZHQQOw+FvtIgRWP47Dsjdvt1r8DGF5J9ZFwICi28FUCS5JzVSWhnKIypIJCfuoyWEmz+Rc3MoCyJQtw2bEtnx6FVLQ2RZu1Gu8I/JAMr1rNK07ksDJy9wGZb9zwKuXP8PaHzj/yJTZbAaC8gRQBNAW22wOlVia7lf8rqCuv9FBYQxFAu3f8lvgC5xWg9sMXIIQo28Bozwg68cCI1PBjUPPsy+QZoBZsfavKK+e44AgdwbeQWZi3usGG7xXRYnSm/hx5VbWUt6s4jRgvcZWD6o7d1bB+2gL6PpH3GVYmIaCvSe1wWugS9h8zDXBP4yiqbkWYwn2L0S81JETdi0HRWcDn6s0bVE9hNtf4HK9j4ArkzcKUyWszsiz9kV3WaV5nf/fPZj31/ySHsIV3cKDFH7FIm8O9+rd1wsodDaFmLLeZ3H3LABG/dJxIjXIbmdy4C0HPH9X2kj0teC37V/CCpYKzpZ6aI9jZPxIy9xMK8uurwTKCk6qrhxsX/oYkn5yFtUvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(2616005)(86362001)(7406005)(31686004)(7416002)(956004)(36756003)(52116002)(6486002)(4326008)(5660300002)(66946007)(478600001)(316002)(38100700002)(38350700002)(16576012)(54906003)(2906002)(83380400001)(44832011)(6916009)(66556008)(8936002)(186003)(8676002)(31696002)(26005)(66476007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEZENEdnTkNvaGR2LzlDSTI4dEhuWkRVSmx5bHg1WjZ3N1NyYzlUc3RYcDI4?=
 =?utf-8?B?MkJEMjJnSHc0QmcyUEhsdzY5WVplVkxmMnJ4TzNzVjFCUGM0NE1pd2Nrb0o3?=
 =?utf-8?B?cldkV0dOSklreS8vZjI2dXNIeHlISS9KbFgzOUhqVzB2bVh2QUdNTE9yeGZq?=
 =?utf-8?B?WnZZbUZtUFN0QzRHVGhRS3R1dUpEVmJ2cTQrY1pZdVgrQU5BZjIrYk53UGpJ?=
 =?utf-8?B?QTBKY2dSQjFPL2RmR3VoYmRORWlQa294dkdKbktlV1ZRK3FOZ1BSNzBOWE50?=
 =?utf-8?B?cUV5S05CNDhvQ1VidE9RT3lXbTgzVDZWeU1GVkdDektON3VQMXZHTXNUY3ls?=
 =?utf-8?B?eXd2Z1pSeGdFWHkzeDh0Wi9VZWh2QWdwZm41NTJlTzZxeHRUdjc3SWduaVlJ?=
 =?utf-8?B?YzQvVFVzY1RFVEttZXlqRmtNUWxVVXRnV3JJV2R3R2xNbW1jc1lIR01rcjhl?=
 =?utf-8?B?clE5MXo4VEcrcXFTM21GVkx1ZVNsdEIvaC9mT2ZJZlpneDByNWJXS3hLUjJR?=
 =?utf-8?B?R2xJYmpZa2lBRjJucnd3ckV4Vll4K2hGdXJJZ3dMNEZMMjIrdzcydEtqNzEy?=
 =?utf-8?B?M3p4ampNM1RjUzI1Wk9FcTViaEZLQlorWWFHZTl3dDVEVGFjYjhMMEpqVzRi?=
 =?utf-8?B?Q2pJdDRzRk02bzQvK01IcnhlZU5WbEhqUmtOWU5KeUNhU2VSMVo0V0FaczJl?=
 =?utf-8?B?ekhUM0VyUi9zTzJ6VnZYc05IQks0Y1Blam1aU2RVZVZZcVp5MXhPUS82TFRU?=
 =?utf-8?B?ZzdpREhVT0JFRS91WjB5S09ORmt1RGZyWnJaOThad3JjSHlZb2x5b092MHlI?=
 =?utf-8?B?SjEyTWJleGxzYWFQSUljc0kvNWNGQ2U4TzZhcWdIbHpPcDhZWlVZZmttY1VE?=
 =?utf-8?B?Q3Z6VnRoT2dOZ3hkbkhvWXcrbWhRL290Ym44VkE0ZklQcEh2aUVTcXJrbU00?=
 =?utf-8?B?NU5iZU9QNUk5NE9TQ0ZoaEZJRnRjeHNUeHM4YTVwNlpGZ1NRUE40QjVqMk1P?=
 =?utf-8?B?UjZLMXZXWnNLL1luRWRUdTRtakpibGhMWlp4bnZpSDI0Q05DY28zMWh2MndY?=
 =?utf-8?B?S2xQTVA3OU5SNDFxbkdyZjE0ZHo1UC8wWXhlNEJsWkpieXhEemFScEpOYnZw?=
 =?utf-8?B?WHhlaGMrY2RjUllrMkUreUdhZjI0TUU2NFBQcHVtVDlqOTc0M3NHZXdYTGpi?=
 =?utf-8?B?U0g1YjJwaVBmelRrWWNaWWFsb0hqdndoZWNmSUJpdW5NaklqWVZPbmJ1TGdp?=
 =?utf-8?B?VzREVVRiL1hQZWRwQW85RkI2Y29jYU5FUmQvaVBvZFdOdkJRZHV3V3VpZmtN?=
 =?utf-8?B?TjFRUTgrSCtvZWdyNnRUSjVRcnREdGlsbGVTaVhkK25RbVM5UzlheHI2c1JJ?=
 =?utf-8?B?K0pOcUJLZTVFUklwcU9lcnFHcW01emFva2tKMFJOK1Y5aklDUzBlWGNBRGR6?=
 =?utf-8?B?azNwNWY4LzAyblZhQlRBUjc5NmR0WGF2TE1wQk0zc0dkQ3l3Z3Q3WlJBcExZ?=
 =?utf-8?B?U004QVhSdGNlUld0Q2VadzhPYXQ1YnE1TndEeWpsWnhhOEo0TkxQY01FQjBN?=
 =?utf-8?B?RnRpYXV3U2Y5bUVtL1BEcU44aVZQV1lDczBDcTNNRkRkTFZjZU5uQ0VhdSto?=
 =?utf-8?B?VkNEWlMraW1mQzR0UHlHR09QeSs3ckVOTVRCeWNKSlQ1a1o4R3JDaitCOVhH?=
 =?utf-8?B?ei8rMEthSGJpT2xIcGE0UTJabWNyU3QzZEgrbkZ3U0Y1WkVJM2pWTE9uSXQy?=
 =?utf-8?Q?D1VQ9EVfPkOLAWVpfspmjffr2hHJTFGkiOLh2q1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77610795-2842-4a2f-43aa-08d96e2633f7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 15:27:41.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8teaP8OhzOVNdwJ7t3vExFGBwR377BIgzo122K/oL2vyCEfr9S6aHpuEcF4O0jYcQ6E6o0tqhXwGEu7d8/waQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 9/2/21 6:26 AM, Borislav Petkov wrote:
> On Mon, Aug 30, 2021 at 10:07:39AM -0500, Brijesh Singh wrote:
>> The SNP firmware spec says that counter must begin with the 1.
> 
> So put that in the comment and explain what 0 is: magic or invalid or
> whatnot and why is that so and that it is spec-ed this way, etc.
> 
> Just having it there without a reasoning makes one wonder whether that's
> some arbitrary limitation or so.

Agreed, I will add a comment explaining it.

> 
>> During the GHCB writing the seqno use to be 32-bit value and hence the GHCB
>> spec choose the 32-bit value but recently the SNP firmware changed it from
>> the 32 to 64. So, now we are left with the option of limiting the sequence
>> number to 32-bit. If we go beyond 32-bit then all we can do is fail the
>> call. If we pass the value of zero then FW will fail the call.
> 
> That sounds weird again. So make it 64-bit like the FW and fix the spec.
> 
>> I just choose the smaller name but I have no issues matching with the spec.
>> Also those keys does not have anything to do with the VMPL level. The
>> secrets page provides 4 different keys and they are referred as vmpck0..3
>> and each of them have a sequence numbers associated with it.
>>
>> In GHCB v3 we probably need to rework the structure name.
> 
> You can point to the spec section so that readers can find the struct
> layout there.
> 

I will add comment that this for spec 0.9+.

thanks
