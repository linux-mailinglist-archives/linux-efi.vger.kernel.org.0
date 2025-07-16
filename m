Return-Path: <linux-efi+bounces-4393-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F2CB07F22
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 22:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126817B66C6
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 20:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0AB1F7580;
	Wed, 16 Jul 2025 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFjyzLWE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69621DB95E;
	Wed, 16 Jul 2025 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698934; cv=none; b=rZ6ehpuSsxmLtJCt8+Hc5FenH66q1XGscC5+v++RC4xfuwJ0VvzOl3n03r2OsGfNm42chcoXRBdHitQgOSFeMuBlKtHR9yJPhZpjYpCp4//ep/w3YbJjHhCsafo5EM9nnDFNRwoYh4Z68UwzRBOz2Ni86yW1WN94Q94HehJYZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698934; c=relaxed/simple;
	bh=Z3CkHZCoZKf5lAaRl/IZ0Dqzf6S69eGU3vBiicfzetA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUAMHq9jtfjzviCkn8vsVkXNSYNWgylnHwBkS3kiVbUkJEnpakXJeUAh01G9RUNOFOnIDsCa6MiCv5y7eKJe0nWSW3oWyIQzLHeUNOdQW9fzyc80lWmrV0jcVnVtf3vtfDQ1u+5cztzIRsnApEHCPqXFX817uTMXRyyMW0V0SpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFjyzLWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9DFC4CEF1;
	Wed, 16 Jul 2025 20:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752698932;
	bh=Z3CkHZCoZKf5lAaRl/IZ0Dqzf6S69eGU3vBiicfzetA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFjyzLWEWM8tLNJ2OvtqlOz8IXuNgNfl7vnOD2ypt/WOkNbAXvz+v/UZ0rN7QtGE+
	 R5sNO1/yvWhxZyuhQWdCBM/Z/863oegfx6P7AdeI1LXs5Q5X7u6tW/oNb9Sa+mhpWg
	 8fTERzEHmJvbzq+TQTqAZTcK8lYvu1oZZashkjqGr8lKn/jv4VTgpgXZF6G3LF5Vat
	 wG58ZZKZ/OvQMYoUdaVky+9711oSWabsls/17faxkM+5psMmmfHoFzSdmM4nA5Vah/
	 K8P+i+YLKPJ22sP5LPKbgP7D/zW92zlGS+kWXHLS7uMJ2s9/z0fun39l6eb8SvfVqh
	 snuEv2mevMA1Q==
Date: Wed, 16 Jul 2025 13:48:49 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v5 15/22] objtool: Add action to check for absence of
 absolute relocations
Message-ID: <dvi4y6u7m2bo6jtesrerxu4sn5nbaw7xjkbnshjgvotvhsp6wa@i3hgg3nu46kj>
References: <20250716031814.2096113-24-ardb+git@google.com>
 <20250716031814.2096113-39-ardb+git@google.com>
 <20250716095446.GV905792@noisy.programming.kicks-ass.net>
 <CAMj1kXHNvPdgG+OKX6UB70oTzzbvovfvDhSH73vAj-q7G03c5Q@mail.gmail.com>
 <20250716113243.GU1613200@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716113243.GU1613200@noisy.programming.kicks-ass.net>

On Wed, Jul 16, 2025 at 01:32:43PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 16, 2025 at 08:26:55PM +1000, Ard Biesheuvel wrote:
> 
> > For robustness, we should actually check for all absolute relocations
> > here, including R_X86_64_32S, which is not abstracted into a R_ABSxx
> > type for objtool.
> > 
> > So perhaps this needs an arch hook where x86_64 can implement it as
> > 
> > bool arch_is_abs_reloc(reloc)
> > {
> >    switch (reloc_type(reloc)) {
> >    case R_X86_64_32:
> >    case R_X86_64_32S:
> >    case R_X86_64_64:
> >       return true;
> >    }
> >    return false;
> > }
> > 
> > and the default just compares against R_ABS32 / R_ABS64 depending on
> > the word size?
> 
> Yes, an arch hook like that makes sense. Perhaps make the signature:
> 
> bool arch_is_abs_reloc(struct elf *, struct reloc *);
> 
> Because the word size comes from elf_addr_size().

We already have an arch_pc_relative_reloc(), please try to keep the
naming consistent.

-- 
Josh

