Return-Path: <linux-efi+bounces-3994-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA17AE867D
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 16:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062221890ED8
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF8E265CCD;
	Wed, 25 Jun 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WhQW8ID5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5F264A74;
	Wed, 25 Jun 2025 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861801; cv=none; b=mbl+EVDEvGSD/T3IvM1eA9+3qErQ/74kjQrLShmFj+J5KHUc5UiWcog4Fy+KcNGFNiagftZXhOu8Z4B27wL65BkYn1YNiwAgWfSmTaiuxVcvq4hGy+uAjv+bAchN3QWuuQkthJcBKKt0Qc9U5TFTDCy6ujbHQFUrV3ePjPJjpvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861801; c=relaxed/simple;
	bh=a+UZwn7ySqA02JacyayHIuiDd66+i/wPMjeYU9n41jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFY827lGJbuc3jWD3mdutVQ2m3ZRxpu5V0D0GJEOkOFzJbjmKilobbC61ao1U3L8qP1ZChdx6P9VfY89MH1yWlq8VKfy0J9QpVnyAw++Axi7tPBDvJ2fkH26mpTVTFCUipBzpIygsjbBsUds0jYz7xsNprHhlK/QtPxPb1VCNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WhQW8ID5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 91C9140E019C;
	Wed, 25 Jun 2025 14:29:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id W4W-Rp0kcUO1; Wed, 25 Jun 2025 14:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1750861793; bh=KjSLLLrF266Nmri9tf6udd4zb+/rT44eHv6fUq0lBuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WhQW8ID5CYUvx8vxFjAXzSgWmaWNtHDiSSIibNJsHWYWVKemVF3Auku3pKgyS/c5c
	 O8xAX0k1exkRK+wBvdeYcz2XLL9kkL9lBSTBfsW9D9175doevuLcTJX8OJdAB06FEm
	 2UuNG30CF61SCaZc/vyIUH7jZaS/Nm/IhF7kLZRc+ZAbBIh7tWR6rhs9gFiYDPpHd+
	 jNYWpMvKZDDueP51HVYf4GbKgBn4q4vCpaCR/mKwQPw62YDofAe/Sb66A31pw7G86P
	 fAczs87CZAi8GeUzG6Vm11M0fi5zWYQu4cH+5FhR+lm1ljqYjsHAbZiy5BQJaANvpX
	 qEwpSjEUU/9VARiJeYkNg2fiVtqlj5oQZCxmKb1feViNcD/Wp5ofYAOOQNuhZk6OG0
	 bdP6Ll1v/sFnSPfsSA32U9F1lbfqBzC9lGWbyowAbaFlLJzFU7i7tHzENQPV/qxkIa
	 mCL4s2v2g4hXgDJLTsoNUR1UgXkc7XqxUWTN6lmqFsIixWCFSUfElxIPzB9VJlyn8i
	 ul1v4Hfhs6IsormRWqDmlLxzAsvh68k4FMNh1lK2tysXKvMYj2Iz4Nl4FdJi/OvUkS
	 Monrlk5ZMF28K/KQuWdGhXvYLUTuPJzPG+q7F5Bzmi3eu1IgSLvvzlFRaW4bKV6U/h
	 I05berPgB/NZ3fGcpNjcEqZg=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3F42840E00CE;
	Wed, 25 Jun 2025 14:29:42 +0000 (UTC)
Date: Wed, 25 Jun 2025 16:29:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/sev: let sev_es_efi_map_ghcbs map the caa
 pages too
Message-ID: <20250625142644.GEaFwHJHFO2gbSN3GJ@fat_crate.local>
References: <20250602105050.1535272-1-kraxel@redhat.com>
 <20250602105050.1535272-3-kraxel@redhat.com>
 <20250624130158.GIaFqhxjE8-lQqq7mt@fat_crate.local>
 <rite3te5udzekwbbujmga5kyyjjm5gfphhqoxlhtsncgckq6rm@7m7owl5jgubz>
 <20250625124016.GCaFvuMA9oApInTVyI@fat_crate.local>
 <4kk67edghl7wvqzuyubgr45mhols37yqsorbxxvkypm3xwnuvc@2oek5mladprs>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4kk67edghl7wvqzuyubgr45mhols37yqsorbxxvkypm3xwnuvc@2oek5mladprs>

On Wed, Jun 25, 2025 at 03:21:47PM +0200, Gerd Hoffmann wrote:
> This is inside a loop, so returning in case the caa address is NULL will
> skip ghcb setup for all but the first CPU.

Then you should not piggyback on this loop but map the CAs in a separate step,
only when a SVSM is running.

And even then we should think about allowing to continue if not all CAs map
successfully.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

