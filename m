Return-Path: <linux-efi+bounces-3247-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F70A81D72
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 08:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AFE3AF1BF
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 06:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBD170809;
	Wed,  9 Apr 2025 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/199WpV"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583A18BEA;
	Wed,  9 Apr 2025 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181280; cv=none; b=Efmc6yKpNTL2UyE3dULIWptP2eV+TShy/HTw8zBgpafIOyrTZ1UZnj/UjmUwCgpV960i+J/9eifKs6FyEoLpN4rmViQIoSDjrZxtCqpy8/uqZZTTmoxLQqTlEg4lkf94BlmZkfAeh5BdNB7GZmkZzbULVd55ZTixHORblH+1z54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181280; c=relaxed/simple;
	bh=tAnhuqPwFhasG0wT5tgPZa+RdUWE8xN1d4wMwMHYA6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHkj25gXxWmO04JkyY03C9ge1xhQpRuMWcdORo5DM0aqP0UJTTo20IU4BpIoBrf+oXfljJpaUZy8SXBTYSW7f4xe6kMQ/NJDZisLaSPruZKDXYjulIlanWwOshKq/eOpsJI/7fNThXpukDgl9vnVpRiz3OaoeSfrsT0VDVrehzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/199WpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B97C4CEEB;
	Wed,  9 Apr 2025 06:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744181279;
	bh=tAnhuqPwFhasG0wT5tgPZa+RdUWE8xN1d4wMwMHYA6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q/199WpVdHsY33vUNd5Hh++7N3B0UV9HpFGS5Ktk5+lJquSoVVFgZhmXWm5boORWl
	 iHy44jqygDTDOixjcvYCtGpsuwkqLk5hM/hnrqcFRup0DFiWFXTd+s/tb1u/nve3Nn
	 UwD+hoqtuDPDi29En9Ou0C2dw2xqR9FRwNqOKwCxRxL/eJOw/E3Eqi0yQAV3JM4u01
	 /uCHk+8/HOesueebcn3JKJJ7uHtvQkrkOtlBca24G5e5TWe1YwQEuBlEPeaYNkKUre
	 xHmSH1j4Wmtj/eigsc7YYyoGwBv4EbQzBNWTxZ04T2msqNqVj4WfIaGSZ6Oh3cQR0w
	 6OLo+hbYtrLVw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30613802a04so68575781fa.2;
        Tue, 08 Apr 2025 23:47:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJzMLv/hCb9zghxkGobCkiT+7XARVANC4LxFGa5KS9H+3fD0nDkFRsNrG8WWs9bulT/dkIbprU3DhAZf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeqLKBROVMSQfdaiHvjrtbI2o+//0jvgRcjmat2q3wkbJ6L49L
	+9qu6kym5YNuEiga/j2+5j06bY2nUKfN8MyHmoSrvecUqAUHks45xKelWzeIJpwfFfP4FIHqpNj
	gjn3PiPXOg0hH3M140ZWylkKOAIQ=
X-Google-Smtp-Source: AGHT+IG0CPbkpvw2SR+BfGdZlFXcfdRseL9cpyZw4rMnMy/+KdLECAwPFKuImDonFnTB1bG5LG20V0Cvkq2+G79UCGg=
X-Received: by 2002:a2e:a992:0:b0:30b:d5ed:55c7 with SMTP id
 38308e7fff4ca-30f438c92aemr5453441fa.36.1744181278102; Tue, 08 Apr 2025
 23:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408085254.836788-9-ardb+git@google.com> <CAMzpN2hrmNhiT8Ppb_fSGW2XtCDY1aiR=2x6Fcv2gzD87r-Akg@mail.gmail.com>
In-Reply-To: <CAMzpN2hrmNhiT8Ppb_fSGW2XtCDY1aiR=2x6Fcv2gzD87r-Akg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Apr 2025 08:47:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEbLAUMSHe9uYGdtorTr7UBFiU6DHBhfzQjMs1QGLXXwQ@mail.gmail.com>
X-Gm-Features: ATxdqUGEyNldwUaPnAQotbzawBn_YuVxHEF7pih8b9QnYj7UWY3NmtUhIilgOjw
Message-ID: <CAMj1kXEbLAUMSHe9uYGdtorTr7UBFiU6DHBhfzQjMs1QGLXXwQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] x86: Refactor and consolidate startup code
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org, 
	linux-kernel@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Apr 2025 at 20:16, Brian Gerst <brgerst@gmail.com> wrote:
>
> On Tue, Apr 8, 2025 at 5:01=E2=80=AFAM Ard Biesheuvel <ardb+git@google.co=
m> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Reorganize C code that is used during early boot, either in the
> > decompressor/EFI stub or the kernel proper, but before the kernel
> > virtual mapping is up.
> >
> > v3:
> > - keep rip_rel_ptr() around in PIC code - sadly, it is still needed in
> >   some cases
> > - remove RIP_REL_REF() uses in separate patches
> > - keep __head annotations for now, they will all be removed later
> > - disable objtool validation for library objects (i.e., pieces that are
> >   not linked into vmlinux)
> >
> > I will follow up with a series that gets rid of .head.text altogether,
> > as it will no longer be needed at all once the startup code is checked
> > for absolute relocations.
> >
> > The SEV startup code needs to be moved first, though, and this is a bit
> > more complicated, so I will decouple that effort from this series, also
> > because there is a known issue that needs to be fixed first related to
> > memory acceptance from the EFI stub.
>
> Is there anything to verify that the compiler doesn't do something
> unexpected with PIC code generation like create GOT references?
>

I will propose something along the lines of what is already being done
for the EFI stub:

------%<------

STUBCOPY_RELOC-$(CONFIG_X86_64) :=3D R_X86_64_64

quiet_cmd_stubcopy =3D STUBCPY $@
      cmd_stubcopy =3D                                                    \
        $(STRIP) --strip-debug -o $@ $<;                                \
        if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then            \
                echo "$@: absolute symbol references not allowed in
the EFI stub" >&2; \
                /bin/false;                                             \
        fi;                                                             \
        $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@

