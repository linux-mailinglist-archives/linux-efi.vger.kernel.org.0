Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8C3EB5FD
	for <lists+linux-efi@lfdr.de>; Fri, 13 Aug 2021 15:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbhHMNOA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Aug 2021 09:14:00 -0400
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:34752
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239062AbhHMNN7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 13 Aug 2021 09:13:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqbngGVFM7Tqrm9BSRJ8Lxr48Yr2x7+bjERkhCaS2RzYWPqlNgOZsBhvWmFYUSpN/y8vXWrTN9fwQx4LPTmnSXkShNc+8cXoohPUNJKJAaph0BwHqJEf9IvyCzetEkWOHknbzVfS+mlloz6vNyvRQ/WoV6wpTtZMcMhvnBDBIJn2rLrLGf40H2Wa+ZRljrcGaQFSs2DwJxItT9nyUpJBefm9SLG/4YmzuVEeb9vrsQ83MZ7VHIIeBV7xTs3ZTfiQVgRgHjXh3i3OkFDz03VCjiY2Tt9sgnTUyI4qvs/6WGpWFx4YsK9Qi6dPEC6rt78MSX8r5molzcD5yFSC/lHdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXOTb+JBRqlmpBN1/PJyDRdw09B+LaUvdSNrUr0VwEk=;
 b=goIV88aXkk1NguZzWRSzlmI+1DME2nX/ZqjH8G+27yi+33XjYvK17jeNoagyA+K6OEIZ0qynLtnpCoag3xJHrJ84ihCHnAKpLY6qJarFmO5Koh6Ihid85lWYJ8xr5Q3RdagF8V0Zceg0RRgpO7FWeqUY/A1veatWTGM5LV4yrW4kXggi086Fby7+uED3MbTJ6S3iT99Qg+e/L2Z0fc8xxI7PROScQ0iPIMjrdHWcLkG8F/cPJrKYhP0S15hKkqIwnh//NZ4r60wCFTnCA/NYPNGX4uvmYs8FFzkcrwNSrlRamfQECFNHXsk/QKTSEbCHO2Qy6JkkCwYhWpjxY+TC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXOTb+JBRqlmpBN1/PJyDRdw09B+LaUvdSNrUr0VwEk=;
 b=aVvB97SjrgWMm3Yfwjvgdx3QPV7NWAK2gxTX4BPpqk1AFiJwuuwBlBnrr0mqOmPGIsTKvz9dJviwHHAawyEoUHz/tFEVc0hivySrbPeLFMDQ9MNZhbXJZjsusLn7SHpddNzstfT2gmryrNxQeB7kRVAlfUZZiuDYZpaskMBZTbI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2768.namprd12.prod.outlook.com (2603:10b6:805:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 13:13:30 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4415.017; Fri, 13 Aug 2021
 13:13:30 +0000
Subject: Re: [PATCH Part1 RFC v4 08/36] x86/sev: check the vmpl level
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
References: <20210707181506.30489-1-brijesh.singh@amd.com>
 <20210707181506.30489-9-brijesh.singh@amd.com> <YRYegqsigZfrbFbk@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <bd5b8826-ab0b-4f4f-8594-0c7e6232941a@amd.com>
Date:   Fri, 13 Aug 2021 08:13:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YRYegqsigZfrbFbk@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0201CA0030.namprd02.prod.outlook.com
 (2603:10b6:803:2e::16) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN4PR0201CA0030.namprd02.prod.outlook.com (2603:10b6:803:2e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 13:13:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bb169ad-34df-44f4-1e76-08d95e5c24e9
X-MS-TrafficTypeDiagnostic: SN6PR12MB2768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2768FEDCB8F9077966A4404BE5FA9@SN6PR12MB2768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yK+Z/2WXlwUIWUP8TcbCYd2UjzHkkvtACM8KBTd0DApjbl67oRXBwL6c4TvUXKy5Yn1f+WI8hhShPVLJT4ALqHe6oBEsBA2kXyLHI6OVXtz9v9vMMs+Ix+NCUQp7dWIzjPFt1WmiExszHRYDlqJ7pXXKvM9mZ4MIoRsTEBZpjrOQS08AKfF+n+SVRqr9u4U9tFw6GyJvIdvJIasUV++Pj4gv1bsXysdL4HJ89EX2zX1FcBMk6MCF+t2FiaGFubMYut4o8EcsNYqxNpEOxsxWor9FyOnvUuHV7MP61/xaiDVCdAtnVlJS3PeD3JTB9gZ1ENOISviHakCRWV+sMK1zXwpNFKQK17JNbBWRdA4rxFDbXDrQUnVepnSRTg612BT+VWERe929ZT8KteqjsxJf/91IeSW2bXacnqLOOH1v5c74D5hu76K4IPDbdirxcy5iQsMtjQeiU6xymuI2lyv2/vOffU+jE8jfm8E/2KC7mWDHalQUzdxbcT4vXiuVjYm4oPEfXIEE0zLioLYVT0jIoPWvD7h/9eTjMuwLbt7VxsEUlalkuEFT25EjDJxnTQyhgxmHDOO0IdIJLxLr2Yac9pe4rc+kiPfMQOax9g9Wj1+cGB8vXE6yDtI5uoY2ijMtY9fRmw339LECjqziIJFVLnOhx/Niamo427Jn75br3uDqQ8pAzMpq44r0M6T/S6TvpLkTqKUjs8RYpf0/nfWlIn5fy7WRKtPcSQdjoj+gfth+ccle4r/qz8ap3tAFQ0AsUbb9uYtnQfoxGpU72j0tQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(186003)(6916009)(7406005)(478600001)(316002)(86362001)(54906003)(8936002)(8676002)(6486002)(44832011)(4326008)(956004)(2616005)(38100700002)(31696002)(38350700002)(6512007)(7416002)(52116002)(66476007)(66946007)(66556008)(83380400001)(26005)(53546011)(6506007)(36756003)(31686004)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU10VFByVDRzWHNYRmhNeTZldU8xckhQNTFuSXhCN0thZ0pDRlNmWWNmcUJs?=
 =?utf-8?B?ZS9VMTIvNVNhZFhWbHlEQi9ITk5NSDdMVmhBU1pHUm83cmJLdUJqZngxczl6?=
 =?utf-8?B?NXJ3cUNhUkVBbjE2NXNFRmFscXp3NEFTRmlOa2pGbVJ5bEFMMU5IdDFWWURm?=
 =?utf-8?B?cXpFdkZKMTVuMkkwWUpwWW1IUm9lOGdaNVZXVHUxd3JhR2s4clJoR2d4b2dM?=
 =?utf-8?B?Tyt1SDZ6a1Y5M3kxNTRzMnJWeEdnUDFRSlJwdEY3MWZiNUpZNEhnNGpLeEVP?=
 =?utf-8?B?UmhrcGRlR1JCN1ExN1BhVW12OFdJNEU2a3R3SnRNKzl2dHNhYm5oNzNuaHJG?=
 =?utf-8?B?VG5Iak1WOVFrc0JTdXlpeTJFa1ZSUWV2bWZ0amhJeldhekQxTjlaWDhEQjN3?=
 =?utf-8?B?eDJ1NFM4TDRkMHd4NXZlSS8wMm1KTzF4ODVKaFdHL3ZWN1RyeDdhTmlFcldK?=
 =?utf-8?B?M1dNRnVYZGpOWE4xZkNCRXhDQXFjNE1XdXltbENlL245c0ZWR1hrTzMxWVpL?=
 =?utf-8?B?VlJRb3ZPSTNzYUREUmQreWxWZnEwaUFDdFd1UnRwK2pleTNpZHBhd1ZIeUhw?=
 =?utf-8?B?MDhnWlBaUjJiZmd5N1RKL3RuOG9pNUhCYVJiTmNWaUVKUFhTU0pNMldpbWFT?=
 =?utf-8?B?dG9HMlNkR0Faa2MvQWsySjlqb2pmL3R5WnhwRkJSWFpDUVZlR3ZXSW1JMk9n?=
 =?utf-8?B?TG16WEd4RzdvNHRCTUNmRjlmZ2hyNHlFTFJmZ25lS0RQM0Q1RlFVOW91UXdI?=
 =?utf-8?B?bmpOcXZVU0RFRWYvWjBTVmo3bFBOQ2haTUZHWmRMVDVjVkpOMzIyOC9ITUNo?=
 =?utf-8?B?OEs5L3NjaW8wd3ZyUExJMkhaYnJSeVBXTks4d3AwUnNKMlRqNzMxaGpsVFhE?=
 =?utf-8?B?dE5UVmVUK1UzK2RnbERrQzZzaVB4emtHT1BEMVpKcTZHK3JlR2VpZ1g5Qzds?=
 =?utf-8?B?aW9ZSjFnM0pNdFArd3Y1NmxnSGNJUnEwU2JHRktlMUo5aE1IWE1OTVc0ZDZw?=
 =?utf-8?B?ZGptWXg3bXhEK1ZuTE5FWGhJbUV5cks5YlVTbGpEaHNWWkdSSHBlYm02enFj?=
 =?utf-8?B?NytXL3FQZ3l2M041K2NYQUNRbXRwRDJHZ3BDVVloWTIyNUloeDJ3TUtxOVNR?=
 =?utf-8?B?Z3NRY0tEZ0I4SVhWNE13dm9sQXV4UUFCcHlrcGFkLzlESmwrdTlDWUhZOW1n?=
 =?utf-8?B?MEhkRy9VcjZvWG53Nk1Pb1hEdVloQ1F0UEk5T1Z6LzV1cmkrRVdSQXdIYjZt?=
 =?utf-8?B?Um50OXhVTUFIQy9DVGwzV010bUhSTTc0dWVOTWpPR2J4V0JYZldVYmpBWUha?=
 =?utf-8?B?bFAxQ1lNV3psYW9pSExvd0ZwUzl2dUdOMHE2SkxtVE1sTE5CeXM0VXBsK1FZ?=
 =?utf-8?B?dFJYTC9OQzdEUnF0WFFXWmFEajZWbnJCUmlwRU5oRzB2T01hZ1pyaVJEV3U4?=
 =?utf-8?B?S3c1aUFnOU0rSmkyVEliUUxiak9BVjJ1dlI4NVY3NmRDa0oxY0dVbmpna2Y2?=
 =?utf-8?B?UWFBMlU4eWZQTHFjYXR5NktKQ2EvYTBsdDZGL0hhN2h3L2RVN3FMM29kT3RQ?=
 =?utf-8?B?SEk1Q2ZScGcvY3REc2syQlJCUE56UXBjdnNTdWZ6dlhReEVjREJ3KzZqcHkz?=
 =?utf-8?B?Z2NPWEpqWW50WkgzN2lLTGwwUGlISEg3UzRvMzdDRjFwaytvRzAyVkxlTkZi?=
 =?utf-8?B?M3BkMWdOT0NsZVcyVlg1MHc0R3IwN0VQNUdpbnZxVytGMlNQR3FNYjMzL3pJ?=
 =?utf-8?Q?tBykImuQBC93V2wOtfFtxovYTSpVLbQP8r/1dEW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb169ad-34df-44f4-1e76-08d95e5c24e9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 13:13:30.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTLZI2KZs7I52fPNGQF1rOYq8y+IEoHUN4EP7eS20+uWtKSt7fUzydopLTYUvvxuItRHYvCsOBpPNq3G8WqBlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 8/13/21 2:25 AM, Borislav Petkov wrote:
> On Wed, Jul 07, 2021 at 01:14:38PM -0500, Brijesh Singh wrote:
>> Virtual Machine Privilege Level (VMPL) is an optional feature in the
>> SEV-SNP architecture, which allows a guest VM to divide its address space
>> into four levels. The level can be used to provide the hardware isolated
>> abstraction layers with a VM. The VMPL0 is the highest privilege, and
>> VMPL3 is the least privilege. Certain operations must be done by the VMPL0
>> software, such as:
>>
>> * Validate or invalidate memory range (PVALIDATE instruction)
>> * Allocate VMSA page (RMPADJUST instruction when VMSA=1)
>>
>> The initial SEV-SNP support assumes that the guest kernel is running on
>> VMPL0. Let's add a check to make sure that kernel is running at VMPL0
>> before continuing the boot. There is no easy method to query the current
>> VMPL level, so use the RMPADJUST instruction to determine whether its
>> booted at the VMPL0.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  arch/x86/boot/compressed/sev.c    | 41 ++++++++++++++++++++++++++++---
>>  arch/x86/include/asm/sev-common.h |  1 +
>>  arch/x86/include/asm/sev.h        |  3 +++
>>  3 files changed, 42 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
>> index 7be325d9b09f..2f3081e9c78c 100644
>> --- a/arch/x86/boot/compressed/sev.c
>> +++ b/arch/x86/boot/compressed/sev.c
>> @@ -134,6 +134,36 @@ static inline bool sev_snp_enabled(void)
>>  	return msr_sev_status & MSR_AMD64_SEV_SNP_ENABLED;
>>  }
>>  
>> +static bool is_vmpl0(void)
>> +{
>> +	u64 attrs, va;
>> +	int err;
>> +
>> +	/*
>> +	 * There is no straightforward way to query the current VMPL level. The
> So this is not nice at all.
>
> And this VMPL level checking can't be part of the GHCB MSR protocol
> because the HV can tell us any VPML level it wants to.
>
> Is there a way to disable VMPL levels and say, this guest should run
> only at VMPL0?

No.

>
> Err, I see SYSCFG[VMPLEn]:
>
> "VMPLEn. Bit 25. Setting this bit to 1 enables the VMPL feature (Section
> 15.36.7 “Virtual Machine Privilege Levels,” on page 580). Software
> should set this bit to 1 when SecureNestedPagingEn is being set to 1.
> Once SecureNestedPagingEn is set to 1, VMPLEn cannot be changed."
>
> But why should that bit be set if SNP is enabled? Can I run a SNP guest
> without VPMLs, i.e, at an implicit VPML level 0?

During the firmware initialization the PSP requires that the VMPLEn is
set. See SNP firmware spec [1] section 8.6. To run the SNP guest you
*must* specify a VMPL level during the vCPU creation.


>
> It says above VPML is optional...

I should not say its optional when we know from the SEV-SNP spec that
VMPLEn must be set to launch SEV-SNP guest. I will fix the description.


> Also, why do you even need to do this at all since the guest controls
> and validates its memory with the RMP? It can simply go and check the
> VMPLs of every page it owns to make sure it is 0.

There is no easy way for a guest to query its VMPL level. The VMPL level
is set during the vCPU creation. The boot cpu is created by the HV and
thus its VMPL level is set by the HV. If HV chooses a lower VMPL level
for the boot CPU then Linux guest will not be able to validate its
memory because the PVALIDATE instruction will cause #GP when the vCPU is
running at !VMPL0. The patch tries to detect the boot CPU VMPL level and
terminate the boot.


>
> Also, if you really wanna support guests with multiple VMPLs, then
> prevalidating its memory is going to be a useless exercise because it'll
> have to go and revalidate the VMPL levels...

We do not need to re-valiate memory when changing to different VMPL
level. The RMPADJUST instruction inside the guest can be used to change
the VMPL permission.


> I also see this:
>
> "When the hypervisor assigns a page to a guest using RMPUPDATE, full
> permissions are enabled for VMPL0 and are disabled for all other VMPLs."
>
> so you get your memory at VMPL0 by the HV. So what is that check for?

Validating the memory is a two step process:

#1 HV adding the memory using the RMPUPDATE in the RMP table.

#2 Guest issuing the PVALIDATE

If guest is not running at VMPL0 then step #2 will cause #GP.  The check
is prevent the #GP and terminate the boot early.

thanks

