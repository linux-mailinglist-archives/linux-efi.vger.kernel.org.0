Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36751479733
	for <lists+linux-efi@lfdr.de>; Fri, 17 Dec 2021 23:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhLQWdJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Dec 2021 17:33:09 -0500
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:36928
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230454AbhLQWdI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 17 Dec 2021 17:33:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzLgH07kEwAFmFCvZ9VwIQCNK+a7YC4LxrX0PoVe33wwszkLLz8ibv7eL2/j5bMjRKmbS+0Shuj6jatvhYVLCuDIctowDJfr535wH8NEWtSQFb3yPzYXDqYfPLL/IKQ/8qBQLOi48kmYr+fTZq0+pRGq64eUKV9VgifFPkPnzuik8YEAXG7MFk4L4B5HyHXTaJOHaysJYhHSIlWvT8K7gLvtotnrV70g+C3d+4ohuVugXQIHAjxZsY2a1UNScxzlL4+EXYtkMTcT1UlPtwwUmoaVyRAiik1bGoOIaTLufKx1PmskVK67MRX8KKohsG2yBlmZpE8nKn2KYur9eDY2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMcy5MK7iCAF8uZSvBiqO7vXGJXyzs7HoWluZSCQLrU=;
 b=SBgPcxTUATiQliEDnRNNcEQTuMOqMZ5qQlLWNHhcXfCvETOYRTcsQynjailhyekW+/w/cU/z8swSmJRmWsl9BQwk/WVzvwWoABwor9vKYLw5APAOPXulq1pqVLvdMWklOm4ZYvIYraDjQzb7yUfw/PpGl10a1xF9z0YA3V/LZnt1G5O40F66SyE0gpIW77Nk58g8T1/zkLf/DkkObijlUYrvMjf5F5qlZFMtg6Bd7x0dmjpbHLqso2HqPCDeapJco+/6buq6symMVxHuWHehb22uHv3g4XuJY4YosJ0nEuP7jUdK8Ics4KRkQBrZ0lrzggTxRFv7m1SB0RjDUlrQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMcy5MK7iCAF8uZSvBiqO7vXGJXyzs7HoWluZSCQLrU=;
 b=BcHWa+qFjQlvrBPpcrksIjRF3xBG9rAJ5ULq8VkIEXKGruQTOmK+WQW8VCMnkGhr+yplHA2QdyssejbF1IXifpV7O8RYx/k37dQ4czUBdF1Q0+5ACHobrEO1D3XwM/85fkNMzYgvVzUHt0X6RixcjK5YeWFLTQb6Bcz9ygY/XWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 22:33:06 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1ddd:71e4:5803:e44a%3]) with mapi id 15.20.4734.028; Fri, 17 Dec 2021
 22:33:06 +0000
Subject: Re: [PATCH v8 08/40] x86/sev: Check the vmpl level
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Mikolaj Lisik <lisik@google.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-9-brijesh.singh@amd.com> <YbugbgXhApv9ECM2@dt>
 <CADtC8PX_bEk3rQR1sonbp-rX7rAG4fdbM41r3YLhfj3qWvqJrw@mail.gmail.com>
 <79c91197-a7d8-4b93-b6c3-edb7b2da4807@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <d56c2f64-9e31-81d8-f250-e9772ba37d7e@amd.com>
