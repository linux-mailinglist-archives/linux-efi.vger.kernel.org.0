Return-Path: <linux-efi+bounces-2616-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152E7A0FE63
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 03:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710EC7A29CC
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 02:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF99E1D514A;
	Tue, 14 Jan 2025 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EV0GbJgj"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2CB3596D
	for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820311; cv=none; b=H4gyJ1Vyw3NlQf/UC63LC4mJa0pO77Bz3XZNz6Cs+HAPKeiJh0L5vLus6Kz9csl96+o7RFa9jQDQ/OJVM+aHS5Jw+CriXD79s0vEEtfqE/UN8jd2ZqWbIMtRvWuO8ESNB1mDUrb+s3ITWSss89vlTptSf0dWgyzdPtrRJqOCI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820311; c=relaxed/simple;
	bh=rh4Oxw5qV+cZZrBIU8hwyvcwt+hztA15oi6O2L8wC4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAhRtVEhKiH548AMuzBPixB1pYPpDH9NzYQXSRyrJZo7v5bgfO/HCv5s9Pk7xeT0htFjUTM/r4tBm3xBsaFqgG+EBWCCBdZ7AS64Y9JOJm22tMg/39l2FuU7MhEPRj/oB5vFuROF2CnNmznkZwlVAawZIZJze0/0foQk3jyBz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EV0GbJgj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736820308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+DwWfmYC01UR9oe+4OrAI9ZzmALdtmNBlSZtiyDZOA=;
	b=EV0GbJgjwCQNUOvxay9Dk9ADHYOPGqpvHVIZuv+quznOi3avs6RknwOeBb9aSbFToJfq4W
	GPjeVCtT87U8PuJq+pm/DyLpYCMNHBknjykLOaxsXTR0x64q6t1VKSiFcMJSFsmGS+d9eV
	PvUcuTBkkjulkb8FDlUIyBXfeFjfiWM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Ih6fZeNAP2iqdRC_4yq7dQ-1; Mon, 13 Jan 2025 21:05:06 -0500
X-MC-Unique: Ih6fZeNAP2iqdRC_4yq7dQ-1
X-Mimecast-MFC-AGG-ID: Ih6fZeNAP2iqdRC_4yq7dQ
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso8820184a91.1
        for <linux-efi@vger.kernel.org>; Mon, 13 Jan 2025 18:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820305; x=1737425105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+DwWfmYC01UR9oe+4OrAI9ZzmALdtmNBlSZtiyDZOA=;
        b=HEoYnI/ID0Ah34cn0wCpzUdtDIBeYTojZaoqjC1wyx19qgFvWKBwETBraJLyAB5NCh
         bD9YOGqPMOgirezSgpbAWynhA+Ktm2hXVtGvPqSwq8N2iDmg9zvtwnenQZigjO0JCSX4
         vDGIOmO0wRVoKMCuw6EU8JFBQ7rkCcdt6WdbdWZ5pwoM0VsKuUf37OdnY0FPGBOlpMLZ
         HwMIO6Ai24sU2kDBLLLX/iEsM7hh749SjU5vnIsrW8NVFDyArpaozU5H4zlATPjf4RWm
         3WIdxumw4Y7TfXAWpUoY0aMMwW5W8h8Wo/xMBX5x0laSdz2Ie/dMCQ0hWKiScl33bzM4
         StNw==
X-Gm-Message-State: AOJu0Yz1CpxdnySgPtTep1y7mw1WuYCaUIPEy24dfeBvgukNHRbAF9Mk
	nQbjRwhxgjcCf9jSprXLqX5TnI1XX7Atj9/p4NzdsyVU0IrX/IgLnuyu+EX7JYJVsvcUUGTBcow
	ScpCfuEM416CipnWFx1Wp8lOMhMgG9NWVcrWu32VnOInUIuT0ovYM7cBH7fQk7DSTbeccRpTVmQ
	CxSU9thD0PiQKWYTj9su/3qFXe9ibzK3zB
