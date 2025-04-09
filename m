Return-Path: <linux-efi+bounces-3253-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B14A821B6
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C54017081F
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947441E04BD;
	Wed,  9 Apr 2025 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQcIHo0s"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68329228CA5;
	Wed,  9 Apr 2025 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193267; cv=none; b=ddeuguXl7p896X+lb8ALlTpQ96E+0J6UVQMcb+CbF5vSZ+GHCbF/WIA0I//P9bdTKCdxOr+sELTDnGJPzPQ8wVcfgdWmpTQg0/+6bncwK5NhWkQ+tiuEMTDLL2NFhbzMXkfp440CRg3LJbhjAZwhUWKjEv7N1vAArRfdw035ieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193267; c=relaxed/simple;
	bh=ABWi/oe0vzOqoVUrq3D06limMOoqGtDOjBaVaeN4e+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3miX7g79nWGnKBFOldHG/TtihOCFHxcldf/Mzy/9jjPQnaKv29Lc16Gjqgf/mzW+IyX1106kYBGyn6MMJ2meDUwBumLb5fRibppTMFnRgV+vc8VImcbOdoMWTWbmLoj8Qgtonz1CjoqsAHlfLadLiOKATbk1i89hGvIS5M7NgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQcIHo0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF83EC4CEE3;
	Wed,  9 Apr 2025 10:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744193266;
	bh=ABWi/oe0vzOqoVUrq3D06limMOoqGtDOjBaVaeN4e+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQcIHo0snBMrf705UFtMeWkzURO8hgwhL1YKr7x82UjwdT7Yc2VeOMNwVavULq4xE
	 YM83zwQ5bMewZx03xbRKhzPK8n7hlsrhElgQm+nF4mq5wthBXD2jkBb+TOaf/CYhD+
	 WbZbtLKJapucfVSxcOdNyJ3E6NPb5mTpPFAXIxjfHvrMSA169UC3mUaTtYOPfLR4Gz
	 LeTtqQo7tmZ+uTijkvNsECZ8ro2i6v0zw5oy6EVLQv4NOf3nPhkviXzyUgBYpQLYHX
	 BydD2tDg1PRr/8AqGOFFjbEXeFk7chzvr8Y/fQLNcTahxYI+l6IoIOaRuajrs1+HTQ
	 WdMXRalnBF9IA==
Date: Wed, 9 Apr 2025 12:07:42 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v3 3/7] x86/boot: Move the early GDT/IDT setup code into
 startup/
Message-ID: <Z_ZG7pAZavKDgFDK@gmail.com>
References: <20250408085254.836788-9-ardb+git@google.com>
 <20250408085254.836788-12-ardb+git@google.com>
 <Z_ZGbVXOTPbGXleS@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_ZGbVXOTPbGXleS@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Ard Biesheuvel <ardb+git@google.com> wrote:
> 
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > Move the early GDT/IDT setup code that runs long before the kernel
> > virtual mapping is up into arch/x86/boot/startup/, and build it in a way
> > that ensures that the code tolerates being called from the 1:1 mapping
> > of memory. The code itself is left unchanged by this patch.
> > 
> > Also tweak the sed symbol matching pattern in the decompressor to match
> > on lower case 't' or 'b', as these will be emitted by Clang for symbols
> > with hidden linkage.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/Makefile |  2 +-
> >  arch/x86/boot/startup/Makefile    | 15 ++++
> >  arch/x86/boot/startup/gdt_idt.c   | 83 ++++++++++++++++++++
> >  arch/x86/kernel/head64.c          | 73 -----------------
> >  4 files changed, 99 insertions(+), 74 deletions(-)
> 
> This causes the following build failure on x86-64-defconfig:
> 
>    arch/x86/boot/startup/gdt_idt.c:67:55: error: cast to generic address space pointer from disjoint ‘__seg_gs’ address space pointer [-Werror]

Caused by the previous patch:

  x86/asm: Make rip_rel_ptr() usable from fPIC code

Thanks,

	Ingo

