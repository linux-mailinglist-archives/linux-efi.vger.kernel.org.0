Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324C41C48E2
	for <lists+linux-efi@lfdr.de>; Mon,  4 May 2020 23:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgEDVV3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 May 2020 17:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgEDVV2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 May 2020 17:21:28 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8D3C061A0E
        for <linux-efi@vger.kernel.org>; Mon,  4 May 2020 14:21:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f8so314821plt.2
        for <linux-efi@vger.kernel.org>; Mon, 04 May 2020 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LfzIhBKyEYjnL3+PecsaPFI1mfT2dyojmCEB1Zt3J7E=;
        b=AoW9DJtUY2hnoqS7o8O7IhkGL7aueMw2BOzOJFVoMkLpGUlbcQCIxJZmAX2JcdbUMy
         bU9YVg3K9Y6P6Un3b0/ECTvE6EDFc3vVqDku+AHvRadT0eIok1D8dBkSrB/fIRXOhX8g
         gqZPQt8fDb9bU/56Qth4yqDbDNTomDYBX+pGMu0fjMsccaO0q+4/MeByUqPOHJrJW+iC
         VANL5jf026u1W1t8ygOputiklsDkiQSceWx/ZsErp9A1fld3UBmr/HH/Yd4t7LsssJs2
         Yy6c4dS9XvaCf9ayckoIbfdFwfV/vzqYZ3kB3Fyq3emWdW6Oa1le3tnQUZ9tdiZT8d+j
         viug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LfzIhBKyEYjnL3+PecsaPFI1mfT2dyojmCEB1Zt3J7E=;
        b=oPV03qVMlDu1VRL9R1LW5ILDKt5pk5TY4DB9ITj5reFPvo+peKxtIqdcK85ovS/Ma1
         xXSZJ4GZXf00uUEIGa4FfjvxUL/qVisQDTqAHt8ubeKtSrq58bSbo21HAu6BytSWQ+Ih
         cOgvdNnQQd7MACUIeOI9KU5Cxa9t6gm9wZxV+82FY6Jt4xLYj7Tx6wl3h7mtSUlEA3f6
         RY6EwFBKKeFs54UVi/Hf1uijxrmya2jtdw/x68y/LPykDzMta40VXTUsXh9UU/FBpbr9
         w0vSrRPcMS7/Tr1PCMl5V9qlEuxvF+UbyT1nbRqO75j2PvVyhxLy89PWG0XMwpSuXSEQ
         xwlQ==
X-Gm-Message-State: AGi0PubK7MmKHZSKJuc4Subxx26gYRDYJNZanT51l5e4khqHF7gclj5h
        V6EIfP1dvQ+wepeBI3wDJVcfaQ==
X-Google-Smtp-Source: APiQypLTnPOCIblicmo14QnUBspgu8ABvtDNcmUBtrph0GlCkSZ741zJlPy88looi5flHFiKAwGF/w==
X-Received: by 2002:a17:902:8601:: with SMTP id f1mr126432plo.122.1588627288078;
        Mon, 04 May 2020 14:21:28 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id f30sm381557pje.29.2020.05.04.14.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 14:21:27 -0700 (PDT)
Date:   Mon, 4 May 2020 14:21:24 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] efi/libstub/x86: work around LLVM ELF quirk build
 regression
Message-ID: <20200504212124.zse6eeinh3z3l2yi@google.com>
References: <20200504081605.32624-1-ardb@kernel.org>
 <CAKwvOdkmXm9Md6ErKeF26M-9mtk_f2i23zndOwV_Z6G1yWmY3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdkmXm9Md6ErKeF26M-9mtk_f2i23zndOwV_Z6G1yWmY3w@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2020-05-04, Nick Desaulniers wrote:
>On Mon, May 4, 2020 at 1:16 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> When building the x86 EFI stub with Clang, the libstub Makefile rules
>> that manipulate the ELF object files may throw an error like:
>>
>>     STUBCPY drivers/firmware/efi/libstub/efi-stub-helper.stub.o
>>   strip: drivers/firmware/efi/libstub/efi-stub-helper.stub.o: Failed to find link section for section 10
>>   objcopy: drivers/firmware/efi/libstub/efi-stub-helper.stub.o: Failed to find link section for section 10
>>
>> This is the result of a LLVM 'feature' [0] where symbol references are
>> stored in a LLVM specific .llvm_addrsig section in a non-transparent way,
>> causing generic ELF tools such as strip or objcopy to choke on them.
>>
>> So drop the .llvm_addrsig section explicitly as well, to work around
>> this behavior.
>>
>> [0] https://sourceware.org/bugzilla/show_bug.cgi?id=23817
>
>This page also has info about the extension:
>https://llvm.org/docs/Extensions.html#sht-llvm-addrsig-section-address-significance-table
>Peter, do you know if it's possible to prevent the emission of this
>section from clang?  Scanning through the sources, it looks like it's
>set unconditionally during LTO, but I couldn't find where else?  Is
>this section required for more than LTO?

