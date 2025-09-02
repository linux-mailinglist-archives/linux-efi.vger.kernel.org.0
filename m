Return-Path: <linux-efi+bounces-4671-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA12FB40A7F
	for <lists+linux-efi@lfdr.de>; Tue,  2 Sep 2025 18:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E4A7A5390
	for <lists+linux-efi@lfdr.de>; Tue,  2 Sep 2025 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C130832A825;
	Tue,  2 Sep 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TmMaJ1jX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CA2DFF12;
	Tue,  2 Sep 2025 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830303; cv=none; b=HD/5kr+kz7GsK3Pg261xSyAzvlZzgqCm5AP5su9FrIlZgQVXJhd2rY2AUenbsv0DRSnjQvQ3gGouWxgNRLTM6VtFz7uwy6hhVgfCrkqbSLsAwbJpxQxOB7q2qli9Bv4ny1peTI4clOSClM5kx1iCcUQjSd/gCDjmtQf8dQKmA4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830303; c=relaxed/simple;
	bh=Qt7Yw4tyf0CJchtiD30856Ss8l360SAR5cxt8FIoAYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqtW7CJZml73TSv3vbW0zr8fcvQXlV108FOYGoqoN4n24EfTcO/T4HaB/kgthtXm5FFne2Ll0lYL23U7Alyw11opnXxeS3dvSW/lx8ZEJW1T8QOnBO0AHLYZQw8BXe8c3eV66SXvZaFv32jiXxfqjW48HYB8DyqHvS2REquHy80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TmMaJ1jX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C8C140E015D;
	Tue,  2 Sep 2025 16:24:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vc3kiI8TuOxZ; Tue,  2 Sep 2025 16:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756830294; bh=Fy+FeldQpYileO0jGk1ltigiYQGbbIabxDiDvu+i0/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TmMaJ1jX0r0vglNTpeHQItoBj8gSsOe29rK4n9eQUj0C055QowO1PTTtbImmNAZ4s
	 i15ccwVwAkacD2jyM1rSaSaE+WrbBkNWuqexgIUz2qxcS+1Tu3RWbF2NqcvaV/tjGL
	 5vCVN6cKEWCZVZCtK5gos/MClxF/a0ww8MlPbHbvWKpt9B4KASzgGOc/8Mev3KrELY
	 5grXHI1V/wC3UN2Fw2+vhvVLgigMCOfXiWcIX3XOS3AMFKquZ/xWSfZJSIZ4hZBNUi
	 KARTuDCGinVBI9MKLh5LnHPAYo+ogWOfSFSCVBRA0AmOa99M0zmXGca45KbK92zUcW
	 pPTfjEPiQGFE7Es/TNLFuNHVpVABhuk9hEJALT+e0ijjrTohP8TSKvETUa86xS4C9Q
	 86t2V5hm5sNsI+p1HDD65JIDJHMy3xLZRg2f24KRyhG7j0uh0nqk1ECPaSlgB4gA4c
	 /AjYGZSbvw3ImCm095VAXoOtgmn/AKCMK7cNIZ4yheR4Fwx6r1Oj3uhFRYVxWZ3O7Y
	 1zwGC+VRobIu+YyF5Je7C94iaC1NJQYddWDXHcFFP6Dw2g4pfyE4NrKVncKIVc3IU/
	 1wyHfNiFOyuzkt9t9C4t42yxgKeZgkLIfHsRmvI14yu64CTNkgIYWKUtIVtJsbvQwZ
	 FtVoU5iukz4s202cA16SSy6M=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B512940E01B0;
	Tue,  2 Sep 2025 16:24:43 +0000 (UTC)
Date: Tue, 2 Sep 2025 18:24:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: [PATCH v7 12/22] x86/sev: Provide PIC aliases for SEV related
 data objects
Message-ID: <20250902162438.GEaLcaRjBkz_MHEVnE@fat_crate.local>
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-36-ardb+git@google.com>
 <20250902120648.GFaLbd2LyZYkQ4l8WV@fat_crate.local>
 <CAMj1kXGiy4XU0nrPU9UL3C1KHDznim1gj=P-MabVu=D59k3Fww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGiy4XU0nrPU9UL3C1KHDznim1gj=P-MabVu=D59k3Fww@mail.gmail.com>

On Tue, Sep 02, 2025 at 02:24:31PM +0200, Ard Biesheuvel wrote:
> it was exported but I failed to update the commit log accordingly.

Ack, zapped commit message sentence locally.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

