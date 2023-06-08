Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496E3727987
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jun 2023 10:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjFHIFP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jun 2023 04:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjFHIE7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Jun 2023 04:04:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1BE2121;
        Thu,  8 Jun 2023 01:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A37464A19;
        Thu,  8 Jun 2023 08:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76CBC433A0;
        Thu,  8 Jun 2023 08:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686211496;
        bh=YuQBDllZbwBwxvyPF9jL3eauRaVU0dHpdkr5oSW5Z9Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nLw2nED3lL8I5pUJK91Mc7/IpZ5Ibar5FTvqlQWu/3HChY4zKT24q/nnE7sdk+TsT
         1JXr6i8W5p4/YE7zZxD2cPYV5fVwirMDA51cH6f7XNmkVJ6J+uiMjNzj3sKxRcsOWU
         Slwjy/2wW4+Ufib1+ktqAmv3USeYHh7CkuTWUkfzqT/1wGNBQRvsJUWiR0nZxbwbxe
         wA13yxmlu7zzFDfqJ2yqaKpnatKsy3XZaxnpFN9hxzMQnjHsWX05r1lXhxF7RJ2nlw
         5+hkwpHPUE8XJtgSpHHiHRABReWdr97n2u9WP+1IgKGAzYNxGImOdmPmiky960saEE
         nJwg5ct8Jig8w==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b1b92845e1so2498541fa.0;
        Thu, 08 Jun 2023 01:04:56 -0700 (PDT)
X-Gm-Message-State: AC+VfDw9EvfrCHk1r0RbPJYM7vAb5DsLqhJ1JD4SYgswjrUjKZC4fqEe
        ATFWjZl5mdjvvsBuZo7wwzlDQGhjqE84pcK9Pmw=
X-Google-Smtp-Source: ACHHUZ4/y6yN8sgLDcCZ7MJCHzAnKo7YbTaSIrt/vTUD9HIKnvHfdwDdlWwUSLt0rtvH3gd/ZvGJ3F80FIB7Xqkn4EA=
X-Received: by 2002:a2e:9f44:0:b0:2b1:d6bf:d8b2 with SMTP id
 v4-20020a2e9f44000000b002b1d6bfd8b2mr3879003ljk.22.1686211494926; Thu, 08 Jun
 2023 01:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230607072342.4054036-1-ardb@kernel.org> <20230607072342.4054036-11-ardb@kernel.org>
 <20230607180920.GA3110@yjiang5-mobl.amr.corp.intel.com>
In-Reply-To: <20230607180920.GA3110@yjiang5-mobl.amr.corp.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 8 Jun 2023 10:04:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHZx5Qb-XCxNsTV1jh7CSj6aEg8xEhPU6yvFbhYqhzcEA@mail.gmail.com>
Message-ID: <CAMj1kXHZx5Qb-XCxNsTV1jh7CSj6aEg8xEhPU6yvFbhYqhzcEA@mail.gmail.com>
Subject: Re: [PATCH v5 10/20] x86/decompressor: Call trampoline directly from
 C code
To:     Yunhong Jiang <yunhong.jiang@linux.intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 7 Jun 2023 at 20:09, Yunhong Jiang
<yunhong.jiang@linux.intel.com> wrote:
>
> On Wed, Jun 07, 2023 at 09:23:32AM +0200, Ard Biesheuvel wrote:
> > Instead of returning to the asm calling code to invoke the trampoline,
> > call it straight from the C code that sets the scene. That way, the
> > struct return type is no longer needed for returning two values, and the
> > call can be made conditional more cleanly in a subsequent patch.
> >
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/head_64.S    | 20 +++-----------
> >  arch/x86/boot/compressed/pgtable_64.c | 28 ++++++++------------
> >  2 files changed, 15 insertions(+), 33 deletions(-)
> >
...
> > diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> > index d66639c961b8eeda..1d28ad95ea839531 100644
> > --- a/arch/x86/boot/compressed/pgtable_64.c
> > +++ b/arch/x86/boot/compressed/pgtable_64.c
> > @@ -16,11 +16,6 @@ unsigned int __section(".data") pgdir_shift = 39;
> >  unsigned int __section(".data") ptrs_per_p4d = 1;
> >  #endif
> >
> > -struct paging_config {
> > -     unsigned long trampoline_start;
> > -     unsigned long l5_required;
> > -};
> > -
> >  /* Buffer to preserve trampoline memory */
> >  static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
> >
> > @@ -106,10 +101,10 @@ static unsigned long find_trampoline_placement(void)
> >       return bios_start - TRAMPOLINE_32BIT_SIZE;
> >  }
> >
> > -struct paging_config paging_prepare(void *rmode)
> > +asmlinkage void set_paging_levels(void *rmode)
>
> Can you please change the refer to paging_prepare() in the comments above also?

You mean the below, right?

--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -24,7 +24,7 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
  * purposes.
  *
  * Avoid putting the pointer into .bss as it will be cleared between
- * paging_prepare() and extract_kernel().
+ * set_paging_levels() and extract_kernel().
  */
 unsigned long *trampoline_32bit __section(".data");
