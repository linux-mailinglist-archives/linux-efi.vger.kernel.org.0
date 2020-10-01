Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A69E280927
	for <lists+linux-efi@lfdr.de>; Thu,  1 Oct 2020 23:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbgJAVHf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Oct 2020 17:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgJAVHT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Oct 2020 17:07:19 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B4C0613D0;
        Thu,  1 Oct 2020 14:07:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 5so5024307pgf.5;
        Thu, 01 Oct 2020 14:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ItqIz6gXnh77/Vt2ZHDHcdf0vLA3J3R86d0HFs2hxss=;
        b=ebxxJDPj/tvbS24ml8ZXMKFMOcecgfeBF7qk10srMX+oBQ38MoQGwEfoDCkk1XFDTf
         sMHwM1gF3VedZTaQE1scSLDcdNnRASo/Qt/OsAe4qHLX2g69R+pxwgO9+V3Kv801Bqry
         7bUqgK80b8dIuamzcqtslLPYxPEc3ilBAcVtjXgJYuP81z2HLFRwmb+haB7o/FZxj/Jv
         HSX8ZZuuYhaz8V90/qARmSrZVVqzhqej01C+AzsjRm9uypUkbK25JTjySehoXo8OFJNS
         zgkoUG0+xc9TaUar/mt8YRhTN/LTGiEmSBB3yHTDB5hukDtq1vapCLXKgbTBLoWD2Yeg
         p8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ItqIz6gXnh77/Vt2ZHDHcdf0vLA3J3R86d0HFs2hxss=;
        b=UGYxKwuhnxkgP5K9s6Mcj7R9Xr5vHOBY+Nl6u7AqeZ/3mPbXjjeWcZprc1LtpEeCHn
         GbTrizuJ8RRbTDff9UfLzQ9j++iEPVqXsWAjvYAKU7Pths6SDYmZGMClOGYKnRg+k+vc
         pn4hBfvJpNuEcbjTPq0L2sYOeRIAMymq/PNJkDKhgDLp1kZcmU4OUTUirORKyZOUCnhR
         yfGSaoI5qNZoMoCLNWFRozBPQeH10jaf0B9H7iwK5QUcERZyXyvB9onDG0SDe4+TRuT4
         sABwHWxS82nH/RMF9MZqPwICUG/phQze8ZQiwzxgVC+KAvbOZG4tDqM6QgX9lDlgmAXR
         QFqA==
X-Gm-Message-State: AOAM532BAftBXgggC6M8we8vIccB6RCxpF7+7dDl1MWS3iZxeZ3LLOOD
        XWZfSp/bmseiIrVT26k8q/KWJyyvGmwM5Q==
X-Google-Smtp-Source: ABdhPJwtlJGYi3KdBqkN8QjF/BYyhY0405HXOyyT6gd5JOL9IIz8WwMUAMTSQlA+2TSKM7IlF2+0Kg==
X-Received: by 2002:a63:161e:: with SMTP id w30mr7496776pgl.255.1601586438657;
        Thu, 01 Oct 2020 14:07:18 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45e1:2200::1])
        by smtp.gmail.com with ESMTPSA id 14sm724389pjn.48.2020.10.01.14.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 14:07:17 -0700 (PDT)
Date:   Thu, 1 Oct 2020 14:07:16 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Lenny Szubowicz <lszubowi@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>, prarit@redhat.com
Subject: Re: [PATCH V2 1/3] efi: Support for MOK variable config table
Message-ID: <20201001210716.GA3767489@ubuntu-m3-large-x86>
References: <20200905013107.10457-1-lszubowi@redhat.com>
 <20200905013107.10457-2-lszubowi@redhat.com>
 <20201001174436.GA2622286@ubuntu-m3-large-x86>
 <CAMj1kXFoCsO3YqvTZx4nU4mQOhoux1iS1vsa73AZhtc5Y8j59Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFoCsO3YqvTZx4nU4mQOhoux1iS1vsa73AZhtc5Y8j59Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 01, 2020 at 10:57:07PM +0200, Ard Biesheuvel wrote:
> On Thu, 1 Oct 2020 at 19:44, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > On Fri, Sep 04, 2020 at 09:31:05PM -0400, Lenny Szubowicz wrote:
> > > Because of system-specific EFI firmware limitations, EFI volatile
> > > variables may not be capable of holding the required contents of
> > > the Machine Owner Key (MOK) certificate store when the certificate
> > > list grows above some size. Therefore, an EFI boot loader may pass
> > > the MOK certs via a EFI configuration table created specifically for
> > > this purpose to avoid this firmware limitation.
> > >
> > > An EFI configuration table is a much more primitive mechanism
> > > compared to EFI variables and is well suited for one-way passage
> > > of static information from a pre-OS environment to the kernel.
> > >
> > > This patch adds initial kernel support to recognize, parse,
> > > and validate the EFI MOK configuration table, where named
> > > entries contain the same data that would otherwise be provided
> > > in similarly named EFI variables.
> > >
> > > Additionally, this patch creates a sysfs binary file for each
> > > EFI MOK configuration table entry found. These files are read-only
> > > to root and are provided for use by user space utilities such as
> > > mokutil.
> > >
> > > A subsequent patch will load MOK certs into the trusted platform
> > > key ring using this infrastructure.
> > >
> > > Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> >
> > I have not seen this reported yet but this breaks arm allyesconfig and
> > allmodconfig when CPU_LITTLE_ENDIAN is force selected (because CONFIG_EFI
> > will actually be enabled):
> >
> > $ cat le.config
> > CONFIG_CPU_BIG_ENDIAN=n
> >
> > $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- KCONFIG_ALLCONFIG=le.config allyesconfig drivers/firmware/efi/mokvar-table.o
> > drivers/firmware/efi/mokvar-table.c: In function 'efi_mokvar_table_init':
> > drivers/firmware/efi/mokvar-table.c:139:5: error: implicit declaration of function 'early_memunmap' [-Werror=implicit-function-declaration]
> >   139 |     early_memunmap(va, map_size);
> >       |     ^~~~~~~~~~~~~~
> > drivers/firmware/efi/mokvar-table.c:148:9: error: implicit declaration of function 'early_memremap' [-Werror=implicit-function-declaration]
> >   148 |    va = early_memremap(efi.mokvar_table, map_size);
> >       |         ^~~~~~~~~~~~~~
> > drivers/firmware/efi/mokvar-table.c:148:7: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
> >   148 |    va = early_memremap(efi.mokvar_table, map_size);
> >       |       ^
> > cc1: some warnings being treated as errors
> > make[4]: *** [scripts/Makefile.build:283: drivers/firmware/efi/mokvar-table.o] Error 1
> >
> > Cheers,
> > Nathan
> 
> Hi Nathan,
> 
> Does adding
> 
> #include <asm/early_ioremap.h>
> 
> to drivers/firmware/efi/mokvar-table.c fix the issue?

Indeed, that was much simpler than I thought it would be... If you send
or apply a patch, feel free to add:

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Cheers,
Nathan
