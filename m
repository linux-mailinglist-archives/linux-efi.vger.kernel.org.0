Return-Path: <linux-efi+bounces-3257-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F44AA83A71
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 09:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4828E17A08D
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 07:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF85204F81;
	Thu, 10 Apr 2025 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf+35uYr"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C32204F7A
	for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269122; cv=none; b=jSINHC45QlOHfBEaCaGRd5awdfMWCNGD8AH3RwhT+4xZCRGW5/Q15LbxOUN7fV+c8EMbY0NO1oB2+cI55Q2uvfHJtn5p9nPE5fHpUjjFlnkUOH5MkCWI1zXCPNxG/p+BlIxQTI2zuCfF3kLxZDHofCmbUx4WbzHIRak6nih2pvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269122; c=relaxed/simple;
	bh=5EwRmCmkdC6fC0JJ36jH3f1wzH3CqRDXzUIpO9LbjBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0/MnVPH/cOZhQkwkG09/eljetGHSeqT5aUCmHMHt0NWYfzfHWjvcDjNCvESwbZDpSlFENZNFG4yoPUbjMkWDymBriIW8az6buhRsJG4ILeID5pYGKBPKGU47cVJmXHPxkgRWUxsYJVvBBgVqqF0mS5j80Et+04MvagMG528otE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf+35uYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4133DC4CEEC
	for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744269122;
	bh=5EwRmCmkdC6fC0JJ36jH3f1wzH3CqRDXzUIpO9LbjBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cf+35uYr1JryCbhSF1Fshki2rVQ/sCVT41r/PdEtDG4yPK8oYnkU5PA9907L4iCd4
	 HaevGlijtYQ4bFtzyf2dzrXVdaVkgwL8QK58oacMbxJW6WhvxCbMfzmkOmCFmu6ufi
	 AQThgkqXtOqFX38DAqhPCnYkWzzx3ryCI1xfBE01pcIyBn4lHm2woYvTVpQZ+WK/K2
	 8KwGx2XszmOCR9qIt5zYuU/smFSCClP4iGik0FUAJSzo7tYqw8v6nJ68XbnZ8ZREFL
	 G78NlvKvgocKCyFobEU9eFqNXhakI2DyPyDngfVG5+d4i4Mv62g5jqesLGtQOYLd25
	 hrzynmMy1hZYg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a59so4827521fa.0
        for <linux-efi@vger.kernel.org>; Thu, 10 Apr 2025 00:12:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDoxm2CQ4FEyPMUWNMnududNcbs/rd8+Y4vZ4bJRmtW+NqYqjr3XSzTuElpgemGWjDvH7vwz9x0W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiLFcTS+vAkRunj63d40zIOdraLbVSBAnxvNHMzXQ0XFM7ENSQ
	utY/zuio+sZ3eds16yFlqcUrKgwIAdYAk2mV+mQZfvdAycwNjoHsx4VHlKfcP+bf6RoGIyD99gN
	DXqFLrh9/1oWtwEZO+xdnzByqupg=
X-Google-Smtp-Source: AGHT+IHvwkNG0l09awBUJjGY050Cg1jKCJcCeY5oYWgzzV86SzILJ2+0aAQtz08k99UXL+ip1dTTAvLZQjpujMYowFk=
X-Received: by 2002:a05:651c:1601:b0:30d:e104:9ad2 with SMTP id
 38308e7fff4ca-3103ed525cdmr3669721fa.39.1744269120528; Thu, 10 Apr 2025
 00:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANCZdfpOs6cTSacxzF013AUwOW78oUf5kY11nbTYMrT7W2oP2g@mail.gmail.com>
In-Reply-To: <CANCZdfpOs6cTSacxzF013AUwOW78oUf5kY11nbTYMrT7W2oP2g@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 10 Apr 2025 09:11:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGcJuf+s5JcKf-a25jwNeWGn+sHhkai+HRYHTnA2z3D2A@mail.gmail.com>
X-Gm-Features: ATxdqUHqEOmXtu0sJjOcgeAtHfCdWN0mI9Ibq75vpwe7gdra81_mmad33rFkVbM
Message-ID: <CAMj1kXGcJuf+s5JcKf-a25jwNeWGn+sHhkai+HRYHTnA2z3D2A@mail.gmail.com>
Subject: Re: Why isn't the EFI memory map published in /sys/firmware/efi?
To: Warner Losh <imp@bsdimp.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Warner,

