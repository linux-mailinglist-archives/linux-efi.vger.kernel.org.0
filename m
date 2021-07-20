Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7F3D0188
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 20:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhGTRlY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 13:41:24 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:48865
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229806AbhGTRk1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 13:40:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKfF22mV1mys/BeMYozTl9rUtDHSi2ZezWFzK8B9/WZLWjr9hqi1bCHWDOLRTnU4rDODWCVcCbZfutvY3tsDyIH95TEDlCUsTugaaZCUPeHHwjs3aN7iGGjyrjbel09EC4MAi47qldbdmtAJvD54y0WMj3/I+dOftepI1V6AmVjJDStYZTpyGCuaQv9vW+eQign+q8EteEeUEVRWujTU95MEz9XRwMo3JTTW5KaDQwdwv9FGWuZWTMt9bdAakzYf79TytHhLlxfq8r2LmZMua3VAtpdghYA37SCL4rwYzer6rB+d1L+jqYfbDUUTRwun8S4OMEF1iHY+b9i4KFEhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQvL9mgrsZFoa14eptlqseFHdBuDW42yZ0KwiBrzrdM=;
 b=f2hnWzQMeiizlOndy/oevE5w25eciq5AxSb6Oj5gn3WaKa2rF0Pd9uyIw8Lw3CuTBGwi/Jfm4mA95O3i7z4Him6PeGESJGlj8MQ5FepFLsouwSzlZ9GOEjNUER0dJqyVbWxmdep2vmNOl0OCocx7DZww7xpnARSDZVs8i2E4dMT1W18LBTkqIPbhYc1nAgdL8SCeiOltqNZRzm1HtdtdF/wC4A5XtdgndiXqVgKRE2Na+lW1mXh/AiA5hMcocuznkHyx/AiRN/HsPW8/P934vnHzMsnvsXya2gmfzID2JL/R+tpOzkREj23dyumhxfkujs823J96VzgwGwdnI+JoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQvL9mgrsZFoa14eptlqseFHdBuDW42yZ0KwiBrzrdM=;
 b=B0SzVH5RRotBCu0NtJ7sdL1Dc3YeY2SWUY2PX1WFNnFvIgf4YMKwv80hsDN/ui/wvz76pIGBAzoBTQPER/OqCjbD3tQSsJ9ug+JY08yiBTFbtg5+FK5cV4kKTQEzoS6oyu39RnFbKX1kUvs6Vob/ATGOk+9aVjJiQ7a51X/60bc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Tue, 20 Jul
 2021 18:21:03 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 18:21:02 +0000
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
Subject: Re: [PATCH Part2 RFC v4 38/40] KVM: SVM: Provide support for
 SNP_GUEST_REQUEST NAE event
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-39-brijesh.singh@amd.com> <YPYBmlCuERUIO5+M@google.com>
 <68ea014c-51bc-6ed4-a77e-dd7ce1a09aaf@amd.com> <YPb5yfKEyJjvDbOl@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <0641fdec-48a0-b3b7-9926-3ce5a6e53eb0@amd.com>
