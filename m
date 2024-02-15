Return-Path: <linux-efi+bounces-557-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52689855DA0
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 10:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98D11F2EEAC
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 09:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AADA13FEE;
	Thu, 15 Feb 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWO6Fl3z"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B217585;
	Thu, 15 Feb 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988653; cv=none; b=spbcMOBjIhm5cQHSr5dgPpck5HnAkKkjKNoP8i8lAesuHsLXazwSs5tSGS0YKSglQxpwjkxYJMDrBMd7bsOFOyuO4TzB9KMJYNgnh22Bz1CDJQScl+NPYfRku8JviAOpVuVYR7GkHn2SZ8ZpbmIU3b5aey0cxk5SSARDOkGqMmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988653; c=relaxed/simple;
	bh=QZiznrS2WZfM5jOXwf3IdqrvwBaCJtTnQvrq4O0MPBo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qt6bJb9Vn4fw2uEZ7bajGeHDrHDRkGR78OP7zgD/eEeh+QVry23ThPLemXV8QiRHNQmve8ZGI3Sqxsa3uIkcPsDoGQEIBQ+vAPN+x6LzO4StKX1sBVHxZWAM56ifqCEYPY6YI/wdpJcuFw3gRVAARKgaK/2GEaHUEFAS1I0zt5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWO6Fl3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532B8C433B2;
	Thu, 15 Feb 2024 09:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707988653;
	bh=QZiznrS2WZfM5jOXwf3IdqrvwBaCJtTnQvrq4O0MPBo=;
	h=From:Date:Subject:To:Cc:From;
	b=uWO6Fl3zqsuK/hgQE5fu1onQlzrPtfdZRMDWOfXLvnfe9YrEwBEmipEO15+VUW6L1
	 cmxjyGLi00o/v2aVf43lLrbMwIGlzFCSF99Fwu9OGyIoB9gzjBLPoSDYwNlj05DnGh
	 iJov8VtTXsnNQ4lM/B15xK0PpQu3mn7zn9dRWH5DYQ+pdTEzwaUh8K8faitwYtDd3D
	 +l7n0joTr3gf1YhV9U3+SMRI54/hXuoDWNcpiXHAh3ih5/NxkPDCcfowyNpR3LrXNp
	 KM1IwvUeDpRUeb1mQYnMX2Agh7fJ9a2TPaRbM3a1PHphUjMjZwHXgO+PSbCFaUWtWz
	 4yFRYNcKiaINw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51182f8590bso779222e87.0;
        Thu, 15 Feb 2024 01:17:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtYR+6GUF6VWTaoWLqmLW4bbDMozhrz4E7sKOXdzFrZpkq7WNH2jPwuSOJDxtbishgX77CKOCuGE2mu30v708sKYg+Jh3ZROmT
X-Gm-Message-State: AOJu0Ywkhm71swu/0ec1Clbv4+Q6OPQyETOdQD3RGolhyeEv1MJdng4x
	9wNACaNkvWrnNZgT2geJ/Ti4R/qW29xUGCCWy/d/vKYeglBDhHiz2gEBFEaCfT5e8O9LFjz84Qj
	/fBjcQ/fwSvzieEufbKPKuiUk7rg=
X-Google-Smtp-Source: AGHT+IHswqCRJVEJAcStwpUMDg0QUZ+gkyp8zGMVICCUkF6T3wZcpIhgk7dYjhMVp0baPORTwbwcWaLv5Qe2FLJ5KvE=
X-Received: by 2002:a19:f011:0:b0:511:a2ed:f6cc with SMTP id
 p17-20020a19f011000000b00511a2edf6ccmr972818lfc.29.1707988651362; Thu, 15 Feb
 2024 01:17:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 10:17:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEGzHW07X963Q3q4VPEqUtKC==y152JyfuK_t=cZ0CKYA@mail.gmail.com>
Message-ID: <CAMj1kXEGzHW07X963Q3q4VPEqUtKC==y152JyfuK_t=cZ0CKYA@mail.gmail.com>
Subject: x86 efistub stable backports for v6.6
To: "# 3.4.x" <stable@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, 
	jan.setjeeilers@oracle.com, Peter Jones <pjones@redhat.com>, 
	Steve McIntyre <steve@einval.com>, Julian Andres Klode <julian.klode@canonical.com>, 
	Luca Boccassi <bluca@debian.org>
Cc: James Bottomley <jejb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

(cc stakeholders from various distros - apologies if I missed anyone)

Please consider the patches below for backporting to the linux-6.6.y
stable tree.

These are prerequisites for building a signed x86 efistub kernel image
that complies with the tightened UEFI boot requirements imposed by
MicroSoft, and this is the condition under which it is willing to sign
future Linux secure boot shim builds with its 3rd party CA
certificate. (Such builds must enforce a strict separation between
executable and writable code, among other things)

The patches apply cleanly onto 6.6.17 (-rc2), resulting in a defconfig
build that boots as expected under OVMF/KVM.

5f51c5d0e905 x86/efi: Drop EFI stub .bss from .data section
7e50262229fa x86/efi: Disregard setup header of loaded image
bfab35f552ab x86/efi: Drop alignment flags from PE section headers
768171d7ebbc x86/boot: Remove the 'bugger off' message
8eace5b35556 x86/boot: Omit compression buffer from PE/COFF image
memory footprint
7448e8e5d15a x86/boot: Drop redundant code setting the root device
b618d31f112b x86/boot: Drop references to startup_64
2e765c02dcbf x86/boot: Grab kernel_info offset from zoffset header directly
eac956345f99 x86/boot: Set EFI handover offset directly in header asm
093ab258e3fb x86/boot: Define setup size in linker script
aeb92067f6ae x86/boot: Derive file size from _edata symbol
efa089e63b56 x86/boot: Construct PE/COFF .text section from assembler
fa5750521e0a x86/boot: Drop PE/COFF .reloc section
34951f3c28bd x86/boot: Split off PE/COFF .data section
3e3eabe26dc8 x86/boot: Increase section and file alignment to 4k/512

1ad55cecf22f x86/efistub: Use 1:1 file:memory mapping for PE/COFF
.compat section


 arch/x86/boot/Makefile                  |   2 +-
 arch/x86/boot/compressed/vmlinux.lds.S  |   6 +-
 arch/x86/boot/header.S                  | 211 ++++++++++--------------
 arch/x86/boot/setup.ld                  |  14 +-
 arch/x86/boot/tools/build.c             | 273 ++------------------------------
 drivers/firmware/efi/libstub/Makefile   |   7 -
 drivers/firmware/efi/libstub/x86-stub.c |  46 +-----
 7 files changed, 112 insertions(+), 447 deletions(-)

