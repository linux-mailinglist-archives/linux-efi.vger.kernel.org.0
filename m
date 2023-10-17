Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC31C7CBBCC
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 08:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjJQG6I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 02:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQG6I (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 02:58:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15DBAB
        for <linux-efi@vger.kernel.org>; Mon, 16 Oct 2023 23:58:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA43C433C9
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 06:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697525886;
        bh=3SJopweuQfpyTdr7dyblR/VFCDsgkmdlmGJFlp9JqJc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nBqo8xy1XhEApuNCpVw4Ao+pBQrbN3T4FPE2+HC48YuHhgUw7ifd0oaYsOJbfeIDi
         5pUedztQRfl3uV7wRLXujp7imCWVIbw+ZAUXNaivL+Wg11IOmxZ06+Wd7WfTelDUe1
         AubA0HNIWuqu4tsVguAr3VQV59NaUQVDrA+bJ//8bQsxt7ogqBUCYtLUrpIyz0ECqG
         wCXZpbf59fCHLsWPQKBmL6KuN3VcT/le+lhpFKudMCqAJwUwn/kDqhuNKjDZ/F7bPv
         TSZn18ngvZLpdYhOxim35zc/hmfFRk+YCzmnaZXcF6EBRWfnL6E3wJtw3VzQkM5IrG
         nNI1OWsfNObdg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so51983431fa.0
        for <linux-efi@vger.kernel.org>; Mon, 16 Oct 2023 23:58:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YxAXC8PdxBt1x7W1hNZF3SJ2JK6XmLZsgtID5V1FSrv0OXrvhw2
        N4djPXUt0guGxHycmIbdA/WfSzylXDGNSfBNdiw=
X-Google-Smtp-Source: AGHT+IFwpmlrwp5m9VmNgAF0l2Iqd/FczasG16eb3B8HRJqN+ZZn8aA64yeljoLScdVvMfU47FDsnvjmpWNFuvqV05Q=
X-Received: by 2002:a2e:874b:0:b0:2bb:78ad:56cb with SMTP id
 q11-20020a2e874b000000b002bb78ad56cbmr830942ljj.37.1697525884598; Mon, 16 Oct
 2023 23:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231016164634.3514517-2-ardb@google.com>
In-Reply-To: <20231016164634.3514517-2-ardb@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 17 Oct 2023 08:57:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFootPaQJTYTFoRWido1Fn_trmT2u42hdPOjP+=8D0H_g@mail.gmail.com>
Message-ID: <CAMj1kXFootPaQJTYTFoRWido1Fn_trmT2u42hdPOjP+=8D0H_g@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: efistub: Assign global boot_params variable
To:     Ard Biesheuvel <ardb@google.com>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 16 Oct 2023 at 18:46, Ard Biesheuvel <ardb@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Now that the x86 EFI stub calls into some APIs exposed by the
> decompressor (e.g., kaslr_get_random_long()), it is necessary to ensure
> that the global boot_params variable is set correctly before doing so.
>
> Note that the decompressor and the kernel proper carry conflicting
> declarations for the global variable 'boot_params' so refer to it via an
> alias to work around this.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 3bfc59637dd1..51407207ded5 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -812,12 +812,15 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
>                                efi_system_table_t *sys_table_arg,
>                                struct boot_params *boot_params)
>  {
> +       extern struct boot_params *bpp asm("boot_params");

I am getting hatemail from the bots about this extern declaration, so
I will move that into x86-stub.h.

Unless anyone minds, I'll queue this up and send it to Linus myself
via the EFI fixes branch.


>         efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
>         struct setup_header *hdr = &boot_params->hdr;
>         const struct linux_efi_initrd *initrd = NULL;
>         unsigned long kernel_entry;
>         efi_status_t status;
>
> +       bpp = boot_params;
> +
>         efi_system_table = sys_table_arg;
>         /* Check if we were booted by the EFI firmware */
>         if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
> --
> 2.42.0.655.g421f12c284-goog
>
