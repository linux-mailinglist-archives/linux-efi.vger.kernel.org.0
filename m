Return-Path: <linux-efi+bounces-3682-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4247AAB549E
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 14:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B8F862C6B
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 12:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A312725525C;
	Tue, 13 May 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOdlKIVO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB9242D6F
	for <linux-efi@vger.kernel.org>; Tue, 13 May 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747138975; cv=none; b=ej3HctUQ3tEoRfUKajSJonH/eRqouePInaDBCQXc6C7LTn48KVjn1O+I+5BR6jWW4j82eeqoXmTLJ9sKvNXSv6/h8L3+ZgyuAdPVv3efLnt0PlHCh6RUQiwLmP03M+0sOppeCbI4nFQC/Qv2GzDiFk/z7A6gSIiryqza3Rqrv0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747138975; c=relaxed/simple;
	bh=I1d0Lk9PVDZaeUnkDxHuqQe6CS/d5SpEWlZBdtBnEtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZC0k23tqL1AzRSEwZCkBtFkTQoh2u4rjvfcpu0E8a64fDCWO41SDzxsPSwMyLZZakt+lbjwmo2nRJUr1rzj3wuh/iKSy2k0blvawDON88oD3ZYgfXfnzNn0IB44X9z/WQqF8S+/VStDQRv4/gcUL3youjIrUEsLvl6wgW35HO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOdlKIVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF6AC4CEF2
	for <linux-efi@vger.kernel.org>; Tue, 13 May 2025 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747138974;
	bh=I1d0Lk9PVDZaeUnkDxHuqQe6CS/d5SpEWlZBdtBnEtA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DOdlKIVOR62QGoHbOVHVha5C5tcbiSravnwbKbucf4YVNok186ccD0Zlo7xfvE4OZ
	 oBzzv6kgsQsnnpOwTh3S3En96Xpjxm8WciKvjL26lH0LPrDu7bKba7HZPGfc/0rh6G
	 auEqUtos3bJSfOyPymQYz3nqRT9aloaIl0D9PhV6HkKSl1sXIFCdtxGBIoviTAS4z0
	 F0k8sJTTI3CyOu/0uQKThyvN5GgY6y7Bj4z95uK85a9uxYGef3OwFrQEZDiB4kllXq
	 IxZc0T+S5s4EzqtBpDN2zSxCxMPJuGGGXQUvi1O/mS+DOQ1v5csuYx/g6+tSAFqMQq
	 8Go5gRGKQcD3A==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54b1095625dso6619525e87.0
        for <linux-efi@vger.kernel.org>; Tue, 13 May 2025 05:22:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+txTRoMejrQVSxZJObIoKdqA9in/mGrfweOL8v3AN3kIDFCJKwmkzOCu7oqXWUfhCTUoZ8Hil2dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFvsXgeo//oBsRWz29BQmds3uzMsvBu1mFukQz1ke3PwRNBzT
	YCUfSyjrPRd7B9tJW/4YqAfXHL4frvDo0jZwlKoMVzufyb4v/SleR1zWx/q5qcakMqo4Dj06iQ3
	LC5/hHYZoEUI0+bNmsW1FlhMso80=
X-Google-Smtp-Source: AGHT+IG9SnIZgc8uSZIBaEIfEi+Td/GMCxCQxgqDtVQZ3Q1Ww5NiWThDJsY7RxifX3lhyfORi0v8bnTPS5d7OebUXxg=
X-Received: by 2002:a05:6512:4505:b0:54e:86f3:5e52 with SMTP id
 2adb3069b0e04-54fc67caf15mr4480822e87.33.1747138973245; Tue, 13 May 2025
 05:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505154523.231233-1-vkuznets@redhat.com> <20250505154523.231233-3-vkuznets@redhat.com>
 <CAMj1kXE5iVsKSEcEPqJs4bZpB03FYR9OcstDVUKNax=2y8nsAg@mail.gmail.com> <8734d9oosf.fsf@redhat.com>
In-Reply-To: <8734d9oosf.fsf@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 13 May 2025 13:22:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFpO+qya2Nngrj-eUPXQo4WMd2ZRn5EqD-46J85hLMSeg@mail.gmail.com>
X-Gm-Features: AX0GCFsjCuUcp41DBALvKL6-fgOvsTNBH_UUVLlzrg5OL_OAURlAHC7SHW68J8k
Message-ID: <CAMj1kXFpO+qya2Nngrj-eUPXQo4WMd2ZRn5EqD-46J85hLMSeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Implement support for embedding SBAT data
 for x86
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
	Emanuele Giuseppe Esposito <eesposit@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Luca Boccassi <bluca@debian.org>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 16:02, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > On Mon, 5 May 2025 at 17:46, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
...
> >> +       .ascii  ".text\0\0\0"
> >> +#ifdef CONFIG_EFI_SBAT
> >> +       .long   ZO__sbat                        # VirtualSize
> >> +       .long   setup_size                      # VirtualAddress
> >> +       .long   ZO__sbat                        # SizeOfRawData
> >> +#else
> >> +       .long   ZO__data                        # VirtualSize
> >> +       .long   setup_size                      # VirtualAddress
> >> +       .long   ZO__data                        # SizeOfRawData
> >> +#endif
> >> +       .long   setup_size                      # PointerToRawData
> >
> > Would it work if we do the following here
> >
> > #ifdef CONFIG_EFI_SBAT
> >   .set .Ltextsize, ZO__sbat
> > #else
> >   .set .Ltextsize, ZO__data
> > #endif
> >
> > and keep a single section definition for .text
> >
> >   .ascii  ".text\0\0\0"
> >   .long   .Ltextsize                  # VirtualSize
> >   .long   setup_size                  # VirtualAddress
> >   .long   .Ltextsize                  # SizeOfRawData
> >   .long   setup_size                  # PointerToRawData
> >
>
> As we already have '#ifdef CONFIG_EFI_SBAT' below I'd suggest we set
> textsize there, basically:
>
> @@ -199,16 +194,20 @@ pecompat_fstart:
>                 IMAGE_SCN_MEM_EXECUTE           # Characteristics
>
>  #ifdef CONFIG_EFI_SBAT
> -       .ascii ".sbat\0\0\0"
> -       .long   ZO__esbat - ZO__sbat            # VirtualSize
> -       .long   setup_size + ZO__sbat           # VirtualAddress
> -       .long   ZO__esbat - ZO__sbat            # SizeOfRawData
> -       .long   setup_size + ZO__sbat           # PointerToRawData
> +       .ascii  ".sbat\0\0\0"
> +       .long   ZO__esbat - ZO__sbat            # VirtualSize
> +       .long   setup_size + ZO__sbat           # VirtualAddress
> +       .long   ZO__esbat - ZO__sbat            # SizeOfRawData
> +       .long   setup_size + ZO__sbat           # PointerToRawData
>
>         .long   0, 0, 0
>         .long   IMAGE_SCN_CNT_INITIALIZED_DATA  | \
>                 IMAGE_SCN_MEM_READ              | \
>                 IMAGE_SCN_MEM_DISCARDABLE       # Characteristics
> +
> +       .set textsize, ZO__sbat
> +#else
> +       .set textsize, ZO__data
>  #endif
>
>         .ascii  ".data\0\0\0"
>
> and nobody seems to care that we use it first and define/set it later.
>

Yeah that looks fine.

> BTW, does '.L' prefix you suggest has a meaning here? I see we don't use
> it for e.g. 'pecompat_fstart', 'section_count'.
>

The .L prefix prevents the symbols from ending up in the ELF file -
you can drop it if you like, it doesn't really matter one way or the
other.

