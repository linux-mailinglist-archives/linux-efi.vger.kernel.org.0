Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0A519EF96
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 05:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDFDvP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 5 Apr 2020 23:51:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46178 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgDFDvO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 5 Apr 2020 23:51:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id g7so11777333qtj.13;
        Sun, 05 Apr 2020 20:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WV8R6FeJvyF9DBdnPAm34qcEm1BtCICmBxz3iuDazCI=;
        b=vE41NK3RbjgCStbTVodJesrPs91H70K9nrdXIU8R6Lz+qqxgy43Hb+nYjVY+Mn06Oz
         Uqjt3OhZqmLqmKdd6Hwi7V288FkfdueXA82Yq1t947f2Izwo0vexU09e8boozekSfWu7
         ue5VgBGx+UkwDu2ivUv23NxGf5vmNeVLEzMcoy18XgURHmHC5vP+Vx2HfzABAAqL6me8
         78QWPHRbZccoInJXFoD5xW6sT6nYoxX3RzTVi4K2Ot7IGQJICZykN1Yqw3ZbdlmhcsnY
         8GcAqovW71pa5Lt+TKAto4SGw2BYgGqS3kXo+lZC/eBVG3g2R4lNHn6ww8/7JUaL0qvp
         f3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WV8R6FeJvyF9DBdnPAm34qcEm1BtCICmBxz3iuDazCI=;
        b=TQXdQRvBhuuMC58/Meq7EE6dE4glE0Sj2Td7s42oU5hIPNgAWwfQM87zS/HfwSZzwC
         gF7wvYaah3RO1KYpNZK3TPrpCQJCkyofqG//Pk0uY/WwddODSiPM0hN7dN4GN/BKTinw
         McYPaoXNAtk+3LBYJzmWGae3dD42aLYM0v33pgEyye7TqfyfphCauLFbCZUr6iz82WYm
         Q85lfbMOD9Z64Zru4khvoRlnB3u+6DF5DasYWXNEfl2DgHlfJBtcH9la0uH9L6Am3NTz
         F89VIoEvIq9V6xGdjUYAGsr79/DLlmvJJUhvOoXQJ3C7Uh44viy+0WEBlHZTl50kyvir
         4upw==
X-Gm-Message-State: AGi0PuYmuCb0wCvobQf39MJvY5gFG8PPwe/ll5B2U89hA48/n1FLxlgt
        VPkk6W9YIlTuJxzFQQUOlWA=
X-Google-Smtp-Source: APiQypJa/k2QgcvR8h5j8+MSkiGDQZlvlxwZXadcxQ6mYtNsTqbDHGoLmZc/E1t7Ktq8otAgCL1odA==
X-Received: by 2002:ac8:1a2b:: with SMTP id v40mr19269089qtj.364.1586145073323;
        Sun, 05 Apr 2020 20:51:13 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p1sm13904678qkf.73.2020.04.05.20.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 20:51:12 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 5 Apr 2020 23:51:10 -0400
To:     Sergey Shatunov <me@prok.pw>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, initramfs@vger.kernel.org,
        Donovan Tremura <neurognostic@protonmail.ch>,
        Harald Hoyer <harald@hoyer.xyz>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Message-ID: <20200406035110.GA3241052@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200405154245.11972-1-me@prok.pw>
 <20200405231845.GA3095309@rani.riverdale.lan>
 <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c692eea9213172d8ef937322b02ff585b0dfea82.camel@prok.pw>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 06, 2020 at 07:00:39AM +0700, Sergey Shatunov wrote:
> On Sun, 2020-04-05 at 19:18 -0400, Arvind Sankar wrote:
> > I'm not familiar with systemd-boot: when you say systemd-boot stub,
> > is
> > that something different from the kernel's EFI_STUB option? Or is it
> > just a kernel with EFI_STUB enabled and with builtin initramfs +
> > builtin
> > cmdline?
> Basicaly systemd-boot stub is efi application with packed EFI_STUB-
> enabled kernel, initrd and cmdline into single file. Source can be
> found here: 
> https://github.com/systemd/systemd/blob/master/src/boot/efi/stub.c
> 
> It doesn't do anything unusual, just extracting data from sections and
> calling efi handover.
> 
> Final image created by objcopy'ing precompiled stub and adding sections with that stuff:
> 
>     objcopy \
>         --add-section .osrel=os_release --change-section-vma
> '.osrel=0x20000' \
>         --add-section .cmdline=cmdline --change-section-vma
> '.cmdline=0x30000' \
>         --add-section .linux=vmlinuz --change-section-vma
> '.linux=0x2000000' \
>         --add-section .initrd=initrd --change-section-vma
> '.initrd=0x3000000' \
>         /usr/lib/systemd/boot/efi/linuxx64.efi.stub output.efi

So this embeds the bzImage which is a PE executable inside another PE
executable. Before my patch, the bss section was explicitly part of the
bzImage and so would have been zero, now it isn't any more and the PE
loader is expected to zero it out before executing. systemd-boot's stub
loader doesn't do that prior to jumping to the EFI handover entry, so
the issue must be because bss contains garbage.  I'm not 100% sure why
that leads to a crash, as the only variables in bss in the EFI stub are
for some boolean EFI command line arguments, so it ought to still have
worked, just as though it was invoked with random arguments. Anyway we
need to handle an uninitialized bss to get this to work properly.

I also see from systemd [0] and dracut source [1] that these VMA's seem
to be hardcoded with no checking for how big the files actually are, and
objcopy doesn't seem to complain if sections end up overlapping.

So since [2] in dracut, the space available for the .linux section
containing the bzImage shrank from ~48MiB to 16MiB. This will hopefully
still fit the compressed kernel (although an allyesconfig bzImage is far
bigger than even 48MiB), but in-place decompression is unlikely to be
possible even for a normal config, which will break another patchset
that got merged into mainline for 5.7 [3,4], which tries to avoid
copying the kernel unless necessary, and has a good chance of triggering
in-place decompression if kaslr is disabled.

I'll get systemd-boot installed here so I can reproduce and implement
some workarounds for both issues. I should hopefully have a fix in a day
or two.

[0] https://github.com/systemd/systemd/blob/9fac14980df8dcce922e1fe8856a88b09590d2c3/test/test-efi-create-disk.sh#L30
[1] https://git.kernel.org/pub/scm/boot/dracut/dracut.git/tree/dracut.sh#n2039
[2] https://git.kernel.org/pub/scm/boot/dracut/dracut.git/commit/?id=4237aeb040c276722b528001bdea31e6eb994d06
[3] https://lore.kernel.org/linux-efi/20200303221205.4048668-1-nivedita@alum.mit.edu/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5cdf4cfeac914617ca22866bd4685fd7f876dec
