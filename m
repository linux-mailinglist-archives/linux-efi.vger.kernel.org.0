Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2855C3A42E8
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jun 2021 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhFKNTI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Jun 2021 09:19:08 -0400
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com ([40.107.237.40]:30304
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230382AbhFKNTF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Jun 2021 09:19:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3+IARQSmG03wpj7U8xniHdmtIlqUsT8Oojo5y4Y7ShFW6UwL6w9Aw/DrKyvQIixoDGpS6E9mn0uzUAtQSspJF81uHbFOfDT/30HB+CMHAJ6S1hx6R7Wkc20TetDu6Wl8RiDgwe/pTy444eTobZ75hfxgGif5QzG8HZVI88CqZx+FPIJfLObcLQA3VDq2KZb03+5FzCbDvXx44tOizvXOemhxGXnT9MG8FDI7QtXOgM9bVYydFaAbvRhlq5gmsyGSIC2Hojl0nvUExbfp58i3qghVdwVzLaED2Ci/5EmNpTIIZnlO4aO/ikIz9n7/ihgDBUBZONnAe8B5JQ1MTfsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBqknHjiwykAU9w5UCvyqkoZnjOBFxVvZrC+yXP4RR0=;
 b=cnQdUlEs5GRj2pCLkxJgrRz7NurywSvba56R4kCkSetmhHV4Wf14zJRglDbXztrCiz+0BTe9FI3/wjNuoj3UfZqkGxBJqoA4MP/pRkirN7QI9Lzee5EDFq6ufauodUHZMrzqTlYmJd/aJ9M5+TftzvixMUE/xgLGPoejDr04nF0l7onk519dr66CmdtyI3To3PEBckPUFAPViFLVllbtg2xKW8vyLMy/uFu/Awhx9qQ3MOhr00+DTzQnb00nO+s7O0Y+9F4gDYAbxEVk81jsss19w8DoItudcAJFCv8zWc8sZQQ3QngSsTspWCPb+59H9/aWN6sMEKe8ASx4YPM8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBqknHjiwykAU9w5UCvyqkoZnjOBFxVvZrC+yXP4RR0=;
 b=p427dS0lDrOgIUW1Zxu/ogum9k5/VBbvSADFLkukQeD9VP4Q5+SjfuLPQ55ur3OOTDZSN/4vkgH8GPu5YA/bfubzEoDgxoEaDqaRzOtUjY60mWLRQfXrCBCE6vdSYFgBJ1XcQZdOdc89kaLl+8ph5qXqGRfNrfKMx31uUfcRumM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20; Fri, 11 Jun 2021 13:17:03 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4195.032; Fri, 11 Jun
 2021 13:17:02 +0000
Subject: Re: [PATCH Part1 RFC v3 21/22] x86/sev: Register SNP guest request
 platform device
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-22-brijesh.singh@amd.com> <YMEVedGOrYgI1Klc@work-vm>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <8a598020-7d89-b399-efb9-735b2a6da8a9@amd.com>
Date:   Fri, 11 Jun 2021 08:16:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YMEVedGOrYgI1Klc@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA9PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:806:23::31) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SA9PR13CA0086.namprd13.prod.outlook.com (2603:10b6:806:23::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Fri, 11 Jun 2021 13:17:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8d56218-0169-479b-ae2b-08d92cdb336c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0121E86FF23AA91BA78C247DEC349@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1L4JREBiW0JeYNTcA26DsRcEeTC5lK6Wwt3YuHh/q5bCRdoWGfmdSpO36/Rn5Frl66GxGro0xBWWx8qC2hcvLI92xim6mw4wpuP7YGXGPtMvCM2emMIbcQGCXz8eJUIN5z5C2D+NQePWuNeM9P/nZf/HV7tAKrbmHc78YkSLErgHSwOFuJBer5HqbWN2v0IiALQIe4Qfs83DlpOwSS/vnTWTEyKADzfwVNKEhgPbwwYqm0dyiqk5owpJXMF4QAleifWEVmBhnARG85ek0zvHZ+I+9YCnuT+dcel6SF+k5Viun5FpnykAWiuBObG+wjsf+uPW3hmFbO6MKT8piPakUCYcRZAdko9JH7C2dn+BEGT1KLR2Z1rvYkFA+/QSnz+Lm99LWF575nYyDs2bUhHG9qH9wGgCAUZNW3GhbDXBqqMFYEl/xpmxxNfMf4Ndy+3tujz7NLz2kAqsZiPZB9bHaZac2Qo2kjQOi3RvdlRHqAq2Xa1q7dRXc3EsZI+I32gNs+dnpIjCC8czNM7NzyP1TW9r74P1YsE9DlZSkuYIYnlXZoNBPm04TMw4bgHl37JE5Oj+N/UY3FV6rOwzepP21RjPDFGJVUJdR40yjytjOBaeVumitFdVJvSlOZSmIuom9yb8pJkgRCmJHoQKuK09IQVvRvuTfjUVkxijjVo8cwBmvQWVW5W6rLiy+TL5mp8J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(31686004)(83380400001)(6636002)(26005)(6486002)(4326008)(54906003)(8936002)(110136005)(66946007)(478600001)(36756003)(66556008)(66476007)(5660300002)(6506007)(53546011)(956004)(16526019)(186003)(316002)(38100700002)(2616005)(6512007)(8676002)(7416002)(31696002)(86362001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHNqQ3EwN0dJbkRqTzc3ckY1VER4c3VXc08rL05nbS84Vy9qU1JENWtqZXhB?=
 =?utf-8?B?a2lJUmlaeHZmRlZNYURCemYrYW03MEp6ZDlWQ2N3TXQyOUhoNEFUTFQxM3hx?=
 =?utf-8?B?ZC81anIzS0V3ekNpajZpOVNPNGpiMnNEOTFlRHdhRW80VGJNUEM1Z1ppUExV?=
 =?utf-8?B?MW9tMU9TcWZXRGUwY2k4Tyt4aG5HbWxZRmlVWGhuVXc4aXNoRG43ODQ2OGhN?=
 =?utf-8?B?SGNzSmRxWjU2ZzBrS1BTN2NTYlZwTGkrYUYvN05RWEd0eGhLSjc0UHdCWDBM?=
 =?utf-8?B?OFQ2WjNmWTZyOGQxNm1vYjM3eGx2VlR6S29nOFdLdmM2YW1RcnlyS3ZzL2JB?=
 =?utf-8?B?OWVGd3BXSWFMNmNYS2ordktucEIrSzhLZlhibEU4Y3Q1OXdtTHNCTldhUEZS?=
 =?utf-8?B?Qy9KeFBrcG1HTmNqVWd3a1RMTTg4TmNnOFp5M1hZOSt6M1UrODgwc1QzTjZQ?=
 =?utf-8?B?TVFjZkE3Q2tzNVc3cTlXU1FtSS84L2ZNR2dYcDhYT3I2eEF5M2gzTTBaUVBj?=
 =?utf-8?B?QU5pNUcwVGJVa2dVTU5KZnJRd3NMc2xza1N0QXhidzZjTnBLdlQrb0ZpK1Ns?=
 =?utf-8?B?STRQTkNKOXlCSmE1dFUrVEIxb1lNT2xhNzUyeFlRL1ptQ1pOSUdrcTV0WU5H?=
 =?utf-8?B?RXNBTjRnOWxYS3FRdkNoSEhsdXJaVlhBT1hmbGdyMVRRcVFsMXBqa0VML2Z6?=
 =?utf-8?B?blQwME1rbWw1NkFBbEcyWDJNWDNpWkJHQ2gxclFKSkc3dnlXaUIyeEswMFRi?=
 =?utf-8?B?a0x0eFRud0swL3duZjVEQW9zb00xM05jYTYrVk5xaW1rV0NOTjR3c1dZR2lH?=
 =?utf-8?B?VTR3UU00Tk5OenE3NTYxRUczRE04U2JGS3BLaEJzYnlIR2tPdjd4RE1mK1NY?=
 =?utf-8?B?aEhnN0lSamwzSlJ3RjJIaXNoRWRkQWQzc2d5TDQrTVVnQmx5TENYbWlCOUxF?=
 =?utf-8?B?Z1RVdmtYQnMwSjM2Ulk3UlFKcVV4QmJhVU05azVGclNvejllN1dwZ0pwWmFO?=
 =?utf-8?B?WktRRjZQaDkwSUQ5N2Q0VXhRUWdkVkVMbWFObXltQkt1VFhEQnRDOTN2UDkx?=
 =?utf-8?B?VDV5N0FjTHJOVU1IQ0swR0N1VkJmbVRSbHpIQzRSR2FEYUlYN2NMQThuQkR6?=
 =?utf-8?B?U2JYdDg4T2FWaHkyWFM5UkorMDhPZTV1TU94aFpQWTc2MUZzMnhYbjE5TW13?=
 =?utf-8?B?T1pCSmhGNDkzWkVaZmtkam1mTVgrR2R0ZUxVQWFTcms4S3hlR1dFZHhMeEo2?=
 =?utf-8?B?UFQzKzI2L0ZMZ0pNUzhzWTFDMUxCMCtNMnpKMnh6R3lsKzNYTVpreEtpWTc0?=
 =?utf-8?B?aCtkZW1KYnhzU0IvbzREZDRQZ0ZjRW1RQkNGQXdLVFBSbVJYRUdxSjBHVmRj?=
 =?utf-8?B?bERFSkhBVWNwWHVkUVF3QjVmL1ZpdU9hem5VYzRQRi82Njg4dGlmNm55d1RK?=
 =?utf-8?B?YlUrdEphcFlYTzlmUDRWd1FGQjhuVWlGYXRMZUVwWkIvTStxU3pHSXNxeXQx?=
 =?utf-8?B?a3cwdkRkaHp5V3N3WnJ0VFR2aFFzU1JuQ3JWRFY1SFJlNDB3NWV1OWtUa1Vh?=
 =?utf-8?B?bW9HWlErWVdRWjhLc25vdXVkS3MrSWtuRmhzUGlGb2xPekU2RUJTc09KQmlY?=
 =?utf-8?B?cW9OS3c0SzVMWXhyMHFleTV0YmhPcmM5SHg2ZHdRazlDMS9iQi9IektSS0JX?=
 =?utf-8?B?RzN5d3lZdEdqQ0Q3Q2pBdkJqVmtlMWJVWXpjY0NtckFFcVcvdndQSWVDWDIz?=
 =?utf-8?Q?eyySo5SoVhfSJIL6hbNxjcyJyzL94+h7SXjaZTg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d56218-0169-479b-ae2b-08d92cdb336c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 13:17:02.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTI5x4BpuNoL1aQc5KsELr2L0jFSF4BEwHM1ZV6cHuC68AqpkHu/1Dirb5+tGL1muBIygQ5ypm/A8yHUfYPCPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/9/21 2:24 PM, Dr. David Alan Gilbert wrote:
> * Brijesh Singh (brijesh.singh@amd.com) wrote:
>> Version 2 of GHCB specification provides NAEs that can be used by the SNP
>> guest to communicate with the PSP without risk from a malicious hypervisor
>> who wishes to read, alter, drop or replay the messages sent.
>>
>> The hypervisor uses the SNP_GUEST_REQUEST command interface provided by
>> the SEV-SNP firmware to forward the guest messages to the PSP.
>>
>> In order to communicate with the PSP, the guest need to locate the secrets
>> page inserted by the hypervisor during the SEV-SNP guest launch. The
>> secrets page contains the communication keys used to send and receive the
>> encrypted messages between the guest and the PSP.
>>
>> The secrets page is located either through the setup_data cc_blob_address
>> or EFI configuration table.
>>
>> Create a platform device that the SNP guest driver can bind to get the
>> platform resources. The SNP guest driver can provide userspace interface
>> to get the attestation report, key derivation etc.
>>
>> The helper snp_issue_guest_request() will be used by the drivers to
>> send the guest message request to the hypervisor. The guest message header
>> contains a message count. The message count is used in the IV. The
>> firmware increments the message count by 1, and expects that next message
>> will be using the incremented count.
>>
>> The helper snp_msg_seqno() will be used by driver to get and message
>> sequence counter, and it will be automatically incremented by the
>> snp_issue_guest_request(). The incremented value is be saved in the
>> secrets page so that the kexec'ed kernel knows from where to begin.
>>
>> See SEV-SNP and GHCB spec for more details.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  arch/x86/include/asm/sev.h      |  12 +++
>>  arch/x86/include/uapi/asm/svm.h |   2 +
>>  arch/x86/kernel/sev.c           | 176 ++++++++++++++++++++++++++++++++
>>  arch/x86/platform/efi/efi.c     |   2 +
>>  include/linux/efi.h             |   1 +
>>  include/linux/sev-guest.h       |  76 ++++++++++++++
>>  6 files changed, 269 insertions(+)
>>  create mode 100644 include/linux/sev-guest.h
>>

>> +u64 snp_msg_seqno(void)
>> +{
>> +	struct snp_secrets_page_layout *layout;
>> +	u64 count;
>> +
>> +	layout = snp_map_secrets_page();
>> +	if (layout == NULL)
>> +		return 0;
>> +
>> +	/* Read the current message sequence counter from secrets pages */
>> +	count = readl(&layout->os_area.msg_seqno_0);
> 
> Why is this seqno_0 - is that because it's the count of talking to the
> PSP?

Yes, the sequence number is an ever increasing value that is used in
communicating with the PSP. The PSP maintains the next expected sequence
number and will reject messages which have a sequence number that is not
in sync with the PSP. The 0 refers to the VMPL level. Each VMPL level has
its own sequence number.

> 
>> +	iounmap(layout);
>> +
>> +	/*
>> +	 * The message sequence counter for the SNP guest request is a 64-bit value
>> +	 * but the version 2 of GHCB specification defines the 32-bit storage for the
>> +	 * it.
>> +	 */
>> +	if ((count + 1) >= INT_MAX)
>> +		return 0;
> 
> Is that UINT_MAX?
> 
>> +
>> +	return count + 1;
>> +}
>> +EXPORT_SYMBOL_GPL(snp_msg_seqno);
>> +
>> +static void snp_gen_msg_seqno(void)
>> +{
>> +	struct snp_secrets_page_layout *layout;
>> +	u64 count;
>> +
>> +	layout = snp_map_secrets_page();
>> +	if (layout == NULL)
>> +		return;
>> +
>> +	/* Increment the sequence counter by 2 and save in secrets page. */
>> +	count = readl(&layout->os_area.msg_seqno_0);
>> +	count += 2;
> 
> Why 2 not 1 ?

The return message by the PSP also increments the sequence number, hence
the increment by 2 instead of 1 for the next message to be submitted.

I'll let Brijesh address the other questions.

Thanks,
Tom

