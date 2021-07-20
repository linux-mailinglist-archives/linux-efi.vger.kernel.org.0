Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C32A3CFCE4
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhGTOWm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 10:22:42 -0400
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com ([40.107.93.55]:48993
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237295AbhGTN47 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 09:56:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDk+0tb7xKDPU+voWehSMCUto4hkbRHaTDXp9LOVl3xWfxJkY61a+j5YGByoZlu6VJUiEApLRYEzjaajF3B5WN2ZrW/Wq8xmyK506R284RzSByg6QrBH/Jz9TLJT0RRvPLirZboRxfWUYp5g3+GouAwB79W1ynFMeHrdSLEW/kSwOS2h1XIRY18h06iLrjHOwLJsJDLbuAYM6iCglds/4aJsg9ZLYGGtZs5kNk7KwjLRWbYKfJRW67JCdQmdnbbZq05OfPjyq+FpkUrqLIFef22WgRzUSMj8TY/CR2HVO8qPJ77C/6QjY3ULBNJOaMa1bMGUGzm5cCTRYtFXgJFCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH7ehnnxhRu0ahip1dqwYRc3YAk259GorxYGnDSTluo=;
 b=lU0i6dDE4geeX/+i1x3nthGxkqBtEZkY23TceA8qWMHUafTot/x9n4NhIsEvTUENJcO/u2mqZdp0DOirv7+Y71+hvl+q4CB6jmA4EUwHoNVKZea3OyurFSKYBg2Js6Z3abJrEMYV9aU4+AisctNT2gV/rO6ZS0ARAQlXeYO9fHhCr4OUPZCsZZy9xhJqgeCLm04Af6AzZ+RrJnJ/4Y8O6xHcaqvO1s+G9pG3zgRyN2zoEqfwagBUyUc7KxUw0pq6jglG30q1EIzMSkMVhdVjsaHYB9bceETSG/LcJi+DTbhesBzg6/klU3RRK6oby4jiqmNEy3+M/AkxZaiEvoqrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH7ehnnxhRu0ahip1dqwYRc3YAk259GorxYGnDSTluo=;
 b=mnBjvHi9+uZEAN9U92dS1W9pkp2wDLO3InIN85YuETbjtKQb/76m5heZCh1UUDllG6+KhkzPSzpHjDcOiIPmVerVSN6RoBiOmpwVjVO7j1tcRukfN9QrTWqDhJN/2QSRhXVqezN/ui80O0L1y4JfaxUQocuAlNdsE3WvmKNaxFM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 14:37:34 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 14:37:34 +0000
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
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <68ea014c-51bc-6ed4-a77e-dd7ce1a09aaf@amd.com>
Date:   Tue, 20 Jul 2021 09:37:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YPYBmlCuERUIO5+M@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0086.namprd12.prod.outlook.com
 (2603:10b6:802:21::21) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.95] (165.204.77.1) by SN1PR12CA0086.namprd12.prod.outlook.com (2603:10b6:802:21::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 14:37:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40068fd9-7cab-44ac-bb4d-08d94b8be99f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4446C4833E76099E761CBB4BE5E29@SA0PR12MB4446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckiEHNeE1FfvR1tfWJeEkYkL9Rnk1WQXc8baSA7AXESsMwE54P3xHfhuvXdx7WwIVF258yk+Wh6/02keVzyL9XMhJ0tbFCw9+F1VkTxI/FoPrYypkKzZJ2NyXF7Oi7KXtFRJ6nSm6UdRAnqCBnx65MU2L90DpCOCjrjtX3rLpccwRbTRvdAjj9O+r2bSD+7HtQMxL3jhPTOPkFLCS9GJ4j6cJXQRRzzJOw/c0rDsG0v78R1q3Zypf9vO9T2/xdvM9agK+l7hxStDeTSxghUuCxzUCficFZd0weRZJVHQ9DDk+gH23PFx3p0rD47p4ocUkjwEWqVSqBB3821sStGqMKrc9INnop7lWYu+STEbozUB2tLzEIc7YZtBpBJfeFYJNHL9qTqObADNV3srp+pMHOSoyInDgvi7+s4ItLDwhAQIVgZ7pSHfInUl1jHDwFH1cCJmoGJaWXU83gabbTaoemUadpYL/JAQ1sHo6M243AxlKC9QgLJE+mbCbm51sf+rzdLwbjbeuJOUGBowzR6o6Jpr8SByM+Wt9M8uaXq45UFFQMsvThEvlSv6JEjjBgEaL1U5SzoiepxT9HWR4sPnRqBYY1TT+hcRmwwUjFsDeMd2MNdM1Hw/tvrwbofJTlg6cNzyC+0w0rroTTB+KTNUE6eEJQU9GtvVZ7cJf83bIJPwb0Cwsj4C5OHV6pEvmuuAeDXyE1ROVgnUBMoy9qWugkAmbWj1tHlNcxNT2N1uBbl6ic+h6ivYMaefzMCBaWeJ6QdeBi0TYejcx+XRt/Iv2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(36756003)(31696002)(83380400001)(44832011)(53546011)(86362001)(38350700002)(31686004)(66476007)(16576012)(66946007)(54906003)(956004)(2616005)(66556008)(38100700002)(316002)(186003)(2906002)(6916009)(8676002)(6486002)(7406005)(4326008)(5660300002)(7416002)(8936002)(52116002)(26005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkpGZTB5ZVQ3TjIzSm42N2hJV1VMRGFKdElvM0hsQXNXbVNydU0rdFp1VmNv?=
 =?utf-8?B?ODBERWk5bTB5TEs4Z3J5K2lLTllzaVQ2WXNVZDlCWXpJR0xwVUQzazJvSktU?=
 =?utf-8?B?eXdaZ25KMWsxODdKd1pOQkczejIzaWFXc3R6TDArQ3l0UnE4VlJBWDB1dW9y?=
 =?utf-8?B?VTV0QzdZczVySE5QeUFERlozMGNoNVdCVHFJRyt6NlpjTFdyY0FhTmFVRHNm?=
 =?utf-8?B?UGVKRjBwU1ZUZXZxelhyWTFrRjN5L1I1M2lSYzZpWU14V2trTUoySk11Uyt6?=
 =?utf-8?B?REYxeTJTWGtKUGlYSjJGNGFEaUxpSDJ6RnBqSFcvRmRLQVplNStnaXozbUwz?=
 =?utf-8?B?R0lOMU5GZDNtbTFLZ3BaY0xmTWxCMmJkU2EzTmhMaGpuSUF5ZndXRzV3QS9L?=
 =?utf-8?B?RmV4UytMYjJZSjZzVzNNVElFRlJmZXdNZ2s1NzNySGl2YzI4N1RLV0dEbXRz?=
 =?utf-8?B?NEE1SjdLaXpFQWdkRnFraDVzY0lISEpCRFVWT05oclQ2b0E3SWRWOWhoUUlE?=
 =?utf-8?B?anFOWC9ORWppejhIdThHK3dmclJQZWMyQVhGL0k0RDl5U0NlRk0zUExYVTFQ?=
 =?utf-8?B?ZVMxNHQ4cnRZWWNIdzIrUjlGM0FEVXNqZkVzY2lobU83MitoNk9JTTNiNys0?=
 =?utf-8?B?R212MTducGhwbm84Ry9kVkxtYlpuTi9QeTE2d2k2QlVpYjQ1VTZMS3lhMGVy?=
 =?utf-8?B?OTRQK2QrcUdiZkRLRWd2WHF1MnVJYU1XYzBvMFFzYTBWOVI4cUlLbzBxTGEx?=
 =?utf-8?B?V1R4Q0tVbFc3WWEyb1BGckw4Um1iaVJ0Qm1YWEZCTUdRaU9DR3FhdTJrSlVG?=
 =?utf-8?B?SzJBQ1R1K05TMFZETUFQdFd2Ylg0UVIxWldBRXRneEMwVVpKTC92eUhtR3hX?=
 =?utf-8?B?bFhWLzd0c3J3RzF4L3ZGVUJYSGcybDlTcW9xb0lXdUtoVU1sMnMrL2dTL0E1?=
 =?utf-8?B?d3BlYmRRcklVQTcxUG5SK0p5RjZYdzR2dE02OHM4dU02QnJ6TTRub0J3b0tB?=
 =?utf-8?B?bjhCSnNtWUg3S2RGWnZEbUJ0dnRCVHcvUkhrSGM3anVlRkNMbDIrcXR4dXFa?=
 =?utf-8?B?bDhNNFNodk9jWlhGZ3FYMEhjZVp3bnJWWmVTUDNTR1NzbnRQVGNCcEJxUGU1?=
 =?utf-8?B?bWdNZXUraTNBbG9JRVFVV0xHbEp1cDFuZENoVjdTamU4ekZOSG5nUXpJK3Yz?=
 =?utf-8?B?VkpkcjhjbHpFUG16SDVXRU1pejFxMEppcmtYRzBIQldvSmhtQ3VBNXRGVVNV?=
 =?utf-8?B?Ti9vNHE2TlB6VHNCdXovK2VLNDdTZ05WRXF1T1lSWVdrdWhveWhMbTlnS0xK?=
 =?utf-8?B?K2J6VGxaWmRxd3lIYzRzdXc1RmY1ZkpxaHRIaytmcm5lWHZwOEJCdDNvVC9H?=
 =?utf-8?B?UndxYmdxY1J1OWxpaHZpeUt2YVoxMGpSQUpmaTUvdHZoQmowTFpENjNlRmRS?=
 =?utf-8?B?bFFQWjB4TWlaRU10cnZlVlpvMXNJblRxakttM21LUFowbHpHNmo4ZFVhdWZz?=
 =?utf-8?B?OVRUR21tVGlKSXZOZzBXREc0bGlnNVpLNDJGazhmRHlDcGVwbmc3WHVoOGhI?=
 =?utf-8?B?RmFrNlNvL20xZkVTbi95RCtMdTQzR2RVOTI3bG50TVdyeXg1NTNSZTB2bjVW?=
 =?utf-8?B?TlhnTHVnMUxucU4yWXR6WkFKSCtLR2V5eW5kcVNQUU5iS2k3RTU5eFF0Yk9p?=
 =?utf-8?B?QUtUQ2t0R3RUcjUvWGN6RUFSaVNHV3ZFdzdtZmF0MUs0UnpoTmxWY1I3Nkc2?=
 =?utf-8?Q?YrmyJ9eC40pVoSNDSCz00vFcewOPGB0bZOkr/Pa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40068fd9-7cab-44ac-bb4d-08d94b8be99f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 14:37:34.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zs+QjrXg6Im9cAn5s1YOTWyCiqGpNhQhYcOnK/gGtLW6iK4Sql0W46mwICrrtlh+K/pxsbDSNFzvtrzBaw+meQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/19/21 5:50 PM, Sean Christopherson wrote:
...
> 
> IIUC, this snippet in the spec means KVM can't restrict what requests are made
> by the guests.  If so, that makes it difficult to detect/ratelimit a misbehaving
> guest, and also limits our options if there are firmware issues (hopefully there
> aren't).  E.g. ratelimiting a guest after KVM has explicitly requested it to
> migrate is not exactly desirable.
> 

The guest message page contains a message header followed by the 
encrypted payload. So, technically KVM can peek into the message header 
format to determine the message request type. If needed, we can 
ratelimit based on the message type.

In the current series we don't support migration etc so I decided to 
ratelimit unconditionally.

...
> 
>> Now that KVM supports all the VMGEXIT NAEs required for the base SEV-SNP
>> feature, set the hypervisor feature to advertise it.
> 
> It would helpful if this changelog listed the Guest Requests that are required
> for "base" SNP, e.g. to provide some insight as to why we care about guest
> requests.
> 

Sure, I'll add more.


>>   static int snp_bind_asid(struct kvm *kvm, int *error)
>> @@ -1618,6 +1631,12 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
>>   	if (rc)
>>   		goto e_free_context;
>>   
>> +	/* Used for rate limiting SNP guest message request, use the default settings */
>> +	ratelimit_default_init(&sev->snp_guest_msg_rs);
> 
> Is this exposed to userspace in any way?  This feels very much like a knob that
> needs to be configurable per-VM.
> 

It's not exposed to the userspace and I am not sure if userspace care 
about this knob.


> Also, what are the estimated latencies of a guest request?  If the worst case
> latency is >200ms, a default ratelimit frequency of 5hz isn't going to do a whole
> lot.
> 

The latency will depend on what else is going in the system at the time 
the request comes to the hypervisor. Access to the PSP is serialized so 
other parallel PSP command execution will contribute to the latency.

...
>> +
>> +	if (!__ratelimit(&sev->snp_guest_msg_rs)) {
>> +		pr_info_ratelimited("svm: too many guest message requests\n");
>> +		rc = -EAGAIN;
> 
> What guarantee do we have that the guest actually understands -EAGAIN?  Ditto
> for -EINVAL returned by snp_build_guest_buf().  AFAICT, our options are to return
> one of the error codes defined in "Table 95. Status Codes for SNP_GUEST_REQUEST"
> of the firmware ABI, kill the guest, or ratelimit the guest without returning
> control to the guest.
> 

Yes, let me look into passing one of the status code defined in the spec.

>> +		goto e_fail;
>> +	}
>> +
>> +	rc = snp_build_guest_buf(svm, &data, req_gpa, resp_gpa);
>> +	if (rc)
>> +		goto e_fail;
>> +
>> +	sev = &to_kvm_svm(kvm)->sev_info;
>> +
>> +	mutex_lock(&kvm->lock);
> 
> Question on the VMPCK sequences.  The firmware ABI says:
> 
>     Each guest has four VMPCKs ... Each message contains a sequence number per
>     VMPCK. The sequence number is incremented with each message sent. Messages
>     sent by the guest to the firmware and by the firmware to the guest must be
>     delivered in order. If not, the firmware will reject subsequent messages ...
> 
> Does that mean there are four independent sequences, i.e. four streams the guest
> can use "concurrently", or does it mean the overall freshess/integrity check is
> composed from four VMPCK sequences, all of which must be correct for the message
> to be valid?
> 

There are four independent sequence counter and in theory guest can use 
them concurrently. But the access to the PSP must be serialized. 
Currently, the guest driver uses the VMPCK0 key to communicate with the PSP.


> If it's the latter, then a traditional mutex isn't really necessary because the
> guest must implement its own serialization, e.g. it's own mutex or whatever, to
> ensure there is at most one request in-flight at any given time.  

The guest driver uses the its own serialization to ensure that there is 
*exactly* one request in-flight.

The mutex used here is to protect the KVM's internal firmware response 
buffer.


And on the KVM
> side it means KVM can simpy reject requests if there is already an in-flight
> request.  It might also give us more/better options for ratelimiting?
> 

I don't think we should be running into this scenario unless there is a 
bug in the guest kernel. The guest kernel support and CCP driver both 
ensure that request to the PSP is serialized.

In normal operation we may see 1 to 2 quest requests for the entire 
guest lifetime. I am thinking first request maybe for the attestation 
report and second maybe to derive keys etc. It may change slightly when 
we add the migration command; I have not looked into a great detail yet.

thanks
