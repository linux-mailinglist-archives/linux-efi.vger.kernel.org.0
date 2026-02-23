Return-Path: <linux-efi+bounces-6209-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDsBFMTVnGnqLgQAu9opvQ
	(envelope-from <linux-efi+bounces-6209-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 23:33:40 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E409317E66E
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 23:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 125A33019535
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 22:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE3737B406;
	Mon, 23 Feb 2026 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J983x/DU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49750379982;
	Mon, 23 Feb 2026 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886016; cv=none; b=oPmr8ygmg53vL15qVwPGGjGm5WhqUxG5jrpu6IXGqjIxuw91HaH0eXWd+UfO5M4JzK8G1VoSZrS45EPtqROp02YLIFzNeEBKyrJPl0QJ4MtBv1WoaFjUR1auT4vkQgWijHlf8f546sAAulNR4sP0U/3oQOTUP+YgxfMNYuJCKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886016; c=relaxed/simple;
	bh=6luMqdKSuq9XRD6Jc4ImEhLDZ+nlkl7La9U57PIctFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNs8tpeJ2M9mdNf1J3pWtyV7iWPI0qMEXs0iNttYJnA9tBJ7rnzYuQOEG1Eskr5A0uCJGK8Xn+/+9h4DMySKPnarZwkUZQEfOu4MGe7AJ/pylSpcZfDdoEvaqLjAReqcOXTUEYLSDMPV6o6kEiNidI0zWzSuR9mpZbF5Xp/fa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J983x/DU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEB5C116C6;
	Mon, 23 Feb 2026 22:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771886015;
	bh=6luMqdKSuq9XRD6Jc4ImEhLDZ+nlkl7La9U57PIctFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J983x/DUXe3wWA3l+3Y64rA0CyNpkzQkwiWNeGpfi4mVEVqwUoxLSa6SgDkizaiuU
	 kyf+CQXTpoeB+BorC0kiHBzbL7iajtQVbKZostEWGW0GTy+zMQ2EO0UAxWNsXvZSC3
	 pYwsPqARByxjspf6jCgBrNJRjb+aVsM3582OK2Z86dHZ4/AT3JjWfCQ7qzfd8TdDO3
	 HYeH2KFUSJokM4IASGtQF+43uR5nJAj3Me2nQddduKJWxtNjoQfmxUNtzNPpVAXvwE
	 LXapQT/2pi7TKjubvmD9ZBhqaEtpqEdZ/k1WaiC8FlfJvMknXYqOOUyAsPpsR2WUfK
	 Z3GgEPZNO4NJQ==
Date: Mon, 23 Feb 2026 14:33:35 -0800
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] kbuild: Use '-fms-anonymous-structs' if it is
 available
Message-ID: <202602231432.20F3F0CF@keescook>
References: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
 <20260223-fms-anonymous-structs-v1-2-8ee406d3c36c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-fms-anonymous-structs-v1-2-8ee406d3c36c@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6209-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,arm.com,xen0n.name,hansenpartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,alien8.de,linux.intel.com,zytor.com,linaro.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-efi,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gnu.org:url]
X-Rspamd-Queue-Id: E409317E66E
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:10:29PM -0700, Nathan Chancellor wrote:
> Clang recently added '-fms-anonymous-structs' [1] to specifically enable
> the Microsoft tagged anonymous structure / union extension, for which
> the kernel added '-fms-extensions' in commit c4781dc3d1cf ("Kbuild:
> enable -fms-extensions"). Switch to this more narrow option if it is
> available, which would have helped avoid the issue addressed by
> commit a6773e6932cb ("jfs: Rename _inline to avoid conflict with clang's
> '-fms-extensions'"). GCC has talked about adding a similar flag [2] as
> well but potentially naming it differently.
> 
> Move the selection of the flag to Kconfig to make it easier to use
> cc-option (as CC_FLAGS_DIALECT may be used in arch Makefiles, which may
> be too early for cc-option in Kbuild) and customize based on compiler
> flag names.
> 
> Link: https://github.com/llvm/llvm-project/commit/c391efe6fb67329d8e2fd231692cc6b0ea902956 [1]
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=123623 [2]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  Makefile     | 2 +-
>  init/Kconfig | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 06ff3032a6bc..1d5c0ab9ed5c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -791,7 +791,7 @@ endif
>  
>  CC_FLAGS_DIALECT := -std=gnu11
>  # Allow including a tagged struct or union anonymously in another struct/union.
> -CC_FLAGS_DIALECT += -fms-extensions
> +CC_FLAGS_DIALECT += $(CONFIG_CC_MS_EXTENSIONS)
>  # Clang enables warnings about GNU and Microsoft extensions by default, disable
>  # them because this is expected with the above options.
>  ifdef CONFIG_CC_IS_CLANG
> diff --git a/init/Kconfig b/init/Kconfig
> index c25869cf59c1..c4282d049463 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -960,6 +960,11 @@ config CC_IMPLICIT_FALLTHROUGH
>  	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
>  	default "-Wimplicit-fallthrough" if CC_IS_CLANG && $(cc-option,-Wunreachable-code-fallthrough)
>  
> +config CC_MS_EXTENSIONS
> +	string
> +	default "-fms-anonymous-structs" if $(cc-option,-fms-anonymous-structs)
> +	default "-fms-extensions"
> +
>  # Currently, disable gcc-10+ array-bounds globally.
>  # It's still broken in gcc-13, so no upper bound yet.
>  config GCC10_NO_ARRAY_BOUNDS

Series looks good to me. One style question, why go the round-trip with
Kconfig instead of doing it all with a fallback in the Makefile:

CC_FLAGS_DIALECT += $(call cc-option,-fms-anonymous-structs,-fms-extensions)


-- 
Kees Cook

