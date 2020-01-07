Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28ED9132E07
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 19:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgAGSKt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 13:10:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53085 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGSKt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 13:10:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so533125wmc.2
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 10:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDZ9BBivpyPcbl9dA0+tXJ7LKzDyFBgtyLBwpRhLmnE=;
        b=JJMQh/SjDKyGJ9ILfXeq8XfRpR6GA7f/KeNcGZbD6UnNpYMMLNMCEwUzP1LV647mlw
         zL/StMg4ApGbG5QwQc+MQpIXXAkKjBsVv0jhQQlAyaZf0O6Wy3IW38HviXCJQpUriuW4
         o4IQvFD+ciL3kTGo2bnMSW7IEHhHAX1A+Yya3C0hMma1+byP2gm1sng6UKal8Cb8231n
         +uLg+lkSZpOoxm1ljQkNmdbXlMJ4Z3qn7pEyy+DI7cOu1o9LQsBfgSOgJgvmijgg5LgP
         kpfCxudot96FhALGqpl9hbvYs37tKbiu5BHT/+Yy5oOks5FU9IKnEfvjaeNUOz26YYWO
         KzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDZ9BBivpyPcbl9dA0+tXJ7LKzDyFBgtyLBwpRhLmnE=;
        b=YVU4ALIMYO3Kp57BarL/6CJ8NhuxiqM5V96TukDNvuckwwy5jVN2zbKo6jVY0FxI2D
         l8ox0oH6ItHLA7CoNUMa12V6mCdTQ/OkYDFNo/EzvaWHwJWUNWOjP5ht+AxMhfi5zeAt
         5fJP478ErsKhd7ef/OXclO0N2YEw1oT+Ulso6Od1aiFE1XvhUwiEmoDtiEIVxntHvnJN
         kKvzr9Pp01aWfU3XsAkmTTdINim9fWSTWQXRBsQGKm9v5eBtRlnbO4IbJ+jPB4QLqGEb
         BDYr7vX3/CR58TeHD/Q94orzpUJ8WQ+xbR012MvlN7T3dCPUlbpauoCa0+h7795Vl5Lf
         607g==
X-Gm-Message-State: APjAAAX/Dgxu/n+8gw1fSjG/cAthxBDDOzTuqTvlGyIs2BXxLh05ctox
        Ws8kz/tjwvVvflqP8ojVQsGJAdWjDhFX7bPm6FzKMy/k3CE=
X-Google-Smtp-Source: APXvYqxaRQo+mdbEnSwXV155lbcc42QPhFMZU6Psa0DR5ccSHPujNZ2SPtL0lALdrzXFD+pZZgAIDE6ZYDKCwBxJCGk=
X-Received: by 2002:a1c:a795:: with SMTP id q143mr330492wme.52.1578420646888;
 Tue, 07 Jan 2020 10:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20200107135500.644618-1-nivedita@alum.mit.edu>
 <CAKv+Gu8HE-QJBpo=S_uUbqkO8BfbKyrp2+nCTxWhPVNMU1E37g@mail.gmail.com>
 <CAKv+Gu_+a4igmTHhMgg17B2oH5f=KRM2g2CBGy+LnF5wYsarng@mail.gmail.com>
 <20200107142125.GA652888@rani.riverdale.lan> <CAKv+Gu-xDaTBVKJ=9ya74giBZ=LdX2r-8-LiFJWzcUofthGv7w@mail.gmail.com>
 <20200107142732.GB652888@rani.riverdale.lan> <CAKv+Gu8v-5DXWh5ZaY0omrVNh46TEourpcf2Hv3TrsbCUtLFng@mail.gmail.com>
 <20200107175829.GA1599060@rani.riverdale.lan> <CAKv+Gu-PU=LqT7MEbSH-0GnJOdakDeaC=ANdmag6JptcfJEJtA@mail.gmail.com>
 <20200107180807.GA1642410@rani.riverdale.lan>
In-Reply-To: <20200107180807.GA1642410@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 7 Jan 2020 19:10:34 +0100
Message-ID: <CAKv+Gu8Jsen-oAvUYrrTXnLRog+iHsLf0s6EMJ9smgUXpzncZw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Jan 2020 at 19:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Jan 07, 2020 at 06:59:57PM +0100, Ard Biesheuvel wrote:
> > On Tue, 7 Jan 2020 at 18:58, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Tue, Jan 07, 2020 at 03:28:31PM +0100, Ard Biesheuvel wrote:
> > > >
> > > > Unfortunately, the command line option implements a weaker form of
> > > > visibility than the pragma, so it probably comes down to setting the
> > > > pragma in a .h file that gets -include'd via the command line so it is
> > > > guaranteed to be seen first.
> > >
> > > Tried hacking that in and it works, tested with gcc 4.6.4.
> >
> > Excellent. But in my testing locally, I don't get any GOT entries in
> > the first place, strangely enough. So what changes in the output for
> > you with visibility hidden compared to before?
>
> Works with 32-bit as well.
>
> Are you checking libstub or boot/compressed? Below is with gcc 4.6 (but
> latest binutils). With gcc 9, there's only one left -- trampoline_32bit_src
> in pgtable_64.
>

