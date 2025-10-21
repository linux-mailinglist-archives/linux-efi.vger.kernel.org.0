Return-Path: <linux-efi+bounces-5079-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A57BF8839
	for <lists+linux-efi@lfdr.de>; Tue, 21 Oct 2025 22:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79EE19C4C97
	for <lists+linux-efi@lfdr.de>; Tue, 21 Oct 2025 20:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B8A23D7E8;
	Tue, 21 Oct 2025 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PJ3NI30V"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4E265CDD;
	Tue, 21 Oct 2025 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077054; cv=none; b=apkseQWx+mjBSZL6xqhuO88LL4zlFzwfiU4xNmSNMwYFIxflqVCa6FGo1EAXtolMxGjx9Bu2dWymbVhTAHHuQtKlgr3KEV3cvBjGfMeYk3Oe79zUPNmA8IOePInk5aHDtKjSsHAWh/k1jws+62tqV4JdeaPBaxT3/e0am4zrBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077054; c=relaxed/simple;
	bh=bvu1hCgaEBFxQCkOQvdBmkEXVLNwGj+rEy6N7mDSE50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLmC9LjTsw5+Fv9lc/MZP/CafUOkbGZLx/rb2ycVglkTj2R/VjciI130gXkjN1sp0jX2Y8rLKSdvtMgEjet5DuT9DU8AEnDfIp/L37VpqXEDfRLH8DGDPInL5Ey5LXs3JKzi+xNPSp+RrW4PwQemQpL0BZGkxyAnxOwYcB4H4oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PJ3NI30V; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B231440E0200;
	Tue, 21 Oct 2025 20:04:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mxa2GnDdAkJI; Tue, 21 Oct 2025 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761077042; bh=LqOuAOc3c7dD6s8nXNoTSnIZ/kx2X/BfM4B8Od2Qvyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJ3NI30VjTbiCHLcday5QU5CsF9G471l400Jgnt1HOwLo0i/09RYT9raBOJ60PCjC
	 rQzvQaU81lQAGNpp1MTXQxGeuYPgotECVjVemhaw6guaJo5o5TDd2TYZMRjf3SNjc0
	 6bFPTYWTti0SGsU/u5/fhEw6z/vdpcAdBga5fHN/z6AumO+oR81IdmgijdvUUKIYOY
	 /yB2dkzr/Xag9kVwgq4uRIIV6wI3ntLyXdMiUR09i8karqhVK3qeXUe2vKWQACchqD
	 MYGuTqvAwSzELanRpRNk0ahO4wklMYcNcNHojJow1dcC2E9CrAfzyGQkSKISeryn0L
	 DS7kxKMNbhx9NAp0vqxCkZ2LIwk06hb1DPb7gsR/OdcUxzYrz6LqdYR6j1/Dsl2+LB
	 fErSDdjgFa5EFWoNtusMCE6RGupdmH1cb+xMlFMtDXStmwZo9BN0oUjeR6m3K/6qBm
	 1CJ7YTVeAadaH3XM/UZFroSLUqjKjWEdq0XckT9pCgdegXLtDfsZHuYyQSkOO5CV1S
	 eCdbbiha8/KADB0QBLJnF3XHXmfgokLhmw0ANVswfDGRgXps32tExX4ixCpQmy9GE+
	 Z8Oqeniw13ojdDv4SNvXWo6rx9uO/cOGkIW31WW1HaYKj9sVUq0osyBZU74+m57nLQ
	 LhzJPl4FfVAzC7JgyN2regiI=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E33A640E00DE;
	Tue, 21 Oct 2025 20:03:34 +0000 (UTC)
Date: Tue, 21 Oct 2025 22:03:28 +0200
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
Subject: Re: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <20251021200328.GMaPfnEDibnBrhNTmQ@fat_crate.local>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-4-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007065119.148605-4-sohil.mehta@intel.com>

On Mon, Oct 06, 2025 at 11:51:07PM -0700, Sohil Mehta wrote:
> +static __always_inline void lass_clac(void)
> +{
> +	alternative("", "clac", X86_FEATURE_LASS);
> +}
> +
> +static __always_inline void lass_stac(void)
> +{
> +	alternative("", "stac", X86_FEATURE_LASS);
> +}

So I probably missed the whole discussion on how we arrived at
lass_{stac,clac}() but just in case, those names sound silly.

IOW, I'd do this ontop:

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 3ecb4b0de1f9..066d83a6b1ff 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -55,16 +55,8 @@ static __always_inline void stac(void)
  * Use lass_stac()/lass_clac() when accessing kernel mappings
  * (!_PAGE_USER) in the lower half of the address space.
  */
-
-static __always_inline void lass_clac(void)
-{
-	alternative("", "clac", X86_FEATURE_LASS);
-}
-
-static __always_inline void lass_stac(void)
-{
-	alternative("", "stac", X86_FEATURE_LASS);
-}
+#define lass_disable()		stac()
+#define lass_enable()		clac()
 
 static __always_inline unsigned long smap_save(void)
 {
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6a96dbc60bf1..6cdf5c226c51 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2487,18 +2487,18 @@ __ro_after_init unsigned long text_poke_mm_addr;
 
 static void text_poke_memcpy(void *dst, const void *src, size_t len)
 {
-	lass_stac();
+	lass_disable();
 	__inline_memcpy(dst, src, len);
-	lass_clac();
+	lass_enable();
 }
 
 static void text_poke_memset(void *dst, const void *src, size_t len)
 {
 	int c = *(const int *)src;
 
-	lass_stac();
+	lass_disable();
 	__inline_memset(dst, c, len);
-	lass_clac();
+	lass_enable();
 }
 
 typedef void text_poke_f(void *dst, const void *src, size_t len);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

