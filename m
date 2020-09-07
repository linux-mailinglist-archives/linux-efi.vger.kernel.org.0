Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C126011F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Sep 2020 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgIGRAk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Sep 2020 13:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbgIGRA1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Sep 2020 13:00:27 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5C9C061573
        for <linux-efi@vger.kernel.org>; Mon,  7 Sep 2020 10:00:24 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e7so10125166qtj.11
        for <linux-efi@vger.kernel.org>; Mon, 07 Sep 2020 10:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9YSam43ke55WEKn0KtNrC6FyjIto7gjQy9n0LZiWMq4=;
        b=cyuskH+YylMq5NQsU3X8SoGCLEFLv8aF032qQvsIlku1qYakpuOKIWGkJ4asZFyCIJ
         n7f0UdE1qqdpEC3fw3gxP/WREnMgXZ+Va5NBoK65kygdJJDUKdh93ie5yu0fClvmOVlw
         J4uTjRnXoZ67ftaZ16YluRuMTE+/LCv7sztIq1YpLtmqVO07hsY+CZsMZcZ9SC2dcEuv
         o3H8iagJSW6HfqE1RtdX5eDeucneFZqrSs24kXNeNtcys9rZhCJgcJYe0XI8dneNOuQ1
         jl3D+CGoyvVp14Dwmmny6NhnSyrUsMvbcJvmroAZt1bsWYFEqXenKaxwYdsDozqCG7Hu
         nNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9YSam43ke55WEKn0KtNrC6FyjIto7gjQy9n0LZiWMq4=;
        b=bLNGCH2KI3H0Hib/6PDrMyLyIaQlopCEnuioduAURXdQq99YYWQL0vgJRRz4+vwrwC
         7ORxN7R3TGKsCcROjUVfhBtBcvHgva6/2lS28umwUOGeaeA9NQIlmlmQrZFlmPU0wXcr
         j8EXtPgnSPDcDsTmOVFLMhgOLJpE4UR3vLsnmMjlAWduKDfiMXEp2PsM3DCwmzozWLjc
         FMp9KaldvtIDhtKQCcj/77yFCRtN7PSx/Qe9kjvhrHQ0Fbb7nuLYq10bKc7u+Oem//mS
         bxP7tTP1/pVAEJstjaNZG4pB+T5iAgTieGZzzXB93wB2GnUILBkXbubKZPhSiOJ3egAv
         /S2A==
X-Gm-Message-State: AOAM530KWOPxdW3bjfwahqRWN2bcud4Dx3RhpuJOZfl/QvuoQw3iLwNh
        Onf06dq4qgp4Aj+io0T3skw=
X-Google-Smtp-Source: ABdhPJxFU9EtLcLhSlhhvR6BJJmLfG3fr9oDlmaLpKHOs2CVuQtBKnaV1I0bPT+Eun1RqGtAsptyEA==
X-Received: by 2002:ac8:202:: with SMTP id k2mr6418277qtg.359.1599498023140;
        Mon, 07 Sep 2020 10:00:23 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x126sm10186398qka.91.2020.09.07.10.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 10:00:22 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 7 Sep 2020 13:00:21 -0400
To:     Jacobo Pantoja <jacobopantoja@gmail.com>
Cc:     ardb@kernel.org, nivedita@alum.mit.edu, linux-efi@vger.kernel.org
Subject: Re: EFISTUB arguments in Dell BIOS
Message-ID: <20200907170021.GA2284449@rani.riverdale.lan>
References: <CAO18KQgxfCBFacLxpLZJZ6iDmEA83DUwG2kjfPyJmPZHPQZ5vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO18KQgxfCBFacLxpLZJZ6iDmEA83DUwG2kjfPyJmPZHPQZ5vQ@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 07, 2020 at 05:30:39PM +0200, Jacobo Pantoja wrote:
> Hi Arvind and Ard:
> 
> First, I'm sorry to use a direct email communication instead of a mailing
> list, but honestly at this point I cannot guess the correct procedure. If
> this should be managed from a mailing list, please be so kind to indicate
> to me which one would it be. I've seen that you have authored some commits
> regarding EFISTUB, so I guess you can at the very least direct me in the
> right way.

Adding linux-efi to Cc.

> 
> Now the problem, related to EFISTUB and argument passing: I've setup a Dell
> workstation for use with ArchLinux, as the rest of my machines, but I've
> faced a problem when using EFI boot stub: kernel arguments are not passed,
> _apparently_. I've seen in [1], [2], [3] and [4] that it might be a common
> problem to Dell's BIOS implementation, not passing the arguments to the
> kernel at all.

Just to check, are you directly booting from firmware into the EFI stub,
or do you have something (grub2/systemd-boot/refind etc) in between?
Which kernel version are you using, and are you able to compile your own
kernel with patches for testing? If so, we should be able to add in some
debug statements in the EFI stub itself to see what the firmware passed
it as the command line, and if it's getting truncated or something.

> 
> Now the _apparently_ part. I have a simple script to create the bootloader
> entry, and it is properly working in at least 3 different machines.
> * If I simply leave the command line empty (i.e. I pass no arguments, i.e.
> no --unicode "..." section in the efibootmgr command): I can see a blank
> screen.
> * However, if I specify my initramfs via the "initrd=\..." argument (i.e.
> efibootmgr ... -u "initrd=...."), it properly boots up to a rescue console.
> 
> In the rescue console, I can see that /proc/cmdline is empty. As no root
> has been specified, the boot process cannot continue. If I manually mount
> the root fs and exit the console, the boot is completed (with no arguments,
> obviously).

If you boot directly from firmware, the EFI stub is what would load the
initramfs, and at least the initrd= argument should be in /proc/cmdline
after boot.

> 
> That said, I can boot in several different ways, but I'd like to understand
> the problem, and solve it if possible.
> My understanding is that the firmware *is* actually passing somehow the
> arguments (because initramfs is properly mounted), but somehow the
> arguments are being discarded or something. *Is there a way I can properly
> debug this?* I'm a bit lost in the kernel tree, I see a lot of ASM that I
> don't understand so I don't know how to debug.
> 

Does efibootmgr -v show the complete command line (i.e. both initrd and
any rootfs argument), so we're sure the full command line did make it to
NVRAM? Check it after a power cycle so we can cross at least that off
the list.

> Thank you very much in advance,
> JPantoja
> 
> [1]:
> https://www.dell.com/community/Linux-Developer-Systems/Linux-EFISTUB/td-p/4586378
> [2]:
> https://www.dell.com/community/Laptops-General-Read-Only/Dell-UEFI-implementation-does-not-support-Linux-Kernel-EFISTUB/td-p/5185272
> [3]: https://bbs.archlinux.org/viewtopic.php?pid=1753169#p1753169
> [4]: https://github.com/xdever/arch-efiboot
