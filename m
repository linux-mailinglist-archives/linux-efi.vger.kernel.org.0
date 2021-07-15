Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E947A3C9FEE
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 15:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhGONpg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 09:45:36 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:2657
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231854AbhGONpf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 15 Jul 2021 09:45:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKTVjO0RefRdgXSE/rrHRYB/iPv1P5afaPr7Oy3Pg8jzNRfHDfBfT4qwnMKRjVLZFeLaQ7mGbyikT7ebMXtGiGCQg31Q7bu8Yoc3TpMbvpQTj5vIhiIiZ+MeNTvu/dEHGRpKmovRdFZ7Qu6BLAkEDSJoSFExtSWQg5JELBveI99PHLnGNOQROmnMilpNPds+ONDdquzFrXVkR6gtrl8+v3vTkyhoMtB+3HJ1skL9en31D3uiE2JkSNXEgmyXEokobFUf33jfZFb6PwAnuyWBgyRSZ8NHAaj+nIqq4hVLWgFwHaitKAbpjOHcARtKogFMpJ0WIbBZ1aORmbsrte6+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5mLd+BB0waimYb5/L+uimUn9geNsdDU3VnD12PIv9g=;
 b=PlraZy2nb5cffrMLu7kPCDHLuJGekpElrq69Sl9U0rJEo/xSXKPeCDv4xYLiY1KTcqd6yR9st9Pt0TSZ2RxrCNkqsodHdFEfbEmaxno08mV/fI7IpvF5a5onoJHpjxmpoSl+TFiNzghRb5h9XGB9x9/TNLinPSzsaA5aYWNmyTXFizgEa65OisUhVcdVYppYU2qUSJyGMEpXreOTBOFpGSE5luOfgqqGSlKEMX07j5slIfgo4Je7fXW3S+fUUJgfZczgO7788iy1P+uHDrQWrNAQBraFvkmbslMjyB5htBtoqE0mHmkkTy1/u0Pr2405Ndb78w7XpYM/4NUnZ0Yqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5mLd+BB0waimYb5/L+uimUn9geNsdDU3VnD12PIv9g=;
 b=rUo0ogx9rkTwdrcaPWW1lOydwVgAuS3WoN5zDb3C2G1qP77BY6r29pCzBiG6WCLUnK8kE2t3w7bv0HbLKhoaTsv8t96SykTdsfcMPxb29OdrRvUO4pfcZKLPP8zAWTWTvZ57lKt8x6Kl/kPuPZV3LYf3BCzlfJbO/DvFnXjJtd8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5309.namprd12.prod.outlook.com (2603:10b6:5:39d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Thu, 15 Jul
 2021 13:42:40 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 13:42:40 +0000
Subject: Re: [PATCH Part2 RFC v4 01/40] KVM: SVM: Add support to handle AP
 reset MSR protocol
To:     Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-2-brijesh.singh@amd.com> <YO9GWVsZmfXJ4BRl@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <e634061d-78f4-dcb2-b7e5-ebcb25585765@amd.com>
Date:   Thu, 15 Jul 2021 08:42:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YO9GWVsZmfXJ4BRl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:806:28::26) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SA9PR13CA0171.namprd13.prod.outlook.com (2603:10b6:806:28::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.10 via Frontend Transport; Thu, 15 Jul 2021 13:42:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5af97b6-20ff-4468-809b-08d9479669b4
X-MS-TrafficTypeDiagnostic: DM4PR12MB5309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5309D3F0DE0FC3E878335DBAEC129@DM4PR12MB5309.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPaHJ9N5mpZXuLpOtsHvE1Sct+jYWW/T6JzTpkDXJKfcL8QScmZ6cQMbsMXVaAT85q9hpc/bWlZC65LrVFMavfkBK1DeuR8RSNtSkge6IqLnfNlkhxt5Q+ahVfGcUQrvvhCb3+gayaZc4ApnoJHe8MEjHFdPaQn0WRRQC50XLQu/bUawYn1OZDO1nehm6TsqslQaNOPmdJTcVUJhiHj+VjVkj5JweWWMJ/uymmWd+0fJW38WZQmnYCk0xma4/hpD7W3F6TGUTtKnRIHo4zW1gwr1J+pSk+5aN+qq0fA6IzGA/myN9kUy9dCWOgjuoiTJmFnvaz+N/sZXD9r66pv+L8hvhxeOGAr0ArT0KF6v+KBSR0eV2D9lWRHYzkkECsDQApazAeqNZuPoEU/Jbw1KmApiLmZnjLLW7v9ze0GkhqjxElzR89E92j/piKFMq0GEyJGMxR9GztA8LJbmTJH3vpchGhVqJgHnDUOvXCV37U3ghFTadFhAz7kLO3Luc4E+WtzrmFEYiJBWBF/03+rjabIuJoK5K6we10Y9gnLIK53FtuOLYSq0f4rpFQx12cFZRam6I1I+G+9YkCBFoOH7pzIQo6X5hwrIzPRgzSG2Tle/9dzyaIzXkLxnf/JSCtRuajiAGoG8OqXmo/egmkHdC1ckdhSlQKT3pW6qrg4nxKiyufG9CiEZS5rCVfbhCKUExogHdahV2rOTcu68DdZNtYLn+OmJeKouJQFk2uv9Q8kbJW3Y3SKfAT4T9OTsxadb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(54906003)(36756003)(956004)(110136005)(66476007)(66556008)(83380400001)(7406005)(7416002)(2906002)(2616005)(86362001)(6636002)(53546011)(26005)(186003)(38100700002)(16576012)(5660300002)(316002)(6486002)(8936002)(8676002)(478600001)(31686004)(4326008)(66946007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkRwNG52S081V1g0V2lseG5kOXB6N0hkUWU1ejNoSE5zcnZUTFpPY1czUXJG?=
 =?utf-8?B?ZFBDQlFXY1ZFSDYvaVB6ZzZudUJpdHhHUk5FRG9qaU5mbmN2bk9rOXNCSFAz?=
 =?utf-8?B?SzZldnJVNm5mVVdmdHNlZlVvbGZIS1VzdHUxbWx1MWpkUnZta2J5VUFrZFNV?=
 =?utf-8?B?RGUybzBTaHFDZ1M1Q3ZGaUlIRnNuTVFTZ0U4cDAwOFdHQzUvTXE2MDVWZ0Ez?=
 =?utf-8?B?RWFzTFo1QnpWWDN3RVN6Wkl3L2xacVZYRDRjQkNCZjhOK3QxZnYxNDdiRU5y?=
 =?utf-8?B?dmY1ZlFNU01IbU4rbjhxakg1MmRZWElVeDJoQ3pYaTd3RnFvVjlhQ2JoQW4r?=
 =?utf-8?B?ZXpmMFJScG1qNi8rRTRTZVluRGRVbldjekd0Z2VCS3Z0Q2VCc2pQek1XQ2U4?=
 =?utf-8?B?UDBSUStYUjdMK01NZkUrYzVQU2N2VUZxMDdVa0dKWWlTWEszRUpOU3VIa3Vn?=
 =?utf-8?B?Rnp2SXZqbXg3YTdDTlVRcmRkZUxjRnQ5YWNDVUxVNWdwZzZHd1NRNGIzaDhw?=
 =?utf-8?B?SGJyVFEvTStiaDRhWE42cEdaTzZ2ZWIwV2NaMUZWNWVBQktLcHFWRnlZV3pU?=
 =?utf-8?B?clB4YkRNOFRiUWo5MjJIWjduNU02SjBoMTZSOUlVd2pzcTM1U2VCcEJpSmRI?=
 =?utf-8?B?UzFJQWNHNDk4ZXludnI0bGNad2E4ZmQ3VDZvem1vSUc1czl0VG81YzliK1JS?=
 =?utf-8?B?WFdTcTFTS3JnclovME5IaVBxMUdiSU14YlRUV1paRUgzVzY2dklMM05FK1ND?=
 =?utf-8?B?RkllZThMVWtBZTg0K2VvSnJZenpqTzlaNG95cm1jK3VkVExCcElwYlRiYVRa?=
 =?utf-8?B?ZnVudmxuL2pKa1hmemxhWnVmWmo3NGQyZmtkbTBWelFPc0ErUyszVnJBVlhh?=
 =?utf-8?B?dkZDUlc2QXdPL1lyTTJzaFVDUHNQaWc0TDV1MnROYmhmKzNqWTFNTnJWNWFm?=
 =?utf-8?B?dXJyanNTQVl1WFg1UG9TQ2tDNVg5VDhmcmNNR3krOTR3VW1ubTMwYmJMSjZw?=
 =?utf-8?B?OFpYTUhsUXZWQVFrUmwzeGFleFg1Z3BMaDJaSU1kRFg1Sy9XTDBZb0I1Z0s3?=
 =?utf-8?B?K1Z1MUVZaXYxZkoxR2U3dmNXcENYMHI3WlVxditiWDh4cVJUUWpJdU5uSVR2?=
 =?utf-8?B?THVHNUNia1JSZFNUK0xrdE1FYUZBR01NT2ZGVWk4NU0vWWhXRDdMWlJnZFhD?=
 =?utf-8?B?MkJrZFFoZTRXZ3hJM2xVUU1rbmtDL0dEYVFNc1BWUytaZ3UraSsvaVBpSXN5?=
 =?utf-8?B?NlVHbC9kR25BekljcS9CYlZNSzRCVW9LdTE2eTB6YlkvMXEwVjRWdDZSNDhV?=
 =?utf-8?B?dkF1dm1UdjhsbUc1c2NXZElVT0dQam1vZHNtYm43S1FDSGR4KzBKVFU1SkJw?=
 =?utf-8?B?NG1NR0MvOUU5cFRaVGFnVHExVHlHYjgwVWhVV1MxcjB5ZnMwKzBveWNsOW8r?=
 =?utf-8?B?MTU1R0JzZnNXZFl3a1RqT29zUElsTW1CMTdweGFNblhmQTFwa25OMHdyVGs1?=
 =?utf-8?B?T29ndVN1OW9NNXBVbTdJUXVabmVPdHNuSHd4UlRja3hwSFhUemFBeERiSlRo?=
 =?utf-8?B?UGJJSXpPalJVNDVqTE9MUG5DOVhsTlNFWVlBeVV5cFI1cXFBMlQ5RHlIb08y?=
 =?utf-8?B?N2oydVV2djR3WEpBUmxIKzF3Ty9aQ1l3QlI2ZFAzMkxscmlTeWFyaHF2dWdj?=
 =?utf-8?B?Y2tlREZFdTkrYURRa29iYXNZdHZ5MURoaFNFR3BlRXdqaWRjZzRLdHkwMlZh?=
 =?utf-8?Q?2/Cr5k1+kaBvfCNcmCPN2PbTxysvTHdXdgeMrJ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5af97b6-20ff-4468-809b-08d9479669b4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 13:42:39.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYQj3Got3kO5XoQqTWN4aJVI3E6do+GGwvKI6zMnVSZO+vUpOkAICKlMf01SLAbyh4HFzlz8v4sqMX7Miq9o4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5309
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/14/21 3:17 PM, Sean Christopherson wrote:
> On Wed, Jul 07, 2021, Brijesh Singh wrote:
>> From: Tom Lendacky <thomas.lendacky@amd.com>
>>
>> Add support for AP Reset Hold being invoked using the GHCB MSR protocol,
>> available in version 2 of the GHCB specification.
> 
> Please provide a brief overview of the protocol, and why it's needed.  I assume
> it's to allow AP wakeup without a shared GHCB?

Right, mainly the ability to be able to issue an AP reset hold from a mode
that would not be able to access the GHCB as a shared page, e.g. 32-bit
mode without paging enabled where reads/writes are always encrypted for an
SEV guest.

> 
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
> 
> ...
> 
>>  static u8 sev_enc_bit;
>>  static DECLARE_RWSEM(sev_deactivate_lock);
>>  static DEFINE_MUTEX(sev_bitmap_lock);
>> @@ -2199,6 +2203,9 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
>>  
>>  void sev_es_unmap_ghcb(struct vcpu_svm *svm)
>>  {
>> +	/* Clear any indication that the vCPU is in a type of AP Reset Hold */
>> +	svm->ap_reset_hold_type = AP_RESET_HOLD_NONE;
>> +
>>  	if (!svm->ghcb)
>>  		return;
>>  
>> @@ -2404,6 +2411,22 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
>>  				  GHCB_MSR_INFO_POS);
>>  		break;
>>  	}
>> +	case GHCB_MSR_AP_RESET_HOLD_REQ:
>> +		svm->ap_reset_hold_type = AP_RESET_HOLD_MSR_PROTO;
>> +		ret = kvm_emulate_ap_reset_hold(&svm->vcpu);
> 
> The hold type feels like it should be a param to kvm_emulate_ap_reset_hold().

I suppose it could be, but then the type would have to be tracked in the
kvm_vcpu_arch struct instead of the vcpu_svm struct, so I opted for the
latter. Maybe a helper function, sev_ap_reset_hold(), that sets the type
and then calls kvm_emulate_ap_reset_hold(), but I'm not seeing a big need
for it.

> 
>> +
>> +		/*
>> +		 * Preset the result to a non-SIPI return and then only set
>> +		 * the result to non-zero when delivering a SIPI.
>> +		 */
>> +		set_ghcb_msr_bits(svm, 0,
>> +				  GHCB_MSR_AP_RESET_HOLD_RESULT_MASK,
>> +				  GHCB_MSR_AP_RESET_HOLD_RESULT_POS);
>> +
>> +		set_ghcb_msr_bits(svm, GHCB_MSR_AP_RESET_HOLD_RESP,
>> +				  GHCB_MSR_INFO_MASK,
>> +				  GHCB_MSR_INFO_POS);
> 
> It looks like all uses set an arbitrary value and then the response.  I think
> folding the response into the helper would improve both readability and robustness.

Joerg pulled this patch out and submitted it as part of a small, three
patch series, so it might be best to address this in general in the
SEV-SNP patches or as a follow-on series specifically for this re-work.

> I also suspect the helper needs to do WRITE_ONCE() to guarantee the guest sees
> what it's supposed to see, though memory ordering is not my strong suit.

This is writing to the VMCB that is then used to set the value of the
guest MSR. I don't see anything done in general for writes to the VMCB, so
I wouldn't think this should be any different.

> 
> Might even be able to squeeze in a build-time assertion.
> 
> Also, do the guest-provided contents actually need to be preserved?  That seems
> somewhat odd.

Hmmm... not sure I see where the guest contents are being preserved.

> 
> E.g. can it be
> 
> static void set_ghcb_msr_response(struct vcpu_svm *svm, u64 response, u64 value,
> 				  u64 mask, unsigned int pos)
> {
> 	u64 val = (response << GHCB_MSR_INFO_POS) | (val << pos);
> 
> 	WRITE_ONCE(svm->vmcb->control.ghcb_gpa |= (value & mask) << pos;
> }
> 
> and
> 
> 		set_ghcb_msr_response(svm, GHCB_MSR_AP_RESET_HOLD_RESP,
> 				      GHCB_MSR_AP_RESET_HOLD_RESULT_MASK,
> 				      GHCB_MSR_AP_RESET_HOLD_RESULT_POS);
> 
>> +		break;
>>  	case GHCB_MSR_TERM_REQ: {
>>  		u64 reason_set, reason_code;
>>  
>> @@ -2491,6 +2514,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>>  		ret = svm_invoke_exit_handler(vcpu, SVM_EXIT_IRET);
>>  		break;
>>  	case SVM_VMGEXIT_AP_HLT_LOOP:
>> +		svm->ap_reset_hold_type = AP_RESET_HOLD_NAE_EVENT;
>>  		ret = kvm_emulate_ap_reset_hold(vcpu);
>>  		break;
>>  	case SVM_VMGEXIT_AP_JUMP_TABLE: {
>> @@ -2628,13 +2652,29 @@ void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
>>  		return;
>>  	}
>>  
>> -	/*
>> -	 * Subsequent SIPI: Return from an AP Reset Hold VMGEXIT, where
>> -	 * the guest will set the CS and RIP. Set SW_EXIT_INFO_2 to a
>> -	 * non-zero value.
>> -	 */
>> -	if (!svm->ghcb)
>> -		return;
>> +	/* Subsequent SIPI */
>> +	switch (svm->ap_reset_hold_type) {
>> +	case AP_RESET_HOLD_NAE_EVENT:
>> +		/*
>> +		 * Return from an AP Reset Hold VMGEXIT, where the guest will
>> +		 * set the CS and RIP. Set SW_EXIT_INFO_2 to a non-zero value.
>> +		 */
>> +		ghcb_set_sw_exit_info_2(svm->ghcb, 1);
>> +		break;
>> +	case AP_RESET_HOLD_MSR_PROTO:
>> +		/*
>> +		 * Return from an AP Reset Hold VMGEXIT, where the guest will
>> +		 * set the CS and RIP. Set GHCB data field to a non-zero value.
>> +		 */
>> +		set_ghcb_msr_bits(svm, 1,
>> +				  GHCB_MSR_AP_RESET_HOLD_RESULT_MASK,
>> +				  GHCB_MSR_AP_RESET_HOLD_RESULT_POS);
>>  
>> -	ghcb_set_sw_exit_info_2(svm->ghcb, 1);
>> +		set_ghcb_msr_bits(svm, GHCB_MSR_AP_RESET_HOLD_RESP,
>> +				  GHCB_MSR_INFO_MASK,
>> +				  GHCB_MSR_INFO_POS);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>>  }
>> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
>> index 0b89aee51b74..ad12ca26b2d8 100644
>> --- a/arch/x86/kvm/svm/svm.h
>> +++ b/arch/x86/kvm/svm/svm.h
>> @@ -174,6 +174,7 @@ struct vcpu_svm {
>>  	struct ghcb *ghcb;
>>  	struct kvm_host_map ghcb_map;
>>  	bool received_first_sipi;
>> +	unsigned int ap_reset_hold_type;
> 
> Can't this be a u8?

Yes, it could be, maybe even an enum and let the compiler decide on the size.

Thanks,
Tom

> 
>>  
>>  	/* SEV-ES scratch area support */
>>  	void *ghcb_sa;
>> -- 
>> 2.17.1
>>
