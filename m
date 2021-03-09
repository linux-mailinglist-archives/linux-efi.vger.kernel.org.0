Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB6F33292D
	for <lists+linux-efi@lfdr.de>; Tue,  9 Mar 2021 15:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhCIOwg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Mar 2021 09:52:36 -0500
Received: from foss.arm.com ([217.140.110.172]:54794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231625AbhCIOwG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 9 Mar 2021 09:52:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A04C1042;
        Tue,  9 Mar 2021 06:52:06 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EA983F71B;
        Tue,  9 Mar 2021 06:52:02 -0800 (PST)
Subject: Re: [PATCH] arm64/mm: Fix __enable_mmu() for new TGRAN range values
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1614954969-14338-1-git-send-email-anshuman.khandual@arm.com>
 <8735x5zozr.wl-maz@kernel.org> <20210309140527.GB28395@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <718f4b0c-20d9-8588-1268-e5b26690899d@arm.com>
Date:   Tue, 9 Mar 2021 20:22:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210309140527.GB28395@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 3/9/21 7:35 PM, Will Deacon wrote:
> On Mon, Mar 08, 2021 at 02:42:00PM +0000, Marc Zyngier wrote:
>> On Fri, 05 Mar 2021 14:36:09 +0000,
>> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>> -	switch (cpuid_feature_extract_unsigned_field(mmfr0, tgran_2)) {
>>> -	default:
>>> -	case 1:
>>> +	tgran_2 = cpuid_feature_extract_unsigned_field(mmfr0, tgran_2_shift);
>>> +	if (tgran_2 == ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE) {
>>>  		kvm_err("PAGE_SIZE not supported at Stage-2, giving up\n");
>>>  		return -EINVAL;
>>> -	case 0:
>>> +	} else if (tgran_2 == ID_AA64MMFR0_TGRAN_2_SUPPORTED_DEFAULT) {
>>>  		kvm_debug("PAGE_SIZE supported at Stage-2 (default)\n");
>>> -		break;
>>> -	case 2:
>>> +	} else if (tgran_2 >= ID_AA64MMFR0_TGRAN_2_SUPPORTED_MIN &&
>>> +		   tgran_2 <= ID_AA64MMFR0_TGRAN_2_SUPPORTED_MAX) {
>>>  		kvm_debug("PAGE_SIZE supported at Stage-2 (advertised)\n");
>>> -		break;
>>> +	} else {
>>> +		kvm_err("Unsupported value, giving up\n");
>>> +		return -EINVAL;
>>
>> nit: this doesn't say *what* value is unsupported, and I really
>> preferred the switch-case version, such as this:
>>
>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index 1f22b36a0eff..d267e4b1aec6 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -312,15 +312,18 @@ int kvm_set_ipa_limit(void)
>>  
>>  	switch (cpuid_feature_extract_unsigned_field(mmfr0, tgran_2)) {
>>  	default:
>> -	case 1:
>> +	case ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE:
>>  		kvm_err("PAGE_SIZE not supported at Stage-2, giving up\n");
>>  		return -EINVAL;
>> -	case 0:
>> +	case ID_AA64MMFR0_TGRAN_2_SUPPORTED_DEFAULT:
>>  		kvm_debug("PAGE_SIZE supported at Stage-2 (default)\n");
>>  		break;
>> -	case 2:
>> +	case ID_AA64MMFR0_TGRAN_2_SUPPORTED_MIN ... ID_AA64MMFR0_TGRAN_2_SUPPORTED_MAX:
>>  		kvm_debug("PAGE_SIZE supported at Stage-2 (advertised)\n");
>>  		break;
>> +	default:
>> +		kvm_err("Unsupported value for TGRAN_2, giving up\n");
>> +		return -EINVAL;
>>  	}
>>  
>>  	kvm_ipa_limit = id_aa64mmfr0_parange_to_phys_shift(parange);
>>
>>
>> Otherwise:
>>
>> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> Anshuman -- please can you spin a v2 with the switch syntax as suggested
> above by Marc?

Sure, will do.

