Return-Path: <linux-efi+bounces-5075-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCB7BF68A4
	for <lists+linux-efi@lfdr.de>; Tue, 21 Oct 2025 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7790E504718
	for <lists+linux-efi@lfdr.de>; Tue, 21 Oct 2025 12:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12385332EBA;
	Tue, 21 Oct 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C0zJv5y0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4A332EC1;
	Tue, 21 Oct 2025 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050914; cv=none; b=aU7i55pZU6ixJpEbroHf3oUyaOVZBxt3MrexKj9aSZMR9J+3yDAX83LQ7xyr7XR0HjTW4ZlOpCcz5MGibSYRKDG8v7IDQ/uBocylA/ICmWl6SsEgNh/9WBGy8YwkPeSHm0fHeMRG9b+txPy8B3AyviHHKa3Dmr2eLU26GiA2Ia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050914; c=relaxed/simple;
	bh=tNSHcMfdMjXil5gehoy0a3xhu+PGlrxF40sZxea4woQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjipBpG+JG+D1w0y+0DfLqYyX0Sqg4ew45HsU5O8Y0zN2IovWUOesHQfMSo49WPVm7vWvdev1KJgwj9JEYCLfYtQZUptAYUCJxNM5Jh0SkxBaTBWcZTX6kVVmlp+QGYcMSMUc6CLfN4rbLKn+2UlSQvPUY9r+pyf6+afsD2ykX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C0zJv5y0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 38AB940E01AB;
	Tue, 21 Oct 2025 12:48:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LaiBo3C4YYWW; Tue, 21 Oct 2025 12:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761050905; bh=zjdz4fznUlZqYgkgEE/leAK6J3jv36NG/bZPQvb50CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0zJv5y03oTMIdoZr80Yg5S6cq8NzX8Foz2yKf29Q0n0inJ8zNVR8CS3ckyrpz8Eb
	 u/i9t2IKRTaIz8lhn5491Nvmpo8uv2o/vZavSdW6wHWO1rz6q7uJKRCaORkmPKbpNt
	 iOJ1WNDZazAGEx7dfV5NZwvX+gPv3q8UOmNgkk7aQk+O9/B2b72hYOcMwQzjAUIojl
	 IPFO0gwRLaHLtofdR3pvH2LLwNG59vlYNeo2FNT5vQrssHnU/+sYIK/qJKSJGMNpsB
	 /L55VkWRugGvwhp+nbNPENo8P6NmmAkbRVhaFfwS/+HVFLJhlP18mlcs6el5ShJkkG
	 PGWvNDDoqFe3a+yX7kF6GZPSRi2aJ70AvpuzFpO+kpgBkH9mkkaVna+5lIMS3juTdS
	 x7vhB9BPrh37SnJARTdpC3ZBuS2+u/h9O0ldLT/8NC6cdJZGXwifeb1SMEW/ebqteS
	 PJfJ/9A2qFiQsda5XKnzJW+CdW8y1pXUgel0NtISa0rH/uqdcj92jmzE3AXEM8tDpO
	 XqYXpwHhlPJq1g7dhSEgizbN+mRzVfW5n19s0gyt/2dsG/XPd6axn9ZXbJfId2s+3G
	 kYsKDTWOGOO1JrdnR2Q0be5tnzwoPTnZBo8inAe6ubeuiPa6Yv7zNWmkZah3o60p2m
	 NhoROR4M9pS2AM7lnezALpDE=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A242740E01A5;
	Tue, 21 Oct 2025 12:47:57 +0000 (UTC)
Date: Tue, 21 Oct 2025 14:47:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v10 02/15] x86/asm: Introduce inline memcpy and memset
Message-ID: <20251021124751.GLaPeA9z8BCIe8AudC@fat_crate.local>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-3-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007065119.148605-3-sohil.mehta@intel.com>

On Mon, Oct 06, 2025 at 11:51:06PM -0700, Sohil Mehta wrote:
> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> 
> Provide inline memcpy and memset functions that can be used instead of
> the GCC builtins when necessary. The immediate use case is for the text
> poking functions to avoid the standard memcpy()/memset() calls within an
> RFLAGS.AC=1 context.

... because objtool does not allow function calls with AC=1 because... see
objtool/Documentation/objtool.txt, warning type 9, yadda yadda...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

