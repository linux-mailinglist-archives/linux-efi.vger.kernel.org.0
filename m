Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3D2622072
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 00:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKHXtO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 18:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiKHXtM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 18:49:12 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693055B866;
        Tue,  8 Nov 2022 15:49:11 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 38CDC419E9CC;
        Tue,  8 Nov 2022 23:49:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 38CDC419E9CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1667951348;
        bh=A9g4mlGOpgbc9SfTjDYTZ+BTxLDY01DkiMQcvJ7EXdg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ObZlrKDOcTgS01n7ylb3MREgXfjMe6vbQEs2hJCUZbgE7IqTyKrsWGZ2hXOh+DMFk
         ZJsGSSWbI7N98oMuR9uF9NfHa1k+YFNtgXxJOB6oKX+HPaO9C59Xkehh9eSH7I/SQ1
         AYe9N7PRQ86ftAvWFoArTD2YRb/p07ZVSdR3BmVg=
MIME-Version: 1.0
Date:   Wed, 09 Nov 2022 02:49:08 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 00/23] x86_64: Improvements at compressed kernel stage
In-Reply-To: <fc262405-451e-3842-9b08-bc36614e810a@amd.com>
References: <cover.1666705333.git.baskov@ispras.ru>
 <e2beec0b-22d3-91bd-c57c-8c8ad2137406@amd.com>
 <d97fdff486959dbf841c92b3cb644740@ispras.ru>
 <fc262405-451e-3842-9b08-bc36614e810a@amd.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <4a942ab07fd320ba9a058c8a112503bd@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-11-08 21:17, Limonciello, Mario wrote:
> On 11/8/2022 01:01, Evgeniy Baskov wrote:
>> On 2022-11-04 21:21, Limonciello, Mario wrote:
>>> On 10/25/2022 09:12, Evgeniy Baskov wrote:
>>>> ...
>>>> 
>>> 
>>> Hi,
>>> 
>>> I was talking to Peter Jones recently about what was still missing 
>>> for
>>> NX support in the kernel and he pointed me at this series.
>>> 
>>> So I had a try with this series on top of:
>>> 
>>> ee6050c8af96 ("Merge tag 'ata-6.1-rc4' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata")
>>> 
>>> Unfortunately I can't boot the system with this series applied.
>>> This is not on a system that enforces NX pre-boot (but that was my
>>> goal after I could prove booting on something that doesn't).
>>> I didn't apply Peter's patch 6 you referenced in your cover letter,
>>> but I don't expect that's the reason for the failure.
>>> 
>>> I get:
>>> 
>>> "Failed to allocate space for tmp_cmdline"
>>> 
>>>    -- System Halted
>>> 
>>> This is early enough [1] that I don't have anything else output to a
>>> serial log from the kernel.
>>> 
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Ftorvalds%2Flinux%2Fblob%2Fd4013bc4d49f6da8178a340348369bb9920225c9%2Farch%2Fx86%2Fboot%2Fcompressed%2Fkaslr.c%23L268&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C9280e92e85bc4e2b52cd08dac15704a5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638034876740462327%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=oiCJUa8M3x%2FYCxVjJj98R7iU%2FzIj%2FQxdVOWbnqGWCNI%3D&amp;reserved=0
>>> 
>>> Since this is only in the kaslr path, I tried to turn that off with
>>> 'nokaslr' on the kernel command line.
>>> 
>>> I then get a failure of:
>>> 
>>> "Out of memory while allocating zstd_dctx"
>>> 
>>>   -- System Halted
>>> 
>>> This kernel was booted from the following path:
>>> -> Insyde BIOS
>>> --> shim (from Fedora 36 repository)
>>> ---> GRUB (from Peter for Fedora 36 w/ some level NX support)
>>> ----> kernel binary (self-built)
>>> 
>>> The BIOS on this system doesn't validate NX, but also the shim binary
>>> did not have the NX bit set in the PE header.
>>> 
>>> Your cover letter referenced CONFIG_EFI_STUB_EXTRACT_DIRECT but I
>>> didn't find this option in the series.  I also tried both with
>>> CONFIG_EFI_DXE_MEM_ATTRIBUTES=y or unset, same result.
>> 
>> Hi,
>> 
>> Thanks for your feedback!
>> 
> 
> Sure!
> 
>> CONFIG_EFI_STUB_EXTRACT_DIRECT option was removed in v2 of the series
>> and direct extraction is unconditional now.
>> 
>> You are getting really weird errors, which unfortunately I am unable
>> to reproduce yet. I've tried booting with fedora's grub and the series
>> applied on top of ee6050c8af96, but it did boot successfully.
> 
> Well so I expect the unique difference is that I'm using Peter's GRUB
> that has some NX support landed.  He has binaries for it here:
> 
> https://blog.uncooperative.org/~pjones/nx/repo/
> 
> *Theoretically* a BIOS that enforces NX should be able to boot a shim 
> with
> the NX compat bit set which should be able to boot that GRUB
> supporting NX which should be able to boot this series.
> 
>> 
>>  From the error messages it's some problem with malloc() 
>> implementation
>> of compressed kernel code. I suspect that malloc_ptr inside .bss is 
>> not
>> zeroed. This should not happen when booting via either non-UEFI
>> interface, or via UEFI (when kernel is properly loaded as PE image).
>> The problem, I think, arises when kernel is loaded as a blob, but EFI
>> handover protocol is used to start its execution. This is what grub
>> seems to be doing.
>> 
>> Can you please try booting with patches below applied on top?
>> If this fixes the problem, I'll include these changes in v3.
> 
> Yup, spot on.  I can the kernel from Peter's NX enabled GRUB now with:
> * 6.1-rc4
> * Your existing 23 patch series
> * this new patch
> 



> Thanks!!
> 
> Would you mind CC me when you submit v3?  As I have an interest in
> seeing NX support I'd like to continue to follow along on the series.

Ok.
> 
> Anything in the series you don't change in any material way from v2
> please feel free to include:
> 
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> 

Great, thanks!
