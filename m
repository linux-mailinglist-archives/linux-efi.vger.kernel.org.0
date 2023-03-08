Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F606B0E24
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 17:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjCHQG4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 11:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjCHQGe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 11:06:34 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F20C460AC;
        Wed,  8 Mar 2023 08:05:22 -0800 (PST)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id A2D2C44C1022;
        Wed,  8 Mar 2023 16:05:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A2D2C44C1022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678291518;
        bh=Wnrv20x1Jmhl55a1g3nJS1uM99ls4YYXhgmxoQUqOAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rioA+8DN1vkplbfxKnFZwMvuUxXCiOKmoYs0CdjYFfppkC24ZepCfxDqy7K6gqQKF
         9iogjZQy4IgEXxuW4iB+PF7cRW2FSRccYG3nZijtgl9+Z6bycyLqf+sOGSZuxa3+QI
         aUto010DVvtaKIT4X8E4zanpULrIMpemQbxxDaqc=
MIME-Version: 1.0
Date:   Wed, 08 Mar 2023 19:05:18 +0300
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 07/26] x86/build: Check W^X of vmlinux during build
In-Reply-To: <CAMj1kXEMk1mLiwUuUTH4V1ro93MmBnwPnPMzJfSG+eH5ts8j3g@mail.gmail.com>
References: <cover.1671098103.git.baskov@ispras.ru>
 <3ca525852ce14a8e04949ff115cb6ec28c8f120b.1671098103.git.baskov@ispras.ru>
 <CAMj1kXEMk1mLiwUuUTH4V1ro93MmBnwPnPMzJfSG+eH5ts8j3g@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <acdc9a8dc7ea944f25eb7c50aed94c1a@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2023-03-08 12:34, Ard Biesheuvel wrote:
> On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
>> 
>> Check if there are simultaneously writable and executable
>> program segments in vmlinux ELF image and fail build if there are any.
>> 
>> This would prevent accidental introduction of RWX segments.
>> 
>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Tested-by: Peter Jones <pjones@redhat.com>
>> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
>> ---
>>  arch/x86/boot/compressed/Makefile | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/x86/boot/compressed/Makefile 
>> b/arch/x86/boot/compressed/Makefile
>> index 1acff356d97a..4dcab38f5a38 100644
>> --- a/arch/x86/boot/compressed/Makefile
>> +++ b/arch/x86/boot/compressed/Makefile
>> @@ -112,11 +112,17 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>>  vmlinux-objs-$(CONFIG_EFI_STUB) += 
>> $(objtree)/drivers/firmware/efi/libstub/lib.a
>> 
>> +quiet_cmd_wx_check = WXCHK   $<
>> +cmd_wx_check = if $(OBJDUMP) -p $< | grep "flags .wx" > /dev/null; \
>> +              then (echo >&2 "$<: Simultaneously writable and 
>> executable sections are prohibited"; \
>> +                    /bin/false); fi
>> +
>>  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>>         $(call if_changed,ld)
>> 
>>  OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
>>  $(obj)/vmlinux.bin: vmlinux FORCE
>> +       $(call cmd,wx_check)
> 
> This breaks the way we track dependencies between make targets: the
> FORCE will result in the check being performed every time, even if
> nothing gets rebuilt.
> 
> Better to do something like the below (apologies for the alphabet soup)
> 
> 
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -112,18 +112,17 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>  vmlinux-objs-$(CONFIG_EFI_STUB) +=
> $(objtree)/drivers/firmware/efi/libstub/lib.a
> 
> -quiet_cmd_wx_check = WXCHK   $<
> -cmd_wx_check = if $(OBJDUMP) -p $< | grep "flags .wx" > /dev/null; \
> -              then (echo >&2 "$<: Simultaneously writable and
> executable sections are prohibited"; \
> -                    /bin/false); fi
> +quiet_cmd_objcopy_and_wx_check = $(quiet_cmd_objcopy)
> +      cmd_objcopy_and_wx_check = if $(OBJDUMP) -p $< | grep "flags
> .wx" > /dev/null; then \
> +                                       (echo >&2 "$<: Simultaneously
> writable and executable sections are prohibited"; \
> +                                       /bin/false); else 
> $(cmd_objcopy); fi
> 
>  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>         $(call if_changed,ld)
> 
>  OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
>  $(obj)/vmlinux.bin: vmlinux FORCE
> -       $(call cmd,wx_check)
> -       $(call if_changed,objcopy)
> +       $(call if_changed,objcopy_and_wx_check)

Thank you for suggestion! I will fix it.
