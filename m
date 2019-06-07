Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71248396E2
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 22:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfFGUhU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 16:37:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43206 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbfFGUhT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 16:37:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id i8so3047664oth.10
        for <linux-efi@vger.kernel.org>; Fri, 07 Jun 2019 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwl/nkc+IszDeHT62sv1m6fGxfEAM5F5rJvu4oDhrCE=;
        b=iXoOHs0qLQeKL146DhnpQRL8fyunWXkNhiyrEGM4mBSemtorkbJ+Lf69iPFQOJa/Gu
         97Z7Zj9tM2EZGj/tnqFMuHcRbrtcN2P9edSdTzjrI3sY9MOfgAKH9+e5MjoUxeF5F0Zc
         IX/4HIajFNa1uMMtHjO4jNtyaM9hw1AoHCA1upzHQMKDiK/kTjkfpyIOKdWYInDlC0xw
         DtqXeQoz30yH3g9Wn1/6c59zn+kx7FaVaBGhD/G9is+lvNesOwwpvLWj6HO8+Iu7xKKt
         UN3q3PaOMFG+sqdZ72Vns2NPyLuL+tkxywHgGlXD5VYzKAww7B5ovRTePAWDkz/oRYPV
         OXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwl/nkc+IszDeHT62sv1m6fGxfEAM5F5rJvu4oDhrCE=;
        b=U+1T0xr/cDxf+Ja8L2yq5c0hhVI+mi2lD969d92MbMNjdl3tLPwKP0FChBXtDsqKVv
         tfOQIDbYOBcJEbWdS3/GGQJthwJvFNpXwapoMhGNRSu4yQVBU+83OoTtKdT1B2R4FZBg
         nrbgNIiotlLj9GKWLIPoO/Kcd8aOmhczxC0yl3b93O9EjgZvFDMJc9aiILS8+ZF3pZzt
         7TFHD8+AJThfeDAI4CkjNb0/FLr+9KJM5+eZlGpAYYIxFypnOueKSCYDP+90uXJfylKB
         ofLwMMKE4NE/g8m6zUmG8RIGoOXebacPfMfXvHgf5T+Z6Nz9tWYb/ys74ypIJrYqYgy+
         uJCw==
X-Gm-Message-State: APjAAAUxUW9HTU9gi+DTMeGqYIhfvjQiurWBcStuvyUGomUMHJ98VB8m
        WRLdm83CbG3GWneG33KUrhHVCHkswJIX7J2CCOmlZA==
X-Google-Smtp-Source: APXvYqxyknLc/KKZrXUegoVoEchoENiE3uDTtvta1M+m/gEOhSX8p64QD9se390P/E5smOxnDXWM2sESCdMzk/VkmBs=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr5538455otf.126.1559939839164;
 Fri, 07 Jun 2019 13:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <86a49d1a-678e-5e86-180b-e48326d1bdb5@intel.com>
In-Reply-To: <86a49d1a-678e-5e86-180b-e48326d1bdb5@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Jun 2019 13:37:08 -0700
Message-ID: <CAPcyv4gvToqPXSy5MKXOX=HvFP2R0F_6DY3qUiagQEKk84BKpg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] EFI Specific Purpose Memory Support
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 7, 2019 at 12:57 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/7/19 12:27 PM, Dan Williams wrote:
> > In support of optionally allowing either application-exclusive and
> > core-kernel-mm managed access to differentiated memory, claim
> > EFI_MEMORY_SP ranges for exposure as device-dax instances by default.
> > Such instances can be directly owned / mapped by a
> > platform-topology-aware application. Alternatively, with the new kmem
> > facility [4], the administrator has the option to instead designate that
> > those memory ranges be hot-added to the core-kernel-mm as a unique
> > memory numa-node. In short, allow for the decision about what software
> > agent manages specific-purpose memory to be made at runtime.
>
> It's probably worth noting that the reason the memory lands into the
> state of being controlled by device-dax by default is that device-dax is
> nice.  It's actually willing and able to give up ownership of the memory
> when we ask.  If we added to the core-mm, we'd almost certainly not be
> able to get it back reliably.
>
> Anyway, thanks for doing these, and I really hope that the world's
> BIOSes actually use this flag.

It should be noted that the flag is necessary, but not sufficient to
route this memory range to device-dax. The BIOS must also publish ACPI
HMAT performance data for the range so the OS has a chance of knowing
*why* the memory is "reserved for a specific purpose", and delineate
the boundaries of multiple performance differentiated memory ranges
that might be combined into one shared / contiguous EFI memory
descriptor.

With no HMAT the memory will be reserved, but no dax-device will be
surfaced. Perhaps this implementation also needs a WARN_TAINT(...,
TAINT_FIRMWARE_WORKAROUND...) to scream about a BIOS that fails to
publish the required HMAT entries, or perhaps even better a command
line option to ignore the flag so that the core-mm can pick up the
memory by default?
