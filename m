Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C67331015A
	for <lists+linux-efi@lfdr.de>; Fri,  5 Feb 2021 01:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhBEAJH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Feb 2021 19:09:07 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:45927 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhBEAJG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Feb 2021 19:09:06 -0500
Received: by mail-qv1-f42.google.com with SMTP id w11so2648134qvz.12;
        Thu, 04 Feb 2021 16:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WJYooe3xF7/mefKhohc7tEDBTk22wMNA7vkmjEV5aGE=;
        b=OEkbXOfMnCzy05c/wZUaypq6cpFZOBRTTfB0QhmONB2ki24Ik/LazMbkuGGGeoujyS
         Vc+Np2E/MI6O56y0Z1r6sPMNpUE3UawLqAs584joedES5a/3tsMjQdiwkoq/vfKmxUSp
         9Q10qxfMmlr+7Eb7El5ESiVLk1TQKYNahGjloFePRkVkJkO9fQPtLQkg+YHK7VwnLE7p
         GQQ/BhKh19K5puW+BykRU+bavOqEL4XmeDhGMu6BcRQXeaqRadVFQjlNheTUOBvnnLSy
         U8Df5miijD04exYYpkPmC345hLkPYhOnF+vdaLCF8L1bTkEOpUWzQfqT5kkCmP28HrFJ
         Hfcg==
X-Gm-Message-State: AOAM532VE9UvYiljfivfyR4VDz4SdMxKxQCAzcadApq6IgR0X/xTpOnq
        zazN9sMndhUIaJgrFnMMulI=
X-Google-Smtp-Source: ABdhPJyHm7vD6eXZdsWo92cvHMgU/gTpRmlLbMh6iK8rT+gWJiA/44WTJ27OShRPGQts3nIAOL9cDQ==
X-Received: by 2002:a05:6214:446:: with SMTP id cc6mr2003665qvb.31.1612483705438;
        Thu, 04 Feb 2021 16:08:25 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e15sm3360111qtq.43.2021.02.04.16.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 16:08:24 -0800 (PST)
Date:   Thu, 4 Feb 2021 19:08:22 -0500
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86: efi: avoid BUILD_BUG_ON() for non-constant p4d_index
Message-ID: <YByMdh/qDEwreq6S@rani.riverdale.lan>
References: <YAH6r3lak/F2wndp@rani.riverdale.lan>
 <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
 <20210118202409.GG30090@zn.tnic>
 <YAYAvBARSRSg8z8G@rani.riverdale.lan>
 <CAMj1kXHM98-iDYpAozaWEv-qxhZ0-CUMwSdG532x2d+55gXDhQ@mail.gmail.com>
 <20210203185148.GA1711888@localhost>
 <CAMj1kXFPOvkcw573wzKzMQOgT-nddFcAZo9M4Lk+idn_1UBbnA@mail.gmail.com>
 <20210204105155.GA32255@zn.tnic>
 <YBxqnosGDroAnpio@rani.riverdale.lan>
 <20210204221318.GI32255@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204221318.GI32255@zn.tnic>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 04, 2021 at 11:13:18PM +0100, Borislav Petkov wrote:
> On Thu, Feb 04, 2021 at 04:43:58PM -0500, Arvind Sankar wrote:
> > This should check EFI_VA_END instead of EFI_VA_START, and maybe throw in
> > a BUG_ON if EFI_VA_END >= EFI_VA_START.
> 
> No need:
> 
>         if (efi_va < EFI_VA_END) {
>                 pr_warn(FW_WARN "VA address range overflow!\n");
>                 return;
>         }
> 
> We already check we're not going over at map time. And our runtime
> services range is hardcoded. And we're switching to that PGD on each
> runtime services call.
> 
> So I don't see the point for keeping any of the assertions.
> 
> Unless you have other valid arguments for keeping them...
> 

No, I don't have any objections to removing them altogether. All the
comments other than the one about changing the #define's only apply if
it's decided to keep them.
