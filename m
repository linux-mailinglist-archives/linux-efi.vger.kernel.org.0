Return-Path: <linux-efi+bounces-1614-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1772962E31
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 19:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB721F23B84
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FB01A4F31;
	Wed, 28 Aug 2024 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRH0EvcH"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC894D108;
	Wed, 28 Aug 2024 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864907; cv=none; b=F3TQZ53+OQ4V4NJQH8u7l4J7pIevHFMMmA0fKRY+iZqsz0iTHsoAhORaTeO50wv0p7R1IbbBxjV/pHpa6IxCgSmgSkmvNIBbUuzwhf4xOZjul2pJIKNvC3+vf/qttPeh2VIjzb0fH7Z6cn+HnUC+fI7yCC1zHqDBR9+RW0I9mN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864907; c=relaxed/simple;
	bh=JxsueSnSgpUq0E0aiVi/UwfMSleCE1Xyjsfg7oEDTFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJ35b8udKL7/s4jgGG6kijuE3PXd4qvAztJyDGFYBTXOLYae/USqgiZqCwBb1WFRxhqnQJBmSRQS9t1DkttEzJhW/zxxUNCzveLqc0KNV4/ZsWqf795uCrVWLinISviLFleUkiTl/mmDyUH/Cy18rk/e5B5Rt9YnsZABGRv/oyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRH0EvcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3265AC4CEC3;
	Wed, 28 Aug 2024 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724864907;
	bh=JxsueSnSgpUq0E0aiVi/UwfMSleCE1Xyjsfg7oEDTFw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BRH0EvcH+Vf2h2JQptTFfaqw70GB1v8ey3mn8+o4f5Dqn1PyHiWV3JWRz8Kq0Sfa+
	 KFAzysOwWiTLxF3Ydl/Vb1MmtBbiqJj6JCKJ1Wy5XE1oB41wLINGphF2skeD2r2p2k
	 owaaSBnevfNjd/ms0z56BpWo7VYpl7BNLEEANDzU2n6sHtdKSq1+C09+Sk/rlZch3P
	 q12nKu0699SoiP+IB4FTmO2nuLFWGip2VXP+z+nWrs3Ybx+RDYZmZSHGx1XWb/6mJQ
	 mdmt8ioIqBWcWU9UbvW+8cyTeG6unyZVpwEJrXaaky39YnKtoYt3Gd4YNHTmiz/fAj
	 Fv1ct9W49ZReg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so371552e87.3;
        Wed, 28 Aug 2024 10:08:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTK70vFkRsgkkZDMGysKtYHDJKN8fJ03Hq9KxLTdKtjC8/keOYXfuP+HECiw3nO83kl7rx4KeiiNNC+JcM@vger.kernel.org, AJvYcCWJvqkcNYCdCCC0AS54XtObu3W+dSxAuwUhke93lHK4ViEAAuRbR64ipBDHbJznHskmX9CxZ/JgcKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw11SqmWFydgw390H+S7br57FbrvTOhiAuvDOjqEnyGW5AzFotE
	Yt9Tzt+QiC38NTfa6rm5dGa18JR4mozVZ0J1pWmyR0tQhj3KG2kNSX4mPDizUtFJ/BTrOvBR0jO
	Twoxm6Z3jeE2Hwp1naw2hBPZ3v+Y=
X-Google-Smtp-Source: AGHT+IHL7Ap08nLbek7EV+lukGhBuzhm3LbdLGJwk2IXYMk/XLLc7Z1Z6xC/2CfmMMQQmBth0h1Tvc9Xpf4we8hI8PA=
X-Received: by 2002:a05:6512:6c8:b0:52c:f2e0:db23 with SMTP id
 2adb3069b0e04-5343886124bmr12461107e87.40.1724864905510; Wed, 28 Aug 2024
 10:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 28 Aug 2024 19:08:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