I am looking at the size of the .got section in
boot/compressed/vmlinux, and it is 0x0 on 64-bit, and 0xc (i.e., only
the .got.plt fixup code) on 32-bit.

Could you please check whether passing -Bsymbolic to the linker gives
the same result btw?


> acpi.o
> 000000000000025b R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
> cmdline.o
> 00000000000001d3 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
> 00000000000001f3 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
> 0000000000000223 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
> cpuflags.o
> 00000000000000a3 R_X86_64_REX_GOTPCRELX  cpu_vendor-0x0000000000000004
> 00000000000000c5 R_X86_64_REX_GOTPCRELX  cpu-0x0000000000000004
> 0000000000000127 R_X86_64_REX_GOTPCRELX  cpu-0x0000000000000004
> 0000000000000144 R_X86_64_REX_GOTPCRELX  cpu-0x0000000000000004
> 0000000000000153 R_X86_64_REX_GOTPCRELX  cpu-0x0000000000000004
> 000000000000017b R_X86_64_REX_GOTPCRELX  cpu-0x0000000000000004
> early_serial_console.o
> 000000000000005a R_X86_64_REX_GOTPCRELX  early_serial_base-0x0000000000000004
> 0000000000000165 R_X86_64_REX_GOTPCRELX  early_serial_base-0x0000000000000004
> eboot.o
> efi_thunk_64.o
> error.o
> head_64.o
> kaslr_64.o
> 00000000000001e7 R_X86_64_REX_GOTPCRELX  ptrs_per_p4d-0x0000000000000004
> 0000000000000372 R_X86_64_REX_GOTPCRELX  __default_kernel_pte_mask-0x0000000000000004
> 000000000000038b R_X86_64_REX_GOTPCRELX  pgdir_shift-0x0000000000000004
> 00000000000003ac R_X86_64_REX_GOTPCRELX  __pgtable_l5_enabled-0x0000000000000004
> 000000000000040a R_X86_64_REX_GOTPCRELX  __pgtable_l5_enabled-0x0000000000000004
> 00000000000004db R_X86_64_REX_GOTPCRELX  __force_order-0x0000000000000004
> 00000000000004f2 R_X86_64_REX_GOTPCRELX  __pgtable_l5_enabled-0x0000000000000004
> 0000000000000517 R_X86_64_REX_GOTPCRELX  _pgtable-0x0000000000000004
> 00000000000005f3 R_X86_64_REX_GOTPCRELX  __force_order-0x0000000000000004
> kaslr.o
> 0000000000000281 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
> 00000000000003e3 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
> 0000000000000ba1 R_X86_64_REX_GOTPCRELX  __force_order-0x0000000000000004
> 0000000000000bb4 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
> 0000000000000cc8 R_X86_64_REX_GOTPCRELX  free_mem_ptr-0x0000000000000004
> 0000000000000cd2 R_X86_64_REX_GOTPCRELX  free_mem_end_ptr-0x0000000000000004
> 0000000000000d6e R_X86_64_REX_GOTPCRELX  free_mem_ptr-0x0000000000000004
> 0000000000000f63 R_X86_64_REX_GOTPCRELX  __pgtable_l5_enabled-0x0000000000000004
> kernel_info.o
> mem_encrypt.o
> misc.o
> 0000000000000015 R_X86_64_REX_GOTPCRELX  free_mem_ptr-0x0000000000000004
> 000000000000001f R_X86_64_REX_GOTPCRELX  free_mem_end_ptr-0x0000000000000004
> 0000000000002965 R_X86_64_REX_GOTPCRELX  early_serial_base-0x0000000000000004
> 0000000000002a43 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
> 0000000000002b8e R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
> 0000000000002bec R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
> 0000000000002c10 R_X86_64_REX_GOTPCRELX  free_mem_end_ptr-0x0000000000000004
> 0000000000002c17 R_X86_64_REX_GOTPCRELX  free_mem_ptr-0x0000000000000004
> 0000000000002d16 R_X86_64_REX_GOTPCRELX  trampoline_32bit-0x0000000000000004
> 0000000000002f97 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
> 0000000000002fea R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
> pgtable_64.o
> 000000000000000d R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
> 000000000000010a R_X86_64_REX_GOTPCRELX  trampoline_32bit_src-0x0000000000000004
> 0000000000000191 R_X86_64_REX_GOTPCRELX  __force_order-0x0000000000000004
> 0000000000000376 R_X86_64_REX_GOTPCRELX  __force_order-0x0000000000000004
> piggy.o
> string.o
