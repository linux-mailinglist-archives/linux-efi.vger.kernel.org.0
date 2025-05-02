Return-Path: <linux-efi+bounces-3534-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D392AAA730C
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 15:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DF198621E
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9590D255E4E;
	Fri,  2 May 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUhxmlE7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6848225524D;
	Fri,  2 May 2025 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191496; cv=none; b=mCSxum4vTksIGJh7RNYpnhDS4Fm/lVOk6MrUCpceU8QBDEDWj2wgiN0TAuXeQCylP24l79D4EQ5hmyLFe0rPPeWjjLCIPdCS02tyJShZ9PdkDqZAjJ+tnH5rQsFn22Rru5cm+HI3kurpxnJpKInGxTukTizFPtmTRP67IyaMFgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191496; c=relaxed/simple;
	bh=LK0m5S09uQwymDotmRqGkjff/YzKrTkEZb8rKc78Zl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FX0drIoeAlJ/saEVfADgl3gCu+DaZKz0CTvmBNshT+BwOPQ4EJuGevaVrNo6Sl2h/xyh8lBn++e4aGtC5LEv5Ari1BwYAgoysTbEFQsLrEj5kAzhynsgUqIBR7ZE3q1zzeaHlNXAaWmm9hObUc/iRh88wpIcNJUj32eA9haIIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUhxmlE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D669BC4CEF8;
	Fri,  2 May 2025 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746191494;
	bh=LK0m5S09uQwymDotmRqGkjff/YzKrTkEZb8rKc78Zl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jUhxmlE7p5g3OiQZe9EksPASqITZJGH4jIbjwfsKL9nuFRn2kL2uAM9NCURs8a1f/
	 SUNH5GaSmXAzuK4iXDuB+JRgRoNGCkCokwb+rMAwhC8cEkKTKITnYZVKSDztDB5J2p
	 7DqXFBb5lscZWAyV1PW46TNQ5BCEL4U1HzWfwWzxBtXBcCPrPfwcjMFldnXX7oAcJO
	 /bd/7qZdVmbPPsPvutLDGuADRnSBGEbhOzuXcJ0ZXPfUlwbrgZr3wMiO2jO59ozzvC
	 IlhoQOSFZyG4gYVPfYdNP+hjx5CpDYZaCL8mKUeS6L5WqICjfwnw0o4AIR1tK6GHmB
	 /it+jwvCSmvpw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54d65cb6e8aso2712265e87.1;
        Fri, 02 May 2025 06:11:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYP0X9Sm6nKf3nfoD3R34UD2er/PNLFuxPoQRqWkNbEakw5Fpa21FO1nDl/ejBq92PJeHHXup0qyU=@vger.kernel.org, AJvYcCWo45LK4oO4adK0kD8wIUN9Fyvu1QzeVNJbyLaJqtZzWKX/J8NZnDx4ylUFaMB85tWqGOFxhsg+xxW2UbZ4@vger.kernel.org, AJvYcCXtZUDSS669j8BU/kjtpmkX01mtHvBKbMSY6QLUXvQ7KnzWh2ojMWy2WnU8W872vGG0TmgxENAQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwUR1LZl1DEbyjf5dE33iCgd+q2V55hEAlMxeaCRxGxvWSARYqY
	ALzRreW9MrpXW7F/dnsIgYLXMV6y7cLgyTSrvOZQLEL4gLDyc9YsA0g/v/Slj+LhiuEQaeVhuXM
	g5NmG1vaErewQ/29FVHNMWQKPZec=
X-Google-Smtp-Source: AGHT+IEdEEn4W75TgYFwhDu2BtCWaI+eVQnfNjJ68WUtHAcceaTNv5VfX2OxYTlSQ9shxVvG495+ttDBaOpQ0AnuP1A=
X-Received: by 2002:a05:6512:234f:b0:549:66d8:a1f3 with SMTP id
 2adb3069b0e04-54eac2332camr731440e87.40.1746191493168; Fri, 02 May 2025
 06:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428174322.2780170-2-ardb+git@google.com> <0ad5e887-e0f3-6c75-4049-fd728267d9c0@amd.com>
In-Reply-To: <0ad5e887-e0f3-6c75-4049-fd728267d9c0@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 2 May 2025 15:11:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE7=u9xNcUHiyFVPbOpwPvntFjdLfTzD0LeD_7it2MEQg@mail.gmail.com>
X-Gm-Features: ATxdqUHCnZY8z4Ary2AT3uxsxUGdTmlnVzUmAj4WTaZo_j0E0mElkzIG8dLedpk
Message-ID: <CAMj1kXE7=u9xNcUHiyFVPbOpwPvntFjdLfTzD0LeD_7it2MEQg@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/sev: Support memory acceptance in the EFI stub
 under SVSM
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 May 2025 at 20:05, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 4/28/25 12:43, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Commit
> >
> >   d54d610243a4 ("x86/boot/sev: Avoid shared GHCB page for early memory acceptance")
> >
> > provided a fix for SEV-SNP memory acceptance from the EFI stub when
> > running at VMPL #0. However, that fix was insufficient for SVSM SEV-SNP
> > guests running at VMPL >0, as those rely on a SVSM calling area, which
> > is a shared buffer whose address is programmed into a SEV-SNP MSR, and
> > the SEV init code that sets up this calling area executes much later
> > during the boot.
> >
> > Given that booting via the EFI stub at VMPL >0 implies that the firmware
> > has configured this calling area already, reuse it for performing memory
> > acceptance in the EFI stub.
>
> This looks to be working for SNP guest boot and kexec. SNP guest boot with
> an SVSM is also working, but kexec isn't. But the kexec failure of an SVSM
> SNP guest is unrelated to this patch, I'll send a fix for that separately.
>

Thanks for confirming.

Ingo, Boris, can we get this queued as a fix, please, and merge it
back into x86/boot as was done before?


> Thanks,
> Tom
>
> >
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> > Cc: Kevin Loughlin <kevinloughlin@google.com>
> > Cc: <stable@vger.kernel.org>
> > Fixes: fcd042e86422 ("x86/sev: Perform PVALIDATE using the SVSM when not at VMPL0")
> > Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> > Tom,
> >
> > Please confirm that this works as you intended.
> >
> > Thanks,
> >

