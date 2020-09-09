Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189F12634B9
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 19:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgIIRfU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 13:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgIIRfS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Sep 2020 13:35:18 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD954C061755
        for <linux-efi@vger.kernel.org>; Wed,  9 Sep 2020 10:35:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so4675387ljk.0
        for <linux-efi@vger.kernel.org>; Wed, 09 Sep 2020 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqFOTGjWCbditxbgpQ8IyRDxYky7yNBzoJozO0vswEQ=;
        b=UToeSBmunsVhylm35nwGeM3cA3zsMBS6lOQy1CzptlQQ0cfeKjtMVl69HKhS9cyZNv
         E6hlL75w/Gj9vqAtBbm0k7mY8b+Qkc0oMrQbp1/HV3fORCWZ3vJrlr4FhfEWyE/IcbhB
         5R4E630CYlfnhzE+TPRPf+AKGPqSRFS7xn+jrtU9B37xL/JKM+UaDjaX6j/qITM3KbxJ
         fleUJdvhaAHMLZ+6uA2BWekQEGXX+hF94yURKXxsqVcfbW71Kd7AD7U7xiT8muglirql
         jEF4l9e8CwfLOZg0bxBelkRwbtU0j3sLew0IuLSdxCwfvFptXvQBz6guLrGIleT6OP97
         V8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqFOTGjWCbditxbgpQ8IyRDxYky7yNBzoJozO0vswEQ=;
        b=KxG1PvKkDivZZ8qd4NHwmbi2rxJLsESfPIGs8uz8Tlto95q1J9F/7vSC8nlDFuKtSh
         0z80qSWWoJk7D1YgeF3Yes6OEQ9upV+bdtohnzn8Yznp8C3I+l8PvvOSq5n69v2U3gN8
         tA9eLG0b+IGyitLI1hOC/c7vLjlqiO+3eKVEZ4eECFRCsmV2xCOAs18a+GOFa5Bl5MwD
         oNsaSliBPC4eefX7V+w3hzgVL6zMQCy7AhzROhPEpJYpvCxZGvMy3V/UcUF/mh6+dhD5
         23FtAou0bbZ5Z0xjq+TDUwgCUuxEBOZ4Rlmn82YsS0h3tck36EXo+JrBC1mkcmiHJWSL
         OLcg==
X-Gm-Message-State: AOAM530qpDzUKBPcJkXDeSLYcYbdgh/foaPJ3fF+u1VJOPJGLBzvtciG
        3S6OYVp9lwd6THYEvYJIJHTwd1g5UXyZnRb6lWfpG0P8uR8=
X-Google-Smtp-Source: ABdhPJxQcq56BqsqIIrIcQRmmh/WJmWhy8kQj3j/RwIH5HE6Plmujyu21VWVfua9tArX4YTmjmxZYt+1pCY+VZp8y1I=
X-Received: by 2002:a2e:9948:: with SMTP id r8mr2368530ljj.126.1599672912361;
 Wed, 09 Sep 2020 10:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAO18KQgxfCBFacLxpLZJZ6iDmEA83DUwG2kjfPyJmPZHPQZ5vQ@mail.gmail.com>
 <20200907170021.GA2284449@rani.riverdale.lan> <CAO18KQg9wLFF8KxZdP4fVv-vk_CpfV+_v38WnCJ-uqEAJ3FNwA@mail.gmail.com>
 <20200908223255.GA276578@rani.riverdale.lan>
In-Reply-To: <20200908223255.GA276578@rani.riverdale.lan>
From:   Jacobo Pantoja <jacobopantoja@gmail.com>
Date:   Wed, 9 Sep 2020 19:34:59 +0200
Message-ID: <CAO18KQgPJu2uZzBuCTsKOJydnbgsNM+EMvcJRDBE3UhSKHtpfw@mail.gmail.com>
Subject: Re: EFISTUB arguments in Dell BIOS
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     ardb@kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 9 Sep 2020 at 00:32, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Sep 09, 2020 at 12:12:35AM +0200, Jacobo Pantoja wrote:
> > >
> > > Just to check, are you directly booting from firmware into the EFI stub,
> > > or do you have something (grub2/systemd-boot/refind etc) in between?
> > > Which kernel version are you using, and are you able to compile your own
> > > kernel with patches for testing? If so, we should be able to add in some
> > > debug statements in the EFI stub itself to see what the firmware passed
> > > it as the command line, and if it's getting truncated or something.
> > >
> > Yes I'm booting directly from firmware into EFI stub, no
> > grub2/systemd-boot/refind
> > involved. My current kernel is 5.8.5.
> > I'm able to compile kernel with patches, no problem.
> > As a side note, the exact same kernel with the exact same efibootmgr command
> > is booting in other machines (different models).
>
> Great. Can you test the patch below? It should dump the options passed
> to the EFI stub, before/after converting from UTF-16 to UTF-8, and then
> wait for a key. If you can take a picture of the screen it should show
> what's going on, hopefully.

