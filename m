Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F253DF075
	for <lists+linux-efi@lfdr.de>; Tue,  3 Aug 2021 16:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhHCOjP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Aug 2021 10:39:15 -0400
Received: from mail-bn8nam08on2068.outbound.protection.outlook.com ([40.107.100.68]:2467
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236631AbhHCOjN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Aug 2021 10:39:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPVAJr2Xus9E1/vmDRbnILZjAGh/L6JiNlgnIwTDnwSTWPrWdPdJxokLYEaR3DJMaDety1+u3RIEYOUbcNsyOnmZYDM0ljMhCFcgabD73P2Hw6Z5h0dB99p54L8q7wCXuSP+OmSNhe2vsp/qZ7tqbgeWv0xq7nGGTX+Jw2H+gFXHLCAj0KZVxP0SbKJcrwt9tJlWghK82Cqzy/3atPZcBtymiyvOvbPxi+zMVLyGhgJJsBNM/iZvMuF5sgfB9HqZ1VuSQ1cUX0emcxXqvBsIGHwdG5AXNMIu9Wpgc42/ksSP5N3LNVvLuqT4uis770p/TWIMzEsSJ+jtk8TvAkFCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq7LZZ4ZwwPEecSecBs70GDoJrELJf8DMXZrhLOTNrc=;
 b=gO4HcSkoRl4YwezXAZMuPC7U6UDJURp5Bc/mPUUqCsHZzI3rrHtp/TSFjTF3Xh0QF58Ip9kBuEmkwRiOLMiBQU4T1c/dCVKwaFJ+HPJOtMrfFa9QR27wZqRv+SqHBs+y5KSFim4wiVS3Fbo+mwnUjGucydDDYGb5f0/a/t9o7ChpU4R0MSWfsBFrOznyNz/zLNrBYx5xuxu6veS0Rc6Y18yT+6p0eS5WLz/vvcpuf+zFqDJq0jJN2tvBGYRJHt99JUCTLBw4SMCH/21f487DzhB6ZL7tl1qp5s7u8Zq0Qu5H3tuIEuQyDu+9xQabu4yuJ+SzkkveAxxqQy6wdzN4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq7LZZ4ZwwPEecSecBs70GDoJrELJf8DMXZrhLOTNrc=;
 b=sGxbtZiXGRhw3Dsl8vW3H8FrTGbCefe/wI3CpWDCMNwO5dT9owtG/NWUawCL/4y6kols+ebvXBXW/SsenLYh9B3yyJW0UkA3BKgMptM2SMqc6K6SPmfLVVehAmEK2PeCuLhCzd9yHRK+yXEmUw/YQGE0AlKNra76C0QGlhUuc9o=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Tue, 3 Aug
 2021 14:39:00 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 14:39:00 +0000
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
Subject: Re: [PATCH Part2 RFC v4 20/40] KVM: SVM: Make AVIC backing, VMSA and
 VMCB memory allocation SNP safe
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-21-brijesh.singh@amd.com> <YPcPqpqRju/QLoHI@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <898be17b-cc2c-cceb-5691-4efcf693d994@amd.com>
Date:   Tue, 3 Aug 2021 09:38:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPcPqpqRju/QLoHI@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0001.namprd07.prod.outlook.com
 (2603:10b6:803:28::11) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN4PR0701CA0001.namprd07.prod.outlook.com (2603:10b6:803:28::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 14:38:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0992472e-3c2c-479a-eaa8-08d9568c6e5c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB241441DF6640FB9ED40CF02BE5F09@SN1PR12MB2414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: diUTUAI0MOngmvbjD4xs8cbeuO9MhamLs0u4AlOrFRoGhgGQ/Ykcv1ewepcYT9uccoNTXKrrSpBctiQo6wmc+/WJM50zYvMXNJolbzRNJBggS0S+CZQKVMwccaC5BX2ILUc8G3PWLru9xGzz9JUi2YhupV3QwjzUl2CoMolI+gG9lqDO1qO0sYvSKYVBV6d2b1aYZJckadtJzeGrNJA2ZpSS9twMVY/DFqVPRfcummgAHhZqbYFxXqmsMFZk9vM1KYRYjv4NST3yCGPIOfc2B7lUh6UY7DqJjbdg/bB8kn2UKeAl7YOtc2lPqlPHF7BO1YgFwOns57Y/+2vw4zZ/MU5CnpPeGY4Y1C3QpTUyynmg6EMB5m/T364oMXb03ZKspA63tACyu2kybyKpFI2G4LH8UXVOC7nayCeO5dWOqlsnEpi8zDByICsW4L90EZoq+dxnCi0TS7yF38QFzijLeJQaFoGhOYPaqi74fN3FVDZIUG5PnESfRxdU4eEGXV8+VU+fi7UbJuN2x2clQ8FE3JmlXJh3trw0z17CxDgy1Un1pQQuLZb8isTp+3ELHBBEjqWOwqE0uzj8gUX5vaADPQaEQhJkp9MfZrMpc+bRW+Lp8ygukIiiFH6h2YsdTwNu7Sx6PaGgoI018+yZApaWgjgnJ9CNdoxKvBsvZfXm9DVCC5DD/rZ5W66NW2hdBcEJYHGlxRJLz5UiD4ChHR311iqlr4bOyvxcvXpr7BxWVcMHMeoso2RijdfbBZaN1KHLmblr2vbz4ni3HRmD8i3uOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(66476007)(26005)(5660300002)(2616005)(66946007)(86362001)(186003)(66556008)(44832011)(956004)(31686004)(7416002)(478600001)(31696002)(7406005)(8936002)(52116002)(4326008)(16576012)(83380400001)(2906002)(8676002)(36756003)(54906003)(53546011)(316002)(6486002)(38100700002)(38350700002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmZEUlR4bFVmWnBqOTRNSC9uTm9zMVBhbFNEejh2QXEwUUc4L0NnRGxvZ0p5?=
 =?utf-8?B?aEpmaGhER0VCL01md1Jxa2hkVEx5OG1Ja2VUOGx2czQ1Y01lK1VLai9SS1px?=
 =?utf-8?B?SlErUzdRSis4a0cyODcvcTdpdFlQYmtNR1g0OTVRcGExMHRsVWFGZm4zOFUr?=
 =?utf-8?B?ZXc2bThJWFdPKzA5Qndpb3ErK0JhbUhGWVBzQXRVYmN0YUczSW9wSTFwVW02?=
 =?utf-8?B?VVAwbWtwYTd0RzBrU2NmdDFiQjArb28rb2VhV0FMLzdQS0VwVnM3TTVGYVlD?=
 =?utf-8?B?SmI1M0k2WFR6cllqcGdFR25qaE5mZkpzMytWemxZUi9ycVNxZ2dOaEZPaUQ1?=
 =?utf-8?B?MVpVNUNicitVRWc3d09rbUdVc0QwQVVxV3FyN3BzSTQzVi8rVHNhRThmVHNR?=
 =?utf-8?B?MS9tRGh4b3lobHgrR0dyLytVTUllbE94K2xPOVFiMUMxaVd1emNqNkFiQStY?=
 =?utf-8?B?UWo5NzR5RWx3MFNROCtNaXVMRHR2SE9hVE9tazFaUW40ZEFCU1FyVUI1Q3hh?=
 =?utf-8?B?QTVidVB6QUVFNXM4QWw1L05KVGZjWkZQZzZIQWR4OEJVQWNPOERYMGlUam9l?=
 =?utf-8?B?QnJjc2tERGhxNWRueURsT3Q3UHRSMXdjbC9Ib3Z6amwyampSZVN1d0lGUS9l?=
 =?utf-8?B?OHgwRUFiMXVYTW1KdXBoemxJeVpmczdCemovcis0Sjh1VUlmL0UzdmFSd0JG?=
 =?utf-8?B?TU1BWHA0dGhtZXlmUkdyUDE0cnI5VmZUMG9LMzIyc1dpRVoxNmZMWXNIWTRC?=
 =?utf-8?B?U2FsNFRXODVrSGkzVmE4THdvNy96TTBESkEvVU5oKzRrc0NneDE3THlLMFFz?=
 =?utf-8?B?NWdHcEMvczRZRlZIaHpzYXFFS1JDdTdlYmdQdXozaXBqWG1rZEZWSnVmM0hM?=
 =?utf-8?B?Zk56TFh6cklPNjNqbGI4TUIrK1RLcHNBNjNHWnQ0L2NLblZJSHRwWmovRG9Z?=
 =?utf-8?B?MnF6QjlwM25pRnFtaTlNeXhkM1NLam1hTW9IMWhvUnhyZEhhSHU1UndoQndR?=
 =?utf-8?B?WlZtbldSTkY4c0RVQlY2UzBLNHNrSHQrNWVzcDZzNThlNEp4Q3diVFBOQkt5?=
 =?utf-8?B?T1pzSjZWcmpJVDRzbmFMUGVpeVYvRnE3d1IvWFg0M2VLQ1ZSdm5PS2oxWWZJ?=
 =?utf-8?B?clJKRzJ6TmFGRE4vcjNCdEJHeC92T3JrZW44bWViOHdTL0JYQ0NwNHN5QlBX?=
 =?utf-8?B?cldHdzVVSnpiVnhrRm5mbEU2NjVaVVBpT3J5YklwMGVTdGgzalR0b3h0VE5F?=
 =?utf-8?B?Ym5yQWlmeGVTa2tyemtuTzJyViszMUhOVWxvL1I0ZVJmTkF4NCtHbzRscWE2?=
 =?utf-8?B?RXdKM1UxNzNuYXhwREdDOHFGQjBnR3VTOWhRakZIdGR6Z2ptTHNpcU9uNWZW?=
 =?utf-8?B?UHFlSXpVMS9YTE9NVU5LMkpmR2pubWRpeCtHVmFtY3M5dkZxbGRIbzRXQU1M?=
 =?utf-8?B?Q1BrZ25CVGFNSXBLdEplaVdqSFBvVUhwaHVTbE5mV1BxNHNSVytoV3I2VlJU?=
 =?utf-8?B?SnZsYzBudXhTSE5ycnRxMmVGV3VYOXdOak0zRUFnNTBBU0psZmNmUkZ5RmxK?=
 =?utf-8?B?SDgxSm5hNFhQSXQ4ZlJ2UnZ6TFZuUVRTaGVPMDJrK21QZU9HRTh3ekpKb2RF?=
 =?utf-8?B?VVgxZWNKZVM1YWRTc2ovdWRZQ2xDTG9tS2dDQ2VFL1ZTbHBOUUlOdG9yblh6?=
 =?utf-8?B?MW53Yjk3R29abURGZFlmd3hmdTMrYlIwcFhkTklZQVEyMjE5OHl1NkNFcDAx?=
 =?utf-8?Q?1VzI1rbOG1O9dPT+AkxET/FXVjSlToPIGcHkbeJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0992472e-3c2c-479a-eaa8-08d9568c6e5c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 14:39:00.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRPxUrR+4LioUbhGukCfhYZjRiBqtNp4YRO5Z8QMG/YZdwgpsUzh/4n1Qe+3f7/N5SvI7SIqrUuWTLa+VvmTbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2414
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Sean,


On 7/20/21 1:02 PM, Sean Christopherson wrote:
> IMO, the CPU behavior is a bug, even if the behavior is working as intended for
> the microarchitecture.  I.e. this should be treated as an erratum.
> 

I agreed with your comment that it should be treated as an erratum. I 
now have agreement from the hardware team to publish this as an erratum 
with explanation and recommendation. This will certainly help in 
documenting on "why" we are making the page split.

...

>>   
>> -	apic->regs = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
>> +	if (kvm_x86_ops.alloc_apic_backing_page)
>> +		apic->regs = kvm_x86_ops.alloc_apic_backing_page(vcpu);
> 
> This can be a static_call().

Noted.

> 
> This isn't "finding" anything, it's identifying which of the two pages is
> _guaranteed_ to be unaligned.  The whole function needs a much bigger comment to
> explain what's going on.

Let me add more comment to clarify it.

> 
>> +	pfn = page_to_pfn(p);
>> +	if (IS_ALIGNED(__pfn_to_phys(pfn), PMD_SIZE)) {
>> +		pfn++;
>> +		__free_page(p);
>> +	} else {
>> +		__free_page(pfn_to_page(pfn + 1));
>> +	}
>> +
>> +	return pfn_to_page(pfn);
>> +}

thanks
