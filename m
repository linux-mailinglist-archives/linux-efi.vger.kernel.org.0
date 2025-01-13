Return-Path: <linux-efi+bounces-2614-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6441BA0BF8A
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 19:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C3F3A0647
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jan 2025 18:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403E513AA31;
	Mon, 13 Jan 2025 18:05:13 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4096C24022F
	for <linux-efi@vger.kernel.org>; Mon, 13 Jan 2025 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736791513; cv=none; b=Xg6P4msthJPgGejQMQ/tI3S2ZoyJhOod21fy1gP8HsJesK/UHGI90yaRKIVH3poHB+m4aDkSw9/NmdYYdQaMLohban6nutsqartlfHgrVebIoBRf8pDwh8v24l3D+oscJGgTAn1ptvMh/DsXog8yCBaxgS2eaOEOCnhvclnKdLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736791513; c=relaxed/simple;
	bh=IDireyiqH5hAkdeW+Ja0aZLRhypIakqsJQVg2bkoIrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SC4ACxjzX8opHUSfZbgxK5kWv9QhIYnK+VjDq7wkC7rQz/NLFh2csiFr4lxgeEPa0LtXqNmz9msA7xAENQCcrvFjXN71THyQJsup/B8L5J5clOSns3g4GgLBrHzVRrRY3cFpwfXu5eyviodidZ4b+SCCWBs9vjuF5EQ7vwn89TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D2A12FC;
	Mon, 13 Jan 2025 10:05:38 -0800 (PST)
Received: from [172.27.42.101] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EBFB3F66E;
	Mon, 13 Jan 2025 10:05:10 -0800 (PST)
Message-ID: <77fe7e38-9e30-41f8-8121-26f493a7d913@arm.com>
Date: Mon, 13 Jan 2025 12:05:08 -0600
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] efi/zboot: Encapsulate ELF image for arm64
To: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
References: <20241218150316.1583806-6-ardb+git@google.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20241218150316.1583806-6-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

So this boots in my test environments, but has the usual set of issues 
around various user-space utilities not recognizing it.

A couple things to think about:

Should the PE header 'zimg' type (or something else in the header) be 
tweaked so that the payload PE vs ELF can be detected before the image 
is decompressed? Right now for example, kexec-tools decompresses the 
image and then tosses it because the resulting decompressed image isn't 
understood as a loadable kernel. This is a trivial fix, but if in the 
future the plan is to be able to load these images directly by 
kexec_file_load() ideally kexec would know this before it attempts to 
decompress the image.

I think this needs a Kconfig entry to enable/disable it until all the 
userspace tools have been updated.

Thanks!


On 12/18/24 9:03 AM, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The EFI zboot image format was introduced to provide a way to distribute
> an EFI bootable image for architectures such as arm64, RISC-V and
> Loongarch supporting both compression and EFI secure boot signing.
> 
> To make this format easy to digest for other consumers than EFI firmware
> (e.g., qemu or kexec), the file header describes the compression type
> and the offset and size of the compressed image inside the file.
> Additional metadata of the payload is currently injected using ELF
> symbols (currently, the size of the executable image's code region on
> arm64), but this information is not accessible to other consumers unless
> it is exposed either via the header, or via the payload itself.
> 
> It would be better to have a structured format inside the container, so
> that any annotation can be added without the need to tweak the EFI zboot
> header layout. On x86, the legacy decompressor encapsulates an ELF
> image, so that ELF notes can be used for arbitrary metadata, and this
> is heavily used by Xen.
> 
> Let's implement something similar for the generic EFI zboot format. This
> removes the need for per-arch hacks to inject symbols, and makes a
> future alignment of EFI zboot with x86 more feasible as well.
> 
> So switch to the ELF format for the EFI zboot payload, but implement it
> in such a way that decompressing the entire ELF image is unnecessary.
> Instead, decompress the ELF file header and program headers first, and
> discard any file data that is not covered by a PT_LOAD program header
> (and therefore not part of the executable's memory image).
> 
> The latter approach permits EFI zboot to be used with unstripped ELF
> binaries, making EFI zboot suitable for future use as a hybrid bootable
> image and debug symbol library for the running kernel.
> 
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Pingfan Liu <piliu@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kees Cook <kees@kernel.org>
> 
> Ard Biesheuvel (4):
>    efi/libstub: Avoid legacy decompressor zlib/zstd wrappers
>    efi/zboot: Add support for ELF payloads
>    arm64/boot: Populate vmlinux ELF program headers
>    efi/arm64: Use ELF payload for EFI zboot
> 
>   arch/arm64/boot/Makefile                             |   4 -
>   arch/arm64/include/asm/efi.h                         |   2 +-
>   arch/arm64/kernel/image-vars.h                       |   4 -
>   arch/arm64/kernel/vmlinux.lds.S                      |  33 ++--
>   drivers/firmware/efi/libstub/Makefile                |   9 +-
>   drivers/firmware/efi/libstub/Makefile.zboot          |   6 +
>   drivers/firmware/efi/libstub/arm64-stub.c            |   2 +-
>   drivers/firmware/efi/libstub/arm64.c                 |  20 +--
>   drivers/firmware/efi/libstub/efistub.h               |   9 ++
>   drivers/firmware/efi/libstub/zboot-decompress-gzip.c |  77 ++++++++++
>   drivers/firmware/efi/libstub/zboot-decompress-zstd.c |  91 +++++++++++
>   drivers/firmware/efi/libstub/zboot-decompress.c      | 161 ++++++++++++++++++++
>   drivers/firmware/efi/libstub/zboot.c                 |  58 ++-----
>   drivers/firmware/efi/libstub/zboot.lds               |   7 +-
>   14 files changed, 391 insertions(+), 92 deletions(-)
>   create mode 100644 drivers/firmware/efi/libstub/zboot-decompress-gzip.c
>   create mode 100644 drivers/firmware/efi/libstub/zboot-decompress-zstd.c
>   create mode 100644 drivers/firmware/efi/libstub/zboot-decompress.c
> 
> 
> base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8