On Wed, 9 Apr 2025 at 19:29, Warner Losh <imp@bsdimp.com> wrote:
>
...
>
> The first one is the EFI system table. On aarch64 I can get it from the DTB
> in /sys/firmware/fdt, but it's unpublished that I can find on x86_64. I get it
> from boot_params that I read from the kernel with /proc/kcore there. Is there
> some reason this isn't published in /sys/firmware/efi/systab or similar? A
> number of other, auxiliary tables are published, but not this one that
> I could see.
>

In general, if something does not exist today, it is because nobody
needed it and so nobody bothered adding it.

If you need this, please propose a patch and we can discuss on the mailing list.

> The second one is the memory map for EFI. A subset of it is exported
> /sys/firmware/efi/runtime-map, but it is only the runtime services mappings,
> not the entire table. FreeBSD populates its memory maps from the EFI Memory
> Map that's obtained just before exit boot services is called. So my next
> question is why the full map isn't also published?

The full map is not published because it is a snapshot of how memory
was being used at boot time. So at kexec time, it is generally out of
data and so the kernel needs to provide an up-to-date memory map
anyway.

However, the EFI_MEMORY_RUNTIME regions should in principle be ok,
because they shouldn't change. However, the x86 kernel does some
disgusting things with the memory map and uses the EFI_MEMORY_RUNTIME
flag for its own purposes.

Note: the runtime-map is only published by x86.

So TL;DR - the original memory map is of limited use, and on x86, not
even the runtime regions can be trusted.

? Most of the same data is
> available from /proc/iomem, so there's not a data visibility issue that I can
> see. BTW, /proc/iomem isn't suitable because it's a processed version of the
> efi memory map that loses information. I can use it for the loader to find a
> spot to put the kernel, but can't use it as the memory map for the FreeBSD
> kernel reliably. The FreeBSD EFI boot loader puts this data into a metadata
> region that's passed to the FreeBSD kernel for it to consume, and I need
> to retain that functionality.
>

Sifting through the contents of RAM is not the solution here.

> So, since I can't get the EFI memmap data directly, I have to use indirec
> means. For aarch64, I can find the PAs and metadata for the memory map
> form FDT.

This is an internal ABI that may be removed at any point.

> Ditto the EFI system table.

Same

> I pass my trampoline code the PA and
> length for the memory map and the metadata area so it can copy the
> needed data for the new kernel.
>
> For x86_64, I open /proc/kcore and read out the boot_params structure.
> I can get the PAs and metadata from it. I do a similar trick in the trampoline
> to copy the data. This works, but feels very 90s BSD netstat to me (where
> all network stats were read directly from kernel variables and had issues
> too long to get into here). This is less than idea as well because I have to
> rely on the Linux Boot Param structure and it only exists on x86.
>
> On permissively configured systems, I could use /dev/mem or /dev/kmem
> to read the actual map so I wouldn't have to do it in the trampoline and
> could use the EFI memory map to find where to store the kernel rather
> than the /proc/iomem map that I use (it's a subset of the EFI memory map
> data, but not enough of one to reconstruct it). But those options aren't
> available for some of the environments I have to boot in.
>

None of these are acceptable solutions.

> FYI, the Linux kernel gets around this, at least on x86, by cheating a little.
> It uses the bzImage kexec handler to copy data from the current boot_params
> into the new kernel's boot_params and passes that to the new kernel. It
> does this because, I think (I've not traced this out 100%, so be kind on any
> corrections), kexec_file is the typical path and the kexec handler can find
> the bzImage header in the file. My trampoline doesn't have that header, and
> attempts to add it have been unsuccessful, so the path to the new kernel
> goes through relocate_kernel in arch/x86/kernel/relocate_kernel_64.S which
> clears all the registers and doesn't pass in the boot_params (which is why
> I read it from /proc/kcore).
>

In true x86 fashion, the kexec code is a jumble of many different boot
paths, and you shouldn't expect that anything remotely as messy will
ever be supported on other architectures.

> So why isn't there a /sys/firmware/efi/map that I can just read?

Because nobody bothered to add it.

> Why isn't
> there a /sys/firmware/efi/systab that I can get the system table address
> from?

Same

> Code for these wouldn't be hard and I could submit that code to
> make publishing the data more controlled and regulated. However, I
> thought it would be prudent to discuss the reason for the omissions
> first to see what the thinking there is.
>
> Thanks for your time and for whatever help and insight you can give me here.
>

For the record, it would be much better to not rely as heavily on
kexec internals as you seem to be doing, and instead, implement a
minimal EFI boot services layer for kexec that should be able to boot
any EFI compatible operating system. The boot services part could run
while the kernel is still up, and only the pivot into the new
environment (after ExitBootServices()) would execute 'in the dark'.

I have been meaning to spend time on this myself, but I haven't gotten
around to it. I did implement minimal the EFI boot services layer but
no time to plug it into kexec.

