Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F0320BA49
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 22:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgFZUZk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Jun 2020 16:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgFZUZk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Jun 2020 16:25:40 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27805C03E97B
        for <linux-efi@vger.kernel.org>; Fri, 26 Jun 2020 13:25:40 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 35so4676011ple.0
        for <linux-efi@vger.kernel.org>; Fri, 26 Jun 2020 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lj8Vexb+6K2EkvRLDIIMa04+QiE5YATPbQS9XSZnShM=;
        b=BtJtUAQP1Xeozg2+9z9AlinIWiJ+0lAh++hWmxBVJxh8hwQh9WjK/7JIYmr5qANx8+
         rObqJyzwtVq3+g4FtTBx2OrKqyZPtMpOpfZuGDD8hFjrhT+zs9i3EoZuKsMlc5WpXcLo
         RyNOyqqeE9dKOo/lSlpY6LbgmNvhelDsGFg14Pg/Wz+urEHSpf/69j6TPIHWL8eN24BX
         9pZOzOQGySgZfoYCljqlnssJhYlYZoxFcQsIANIlFuIgerryKcEt0H9LKLdqXsxUtfkU
         q+KeTMaCLhaRiVSysD2ZM5rCRxFidoDg/lOsbGd5wquzb+2yAZcuj0i6JUGBVB9EtP+Z
         evHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lj8Vexb+6K2EkvRLDIIMa04+QiE5YATPbQS9XSZnShM=;
        b=nqxunpY46nFEKKHW26hfov8GBDtRrZNk0pPxh++wa0k0hUi/1Qn0PFZ6wnBG+GGbHl
         RlY6Oh48pcuMuMdN8R2TkqE50j6oiGLn/sp5WBbkGy9HgQBMsGHRjpnK05yHQByrhrK9
         SyLM8kay90/mAPkZs1wa8pcCrspUfUrugBhms5R5QpGtREWQYw1rCBTA9VjoHbMXmT6z
         ssot50+/KEDw3Q0ihLk3GR1kiQsNLi9Bp0rKrXIFz6UJ20SPrOhAbj46nsjs8dcVqwLm
         jrS3hCgZOfqE9Ao1gQ7LmjH43dqvigZfFI7NKk6uiS/5NvYx9vXY8194ykfpJcjDfmkV
         KUZg==
X-Gm-Message-State: AOAM530xsSH7GogNtEE5ylMEjtb3kAPGmMe1VziogZE0ASFBFrnVG8D1
        CUCd5D47z0NxESOfhM4qG7JEOg6LUNBGfbKK+oDE3Rb4
X-Google-Smtp-Source: ABdhPJzi2CjOFoRaJFc6nIMQidEczrCchKjb4mW48OJK5lS21+wU2sDMo1f9Dcd7/SOBVPm9EP1XSN0nK3bjmIdsPg4=
X-Received: by 2002:a17:90a:30ea:: with SMTP id h97mr5337521pjb.32.1593203139352;
 Fri, 26 Jun 2020 13:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200626185913.92890-1-masahiroy@kernel.org> <CAKwvOd=V_M43CP7G87K3TqSsxua2NcXPz6BnDt-z6167O2WAzQ@mail.gmail.com>
 <202006261319.F130204@keescook>
In-Reply-To: <202006261319.F130204@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 26 Jun 2020 13:25:27 -0700
Message-ID: <CAKwvOdmFpgSGow3X4AhEC1B-xWNORTgAFBXgYPQHLGyhgefddw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: remove cc-option test of -fno-stack-protector
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 26, 2020 at 1:21 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 01:13:20PM -0700, Nick Desaulniers wrote:
> > On Fri, Jun 26, 2020 at 12:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > +++ b/Makefile
> > > @@ -762,7 +762,7 @@ ifneq ($(CONFIG_FRAME_WARN),0)
> > >  KBUILD_CFLAGS += -Wframe-larger-than=$(CONFIG_FRAME_WARN)
> > >  endif
> > >
> > > -stackp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
> > > +stackp-flags-y                                    := -fno-stack-protector
> > >  stackp-flags-$(CONFIG_STACKPROTECTOR)             := -fstack-protector
> > >  stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
> >
> > So it looks like the previous behavior always added
> > `-fno-stack-protector` (since CONFIG_CC_HAS_STACKPROTECTOR_NONE was
> > always true), but then we append either `-fstack-protector` or
> > `-fstack-protector-strong` based on configs.  While that's ok, and you
> > patch doesn't change that behavior, and it's good to be explicit to
> > set the stack protector or not...it seems weird to have
> > `-fno-stack-protector -fstack-protector` in the command line flags.  I
> > would prefer if we checked for not having CONFIG_STACKPROTECTOR or
> > CONFIG_STACKPROTECTOR_STRONG before adding `-fno-stack-protector`.
> > That doesn't have to be done in this patch, per se.
>
> No, it would add only what was latest and most selected. (They're all
> ":=" assignments.) If CONFIG_STACKPROTECTOR_STRONG, only
> -fstack-protector-strong is set. If only CONFIG_STACKPROTECTOR, only
> -fstack-protector is set. Otherwise -fno-stack-protector.

Ah, right. Thanks for pointing that out.  I'm still curious if the
CFLAGS_<file>.o rules get appended or overwrite all flags for that
translation unit?
-- 
Thanks,
~Nick Desaulniers
