Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCABC12BC8A
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 05:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfL1EoC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 23:44:02 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33285 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfL1EoB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Dec 2019 23:44:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so15021759qkc.0
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 20:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sm+5CNCbDHd52YEC0D6Oa9Akw0RhNU8Jr/rZBKKMKaI=;
        b=oyaBmfpuxKLzO3hTLBLiJkPTXEvC20DY/RRR6JSMOHQxI789ap9Icte536fSaw8R2F
         5IsRqRVVsmqJNE07dhV4J+n7f0BXNr0rjQWGXsas6We4FrtVCFs3ajZ0m8oZx4gTbQLb
         4anPUpGBcqyarPVDDvGBNXEDXWWDmwxCQHHs1zdu9i40JzXeI90U7/asPj7GR/pwC6cI
         f4XfvxTQVCo49enY45J+G0+3L7B9XzScOwD8NT2eAorne/JjvBs4q5wX+Sx4VjZH0spk
         JXjzyI0JgIk2TnzcpcAz1KVRnF/e25yi9ZO6cgYRIGyr/MbeFQ3LoBh/25wNdIfhY92J
         jIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sm+5CNCbDHd52YEC0D6Oa9Akw0RhNU8Jr/rZBKKMKaI=;
        b=GR8o2YAHj7dbiQob592VpkqxcV3/OrHi1nXolqRbWpJYEpZIKcVk3wVAV+wblnB5Ab
         y0cphTbF9ssEpyQqqHTQoUm8/jxBatpsG8RpslBX3+fc0P5VPapSWD0uLPKatjAqFQ/A
         d6s6LYYxb2VgMA45wKyRMwRhWqOPiD1H3mTJIf00Wu4UFHkCEkjUgY/U8gF/RSwpARtg
         h2D20/9ljQgc7naGFlnWYjYK3MG0MdGzAfLxG8ZIXxakXJUaxF89P+Oq5pPdmGlMeYPP
         82pasnk3iAATPSya4USB9qnLh+FuQ+miqw8uAnXO7THxZG4Ihzl/sKqlc086LXnJ3e+A
         Aiaw==
X-Gm-Message-State: APjAAAUiLPrOYcuor5m0avs5K2qzVbzRS0MZm5H6SSd+XWcewqmkJ4aQ
        d8TDHTo9q+ciLv6chHpImhU=
X-Google-Smtp-Source: APXvYqwcOLC/ZIx4YOBNYuZOKZ/rpWnQXd38yg3XxJ6Xy8MA31p8aXbBHifrBCBkfZXfJ88FRNEEOw==
X-Received: by 2002:a05:620a:911:: with SMTP id v17mr46106175qkv.251.1577508240440;
        Fri, 27 Dec 2019 20:44:00 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t42sm11543550qtt.84.2019.12.27.20.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 20:44:00 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 27 Dec 2019 23:43:58 -0500
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] efi/x86: simplify 64-bit EFI firmware call wrapper
Message-ID: <20191228044357.GA1194635@rani.riverdale.lan>
References: <CAKv+Gu-LeDgMFU-Hfuc7wDgNRmq2n0goJTuK6f8oahB_MGCc-g@mail.gmail.com>
 <9CF0A0F3-DEA8-410B-A042-0A4F8BF543F2@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9CF0A0F3-DEA8-410B-A042-0A4F8BF543F2@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 28, 2019 at 11:25:49AM +0800, Andy Lutomirski wrote:
> 
> 
> > On Dec 28, 2019, at 2:13 AM, Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > 
> > ﻿On Fri, 27 Dec 2019 at 19:08, Arvind Sankar
> > <nivedita@alum.mit.edu> wrote:
> >> 
> >>> On Fri, Dec 27, 2019 at 12:51:56PM -0500, Arvind Sankar wrote:
> >>> Does kernel_fpu_begin/kernel_fpu_end need to be outside the
> >>> efi_switch_mm?
> >>> 
> >>> If there's an error in efi_call_phys_prolog during the old memmap
> >>> code, it will call efi_call_phys_epilog without having called
> >>> kernel_fpu_begin, which will cause an unbalanced kernel_fpu_end.
> >>> Looks like the next step will be a panic anyway though.
> >> 
> >> Do we even need to save/restore the fpu state at this point in
> >> boot? The mixed-mode code path doesn't appear to be
> >> saving/restoring the XMM registers during SetVirtualAddressMap.
> > 
> > That is an excellent question, and I was hoping Andy or Ingo could
> > shed some light on that.
> > 
> > I tested without and it booted fine, and it does seem to me that
> > there should be very little to preserve given how early this call
> > happens (from efi_enter_virtual_mode() which gets called from
> > start_kernel())
> 
> 
> Unless you’re somehow calling it from interrupt context, I doubt
> saving FP regs is needed. Certainly kernel_fpu_begin() doesn’t do
> anything that matters if we’re in the (misnamed) init task. If you’re
> calling it really really early, there’s a different potential issue:
> FP might not be fully initialized. We could have CR0.TS still set, or
> we might not have all the various “OS supports such-and-such regs”
> flags set.
> 
> Does the UEFI spec explicitly state what FP state can be used by the
> EFI functions?

For 32-bit, it requires the following for boot services and runtime
services:

* Direction flag in EFLAGs clear
* 4 KiB, or more, of available stack space
* The stack must be 16-byte aligned
* Floating-point control word must be initialized to 0x027F (all exceptions masked, double-
  precision, round-to-nearest)
* Multimedia-extensions control word (if supported) must be initialized to 0x1F80 (all
  exceptions masked, round-to-nearest, flush to zero for masked underflow)
* CR0.EM must be zero
* CR0.TS must be zero

We don't actually align the stack for 32-bit mode before calling, do we?

No FP registers are clobbered except the floating point status register.

For 64-bit:
* Direction flag in EFLAGs clear
* 4 KiB, or more, of available stack space
* The stack must be 16-byte aligned
* Floating-point control word must be initialized to 0x037F (all exceptions masked, double-
  extended-precision, round-to-nearest)
* Multimedia-extensions control word (if supported) must be initialized to 0x1F80 (all exceptions
  masked, round-to-nearest, flush to zero for masked underflow)
* CR0.EM must be zero
* CR0.TS must be zero

xmm0-5 (and the FP status register) may be clobbered, the rest of the FP
registers are preserved.
