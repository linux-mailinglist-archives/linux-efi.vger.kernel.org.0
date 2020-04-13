Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DCF1A674C
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 15:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgDMNrD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbgDMNrC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Apr 2020 09:47:02 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34C0C0A3BDC;
        Mon, 13 Apr 2020 06:47:01 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id v38so4348585qvf.6;
        Mon, 13 Apr 2020 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x1yXSTDynQiy82Vyc5H3wDcpDxiJ8zfFOpxq7i05rdA=;
        b=E0vI36uYuChS4rQ8OqvYKwGYdN2vO6ZS5h2cVbCMl/eDa9rd8yb54EO5+f26Vbj/9g
         ZEl5MmTu1k9kbiztjCQmN//Bri+Q82cr0kZ3fbIbU0KP7o/g8FQ6wRUw0sgD/C0gIqtx
         8L+CjWXZr5zVfReTtEvnyUejSBIQyyvLqFsO4m49e2fdIWNIKIl//ebNJAs9ev5wQVWZ
         pHQhDYWwcH9rowmV/JA3/48cFm64knG8LgaSgctO2Z6k6QYx+xCrM4TRzEI/m4e3vkwS
         NpYpjhR0x3uVF4xYo3g6zOkFSUq5T+u3vHPOqhek9NMEsPLC8uKT7AIP7k5qltMwXR+5
         l0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=x1yXSTDynQiy82Vyc5H3wDcpDxiJ8zfFOpxq7i05rdA=;
        b=tuWJdyHjwkwXvrieMAM4TUiehuRNI2wy4gnUPd0Y+idwrRhHTddqsrOO7PmZGMXoz6
         c9Xa3bx7bUxcMPIbTmwBApOJcAGS2uqNJWwZACDeJw8MIygEAAElZeCNS1oMOaA6zay7
         yQuFEfGHC/n133EZkAJmmGkEyIAYxb4RiylGw1LCHwaNQw9jA3hSctcrRenC3WLatPZt
         wtZhzi0gVjx/LhsljM86vyDS733wEdAK94nZlfjb0qVOjVmJKBlad8yQOPVrV7LGcgI+
         /ssVou+CBNrO1e4Z1GSS0y5SVWo8uhW7aXZoba5bLh5W4FqgZ/LIm7Q7VP4+NwdOcZ/z
         engw==
X-Gm-Message-State: AGi0PubrtzL/DDFeRuV+LaoUReQBELcPLOvYb/JvdB3lQIjdN3rjoehJ
        EuVxlqiIxH6fTay2IxJFnWA=
X-Google-Smtp-Source: APiQypKRGoH7GuYS1xxa6TJXgAVk03aMRlImkl8rhi+XUAJ1qsmZFzQOgk5xM1YjprER8S/Reox48w==
X-Received: by 2002:a05:6214:1781:: with SMTP id ct1mr17456897qvb.87.1586785620886;
        Mon, 13 Apr 2020 06:47:00 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i42sm7254276qtc.83.2020.04.13.06.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 06:47:00 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 13 Apr 2020 09:46:58 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Victor Erminpour <victor.erminpour@oracle.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi/libstub/arm64: Enable __efistub_global define in
 .data section
Message-ID: <20200413134658.GA2111242@rani.riverdale.lan>
References: <1586468669-21456-1-git-send-email-victor.erminpour@oracle.com>
 <CAMj1kXGgYYx=9rq-Ficw3vS6FX_0nb-hRStXijh7H4zdD=+Gaw@mail.gmail.com>
 <aee6c7cc-24c7-2822-47d5-1e05413a8024@oracle.com>
 <CAMj1kXFF3gR+LyE1VbLuwnRA3CzQtF90mv7rpw9x2RcyugO1JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFF3gR+LyE1VbLuwnRA3CzQtF90mv7rpw9x2RcyugO1JA@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Apr 11, 2020 at 08:39:00AM +0200, Ard Biesheuvel wrote:
> On Sat, 11 Apr 2020 at 00:12, Victor Erminpour
> <victor.erminpour@oracle.com> wrote:
> >
> >
> >
> > On 4/10/20 1:09 AM, Ard Biesheuvel wrote:
> > > On Thu, 9 Apr 2020 at 23:44, Victor Erminpour
> > > <victor.erminpour@oracle.com> wrote:
> > >>
> > >> Enable the __efistub_global define to place variables in the
> > >> .data section for both CONFIG_ARM and CONFIG_ARM64.
> > >>
> > >> This places the EFIstub sys_table variable and other EFIstub
> > >> static variables in the .data section for both CONFIG_ARM and
> > >> CONFIG_ARM64.
> > >>
> > >
> > > What does that achieve?
> >
> > Hi Ard,
> >
> > Without placing these global variables in .data, I get the
> > following errors when booting an ARM64 EFI system:
> >
> > EFI stub: ERROR: Exit boot services failed.
> > EFI stub: ERROR: Failed to update FDT and exit boot services
> >
> 
> Which boot loader are you using? Does this involve shim?
> 
> Also, does it help if you add 'efi=no_disable_early_pci_dma'?
> 
> 
> >
> > I know that the ARM64 linker script is supposed to put the
> > .init.bss into the .init.data section, but I don't think this
> > is happening for all systems.
> >
> > Having it explicitly enabled for CONFIG_ARM64 worked for me.
> >
> 
> OK, thanks for the report. However, we will be removing
> __efistub_global entirely during the next cycle, so this is not the
> right fix.

Victor, can you attach your kernel configuration and the output of
	objdump -t drivers/firmware/efi/libstub/lib.a
on the non-working kernel and the working kernel?

Also, is this failing with the latest git kernel or some other version?

Thanks.
