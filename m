Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B420BA24
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 22:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgFZUS7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Jun 2020 16:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZUS6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Jun 2020 16:18:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4472C03E97A
        for <linux-efi@vger.kernel.org>; Fri, 26 Jun 2020 13:18:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so5420280pgq.1
        for <linux-efi@vger.kernel.org>; Fri, 26 Jun 2020 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SjdKzeH7GW9tQGsunBGfIcgoB4TuWBhVIwFN+ncvBXE=;
        b=Tm6uhy3i8keuHafctoH4MuP4dZ5blfAOikPg1Mlf5CHLIkopdkpyAFZI/u9bZwoURX
         X8shbqeQOPfH5Iyo1VLp9cMkDG+LeyHP3Oql7Nx4R5FFtRn/PB796zbp39sRouaHkGdj
         6eSxAbjnscbgL3gC9uEKsB4QlM7SqUZHn8pGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SjdKzeH7GW9tQGsunBGfIcgoB4TuWBhVIwFN+ncvBXE=;
        b=OUSvFfOSmyvDhZczQ4AxQeK7ZNgL5Ii3lCm+D98EvkZMOgcdodgJO/+himFI6/r60F
         cXQ6P/CJCTbkxVFJRBQZJFpQ1nxbpDsApTEfpTc7DPZPI16lSM3aJXPbpyXuGbSyyZaB
         yhIDp6NEPzh+p0YddY/FjyHfV9RslAzoHJ0RPbqHCobEey3lZqFuewRxEKOjIVRkfbry
         5bDw7ZJe71TO3aTDt5lifw1IhA8Wz5FQfWkHb5pQnDljzwocNig9uZo2riJKQSnf3mGQ
         kr/Gi/bXGFlmJagr5HtYXqZ6XiLOMEFxpeD7VAKfKEB0c4eUo5LM4bA7UYg41xqRt1Z8
         lCXQ==
X-Gm-Message-State: AOAM533WqRgR4akeqO8EiBcV3OcDxPtf+IqwxJD4vWh4h76Urpwk0dBR
        rM3Knscy9gsxeUvUwKHcw4+0iPNMgdc=
X-Google-Smtp-Source: ABdhPJzRLB1VAhnTAH//Vf34hhnhLIcox6EcBAnKlJDtzGp+8PwlZspufe0ZqKpRpx5poWE80d8uJA==
X-Received: by 2002:a65:4c4b:: with SMTP id l11mr411781pgr.123.1593202738300;
        Fri, 26 Jun 2020 13:18:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p12sm23389172pgk.40.2020.06.26.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:18:57 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:18:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: remove cc-option test of -fno-stack-protector
Message-ID: <202006261318.75C7FE339@keescook>
References: <20200626185913.92890-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626185913.92890-1-masahiroy@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jun 27, 2020 at 03:59:12AM +0900, Masahiro Yamada wrote:
> Some Makefiles already pass -fno-stack-protector unconditionally.
> For example, arch/arm64/kernel/vdso/Makefile, arch/x86/xen/Makefile.
> No problem report so far about hard-coding this option. So, we can
> assume all supported compilers know -fno-stack-protector.
> 
> GCC 4.8 and Clang support this option (https://godbolt.org/z/_HDGzN)
> 
> Get rid of cc-option from -fno-stack-protector.
> 
> Remove CONFIG_CC_HAS_STACKPROTECTOR_NONE, which should always be 'y'.
> 
> Note:
> arch/mips/vdso/Makefile adds -fno-stack-protector twice, first
> unconditionally, and second conditionally. I removed the second one.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
