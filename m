Return-Path: <linux-efi+bounces-1669-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4196F96F1F3
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 12:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6FF1F24CA1
	for <lists+linux-efi@lfdr.de>; Fri,  6 Sep 2024 10:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D731CA69D;
	Fri,  6 Sep 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anX3CmUQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BD1C9ED1
	for <linux-efi@vger.kernel.org>; Fri,  6 Sep 2024 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620103; cv=none; b=jjKMS4PPLTJQ/SWgtSKo2e2dOO+pkzrSctOEtVNXPeVUTX5lkuWSibkToUg+JW+vltwLdklBVtogiF4ZS5q6PLhpof6PecVs0iV2KhjjZT8V9NkcvIqPWhQsyP3mERYEbAwIfnQGYK/5yhs7w4qezTqyB4iKHbqUsXHEZpXcS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620103; c=relaxed/simple;
	bh=jp4O9LW8IWcYH8uH5bziRTDZTtx57L9dUd6pC68Qnjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaFrA6AUwI1AP0/wFzVCbgmsguhZm80S49KirOJ49qM5N6ZeqwlLzNB2f97hyuDLTDqvPdo3CBptdPuewidOftuyA4+i/611RKXxxvLbYa+bfKLI8hhYLg1VtewuAFTPtbFMw64craTsss8MRZhaTOaCGe3/K/alunpcmnuqyWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=anX3CmUQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725620100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bz2nJuvJfSC/E6iHvxzgQOTw9UEW2x/G2ibR8rkxWXo=;
	b=anX3CmUQ1v9aeHRJarRtdn49e01IEsTRnLk4ZC7lMGgLlFF9ShuqWLyaS+sBrx89V2ep+J
	t/Bc4a6/gR7myK/WpJqEDSvU2mzhVRTuzFqCspiJUVQNcakoB4VTZ7DMaqhKvEgKn2+4IY
	E+fqWgspWsmWsyZ5wXjx6CFTK6IPNfs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-qM2hcHPQPPWgr4iBH0cb6Q-1; Fri,
 06 Sep 2024 06:54:57 -0400
X-MC-Unique: qM2hcHPQPPWgr4iBH0cb6Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40AB81956048;
	Fri,  6 Sep 2024 10:54:55 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.193.186])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 377013000238;
	Fri,  6 Sep 2024 10:54:46 +0000 (UTC)
Date: Fri, 6 Sep 2024 12:54:38 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Pingfan Liu <piliu@redhat.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Lennart Poettering <mzxreary@0pointer.de>, Jarkko Sakkinen
 <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He
 <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <20240906125438.1e54c5f6@rotkaeppchen>
In-Reply-To: <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
References: <20240819145417.23367-1-piliu@redhat.com>
	<CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Ard,
Hi Jan,

On Wed, 28 Aug 2024 19:08:14 +0200
Ard Biesheuvel <ardb@kernel.org> wrote:

[...]

> Thanks for putting this RFC together. This is useful work, and gives
> us food for thought and discussion.
> 
> There are a few problems that become apparent when going through these changes.
> 
> 1. Implementing UEFI entirely is intractable, and unnecessary.
> Implementing the subset of UEFI that is actually needed to boot Linux
> *is* tractable, though, but we need to work together to write this
> down somewhere.
>   - the EFI stub needs the boot services for the EFI memory map and
> the allocation routines
>   - GRUB needs block I/O
>   - systemd-stub/UKI needs file I/O to look for sidecars
>   - etc etc
> 
> I implemented a Rust 'efiloader' crate a while ago that encapsulates
> most of this (it can boot Linux/arm64 on QEMU and boot x86 via GRUB in
> user space **). Adding file I/O to this should be straight-forward -
> as Lennart points out, we only need the protocol, it doesn't need to
> be backed by an actual file system, it just needs to be able to expose
> other files in the right way.
> 
> 2. Running the UEFI emulator on bare metal is not going to scale.
> Cloning UART driver code and MMU code etc is a can of worms that you
> want to leave closed. And as Lennart points out, there is other
> hardware (TPM) that needs to be accessible as well. Providing a
> separate set of drivers for all hardware that the EFI emulator may
> need to access is not a tractable problem either.
> 
> The fix for this, as I see it, is to run the EFI emulator in user
> space, to the point where the payload calls ExitBootServices(). This
> will allow all I/O and memory protocol to be implemented trivially,
> using C library routines. I have a crude prototype** of this running
> to the point where ExitBootServices() is called (and then it crashes).
> The tricky yet interesting bit here is how we migrate a chunk of user
> space memory to the bare metal context that will be created by the
> kexec syscall later (in which the call to ExitBootServices() would
> return and proceed with the boot). But the principle is rather
> straight-forward, and would permit us, e.g., to kexec an OS installer
> too.

I mostly agree on what you have wrote. But I see a big problem in
running the EFI emulator in user space when it comes to secure boot.
The chain of trust ends in the kernel. So it's the kernel that needs to
verify that the image to be loaded can be trusted. But when the EFI
runtime is in user space the kernel simply cannot do that. Which means,
if we want to go this way, we would need to extend the chain of trust
to user space. Which will be a whole bucket of worms, not just a can.

That's why I tend more to Jan's suggestion to include the EFI runtime
in the kernel. Alas, that comes with it's own problem, as that requires
to run code in the kernel that was never intended to run in kernel
context. So even when we can trust the code not to be malicious, we
cannot trust it to not accidentally change the system state in a way
the kernel doesn't expect...

Let me throw an other wild idea in the ring. Instead of implementing
a EFI runtime we could also include a eBPF version of the stub into the
images. kexec could then extract the eBPF program and let it run just
like any other eBPF program with all the pros (and cons) that come with
it. That won't be as generic as the EFI runtime, e.g. you couldn't
simply kexec any OS installer. On the other hand it would make it
easier to port UKIs et al. to non-EFI systems. What do you think?

Thanks
Philipp

> 3. We need to figure out how to support TPM and PCRs in the context of
> kexec. This is a fundamental issue with verified boot, given that the
> kexec PCR state is necessarily different from the boot state, and so
> we cannot reuse the TPM directly if we want to pretend that we are
> doing an ordinary boot in kexec. The alternative is to leave the TPM
> in a state where the kexec kernel can access its sealed secrets, and
> mock up the TCG2 EFI protocols using a shim that sits between the TPM
> hardware (as the real TCG2 protocols will be long gone) and the EFI
> payload. But as I said, this is a fundamental issue, as the ability to
> pretend that a kexec boot is a pristine boot would mean that verified
> boot is broken.
> 
> 
> As future work, I'd like to propose to collaborate on some alignment
> regarding a UEFI baseline for Linux, i.e., the parts that we actually
> need to boot Linux.
> 
> For this series in particular, I don't see a way forward where we
> adopt this approach, and carry all this code inside the kernel.
> 
> Thanks.
> Ard.
> 


