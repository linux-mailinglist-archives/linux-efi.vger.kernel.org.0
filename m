Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A611FBE72
	for <lists+linux-efi@lfdr.de>; Tue, 16 Jun 2020 20:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgFPSsf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Jun 2020 14:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgFPSsf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Jun 2020 14:48:35 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB73DC061573
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 11:48:33 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z1so16367372qtn.2
        for <linux-efi@vger.kernel.org>; Tue, 16 Jun 2020 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q3XJdRkItXdTbVltIKOebTmbTaeIw+1QENo/OZhawig=;
        b=pG1QjcUgmqqrFdOQ9o8wSUq5I6SjXdpzb+aRhzqFrYZmrxtnggUOl7ddNYS9cnIcAM
         ylNwE0JNp98TPfcUzmzQmgyZXOyWQcMvorPsuW+uqT2Uz1NwVtQ0qsULdLWeiip1F0Xf
         ehFnLLiteIxPs8xocby61HH+7m/vvAeV7C0t1sIfAjsAFFd6LtuxRGWxHjq6/HrY1KJQ
         0JOK6HJQoFTl2Pja3qQEafH6rW43Ra83l00wlOMsB3bhJmDT9ATMEzk7viGqGOIhMuh9
         7kcXXuDN+KFt28REVJuiKyt+g1EvDoES7b62QfasG/ef9bs8+VfjaBC3w8s4z/hR+VlI
         VqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Q3XJdRkItXdTbVltIKOebTmbTaeIw+1QENo/OZhawig=;
        b=lfNjLzdcsfTeeHFbxw0YZnYR9wspMJbN8TcZtsD2lnrAW1njRoYuFObdZCn70QQFO6
         St0kab79hCyHU7SCuR6N+X80NOK6VjwhRbnt/D0R83prVpJOOrMu/9kEGZ86PeYG/4bJ
         F9kEB24RnKm20LOeepXbsppHMSuvIoX/IT7CIMDLPifcqBNsTQVH94MeeOcxundxr+OC
         ewdoFZdfcizK0khFweeo0By+5VTeLOvMos8LQV88RgMLJEIlkKoieQg7JLWJ9v2nzSh9
         8i9DQUIgZwTdC2pU1H1QRhJjWb/8w3mw/AXIGTKyETa9tg4FjSaYAxTwgcUuWvXRK6Te
         wx3A==
X-Gm-Message-State: AOAM5328NWRZ566DkBZ4SMKBmyNwfzdqnDm+NLBOA23r39p4d+U1/i0y
        dJgmlKpMLOZ/Ync7lGWR+wk=
X-Google-Smtp-Source: ABdhPJz7U7lbdFjiYwMB1X2Y/ztnhaotBW5LLYx1jeJ3HYyrkpZf0q85HF2aIh/8m20uncpN/vK6bw==
X-Received: by 2002:ac8:6bd3:: with SMTP id b19mr22019902qtt.27.1592333312866;
        Tue, 16 Jun 2020 11:48:32 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k7sm15172654qth.10.2020.06.16.11.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:48:32 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 16 Jun 2020 14:48:30 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 1/1] efi/x86: Use firmware stack for mixed-mode EFI stub
Message-ID: <20200616184830.GA1581658@rani.riverdale.lan>
References: <20200526170226.2371024-1-nivedita@alum.mit.edu>
 <20200526170226.2371024-2-nivedita@alum.mit.edu>
 <CAMj1kXFGubFssfb1K_KUGXHhwF1X-vsL+ENYHU4EtbEXCTsQXw@mail.gmail.com>
 <20200615155605.GA672028@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200615155605.GA672028@rani.riverdale.lan>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 15, 2020 at 11:56:05AM -0400, Arvind Sankar wrote:
> On Mon, Jun 15, 2020 at 11:58:43AM +0200, Ard Biesheuvel wrote:
> > On Tue, 26 May 2020 at 19:02, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > The UEFI specification requires a 128KiB stack during boot services. On
> > > a native mode boot, the EFI stub executes on the firmware stack.
> > > However, on a mixed-mode boot, startup_32 switches to the kernel's boot
> > > stack, which is only 16KiB, and the EFI stub is executed with this
> > > stack.
> > >
> > > To avoid any potential problems with running out of stack space, save
> > > and restore the UEFI stack pointer in the mixed-mode entry, so that the
> > > EFI stub can use the firmware stack in this case as well.
> > >
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > 
> > This does not apply onto v5.8-rc1, and I was going to take it as a fix.
> > 
> 
> This was based on the runtime-relocation removing patch series (see
> cover letter).
> https://lore.kernel.org/linux-efi/20200526170226.2371024-1-nivedita@alum.mit.edu/
> 
> I can rework it to apply on mainline if we decide this patch could be
> useful.
> 
> > However, are we sure this is safe? Do we have a ballpark figure of how
> > much stack we use in the stub?
> > 
> > This is one of those things I am reluctant to change, given that we
> > are not sure that firmware implementations conform to this, and IA32
> > firmware was not designed to boot a 64-bit image (which might use more
> > stack space?)
> > 
> 
> The EFI stub code itself doesn't use much stack. The largest frame is
> 720 bytes and the rest are below 300, so it probably doesn't even reach
> 4k. The risk is really that inside the firmware it uses stack space more
> liberally given it can assume it has 128KiB available. A safer
> alternative would be to switch to the firmware stack only when actually
> calling the firmware, inside the mixed-mode thunk.

So one thing that mostly mitigates this is that the boot heap, which at
this time would be unused, is right below the stack and is at least
64KiB in size. Taking that into account we really have 80KiB of stack
available, so this might be fragile wrt future changes but right now
it should be safe to run on the boot stack.

> 
> Also, this patch fixed up one other small issue, which is that when we
> enter via the compat 32-bit entry, we will call efi_pe_entry with a
> misaligned stack (0 mod 16 instead of 8 mod 16). It gets correctly
> aligned once efi_pe_entry finishes and calls efi_stub_entry though, so
> most of the stub will still execute with proper alignment.

Should I do a patch just for the alignment thing then?
