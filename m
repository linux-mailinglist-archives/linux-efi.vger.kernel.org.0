Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED90C1C9A80
	for <lists+linux-efi@lfdr.de>; Thu,  7 May 2020 21:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGTII (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 May 2020 15:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGTIH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 May 2020 15:08:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765BEC05BD43
        for <linux-efi@vger.kernel.org>; Thu,  7 May 2020 12:08:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so2450111plt.5
        for <linux-efi@vger.kernel.org>; Thu, 07 May 2020 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPfLy6zhX+Hjt5T8iZD4lv7tfdBWzHLW638s7QodkWI=;
        b=BmMdI3YvSlhmgsYU6OV3eLKVWcNbbYKo9+rC4ymylw+qqvCnuEYnFoq1JB0G9W0epV
         cqQxLRAm+5QGl7GWtTdUxCvXMRCThAXuz4NHoa89WhOTxfc5FJLsglL0dGgyFxKXPAe3
         UMBMuwQOXDQWcIoNi370t+fPOtB4kjf3WTXknm1SOlmAEsKuVh1Gk/EkrwdWpVf/Souu
         CYPQ+2ATPATEKbmTYRSK09cIR9vRn2pTClmuppzoy0QIG/p/ytcprhyf6peTJot7XWkF
         A7qiIXJVhqaFDqOb0Yc5k56kH/qDeyN7vU0QH53gaQHkpdKBWQhd1pghOpFu39kSwJSm
         rdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPfLy6zhX+Hjt5T8iZD4lv7tfdBWzHLW638s7QodkWI=;
        b=e2oDSULt1JUNd64dE+eWThYULM8vJlJFN4GnhmTa/yfaMktgN2nxR00DxlUV+/nJqI
         HxVrwggjzRZIh1o4xBNscCBKDr77tgGdCaeoK/f2Ibam2feSM6u+1EGw2OrmcOwtf4ao
         5zXIe3gsA7tASA+9lTvPPNkWWfwqyjtogeKr/C0KFzjOHe1XvU9rNvx8F3qjmSOphEqm
         zBE9MS5rP3p408xiSN2kQVIy0FpjSMIKwqwmpALCC69mKMHAvFdBMV5nx8HfO6E0tou+
         Ur9ogYrbDY/2UByKb2cSoiWBYtpumSF+bWDWFT9cJYk9EmrBx+yQ4GOi0rJhm8HZYzuJ
         h3bQ==
X-Gm-Message-State: AGi0PuYLx6uGNZhKi1i9WqYQPqG04cGeEjM6k3eP2/1vKPoQRhuqnORi
        RM36JNEC/iJzWgqO7UuXkecJhq08p6pt1LW2/3eXMQ==
X-Google-Smtp-Source: APiQypKZU9EIkb+4leK/LEBbL8XLyxV1L0abX2tphsveIj+TkgEnYwPICwR+p8dJj8VHiE9case19uo8OSVq3oGggQc=
X-Received: by 2002:a17:90a:6d03:: with SMTP id z3mr1731941pjj.32.1588878486596;
 Thu, 07 May 2020 12:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200505073054.22437-1-ardb@kernel.org>
In-Reply-To: <20200505073054.22437-1-ardb@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 May 2020 12:07:55 -0700
Message-ID: <CAKwvOdku_Yq29bThRw9FSNb2QKTr1PuAw_og4ag3MApPujkxOw@mail.gmail.com>
Subject: Re: [PATCH v2] efi/libstub/x86: Work around LLVM ELF quirk build regression
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 5, 2020 at 12:31 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> When building the x86 EFI stub with Clang, the libstub Makefile rules
> that manipulate the ELF object files may throw an error like:
>
>     STUBCPY drivers/firmware/efi/libstub/efi-stub-helper.stub.o
>   strip: drivers/firmware/efi/libstub/efi-stub-helper.stub.o: Failed to find link section for section 10
>   objcopy: drivers/firmware/efi/libstub/efi-stub-helper.stub.o: Failed to find link section for section 10
>
> This is the result of a LLVM feature [0] where symbol references are
> stored in a LLVM specific .llvm_addrsig section in a non-transparent way,
> causing generic ELF tools such as strip or objcopy to choke on them.
>
> So force the compiler not to emit these sections, by passing the
> appropriate command line option.
>
> [0] https://sourceware.org/bugzilla/show_bug.cgi?id=23817
>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I wonder if it's more appropriate to enable this globally for the
kernel, or why we don't see the failure for other object files outside
of libstub?  We might need to revisit that if we see such failures
again, but this patch LGTM. Thanks Ard.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/firmware/efi/libstub/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 8d246b51bd49..e5a49dc8e9bc 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -30,6 +30,7 @@ KBUILD_CFLAGS                 := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>                                    -D__NO_FORTIFY \
>                                    $(call cc-option,-ffreestanding) \
>                                    $(call cc-option,-fno-stack-protector) \
> +                                  $(call cc-option,-fno-addrsig) \
>                                    -D__DISABLE_EXPORTS
>
>  GCOV_PROFILE                   := n
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
