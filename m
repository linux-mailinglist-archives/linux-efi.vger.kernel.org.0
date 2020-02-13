Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44AEA15C9C3
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 18:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBMRz6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 12:55:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgBMRz6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Feb 2020 12:55:58 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D4E6217F4
        for <linux-efi@vger.kernel.org>; Thu, 13 Feb 2020 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581616557;
        bh=eBn48RkWFOmXTP4xg1mIIwtc1jP4EojXHNp7TaO0m/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KFCzYOczsjq+kBkQDR7lLUac+yQiOtIc5gJ5tK9Hfdlx5ii/omkX6CkRv2Wr8Wcw4
         pU7uWRV2BXSL13rZsL2FUf4JIGljs6zoGB0QQUEgFwR3A9O0a3xbLsU0UUTbPpNaL9
         8KRysDIm3qrZXqtAHtykFf1Ud6tl2NjzjMZ7r5Lg=
Received: by mail-wm1-f46.google.com with SMTP id s10so7253582wmh.3
        for <linux-efi@vger.kernel.org>; Thu, 13 Feb 2020 09:55:57 -0800 (PST)
X-Gm-Message-State: APjAAAVlvsGWR+9b09o7YTfbi4foM2omuN5pxlN+vRJTxwUEEYROBKmi
        xVTEiLb+Bt6VpkMmVN512FONlcvfEhvY8OU8U5RVCA==
X-Google-Smtp-Source: APXvYqxkXN2CIAf2aC7refb37+UVsi8JAdMu5gJuMLkRSo5ntGwEehvYEsUR6yzmsI2vLynMERovPTskrlAB1zcipPg=
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr6781840wma.62.1581616555626;
 Thu, 13 Feb 2020 09:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20200213145928.7047-1-ardb@kernel.org> <20200213175317.GC1400002@rani.riverdale.lan>
In-Reply-To: <20200213175317.GC1400002@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 13 Feb 2020 17:55:44 +0000
X-Gmail-Original-Message-ID: <CAKv+Gu-78w=gs+D-eS5iBX7e3zL57XBOe1vdW=Bkk=EcA+_FQA@mail.gmail.com>
Message-ID: <CAKv+Gu-78w=gs+D-eS5iBX7e3zL57XBOe1vdW=Bkk=EcA+_FQA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] efi/x86: add support for generic EFI mixed mode boot
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Brown <mbrown@fensystems.co.uk>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 13 Feb 2020 at 18:53, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Feb 13, 2020 at 03:59:25PM +0100, Ard Biesheuvel wrote:
> > This series is another part of my effort to reduce the level of knowledge
> > on the part of the bootloader or firmware of internal per-architecture
> > details regarding where/how the kernel is loaded and where its initrd and
> > other context data are passed.
> >
> > The x86 architecture has a so-called 'EFI handover protocol', which defines
> > how the bootparams struct should be populated, and how it should be
> > interpreted to figure out where to load the kernel, and at which offset in
> > the binary the entrypoint is located. This scheme allows the initrd to be
> > loaded beforehand, and allows 32-bit firmware to invoke a 64-bit kernel
> > via a special entrypoint that manages the state transitions between the
> > two execution modes.
> >
> > Due to this, x86 loaders currently do not rely on LoadImage and StartImage,
> > and therefore, are forced to re-implement things like image authentication
> > for secure boot and taking the measurements for measured boot in their open
> > coded clones of these routines.
> >
> > My previous series on this topic [0] implements a generic way to load the
> > initrd from any source supported by the loader without relying on something
> > like device trees or bootparams structures, and so native boot should not
> > need the EFI handover protocol anymore after those change are merged.
> >
> > What remains is mixed mode boot, which also needs the EFI handover protocol
> > regardless of whether an initrd is loaded or not. So let's get rid of that
> > requirement, and take advantage of the fact that EDK2 based firmware does
> > support LoadImage() for X64 binaries on IA32 firmware, which means we can
> > rely on the secure boot and measured boot checks being performed by the
> > firmware. The only thing we need to put on top is a way to discover the
> > non-native entrypoint into the binary in a way that does not rely on x86
> > specific headers and data structures.
> >
> > So let's introduce a new .compat header in the PE/COFF metadata of the
> > bzImage, and populate it with a <machine type, entrypoint> tuple, allowing
> > a generic EFI loader to decide whether the entrypoint supports its native
> > machine type, and invoke it as an ordinary EFI application entrypoint.
> > Since we will not be passing a bootparams structure, we need to discover
> > the base of the image (which contains the setup header) via the loaded
> > image protocol before we can enter the kernel in 32-bit mode at startup_32()
> >
> > A loader implementation for OVMF can be found at [1]. Note that this loader
> > code is fully generic, and could be used without modifications if other
> > architectures ever emerge that support kernels that can be invoked from a
> > non-native (but cross-type supported) loader.
> >
> > [0] https://lore.kernel.org/linux-arm-kernel/20200206140352.6300-1-ardb@kernel.org/
> > [1] https://github.com/ardbiesheuvel/edk2/commits/linux-efi-generic
> >
>
> As an alternative to the new section, how about having a CONFIG option
> to emit the 64-bit kernel with a 32-bit PE header instead, which would
> point to efi32_pe_entry? In that case it could be directly loaded by
> existing firmware already. You could even have a tool that can mangle an
> existing bzImage's header from 64-bit to 32-bit, say using the newly
> added kernel_info structure to record the existence and location of
> efi32_pe_entry.
>

That wouldn't work with, say, signed distro kernels.

> Also, the PE header can live anywhere inside the image, right? Is there
> any reason to struggle to shoehorn it into the "boot sector"?

It cannot. It must live outside a region described by the section headers.