Date:   Tue, 20 Jul 2021 13:21:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPb5yfKEyJjvDbOl@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:806:f3::34) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN7PR18CA0017.namprd18.prod.outlook.com (2603:10b6:806:f3::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.32 via Frontend Transport; Tue, 20 Jul 2021 18:21:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c03adc93-d0fc-4988-857f-08d94bab21a0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45126E82A5BB031E157E04E5E5E29@SA0PR12MB4512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+g++qkCQOkub3JW5CHbH9wIVHJpBp2O2EEfdi0rfiJ3sstSYPiuyTh/5k5bKg1t83wmZq9n6kvDF2MrdIE3sMXl0LD6sydfCQTUnLRPhD4RJ4bM3k8sRDGrn7H1xKvdzro1KGEmzboffhND4tmmbVlg4glQm6XwLaL7SWBxLVosLGaxRYfps7GdRD1+qZ3K2SPxt07Ri0nG92LUE53cDzbloK6UhGiLE+cJynzXXtC7u7E+zahD21AEb0S/GI0dJA5W66A8ocVfrMAsVbkb8fD6YsX/JqSq7b9Fmxpw4SxZPaegvcJ3xV1oIkGTmLbKhJLKmU+49GeJ18u35zZpZNcg6zrMV4hLSfcpYYI2/4kzXm/ueKszzYRTzSGfzHdIXzYqe7PPHFMA+gymOQ3/mSZ7OCqsyOB+4LJSAPri5UMVFyr5EajtZSMJ505ZwYuxaNTz4N79zWlYMgCrn0CZasQd+h0m/nVSeTmN0w89NCv6nWOa6+vNWF5iBrEkkvT2ojvrt5Sj/Co9ByBgx4kXW0Y0kiyo2VwUHlcpPbYWIDu4iAZi9qqF0MjbKdSc4wn5WyLyo8uvAeThGx+N8GZN8AGKPleX02+YiZh6XfzxfhB/20A9Ju1LGDndPAld7SIpc0CTNUaMBcmAIv5rYdFJV/BrHJhDa9hlWpq7pEmb7KipSfmVGUrhfeWWczTu8xidjQu5jebp+AJSqo9YoQ1Dh9HKTpffdeM9zMCuSDnMWVlwFv8bzH3+OPhABGuXjIO8Q8WPOtJNXLVHdZZwY0GEtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(44832011)(478600001)(7406005)(86362001)(8936002)(6486002)(52116002)(26005)(956004)(7416002)(2906002)(66556008)(66476007)(8676002)(53546011)(186003)(54906003)(36756003)(38350700002)(2616005)(38100700002)(16576012)(66946007)(6916009)(4326008)(5660300002)(31696002)(83380400001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE1zTUxJUWhyRUlyUUNoRVZnTEJlRzdrNnFSc3l4dzhjWW10NlhoMDZUTTBn?=
 =?utf-8?B?eWZ1TVpwenBCam1CTTR4c3Y4czhSVHU4Z2JIOVdpbGFCK0F2dGcwaDlyVnBF?=
 =?utf-8?B?YmF3dTFicUswNTBSRTc2Yk9qUWFTZmdDdmR0dUIzeDhiczJQclhySU5WcmpP?=
 =?utf-8?B?Y1NuOThheU1iY2tGLzZxdkN6OXVhQjNWYW9ZRGtDT0JPaHZkQzVPRDJhVCsw?=
 =?utf-8?B?djBWMnNFdzdWWGhzUHNUTSsxT25pWXdXVm5SYkVrNFFYRGxGcTk3RDhUTnI5?=
 =?utf-8?B?VHlQNkdIM1QrZFJ1dW41eG9NSXlFYmhiNy9uQkhZL2wvRWJYSUc5MW9LWGg1?=
 =?utf-8?B?UHFBUWhBUDZmZVhhTU54ZXZxY3ByWnFzYUNPWWt4TUpwVUtGYk5ENStTdmZM?=
 =?utf-8?B?bm44Uk5qZE42a3R6K1ErcnMzWGVoa3lHeWZPeXRPbC9tL2FBWnBDVmdyOEU3?=
 =?utf-8?B?WEhyeVRaWTltblU0WkM5Y1FaOS9uREUwcXJZcWUvcjRFeUJMclBLTnNtNzZ3?=
 =?utf-8?B?KzZHUU5pNGozRXNmMlUxNHhSdjgycWZVYW0rdHV4NGUrLy9UbDdaYUdpTUlv?=
 =?utf-8?B?YVNGSDM5dmxONW9OejVPVk5ZV09samwyWUtZR0o0dUFaYTV5WENNWnNiNnlR?=
 =?utf-8?B?ZG16Zk9PNXRrQTdudkx6NzhibjF3ckp4aDUyTU52NUlHbTF2Vkx1cTlPTGZ6?=
 =?utf-8?B?TFR4WUVHOXlFdXNNVDdvT0xNZjNNZWlka0ZnbHlESnlGUlRrZEswVlNaSzZ6?=
 =?utf-8?B?U2dTeTVEZW1NRzBoZ2Z2V29ZYUJCSzA1U1VLSHo3bEZ5UjlYUEltSk1xNDI4?=
 =?utf-8?B?b2J1alVkVzd2NWl1Wm83N3dTcitlNlptRHNERndJdHB1RnYrNHBqNXZnb2Vi?=
 =?utf-8?B?dlNLUjhwcHkvcXY4MFRmcHRrRDJrNWxHQXJRYXhhK1lWUWxZR3k4WUtQYy9z?=
 =?utf-8?B?aVpENFNUeE9GbDc1UUs1NnZvY282ck5iODhYUDFlV2ZvTXFCQi8yaktQQzZj?=
 =?utf-8?B?dVBqa01OSTNoUlIzemxlcVpqY2drVHQzTVZsc3NSZnVVQzI3bWpKZXhpV3Iv?=
 =?utf-8?B?Y2Z4UDcwSmpObUdOOHFyb290Ym5xV21xcUZQTytvbjE4emFSQlZCTkJSK3NG?=
 =?utf-8?B?R0xUTG1RMU5RUDA0ZS9lbnBTL1BEU3ZaS3lRbWY2MjdiVkJqVlZTQkZKdnpB?=
 =?utf-8?B?MWhyQ09SMWdaL3pvT2xvUWIzRC9YanFFbnNDeEQ4ZS9VWWIrMHduZ05Eb1pX?=
 =?utf-8?B?dWl6VjdVTmRLVVpzM0ZQK2lXRU1XaWY3Vm50MWF3VlNvWHdHVTJsN2VuRjAx?=
 =?utf-8?B?dzV2ZlVQTmMrSk8wamJFS2ZaSmNYUEN3NlBBQnBsM01JSGdsV3VvdkZ2ZEI5?=
 =?utf-8?B?TE5wempuOGlHeTBqdGtKdy9XcHNoYjF0MFk5KzhjZmlLNDZYVUFnVjI3MDN0?=
 =?utf-8?B?eW0zWWUzSFhlaFVORU04T3Q5UTdob1ZlZFFBVmlnRkVKdHowSlVDeDJ2RTZo?=
 =?utf-8?B?VjB3Nm94em9BTkdLOSthSkhiV3RaV3pUVkwvSWdMZ1NoOTh6d2hZT25EcHJx?=
 =?utf-8?B?N2Fsa0hJVVhTZjNOZDFpcWRja0tyVGRvZVcreWFwYVdHdGNiRHhJckdXUWJR?=
 =?utf-8?B?TlE5T2dSQTdKV1ltZlhPRHQ0aDRDVkVKcHpmV3pjZlRtNkJxY2VJSGFWeTNS?=
 =?utf-8?B?MHl2c1lMMUszYzJSRC9MSXJrcG1UWTFNQ01LYTBjNnMrU0xKYWZSSFFJYkp2?=
 =?utf-8?Q?RTxCAxNw1jbTtb7uAhA34GFhV07P6DMlMcvEXZZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03adc93-d0fc-4988-857f-08d94bab21a0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 18:21:02.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyQCkiKVEfdNWXht6XjLvSzlP+xuWGj4lgHJ5EuOwc6TKGmqjn9om9c4PXQ9T1sC3Me8tXvI5HpAGEnbAE+4RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4512
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/20/21 11:28 AM, Sean Christopherson wrote:

> 
> Ah, I got confused by this code in snp_build_guest_buf():
> 
> 	data->req_paddr = __sme_set(req_pfn << PAGE_SHIFT);
> 
> I was thinking that setting the C-bit meant the memory was guest private, but
> that's setting the C-bit for the HPA, which is correct since KVM installs guest
> memory with C-bit=1 in the NPT, i.e. encrypts shared memory with the host key.
> 
> Tangetially related question, is it correct to say that the host can _read_ memory
> from a page that is assigned=1, but has asid=0?  I.e. KVM can read the response
> page in order to copy it into the guest, even though it is a firmware page?
> 

Yes. The firmware page means that x86 cannot write to it; the read is 
still allowed.


> 	/* Copy the response after the firmware returns success. */
> 	rc = kvm_write_guest(kvm, resp_gpa, sev->snp_resp_page, PAGE_SIZE);
> 
>> In the current series we don't support migration etc so I decided to
>> ratelimit unconditionally.
> 
> Since KVM can peek at the request header, KVM should flat out disallow requests
> that KVM doesn't explicitly support.  E.g. migration requests should not be sent
> to the PSP.
> 

That is acceptable.


> One concern though: How does the guest query what requests are supported?  This
> snippet implies there's some form of enumeration:
> 
>    Note: This guest message may be removed in future versions as it is redundant
>    with the CPUID page in SNP_LAUNCH_UPDATE (see Section 8.14).
> 
> But all I can find is a "Message Version" in "Table 94. Message Type Encodings",
> which implies that request support is all or nothing for a given version.  That
> would be rather unfortunate as KVM has no way to tell the guest that something
> is unsupported :-(
> 

The firmware supports all the commands listed in the spec. The HV 
support is always going to be behind what a firmware or hardware is 
capable of doing. As per the spec is concerned, it say

   The firmware checks that MSG_TYPE is a valid message type. The
   firmware then checks that MSG_SIZE is large enough to hold the
   indicated message type at the indicated message version. If
   not, the firmware returns INVALID_PARAM.

So, a hypervisor could potentially send the INVALID_PARAMS to indicate 
that guest that a message type is not supported.


>>> Is this exposed to userspace in any way?  This feels very much like a knob that
>>> needs to be configurable per-VM.
>>
>> It's not exposed to the userspace and I am not sure if userspace care about
>> this knob.
> 
> Userspace definitely cares, otherwise the system would need to be rebooted just to
> tune the ratelimiting.  And userspace may want to disable ratelimiting entirely,
> e.g. if the entire system is dedicated to a single VM.

Ok.

> 
>>> Also, what are the estimated latencies of a guest request?  If the worst case
>>> latency is >200ms, a default ratelimit frequency of 5hz isn't going to do a whole
>>> lot.
>>>
>>
>> The latency will depend on what else is going in the system at the time the
>> request comes to the hypervisor. Access to the PSP is serialized so other
>> parallel PSP command execution will contribute to the latency.
> 
> I get that it will be variable, but what are some ballpark latencies?  E.g. what's
> the latency of the slowest command without PSP contention?
> 

In my single VM, I am seeing latency of guest request to be around ~35ms.

>>> Question on the VMPCK sequences.  The firmware ABI says:
>>>
>>>      Each guest has four VMPCKs ... Each message contains a sequence number per
>>>      VMPCK. The sequence number is incremented with each message sent. Messages
>>>      sent by the guest to the firmware and by the firmware to the guest must be
>>>      delivered in order. If not, the firmware will reject subsequent messages ...
>>>
>>> Does that mean there are four independent sequences, i.e. four streams the guest
>>> can use "concurrently", or does it mean the overall freshess/integrity check is
>>> composed from four VMPCK sequences, all of which must be correct for the message
>>> to be valid?
>>>
>>
>> There are four independent sequence counter and in theory guest can use them
>> concurrently. But the access to the PSP must be serialized.
> 
> Technically that's not required from the guest's perspective, correct?  

Correct.

The guest
> only cares about the sequence numbers for a given VMPCK, e.g. it can have one
> in-flight request per VMPCK and expect that to work, even without fully serializing
> its own requests.
> 
> Out of curiosity, why 4 VMPCKs?  It seems completely arbitrary.
> 

I believe the thought process was by providing 4 keys it can provide 
flexibility for each VMPL levels to use a different keys (if they wish). 
The firmware does not care about the vmpl level during the guest request 
handling, it just want to know which key is used for encrypting the 
payload so that he can decrypt and provide the  response for it.


>> Currently, the guest driver uses the VMPCK0 key to communicate with the PSP.
>>
>>
>>> If it's the latter, then a traditional mutex isn't really necessary because the
>>> guest must implement its own serialization, e.g. it's own mutex or whatever, to
>>> ensure there is at most one request in-flight at any given time.
>>
>> The guest driver uses the its own serialization to ensure that there is
>> *exactly* one request in-flight.
> 
> But KVM can't rely on that because it doesn't control the guest, e.g. it may be
> running a non-Linux guest.
>

Yes, KVM should not rely on it. I mentioned that mainly because you said 
that guest must implement its own serialization. In the case of KVM, the 
CCP driver ensure that the command sent to the PSP is serialized.


>> The mutex used here is to protect the KVM's internal firmware response
>> buffer.
> 
> Ya, where I was going with my question was that if the guest was architecturally
> restricted to a single in-flight request, then KVM could do something like this
> instead of taking kvm->lock (bad pseudocode):
> 
> 	if (test_and_set(sev->guest_request)) {
> 		rc = AEAD_OFLOW;
> 		goto fail;
> 	}
> 
> 	<do request>
> 
> 	clear_bit(...)
> 
> I.e. multiple in-flight requests can't work because the guest can guarantee
> ordering between vCPUs.  But, because the guest can theoretically have up to four
> in-flight requests, it's not that simple.
> 
> The reason I'm going down this path is that taking kvm->lock inside vcpu->mutex
> violates KVM's locking rules, i.e. is susceptibl to deadlocks.  Per kvm/locking.rst,
> 
>    - kvm->lock is taken outside vcpu->mutex
> 
> That means a different mutex is needed to protect the guest request pages.
> 

Ah, I see your point on the locking. From architecturally a guest can 
issue multiple requests in parallel. It sounds like having a separate 
lock to protect the guest request pages makes sense.


-Brijesh
