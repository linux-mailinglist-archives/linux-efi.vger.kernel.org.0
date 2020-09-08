Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD972622A9
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 00:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgIHWdC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Sep 2020 18:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgIHWdC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Sep 2020 18:33:02 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E36C061573
        for <linux-efi@vger.kernel.org>; Tue,  8 Sep 2020 15:33:01 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id f11so579721qvw.3
        for <linux-efi@vger.kernel.org>; Tue, 08 Sep 2020 15:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ubvpJ9hHxAR4cNmaqvRodC55jgLsi1/F60DWH9avQ5Y=;
        b=X1/8hbI8AyM9tugQMfLmy2sx9VzqFBZressrV2953KDHBws6sVKMImW6veGCgo0MLb
         Q3yrFdwSOyByNRAUwFhM07u2VyNjFn8GkHqCIzYHRhmjQ8Cqfy35/hHk6HRCNpKTEzEj
         K6Fk3CtW+sqtyf9qBZ/mG6FcPvD4lNwx4GEawf6gxpiCrRTe0iYRal6+PiLdhQ4NV+D+
         /ikqAqFMKyZI2OA57vvO2UHmdYSRkikezyyMsoXKgSY8DxuVX1E4dr0rt8J2yMTna9wJ
         PGbb/6+vYXVIQkhasgDyMRNEYk/k2cofGbWduHkDiON/ierlCBieATw4pbaUe01BdWbV
         im3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ubvpJ9hHxAR4cNmaqvRodC55jgLsi1/F60DWH9avQ5Y=;
        b=QxegH6vHohucA7BQt3PP2lrALPouv9oCUMp/hY3HGlZrJBRVSVfNFjQ2jGnLbSYr3n
         wJpG7XwpneGujVcQxh/yizSmfso0NPovENVHIEQKqp3jt0kAVVGBXfZZZRngoTUchzV3
         59/BEowGeZdqm+FN2dIE8yK+jcuA5olViii7SyYmVkM4OyawAt/nnp5hCgYGZ/5fYa/3
         PiYH1Q63JrnbMwZ4P3GPEAkBjBSGKiwR+urNWrANksZpNgxcggYKrL6V+FagCx8gby1s
         191iKiEg3bm/z9Wg3dvbjsZzB8uKI9bOthUZHiVc4qxC+gdAsjX/yhTGXs8ondqP6J5K
         DT/Q==
X-Gm-Message-State: AOAM533k9l0iaBiVgSO1nv9zvAZA0kYdWzHfnScjFKnK5RGR1BGw1bl0
        rZTrmuj/TxSTr8SOMyCqimo=
X-Google-Smtp-Source: ABdhPJxgvz4ZrIdMBcn9XOMTmxt9oavN657X2lbiK4mEMuiwOGltkv1CiU3d6RXHAMN0Hk3PS0DH7g==
X-Received: by 2002:a0c:e602:: with SMTP id z2mr1441193qvm.69.1599604378093;
        Tue, 08 Sep 2020 15:32:58 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t43sm945622qtc.54.2020.09.08.15.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 15:32:57 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 8 Sep 2020 18:32:55 -0400
To:     Jacobo Pantoja <jacobopantoja@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, ardb@kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: EFISTUB arguments in Dell BIOS
Message-ID: <20200908223255.GA276578@rani.riverdale.lan>
References: <CAO18KQgxfCBFacLxpLZJZ6iDmEA83DUwG2kjfPyJmPZHPQZ5vQ@mail.gmail.com>
 <20200907170021.GA2284449@rani.riverdale.lan>
 <CAO18KQg9wLFF8KxZdP4fVv-vk_CpfV+_v38WnCJ-uqEAJ3FNwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO18KQg9wLFF8KxZdP4fVv-vk_CpfV+_v38WnCJ-uqEAJ3FNwA@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 09, 2020 at 12:12:35AM +0200, Jacobo Pantoja wrote:
> >
> > Just to check, are you directly booting from firmware into the EFI stub,
> > or do you have something (grub2/systemd-boot/refind etc) in between?
> > Which kernel version are you using, and are you able to compile your own
> > kernel with patches for testing? If so, we should be able to add in some
> > debug statements in the EFI stub itself to see what the firmware passed
> > it as the command line, and if it's getting truncated or something.
> >
> Yes I'm booting directly from firmware into EFI stub, no
> grub2/systemd-boot/refind
> involved. My current kernel is 5.8.5.
> I'm able to compile kernel with patches, no problem.
> As a side note, the exact same kernel with the exact same efibootmgr command
> is booting in other machines (different models).

