Return-Path: <linux-efi+bounces-4394-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 861F2B07F42
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 23:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D803B175A41
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179A27A123;
	Wed, 16 Jul 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwbbm/Sa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E918C008;
	Wed, 16 Jul 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752699842; cv=none; b=Ex6zY27c4hVMzw2dOmlg1DI+c5V/91A/uyuTaIKMnCUgSa14WURqVBlY2swTGIuLNAUjUpVS7qXXm0Lab2+d+0ygtPuXuhb2h7KqYdSrFKplvojZQlJN3+Jyfjo0NL/00G1VOg3l5xA9wXs8YppsmX1/MOq0942b+P8pZhnH990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752699842; c=relaxed/simple;
	bh=LULn+aJ4tvMj1FIRYSApYIQDI5tI4xKUAYzS622ljVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEC7a5ORA1gHZtzlMDzk/fTMblX58kumEGOTu+LXL3Gy1iAZ+RO4XAzyxQ5f+uFhO4WLXTPlXNkV+N91oeR/6L2+tsVk4+ixlc8zPKN/VTeq/580hDI8kICBeoGoZr3XiExSGCglJJ8aR1WIkvpe0BkMsKdJirbGxuAHt4FIiZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwbbm/Sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F64DC4CEE7;
	Wed, 16 Jul 2025 21:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752699842;
	bh=LULn+aJ4tvMj1FIRYSApYIQDI5tI4xKUAYzS622ljVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fwbbm/SaHFhjqO7vzBSTvDd1n5eSQIEalWBUD3QVSrsMe5U3yEbJwPfbOrzBiujo3
	 yn8j8CoqvZTV0vYw9DPth+6Uvjfizkyer+6ANRDSm4QEcHIgRpHOG1SmeVSq/rh9sf
	 rbHXlAB53zixOTvh22F96gjqukRIJwaR1LDGS7uAW+i9zE6DUZ9KYv/EB5ziOkjkgH
	 JSVP2b3a35qZlaj9Zf4fuxzJttpXB3Bh9FVGnTJPdvYzkSGupjkicx71++mF8uI492
	 uzNfiFkptKMuVsZoGuiaGet5ryYckiOyyN5dZ34+lTOp3M3BLQLg4fuKYobfCkQ8gl
	 keMi0++urxh5w==
Date: Wed, 16 Jul 2025 14:03:58 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, seanjc@google.com, 
	pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, samitolvanen@google.com, 
	ojeda@kernel.org
Subject: Re: [PATCH v3 16/16] objtool: Validate kCFI calls
Message-ID: <llyr3xzwbywv45ckdpzdco6g5ek3yu2lqqkxupgxaflrhsm42w@7of74nnyjhqt>
References: <20250714102011.758008629@infradead.org>
 <20250714103441.496787279@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250714103441.496787279@infradead.org>

On Mon, Jul 14, 2025 at 12:20:27PM +0200, Peter Zijlstra wrote:
> Validate that all indirect calls adhere to kCFI rules. Notably doing
> nocfi indirect call to a cfi function is broken.
> 
> Apparently some Rust 'core' code violates this and explodes when ran
> with FineIBT.
> 
> All the ANNOTATE_NOCFI_SYM sites are prime targets for attackers.
> 
>  - runtime EFI is especially henous because it also needs to disable
>    IBT. Basically calling unknown code without CFI protection at
>    runtime is a massice security issue.
> 
>  - Kexec image handover; if you can exploit this, you get to keep it :-)
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

