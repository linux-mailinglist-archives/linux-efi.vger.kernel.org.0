Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD012F847F
	for <lists+linux-efi@lfdr.de>; Fri, 15 Jan 2021 19:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733257AbhAOScv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Jan 2021 13:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733262AbhAOScv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Jan 2021 13:32:51 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684ACC061799;
        Fri, 15 Jan 2021 10:32:06 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 143so12565029qke.10;
        Fri, 15 Jan 2021 10:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NWIVG2KxAyCSAbHgbe1kK1Pe6u+Em4RwT5uHY88V9T0=;
        b=Ez0mmPRzsxM/TG3NrKfui7SxfYHktje0S5IwnWOP7YnFh4Ok5C476FVRp9tq9ioOvg
         KIwk2rkZpkn+F8zGgKIm2JGernqgfp7RRAp3qSxDQd8OgM71pnlGB9jBmd+ciRNVLyO8
         GgsoKEKTTOgVZbYpDaGgL3XnPr1R5raCdxTxPRbBT8SNrGJmKeX9BJa3NELIqV55KhVE
         Ggi8TsRkT0wUqev0htvQXHTF/unuAL8X+AqS2rfc+vAMorTAUvzrmytvktQYClRkIwbu
         TRgRLVknJ4kaEErLfqA3UuYGt3r2WJZNR4p3YPZz5ptjHX5V2p8xdahMKfXTLSkf0Llt
         Ra9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NWIVG2KxAyCSAbHgbe1kK1Pe6u+Em4RwT5uHY88V9T0=;
        b=H5p3zAyYmm2qSbG5HOdvU0oQOYWZLtlhxWSjp1dgXsEWMGIRKeHjp8XxS3AxizfxQP
         D+q5PxuKxT3JyKqNP7efSh23tU3Va8TEk1/FibdbsQ7aSTcdPOACQ4lpHlmvHpZLCJO3
         VnL+2IL4r/niETcdKVpg+77teJJIGaMAKr8C+O/3wYygWLoX6Zb5TQUm3gP+vOw4tDVP
         Ih5dpDYUh/toHYZUBp2Vm+kEiMD+D0nbLfWs6DSyeypdgfgn/Zfc6jn9f+HWpueNWglq
         R51WMMvBpY1gBI9yH21F1VxcUinosQK+q9FTJibbU2bRJ8qHowI/ZGC2A2S4Fxehx74H
         itVg==
X-Gm-Message-State: AOAM5318OVF0YQt5ssu/ZbazRp3NWr9UsaVbJHwA7pwbFZeqglx49o+X
        YxayWffYAvPM4cUPqmYnwVqMnvlaCR0=
X-Google-Smtp-Source: ABdhPJwJFmezxePs+vr6dhIZlGppx+ulXQvwsTneiKkN5Z0IA6Q3OS/LkzTi+fn89ulFPVYXsu3Nzw==
X-Received: by 2002:a37:4796:: with SMTP id u144mr13186207qka.235.1610735525568;
        Fri, 15 Jan 2021 10:32:05 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id c136sm5556114qkg.71.2021.01.15.10.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:32:04 -0800 (PST)
Date:   Fri, 15 Jan 2021 11:32:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <20210115183203.GA1991122@ubuntu-m3-large-x86>
References: <20210107223424.4135538-1-arnd@kernel.org>
 <20210115182300.GD9138@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115182300.GD9138@zn.tnic>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 15, 2021 at 07:23:00PM +0100, Borislav Petkov wrote:
> On Thu, Jan 07, 2021 at 11:34:15PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > When 5-level page tables are enabled, clang triggers a BUILD_BUG_ON():
> 
> I have CONFIG_X86_5LEVEL=y, CONFIG_EFI=y and am using Debian clang
> version 10.0.1-8+b1 but my .config builds just fine.
> 
> How do you trigger this?

I triggered it with CONFIG_UBSAN=y + CONFIG_UBSAN_UNSIGNED_OVERFLOW=y
(it can be exposed with an allyesconfig/allmodconfig on mainline
currently).

Cheers,
Nathan
