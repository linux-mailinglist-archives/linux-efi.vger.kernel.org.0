Return-Path: <linux-efi+bounces-5406-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFDEC4900B
	for <lists+linux-efi@lfdr.de>; Mon, 10 Nov 2025 20:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 212B54EE281
	for <lists+linux-efi@lfdr.de>; Mon, 10 Nov 2025 19:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9754123B607;
	Mon, 10 Nov 2025 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xg5QVPYK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43522E9EBB;
	Mon, 10 Nov 2025 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802719; cv=none; b=QY73gv3K8vUqYl6MMx5S1DS3QV0HnaP9mAvD33CqGAK8vPov6wITTY5suVvjRD5eqB3nM4frfQv4MVw0KbW0oyPQFlBIrDZebD1aKRUZNC1Yy2zGlB3uPwkNdj2pdRZpMA+iowR3B5+F/yu3ViZFspxE8sCC3WI2g+KQpukmgys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802719; c=relaxed/simple;
	bh=ndaki4c5GVx3UM4kQnMQY6/ymeewU6gsdPF4viqL8SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P766ec3k7CfJJ+feYgZxj6k5NGcBFlo7TycIY4+RL2obCrnmuxHK6G9JDk8W/t22gWFKKBWXZdFq4BNULaUmscld5X0lprwFK01QFV0kh4a2gKxggiJg8x4IfeEdtYj4YYHyE9Y1ytibxmqQctfxVZIH7YGN8HOFZhhXz4tGMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xg5QVPYK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E0CC540E01CD;
	Mon, 10 Nov 2025 19:25:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id d1DZ8FveVMUe; Mon, 10 Nov 2025 19:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762802695; bh=9gPJ2NeCfH2XobjLeNpHfi6XhOsGYwzZnRG0xt6qLMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xg5QVPYKPNYI3wDQG3bQPfw+jsMKYywMxv1tI5Ue7vDwzysfBX2c2/jdvot4+Uap/
	 uY99MM4ZB+9NRTleQdJOnXgJUI+zWT3YDnbOgJkA4EOT4IxmprB2ErIuUDa9nguWsd
	 utt/ekeFE/DaEbT6ohSvpupKEkZSMYwaBoMn5+zf+u150Q49mO+zIOO3dTfHCT/8d0
	 XXUgJfLGGH/+80iOvkoqgHo3JsJz1P67aGRnj1NBD/44BSZAfG/C4wCnJyXFM4R8VQ
	 zrBDBcf43JVE5P3zcQXO41441lUwj9QgG9OLIm5mxfX0Gqx9Mn3KHRXkYn/ScsFkvt
	 rp5Y7I7/0JSDGYcprbpbKKFeqgl5bctMFcydJfo9Opt9RqpzeLqDjSebg3fORtw05D
	 4hL8KQ5G4kzRQL98ShktChOAfSAN5yfei9+C06O8YRhrzqb6f8+BdmHkrUf7ouHSYD
	 O40hrV0jrDWN5SmtVIDBNAmv9RiVGFVQhH3muQ8oZhidqUZR+3mAO7Cumi9io+A2Lk
	 cz1GYUtwR0kjACJDOicxa1dfvyIgz3RYIepvMvyLj9xnfMdJGnvn7OsKXOoX2KZZ+4
	 bky77zEA+W40ORt8nQKivtUmHxqfTECI/1l02qebTvC6SE88NMlGW9w3/4P/gpTe5/
	 oPQV9gAlDlQMt4Sed3Jcge8o=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 59F6B40E019F;
	Mon, 10 Nov 2025 19:24:29 +0000 (UTC)
Date: Mon, 10 Nov 2025 20:24:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v11 4/9] x86/alternatives: Disable LASS when patching
 kernel code
Message-ID: <20251110192422.GBaRI75huOXoUSmoDt@fat_crate.local>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-5-sohil.mehta@intel.com>
 <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29f2d16f-361f-475c-957e-0ebcefcd1a8c@intel.com>

On Mon, Nov 10, 2025 at 10:15:23AM -0800, Sohil Mehta wrote:
> lass_clac()/_stac():
> 	Disable enforcement for kernel data accesses similar to SMAP.
> 
> lass_enable()/_disable():
> 	Disable the entire LASS mechanism (Data and instruction fetch)
> 	by toggling CR4.LASS
> 
> Would that work? Any other suggestions?

Sure, as long as they're documented. And if we decide to change them later for
whatever reason, we can. More than enough bikeshedding we did here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

