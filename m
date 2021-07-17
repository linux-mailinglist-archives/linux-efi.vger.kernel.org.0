Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0643CC052
	for <lists+linux-efi@lfdr.de>; Sat, 17 Jul 2021 02:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhGQAsA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 20:48:00 -0400
Received: from mail-dm3nam07on2087.outbound.protection.outlook.com ([40.107.95.87]:56448
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229566AbhGQAr7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 16 Jul 2021 20:47:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=encDz+5IlHfGBhPziawwzAc00PvIWC5FhrIUL3oPBGiAjySxqxiGQiJXKyiO2goG3nyTOboC/vI8mpdaz4uWo4AP5MP5IMLeQGHQjHB1sFY23yKABoiFgfq3VbAruJ6zi8TFaEeGN3Jr0xO2GyT+3iu+vDqMMjIcPdStmlIjC3/nBQwEcxaBsKonMvH4egIYtk9W+/8Bj/ikUz9cku3NjE1zk5TfpD3EUw4tjPc0qjdut6viQihlhAX/pyVH7BLCPy9M+/taHLU6tXNLji9HNgr65ytAUDg4WM2v0YH/yfDeaYzH4SZcjdMpU+7EcGsApcGKVgdcKh2/nCTqzlXDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm5nEXgGbR3CIZfyFwQ52X6KVQK33cZwo8n/6BzrFF0=;
 b=SmqfjbQqesvhaoTbNTKoUKfz68RMN8Le8LdpidVFxjEz9kFxD4Axe4kZR4rh/ddLa2qYrWBrDOmsqK28BmX2EgIwYy1Nge5BkJRyFpDh0djS03beLrReFvtrD3YMUpss5uAMdFrwlvDbMULhKfPuTh1K1avv5DESZlqi7wRMSwuXE4ucc0sDGd7S6/EIHOwaOrrv6yt2ghTe0O/vuzNz3h74GJWlCHdbXV2HOje0NBgGDpwSE8gXbGM7Hbv1fR5oDoM5xuJgDxJ/CFmDxa+8kc7wYY4H4WJ1pQbTrMajqCz1cJHpTuUSkP9Z3334lKyQWFEnJVila1Vw71BO8siAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm5nEXgGbR3CIZfyFwQ52X6KVQK33cZwo8n/6BzrFF0=;
 b=jfR573SanHbQbFp+3BpJxeLFe9robynS1TqwXyyG7cN1C5rva9Vdf0F4AKdIDe5oP2AgorCpe524O7PyMcbt8IIt27FihCWfMSSiZdKSCDjWI9DgG/DbewrnwJBzXlRdU0g+GZ1aKqCH2WTxc1h6AcVQrDlhqzjoyfrGZeog8Gs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2830.namprd12.prod.outlook.com (2603:10b6:805:e0::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Sat, 17 Jul
 2021 00:45:00 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4331.024; Sat, 17 Jul 2021
 00:45:00 +0000
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
Subject: Re: [PATCH Part2 RFC v4 32/40] KVM: SVM: Add support to handle GHCB
 GPA register VMGEXIT
To:     Sean Christopherson <seanjc@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-33-brijesh.singh@amd.com> <YPHv0eCCOZQKne0O@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <35b1c6c6-b8f1-6ec6-e55c-f2e552e29527@amd.com>
Date:   Fri, 16 Jul 2021 19:44:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPHv0eCCOZQKne0O@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN7PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:806:125::17) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN7PR04CA0162.namprd04.prod.outlook.com (2603:10b6:806:125::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Sat, 17 Jul 2021 00:44:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 322e04c0-4fe2-4588-34b9-08d948bc1b85
X-MS-TrafficTypeDiagnostic: SN6PR12MB2830:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28309CBEB4C7D459BCA774A5E5109@SN6PR12MB2830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dM+j+HwHlZDHQ426yTWg7bW59NVnF6LMJzQXmEOUaYdqz7qtjjTnWetSCJHRw8dTAKkCGA1YoG7q0uBg4E/KqiG9cf1ndygW7zAl4YyO6VvOqvbaBBhzZz7oVWItbXn9v+eh8Ato4NAvV0X5mzOyqgQRtmxtZxfc7J2bfnzdo9kkFMp29gccTHAgWC2XhLrZbr1jVLYnqzfIMhiZht5fH0K+JyOU8rSQS7jd0sJe6zKo9GFyGggZsLD6I9ePXxW4kypLGzsgiuZOMe7ESPisc8ofZ+idmbkAgy5oOdyDqzShed37Lb4ueap0keOAp6vlTCQemezpnMw8VyxgwyWDuJl3IMeXPKhhKh6/Y3klwR/BywH4lUGh36MgujjfBX4BCQXgBcEO3AHYVgv8EKrgBT6r33PQqiYt5NWBN/8EkCBQhKeNIpMIOJlTOJfDoGGDPVgz2I4F14Cv4hKndA8XP6h7Zkt2dc0RUQltctzd439Vlvt4Ovj+kI7lElQz1DKx3bWCA3tGa251CuwkzKBfl+KC0daaEi9bcL6PasvibqJCBmWObq5gudtc4fJIiLh3D2dmEtX/E7EZ1fGHz7x6xnAHjFWJSe86c4TIx5SSg+0cXxxSFmatEjKtOJo9frx+K/ojIBJUyJ9WmT2e1peCcT/++aUTZ396U0VZaGKIX7ZFspTf3wOMlqzJnR6sK7kqWk8SIZQMywZ44l4xeV+BotsFBFH4Eb8c56VFayZ79k+zuNfHUWBtcPPw+iWcmoZgYRBXG93XuKwd0a9sPhwKoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(2906002)(83380400001)(53546011)(5660300002)(2616005)(186003)(6512007)(66476007)(38350700002)(36756003)(66946007)(52116002)(31686004)(31696002)(44832011)(478600001)(38100700002)(6506007)(66556008)(8676002)(26005)(86362001)(6916009)(7416002)(6486002)(54906003)(7406005)(8936002)(316002)(956004)(6666004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tjd2dXNkR3lUM1dLTDA4K29XY0Q5bnBsdldZYlBXRDI4aytaUk9WUDZTM2Vm?=
 =?utf-8?B?SHJoWnR2ZW1Ta0hDaE1sSzJkaldmZ2pCUWJLRTZmNlloTDEvZW5IaG9ZeURY?=
 =?utf-8?B?K1RnMTNJYmNYbE8zajJlOStlVGhoYnBzL1E5Q2VEQkRGVXQyNEJ5YXJ3WVVt?=
 =?utf-8?B?QVoxdjlHbnhFMncwMzl2RWZLMnZiWFd1ZDQwendvaHFkTkx4djJCU1NwQTJw?=
 =?utf-8?B?U0k5NHhQb1QyZ29vWXJuNHRTNytnQlRRR3FnekRpQ2NHN3hYOEdDVU8zb2x5?=
 =?utf-8?B?cW5oenlVZ1BDTjlnQUNpSU90SmlwRm81TmJUUmdnWk5reEUvS1BsYXRiQXd0?=
 =?utf-8?B?MXVLKzJiVDJXTTM0UmljTDFabzhwRUNyMWlWTDhvWUVQUHVMZjVpT2p3aklB?=
 =?utf-8?B?OVV5NFNxZmVMdDJCMkwrSnVFaGRVZjNmcmZaK3ZsdlNnUGdmVFpVbHppd1Vi?=
 =?utf-8?B?M2NLRi9YVkhuTWhZNkVndHNzZWdqd25CLzQ1UTNjbDV5T1hOT2FHajRCbGVF?=
 =?utf-8?B?ZFBLN1RrYjFvV2xIWDVGeUEyZU95Zm90VG9peEpaL3ozREFTM2FVRDlEZUJ3?=
 =?utf-8?B?T2tLV1U0REtMb29zemUyMkNpM1AxVmlZRU9LVWNCMzVPNFByMmdjWXJrRzJN?=
 =?utf-8?B?MTlZVlp1eEtLcW9YS2hCbEFQczlhczhSTlIrYWlHRW5rMkRHQldtc2pmOHpR?=
 =?utf-8?B?WVNrTGhlSHJpUmxuaWYvbU9vUkxCWnpyMGJHeno3NjBWUTN4L29kaTFuYVlh?=
 =?utf-8?B?Rzlsc2tMOUVUSS9lQk5mdUlKczlIV2hOYmp6dzEyaDRKQzE2SmZNY2o1dmpY?=
 =?utf-8?B?R3JJY2dkTlo4OUhrRzdIRGVYYzAxWS84OHB5R2Z1cUY3ZDVnOHJmTHVjdzJv?=
 =?utf-8?B?aFk2aUZRbG5YMnlwanRHVmZwUmRncVVwWnI4d3NINURSNTZhOFdIQjVWM2RH?=
 =?utf-8?B?bHZ4dkV3L0oyakhFdkdjVEpFZXB0N0trbkxhSXRpQ0N0djZLUklhYjJEbjlj?=
 =?utf-8?B?Q05LWUFDVFluM0d3Ny95TWZUWnF6WThIelJBVFVUaW9MZXQwdDJybW1SVW56?=
 =?utf-8?B?cTFYcnhRandUOHRhK1VwL1huQUVZR0lYQXV5NGxVYXE3ZmhIVmlHMFBZOVBk?=
 =?utf-8?B?UEYwMVJnRXFhT3Zwd1FpdFRFaFpNMWcxbTg3QTVJdDdwV0RBcUV3a21PMmxV?=
 =?utf-8?B?OFM1aGlWOE9Rb3ZvV002blhUV3cvc0dxR2JzZXBpSit6NVJINkFoc1RnV1lJ?=
 =?utf-8?B?S3E4RGRSVHFDTlB2UTVxb2JQSlg0dVVBYldkM09nVXR3UUJJa2doQkFYZVRQ?=
 =?utf-8?B?STJKemJBblZldzl3QW81eGZIU25NZXFxMmQzTVJlVTZrWWNlR1JpczZIZUgw?=
 =?utf-8?B?N2dwRVBUMWhCeVMvc0ZPZHl0S3pielJIem5md0FXb1Q5M2J1c1dPeXFqdkZ1?=
 =?utf-8?B?UDFKRW0yRjd3MzVZUlFGOVlZbUdBYUFZOTdQUXRwSlJZYkpLNjFlejI4VUVT?=
 =?utf-8?B?K1hZSlRBN2x0enFrK0E4dlpYVWFySmxsMlQ5eWZSMUhlWkVWcUVwRWZtTXFH?=
 =?utf-8?B?NkgyellnbG9mbTkxMWVZRzkwMVpBK3podjR4WFBUektIWlFpdUxqUng1c3ZW?=
 =?utf-8?B?V0xGQUkyVVFhVUJSSjBHZ21iZXd1V29EbTkwSFJGamlNQU9vc1NNYmdob2oz?=
 =?utf-8?B?RGhVWDJpYU5aWUdpQ3FkN1BrdFJlMU83VC9aellOOEZoVDk1U3BMU21ZcXlk?=
 =?utf-8?Q?s3zEbFflgaOFMWrhrbXsw9xHx0ZRYNpq8hDCLH5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322e04c0-4fe2-4588-34b9-08d948bc1b85
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2021 00:45:00.4840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebUzkqABZXpG9HQxde+1ML5exiGXhBit60DUbHasvAugSWt6CsFjaWXj769WfedMnbhM/LibSsIcGguqp9VDzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2830
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 7/16/21 3:45 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> SEV-SNP guests are required to perform a GHCB GPA registration (see
>> section 2.5.2 in GHCB specification). Before using a GHCB GPA for a vCPU
> It's section 2.3.2 in version 2.0 of the spec.
Ah, I will fix it.
>
>> the first time, a guest must register the vCPU GHCB GPA. If hypervisor
>> can work with the guest requested GPA then it must respond back with the
>> same GPA otherwise return -1.
>>
>> On VMEXIT, Verify that GHCB GPA matches with the registered value. If a
>> mismatch is detected then abort the guest.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  arch/x86/include/asm/sev-common.h |  2 ++
>>  arch/x86/kvm/svm/sev.c            | 25 +++++++++++++++++++++++++
>>  arch/x86/kvm/svm/svm.h            |  7 +++++++
>>  3 files changed, 34 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
>> index 466baa9cd0f5..6990d5a9d73c 100644
>> --- a/arch/x86/include/asm/sev-common.h
>> +++ b/arch/x86/include/asm/sev-common.h
>> @@ -60,8 +60,10 @@
>>  	GHCB_MSR_GPA_REG_REQ)
>>  
>>  #define GHCB_MSR_GPA_REG_RESP		0x013
>> +#define GHCB_MSR_GPA_REG_ERROR		GENMASK_ULL(51, 0)
>>  #define GHCB_MSR_GPA_REG_RESP_VAL(v)	((v) >> GHCB_MSR_GPA_REG_VALUE_POS)
>>  
>> +
>>  /* SNP Page State Change */
>>  #define GHCB_MSR_PSC_REQ		0x014
>>  #define SNP_PAGE_STATE_PRIVATE		1
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index fd2d00ad80b7..3af5d1ad41bf 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -2922,6 +2922,25 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
>>  				GHCB_MSR_INFO_MASK, GHCB_MSR_INFO_POS);
>>  		break;
>>  	}
>> +	case GHCB_MSR_GPA_REG_REQ: {
> Shouldn't KVM also support "Get preferred GHCB GPA", at least to the point where
> it responds with "No preferred GPA".  AFAICT, this series doesn't cover that,
> i.e. KVM will kill a guest that requests the VMM's preferred GPA.

Good point, for the completeness we should add the preferred GPA MSR and
return appropriate response code to cover the cases where non Linux
guest may use this vmgexit to determine the GHCB GPA.


>
>> +		kvm_pfn_t pfn;
>> +		u64 gfn;
>> +
>> +		gfn = get_ghcb_msr_bits(svm, GHCB_MSR_GPA_REG_GFN_MASK,
>> +					GHCB_MSR_GPA_REG_VALUE_POS);
> This is confusing, the MASK/POS reference both GPA and GFN.

Let me see if I can improve it to avoid the naming confusion. Most of
the naming recommending came during the part1 review, I will check with
Boris and other to see if they are okay with new names.


>
>> +
>> +		pfn = kvm_vcpu_gfn_to_pfn(vcpu, gfn);
>> +		if (is_error_noslot_pfn(pfn))
> Checking the mapped PFN at this time isn't wrong, but it's also not complete,
> e.g. nothing prevents userspace from changing the gpa->hva mapping after the
> initial registration.  Not that that's likely to happen (or not break the guest),
> but my point is that random checks on the backing PFN really have no meaning in
> KVM unless KVM can guarantee that the PFN is stable for the duration of its use.
>
> And conversely, the GHCB doesn't require the GHCB to be shared until the first
> use.  E.g. arguably KVM should fully check the usability of the GPA, but the
> GHCB spec disallows that.  And I honestly can't see why SNP is special with
> respect to the GHCB.  ES guests will explode just as badly if the GPA points at
> garbage.
>
> I guess I'm not against the check, but it feels extremely arbitrary.
>
>> +			gfn = GHCB_MSR_GPA_REG_ERROR;
>> +		else
>> +			svm->ghcb_registered_gpa = gfn_to_gpa(gfn);
>> +
>> +		set_ghcb_msr_bits(svm, gfn, GHCB_MSR_GPA_REG_GFN_MASK,
>> +				  GHCB_MSR_GPA_REG_VALUE_POS);
>> +		set_ghcb_msr_bits(svm, GHCB_MSR_GPA_REG_RESP, GHCB_MSR_INFO_MASK,
>> +				  GHCB_MSR_INFO_POS);
>> +		break;
>> +	}
>>  	case GHCB_MSR_TERM_REQ: {
>>  		u64 reason_set, reason_code;
>>  
>> @@ -2970,6 +2989,12 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>>  		return -EINVAL;
>>  	}
>>  
>> +	/* SEV-SNP guest requires that the GHCB GPA must be registered */
>> +	if (sev_snp_guest(svm->vcpu.kvm) && !ghcb_gpa_is_registered(svm, ghcb_gpa)) {
>> +		vcpu_unimpl(&svm->vcpu, "vmgexit: GHCB GPA [%#llx] is not registered.\n", ghcb_gpa);
> I saw this a few other place.  vcpu_unimpl() is not the right API.  KVM supports
> the guest request, the problem is that the GHCB spec _requires_ KVM to terminate
> the guest in this case.

What is the preferred method to log it so that someone debugging know
what went wrong.

thanks

