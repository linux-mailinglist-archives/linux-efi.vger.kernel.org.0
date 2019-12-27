Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF00A12B0C5
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 03:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfL0C4y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Dec 2019 21:56:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfL0C4x (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 26 Dec 2019 21:56:53 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8AAB21775
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 02:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577415413;
        bh=payQN/HRBVM+DSEMfWKg08oS9Vd+YiSH+0/rF/7x2MY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tY22BCGXN3qfL4K5s9JQV5HD5iUoN6sHUByOGEbx2L3RbFoDOTXzhM+Pw/4VZRhcq
         r380YE5+ATGP3prc9WnQNoZ5gvNdXoTyyuZ2dgb+/g7MJYNvHgvUbIXfTsS30zxLMt
         QqtZ60G1VcfXZPOBjfS7uDc8E6QsHaqeXsuvZCbE=
Received: by mail-wm1-f43.google.com with SMTP id u2so7289727wmc.3
        for <linux-efi@vger.kernel.org>; Thu, 26 Dec 2019 18:56:52 -0800 (PST)
X-Gm-Message-State: APjAAAUbF8HBBESKuGsfzOoqHJs3oMoC24XQzYHTAX2DD6OtCrqXf1Xa
        o47t99t8lwJrfFVT92tXd++jF3od8ww63GNapNn8SA==
X-Google-Smtp-Source: APXvYqyr5irnMNB5SuhxKHMIuJfzM40LH38Akir3sc/NyQXbP4oqVvBOoGCx069ySq7GdwZDkpI6bsbSSCTsRpvWMCI=
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr16803175wmg.38.1577415411215;
 Thu, 26 Dec 2019 18:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20191226151407.29716-1-ardb@kernel.org> <20191226151407.29716-4-ardb@kernel.org>
In-Reply-To: <20191226151407.29716-4-ardb@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 26 Dec 2019 18:56:37 -0800
X-Gmail-Original-Message-ID: <CALCETrWUv57ry+oy-65DSAOA62YM5okKMomFXHWgm_-5hUqTYg@mail.gmail.com>
Message-ID: <CALCETrWUv57ry+oy-65DSAOA62YM5okKMomFXHWgm_-5hUqTYg@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi/x86: simplify mixed mode call wrapper
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 26, 2019 at 7:16 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Calling 32-bit EFI runtime services from a 64-bit OS involves
> switching back to the flat mapping with a stack carved out of
> memory that is 32-bit addressable.
>
> There is no need to actually execute the 64-bit part of this
> routine from the flat mapping as well, as long as the entry
> and return address fit in 32 bits. There is also no need to
> preserve part of the calling context in global variables: we
> can simply preserve the old stack pointer in %r11 across the
> call into 32-bit firmware, and use either stack to preserve
> other values.

The %r11 trick makes me a little bit nervous.  I can imagine a 32-bit
firmware implementation clobbering r11 by one of a few means: SMM bugs
(unlikely -- this would probably kill the system even outside of an
EFI call) or, more likely, if some code module is actualy 64-bit.
Maybe we shouldn't be worried about this.  More comments below.

> diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
> index 3189f1394701..7357808d3ae8 100644
> --- a/arch/x86/platform/efi/efi_thunk_64.S
> +++ b/arch/x86/platform/efi/efi_thunk_64.S
> @@ -28,11 +28,17 @@
>  SYM_FUNC_START(efi64_thunk)
>         push    %rbp
>         push    %rbx
> +       movl    %ds, %ebx
> +       push    %rbx
> +       movl    %es, %ebx
> +       push    %rbx
> +       movl    %ss, %ebx
> +       push    %rbx

I realize that you haven't actually changed any of the below, but this
code has issues.

You don't actually need to save %ss.  Loading KERNEL_DS is fine.  0
would almost be fine, except that AMD CPUs have some oddities and the
fallout would be subtle and annoying to debug.

The kernel does not strictly guarantee that the selectors in DS and ES
are always valid.  They're fairly likely to be valid when running
syscalls, but code like this should not bet on it.  And the EFI thunk
is missing exception handlers when it reloads them.  So the right
thing to do is probably to get rid of all the segment handling in the
asm for everything except CS and to move it into C, like:

unsigned short ds, es;

/* DS and ES contain user values.  We need to save them. */
savesegment(ds, ds);
savesegment(es, es);

/* The 32-bit EFI code needs a valid DS, ES, and SS.  There's no need
to save the old SS: __KERNEL_DS is always acceptable.  */
loadsegment(ss, __KERNEL_DS);
loadsegment(ds, __KERNEL_DS);
loadsegment(es, __KERNEL_DS);

__s = efi64_thunk(...);

loadsegment(ds, ds);
loadsegment(es, es);

Want to make that change?
