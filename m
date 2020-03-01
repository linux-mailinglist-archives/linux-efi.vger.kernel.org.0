Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F69174F3A
	for <lists+linux-efi@lfdr.de>; Sun,  1 Mar 2020 20:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgCATgz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 14:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgCATgz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 1 Mar 2020 14:36:55 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0424246C2
        for <linux-efi@vger.kernel.org>; Sun,  1 Mar 2020 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583091415;
        bh=9EbcqOHs6e5JkfaglqgzblxMXB/mx7GNfAODMkSvsQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BK/eFOzHUMog9+t+v02tZhnhwgo7PErEWeR9V2GfdcYmfClzziwtH7HjbPIuJHY37
         gwqvFhA2Ke7G1BKCqLaRxdxx+n7YkhQvvBdrX219M5gJGD+JB/0OsHQjF2Yv1czfRQ
         Y9UzmM24lABiRCAci+aaRbajYG0ZGyvvjOpnOt90=
Received: by mail-wm1-f53.google.com with SMTP id g83so6457830wme.1
        for <linux-efi@vger.kernel.org>; Sun, 01 Mar 2020 11:36:54 -0800 (PST)
X-Gm-Message-State: ANhLgQ2TT7ut0k7z0LLDpTn5qGwE6ifCuH0rRumqjjnTjhOELUjE+KsX
        O+13xRRI3sgAkBHkeBewJueSAGxNnjCZmwDIOT91+Q==
X-Google-Smtp-Source: ADFU+vt+LrB/wZglQzGGv3VdITPdinzHstFbh8NRzDd0+IwwckJz1BQuVbTFVlmDaQj8KDxQr3LJuMJYZNZtQ9NqdK4=
X-Received: by 2002:a1c:2d88:: with SMTP id t130mr2846387wmt.68.1583091413175;
 Sun, 01 Mar 2020 11:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20200222155519.23550-1-ardb@kernel.org> <20200301171509.GA1845222@rani.riverdale.lan>
 <20200301172248.GA1851857@rani.riverdale.lan>
In-Reply-To: <20200301172248.GA1851857@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 1 Mar 2020 20:36:42 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_N3vbea79CAQNZn6DmKBsKOhT9ucQYgBf0_8Pnd+vz2g@mail.gmail.com>
Message-ID: <CAKv+Gu_N3vbea79CAQNZn6DmKBsKOhT9ucQYgBf0_8Pnd+vz2g@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] efi/x86: add support for generic EFI mixed mode boot
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 1 Mar 2020 at 18:22, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sun, Mar 01, 2020 at 12:15:10PM -0500, Arvind Sankar wrote:
> > What I'm doing is creating an x86-64 defconfig based on tip:efi/core,
> > and then running it via
> >
> > $ qemu-system-x86_64 -cpu Haswell -pflash qemu/OVMF_64.fd \
>                                                  ^^^^^^^
> That OVMF_64.fd is incorrect copy/paste from a different run, the panic
> case is using OVMF-mixed-mode-compat-section.fd.
> >   -drive file=fat:rw:qemu/boot -nographic -m 3072

Thanks for the patch. Interestingly, I don't even make it to the point
where it crashes, and I end up in an ASSERT() in the firmware:

ASSERT_EFI_ERROR (Status = Not Found)
ASSERT /home/ardbie01/build/edk2/MdeModulePkg/Universal/ReportStatusCodeRouter/RuntimeDxe/ReportStatusCodeRouterRuntimeDxe.c(347):
!EFI_ERROR (Status)

which appears to be a result of the fact that the memory map passed to
SetVirtualAddressMap() does not cover some function pointer that gets
converted in that code.

I don't remember - does mixed mode even work in general with 3 GB of memory?
