Return-Path: <linux-efi+bounces-3745-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DADEAB9FE0
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 17:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E52A028CE
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE6C7D07D;
	Fri, 16 May 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="d05oGczZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429125634;
	Fri, 16 May 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409447; cv=none; b=H4R9yMKPAYxJ7oCeS4Fpx0Xk8WzkyGRbWCRBqtQJJws/MI8MqIuiEUYs6APr3QUj4nb+VYrHDWZTaLNLH5ad4yUilGOn0CoqfY7b++i7MBtcOoe8gbn1BeMnj4FOrZp1PArlGcnBUbTH1WVvGhg6ilatBzfECfyQ3sVPJTaYwY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409447; c=relaxed/simple;
	bh=aiZxNYn+tgkHmM3iNy65IGnhdwpMLD9DL48fqn5EZPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxLrUcWxATXFFrIBFCI6brX6cM6G173Yu3pgdUj0pYHcSyg47fE1DlLUj5nu47ku3zn24Fk1wFYVFePllQOwLbEkb0Cfq66obRth4HZ62DwOY7gRbbeUmK1Y3KlEy3juU9MeqbkWoA4Q/OV2lwMqzXz6aOJyGyE5JrmKvy1Bqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=d05oGczZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2775140E01ED;
	Fri, 16 May 2025 15:30:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t1smUWOis_Vl; Fri, 16 May 2025 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747409437; bh=McVGoq+UtKCdfvFYOGPlL/OvNduF+f0TrshIhzY75bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d05oGczZmarekC1JZiZ/c6VsK4Kmz72h37LMtuKtAwme8iUtaZjf7Fg16pArdatyY
	 G+d75nGrln5L5EzHoK37wlmTwAGKtNauH+0D2lj206Os79aCObuaaUpxzEBoHqj8wQ
	 YNZjbGdaCAb/0lqppESMuehhHr01VT3NIkhcPXITn+GNbqpnB6VTpV0PnDKUUG7cPG
	 3YxT4Z8CXQH+/AofnFmux2zBgl8U+/tZOvqbZBDjvHpIirVD3uEtImAbxOrgMxDlrX
	 TKDfPRwteJ0lhDIbGcZPUhO3YleUQTOeT8LBvJ8k+AaXbil33YdMTCw9rWzMHFU9mh
	 rT8+0hsCXuLrXDau1wjllWWZLMlc4D/FftqxoqtA6A79nSHfgpIKeulGU0dZap1f0v
	 G5d1xiy8jDqc9KFm8L16cRQZU6XkJzvmje05RxbvnD3fAogP6CO+RsGwO7hEGxBMiu
	 DM6JkfPNhwbsiGiA2CDPEzx6mlNu2ip6auGZQpSMRSJrrOutAjJ5vJr3bUWc4poiHx
	 8mJ2nnr0p6MYsjGDbKmh3mJFJDvn0ntIGi/2X+mdZuJWX9TlhP0ioxgTwWSnlLisVC
	 ktQGZQkjCaxw0tsN6J+cgKh09BepsyIHcsjE03SrF0jfW6Ejr72mJCq8Qr23iucSOw
	 n64fAEeWmAWkEeqGudIhn62Q=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D01F40E0196;
	Fri, 16 May 2025 15:30:15 +0000 (UTC)
Date: Fri, 16 May 2025 17:30:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/3] x86/64/mm: Make 5-level paging support
 unconditional
Message-ID: <20250516153009.GEaCdaAdhCVpjaViSx@fat_crate.local>
References: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
 <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516091534.3414310-4-kirill.shutemov@linux.intel.com>

On Fri, May 16, 2025 at 12:15:33PM +0300, Kirill A. Shutemov wrote:
> @@ -173,10 +173,10 @@ For example, when an old kernel is running on new hardware.
>  The kernel disabled support for it at compile-time
>  --------------------------------------------------
>  
> -For example, if 5-level-paging is not enabled when building (i.e.,
> -CONFIG_X86_5LEVEL is not selected) the flag "la57" will not show up [#f1]_.
> +For example, if Linear Address Masking (LAM) is not enabled when building (i.e.,
> +CONFIG_ADDRESS_MASKING is not selected) the flag "lam" will not show up.
>  Even though the feature will still be detected via CPUID, the kernel disables
> -it by clearing via setup_clear_cpu_cap(X86_FEATURE_LA57).
> +it by clearing via setup_clear_cpu_cap(X86_FEATURE_LAM).

LOL, good one.

The rest looks nice and good to me. And FWIW, it boots fine on my Zen5 with
5lvl enabled.

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

