Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E58020BA0D
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 22:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgFZUNU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Jun 2020 16:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFZUNU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Jun 2020 16:13:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D369C03E97E
        for <linux-efi@vger.kernel.org>; Fri, 26 Jun 2020 13:13:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f2so4647845plr.8
        for <linux-efi@vger.kernel.org>; Fri, 26 Jun 2020 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Az9RFFYtn5C7TmV4P2ySXpJMS+ldXmIwmwoLtzgDuS8=;
        b=kaoCNqPS1QsSCdQvqaSVaEOAXbalmo1arka1el0o4zpvk3N0TP8c2fV2jYdsRreLMw
         yDtrumERCVizvepxpfw0Om38FWisWAy7daOjrh8Lu/hU7IK5N8OAn4TVfHcuv2OMpEg9
         Jcmvj2f2b1QJUPjV3veR2dZlYeqosz3ojrmq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Az9RFFYtn5C7TmV4P2ySXpJMS+ldXmIwmwoLtzgDuS8=;
        b=tOIq0ov8MpTXCMH/oamyebKTa8jy6T1FmNPnzDUv6wLo+5jnUReGQSOWOqkw+Vdbey
         0gXVeNFqQuCzqjhJnvQwvMiUfWifryx/zJqXQKhOYXRrhWEgaF1V9zZO4mJI4JB+C0Sp
         rMqPIqYdODVkaJjGMB1aWZcq7/IKhPUU3i94jAPmx+cW7zc3qQP+g/YxcKghQ5ZRIUul
         kPzSHXEIHUCCG2Bg5XYcNY14Wi2qsN99Yg1fCmwUNctvAdAt18eub7A3WVGnhFYlBpPx
         dRYfb/fi+RPkS65us5MJ9cpoPbO7BPgBo+3NjPwwdfsOGWno6QLdqRlEMjlJ7fsEDTNb
         4uhg==
X-Gm-Message-State: AOAM532/ii2cKnhZchz4faW4o5isHLo6m87WbTDUtJ8j44uOmM/xYneC
        uWfrpxY5Kq2jrKA+ZLpyfoAoBg==
X-Google-Smtp-Source: ABdhPJyboLRCHhlEE16WjSu4BWalicgOTCnBMXYn0MvwG2mprXGsrY/REL8KRMtW3BQoaNUGnfaC+g==
X-Received: by 2002:a17:90a:aa88:: with SMTP id l8mr5328566pjq.145.1593202400000;
        Fri, 26 Jun 2020 13:13:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y187sm26950121pfb.46.2020.06.26.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:13:19 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:13:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kbuild: remove cc-option test of -fno-stack-protector
Message-ID: <202006261312.560B045E@keescook>
References: <20200626185913.92890-1-masahiroy@kernel.org>
 <CAKwvOdnK4KZaE=D40UyKHN-nB1Y-oXXJUcVv08cGJNsExOs-Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnK4KZaE=D40UyKHN-nB1Y-oXXJUcVv08cGJNsExOs-Pw@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 26, 2020 at 12:09:37PM -0700, Nick Desaulniers wrote:
> On Fri, Jun 26, 2020 at 12:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >  CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
> > -       $(call cc-option, -fno-stack-protector,) \
> > -       $(call cc-option, -fno-stack-protector-all,)
> > +       -fno-stack-protector $(call cc-option, -fno-stack-protector-all)
> 
> Just curious, looks like we could do the same for
> `-fno-stack-protector-all`, here or tree-wide, right?  Wait, what
> compiler recognizes -fno-stack-protector-all?
> https://godbolt.org/z/QFQKE_

That is from ancient times, IIRC. -fno-stack-protector should be
sufficient.

-- 
Kees Cook