X-Gm-Gg: ASbGncs+u7gsm/YSpVYD+xb5Y1A4v7V1vzu39/agRPnuw+5qdbInOzizK7YE6Dk2nRY
	NHTjWoBkl5PhDK43ZMslRi2YZR3X8vexQu3EryJU=
X-Received: by 2002:a17:90b:4ec8:b0:2ee:b6c5:1def with SMTP id 98e67ed59e1d1-2f548e9a78bmr33494007a91.8.1736820305569;
        Mon, 13 Jan 2025 18:05:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8Kog3xi1aMsVt/+k3UI6Ajpy9zvlje8z6ZoCRp05j6l8k2mlFREwa1Xry0kPw6bU15BXKG4vDUB4RathSMKs=
X-Received: by 2002:a17:90b:4ec8:b0:2ee:b6c5:1def with SMTP id
 98e67ed59e1d1-2f548e9a78bmr33493976a91.8.1736820305220; Mon, 13 Jan 2025
 18:05:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218150316.1583806-6-ardb+git@google.com>
In-Reply-To: <20241218150316.1583806-6-ardb+git@google.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 14 Jan 2025 10:04:53 +0800
X-Gm-Features: AbW1kvZK9eY7a3XGMgD4IGTByoHjl3GBGLSY2TW2QAAtGbPsh2gd_ZYchnUhiw8
Message-ID: <CAF+s44S55pJ6090QExhjCv4kJS3+za64m_=TGb1rzGphj4sJ-g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] efi/zboot: Encapsulate ELF image for arm64
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Jeremy Linton <jeremy.linton@arm.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard,

Sorry to reply late. A new approach sprints to my mind, but I am not
sure about its feasibility.

I sent out a RFC [1]. It can stick to our original goal: keep kernel
code immutable from various PE format

https://lore.kernel.org/bpf/20250114012831.4883-1-piliu@redhat.com/T/#u


On Wed, Dec 18, 2024 at 11:03=E2=80=AFPM Ard Biesheuvel <ardb+git@google.co=
m> wrote:
>
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
>   efi/libstub: Avoid legacy decompressor zlib/zstd wrappers
>   efi/zboot: Add support for ELF payloads
>   arm64/boot: Populate vmlinux ELF program headers
>   efi/arm64: Use ELF payload for EFI zboot
>
>  arch/arm64/boot/Makefile                             |   4 -
>  arch/arm64/include/asm/efi.h                         |   2 +-
>  arch/arm64/kernel/image-vars.h                       |   4 -
>  arch/arm64/kernel/vmlinux.lds.S                      |  33 ++--
>  drivers/firmware/efi/libstub/Makefile                |   9 +-
>  drivers/firmware/efi/libstub/Makefile.zboot          |   6 +
>  drivers/firmware/efi/libstub/arm64-stub.c            |   2 +-
>  drivers/firmware/efi/libstub/arm64.c                 |  20 +--
>  drivers/firmware/efi/libstub/efistub.h               |   9 ++
>  drivers/firmware/efi/libstub/zboot-decompress-gzip.c |  77 ++++++++++
>  drivers/firmware/efi/libstub/zboot-decompress-zstd.c |  91 +++++++++++
>  drivers/firmware/efi/libstub/zboot-decompress.c      | 161 +++++++++++++=
+++++++
>  drivers/firmware/efi/libstub/zboot.c                 |  58 ++-----
>  drivers/firmware/efi/libstub/zboot.lds               |   7 +-
>  14 files changed, 391 insertions(+), 92 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/zboot-decompress-gzip.c
>  create mode 100644 drivers/firmware/efi/libstub/zboot-decompress-zstd.c
>  create mode 100644 drivers/firmware/efi/libstub/zboot-decompress.c
>
>
> base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
> --
> 2.47.1.613.gc27f4b7a9f-goog
>


