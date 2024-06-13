Return-Path: <linux-efi+bounces-1213-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F629067DB
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 10:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B572289312
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2024 08:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140513E40E;
	Thu, 13 Jun 2024 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FCRHpAur"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E2A13E036;
	Thu, 13 Jun 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268923; cv=none; b=nRkzT2XUPwB79u02I5/WbrUx6d8789A0zfCoxGgk5bLHnVB/5vJnxN5ykdRmlVWrjuOxZlDvC/PJafVoLjrMv3++ITatyie1fhbCaqeTcbRmlq9AsrrMW/BwAKgrBocG26ByL9M0WBRSH0KA3gN8NK0oqPKJe7QzPGq9aM89hjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268923; c=relaxed/simple;
	bh=Mbx86OvHeq6gyJt0/wrbcA7csW4sD7XcvVlcTa4GkFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quQCWGSRx2vQJbrbqOJXLZ1ulBdkozJakDvfYNfYYPGJd2NZCqZcbZRQ5S3ScQ6K1Z83uiZ3VCka1WAagExiudIrNLz27Uex0zNglJ92mOfIxCdho6hz6rXYSc+jCTycVFygBjbnBMfqnsDFKjTSgR+vmEtxdFOboR8ywWgl538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FCRHpAur; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3C24740E016C;
	Thu, 13 Jun 2024 08:55:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bZBfFqES31R9; Thu, 13 Jun 2024 08:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718268915; bh=3Dzk+C3x6/O7l/Mmw+O7gTZjYw/iV38/2gr+mmH9V9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCRHpAurF+Wm/EOGZM65m6GLwmaYdiGwKyoDw/JKgAHLBrGG3jBdRefQOXpURQTgq
	 pRL5nPED5jvwl8KeUqkAUCH6sFbGufzeSw3VpJopkeeMYQpYB5G33X3y52FuuSOjEa
	 UoE0qjM8ngZca0OcO5ZFtgGSmJIlYEFoQ9sPzGXPtbMAnZ8Gn9WfDQIIJ816tJwGLT
	 HEbNzybwLGzKBYTBuA4MgSO2lVzwWn5HKCcGbG6bE9NSaMPRKIgy4Zdg6UWCbU5EP3
	 O94BGrYUpFVF0msJz0MP6Klh6B/upITbg7aWriz3jVjxxBdVbdIL0SkQe7DoAsJH5w
	 D2AfKnd4qR7iU40tp4HAhSuErQrS+q3Fi3cBakIuJTKvkhIab+WFMJ7YXhB8uBu0hU
	 d4S71CrP5lW6ej2pT4Lb2Pi0Wi5oxXRQ+mFEaTJjmm2f6KiNzzazG2HILEb0Pka/l8
	 mtn6YgY/hyo9gxaLihpmwJvvXkkL0AGJbQEv1hcIOKqkPOsjOpKD7o3Rh1XNFh6pfK
	 cpvZI+lQ8IESc/H9E4rdWOWCqmhHivDRq5HfiVodUvng//j5tZ6aldkWgGSHhrA0l+
	 Qu1UJsBfoHjn8sLTURFd2GcB//vOtSFVFBnGjrDp6HhZfQBMHzkK+FuKZ0vq0+8f1c
	 O4IIWM8GAvZiDWb5079/AjxQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9031940E0081;
	Thu, 13 Jun 2024 08:55:06 +0000 (UTC)
Date: Thu, 13 Jun 2024 10:55:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ashish Kalra <Ashish.Kalra@amd.com>, Dave Young <dyoung@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3] x86/efi: Free EFI memory map only when installing a
 new one.
Message-ID: <20240613085505.GDZmqz6UWxZ1QxKeHu@fat_crate.local>
References: <20240612135638.298882-2-ardb+git@google.com>
 <CAMj1kXEgAStastV+sMhXt0pUmvM=nr9D-oDctwb8iiYxt9+fAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEgAStastV+sMhXt0pUmvM=nr9D-oDctwb8iiYxt9+fAQ@mail.gmail.com>

On Thu, Jun 13, 2024 at 10:28:05AM +0200, Ard Biesheuvel wrote:
> Given that this fixes an actual use-after-free bug that is not
> specific to TDX/SEV or kexec, I'm inclined to queue this up as a fix.
> 
> @Boris: Mind if I take this as an EFI fix? Otherwise, can you queue
> this up? Thanks.

Sure, go ahead:

$ git log master..tip/master arch/x86/platform/efi/memmap.c
$ 

Should be fine, conflict-wise.

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

