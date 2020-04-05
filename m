Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B56C19EE7D
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 01:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgDEXSt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 5 Apr 2020 19:18:49 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:34255 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgDEXSs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 5 Apr 2020 19:18:48 -0400
Received: by mail-qv1-f66.google.com with SMTP id s18so6691449qvn.1;
        Sun, 05 Apr 2020 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M/F/f/WzwdqXVXZxqD6HXXgsX9oeQ3XHsN3eudpW6Js=;
        b=QwVnRAi1GBtAEz+wTk1Adt9f8cAAAx7zwq08y7UvmAG+z2Tfvyf8ot33CvKSQrOOUw
         xsk7SYls+pdhTRdE9x97McpZA9ACwMFKldKpiS6DdfQ8gE8bC/B44wmXwJPKEwf1ebGw
         xmfFLdBp58U3VGm7FfkKVUByxwLg4zhreRneAYM+uAdqP/OiKHNey7uQKIqcjXkDf4tS
         ibEY4k+UsASqou4b7CbDmF5b8aUb8+wDHgDlNun/NjeXLjRyqvLA4WK47VbLICPRz49q
         5MqZ49okDnTcgrmmgrdBuAH9aDBCZ94xAoKcUMcNU2rzCHaBg5TU8YDesEKLdDo6YTwt
         4qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=M/F/f/WzwdqXVXZxqD6HXXgsX9oeQ3XHsN3eudpW6Js=;
        b=WVBvPaHoRXpImGE/inBG+/e1gJNmUa/yfdfjcsublNjCHEBml/IzDrOOKp3h+oFJJs
         3TklVHzJQOD3frJzVyYHq2hwocD4Vim38gtHklvemhTaJ8u0HKILRrITrVBggyY+yha0
         nWfoF/bxQqzFRgna8Vz/w2qxWgdQ2UFE5rajAJKZyCn8KEHpVX3h8r1zh2qJwh0FZxiS
         lkSYOJtGxjV/OkafST7dRKoDPnyu7DYX0LOxjyJWUdZDbNW370zkNBhuXUsR/BgSQGXC
         MYvdefS4G+mFBklAqYi9MDjc9L8Z+Bywdm8UEQArgnYGwqSYuI4XZj+yWg1hqpp2HB11
         3sPg==
X-Gm-Message-State: AGi0PubXa6Q87AFmoDW5QN2SH8rXlUQeO6l0Uf1VhunDEEgM7fzdyTSz
        bW4jLODGWT4O9RjSiPfDLTg32RJ+
X-Google-Smtp-Source: APiQypLc1ovH2pPL1gk+Ej3Io8JqDMxZYYdmuFrMa7Z/i+9n8HvoSu3F9+6C7Y5gTXsKzf28Am+Mxg==
X-Received: by 2002:ad4:498c:: with SMTP id t12mr18696454qvx.27.1586128727395;
        Sun, 05 Apr 2020 16:18:47 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o5sm3810154qkh.77.2020.04.05.16.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 16:18:46 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 5 Apr 2020 19:18:45 -0400
To:     Sergey Shatunov <me@prok.pw>
Cc:     nivedita@alum.mit.edu, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Message-ID: <20200405231845.GA3095309@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200405154245.11972-1-me@prok.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200405154245.11972-1-me@prok.pw>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Apr 05, 2020 at 10:42:46PM +0700, Sergey Shatunov wrote:
> This patch causes some strange things happens with my laptop.
> 
> Cold boot crashed in some early initilization logic with message 'Failed to execute /esp/.../linux.efi: Buffer Too Small'.
> After couple reboots into firmware setup (bios) or hot reboot from other working kernel (without that commit) helps it to boot.
> During bisecting couple times I saw different message: 'exit_efi() failed; efi_main() failed', but above tricks helps it too.
> So bisect points to that commit and I tried to compile kernel with that commit reverted and it works flawlessly.
> 
> Some notes about my setup:
> Kernel tree I used: Torvalds git (which recently pulls that commit).
> Kernel itself with initrd and cmdline packed into systemd-boot stub (probably here can be issues too, not sure).
> Secure boot enabled with custom keyring.
> 
> I can provide more info or change my setup (for example get rid of systemd-boot stub) if needed for sure.

I'm not familiar with systemd-boot: when you say systemd-boot stub, is
that something different from the kernel's EFI_STUB option? Or is it
just a kernel with EFI_STUB enabled and with builtin initramfs + builtin
cmdline? If it is different, can you point me to the tool that creates
it?

The first error message you mention should be from systemd-boot after
the kernel exits with an EFI_BUFFER_TOO_SMALL error status. The second
one -- is that 'exit_boot() failed' rather than 'exit_efi() failed'? I
can't find the latter string in the tree.

Can you also specify a commit tag that is broken + works with this patch
reverted, just to make sure we're looking at the same code?

Thanks

Cc linux-efi.
