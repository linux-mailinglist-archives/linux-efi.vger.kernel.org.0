Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD0606062
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 14:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJTMjX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 08:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJTMjW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 08:39:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D4ABB7
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 05:39:19 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1olUpM-0004m0-0r; Thu, 20 Oct 2022 14:39:12 +0200
Message-ID: <9c06c75d-5079-dd27-6533-c053c986083e@leemhuis.info>
Date:   Thu, 20 Oct 2022 14:39:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
To:     Yicong Yang <yangyicong@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, probinson@gmail.com, andersson@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        Linuxarm <linuxarm@huawei.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20220916101843.495879-1-ardb@kernel.org>
 <56877644-8173-d2ed-ed00-7973734a3698@huawei.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] efi/libstub: arm64: avoid SetVirtualAddressMap() when
 possible
In-Reply-To: <56877644-8173-d2ed-ed00-7973734a3698@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1666269560;d8d0ba60;
X-HE-SMSGID: 1olUpM-0004m0-0r
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker. CCing the regression
mailing list, as it should be in the loop for all regressions, as
explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
On 19.10.22 05:24, Yicong Yang wrote:
> 
> After entering 6.1-rc1 the efi runtime services is not working on my platform:
> 
> [    0.054039] Remapping and enabling EFI services.
> [    0.054043] UEFI virtual mapping missing or invalid -- runtime services will not be available
> 
> Not sure this patch is the root cause since I see some refactor of efi codes in 6.1-rc1,
> but simply reverting this make EFI runtime services works again. Tested on HiSilicon's
> Kunpeng 920 arm64 server using 48 bit VA address:
> 
> CONFIG_ARM64_VA_BITS_48=y
> CONFIG_ARM64_VA_BITS=48
> 
> Thanks.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced d3549a938b73f203ef522562ae9f2d38aa43d234
#regzbot title efi/libstub: arm64: efi runtime services stopped working
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

> On 2022/9/16 18:18, Ard Biesheuvel wrote:
>> EFI's SetVirtualAddressMap() runtime service is a horrid hack that we'd
>> like to avoid using, if possible. For 64-bit architectures such as
>> arm64, the user and kernel mappings are entirely disjoint, and given
>> that we use the user region for mapping the UEFI runtime regions when
>> running under the OS, we don't rely on SetVirtualAddressMap() in the
>> conventional way, i.e., to permit kernel mappings of the OS to coexist
>> with kernel region mappings of the firmware regions. This means that, in
>> principle, we should be able to avoid SetVirtualAddressMap() altogether,
>> and simply use the 1:1 mapping that UEFI uses at boot time. (Note that
>> omitting SetVirtualAddressMap() is explicitly permitted by the UEFI
>> spec).
>>
>> However, there is a corner case on arm64, which, if configured for
>> 3-level paging (or 2-level paging when using 64k pages), may not be able
>> to cover the entire range of firmware mappings (which might contain both
>> memory and MMIO peripheral mappings).
>>
>> So let's avoid SetVirtualAddressMap() on arm64, but only if the VA space
>> is guaranteed to be of sufficient size.
>>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>  drivers/firmware/efi/libstub/arm64-stub.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
>> index cd3bea25c762..4fff6c32899e 100644
>> --- a/drivers/firmware/efi/libstub/arm64-stub.c
>> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
>> @@ -31,6 +31,15 @@ efi_status_t check_platform_features(void)
>>  			efi_err("This 16 KB granular kernel is not supported by your CPU\n");
>>  		return EFI_UNSUPPORTED;
>>  	}
>> +
>> +	/*
>> +	 * If we have 48 bits of VA space for TTBR0 mappings, we can map the
>> +	 * UEFI runtime regions 1:1 and so calling SetVirtualAddressMap() is
>> +	 * unnecessary.
>> +	 */
>> +	if (VA_BITS_MIN >= 48)
>> +		efi_novamap = true;
>> +
>>  	return EFI_SUCCESS;
>>  }
>>  
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
