Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE0F20BA62
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 22:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgFZUhD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Jun 2020 16:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgFZUhC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Jun 2020 16:37:02 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37CEC03E97B
        for <linux-efi@vger.kernel.org>; Fri, 26 Jun 2020 13:37:02 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g17so4659520plq.12
        for <linux-efi@vger.kernel.org>; Fri, 26 Jun 2020 13:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nt/218p7v20WGusEjZTRWNofL1UTU7wXJpxnIwWbqck=;
        b=LasIkQVyh7YOVLhmmWjNknLdRMiIhvmSIsX6upZZEv19wZkBLTDXThFG+IoJtTQ1DK
         zcl6LQej91z8gS9IaBIyAs1OvHj/0GDMvNCjRsmmphnLs25aUBJeB2/1LelcaqiXTaN0
         pdUtgwESOtklxyeVHayu+6UmjFTjibUVnEUdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nt/218p7v20WGusEjZTRWNofL1UTU7wXJpxnIwWbqck=;
        b=KBZ4Jx3GrFz3aHZdwhiQbO2o1Ojvg9mGXeV+EZaVAwx4MoJdGur7vT4FKGb5It42hg
         w4vOtewug+CTEg7+CAs/mEp4UjshpCjRu6Xywfa4NA8Bw7+pqF9Ks08cVhUpUIX5XzhD
         sC5FanNsZ9DD6bG3nlITDEPDWM1zMxuR6b3067bttuVinXAA9kfyCYclXNzZu52sECkd
         9Lmj9WAn4Y+Pvj9slPxbu7+Ixa1UJxNrzeKP0f0Wnv+dCcQJHagx7UVlKaXxHTBcp4Dh
         Lc8a3I+VpztcRIUgCxJjPH1jUujYKXCSLbN/HihoQ6KLDhCEchQEsyLi3vv0LOx7iIDc
         geiA==
X-Gm-Message-State: AOAM530/aefcAbKgguTG54VTBlsMFve9q49wbah8kOFayrbtwwNypODT
        dhk1VdwhXtj74k903Pyc+R/1d1B1lTE=
X-Google-Smtp-Source: ABdhPJzRjBzSEkMCU+0/yeMZIBtu9OcMQa8md9tY/FMmEyvlXIZhD94nhAwv0QyEtFY0fbb9xk24ng==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr3972740pll.338.1593203822398;
        Fri, 26 Jun 2020 13:37:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r8sm27166377pfq.16.2020.06.26.13.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:37:01 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:37:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kbuild: remove cc-option test of -fno-stack-protector
Message-ID: <202006261331.3A94DB7@keescook>
References: <20200626185913.92890-1-masahiroy@kernel.org>
 <CAKwvOd=V_M43CP7G87K3TqSsxua2NcXPz6BnDt-z6167O2WAzQ@mail.gmail.com>
 <202006261319.F130204@keescook>
 <CAKwvOdmFpgSGow3X4AhEC1B-xWNORTgAFBXgYPQHLGyhgefddw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmFpgSGow3X4AhEC1B-xWNORTgAFBXgYPQHLGyhgefddw@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 26, 2020 at 01:25:27PM -0700, Nick Desaulniers wrote:
> Ah, right. Thanks for pointing that out.  I'm still curious if the
> CFLAGS_<file>.o rules get appended or overwrite all flags for that
> translation unit?

CFLAGS_file.o gets appended to the CFLAGS. For example, after my updated
patch[1], the command line for syscall_64.o looks like this:

gcc -Wp,-MMD,arch/x86/entry/.syscall_64.o.d  -nostdinc -isystem \
...
-Wframe-larger-than=2048 -fstack-protector-strong \
...
-fno-stack-protector -Wno-override-init \
-DKBUILD_MODFILE='"arch/x86/entry/syscall_64"' \
-DKBUILD_BASENAME='"syscall_64"' \
-DKBUILD_MODNAME='"syscall_64"' \
-c -o arch/x86/entry/syscall_64.o \
arch/x86/entry/syscall_64.c

-Kees

[1] https://lore.kernel.org/lkml/202006261333.585319CA6B@keescook/

-- 
Kees Cook
