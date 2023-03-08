Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9801F6B02FA
	for <lists+linux-efi@lfdr.de>; Wed,  8 Mar 2023 10:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCHJeT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Mar 2023 04:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCHJeR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Mar 2023 04:34:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281513B85C;
        Wed,  8 Mar 2023 01:34:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBB7661723;
        Wed,  8 Mar 2023 09:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28865C4339C;
        Wed,  8 Mar 2023 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678268055;
        bh=1KV96xkQ/3t6nnAo2Wh01Ryockokv9RTDCDMFXLIeRU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H13BECuQJacRifJdk2avdkBpVnO/OLgoyPwyDkBpLEeUlpsahHbSiWGX85fLUqTS9
         al9rC2Nv7Ni/ZuNc+OFNea0hzQbdX7UkxGvGVYLe11npXVeqcMDr5RsxPk7RMYILQI
         SYGnzX/4XOqyYhFz3/uNJAxExyrzyg0OMyjXcEwI8ABbLwQngwVJT4Vv6qMCAmNdqG
         GqM0zuUbNf1uWbzvQiV76Erp/nqd9+UmxoM0WdI7iZTCbZaU+kXZLlnXyl6Njtoq46
         usPJ7ZhZqSmRfYITFN86PSaaMwOpD6mSAn7LHlmOuvvBs2zBlGsxjyRqrKVj1zHMVf
         D7D8pzJbqvRYg==
Received: by mail-lf1-f46.google.com with SMTP id f18so20528720lfa.3;
        Wed, 08 Mar 2023 01:34:15 -0800 (PST)
X-Gm-Message-State: AO0yUKVo/EpWMIe04tQH/usCcKHRWeLR+xhhnsrYSxKGfj6gIGRN7J9o
        SDquJQ63RzM830V8ilx4afBVRcnYTro9TkH6dnk=
X-Google-Smtp-Source: AK7set9TzylTWEMKly0Kp7ZgtVCa95OLKC2rbX2Wxw0cFgbNnwoICiYHoMHuzY1g9c6tiGbG4J1UtG/F+ut2nI7iwpU=
X-Received: by 2002:ac2:43d0:0:b0:4db:f0a:d574 with SMTP id
 u16-20020ac243d0000000b004db0f0ad574mr5237905lfl.7.1678268053173; Wed, 08 Mar
 2023 01:34:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671098103.git.baskov@ispras.ru> <3ca525852ce14a8e04949ff115cb6ec28c8f120b.1671098103.git.baskov@ispras.ru>
In-Reply-To: <3ca525852ce14a8e04949ff115cb6ec28c8f120b.1671098103.git.baskov@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 8 Mar 2023 10:34:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEMk1mLiwUuUTH4V1ro93MmBnwPnPMzJfSG+eH5ts8j3g@mail.gmail.com>
Message-ID: <CAMj1kXEMk1mLiwUuUTH4V1ro93MmBnwPnPMzJfSG+eH5ts8j3g@mail.gmail.com>
Subject: Re: [PATCH v4 07/26] x86/build: Check W^X of vmlinux during build
To:     Evgeniy Baskov <baskov@ispras.ru>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 15 Dec 2022 at 13:38, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> Check if there are simultaneously writable and executable
> program segments in vmlinux ELF image and fail build if there are any.
>
> This would prevent accidental introduction of RWX segments.
>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Peter Jones <pjones@redhat.com>
> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> ---
>  arch/x86/boot/compressed/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 1acff356d97a..4dcab38f5a38 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -112,11 +112,17 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
>  vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>
> +quiet_cmd_wx_check = WXCHK   $<
> +cmd_wx_check = if $(OBJDUMP) -p $< | grep "flags .wx" > /dev/null; \
> +              then (echo >&2 "$<: Simultaneously writable and executable sections are prohibited"; \
> +                    /bin/false); fi
> +
>  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>         $(call if_changed,ld)
>
>  OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
>  $(obj)/vmlinux.bin: vmlinux FORCE
> +       $(call cmd,wx_check)

This breaks the way we track dependencies between make targets: the
FORCE will result in the check being performed every time, even if
nothing gets rebuilt.

Better to do something like the below (apologies for the alphabet soup)


--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -112,18 +112,17 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
 vmlinux-objs-$(CONFIG_EFI_STUB) +=
$(objtree)/drivers/firmware/efi/libstub/lib.a

-quiet_cmd_wx_check = WXCHK   $<
-cmd_wx_check = if $(OBJDUMP) -p $< | grep "flags .wx" > /dev/null; \
-              then (echo >&2 "$<: Simultaneously writable and
executable sections are prohibited"; \
-                    /bin/false); fi
+quiet_cmd_objcopy_and_wx_check = $(quiet_cmd_objcopy)
+      cmd_objcopy_and_wx_check = if $(OBJDUMP) -p $< | grep "flags
.wx" > /dev/null; then \
+                                       (echo >&2 "$<: Simultaneously
writable and executable sections are prohibited"; \
+                                       /bin/false); else $(cmd_objcopy); fi

 $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
        $(call if_changed,ld)

 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
 $(obj)/vmlinux.bin: vmlinux FORCE
-       $(call cmd,wx_check)
-       $(call if_changed,objcopy)
+       $(call if_changed,objcopy_and_wx_check)
