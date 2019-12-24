Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAFF129E78
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 08:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfLXHiq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 02:38:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46766 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfLXHiq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Dec 2019 02:38:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so18999306wrl.13
        for <linux-efi@vger.kernel.org>; Mon, 23 Dec 2019 23:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZccYSuHYnQu3yCdgRMWBrwDcVVqiwPAPicsqL0eZEU=;
        b=Dw+J3Qe3d2g7awjoTf+RDK2l/slw1HWg4XhsJFH5gV4mInkHqYAQMVB98f9Hk6Cxug
         6bM10+9dODOvp30z6skQhYCWySo0aO4FVWWbKt3iOHYtSLFgJsDnUlbJwiOym5RfDMmR
         nx0IAlOi8S7mKWDE1m6Of7YDWQlWanPVHpvEu+rkeNgLZxouWFheDuU1u9rFTXaBtiw9
         S7eQYTKu+B+8P2+5FC5UjFiEEpOSrMzUxVXjx5DDqJIikyAY4XWbvWpsP6jytR5rWEzN
         kd6t8fnBE78VkdqlFLtPV2phA+lZgCw6Q/CaFJQKMtxr4/rrCIdONuAK3H9ZpWZ+FiDs
         VbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZccYSuHYnQu3yCdgRMWBrwDcVVqiwPAPicsqL0eZEU=;
        b=qOYiWRcB+4earJb2806CpqXUDWacLZhmpK22jXSPIZxKLLP4Wibr5Zc6dXv61JTlj1
         v7E4DYjkcKD5ypQpS3DqsIkhQ7aZFkr2TicOZL2UgvAY1DDFz5OmvYIqUBnCOuhz9LJB
         0GIB+cfaZ+VmzYIAVkzUyGmrndSkwa2d3CtoVzdIfCh3FYz/5wQpbHe8oDrRHx5A3ENr
         cO6ZBS3VsatnpKyjJ8senr+W4wKikKomtS5e/ahN/indQfl0J9mLpZDNRsj3QmHiK4cG
         hjFsrQgLmQov0vIvhHQRis4818wLUg/sKBVl9yx1eHzFuFGpOQ17CqPKQHT+Uv5Bb6dQ
         EgCw==
X-Gm-Message-State: APjAAAXNUXbWgmUpRYU29xwlr4ZBrNhskTnHrRmZNldZjx6km2k5BLUd
        kLTv90vz7uKJwjKOAXplA60kjXKmxdiPDfMMkAaonw==
X-Google-Smtp-Source: APXvYqw5uBnxMoq5BDGxRbot2GSVlmqPiSb7fhY55rIrsGk7ze7NDCs1R/UvUSqHmS89dMah+w2mgkaVkig8L//kUsA=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr31733183wrr.32.1577173124203;
 Mon, 23 Dec 2019 23:38:44 -0800 (PST)
MIME-Version: 1.0
References: <20191223152157.68545-1-ardb@kernel.org> <CALCETrXV1jbdvUMACdXiYuVyxxZUb1FByLPXLfwrooT-8N0Gpw@mail.gmail.com>
In-Reply-To: <CALCETrXV1jbdvUMACdXiYuVyxxZUb1FByLPXLfwrooT-8N0Gpw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 24 Dec 2019 08:38:43 +0100
Message-ID: <CAKv+Gu9B4+MGP7gqpSiaYMaGG5u1K9D1nQ2sTvTt50qPhvwQFg@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: disable paging at mixed mode entry
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, X86 ML <x86@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 24 Dec 2019 at 03:15, Andy Lutomirski <luto@amacapital.net> wrote:
>
> On Mon, Dec 23, 2019 at 7:23 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > The EFI mixed mode entry code goes through the ordinary startup_32()
> > routine before jumping into the kernel's EFI boot code in 64-bit
> > mode. The 32-bit startup code must be entered with paging disabled,
> > but this is not documented as a requirement for the EFI handover
> > protocol, and so we should disable paging explicitly when entering
> > the kernel from 32-bit EFI firmware.
>
> Does this mean that EFI is allowed to call the kernel with paging on
> but the text identity-mapped?

Yes. This is explicitly mentioned in the spec. Paging may be on or
off, but all memory must be mapped 1:1

>  Have you seen this happen in practice?
>

Yes. GRUB and OVMF both implement the EFI handover protocol, but OVMF
doesn't disable paging before calling the 32-bit entry point, and so
it explodes in startup_32(). GRUB calls the EFI handover entrypoint
with paging disabled, and so then everything works fine.

> If the kernel is entered with paging on and the text not
> identity-mapped, this is going to blow up badly.
>

Not just text: all of system memory is guaranteed to be 1:1 mapped if
paging is on when entering the kernel from EFI, so this should be
safe.
Note that this change only affects mixed mode configurations that use
OVMF instead of GRUB.

We are using OVMF/qemu in kernelCI for test coverage of the EFI stub
for all architectures, and this is the missing puzzle piece to get it
working in x86 mixed mode as well.