Great. Can you test the patch below? It should dump the options passed
to the EFI stub, before/after converting from UTF-16 to UTF-8, and then
wait for a key. If you can take a picture of the screen it should show
what's going on, hopefully.

> >
> > If you boot directly from firmware, the EFI stub is what would load the
> > initramfs, and at least the initrd= argument should be in /proc/cmdline
> > after boot.
> >
> That is weird; I can see the difference between including initrd arg or not
> including, but "cat /proc/cmdline" returns a blank line. Hexdump reveals
> that it is really 0x01 0x0a. I'm 100% sure the initramfs is being loaded when
> passed as an argument, although the cmdline does not reflect it.

The 0x0a I think is added by /proc/cmdline, so the cmdline is just 0x01.
The only thing I can think of is that the conversion from UTF-16 to
UTF-8 in the EFI stub went wrong somehow: the initrd= argument is
processed directly from the UTF-16 cmdline, but the UTF-8 converted
version is what is passed to the kernel.

> Yes, I'm including here my efibootmgr command, and the output after calling
> with -v. Line breaks are simply for the email readability.
> 
> $ efibootmgr --disk /dev/disk/by-id/ata-(...) --part 1 --create
> --label "ArchLinux" \
>   --loader /vmlinuz-linux --unicode "root=LABEL=ArchRoot rw quiet \
>   initrd=\intel-ucode.img initrd=\initramfs-linux.img intel_iommu=on audit=0"
> 
> $ efibootmgr -v
> Boot0000* ArchLinux
> HD(1,GPT,b0fd4cf1-1566-4c71-b214-c3c0c5924fea,0x800,0xfa000)/File(\vmlinuz-linux)r.o.o.t.=.L.A.B.E.L.=.A.r.c.h.R.o.o.t.
> .r.w. .q.u.i.e.t. .i.n.i.t.r.d.=.\.i.n.t.e.l.-.u.c.o.d.e...i.m.g.
> .i.n.i.t.r.d.=.\.i.n.i.t.r.a.m.f.s.-.l.i.n.u.x...i.m.g.
> .i.n.t.e.l._.i.o.m.m.u.=.o.n. .a.u.d.i.t.=.0.
> 
> I've just checked right after a power cycle, with the exact same result:
> 1) No parameters appended in efibootmgr => black screen
> 2) Parameters appended in efibootmgr => boots to rescue shell
> 

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index f735db55adc0..084cf4812a02 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -252,6 +252,11 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 	int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
 	bool in_quote = false;
 	efi_status_t status;
+	const char *cmdline;
+	size_t i;
+	efi_input_key_t key;
+
+	efi_info("Load options: %08x @ %p\n", efi_table_attr(image, load_options_size), options);
 
 	if (options) {
 		s2 = options;
@@ -313,6 +318,41 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 	snprintf((char *)cmdline_addr, options_bytes, "%.*ls",
 		 options_bytes - 1, options);
 
+	efi_info("%.*ls\n", options_bytes - 1, options);
+	/* Hex dump */
+	efi_info("UTF-16:\n");
+	options_chars = efi_table_attr(image, load_options_size)/2;
+	i = 0;
+	do {
+		size_t j;
+		efi_info("%p: ", options + i);
+		for (j = i; j < options_chars && j < i + 8; j++)
+			efi_printk("%04x ", options[j]);
+		for (; j < i + 8; j++)
+			efi_printk("%4c ", ' ');
+		for (j = i; j < options_chars && j < i + 8; j++)
+			efi_printk("%lc", options[j]);
+		efi_printk("\n");
+		i += 8;
+	} while (i < options_chars);
+	efi_info("UTF-8:\n");
+	cmdline = (const char *)cmdline_addr;
+	i = 0;
+	do {
+		size_t j;
+		efi_info("%p: ", cmdline + i);
+		for (j = i; j < options_bytes && j < i + 8; j++)
+			efi_printk("%02x ", cmdline[j]);
+		for (; j < i + 8; j++)
+			efi_printk("%2c ", ' ');
+		for (j = i; j < options_bytes && j < i + 8; j++)
+			efi_printk("%c", cmdline[j]);
+		efi_printk("\n");
+		i += 8;
+	} while (i < options_bytes);
+
+	efi_wait_for_key(120 * 1000000, &key);
+
 	*cmd_line_len = options_bytes;
 	return (char *)cmdline_addr;
 }
