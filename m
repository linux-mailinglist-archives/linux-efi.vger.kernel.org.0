Return-Path: <linux-efi+bounces-4494-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419AB149CA
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jul 2025 10:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A99D4E5E7D
	for <lists+linux-efi@lfdr.de>; Tue, 29 Jul 2025 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5A4275AE4;
	Tue, 29 Jul 2025 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+W04S5x"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6ED263F40;
	Tue, 29 Jul 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776672; cv=none; b=UhPDVSQ7LnohOrK7B1YzRbX5pZM4I29itNGr+Dfh801NimR6u5eSJ3kUexrERuU4yLy3z44aqp/Z3yeBBXgmCbKBEUks52mIg/eDxjCEEN1bdk25PYaiBgaJTtMGg5rOe9MtvRYpNo0DrQ9u9qNvaZAcLAuJStScAXuO+ZEosBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776672; c=relaxed/simple;
	bh=cWVIex8ZD7iLHUiFYdl7hALOOKwBmGPA9Eu9Lq5/ve4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pmiqh4vKeniJcfgXOXAwYoVO6GQcySw2yVNYTwjbe7Yaku8/g6TpDOXBbJRXdZ4g8H05+UbTsNoHXdgT8TQwCaC4nrviajMHyrdPLGrkfLV2HCXAWtbr3E155nvKeYRtqXyC3ytO4pOUYvX7Wd/0Q/2rgE/BuuOHGuotRDLZHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+W04S5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46400C4CEEF;
	Tue, 29 Jul 2025 08:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753776671;
	bh=cWVIex8ZD7iLHUiFYdl7hALOOKwBmGPA9Eu9Lq5/ve4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+W04S5xBBcVSjTJ0lwCukWF0CUJoPlRJ5apOHIjcIp4Ir2h0WEtBfOZPNq9j6UIw
	 6fZP5IdfM5f5vLEjByzE5d1D4q0ntoXIKt1ZlaptYaMMJ/RbpgOJ4vi8j7m1REK/WE
	 cJzV6oM57CeEOUeuFXbdpRKe9ommavUNv3horhLZRAO6muGJhtumt9y36tBBk8z1p0
	 RcW8XEWXTvj+vpzKEBs29ORzEbWanrDmwe68O6LcUhBYBhNbsg7nJAYdHkL7mym1rZ
	 WuxIc0wxhAbBVU5BUD51GFHFqvaCN7R5JBhhYX7ZtWmQVYAe4Cx4MWw9LPH9S4UYr+
	 4hpI//0VngcyA==
Date: Tue, 29 Jul 2025 09:10:55 +0100
From: Will Deacon <will@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gavin Shan <gshan@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
	Oza Pawandeep <quic_poza@quicinc.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Juergen Gross <jgross@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Roger Pau Monne <roger.pau@citrix.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Usama Arif <usama.arif@bytedance.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Huth <thuth@redhat.com>, Brian Gerst <brgerst@gmail.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jan Beulich <jbeulich@suse.com>, Boqun Feng <boqun.feng@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kvm@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-mm@kvack.org, kasan-dev@googlegroups.com,
	linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org,
	kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v4 1/4] arm64: Handle KCOV __init vs inline mismatches
Message-ID: <aIiCD5V1MaI3ORqA@willie-the-truck>
References: <20250724054419.it.405-kees@kernel.org>
 <20250724055029.3623499-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724055029.3623499-1-kees@kernel.org>

On Wed, Jul 23, 2025 at 10:50:25PM -0700, Kees Cook wrote:
> GCC appears to have kind of fragile inlining heuristics, in the
> sense that it can change whether or not it inlines something based on
> optimizations. It looks like the kcov instrumentation being added (or in
> this case, removed) from a function changes the optimization results,
> and some functions marked "inline" are _not_ inlined. In that case,
> we end up with __init code calling a function not marked __init, and we
> get the build warnings I'm trying to eliminate in the coming patch that
> adds __no_sanitize_coverage to __init functions:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: acpi_get_enable_method+0x1c (section: .text.unlikely) -> acpi_psci_present (section: .init.text)
> 
> This problem is somewhat fragile (though using either __always_inline
> or __init will deterministically solve it), but we've tripped over
> this before with GCC and the solution has usually been to just use
> __always_inline and move on.
> 
> For arm64 this requires forcing one ACPI function to be inlined with
> __always_inline.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> Cc: James Morse <james.morse@arm.com>
> Cc: Oza Pawandeep <quic_poza@quicinc.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> ---
>  arch/arm64/include/asm/acpi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index a407f9cd549e..c07a58b96329 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -150,7 +150,7 @@ acpi_set_mailbox_entry(int cpu, struct acpi_madt_generic_interrupt *processor)
>  {}
>  #endif
>  
> -static inline const char *acpi_get_enable_method(int cpu)
> +static __always_inline const char *acpi_get_enable_method(int cpu)
>  {
>  	if (acpi_psci_present())
>  		return "psci";

Thanks for improving the commit message:

Acked-by: Will Deacon <will@kernel.org>

Will

