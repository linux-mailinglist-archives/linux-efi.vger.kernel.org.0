Return-Path: <linux-efi+bounces-3789-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F071AC2AD7
	for <lists+linux-efi@lfdr.de>; Fri, 23 May 2025 22:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD1FA43C18
	for <lists+linux-efi@lfdr.de>; Fri, 23 May 2025 20:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB88E1F4CB2;
	Fri, 23 May 2025 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKCTWrMO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A863322338;
	Fri, 23 May 2025 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748032111; cv=none; b=AOiBAxjD9S25c3buvtfvmu7V1LGvFlRAM3AvKQxinzzaghJT+7HC94QlZ/XRaHQ7duJkvf5AEi3vr8LxIKCFkys8eCoJoPehRJk3pLmo19icXYX2awjXDgfM+KOaYNHmsBsOjuZY+XXI9dnoV0mWZ2l/YSsQXTbpMyTakjvruBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748032111; c=relaxed/simple;
	bh=mCqS/Kijb63hfjRogkIoo1V9a7plAKd5pBatsPb3zS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=An9HTiL0bNA4gZqLd+hPMKDmuQkClv/6HoDX/TW6yoIu93r7VBSmHU8JWSzodBS3PE3gKUEpwXL0PmalcCLkilnaB96565HqOj5NsdzJz7GaH6cgg3kOFJTcT4JN0kzMwubt81K3UrULP76ecMvLg3zrKuUeQk2ZPGYU/yzXA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKCTWrMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E60C4CEEF;
	Fri, 23 May 2025 20:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748032111;
	bh=mCqS/Kijb63hfjRogkIoo1V9a7plAKd5pBatsPb3zS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKCTWrMOz8QGFkwtap37uEMcxPQVostPEoFPh+liJpGoIZm7yUbph01VSxYIZ9Mnu
	 Xp2SFx8fCFcAMCn/ELInspiWG36xJF3J7d0jPlVxo6aeh9oNz5+dzf8Kq3g/Xe/so1
	 mYCrUnXAuBAVZPsZr7ruImlYVc+gipnIRXGuB54FA2ds4IMAQQ3eh1QLM/4b0qJj2M
	 gTr/IjcVsa0wubmGcNRixgHZajZrPNsHowCdWXY/LC03W+Pu6hAChB6eWCEPXnK99u
	 2vaA5rFoq3M2ELAJVxf64ufJ8UJLD7jY5t0UU+6I6+n7SgWhzCzujvRIpD5lc47LG4
	 +IQz87qYLaslQ==
Date: Fri, 23 May 2025 13:28:28 -0700
From: Kees Cook <kees@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Juergen Gross <jgross@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Roger Pau Monne <roger.pau@citrix.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Usama Arif <usama.arif@bytedance.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Huth <thuth@redhat.com>, Brian Gerst <brgerst@gmail.com>,
	kvm@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-mm@kvack.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 04/14] x86: Handle KCOV __init vs inline mismatches
Message-ID: <202505231327.3FA45E4B@keescook>
References: <20250523043251.it.550-kees@kernel.org>
 <20250523043935.2009972-4-kees@kernel.org>
 <aDCHl0RBMgNzGu6j@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDCHl0RBMgNzGu6j@google.com>

On Fri, May 23, 2025 at 07:35:03AM -0700, Sean Christopherson wrote:
> On Thu, May 22, 2025, Kees Cook wrote:
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index 921c1c783bc1..72f13d643fca 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -420,7 +420,7 @@ static u64 kvm_steal_clock(int cpu)
> >  	return steal;
> >  }
> >  
> > -static inline void __set_percpu_decrypted(void *ptr, unsigned long size)
> > +static __always_inline void __set_percpu_decrypted(void *ptr, unsigned long size)
> 
> I'd rather drop the "inline" and explicitly mark this "__init".  There's value
> in documenting and enforcing that memory is marked decrypted/shared only during
> boot.

Sure! I will swap this around. Thanks!

-Kees

-- 
Kees Cook

