Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A18F20DA21
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jun 2020 22:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgF2TyD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 15:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgF2Tx7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 15:53:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431DBC061755
        for <linux-efi@vger.kernel.org>; Mon, 29 Jun 2020 12:53:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 207so8159549pfu.3
        for <linux-efi@vger.kernel.org>; Mon, 29 Jun 2020 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKRhn9sIaFaGEW3xbHkfNQIj02f8YddLObFXUqnNhu8=;
        b=bRgfBWJhw3k6vEkg+gGrA7QdNS4rt+ffVIqjxb8+xRH5Hf8e5n3ITha/4r/HQQjG1F
         Mnp916bSSyiyNJ3mB4Pp24pG+NomV7NtlGrDIbs1/VO6qz2zh+2u4MyKygTW4DWOdEAW
         h0hJeQ7dnSzCQo+TA8azgjmFV+w1Q1r8AkAQ6kyp/vQDX2e8LTYa1tMbaefxqY2R+gNz
         opFp+Zy1OQeuKe8JMokYShmECU6iURq7DyQW5616Pz5i3j+aOZhMSWUTT6+QxBbnEYnE
         2WnYAveyeIeVpJcFa2nui3COjVCHDpZHxL9us5S2uMZdxLknVjYHLMAByD7JWc3QqKQU
         /rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKRhn9sIaFaGEW3xbHkfNQIj02f8YddLObFXUqnNhu8=;
        b=KDOgNikWk7P1cjUf3pV/hOUmk3F5snavrFYZo2zkrji2BRtaG2oKg1GBISX3Nl7TFI
         mlJAwbmm1q39OIvlJp/ZwcrhVIN+0Tp1vE4AaofTOY/+cyn1RiN6sU6i1hUaCRMagW80
         2KxpO6ZUfUfAkFtrm+kaT6fH2hRmrjik/p0BHrJ6e8CdqPqJfUi2diFJ+8OV7S/YQUEV
         6lugH3Cvc6LDf/q+GJUXUBtFHmMRwjbnNE+ko3nqRg6/De0kHBWCZ2yE1YTUHXQkyvIy
         5r2m4y13ViolTPC277/7LgHjimXTnw2y1U32sq2xmYTCDqvasCt5ijfWvVfrgzifxEzE
         gEWA==
X-Gm-Message-State: AOAM531icIa3bdWsQM7fhX2FzDYF483nBIvE7G65jzqne29C1TISHTFA
        CAaYeqHcMAVduBoeOYuUOtMCOkxEhG46lSQSZARMtQ==
X-Google-Smtp-Source: ABdhPJx1ZltZC8TxdLF0qs/W70OrjV+LgOyxShhZsT9U/M+Islb1fHf4YkGIw2+d4lhznk2dOuqEiVum9V3YVQvnVAQ=
X-Received: by 2002:a63:7e55:: with SMTP id o21mr11995677pgn.263.1593460438609;
 Mon, 29 Jun 2020 12:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200629061840.4065483-1-keescook@chromium.org> <20200629061840.4065483-9-keescook@chromium.org>
In-Reply-To: <20200629061840.4065483-9-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jun 2020 12:53:47 -0700
Message-ID: <CAKwvOd=r6bsBfSZxVYrnbm1Utq==ApWBDjx+0Fxsm90Aq3Jghw@mail.gmail.com>
Subject: Re: [PATCH v4 08/17] arm64/mm: Remove needless section quotes
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jun 28, 2020 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> Fix a case of needless quotes in __section(), which Clang doesn't like.
>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Yep, I remember bugs from this.  Probably should scan the kernel for
other instances of this.  +Joe for checkpatch.pl validation.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm64/mm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 1df25f26571d..dce024ea6084 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -42,7 +42,7 @@
>  u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
>  u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
>
> -u64 __section(".mmuoff.data.write") vabits_actual;
> +u64 __section(.mmuoff.data.write) vabits_actual;
>  EXPORT_SYMBOL(vabits_actual);
>
>  u64 kimage_voffset __ro_after_init;
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