Message-ID: <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Pingfan Liu <piliu@redhat.com>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 16:55, Pingfan Liu <piliu@redhat.com> wrote:
>
> *** Background ***
>
> As more PE format kernel images are introduced, it post challenge to kexec to
> cope with the new format.
>
> In my attempt to add support for arm64 zboot image in the kernel [1],
> Ard suggested using an emulator to tackle this issue.  Last year, when
> Jan tried to introduce UKI support in the kernel [2], Ard mentioned the
> emulator approach again [3]
>
> After discussion, Ard's approach seems to be a more promising solution
> to handle PE format kernels once and for all.  This series follows that
> approach and implements an emulator to emulate EFI boot time services,
> allowing the efistub kernel to self-extract and boot.
>
> Another year has passed, and UKI kernel is more and more frequently used
> in product. I think it is time to pay effort to resolve this issue.
>
>
> *** Overview of implement ***
> The whole model consits of three parts:
>
> -1. The emulator
> It is a self-relocatable PIC code, which is finally linked into kernel, but not
> export any internal symbol to kernel.  It mainly contains: a PE file parser,
> which loads PE format kernel, a group of functions to emulate efi boot service.
>
> -2. inside kernel, PE-format loader
> Its main task is to set up two extra kexec_segment, one for emulator, the other
> for passing information from the first kernel to emulator.
>
> -3. set up identity mapping only for the memory used by the emulator.
> Here it relies on kimage_alloc_control_pages() to get pages, which will not
> stamped during the process of kexec relocate (cp from src to dst). And since the
> mapping only covers a small range of memory, it cost small amount memory.
>
>
> *** To do ***
>
> Currently, it only works on arm64 virt machine. For x86, it needs some slightly
> changes. (I plan to do it in the next version)
>
> Also, this series does not implement a memory allocator, which I plan to
> implement with the help of bitmap.
>
> About console, currently it hard code for arm64 virt machine, later it should
> extract the information through ACPI table.
>
> For kdump code, it is not implmented yet. But it should share the majority of
> this series.
>
>
> *** Test of this series ***
> I have tested this series on arm64 virt machine. There I booted the vmlinuz.efi
> and kexec_file_load a UKI image, then switch to the second kernel.
>
> I used a modified kexec-tools [4], which just skips the check of the file format and passes the file directly to kernel.
>
> [1]: https://lore.kernel.org/linux-arm-kernel/ZBvKSis+dfnqa+Vz@piliu.users.ipa.redhat.com/T/#m42abb0ad3c10126b8b3bfae8a596deb707d6f76e
> [2]: https://lore.kernel.org/lkml/20230918173607.421d2616@rotkaeppchen/T/
> [3]: https://lore.kernel.org/lkml/20230918173607.421d2616@rotkaeppchen/T/#mc60aa591cb7616ceb39e1c98f352383f9ba6e985
> [4]: https://github.com/pfliu/kexec-tools.git branch: kexec_uefi_emulator
>
>
> RFCv1 -> RFCv2:
> -1.Support to run UKI kernel by: add LoadImage() and StartImage(), add
>    PE file relocation support, add InstallMultiProtocol()
> -2.Also set up idmap for EFI runtime memory descriptor since UKI's
>    systemd-stub calls runtime service
> -3.Move kexec_pe_image.c from arch/arm64/kernel to kernel/, since it
>    aims to provide a more general architecture support.
>
> RFCv1: https://lore.kernel.org/linux-efi/20240718085759.13247-1-piliu@redhat.com/
> RFCv2: https://github.com/pfliu/linux.git  branch kexec_uefi_emulator_RFCv2
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Jan Hendrik Farr <kernel@jfarr.cc>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-efi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
>
>
> Pingfan Liu (9):
>   efi/libstub: Ask efi_random_alloc() to skip unusable memory
>   efi/libstub: Complete efi_simple_text_output_protocol
>   efi/emulator: Initial rountines to emulate EFI boot time service
>   efi/emulator: Turn on mmu for arm64
>   kexec: Introduce kexec_pe_image to parse and load PE file
>   arm64: kexec: Introduce a new member param_mem to kimage_arch
>   arm64: mm: Change to prototype of
>   arm64: kexec: Prepare page table for emulator
>   arm64: kexec: Enable kexec_pe_image
>

Thanks for putting this RFC together. This is useful work, and gives
us food for thought and discussion.

There are a few problems that become apparent when going through these changes.

1. Implementing UEFI entirely is intractable, and unnecessary.
Implementing the subset of UEFI that is actually needed to boot Linux
*is* tractable, though, but we need to work together to write this
down somewhere.
  - the EFI stub needs the boot services for the EFI memory map and
the allocation routines
  - GRUB needs block I/O
  - systemd-stub/UKI needs file I/O to look for sidecars
  - etc etc

I implemented a Rust 'efiloader' crate a while ago that encapsulates
most of this (it can boot Linux/arm64 on QEMU and boot x86 via GRUB in
user space **). Adding file I/O to this should be straight-forward -
as Lennart points out, we only need the protocol, it doesn't need to
be backed by an actual file system, it just needs to be able to expose
other files in the right way.

2. Running the UEFI emulator on bare metal is not going to scale.
Cloning UART driver code and MMU code etc is a can of worms that you
want to leave closed. And as Lennart points out, there is other
hardware (TPM) that needs to be accessible as well. Providing a
separate set of drivers for all hardware that the EFI emulator may
need to access is not a tractable problem either.

The fix for this, as I see it, is to run the EFI emulator in user
space, to the point where the payload calls ExitBootServices(). This
will allow all I/O and memory protocol to be implemented trivially,
using C library routines. I have a crude prototype** of this running
to the point where ExitBootServices() is called (and then it crashes).
The tricky yet interesting bit here is how we migrate a chunk of user
space memory to the bare metal context that will be created by the
kexec syscall later (in which the call to ExitBootServices() would
return and proceed with the boot). But the principle is rather
straight-forward, and would permit us, e.g., to kexec an OS installer
too.

3. We need to figure out how to support TPM and PCRs in the context of
kexec. This is a fundamental issue with verified boot, given that the
kexec PCR state is necessarily different from the boot state, and so
we cannot reuse the TPM directly if we want to pretend that we are
doing an ordinary boot in kexec. The alternative is to leave the TPM
in a state where the kexec kernel can access its sealed secrets, and
mock up the TCG2 EFI protocols using a shim that sits between the TPM
hardware (as the real TCG2 protocols will be long gone) and the EFI
payload. But as I said, this is a fundamental issue, as the ability to
pretend that a kexec boot is a pristine boot would mean that verified
boot is broken.


As future work, I'd like to propose to collaborate on some alignment
regarding a UEFI baseline for Linux, i.e., the parts that we actually
need to boot Linux.

For this series in particular, I don't see a way forward where we
adopt this approach, and carry all this code inside the kernel.

Thanks.
Ard.

