Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337EB3CBF7B
	for <lists+linux-efi@lfdr.de>; Sat, 17 Jul 2021 00:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbhGPWv4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 18:51:56 -0400
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com ([40.107.237.64]:62331
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231846AbhGPWvz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 18:51:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLfNklmHWYUCrmWxLlQ2H7Eod9gBOL9VzozfCPaPv+J8Oxxdf6K6uxG6ast5V3SI06xccSMkVFVOLosmYsEqsSZJDeu2kPVn9BYudZZKJaxp5hgcdTBtTHZFPXSH2qhKpUPpIrlC0EcKZye1wjMJ6MUXtPUmH4JY0SI7K09kqRYQDN5TzTgvS3Szn2cnAuJBwLsa0y5c7pZQ6wjLEx7WthUKkE0nRCyI6dH3mjXniWTUaEkptf7nAwFcqgbXeHYLgI9MIVpkbftpbL5BmZVDlMqkFyuBuSRUB+LmYbL1CJlm6EPAY90rxR18w4rCMh2SmqPvqv/nJwAG9G1fSQ+KJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLEGBubs/LePthjnpx0pkj6ziTxtQCuBfVr5UJ4fyHo=;
 b=D5SMFNy8ooyrfmcD2fxDRvHX4mPgnF12O31F3j6MU/S9ORzoBOLKvxfcw2D/Z3NVYANJqvQjQ6q0YoYS0oqvla7pa1XcmMuTTW3mK+zWF0YmLwzSWa6WC7AuLiQStSFILkYnbMwAniienWmwvqp8LKJ9nFPdgcRKhBR/40N3OPSXJmrX7p4NRd5LJM5Q6OqUGsf5NhYxuuWc6joOxW5FAwaNoBaqa4qX8G1nqiP0GBLFYlf/W1SXK6boU+KWXxWHKd6B/RKeqej5ck2CEFHUht9zAu8q0pQJ9VYlL8HPa0bpUUuLCgLvvAql74Q/m3PRje82KvWTB5Wuk4RPg7i36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLEGBubs/LePthjnpx0pkj6ziTxtQCuBfVr5UJ4fyHo=;
 b=eiN1Co8RM4ER+OefBCrAT7gAB66BgIDrzfTvWEfoW3RBkgrh1qV08aUsAFqZBGwDeOKzKHXiDmELEf9Aaj7OlRJRVRW5t/XFP1h3XeneLyVvZwHufsTsgF2OSc/ounl+ZVzurNrIU7teDTYgKzbZiaPQLQhDNOvU/TvJ24Qfrhg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Fri, 16 Jul
 2021 22:48:57 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Fri, 16 Jul 2021
 22:48:57 +0000
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
Subject: Re: [PATCH Part2 RFC v4 26/40] KVM: SVM: Add
 KVM_SEV_SNP_LAUNCH_FINISH command
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-27-brijesh.singh@amd.com> <YPHpk3RFSmE13ZXz@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <9ee5a991-3e43-3489-5ee1-ff8c66cfabc1@amd.com>
Date:   Fri, 16 Jul 2021 17:48:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPHpk3RFSmE13ZXz@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0120.namprd11.prod.outlook.com
 (2603:10b6:806:d1::35) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SA0PR11CA0120.namprd11.prod.outlook.com (2603:10b6:806:d1::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Fri, 16 Jul 2021 22:48:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a0b68a9-6daf-47aa-3e15-08d948abe517
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2416CF8B674B581EF9BDDEEBE5119@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5o0XpSBQXtuKWDspy6j7EMboomvMdCcB2Djwb14yYSi1yjXc6VTKVsq4GFI06M7WwXCOiMe2iRQ1j8p9kE2NqdHD09uELTxiRj2BGnDtwAYWDoxX4qQ6t1NywbBzBKP2UELiprc/13IMJRR8PUI5n+pAZtovw7LuJZ/gYFaH6D/1+Xp5THKqzBXSK6uHXfCrqaRb9s9k/V2VjSG9+AfW2J4KUoLm5Us4zKpLcxo8V13GcgLlFucTv5ab8jH/q6uYb+s7F6iOB94PP657Xs/Jw8droUHuDAwGDiMddasPIdiTHwaO5DvAAlFhqYU8SLdx7SprSVVnB34TqjUIbQMKuhm4KDLPrf1SQZw2DEyIEOL0645HAlE/a6j/cC4EE0/6+evHnEsy4YcUj8bffuLxQi6x4HBysP6OCScH+3AUGI8sM0Yq6BXNK7OYORafh4GmjiZReqqfjZHkhS5/uAflF9LzeEo0W692gi1Vkw6zxQnE/TFpZLpTOvON2QmuYzQYrrXY6F3UTU1Eizmg4wWFcGzJEstmFsg/WLx9weC4AcVDPquXab14swP6rJGYpUh/XHDe2gOgi7Aygz/lCQCM5UuQBgJ/wgmQb/Ajc7oxemUreeEUADo7VCemrUrwCQGwkz9qGNIE/FIdEyJhbqd5dzd5gDuJn74r7YVyDPotvbGdHMjKiUKX9rUM1Yh6TBe8mhY8EjYh2VOEPgX56A07wB4evQZPLiVq1BjRdzM6INNurudDrvBdk7MQNDnK05uAXxyiX87dzXQ2fktO5lFpqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(7416002)(44832011)(54906003)(66476007)(7406005)(508600001)(66556008)(316002)(66946007)(38100700002)(2906002)(6486002)(38350700002)(6512007)(5660300002)(4326008)(8676002)(6916009)(31696002)(956004)(31686004)(52116002)(86362001)(36756003)(186003)(83380400001)(26005)(2616005)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzNhYURRUFk0QXlaejI5UmxadTE3dkdJYVc1NEV5bG1VOFg4MC9Lb09RUzdE?=
 =?utf-8?B?azlKSzdwb1VwRUFMUnp3ZW4yZ3JpazVIdEpCV2hwN2YvQkVDRjhiNjZ3UHlI?=
 =?utf-8?B?MTNTdy9VbHVpWVdnQ0pNcVZmUXZyTWphWE9LTmtCOThuTVVXSmsvZWtld1hS?=
 =?utf-8?B?dVVkL2xYeWRzTnRuWXlGa2RNSjRtUEwrdjZOamwyMk5aUExPRkxVKzZxMlM4?=
 =?utf-8?B?bXNJWDg1NzBWVWRPUDFjQ3ZMbjFaWENjeGx3UUZjVlpJcHJKeW4yNnJtS0l1?=
 =?utf-8?B?T1J1SUJIMDRBdzRDWE0wWndFbHU4OStFaWdhem4rY2lTNmZTNnZialluMGcx?=
 =?utf-8?B?MjBIakxENmpiZWpvUnk5REROS3owK29lU05VUVNHdkFsKzV0OXY2ZEhuLzIw?=
 =?utf-8?B?ZVQzNzlUU2pFSmRBZlRLTzJzZjdaM20rdjFxK1YvVlRwZUE5MW9qUERFV3Rs?=
 =?utf-8?B?b1dXWTE5VEpaR0tLWlkwc3lFbFp6dzVSZ1RYd0ZPU0d4bkFNNmkyTjhKWlp6?=
 =?utf-8?B?eGx4OTRseVA0NzRIcU9XR3ZhS3pKYndLTTRPVUVWNWV3Qk5ZeWE2TmswSlN0?=
 =?utf-8?B?MG5CdGJvRER6RlpwQ0JGbW5BenQ0YzJzWDgxZThCUlprWWRZS2JSeWpzaTEz?=
 =?utf-8?B?QmdYdXlnWlB5UkVvTmpRUFVXR1dUMDdtZFIyMlJINmY4YkU3Q0YzVEUzVjBv?=
 =?utf-8?B?N3ZSenVqNWg5OUJmaHczdEFtYjlrK3NPVm91M1phMmI2TkU4dUFDU0toTkVj?=
 =?utf-8?B?RjdYWGJUNEljdGpldTFUb3l4ZEpPb0dEc25uRFBLN213U2Iybk02YXIybURY?=
 =?utf-8?B?NmNDakJwejR4ViszRHQwWklNSGt6QnB3MVFVS0N2NFQ2a3NtRmpzM2UvN3hq?=
 =?utf-8?B?RFRJVVNXbEp4aWtFUndJM2NlS3pyb1A4WXVJbWppckM2MUo1WCswQmRSWWNz?=
 =?utf-8?B?Y2doK3B1dkJIR3dlaTZ3WW5TU1MxaUhQa3ZBMXlPeVlqUHB1ZFBwa1JVaW5B?=
 =?utf-8?B?U3hhQitHWndLcWx0dU10YjIvWFV2blEzaUFwN0hQSTJQYTFlTzJPbFk5K0tR?=
 =?utf-8?B?SnpjR2tKeGtSV2Ivby9EbkFxbVFod3JSVHh1TGtUMjMyUDNDVDY5ekdiWlFw?=
 =?utf-8?B?eVJBQ2w3MWhlcU1xL0wwaDJZMmNkZUxBMEI4YzU0VkloVFRkMUx1dXRxbzFW?=
 =?utf-8?B?NkR4VkJkQW1kaFNNeEtERllQOTdHUmxqRDR2dUNCOG9UNmZQN1plMXg5UVpm?=
 =?utf-8?B?SHA2L0VLaHBYbktSS2w0VVlJZ25FZ0QrcmRnYW9ERkh6aThIRkxOVnp2ZXFx?=
 =?utf-8?B?b0dDNGVja1Y2elNhNWJjQXhoNHEzZXpkTEM3N0JBeUpHMTQ5Uzg0dTdSY2k3?=
 =?utf-8?B?Wkp1L0t0TDBPZjZCQW5UUGpyV1oyWXJGa2pYSmcvSVRMMlh4cENpNlZoZkEy?=
 =?utf-8?B?VnBBVGhuQUF4NXkrdFVUR1poK1ZuMmUrUitQeE0rSWNUSEU4RytLc0g5WmRJ?=
 =?utf-8?B?bHNDRHBKTlkrb2lkWkJPYWg1L3dROXlVcUVJaTdjR2lzV09maDl2NGozV1pt?=
 =?utf-8?B?QU4vUkZDNytHc1VlL1MzU2p0WUNYL3hkQXdxQVUrK1NsUzA2RENCdzJINE55?=
 =?utf-8?B?aVRNcHFaazM5WnhpNklDaVE0MWtNSmFtYi9QSFpRWHl1M2tNMGExTVZxS1Np?=
 =?utf-8?B?Q3NOa2FML2lKbFNlU2RzRXRONVNDMWVYTFRaMHlST1VsNkxRbGZQWFd4YS80?=
 =?utf-8?Q?Eun3SSkWP7Fy9aykFNf5kvxQVb9pCI7NvyBVqdv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0b68a9-6daf-47aa-3e15-08d948abe517
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 22:48:57.1877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtTRr8rCPY+tkdebLG8lJlHX8megYehggUympA4fTt9AWove19cdm/uvo5yO1CtgQE/xp7WpXbXXAOQDbLzXjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/16/21 3:18 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> +        struct kvm_sev_snp_launch_finish {
>> +                __u64 id_block_uaddr;
>> +                __u64 id_auth_uaddr;
>> +                __u8 id_block_en;
>> +                __u8 auth_key_en;
>> +                __u8 host_data[32];
> Pad this one too?

Noted.


>
>> +        };
>> +
>> +
>> +See SEV-SNP specification for further details on launch finish input parameters.
> ...
>
>> +	data->gctx_paddr = __psp_pa(sev->snp_context);
>> +	ret = sev_issue_cmd(kvm, SEV_CMD_SNP_LAUNCH_FINISH, data, &argp->error);
> Shouldn't KVM unwind everything it did if LAUNCH_FINISH fails?  And if that's
> not possible, take steps to make the VM unusable?

Well, I am not sure if VM need to unwind. If the command fail but VMM
decide to ignore the error then VMRUN will probably fail and user will
get the KVM shutdown event. The LAUNCH_FINISH command finalizes the VM
launch process, the firmware will probably not load the memory
encryption keys until it moves to the running state.


>> +
>> +	kfree(id_auth);
>> +
>> +e_free_id_block:
>> +	kfree(id_block);
>> +
>> +e_free:
>> +	kfree(data);
>> +
>> +	return ret;
>> +}
>> +
> ...
>
>> @@ -2346,8 +2454,25 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
>>  
>>  	if (vcpu->arch.guest_state_protected)
>>  		sev_flush_guest_memory(svm, svm->vmsa, PAGE_SIZE);
>> +
>> +	/*
>> +	 * If its an SNP guest, then VMSA was added in the RMP entry as a guest owned page.
>> +	 * Transition the page to hyperivosr state before releasing it back to the system.
> "hyperivosr" typo.  And please wrap at 80 chars.

Noted.


>
>> +	 */
>> +	if (sev_snp_guest(vcpu->kvm)) {
>> +		struct rmpupdate e = {};
>> +		int rc;
>> +
>> +		rc = rmpupdate(virt_to_page(svm->vmsa), &e);
> So why does this not need to go through snp_page_reclaim()?

As I said in previous comments that by default all the memory is in the
hypervisor state. if the rmpupdate() failed that means nothing is
changed in the RMP and there is no need to reclaim. The reclaim is
required only if the pages are assigned in the RMP table.


>
>> +		if (rc) {
>> +			pr_err("Failed to release SNP guest VMSA page (rc %d), leaking it\n", rc);
> Seems like a WARN would be simpler.  But the more I see the rmpupdate(..., {0})
> pattern, the more I believe that nuking an RMP entry needs a dedicated helper.


Yes, let me try coming up with helper for it.


>
>> +			goto skip_vmsa_free;
