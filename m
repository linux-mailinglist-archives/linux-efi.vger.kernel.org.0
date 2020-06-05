Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED121EF91B
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgFENci (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgFENcg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Jun 2020 09:32:36 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76A1C08C5C2;
        Fri,  5 Jun 2020 06:32:35 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s1so9589595qkf.9;
        Fri, 05 Jun 2020 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dXbhElR9fIIoNm592BqkNtyiLYeHyEZyFElSd2U14e0=;
        b=g2eBnKJ/6GO7grzMO+xW4oWDN4O3M4casrrOgjTC6/2fCwxR7YV4qMSwzZrolEu+qu
         BbW10JeIkmvR5zYcSzdMLj2a/HAK9kekPIikLcr9BmAEvJhjC3+Ql8jyVGB1M4GfuGnh
         5AeLNlQtnA+fUyJVBs7VRaXSCLTXifUTL0fUhc72H1DyFs+A0LVqG2JNU0qObI2xSG7V
         soKe8/Vi/iUKWmGDtbGuJimWryob34I0Y4b6q8GXmkZNwdrbdB4CSbU0ZiKa/0fRfTZH
         E8y/PVCp0pZL49w+IVCiuJMYeQnd2ooO4twWCsBPcw6PToMs4oIEsHz7/tB1S/QVYcWE
         B/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dXbhElR9fIIoNm592BqkNtyiLYeHyEZyFElSd2U14e0=;
        b=l11yk2H8BYg8s3qEspmtnt0YU8B1pgCfk5UYRAzYc6YV17OSLoEg5cD7n1c7vKr7XT
         ZpH8SGbWQqZm5gEesAmqIoVFb3fVshTRU9YZSlMvy16KJdP4VQ2nMnpy1elluq7+Uqcs
         ygCUxLSjmlkK07zUq61Cz2JOpEghaFAvbNS64ZMynJxZyP6xq7+OjnGh9crYJUyZ2dtO
         kOi9a6uLYyOxqgIVwIfs6WnT8qVJsMX+XbM47bA9MvZNuLOuMh1LV+GIahxPtT63ssjN
         QhWeRDYt3JJyNGuI52bU91N2yoBvtHyNPJonGb9031c/PevKaFXbLdkv/0QJ1SJffGwg
         kvdg==
X-Gm-Message-State: AOAM530J7B8HcCyfFeH1Gob7ZNDOnJxuhLBzC6DKYFOrod5nYz7Wrb/b
        6CLMw4Lt7nVRIoBJt0/VuXs=
X-Google-Smtp-Source: ABdhPJzzbtd5Rfo9YY68qzkP0BF7W7YsX6+0mA8TshauSrpia1fxzkYZoj+bsmgwLRxAeS0BaOoMRQ==
X-Received: by 2002:a37:61d7:: with SMTP id v206mr10649554qkb.100.1591363954560;
        Fri, 05 Jun 2020 06:32:34 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q124sm6976871qke.51.2020.06.05.06.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:32:34 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 5 Jun 2020 09:32:32 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Andrey Ignatov <rdna@fb.com>,
        linux-efi <linux-efi@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 05/24] efi/libstub: Optimize for size instead of speed
Message-ID: <20200605133232.GA616374@rani.riverdale.lan>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
 <20200518190716.751506-6-nivedita@alum.mit.edu>
 <20200605003134.GA95743@rdna-mbp.dhcp.thefacebook.com>
 <CAMj1kXGaQGaoiCqQpX4mdN6UQi25=EhqiNZn=sbcgi1YYuJwBA@mail.gmail.com>
 <20200605131419.GA560594@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200605131419.GA560594@rani.riverdale.lan>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 05, 2020 at 09:14:19AM -0400, Arvind Sankar wrote:
> On Fri, Jun 05, 2020 at 08:33:22AM +0200, Ard Biesheuvel wrote:
> > Hello Andrey,
> > 
> > On Fri, 5 Jun 2020 at 02:31, Andrey Ignatov <rdna@fb.com> wrote:
> > >
> > > Arvind Sankar <nivedita@alum.mit.edu> [Wed, 1969-12-31 23:00 -0800]:
> > > > Reclaim the bloat from the addition of printf by optimizing the stub for
> > > > size. With gcc 9, the text size of the stub is:
> > > >
> > > > ARCH    before  +printf    -Os
> > > > arm      35197    37889  34638
> > > > arm64    34883    38159  34479
> > > > i386     18571    21657  17025
> > > > x86_64   25677    29328  22144
> > > >
> > > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > ---
> > > >  drivers/firmware/efi/libstub/Makefile | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > > > index fb34c9d14a3c..034d71663b1e 100644
> > > > --- a/drivers/firmware/efi/libstub/Makefile
> > > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > > @@ -7,7 +7,7 @@
> > > >  #
> > > >  cflags-$(CONFIG_X86_32)              := -march=i386
> > > >  cflags-$(CONFIG_X86_64)              := -mcmodel=small
> > > > -cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ -O2 \
> > > > +cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ \
> > > >                                  -fPIC -fno-strict-aliasing -mno-red-zone \
> > > >                                  -mno-mmx -mno-sse -fshort-wchar \
> > > >                                  -Wno-pointer-sign \
> > > > @@ -25,7 +25,7 @@ cflags-$(CONFIG_ARM)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> > > >
> > > >  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
> > > >
> > > > -KBUILD_CFLAGS                        := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
> > > > +KBUILD_CFLAGS                        := $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
> > > >                                  -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
> > > >                                  -D__NO_FORTIFY \
> > > >                                  $(call cc-option,-ffreestanding) \
> > >
> > > Hi Arvind,
> > >
> > > This patch breaks build for me:
> > >
> > > $>make -j32 -s bzImage
> > > drivers/firmware/efi/libstub/alignedmem.c: In function \x2018efi_allocate_pages_aligned\x2019:
> > > drivers/firmware/efi/libstub/alignedmem.c:38:9: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
> > >   status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
> > >          ^
> > 
> > Which version of GCC are you using?
> 
> gcc-4.8.5 from the config. I got a copy and can reproduce it. Just
> adding -maccumulate-outgoing-args appears to fix it, checking some more.
> 

On a simple test:
	extern void __attribute__ (( ms_abi )) ms_abi();
	void sysv_abi(void) { ms_abi(); }
it only breaks with -Os -fno-asynchronous-unwind-tables, weirdly enough.
