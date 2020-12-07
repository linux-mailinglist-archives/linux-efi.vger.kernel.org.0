Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27802D1837
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 19:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgLGSJD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Dec 2020 13:09:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43666 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGSJD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Dec 2020 13:09:03 -0500
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1kmKvs-0002la-L6
        for linux-efi@vger.kernel.org; Mon, 07 Dec 2020 18:08:20 +0000
Received: by mail-wm1-f70.google.com with SMTP id r5so38464wma.2
        for <linux-efi@vger.kernel.org>; Mon, 07 Dec 2020 10:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lg/Uu0kbCMDFbnF6jaZ9tjEn9XGS7/YowaMlc8psiPU=;
        b=O0Zb2rbq6SYomli7cETugiyALOEyemlgVqJUI+yc2vzbMohC233bUyTdnN/hE9WUqc
         B16BoT5TpI1uqziBfLTdRY+WO8P4tsn3K78U97oIckqamxYRTcA/oqvRrZCaUAGpraAC
         4PyIeO5K8RWJ4ZYo0udNyeNte9VDPkOe97SCxNW16sUHcqhF6q1omlzOe+czcWGUXMGz
         khA3bmmPFRyA7x8LfVVb5DhYV8K8c4uTotsJRUE/ZLHEzyjsYweI7o4U7/C55wj27kbp
         y72DN1Yq+vE0mfmNqnpoX8nERwKff1AMw0pSkkpSBXt/PWhL1TkVXOsOMXAxpfHJBLV2
         fQ5A==
X-Gm-Message-State: AOAM530N831x8Ua/l9Dy+2PCv+uSHt43yDwqhXYNAbWz0nOHCCoET0za
        6/R5LVXlzkfJ3yfzssLeVtsdBzsD9h3n26AkL9iX+xAZ28/0x+oYBkj/7DMUkPva4RToF5aeH5Y
        VJ8KDZyAjATz/DK1pi4F+pMFSPUO608h4PuItHA6T/Bdc6rLa9W6DGg==
X-Received: by 2002:adf:c7c4:: with SMTP id y4mr21026125wrg.344.1607364499770;
        Mon, 07 Dec 2020 10:08:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkYY5+9pTrlJDMm9CFbBBOxcw1Fb6oiIRwudZ51dYHOspQPcRSCBIx4qcZ8ryFopnrDyZHB3CDyJO4qCxhPQ8=
X-Received: by 2002:adf:c7c4:: with SMTP id y4mr21026089wrg.344.1607364499317;
 Mon, 07 Dec 2020 10:08:19 -0800 (PST)
MIME-Version: 1.0
References: <X8yoWHNzfl7vHVRA@kroah.com> <20201207172625.2888810-1-dann.frazier@canonical.com>
 <CAMj1kXHdqaso9Vkm3KeKFntMBQeRTkY-fU1GW8K8rcxBbQbKBA@mail.gmail.com>
In-Reply-To: <CAMj1kXHdqaso9Vkm3KeKFntMBQeRTkY-fU1GW8K8rcxBbQbKBA@mail.gmail.com>
From:   dann frazier <dann.frazier@canonical.com>
Date:   Mon, 7 Dec 2020 11:08:08 -0700
Message-ID: <CALdTtnv6VCBjvS-rtUTdhmLHkiJJrY+m4CLW4F8F89NEpZYF7A@mail.gmail.com>
Subject: Re: [PATCH 4.4] Revert "crypto: arm64/sha - avoid non-standard inline
 asm tricks"
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>,
        Michael Schaller <misch@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 7, 2020 at 10:50 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 7 Dec 2020 at 18:26, dann frazier <dann.frazier@canonical.com> wrote:
> >
> > This reverts commit c042dd600f4e89b6e7bdffa00aea4d1d3c1e9686.
> >
> > This caused the build to emit ADR_PREL_PG_HI21 relocations in the sha{1,2}_ce
> > modules. This relocation type is not supported by the linux-4.4.y kernel
> > module loader when CONFIG_ARM64_ERRATUM_843419=y, which we have enabled, so
> > these modules now fail to load:
> >
> >   [   37.866250] module sha1_ce: unsupported RELA relocation: 275
> >
> > This issue does not exist with the backport to 4.9+. Bisection shows that
> > this is due to those kernels also having a backport of
> > commit 41c066f ("arm64: assembler: make adr_l work in modules under KASLR")
>
> Hi Dann,
>
> Would it be an option to backport 41c066f as well?

Hi Ard,

That was attempted before, but caused a build failure which would
still happen today:
  https://www.spinics.net/lists/stable/msg179709.html
Specifically, head.S still has a 3 argument usage of adr_l. I'm not
sure how to safely fix that up myself.

  -dann

> >
> > Signed-off-by: dann frazier <dann.frazier@canonical.com>
> > ---
> >  arch/arm64/crypto/sha1-ce-core.S |  6 ++----
> >  arch/arm64/crypto/sha1-ce-glue.c | 11 ++++++++---
> >  arch/arm64/crypto/sha2-ce-core.S |  6 ++----
> >  arch/arm64/crypto/sha2-ce-glue.c | 13 ++++++++-----
> >  4 files changed, 20 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arm64/crypto/sha1-ce-core.S b/arch/arm64/crypto/sha1-ce-core.S
> > index 8550408735a0..c98e7e849f06 100644
> > --- a/arch/arm64/crypto/sha1-ce-core.S
> > +++ b/arch/arm64/crypto/sha1-ce-core.S
> > @@ -82,8 +82,7 @@ ENTRY(sha1_ce_transform)
> >         ldr             dgb, [x0, #16]
> >
> >         /* load sha1_ce_state::finalize */
> > -       ldr_l           w4, sha1_ce_offsetof_finalize, x4
> > -       ldr             w4, [x0, x4]
> > +       ldr             w4, [x0, #:lo12:sha1_ce_offsetof_finalize]
> >
> >         /* load input */
> >  0:     ld1             {v8.4s-v11.4s}, [x1], #64
> > @@ -133,8 +132,7 @@ CPU_LE(     rev32           v11.16b, v11.16b        )
> >          * the padding is handled by the C code in that case.
> >          */
> >         cbz             x4, 3f
> > -       ldr_l           w4, sha1_ce_offsetof_count, x4
> > -       ldr             x4, [x0, x4]
> > +       ldr             x4, [x0, #:lo12:sha1_ce_offsetof_count]
> >         movi            v9.2d, #0
> >         mov             x8, #0x80000000
> >         movi            v10.2d, #0
> > diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
> > index 1b7b4684c35b..01e48b8970b1 100644
> > --- a/arch/arm64/crypto/sha1-ce-glue.c
> > +++ b/arch/arm64/crypto/sha1-ce-glue.c
> > @@ -17,6 +17,9 @@
> >  #include <linux/crypto.h>
> >  #include <linux/module.h>
> >
> > +#define ASM_EXPORT(sym, val) \
> > +       asm(".globl " #sym "; .set " #sym ", %0" :: "I"(val));
> > +
> >  MODULE_DESCRIPTION("SHA1 secure hash using ARMv8 Crypto Extensions");
> >  MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
> >  MODULE_LICENSE("GPL v2");
> > @@ -29,9 +32,6 @@ struct sha1_ce_state {
> >  asmlinkage void sha1_ce_transform(struct sha1_ce_state *sst, u8 const *src,
> >                                   int blocks);
> >
> > -const u32 sha1_ce_offsetof_count = offsetof(struct sha1_ce_state, sst.count);
> > -const u32 sha1_ce_offsetof_finalize = offsetof(struct sha1_ce_state, finalize);
> > -
> >  static int sha1_ce_update(struct shash_desc *desc, const u8 *data,
> >                           unsigned int len)
> >  {
> > @@ -52,6 +52,11 @@ static int sha1_ce_finup(struct shash_desc *desc, const u8 *data,
> >         struct sha1_ce_state *sctx = shash_desc_ctx(desc);
> >         bool finalize = !sctx->sst.count && !(len % SHA1_BLOCK_SIZE) && len;
> >
> > +       ASM_EXPORT(sha1_ce_offsetof_count,
> > +                  offsetof(struct sha1_ce_state, sst.count));
> > +       ASM_EXPORT(sha1_ce_offsetof_finalize,
> > +                  offsetof(struct sha1_ce_state, finalize));
> > +
> >         /*
> >          * Allow the asm code to perform the finalization if there is no
> >          * partial data and the input is a round multiple of the block size.
> > diff --git a/arch/arm64/crypto/sha2-ce-core.S b/arch/arm64/crypto/sha2-ce-core.S
> > index 679c6c002f4f..01cfee066837 100644
> > --- a/arch/arm64/crypto/sha2-ce-core.S
> > +++ b/arch/arm64/crypto/sha2-ce-core.S
> > @@ -88,8 +88,7 @@ ENTRY(sha2_ce_transform)
> >         ld1             {dgav.4s, dgbv.4s}, [x0]
> >
> >         /* load sha256_ce_state::finalize */
> > -       ldr_l           w4, sha256_ce_offsetof_finalize, x4
> > -       ldr             w4, [x0, x4]
> > +       ldr             w4, [x0, #:lo12:sha256_ce_offsetof_finalize]
> >
> >         /* load input */
> >  0:     ld1             {v16.4s-v19.4s}, [x1], #64
> > @@ -137,8 +136,7 @@ CPU_LE(     rev32           v19.16b, v19.16b        )
> >          * the padding is handled by the C code in that case.
> >          */
> >         cbz             x4, 3f
> > -       ldr_l           w4, sha256_ce_offsetof_count, x4
> > -       ldr             x4, [x0, x4]
> > +       ldr             x4, [x0, #:lo12:sha256_ce_offsetof_count]
> >         movi            v17.2d, #0
> >         mov             x8, #0x80000000
> >         movi            v18.2d, #0
> > diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
> > index 356ca9397a86..7a7f95b94869 100644
> > --- a/arch/arm64/crypto/sha2-ce-glue.c
> > +++ b/arch/arm64/crypto/sha2-ce-glue.c
> > @@ -17,6 +17,9 @@
> >  #include <linux/crypto.h>
> >  #include <linux/module.h>
> >
> > +#define ASM_EXPORT(sym, val) \
> > +       asm(".globl " #sym "; .set " #sym ", %0" :: "I"(val));
> > +
> >  MODULE_DESCRIPTION("SHA-224/SHA-256 secure hash using ARMv8 Crypto Extensions");
> >  MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
> >  MODULE_LICENSE("GPL v2");
> > @@ -29,11 +32,6 @@ struct sha256_ce_state {
> >  asmlinkage void sha2_ce_transform(struct sha256_ce_state *sst, u8 const *src,
> >                                   int blocks);
> >
> > -const u32 sha256_ce_offsetof_count = offsetof(struct sha256_ce_state,
> > -                                             sst.count);
> > -const u32 sha256_ce_offsetof_finalize = offsetof(struct sha256_ce_state,
> > -                                                finalize);
> > -
> >  static int sha256_ce_update(struct shash_desc *desc, const u8 *data,
> >                             unsigned int len)
> >  {
> > @@ -54,6 +52,11 @@ static int sha256_ce_finup(struct shash_desc *desc, const u8 *data,
> >         struct sha256_ce_state *sctx = shash_desc_ctx(desc);
> >         bool finalize = !sctx->sst.count && !(len % SHA256_BLOCK_SIZE) && len;
> >
> > +       ASM_EXPORT(sha256_ce_offsetof_count,
> > +                  offsetof(struct sha256_ce_state, sst.count));
> > +       ASM_EXPORT(sha256_ce_offsetof_finalize,
> > +                  offsetof(struct sha256_ce_state, finalize));
> > +
> >         /*
> >          * Allow the asm code to perform the finalization if there is no
> >          * partial data and the input is a round multiple of the block size.
> > --
> > 2.29.2
> >
