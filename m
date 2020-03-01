Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78ECD174F5F
	for <lists+linux-efi@lfdr.de>; Sun,  1 Mar 2020 21:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgCAUAi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 15:00:38 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45302 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgCAUAi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 15:00:38 -0500
Received: by mail-qt1-f194.google.com with SMTP id a4so12312qto.12
        for <linux-efi@vger.kernel.org>; Sun, 01 Mar 2020 12:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c+F+wlqGzMoVE2eRUr2Al/MVfpWMoI3CqyWecCvq+rc=;
        b=mq6ppiWh/ehsQcH5CDYy/yjUGd13ahaeKMMeKwEl6kvqB35fuJglBnaYmsk8csmSqC
         3Ier2KmLxFwACI0f9FpBLhP13QN1xjjigagXCbfdoTga7Rblr5EXf8dhU3JKk5rV7XND
         ITb7BxmNybUMFUyB+Y4acJGtmkn6ANUHXHDA5Xvl/prYSR7fUUDsEDxQiW2auVNEI45d
         4nw671ZpHL1JnVbQzQ4sjFMtxcXYq4tf9RsQDJ5LkZZAEQGDQoRe9HY6LWCk6OOifoh8
         TCccfvDttXRJYm5I2Rn8Z7l0c+7erVrf0z2RaLTGoGBMER4P/zxn3kVq2fmKLtT0QQ3X
         sprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=c+F+wlqGzMoVE2eRUr2Al/MVfpWMoI3CqyWecCvq+rc=;
        b=qx/JuewGLmk06oxk21y6YIfWG785ImoW+0QzHB16W9Zn6LfMvH8a/cVSZLKhW1lP3F
         tc4LBWi6Iw6e2JXuFi384SLbpq+2fpFxyksyfaoEI6lVJ3m/2V0lUNdD4pg+mou8Vv5h
         xq26ekETicJyQLiT7ozAj1MbFDIO/b1mg7ARwsw88KzeJZAEJDaKMFdl0g6F5rX2IrWH
         C6TIKkqPDiNdY+WtF4P00hz4TKOseSsCOLH67hIE4eihzDoMneD8Te/9FOfWUuv9ZFih
         zT0II/blNDWbkJVRWHdB36jqRrImBtJFXNRwZ/IcWRf8da7KBkt0LUgZB1SWTk+NUIc3
         U+vg==
X-Gm-Message-State: APjAAAXFSKL/T4c2Mkic0/Sif8KkI/19ggY9LuYYEVHq825eQb9fhvKi
        Fs89r80H21Rg4dY9ZtpqUWRJz/KeS5Y=
X-Google-Smtp-Source: APXvYqzRgd3GOfks8DF8S5dd8vtyyAcVmOyvdQSvMLo0PNRgSpAmZlUT/nUxoy+Zgmgx9ijgmIAcXQ==
X-Received: by 2002:ac8:4a16:: with SMTP id x22mr12925904qtq.339.1583092837364;
        Sun, 01 Mar 2020 12:00:37 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 11sm8679959qko.76.2020.03.01.12.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 12:00:37 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 1 Mar 2020 15:00:35 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 0/6] efi/x86: add support for generic EFI mixed mode
 boot
Message-ID: <20200301200035.GA2031375@rani.riverdale.lan>
References: <20200222155519.23550-1-ardb@kernel.org>
 <20200301171509.GA1845222@rani.riverdale.lan>
 <20200301172248.GA1851857@rani.riverdale.lan>
 <CAKv+Gu_N3vbea79CAQNZn6DmKBsKOhT9ucQYgBf0_8Pnd+vz2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_N3vbea79CAQNZn6DmKBsKOhT9ucQYgBf0_8Pnd+vz2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Mar 01, 2020 at 08:36:42PM +0100, Ard Biesheuvel wrote:
> On Sun, 1 Mar 2020 at 18:22, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sun, Mar 01, 2020 at 12:15:10PM -0500, Arvind Sankar wrote:
> > > What I'm doing is creating an x86-64 defconfig based on tip:efi/core,
> > > and then running it via
> > >
> > > $ qemu-system-x86_64 -cpu Haswell -pflash qemu/OVMF_64.fd \
> >                                                  ^^^^^^^
> > That OVMF_64.fd is incorrect copy/paste from a different run, the panic
> > case is using OVMF-mixed-mode-compat-section.fd.
> > >   -drive file=fat:rw:qemu/boot -nographic -m 3072
> 
> Thanks for the patch. Interestingly, I don't even make it to the point
> where it crashes, and I end up in an ASSERT() in the firmware:
> 
> ASSERT_EFI_ERROR (Status = Not Found)
> ASSERT /home/ardbie01/build/edk2/MdeModulePkg/Universal/ReportStatusCodeRouter/RuntimeDxe/ReportStatusCodeRouterRuntimeDxe.c(347):
> !EFI_ERROR (Status)
> 
> which appears to be a result of the fact that the memory map passed to
> SetVirtualAddressMap() does not cover some function pointer that gets
> converted in that code.
> 
> I don't remember - does mixed mode even work in general with 3 GB of memory?

Oh -- is there some option to enable debugging assertions? I did see
that it crashed somewhere inside SetVirtualMap (i.e. we called it and
it never returned).

For some reason, with nokaslr on the command line, I can't get this to
crash. All the addresses seem to be within 4Gb, so it ought to work, no?
