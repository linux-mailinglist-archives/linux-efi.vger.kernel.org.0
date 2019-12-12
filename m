Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA7711D909
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 23:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfLLWIx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 17:08:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43761 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbfLLWIx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 17:08:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so4418542wre.10
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 14:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zVlaiJaZgrAKfX7GWpNeUHj/DFAQGOtpzGJ9kkSSsY=;
        b=Pk4zsz7yNsVNX+R4JV4Fsk+TbLY97k3dDEaUTsOqc4+4WfTMPXX88mK+L/wJltTV8h
         wZsiXpa5WdD8NdAVWMq6mwChZv9avL3JA8fF/fdOHHQNedvkratDVamOrT6hCd1RVunK
         cLkddCNhsc8hR8s6Lf2t3z3RqeBq9Pksulzjp8KoiaXYj9Unau7vLYmW5W1FhDQqyjxl
         vFUwCpeXFpfY+pQerKe033eMtcS6YeHDuqz+spvsCja2+eLlDdnFb5twuU3cXzC/SsAl
         My/8NrGH9Hmxt0dBIvvc2U/YHD6kYF8JQc4BoxBXGIhkXwWyyXW8cLzRPNN7mZ1bJVVU
         iOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zVlaiJaZgrAKfX7GWpNeUHj/DFAQGOtpzGJ9kkSSsY=;
        b=n7LdWRMWp15DlOYczsCzjPlUEumWyiS1VZmWDNbRNuYm4vWryqsc0DwtK99FNQvver
         k4waDawaAnNJ/L8+2Oy9IaAsEp4Zgk002cYfDm8o8Tz2TcS9lbGzsmVFb6a2eBR6Ymrn
         byvw8bbQhqJt8iimBXHuw8QTMPFjBipOLYjch44YQc8/ghvwUGTabDYz2FL72EviU9k5
         mqv9M2Z6vvA3NNRea0UpxyMYdOL3MksbmQdnV5auSdVVTRnTUlTcnqUrj8GFNqhm4Ex/
         W0pMaoXYc8MCwhyHowFmtJlPKd00rw/287URXvpPkmMz1tGuHgFsNyuVRNeTOR4L8uof
         7mqQ==
X-Gm-Message-State: APjAAAUvM6YslZ313xFZ7dR+KBbbNxPihoUiMrNsRCf1hxPx9ZguS/L+
        7RmMPngIAeJEZJlKdf5HCTcZGST2JLZ5ERb25zb9bA==
X-Google-Smtp-Source: APXvYqwB2qchByZr4MnMJet2TTG1xb/f5eJTa057JT+aZsMSSPBVlwyWEyjPuJ10uDOibhve9k5q0Q7AowQ6gHQAvHQ=
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr8345579wrj.325.1576188531142;
 Thu, 12 Dec 2019 14:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20191212213443.24128-1-nivedita@alum.mit.edu>
In-Reply-To: <20191212213443.24128-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 12 Dec 2019 22:08:49 +0000
Message-ID: <CAKv+Gu_EDan06Cm+LC3Rr8RZhrGsRELwLQWUOLHyzhToenuG8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] efi/gop: Merge 32/64-bit code
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Arvind,

On Thu, 12 Dec 2019 at 22:34, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> This series unifies the 32-bit and 64-bit firmware functions in gop.c.
>
> Patches 1, 2 and 5 are bugfix/cleanup. The merge is in patches 3/4.
>

Which tree are these patches based on? I get a conflict applying #3

> Patch 1 removes __packed from the GOP structures, which is wrong but
> didn't impact their layout.
>
> The UEFI spec differs from the standard gcc layout for 32-bit systems,
> in that it specifies 64-bit alignment for 64-bit members. We have a bit
> of a mix in the type definitions currently, with different types doing
> one of the below:
>         (a) nothing, if a 64-bit member happens to fall naturally on a
>             64-bit boundary
>         (b) explicit padding fields
>         (c) use of __aligned_u64
> The last method is the only one that gets the alignment requirement of
> the structure itself correct as well as the internal layout -- is it
> worth fixing everything to use it?
>

Absolutely.


> Patch 5 is to make sure that we don't wind up with a >4G framebuffer on
> a 32-bit kernel that can only address 4G. I'm not sure if this can
> practically happen on anything that we can run a 32-bit kernel on, but
> UEFI specs the framebuffer physical address to be 64-bit even on 32-bit
> systems, so I figured we might as well cover this edge case.
>

This cannot happen. The 32-bit kernel can only run on 32-bit firmware,
which cannot create mappings above 4 GB, so in that case, fb_base is
guaranteed to be 32-bit addressable.



> For the code merge, formatting is a bit annoying as the types are named
> "graphics_output_protocol", which is overly long to let code fit nicely
> into 80 columns. I've used an intermediate macro to address that
> somewhat. Alternatively, would renaming the types to use just "gop" be
> acceptable?
>
> Arvind Sankar (5):
>   efi/gop: Remove bogus packed attribute from GOP structures
>   efi/gop: Remove unused typedef
>   efi/gop: Convert GOP structures to typedef and cleanup some types
>   efi/gop: Unify 32/64-bit functions
>   efi/gop: Check that the framebuffer will be accessible
>
>  drivers/firmware/efi/libstub/gop.c | 150 ++++++-----------------------
>  include/linux/efi.h                |  50 +++++-----
>  2 files changed, 50 insertions(+), 150 deletions(-)
>
> --
> 2.23.0
>