Result saved as image:
https://ibb.co/vcz48vC

>
> > >
> > > If you boot directly from firmware, the EFI stub is what would load the
> > > initramfs, and at least the initrd= argument should be in /proc/cmdline
> > > after boot.
> > >
> > That is weird; I can see the difference between including initrd arg or not
> > including, but "cat /proc/cmdline" returns a blank line. Hexdump reveals
> > that it is really 0x01 0x0a. I'm 100% sure the initramfs is being loaded when
> > passed as an argument, although the cmdline does not reflect it.
>
> The 0x0a I think is added by /proc/cmdline, so the cmdline is just 0x01.
> The only thing I can think of is that the conversion from UTF-16 to
> UTF-8 in the EFI stub went wrong somehow: the initrd= argument is
> processed directly from the UTF-16 cmdline, but the UTF-8 converted
> version is what is passed to the kernel.
>
> > Yes, I'm including here my efibootmgr command, and the output after calling
> > with -v. Line breaks are simply for the email readability.
> >
> > $ efibootmgr --disk /dev/disk/by-id/ata-(...) --part 1 --create
> > --label "ArchLinux" \
> >   --loader /vmlinuz-linux --unicode "root=LABEL=ArchRoot rw quiet \
> >   initrd=\intel-ucode.img initrd=\initramfs-linux.img intel_iommu=on audit=0"
> >
> > $ efibootmgr -v
> > Boot0000* ArchLinux
> > HD(1,GPT,b0fd4cf1-1566-4c71-b214-c3c0c5924fea,0x800,0xfa000)/File(\vmlinuz-linux)r.o.o.t.=.L.A.B.E.L.=.A.r.c.h.R.o.o.t.
> > .r.w. .q.u.i.e.t. .i.n.i.t.r.d.=.\.i.n.t.e.l.-.u.c.o.d.e...i.m.g.
> > .i.n.i.t.r.d.=.\.i.n.i.t.r.a.m.f.s.-.l.i.n.u.x...i.m.g.
> > .i.n.t.e.l._.i.o.m.m.u.=.o.n. .a.u.d.i.t.=.0.
> >
> > I've just checked right after a power cycle, with the exact same result:
> > 1) No parameters appended in efibootmgr => black screen
> > 2) Parameters appended in efibootmgr => boots to rescue shell
> >
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index f735db55adc0..084cf4812a02 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -252,6 +252,11 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
>         int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
>         bool in_quote = false;
>         efi_status_t status;
> +       const char *cmdline;
> +       size_t i;
> +       efi_input_key_t key;
> +
> +       efi_info("Load options: %08x @ %p\n", efi_table_attr(image, load_options_size), options);
>
>         if (options) {
>                 s2 = options;
> @@ -313,6 +318,41 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
>         snprintf((char *)cmdline_addr, options_bytes, "%.*ls",
>                  options_bytes - 1, options);
>
> +       efi_info("%.*ls\n", options_bytes - 1, options);
> +       /* Hex dump */
> +       efi_info("UTF-16:\n");
> +       options_chars = efi_table_attr(image, load_options_size)/2;
> +       i = 0;
> +       do {
> +               size_t j;
> +               efi_info("%p: ", options + i);
> +               for (j = i; j < options_chars && j < i + 8; j++)
> +                       efi_printk("%04x ", options[j]);
> +               for (; j < i + 8; j++)
> +                       efi_printk("%4c ", ' ');
> +               for (j = i; j < options_chars && j < i + 8; j++)
> +                       efi_printk("%lc", options[j]);
> +               efi_printk("\n");
> +               i += 8;
> +       } while (i < options_chars);
> +       efi_info("UTF-8:\n");
> +       cmdline = (const char *)cmdline_addr;
> +       i = 0;
> +       do {
> +               size_t j;
> +               efi_info("%p: ", cmdline + i);
> +               for (j = i; j < options_bytes && j < i + 8; j++)
> +                       efi_printk("%02x ", cmdline[j]);
> +               for (; j < i + 8; j++)
> +                       efi_printk("%2c ", ' ');
> +               for (j = i; j < options_bytes && j < i + 8; j++)
> +                       efi_printk("%c", cmdline[j]);
> +               efi_printk("\n");
> +               i += 8;
> +       } while (i < options_bytes);
> +
> +       efi_wait_for_key(120 * 1000000, &key);
> +
>         *cmd_line_len = options_bytes;
>         return (char *)cmdline_addr;
>  }
