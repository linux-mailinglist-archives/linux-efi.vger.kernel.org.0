Return-Path: <linux-efi+bounces-5258-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEC2C20C93
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D989D1A23DD5
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 14:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C627CB35;
	Thu, 30 Oct 2025 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdjLMwuF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8192773F9
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835953; cv=none; b=FaSu7j/MwZs9tMTVjkPY89Hpajh1JPE2bJBqrH3P7ZNilkXW7cQt3wI+crmkCld2L0D3TOe0ZgVyfoYMxtKI7DnhLd5ndQj8AbhWzd5FHWPXtosprjOp3/oLgZ0dBQCz9G1Uo/rg5hUmaEaOiaVr3hs1lJID+b1VdlCTdDX/MUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835953; c=relaxed/simple;
	bh=MwA979kR7JhZAfFkfzHJO13jyEVBAnwcdUBbaUPBNDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjIH95zaMdbYgKuK2jJ8Xcya+TOykwPdszlxPAU04jKz6dwO3Nzq2IeSKTKjC8XIco1Bsd9eb2w8OvNXPexJ/ZKjoXI6gM0ICrqEtuEEgjFoq9l4XZ47vSAJ4e2aoovSrv/sN6kwJjSu7B7qyiP6MJa+9As5IU3MIQVRdtirqzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdjLMwuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275CAC4CEF1
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761835952;
	bh=MwA979kR7JhZAfFkfzHJO13jyEVBAnwcdUBbaUPBNDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VdjLMwuFuHUPgFaHrRn0v0fstulBaLjTG+83BJJ2A6EUamxWt1FnC4NtGGk7snUX/
	 VFSPlq6yg4vAX+CGWs64jMkp3HFyJIW/9zaoA+RzZXofmDSOdNAHqaWMr7waO2RZgU
	 h/lb63DDNseXy8Mb3wUy2SxXitj2rZEpDCinntWb4O7J3afyHHwKTyQxYV870tqtff
	 YyG2aiqCm/RRmoU2EdQshUtZOHyhhYTF+Gc+KY1AjwGn1aXifD9iF46i/Y+mhbvTBT
	 S+9NjKHX9ON8QViAsAYfcGx2XhkgPeVMuEcTNvKB08/8jWa+coMKwiVdXv0C9CMUHz
	 HASMGQSIlkPgg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-592f098f7adso392613e87.0
        for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 07:52:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YwOq2w7hXK2vjQzQTjUDyM5eojpWnf7eOw51chgckpBAGPxkoeO
	EIG7A+w8rbt4147BCpPnKvvBA5be0g/vrIOrVUfxzwXJPiw63OrBQwTUVW1lkGZ3uQvOsdSrLNZ
	rn9cFewAWKzPjMT/yci8TmV5Cmgp+NDc=
X-Google-Smtp-Source: AGHT+IEmJYaLKpnIcvX22qOYwwRwAvrgrTNiN+zxLirnrgKEiG1ICDVlDLekPiejuEf+sLDXNomCfruws1l0g6gGQ8U=
X-Received: by 2002:a05:6512:234c:b0:594:1957:a379 with SMTP id
 2adb3069b0e04-5941d4f51c8mr8207e87.6.1761835950472; Thu, 30 Oct 2025 07:52:30
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8-FqnVn=dwOhbNHcmZjdM_htr9m-1FPtEoUBGA14EJSVbCgw@mail.gmail.com>
In-Reply-To: <CAP8-FqnVn=dwOhbNHcmZjdM_htr9m-1FPtEoUBGA14EJSVbCgw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 30 Oct 2025 15:52:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG2STQhNhy3rgm+4JmGZZiyK0AFruM6fwNai=LA6is+1g@mail.gmail.com>
X-Gm-Features: AWmQ_bn2x5uvluP_8g2o_LjYHDkR4H7XBRCINPcfKCAEtFDbEiU1cxIisMoQ8rY
Message-ID: <CAMj1kXG2STQhNhy3rgm+4JmGZZiyK0AFruM6fwNai=LA6is+1g@mail.gmail.com>
Subject: Re: Secure boot with the (not deprecated) EFI protocol
To: Costin Manolache <costin@gmail.com>
Cc: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Sept 2025 at 07:57, Costin Manolache <costin@gmail.com> wrote:
>
> Hi,
>
> With UKI and the deprecated protocol - signing the combined
> (stub,kernel,cmdline,initrd) works as documented.
>

UKI uses systemd-stub, which is based on LoadImage/StartImage and the
initrd loading protocol, except when booting very old x86 kernels.

> I've been trying to use the new recommended protocol - i.e. LoadImage
> and StartImage, with kernel
> loading initrd from the kernel stub. The first problem is that initrd
> is not verified - that can be addressed in a
> UKI-like stub that loads initrd and checks the SHA against some  value
> added to an UKI section,
> before starting the kernel - seems to work fine even if initrd ends up
> getting loaded 2x. It would be
> nice if the kernel stub had a command option to check the initrd sha directly.
>

The kernel's EFI stub is intentionally kept minimal: if authentication
is required, it needs to be performed by the loader implementing the
initrd loading protocol, or by the kernel when it unpacks the initrd
into memory. The EFI stub does measure the initrd into the TPM if the
TCG2 protocols are available, as the next opportunity to communicate
with the TPM may be long after the initrd has been loaded.

> What I can't figure out is getting StartImage to work - it will fail
> if the kernel EFI is not signed (access_denied).
> It works if the kernel is signed - however a signed kernel can be
> extracted and used to boot with arbitrary command line
> and initrd, so anyone can get a root shell.
>

This is why it should be the kernel's job to authenticate the initrd
and command line before ingesting them. I am aware that things don't
work like that today, but this is not an issue with the old vs the new
protocol. This is also why TPM measured boot based full disk
encryption is typically deployed alongside secure boot, so that this
root shell does not actually give you access to the system.

Note that there is a glaring hole in the TCG PC client spec (which
describes measured boot on EFI systems) as the command line (aka Load
Options) are not measured into the TPM by default - the loader needs
to do so explicitly.

> So far the only option I found is to build a custom kernel with a
> cmdline built-in and not allowing
> cmdline modifications. It also needs the initrd built-in - and if both
> cmdline and initrd are included
> there is no need for a stub, which is nice - what is less nice is
> passing the dm-verity sha, or
> having to rebuild the kernel every time the rootfs changes and a new
> dm-verity needs to
> be configured. There are some workarounds for this - but at this point
> I'm wondering if
> I am missing something obvious ?
>

No, I don't think you're missing something, this is simply the state of things.

> The goal is to guarantee that only signed rootfs, initrd, cmdline and
> kernel can be loaded when secure boot is enabled, and can't be changed.
>
> Thanks
>

