Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA641F9C63
	for <lists+linux-efi@lfdr.de>; Mon, 15 Jun 2020 17:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgFOP4J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Jun 2020 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgFOP4I (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Jun 2020 11:56:08 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1C7C061A0E
        for <linux-efi@vger.kernel.org>; Mon, 15 Jun 2020 08:56:08 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w9so12977289qtv.3
        for <linux-efi@vger.kernel.org>; Mon, 15 Jun 2020 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pyUObpuGjXc0u3LNw8wyBFNVD6oCJobVfqhBzgZCF2s=;
        b=awK+jta+Ll2+n+qrFxXNlquHhaUsZ/r2xFMLB3iZtJux20kcYeaV+9lCYS1BOMYqlX
         w/ONz/vRXbqK1UTwRsmeft/+FDIRqGtfXh8bg1eQP/qIJiRSgHKcty0cxFhoMOdBBOr9
         t8OFBnIGMHCR57ZQkew8mutD3ijLlCc/BPKEXmBvudx/lCxCcz46vY5bM6fDLYnuFhz/
         zxQgB6I0q39kCX1oz/lCqhXwDlpma1gq8wab+yhxNG0vWZ66CVfvp829sjhg+fgrh3iO
         mdZM/rekso0mxN3m/7xPtYJm3x/VzJed8s3OC9YIYtuQWYNVSmCyp/t6a7Y1hYpzwhBC
         iSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pyUObpuGjXc0u3LNw8wyBFNVD6oCJobVfqhBzgZCF2s=;
        b=ONgOLmwB+GdbYj9IBmIrjNMuHK2HKHKywqPOuw9JVVJ4vSul7mMcVBjwTj9EVP16cl
         PJ9T6SyZRIizojVXkBqzWiDbMTMX3HCvshhei2LiQ3a1tI4H31VdSTZzP6/GxYYN9eoK
         N/ZmA4kcI4Cpsnmz0fhUrXqBrDdsiJwmOWxrATVjhp9iYpzMThLPZNmZbw2Emq2kIrvs
         JM7+E/vLXDzXsDYYPUthzaz1mYeb7MCyrnPpbiD89WLXAOuGqQy0yJ5AsSt2WMj5WrER
         WaUS2Ui+Ywvu/ITzaFkn0oulCG+9OrYKDsYOtEK1VbrlgEui8QpvD9fKvKvLGTqz1ZO0
         Jmvw==
X-Gm-Message-State: AOAM533q5GtmBkYNwSzZ1JJfIbSvhV/3WFXE/Jbd7nAm/p8wEJ40qvCo
        OJ9TGnt5thNCabETRoCai3gD6QL7
X-Google-Smtp-Source: ABdhPJyk0hkp8ESV4UDtjtr7ZgtQrnr/6gBCGINyk03ytGfMrt8EIYeah1r5tey/CKDO+vg+M5bURg==
X-Received: by 2002:ac8:1925:: with SMTP id t34mr16126378qtj.265.1592236567900;
        Mon, 15 Jun 2020 08:56:07 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i71sm11420091qke.75.2020.06.15.08.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 08:56:07 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 15 Jun 2020 11:56:05 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 1/1] efi/x86: Use firmware stack for mixed-mode EFI stub
Message-ID: <20200615155605.GA672028@rani.riverdale.lan>
References: <20200526170226.2371024-1-nivedita@alum.mit.edu>
 <20200526170226.2371024-2-nivedita@alum.mit.edu>
 <CAMj1kXFGubFssfb1K_KUGXHhwF1X-vsL+ENYHU4EtbEXCTsQXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFGubFssfb1K_KUGXHhwF1X-vsL+ENYHU4EtbEXCTsQXw@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 15, 2020 at 11:58:43AM +0200, Ard Biesheuvel wrote:
> On Tue, 26 May 2020 at 19:02, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > The UEFI specification requires a 128KiB stack during boot services. On
> > a native mode boot, the EFI stub executes on the firmware stack.
> > However, on a mixed-mode boot, startup_32 switches to the kernel's boot
> > stack, which is only 16KiB, and the EFI stub is executed with this
> > stack.
> >
> > To avoid any potential problems with running out of stack space, save
> > and restore the UEFI stack pointer in the mixed-mode entry, so that the
> > EFI stub can use the firmware stack in this case as well.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> This does not apply onto v5.8-rc1, and I was going to take it as a fix.
> 

This was based on the runtime-relocation removing patch series (see
cover letter).
https://lore.kernel.org/linux-efi/20200526170226.2371024-1-nivedita@alum.mit.edu/

I can rework it to apply on mainline if we decide this patch could be
useful.

> However, are we sure this is safe? Do we have a ballpark figure of how
> much stack we use in the stub?
> 
> This is one of those things I am reluctant to change, given that we
> are not sure that firmware implementations conform to this, and IA32
> firmware was not designed to boot a 64-bit image (which might use more
> stack space?)
> 

The EFI stub code itself doesn't use much stack. The largest frame is
720 bytes and the rest are below 300, so it probably doesn't even reach
4k. The risk is really that inside the firmware it uses stack space more
liberally given it can assume it has 128KiB available. A safer
alternative would be to switch to the firmware stack only when actually
calling the firmware, inside the mixed-mode thunk.

Also, this patch fixed up one other small issue, which is that when we
enter via the compat 32-bit entry, we will call efi_pe_entry with a
misaligned stack (0 mod 16 instead of 8 mod 16). It gets correctly
aligned once efi_pe_entry finishes and calls efi_stub_entry though, so
most of the stub will still execute with proper alignment.
