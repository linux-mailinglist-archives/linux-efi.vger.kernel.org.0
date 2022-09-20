Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC655BE96B
	for <lists+linux-efi@lfdr.de>; Tue, 20 Sep 2022 16:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiITO4L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Sep 2022 10:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiITO4L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Sep 2022 10:56:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF3F1EAC9;
        Tue, 20 Sep 2022 07:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9B8CB810CC;
        Tue, 20 Sep 2022 14:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822FAC433D6;
        Tue, 20 Sep 2022 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663685767;
        bh=BzVxD9i5pBcK0wbCxWreUuh42PWPt1DCFtMsohJWvQM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bj9W+4tBNFEVu9EHvgRIxSLHLlmR+nrDk4LYmeUmSFyfiP/O0zUXe/C4yM26SGIhS
         5DXNji/P6vdJfIrbOSjlZYneOA242iZI5xHbThE+N0DUBg1oSuTq1i0sBELmQ0M6qk
         irxW6L+9E/L89TWlQ7Eo6Ofp/Ldhvz+S28JjB9y1bOlaOoDv/33FnoN/2sJx1DvIOf
         BukQnHFqDpaRXYBF/KqTz8ACK2kBlibrxAy7P8+/gM+PXiSJTI/Jhk+DZuB3Pq5shg
         CODhp7i3s9QzRdwKgILTEIN0Y735NDKiRIfJ8lEHPnsW8Gtw146fkMA7O41ttC42h8
         0smg02T8FhTfw==
Received: by mail-lf1-f53.google.com with SMTP id u18so4213244lfo.8;
        Tue, 20 Sep 2022 07:56:07 -0700 (PDT)
X-Gm-Message-State: ACrzQf0SSvrZCdWbCD5xbcZoKHfEiWeZmMoEge+SSAjGPdZyzfjqx4vj
        w5eT0mFdchpTN0GE+dhuj6ncq+hBGz9vScWrbks=
X-Google-Smtp-Source: AMsMyM7uW15RAmMeLYJOrTt9HvnbIRFZmnKv2IyZ9AbzX0Dl1wRYg6g/HTPVgUq6bJNlQgSFPr30FIGX5Rc7McG9/w4=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr7948133lfb.583.1663685765550; Tue, 20
 Sep 2022 07:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220815134223.740112-1-ardb@kernel.org>
In-Reply-To: <20220815134223.740112-1-ardb@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 20 Sep 2022 16:55:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGbB9BdwKw5vf=+kEH2aF7jwDKvNJ+gAYk2+m1foYbn5w@mail.gmail.com>
Message-ID: <CAMj1kXGbB9BdwKw5vf=+kEH2aF7jwDKvNJ+gAYk2+m1foYbn5w@mail.gmail.com>
Subject: Re: [PATCH 0/6] x86: head_64.S spring cleaning
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 15 Aug 2022 at 15:42, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> After doing some cleanup work on the EFI code in head_64.S, the mixed
> mode code in particular, I noticed that the memory encryption pieces
> could use some attention as well, so I cleaned that up too.
>
> I have been sitting on these patches since November, waiting for the
> right time to post them, i.e., after the SEV/SNP review had finished.
> This has yet to happen, so I'm posting them now instead. Please feel
> free to disregard for the time being, and propose a suitable timeframe
> to repost them if this is likely to conflict with ongoing work.
>

Ping?

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Michael Roth <michael.roth@amd.com>
>
> Ard Biesheuvel (6):
>   x86/head_64: clean up mixed mode 32-bit entry code
>   efi/x86: simplify IDT/GDT preserve/restore
>   x86/compressed: move startup32_load_idt() out of startup code
>   x86/compressed: move startup32_check_sev_cbit out of startup code
>   x86/compressed: adhere to calling convention in
>     get_sev_encryption_bit()
>   x86/compressed: only build mem_encrypt.S if AMD_MEM_ENCRYPT=y
>
>  arch/x86/boot/compressed/Makefile       |   8 +-
>  arch/x86/boot/compressed/efi_mixed.S    | 352 ++++++++++++++++++++
>  arch/x86/boot/compressed/efi_thunk_64.S | 195 -----------
>  arch/x86/boot/compressed/head_32.S      |   4 -
>  arch/x86/boot/compressed/head_64.S      | 309 +----------------
>  arch/x86/boot/compressed/mem_encrypt.S  | 146 +++++++-
>  drivers/firmware/efi/libstub/x86-stub.c |   3 +-
>  7 files changed, 506 insertions(+), 511 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/efi_mixed.S
>  delete mode 100644 arch/x86/boot/compressed/efi_thunk_64.S
>
> --
> 2.35.1
>
