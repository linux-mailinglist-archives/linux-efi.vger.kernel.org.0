Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECA84796F3
	for <lists+linux-efi@lfdr.de>; Fri, 17 Dec 2021 23:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhLQWTc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Dec 2021 17:19:32 -0500
Received: from mail-bn8nam11on2043.outbound.protection.outlook.com ([40.107.236.43]:15392
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229480AbhLQWTc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 17 Dec 2021 17:19:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYIYnvyZqdY0ymv8BNm7o4I48qdsO4rGbqLM5DpcU2HJ3X+GpVGDyItVbelxLuA7AA5KZZdV5Krvjr8nBXheB7ygXAhLfUaTr0+nxRmYJKAzIlvaP0gV0O6Z2VfpQrgB+Z+2iF2WxTXYU6kxghgfun/vBma5la4pUbNJqiXexI4dmTK4Vcbgik0T/y8X+qhI6rtxDNhjNneQJAqRKogTDwn51lBvvoJf7B1yR0qWmvhei9kE+uvd6sJo90/Kk7StmgmWhud45ZxkJIG7+3Rxq2PvJuRrqHa/RMNG6cCt70JHQdlnm43s6+S3wmhl/aOPIYKnFsIRTmMTjtnxGRehAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPRLP4ULOcfZ14d67KP8L9HIv+H/Zh/zhIR6ZHVbkCM=;
 b=SGtoyolJlXf1tdcEBRt+m1VAmFUoER6J9qyck+EY4treslbUdsF9G/NL6w9kjSRetfgS/6TIkLttTy1ObBjWvEiO0sRx/KEpnT/yznZJPdZR2nmsciYbfpYA0ItqkueqboacwNrhraIQHN1xnxxfGcZQ34zKkR/PEBAEAWMaal6SxJtntCurnJT9KqnHZ8kIcmuV0QPuiOW/UT46Ljd8ymXva/kqi7zCiLymvkjEpd35yKLVnr67jU39p3pUDQAq/eFhQrrttVMn8bm2tYkOBAN91xItmYfZOriFyGub3yhJpbTCRwwaYMFqvBTHV0yrjkIaJsdhR2dBfk/37fGOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPRLP4ULOcfZ14d67KP8L9HIv+H/Zh/zhIR6ZHVbkCM=;
 b=GmvE6q3mxRn+xF8wCmvqMTYSrMQmxRLC3RsBWFCTNJy/0YQuKrI6GmRXjjjuzt6YZ/OPjQQZnbqLnAz7jmXvu7ADyACjH16DBDEKkNacCQxqgs6wWOlfmJywI/EC4m9W9/m/uhVnH69IR2OdzxmNiKXU4KvABI98VFNY1nhcrCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16; Fri, 17 Dec
 2021 22:19:29 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 22:19:29 +0000
Message-ID: <79c91197-a7d8-4b93-b6c3-edb7b2da4807@amd.com>
Date:   Fri, 17 Dec 2021 16:19:25 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
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
Subject: Re: [PATCH v8 08/40] x86/sev: Check the vmpl level
Content-Language: en-US
To:     Mikolaj Lisik <lisik@google.com>,
        Venu Busireddy <venu.busireddy@oracle.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-9-brijesh.singh@amd.com> <YbugbgXhApv9ECM2@dt>
 <CADtC8PX_bEk3rQR1sonbp-rX7rAG4fdbM41r3YLhfj3qWvqJrw@mail.gmail.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <CADtC8PX_bEk3rQR1sonbp-rX7rAG4fdbM41r3YLhfj3qWvqJrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0066.namprd12.prod.outlook.com
 (2603:10b6:802:20::37) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76c2395b-bb67-47d5-aa87-08d9c1ab4b18
X-MS-TrafficTypeDiagnostic: SN6PR12MB2718:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2718BC14919A6ADD58F21F06E5789@SN6PR12MB2718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qpYLGE0ouAXiiRoLleFUF+HF1r6cf0gz3ugigCXjy7t0WFYYKlzjk9I4q66skxjjl9kvoVLOBwEMYnWUYotNYZm1p0rDZsM9imVhdSRVsQS4knjmoLtnhMPQA2a7wJUOQmYUYAKEF6Uy74TOjwcnjfms19LNfcDxMwhjlflnys2kwCIre4UlNpS4dNvGiMaBJ9/DMSWupqpjHhb21aibhrS6TyzWCaShodp/h2Wdiz62FqSPJGwJde5Gv6lnm7fg/RIh8/QLwXJPhvykku/W7WPtfuF/H0Ff4jL0YgI7HoCOtbvffWqWADlp5rIGye7KXmRcgV+Wit6p2rWta1kAnDCk7LMy77ILFxfUmCCUwF+MuoeVv6cdEFKHNeyq7PlUysmppByvjkTbhX++ur7kTqmvnZcrd13UQvpKFoSyENdT6pzUVjuwFW+Ed4EsPDPBc2i5fa1yoYc8/rcasLieR/2K1yc4Lf6wZd/cg97j0pdx7x65MOuzk1zz/Vx/xNjjZAKzVa7VQZ77IiHIpXisbE/FXG0BzdVqYjXLecR5gseOXkiourZBl2J9ns2qRb5VSi4/gUb1UkGol7A7Iz7QoNzODn/PjWXwbjE99+n11LlHJuvyUlfzkosNl+fGhA4xXC8aVf0FviFc/sQHy+kP1kVy4Dl6GbWkkTrCWtiGtPQPrnA393mZU1u+CF3Jh7mGxhiNfxfyOywaM2AODALD6sqRKwXtruI75AfvWYEKIagseyScZ9YWE1x6cpEj4XE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(4326008)(36756003)(7416002)(8676002)(8936002)(66946007)(31696002)(44832011)(7406005)(2906002)(6506007)(26005)(6512007)(186003)(2616005)(53546011)(4001150100001)(6486002)(6666004)(508600001)(110136005)(54906003)(86362001)(31686004)(66556008)(316002)(83380400001)(5660300002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3BUV2VnVFBPK0NCS1lIdlVQbW5uN3NuNWN4WmUrUU81Zjg1ejZvbDlXWnFm?=
 =?utf-8?B?bk04SUpMQ015WXlKYU53MWQ2NHJCdXNzSy9ENE4rWDVFUG53Nk9ITnFmWWpp?=
 =?utf-8?B?ZEhYTDU0ME1LcXM4bmovaHVvTTdDaUg0QTcxTW91WW5CejZqK1IvME1sMzBu?=
 =?utf-8?B?Q2wyTkp4ODJEdXU4RkxhajBNcmluODhneHRadStUZEhYeTlaUU9GODFwdWRO?=
 =?utf-8?B?WDcwTnFwa3J3eGdCV2ZrR3RVZFYrcmhVN0U3S3lXenZHVGRaWmE0V1VidzBi?=
 =?utf-8?B?UkFvSUxrb2xwYmdQTFlSbU4wWW9aRzIzZU1oNEt2MG4zWS9SSFREdVhBbC9L?=
 =?utf-8?B?TVptTm9jMHYvQzEvTDFoSWlnMnJCekFlQWZ6NEdNQkoxTnlhU2hXTEY3ci9h?=
 =?utf-8?B?S1dhQTlBWm9LVEtsOWFaSkpyaXcxemxBYjZLNnFFaVlBbjZLOVJsTXNNdVFM?=
 =?utf-8?B?cU5HY0xwTkJRSkpwQmJhc0ZrSTJZTWJQeUU0Q0RRbGZtcVhPZDZGd2VtUzFS?=
 =?utf-8?B?ZmNjeGlMbGZscnlCTm5SQXU4WVJmN0dreE0yVjlURHdOK3BEdHdNN3IwTE5M?=
 =?utf-8?B?amlYRlRJdlNXaU56TTJuQlYrRm1BQitMbXVjaVc3bkF1NVNmYnMyRmJRekRk?=
 =?utf-8?B?REdGM3lZVHVIbWJ1WmtkaWdEa2VKSUJacWRteWZaQXZ4UWJXTVExSHVlcFZ0?=
 =?utf-8?B?RklhMm9wRDFTTzIyZVlDNEdRLytWLzJ3RXU2cXQ1ZFNncU5sNWxLbkFNUXdS?=
 =?utf-8?B?dEc3enhHLzBqOVR0dkhyaHpRbzlOYThpaEQ1ZFEzOE9ZTVhsK3JidVQ2NDh3?=
 =?utf-8?B?RFNiSXNRMkdCYzd0VTliV0tUNG1PbkJFSkZ5cDRCL1hNRCttSFJZa3h5ZWxR?=
 =?utf-8?B?MGk4RmhrYlpiN0hjZzBhSEZ5Q25KaUR0eklpazBHN2FpL0Zha05WNWQ0OVl2?=
 =?utf-8?B?YnNSV2xYSEZPVGgrOTFRNURoWUFYc3JBSTFIYnpzTVlEMC94RGJvWkhtUUVy?=
 =?utf-8?B?MUNXU1hQVytRTFplT1oyL1hRMlQ3K0dNaytOQW9POXRJelZ2S0lYTmdKWDBt?=
 =?utf-8?B?bnZvTG9iWUZpL2JlUk55dFluSW41NXQ1UGdscVlpRTJYUm9Na2cwRUVUUTVK?=
 =?utf-8?B?c0pQb2k4RGdDbk5vbHJnNEZHVkJucmZBbEM2WW5ERVlXRGREbjAxZVdsZ2VF?=
 =?utf-8?B?NE14SmVrOTJQcWxoNlFpbUMyYlVxTVI1ODRHelZvNWdDTSs5NXFsUWVGcnZE?=
 =?utf-8?B?TDR2MjFQU2hWcElKRlpka2RpdmRzeW8vRWcvV0Vwa1RSRG9ObVZtREFUM3Rs?=
 =?utf-8?B?L092SzYvSW9vUnkwQllnZUtNVGJScEdESWFHdlJGRTdsV3U3dXVzc1VhTHYr?=
 =?utf-8?B?WGhJcXdGeVpKYTQ3TEF0VStaelkvUFRyY0hNZlhMV3pOUmV4cnlYSkRqZTdm?=
 =?utf-8?B?YnRFVWx1dHRocWVueWFZUDE0LzJ0YlkvRlhNVU9rVGl0QnJJOGprcVBSdGZi?=
 =?utf-8?B?ekhTNjJ6R1RhdkNEblZESURtNUNvR0dCaEdMNGltbXdVaHhmQ0ZaL0Q1cHpl?=
 =?utf-8?B?UVA3Q2xwa0xhdkk3dXI1TXk3cTNSL2JwY2w4MHFHOXd1VnFib1N6b0h5Q2ZQ?=
 =?utf-8?B?WUVodStNeFpkUE03VjRKUCtTWG1wR3M2RGZjU0pUakpYdlJib2pwWndSaFJN?=
 =?utf-8?B?ZVhnNHJ2TkJkc3lRajE1cGRyL0JrWXlNWUpYbjN3UUhLaTFtNU1pYWp0R3dB?=
 =?utf-8?B?Q0ZOWGhqamVHL1FRU3djNlZvRmdEcHI5Q3Z1Y2FYeTNoR3dBTm0ybEFBWG9C?=
 =?utf-8?B?N25hMWJraktEZm1wdm1wT3hRdmhlTlZzNTZ0TXl3bHVIdnRGci9HdkJRVVNX?=
 =?utf-8?B?VXR5emduWStUSDhubUE4Ti9ZMXd3RjBNQmVmd3VWaFlTbll1NzVUc1lXQXJl?=
 =?utf-8?B?UlM4djl5a0xIZU5vNExQUTljaThpbHk4WENxZzdaV1kwZDd4WThLQXdIVkcx?=
 =?utf-8?B?anR2M05ZUEZ3RlBhd0w3a1hYeStuRmZBK1F1TzBnc2lFaDFBVmVBRUVvQVB6?=
 =?utf-8?B?VEQ1MGtJZW0wVDRaQVk2RnRRajhFZTU0K2hOcjJuQmUxclAvLyt0NG5MclVl?=
 =?utf-8?B?c0VwbWdld1gvNzJGZXVsNXliS056QVhMbkhHY280WEZtWWFaWVBpR00ySnRt?=
 =?utf-8?Q?h7pjAY64Mz3rV4ehoQtH0hc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c2395b-bb67-47d5-aa87-08d9c1ab4b18
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 22:19:29.4920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOOsxkw7ung/ecwT/DG5dodQLgQg6TfR9YYSNrrE1VT0qFJmgKK8QE5XETqMeUZkp2c3BxJYNC4k6tChiDeEXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2718
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 12/16/21 5:39 PM, Mikolaj Lisik wrote:
> On Thu, Dec 16, 2021 at 12:24 PM Venu Busireddy
> <venu.busireddy@oracle.com> wrote:
>> On 2021-12-10 09:43:00 -0600, Brijesh Singh wrote:
>>> Virtual Machine Privilege Level (VMPL) feature in the SEV-SNP architecture
>>> allows a guest VM to divide its address space into four levels. The level
>>> can be used to provide the hardware isolated abstraction layers with a VM.
>>> The VMPL0 is the highest privilege, and VMPL3 is the least privilege.
>>> Certain operations must be done by the VMPL0 software, such as:
>>>
>>> * Validate or invalidate memory range (PVALIDATE instruction)
>>> * Allocate VMSA page (RMPADJUST instruction when VMSA=1)
>>>
>>> The initial SEV-SNP support requires that the guest kernel is running on
>>> VMPL0. Add a check to make sure that kernel is running at VMPL0 before
>>> continuing the boot. There is no easy method to query the current VMPL
>>> level, so use the RMPADJUST instruction to determine whether the guest is
>>> running at the VMPL0.
>>>
>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>> ---
>>>  arch/x86/boot/compressed/sev.c    | 34 ++++++++++++++++++++++++++++---
>>>  arch/x86/include/asm/sev-common.h |  1 +
>>>  arch/x86/include/asm/sev.h        | 16 +++++++++++++++
>>>  3 files changed, 48 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
>>> index a0708f359a46..9be369f72299 100644
>>> --- a/arch/x86/boot/compressed/sev.c
>>> +++ b/arch/x86/boot/compressed/sev.c
>>> @@ -212,6 +212,31 @@ static inline u64 rd_sev_status_msr(void)
>>>       return ((high << 32) | low);
>>>  }
>>>
>>> +static void enforce_vmpl0(void)
>>> +{
>>> +     u64 attrs;
>>> +     int err;
>>> +
>>> +     /*
>>> +      * There is no straightforward way to query the current VMPL level. The
>>> +      * simplest method is to use the RMPADJUST instruction to change a page
>>> +      * permission to a VMPL level-1, and if the guest kernel is launched at
>>> +      * a level <= 1, then RMPADJUST instruction will return an error.
>> Perhaps a nit. When you say "level <= 1", do you mean a level lower than or
>> equal to 1 semantically, or numerically?

Its numerically, please see the AMD APM vol 3.

Here is the snippet from the APM RMPAJUST.

IF (TARGET_VMPL <= CURRENT_VMPL)  // Only permissions for numerically

        EAX = FAIL_PERMISSION                // higher VMPL can be modified

        EXIT


> +1 to this. Additionally I found the "level-1" confusing which I
> interpreted as "level minus one".
>
> Perhaps phrasing it as "level one", or "level=1" would be more explicit?
>
Sure, I will make it clear that its target vmpl level 1 and not (target
level - 1).

thanks


