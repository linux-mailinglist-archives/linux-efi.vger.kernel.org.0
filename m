Return-Path: <linux-efi+bounces-5038-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF18BDAB04
	for <lists+linux-efi@lfdr.de>; Tue, 14 Oct 2025 18:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612EC3AF54F
	for <lists+linux-efi@lfdr.de>; Tue, 14 Oct 2025 16:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0A6303CB0;
	Tue, 14 Oct 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGSA3pga"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B1D302161;
	Tue, 14 Oct 2025 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460480; cv=none; b=lzvGRnLIHAxtvjWU51AGbtINjQYvIGpddvm9688HS/JGdsYtraODaCrGTVSpB8glP9RdDPj0a7ggKvjR1bnV4U4jgGwT2cyMSh1FvEWr4CsiIKf61jKg4LxOJ4cyOcBLaifXSWxnqGT00wiPlAj4JMBr6UxD81oRzEK56xcA9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460480; c=relaxed/simple;
	bh=l8eLRFVMqE9fpiqrKqMylM/MEdNRiawD7W1mbhHYUUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5Smf76Elf0DuUKHLirm0TmjDtcfGaKov+fGI0Nk0ybTqV/8UpPGoIVqt2rh1E/5hQPAWNTXT+xVEPeBiISAASiceLiwrgEGvFcH428NZ5p7+n5yc+1M8exlQqdF5ayF1gS+KxcJaqACE7AhvJBu6mgy3bg48zqMmSbNr6X/7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGSA3pga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4FBC4CEF9;
	Tue, 14 Oct 2025 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760460478;
	bh=l8eLRFVMqE9fpiqrKqMylM/MEdNRiawD7W1mbhHYUUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGSA3pgaOhHGfOTcRgObQgFAXRmOW61i/dlmHQrwQtYq+xQu+Ft19yt6twH4meYJQ
	 pWh4Zv2yemKHxTklIE0SZgp3LMws95vKHPuayVyCrSzSO/TuzlIKgKlN/9AzmSYXI+
	 VDWj2WvV3uEOaZ0+mpeTKD3MLGvDFT3ttd2kKoAg8mFv263krvh8pHzQF2S8h0d4ww
	 mm+3rI11mjJHFue72xqUgh8qpTfrAldmagVOJzzCXqrhyFjsfIqCa5+MRQvPB9RG+W
	 jCXWH/AKVd0lxrKcHaX4aoIX3SXFgHU9WqNVNS2owUSOkfqBwuBB2vnN+AirnG+X8m
	 oq6U4gwpx/A1w==
Date: Tue, 14 Oct 2025 09:47:55 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
Message-ID: <rhnei6wovxmoqs36wdysomfsul3faxtmgde73wrrqdt3qo3b2j@akd7vzne76rq>
References: <8091e8fa-3483-af39-2f7a-e4eb62b0944f@loongson.cn>
 <CAAhV-H4+UGLSkbjHbq9MerWfxnq0a13x+uzNfTsCoe1UxjbWsg@mail.gmail.com>
 <CAMj1kXH-rK0bRyHXdJ-crAyMyvJHApH0WR7_8Qd8vrSPBLK+yg@mail.gmail.com>
 <0c9b8e6a-96a6-91d4-946f-2109f48a529b@loongson.cn>
 <CAAhV-H41m96fvEWG5NqAE=tykPjyzt=50CseJDeCqdG-c_WMrQ@mail.gmail.com>
 <CAMj1kXEs5=VRi_rJwgHUrQWos-27PBbr3c4fYnmkV8Ahi8HZgw@mail.gmail.com>
 <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
 <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com>
 <CAAhV-H4UKdso0BokAqvjYeBLr-jbjFAaQX4z=1ztpBamqrOEEg@mail.gmail.com>
 <CAMj1kXEXDC_oq4aWbkR5dqYBix2d1xJEdaj-v747e1nOA0Q_Yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXEXDC_oq4aWbkR5dqYBix2d1xJEdaj-v747e1nOA0Q_Yg@mail.gmail.com>

On Mon, Oct 13, 2025 at 04:36:49PM +0200, Ard Biesheuvel wrote:
> On Mon, 13 Oct 2025 at 16:09, Huacai Chen <chenhuacai@kernel.org> wrote:
> > On Sat, Oct 11, 2025 at 11:59 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > It is an objtool issue in essence.
> > >
> > > The generated code looks like this
> > >
> > > 9000000001743080: ff b7 fe 57   bl      -332 <__efistub_kernel_entry_address>
> > > 9000000001743084: 26 03 c0 28   ld.d    $a2, $s2, 0
> > > 9000000001743088: 87 00 15 00   move    $a3, $a0
> > > 900000000174308c: 04 04 80 03   ori     $a0, $zero, 1
> > > 9000000001743090: c5 02 15 00   move    $a1, $fp
> > > 9000000001743094: e1 00 00 4c   jirl    $ra, $a3, 0
> > >
> > > 9000000001743098 <__efistub_exit_boot_func>:
> > > 9000000001743098: 63 c0 ff 02   addi.d  $sp, $sp, -16
> > >
> > > There is nothing wrong with this code, given that the indirect call is
> > > to a __noreturn function, and so the fact that it falls through into
> > > __efistub_exit_boot_func() is not a problem.
> > >
> > > Even though the compiler does nothing wrong here, it would be nice if
> > > it would emit some kind of UD or BRK instruction after such a call, if
> > > only to make the backtrace more reliable. But the code is fine, and
> > > objtool simply does not have the information it needs to determine
> > > that the indirect call is of a variety that never returns.
> > So the best way is to fix the objtool?
> >
> 
> I think the best solution is to fix the compiler, and ensure that call
> instructions are always followed by some undefined or debug/break
> opcode. This works around this problem, but it also ensures that the
> return address does not point to the wrong function, which may cause
> confusion in backtraces.

I think the compiler folks will say that's working as designed.  The
whole point of __noreturn is to eliminate unecessary code after the
call.

Unwinders are already designed to handle that case anyway.

If you don't want to optimize out the code after the call then just
remove the __noreturn annotation from the function pointer.

> > > So I don't mind fixing it in the code, but only for LoongArch, given
> > > that the problem does not exist on arm64 or RISC-V.
> > You believe this problem won't exist even if they add objtool support
> > (because their objtool will be sane)?
> >
> 
> It depends on the compiler.

I don't think so, all compilers do this...

My suggestion (which prompted this v2 patch) was to move the libstub
code out of vmlinux.o (but still keep it in vmlinux), to make it
consistent with what x86 already does.

The idea is that libstub code doesn't belong in vmlinux.o because it's
not a part of the kernel proper, and doesn't need to be validated or
modified by objtool for any reason.

-- 
Josh