-faddrsig has been the default for many platforms since clang 7.
You can find the current default state on various platforms here:

https://github.com/llvm/llvm-project/blob/master/clang/lib/Driver/ToolChains/Clang.cpp#L6157

The table may have other benefits but currently the only use case is lld
--icf=safe , which is safer and better than gold's --icf=safe (which
relies on (hacky) relocation scanning).

The current way things work:
(1) clang always emits .llvm_addrsig
(2) if the linker is lld and --icf=safe is specified, .llvm_addrsig is read to perform safe ICF

makes it easy for people to try --icf=safe, otherwise people will need
to change CFLAGS as well to try the linker size optimization.

This section has nothing to do with LTO.

I am a bit surprised that certain strip can error "Failed to find link section for section 10"
They were expected to set sh_link to 0.

>We need a generic way to disable LLVM extensions when we're not using
>the LLVM binutils.  We have a couple cases where `-no-integrated-as`
>will prevent AsmStreamer from not using assembler extensions, but in
>this case it's the linker+objcopy+strip that don't work with the
>extensions.

objcopy -R .llvm_addrsig can be used when it is difficult to pass -fno-addrsig

(it is also used here
https://sourceware.org/git/?p=glibc.git;a=blobdiff;f=csu/Makefile;h=7460bcb0cf1e6cb296cf76d6e8ed9e43044f89f9;hp=f3498960f89e3b31f7cda6969e6eb3393a305241;hb=3628670a04f9a53586bd91c01588c4462b5e01d3;hpb=b9dab9c53496a8cd5bb18342eceff8a584c37a3e
)

If possible, use -fno-addrsig instead.

>>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>
>Do you have a link to the configs or report so we can repro?
>
>Also, scripts/get_maintainer.pl should recommend our list for patches
>mentioning clang or llvm, which is a wider audience that can help test
>and review.  I've been out sick much of the past week, so I appreciate
>the shared help with code review.  Of course if your intention was to
>be more discreet, I'm sorry I may have just messed that up.
>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>  drivers/firmware/efi/libstub/Makefile | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>> index 8d246b51bd49..4d137615a666 100644
>> --- a/drivers/firmware/efi/libstub/Makefile
>> +++ b/drivers/firmware/efi/libstub/Makefile
>> @@ -66,7 +66,8 @@ CFLAGS_arm64-stub.o           := -DTEXT_OFFSET=$(TEXT_OFFSET)
>>  # .data section of the compressed kernel to ensure initialization. Rename the
>>  # .bss section here so it's easy to pick out in the linker script.
>>  #
>> -STUBCOPY_FLAGS-$(CONFIG_X86)   += --rename-section .bss=.bss.efistub,load,alloc
>> +STUBCOPY_FLAGS-$(CONFIG_X86)   += -R .llvm_addrsig \
>> +                                  --rename-section .bss=.bss.efistub,load,alloc
>
>Do we only observe this for x86, not ARM?
>
>>  STUBCOPY_RELOC-$(CONFIG_X86_32)        := R_386_32
>>  STUBCOPY_RELOC-$(CONFIG_X86_64)        := R_X86_64_64
>>
>> @@ -111,7 +112,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
>>  #
>>  quiet_cmd_stubcopy = STUBCPY $@
>>        cmd_stubcopy =                                                   \
>> -       $(STRIP) --strip-debug -o $@ $<;                                \
>> +       $(STRIP) --strip-debug -R .llvm_addrsig -o $@ $<;               \
>>         if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then            \
>>                 echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
>>                 /bin/false;                                             \
>> --
>> 2.17.1
>>
>
>In the absence of a linker script where we can use `DISCARD` rules,
>this looks like the best approach, though I'm still curious about ARM.
>Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>-- 
>Thanks,
>~Nick Desaulniers
