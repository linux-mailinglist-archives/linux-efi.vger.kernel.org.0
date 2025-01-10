Return-Path: <linux-efi+bounces-2562-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E62AA088F5
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 08:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934133A9256
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 07:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D622066CB;
	Fri, 10 Jan 2025 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSWPXrXq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3284205E05;
	Fri, 10 Jan 2025 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494493; cv=none; b=BtUImU4oB03/opvcZfLjjfrcYMxP/KZWqe4GKfFosFdWrTIInNb0iGFvESqv22tOXPR9yTU4HJiFZ89dzUy5A78vwu1PybVL+gtA7w07kON0R+IXNChQuCVa4Sm8LOploeVrICAoN+ghmn4cGZBfd72lgXLA2qSOPgdtp3Fi6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494493; c=relaxed/simple;
	bh=kYqbSLzknzruTkzUb3qvktdfdDW95zy1Jf8hzJJDvMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbqap/L4znnyKaVMRbHT2/Ov+ZTqKhpeOe/KBIi/h06D/UqKEynZ41DPM8flh+D7E+Uidpd3O+WjSTt+sxi//4Qu1BgLJQotIBl26N5eslqkcAhm3x5rHp0d+Q7TNJhJAqSO/qNjZvwe17WQ+sF3CsatEwoq1YL5GYA2VjUMnv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSWPXrXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D75DC4CEE0;
	Fri, 10 Jan 2025 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494492;
	bh=kYqbSLzknzruTkzUb3qvktdfdDW95zy1Jf8hzJJDvMM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RSWPXrXq938Ij3QM6DZYS+bTFT/0HhHNLE+f8evIgqGIN0HqrHunna1C8DUEBqgh+
	 GMPIBrYuEkYWG3JYpbDeDsPA98WOnKmPZBehjAkSrLB7QJwR8Lns9q0P3FkB2c1Ky9
	 og172lpGKRWO0JB2zRIv2bNTsz3Iu6MPx8+qtCZIk7LfkRF7YyBrQGpKbVUVgA2qMC
	 A1gYS9/2xdmgx9Px0SHQqKZfxUo4oMQRUIoKjbcbMQXr4S9V+1blVFsWg9hFXUciHH
	 N5mM7PCnFnWIVEtogOsNS7xoiBSxJwXz2gnSOZhkNkJsTHd+xYjMXx17Q1e7WGqKdC
	 jlf3/Rsnpk4RQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e399e3310so1838140e87.1;
        Thu, 09 Jan 2025 23:34:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkaewyXkeyFecRzfvx2zYolT5RPIosVRxktcCaRX0X+T7KwbcmonBpjgvBojgUqU8TFRp8Wxb3a/VWWzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Lgvu4FbLaJmSM3PEmkZQJUrjCsAzLeYYtaFq6SOJBozR/gPO
	GhS0iSkJQvRd81lgAnx59G8UrlXihVV5+AcXSS9ooZkmcBzJuSSrIzKfa9H3hbDjoKJq8slhMqs
	qmeK9M8ualyAKXLvCFz+zuDJMHTw=
X-Google-Smtp-Source: AGHT+IHcf2xM9VvsYkjaloDENOtP+ZvDGKm/5QwUX3w3+EsHJCn4Dx75mqct7KEITe06bcj8EHmwCzJigOu+TQuR7FA=
X-Received: by 2002:ac2:4e08:0:b0:540:2ff1:309d with SMTP id
 2adb3069b0e04-542845c56cfmr3059582e87.34.1736494490953; Thu, 09 Jan 2025
 23:34:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com> <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
 <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
In-Reply-To: <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Jan 2025 08:32:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
X-Gm-Features: AbW1kvad1Ep7ZJNKHY5SzNw-aw7vA2PCxxRZNUDwL7taXhAPV5dXJQCNTI_QuUA
Message-ID: <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	hannes@cmpxchg.org, dyoung@redhat.com, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 17:32, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 09/01/2025 16:15, Ard Biesheuvel wrote:
> > On Wed, 8 Jan 2025 at 23:00, Usama Arif <usamaarif642@gmail.com> wrote:
> >>
> >> When this area is not reserved, it comes up as usable in
> >> /sys/firmware/memmap. This means that kexec, which uses that memmap
> >> to find usable memory regions, can select the region where
> >> efi_mem_attr_table is and overwrite it and relocate_kernel.
> >>
> >> Since the patch in [1] was merged, all boots after kexec
> >> are producing the warning that it introduced.
> >>
> >> Having a fix in firmware can be difficult to get through.
> >
> > I don't follow. I don't think there is anything wrong with the
> > firmware here. Could you elaborate?
> >
>
> So the problem is, kexec sees this memory as System RAM, and decides
> it can be used to place an image here.
>
> I guess the question is (and I actually don't know the answer here),
> whose responsibility is it to mark this region as reserved so that
> its not touched by anyone else. I would have thought it should be
> firmware?
>

No, it is the OS. The firmware only reserves regions that are needed
for its own correct operation at runtime. For informational tables
such as this one, it is up to the OS whether it wants to reserve it
and keep it in place, consume it and release the memory, or ignore it
altogether.

> Maybe its not the firmwares' job to mark it as reserved, but just pass
> it to kernel and the kernel is supposed to make sure it gets reserved
> in a proper way, even across kexecs.
>

Indeed.

> I think in the end whoevers' responsibility it is, the easiest path forward
> seems to be in kernel? (and not firmware or libstub)
>

Agreed. But as I pointed out in the other thread, the memory
attributes table only augments the memory map with permission
information, and can be disregarded, and given how badly we mangle the
memory map on x86, maybe this is the right choice here.

> >
> >> The next ideal place would be in libstub. However, it looks like
> >> InstallMemoryAttributesTable [2] is not available as a boot service
> >> call option [3], [4], and install_configuration_table does not
> >> seem to work as a valid substitute.
> >>
> >
> > To do what, exactly?
> >
>
> To change the memory type from System RAM to either reserved or
> something more appropriate, i.e. any type that is not touched by
> kexec or any other userspace.
>
> Basically the example code I attached at the end of the cover letter in
> https://lore.kernel.org/all/20250108215957.3437660-1-usamaarif642@gmail.com/
> It could be EFI_ACPI_RECLAIM_MEMORY or EFI_RESERVED_TYPE, both of which aren't
> touched by kexec.
>

This is a kexec problem (on x86 only) so let's fix it there.