Date:   Fri, 17 Dec 2021 16:33:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <79c91197-a7d8-4b93-b6c3-edb7b2da4807@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:805:f2::24) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN6PR04CA0083.namprd04.prod.outlook.com (2603:10b6:805:f2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 17 Dec 2021 22:33:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8434f5e2-d80a-4f3d-38de-08d9c1ad321a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5182:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5182FCFDAA8DB01F9E1CB98FEC789@DM4PR12MB5182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iP/w30h1NE89EFDw8mzPxbpWuVRq0/avzpMi73ucyGojqL97wLIguOVMKqpFUH+SFN7YwJeKMMf4dqTeheMUfIVJWu6Dqt2Ybn1uY38AW2ZCQdUmIK8wlr+ffCdPIdYEzrD8QBxCg8aby1oP9NKPlVZ0pzJh/aXPrWf+0+elOZZ54HQkrhx8+OGqGh/N7FS2c4q8ZWde+XJtIC4vDpAbm7KXXPRDotHIw+tUFUg9jJbo8hv3RWwei9VOTmUccRBaOP0iLvW8C8rHmYQW9J5rbZ9egf099/pcKzDoPc48nzeSXAKs9raxYLIAdl/hx4yWyZdpfDztzdCYHCADfpwUjEjzdGLCXTxvTIMYAVUnbJvyV6OqkL5EwMExu052cy8mxW4kc6yyn7arkJbuPEGmwKTFTGvqei/o4qvhPXP0aGH+yriYfk5i+HfzdQx9O1Tsy9tgLfb95x+wzUTRvpmSI/HRRreA/IuWKTdhzntQtqVXcIqI6KkWd08C97N38tjyOXOILawgjqpKAb7UeJ3w2jcTrjnUrffQR624ylineAzpgHpmSW8fU4jhRft3u6kWL9zFtRgU7iy6VOIEHuKH16V3kuttJll/F9HwaE//CEwcgSxrWaOmlM2lwpFhprP/7xaTvMtrPLGi6/yuWuozxqu2IBl842IBRDVDqs2Dipn1D3UsagsH7uHfDoxv05qf71YlEWIfRE2Uzae9ZA03oNxjIcswuzJfNlTiR63USg+DrxOce1jA9x9gsM0I7t0G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(31696002)(66556008)(2906002)(508600001)(54906003)(83380400001)(186003)(2616005)(6512007)(4001150100001)(5660300002)(7416002)(316002)(66946007)(956004)(31686004)(7406005)(26005)(4326008)(110136005)(8936002)(6506007)(66476007)(8676002)(6486002)(53546011)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjNpTkptdTlJQlFPNEVtLzRLYmU4ajczdklYQWhFY3poNDJEejRSUDREeW9T?=
 =?utf-8?B?THNBS3M4ZmxJb2FsdjJnd25wVHdHK2pJMm1ELzJSRUEvNzQyRlIvd2pzeEV3?=
 =?utf-8?B?MnJQaFBTRmpaNy9EdDd6K1RVbGlwZWlQOGxWM0FLQmNzQlJmTUc2SnM1aGw3?=
 =?utf-8?B?aHl4dmNMblFQcHU3c2UwNGlZZmxEekllTTZ3dlhHWWQvb0hpcnF5ZTUzNmJ0?=
 =?utf-8?B?eXpPME9CK2RBSnJZWmcraGJSNzYvdTFvVDBPMkw5K0QvbTZCcFRhUzBaQzlQ?=
 =?utf-8?B?ZCtkM0tDZ3JGTWpCNHZyaFRqS09FYmdBdlhyZm1Dc256WGxzTzNKQlA2RENC?=
 =?utf-8?B?RUwxK2pJanJtVkJJM2dNbHcvcEJRV3Nha1k2dmN2KzBZUW5LajJNYW5KTGRk?=
 =?utf-8?B?SllzcUQwbWIwUURqMmpaTkUwaFRsV09UUTcvTmh0MGRUdG5kLzdIM3doZ0xE?=
 =?utf-8?B?RDlMRHJVcm1PcmRSalY0MUJJVm9GblNXRWUrU3JJdVlSbXIzVVlHbkVjTG9F?=
 =?utf-8?B?T0tsTkxlRnFNRkJwaHI5YkJzNmlDRjcxelA5OUVlNlBzejBKcFNHZWgvM1ho?=
 =?utf-8?B?RjNONUxXSHRCQ3p2cGRlSUJhTE51TVR2UFkxM1hZcWtlWFhPUTBVZFNrS00z?=
 =?utf-8?B?eDhHOFdFYVcvdjdPUnJ6SUtod041d0FPWjB5R3ZxN1ZkSGhPUjRhM3QvMDd5?=
 =?utf-8?B?UVBLWnJIL0NKWG5mSFNvaUV1MlNGYS92STFQWmN6MG5xRnpRdllmMzQrQ0lO?=
 =?utf-8?B?aHlRTlNkZk5GNlhVeXVJakJiZEhiclJJVFh3a2FqSHVuaWM4aCtWTTdFYzkz?=
 =?utf-8?B?eklZUE5iZDdLQzdpTVp5K0k0czFud1BKVWtQd1ZnbjJad2toN0c1d3JQN0xL?=
 =?utf-8?B?cGN4c1J1UFRIYTRqV1dqSW9qelI1TVBBN1QxRmRocFNYRlJjeDNWY0Q2Q3BB?=
 =?utf-8?B?RS9ib0RaWGxBanBrWkdQaDlVQ05ab3RXWEpNTnFWTEdYNG9kNTFNN3diQVNB?=
 =?utf-8?B?TUtXd08vNGxPa201T2xiR2dSckY0UXRMazZoWWRlZzcxM3JiN1hsMVo0ckY2?=
 =?utf-8?B?V1FPWXpSL0N1ZC85bGlhRlpoNjV0WHZMNUsrV0Y3dnZTWkdrQ1d0ZFBLdHJH?=
 =?utf-8?B?NHAzbnh6MVRrNUU3OWM1R04zZWIwRzRhcmRPY2hhZ2k2dlF3L0lQK3VkUDRE?=
 =?utf-8?B?QlQ4S0FZVDZhVS9jV0w0dENVRWd1UHNhN0MzcklCS29KQ0F3WjZYejJ2Ymtl?=
 =?utf-8?B?R0FTZE1ueC9ac0Mxc01tWk9oekcwMkYyTUJpNTNKd3pqSHhrT2Y2MjllUG1x?=
 =?utf-8?B?NG5Idk9RZlhYMWhCcml6R3ZLYm9aczlNKzZIZ2ZzR2JMYzRpMFl4ek5DUm10?=
 =?utf-8?B?Z3NRWE5EbU5BYnZNOXYrUFNjU2k0VUovbFpiMG91dTQrSUplQVBHYW1jTXFj?=
 =?utf-8?B?L01sUTVLQ1JGZTRiazNYZngxa1BWMUxNWW9wNWE3SEJCeEc2RzlLbUJubTY5?=
 =?utf-8?B?V1AvR2U4amMwTUIzV2MwaDk0bG44K2lEL0pUeG9TT2NsU1c0Q2hFTmt4Sm5C?=
 =?utf-8?B?blhGRllzTzJPdWlsNHVVaDBocUNKc3ZTbHhWbFp5Q0RlQjVqWjYwanpjYmN4?=
 =?utf-8?B?UEVVUkEzNGZZZ2ZxNkRrSjUrV1VwUWR2MFlOY0JPUUt2U0VoZUxqS0lFTTl0?=
 =?utf-8?B?Q1k5L1dTV3pEWWZUeThLUW9RbkJQVG83blZuaG9yR0ZjRnpoNGJWakorRmZS?=
 =?utf-8?B?S1JGS21QWHBhU3k5d1NFUEJmdEFnNHc4V2owUFQrRkZhbHl6MG5nQTE1bDJL?=
 =?utf-8?B?azNiZ0NUQzRUOHROWVNEYmNzUklrNVN3ajlrN3Y5Yi9GOURJZnFPTC9pYVJz?=
 =?utf-8?B?UloxcmZsdlF2N1ZOS0RiVmRhOFJBd3grQW93emdBeEhtNXAwZlpBU3BrYzFa?=
 =?utf-8?B?TWI5YnFDaEFNZ05FMS9ycXBEMXdjdktxaGRHWGoxT3cxdElsRXlicmJWUlBH?=
 =?utf-8?B?andZdnVZZjlNWFhucW1Dbld4UkhYQVFuejVPa3pURDRZV1lGUFBzcEs1eFRk?=
 =?utf-8?B?ZGlFZERCM2pCV3pFYVZPRUNraTd4Y1VXSU8ydjdqVFM4ejAwVFc5eC85bUFK?=
 =?utf-8?B?YlhhNzB0VWFwQTdsNlcwMllBVVlTdjQ1M2FCRVorNm16NHRpZGFGYnROQXlB?=
 =?utf-8?Q?evL9eUhPhZG+LgJI38E+cms=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8434f5e2-d80a-4f3d-38de-08d9c1ad321a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 22:33:06.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Az6UWmVmkoP4p13zRoz021iPQrEkZzd9zjc0zg73dJ7IoY648UKOUGo8WFJ/9ZT9WGuph+zwfXwtowd0VVQQeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/17/21 4:19 PM, Brijesh Singh wrote:
> 
> On 12/16/21 5:39 PM, Mikolaj Lisik wrote:
>> On Thu, Dec 16, 2021 at 12:24 PM Venu Busireddy
>> <venu.busireddy@oracle.com> wrote:
>>> On 2021-12-10 09:43:00 -0600, Brijesh Singh wrote:
>>>> Virtual Machine Privilege Level (VMPL) feature in the SEV-SNP architecture
>>>> allows a guest VM to divide its address space into four levels. The level
>>>> can be used to provide the hardware isolated abstraction layers with a VM.
>>>> The VMPL0 is the highest privilege, and VMPL3 is the least privilege.
>>>> Certain operations must be done by the VMPL0 software, such as:
>>>>
>>>> * Validate or invalidate memory range (PVALIDATE instruction)
>>>> * Allocate VMSA page (RMPADJUST instruction when VMSA=1)
>>>>
>>>> The initial SEV-SNP support requires that the guest kernel is running on
>>>> VMPL0. Add a check to make sure that kernel is running at VMPL0 before
>>>> continuing the boot. There is no easy method to query the current VMPL
>>>> level, so use the RMPADJUST instruction to determine whether the guest is
>>>> running at the VMPL0.
>>>>
>>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>>> ---
>>>>   arch/x86/boot/compressed/sev.c    | 34 ++++++++++++++++++++++++++++---
>>>>   arch/x86/include/asm/sev-common.h |  1 +
>>>>   arch/x86/include/asm/sev.h        | 16 +++++++++++++++
>>>>   3 files changed, 48 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
>>>> index a0708f359a46..9be369f72299 100644
>>>> --- a/arch/x86/boot/compressed/sev.c
>>>> +++ b/arch/x86/boot/compressed/sev.c
>>>> @@ -212,6 +212,31 @@ static inline u64 rd_sev_status_msr(void)
>>>>        return ((high << 32) | low);
>>>>   }
>>>>
>>>> +static void enforce_vmpl0(void)
>>>> +{
>>>> +     u64 attrs;
>>>> +     int err;
>>>> +
>>>> +     /*
>>>> +      * There is no straightforward way to query the current VMPL level. The
>>>> +      * simplest method is to use the RMPADJUST instruction to change a page
>>>> +      * permission to a VMPL level-1, and if the guest kernel is launched at
>>>> +      * a level <= 1, then RMPADJUST instruction will return an error.
>>> Perhaps a nit. When you say "level <= 1", do you mean a level lower than or
>>> equal to 1 semantically, or numerically?
> 
> Its numerically, please see the AMD APM vol 3.

Actually it is not numerically...  if it was numerically, then 0 <= 1 
would return an error, but VMPL0 is the highest permission level.

> 
> Here is the snippet from the APM RMPAJUST.
> 
> IF (TARGET_VMPL <= CURRENT_VMPL)  // Only permissions for numerically

Notice, that the target VMPL is checked against the current VMPL. So if 
the target VMPL is numerically less than or equal to the current VMPL 
(e.g. you are trying to modify permissions for VMPL1 when you are running 
at VMPL2), that is a permission error. So similar to CPL, 0 is the highest 
permission followed by 1 then 2 then 3.

Thanks,
Tom

> 
>          EAX = FAIL_PERMISSION                // higher VMPL can be modified
> 
>          EXIT
> 
> 
>> +1 to this. Additionally I found the "level-1" confusing which I
>> interpreted as "level minus one".
>>
>> Perhaps phrasing it as "level one", or "level=1" would be more explicit?
>>
> Sure, I will make it clear that its target vmpl level 1 and not (target
> level - 1).
> 
> thanks
> 
> 
