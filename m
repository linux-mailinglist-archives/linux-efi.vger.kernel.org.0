Return-Path: <linux-efi+bounces-1933-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D225899A311
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2024 13:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D4BBB21A1D
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2024 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C759E216A0E;
	Fri, 11 Oct 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fPFwGSnz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619102AE7F;
	Fri, 11 Oct 2024 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728647860; cv=none; b=YLThuVLvnC7lV/H79lVF7nsuv8WtyL20hG6zfWr+n5yfKqj0mhE69+0AaBLsJhSvB5oJ9V+u9DGA5NDZS0XCHqmWa+j9/Lz5NxpTXiQZjIGZVUFI3Mb+TmAHrU/GSJF5+tjjkUXR/cEEaDVOfE1MKjgXjczJvi3KhGvOlfFbWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728647860; c=relaxed/simple;
	bh=Q7XL/TXQyMBQb3KLaQfFLqc1QkvYBlgSvkt16YmJmnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oz+6qGYO6RRe5hnB7twzgMYwBtEcBBUydnYYMPNCPynmjAkWHw2Zm+mFCdUKKH357di5p4hs6/H5Ob1wnUJvne4BMMk3ESojDyuo6ZItfBQQY5tZVmGEUjKH+BU6Iu0ekjqypSYRKVWnx0+U2WVcadqNKFxOVgMOSin38o5xy6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fPFwGSnz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 562BB40E0163;
	Fri, 11 Oct 2024 11:57:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HWnVobhI6GlO; Fri, 11 Oct 2024 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728647843; bh=hsoYnwjk+bx8QIrA3aXqChgdJHxyjjoKqysOlGZEEkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPFwGSnzZ0M2UzmfA6nUwfF48I9ivtLQQvrDIoRbzU5FzEzX0nQj5KRn+dDvWLxKn
	 rZhV2ynDeSiteHw5ciMbkH8AHVuSU3ijTWTe9GK8GvoMGKhMhFW9njVkUhNa7x8Z3z
	 fhw3qMoQtXkf+OgPuFsuN7aid2byG/+hpWifp5oJUQzm6uW5FEZHBzfwL4MtPU9Wvh
	 QPn53Gk5VWHRMXBW3aELv0baAcbi3KAimjbV0MailmDVy9QPd4ACNayZxfrDacX2b4
	 wcU7NmxlXWpSw7/CySkeJEbg2w+YDvOEAT1sd4e5HPW27z5RwQKuImlZBGOpHt7eZZ
	 amn1doPuPtqOheyEz5Uq0GhVcKFxFf6O8fjdOlkRFErLw4Yf9P1CJP7hkE586o7Ds5
	 DiZho5h94B/RSxXWVFDfBs5Cgiu9YTSMMEdpW9rX3J5w77Z2/DR9/FLBBWUuglCmlg
	 deRdjV3FBV7kKt4KqS/Obpx4NajH4JVNgRsnG83/oiabXZ8zSw1hcikHRWj2KcYgPY
	 4PAG3ahMBeLPM/j4oxYMsTbw6kP2QoQO6TwnpObAc1yLbvd2PcHjOmI0da/sfjLos6
	 uGf0Oafp5XugSIAmZUzk1dz0Q74oxoWJReJIQifCNDAWofXGvnPLZGdCGaxQHCIv9W
	 9/mwydeq86B57gDCbxk6Kkcg=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E5A8640E0169;
	Fri, 11 Oct 2024 11:57:12 +0000 (UTC)
Date: Fri, 11 Oct 2024 13:57:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Fix issues with ARM Processor CPER records
Message-ID: <20241011115707.GCZwkSk5ybx-s9AqMM@fat_crate.local>
References: <cover.1725429659.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725429659.git.mchehab+huawei@kernel.org>

On Wed, Sep 04, 2024 at 08:07:13AM +0200, Mauro Carvalho Chehab wrote:
> Jason Tian (1):
>   RAS: Report all ARM processor CPER information to userspace
> 
> Mauro Carvalho Chehab (4):
>   efi/cper: Adjust infopfx size to accept an extra space
>   efi/cper: Add a new helper function to print bitmasks
>   efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
>   docs: efi: add CPER functions to driver-api
> 
>  .../driver-api/firmware/efi/index.rst         | 11 +++-
>  drivers/acpi/apei/ghes.c                      | 27 ++++----
>  drivers/firmware/efi/cper-arm.c               | 52 ++++++++--------
>  drivers/firmware/efi/cper.c                   | 62 ++++++++++++++++++-
>  drivers/ras/ras.c                             | 41 +++++++++++-
>  include/linux/cper.h                          | 12 ++--
>  include/linux/ras.h                           | 16 ++++-
>  include/ras/ras_event.h                       | 48 ++++++++++++--
>  8 files changed, 210 insertions(+), 59 deletions(-)

With the issues to patch 1 fixed:

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

I'm presuming this'll go through Ard's tree. Alternatively, I can pick it up
too with Ard's ack.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

