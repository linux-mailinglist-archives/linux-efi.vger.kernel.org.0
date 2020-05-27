Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC91E460B
	for <lists+linux-efi@lfdr.de>; Wed, 27 May 2020 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbgE0Og6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 May 2020 10:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389313AbgE0Og5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 May 2020 10:36:57 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CB2C05BD1E;
        Wed, 27 May 2020 07:36:53 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id l3so11234155qvo.7;
        Wed, 27 May 2020 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M/Ui5N10MoWP25QkZD0joVeWRBDs+C5tf80CUmghzwI=;
        b=PGIXthgPprHVZlHsny105w605Sd1gB4QZTpYrlxOq3UJ5SRdnxxv2HkC4XUz+sizjX
         Lkpnq+1W5yP+SYim2ekNp+smjGuRwlgd3QovMAh/8UV61v8MH46E+TACFUI1+0E74nVG
         EBRqzKaUxD2jctWZtSgKkdieSmSpXlJRVMwWW+tuCoXflNOT+3gbAYl1Ykt2kxwdyNIW
         oEXwhTaL5S0dzKJyHZbuDeiNTU7YZb5zwAWbGGnLxmzyuqLPewIy41XKZDuNq6tp6jt2
         a96Zw1DFViX0GKoUtQnOjxhQ7MvFHhWtxQVrK6Ws7L5tA7ZGL1Rs1VJ3ooFqlpGh9qYA
         omEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=M/Ui5N10MoWP25QkZD0joVeWRBDs+C5tf80CUmghzwI=;
        b=PX5PuwiDvc9Nt6WvQetptC16IaYMclvGpg3eUMgkdqjpgXWYu9lF/9PVR80DYc5/jY
         T99tLw7Y9dkNEKr8Nk0Czg4bUdTg4yCAhTHwvkAYxwa3pa0yIRgsmfI55g95WF7IceBk
         iiyTnYBr51JY73hxpVeUew1kB0XQWNG38rKZ8h+4CaQjVSQ5oatNopQ6Z0hXFUbyoujR
         LNdrA7VjQNeeo1I9EktETFDTY7hAlZKjNdmMud7TzZst+h6BeF9hE2EuHfHf18kOhqiZ
         XvXdmh9ZMccv2ZE86WmxAb2dS1uSo0ixdD57Vzmrs3QPKCQP894XXIlxneOnpY+wak1k
         lUCg==
X-Gm-Message-State: AOAM533L8uMGv4GTNm+iywcjj0zR5AH+9SfTdEzIiOTX5RrjvHZKw98+
        re5UEC3L0FkZHPreWUVfc/n9Q/dQ
X-Google-Smtp-Source: ABdhPJyMu12+V12ENpEF2IvmAVARuf8i7xe/1zWRe2s1RqcQQm7+ktBiyXEnpP/GhP3uGuwwJfYPfg==
X-Received: by 2002:ad4:58cb:: with SMTP id dh11mr23547867qvb.211.1590590212778;
        Wed, 27 May 2020 07:36:52 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l2sm2620918qth.47.2020.05.27.07.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 07:36:52 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 27 May 2020 10:36:50 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 2/3] x86/boot/compressed: force hidden visibility for
 all symbol references
Message-ID: <20200527143650.GA3103408@rani.riverdale.lan>
References: <20200523120021.34996-1-ardb@kernel.org>
 <20200523120021.34996-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200523120021.34996-3-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, May 23, 2020 at 02:00:20PM +0200, Ard Biesheuvel wrote:
> Eliminate all GOT entries in the decompressor binary, by forcing hidden
> visibility for all symbol references, which informs the compiler that
> such references will be resolved at link time without the need for
> allocating GOT entries.
> 
> To ensure that no GOT entries will creep back in, add an assertion to
> the decompressor linker script that will fire if the .got section has
> a non-zero size.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/Makefile      |  1 +
>  arch/x86/boot/compressed/hidden.h      | 19 +++++++++++++++++++
>  arch/x86/boot/compressed/vmlinux.lds.S |  1 +
>  3 files changed, 21 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 5f7c262bcc99..aa9ed814e5fa 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -40,6 +40,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> +KBUILD_CFLAGS += -include hidden.h
>  

Ard, from the other thread [1] in case you missed it -- the plain
hidden.h fails to build in-tree. We need something like
	KBUILD_CFLAGS += -include $(srctree)/$(src)/hidden.h
instead.

[1] https://lore.kernel.org/lkml/20200526153104.GC2190602@rani.riverdale.lan/
