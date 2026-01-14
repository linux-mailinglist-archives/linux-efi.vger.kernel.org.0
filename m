Return-Path: <linux-efi+bounces-5990-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E1BD1FFD4
	for <lists+linux-efi@lfdr.de>; Wed, 14 Jan 2026 16:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5CCA301D139
	for <lists+linux-efi@lfdr.de>; Wed, 14 Jan 2026 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB7939C655;
	Wed, 14 Jan 2026 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiWdFN5S"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98543570C6
	for <linux-efi@vger.kernel.org>; Wed, 14 Jan 2026 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406075; cv=none; b=cAzUQPq9lwV3Li4pEyWapcgJaDuiWKE/JyYxl1fqu+hUKV3So+ZzEWKswkJQf9WnxJLk/U27VyzJ9feie4slL2DAvKkyNJ78wkwO3QuxeuGuqFNDwombfDPcKKdDnInvLJU8gbTLHbk9G5TnsfCbwmN1NQ7+O6Mb5ShvBenyPP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406075; c=relaxed/simple;
	bh=/1wTiWpsCpunOq5fzWEU9xuNhfBmPPkOYODo7GujLyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBkHfdNwhi4k090+7dbCsqcmGD0imDIB5AzdwY1DrT29OqT/xMHV9n0g8UKxH0blGBZAXqnB+297yIlnzcJApV/h/WY93LWHfM87JkzgolPnr8KU8OOkee5dOFaUUaS7Q7ay5LzUJ+DNepm6EqSHmDBWcSYAbTe+5FnFf3DPyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiWdFN5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C01CC16AAE
	for <linux-efi@vger.kernel.org>; Wed, 14 Jan 2026 15:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768406075;
	bh=/1wTiWpsCpunOq5fzWEU9xuNhfBmPPkOYODo7GujLyk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZiWdFN5SvPTdNAUhPXVsu6tOOMTlR5k8zfBkm2whiyn0TUM8irA+D9cTZqhbdgP3X
	 Ukgbf3CcSpkm6XOXi5GtyQi/cto0zj3Ovdep4vIUD+CqQ01xdm2G83VRsbLN7TsFWa
	 qq+uSNBtfVle6sUsVPDoMnqDwNl5oFEkcoeJzlTPqZUh60yzQi/uNX40zhsxYejw3a
	 DnDKcKIPAnkTwSf0h0qmMsyXEcoG3jAE2j37nupLsRPB61hh4d63StfPAphGbKvvjp
	 KfXp3kRn1j1TMzQB13ygKGl7TtyEAjuq3ThAzjbag6JWKFtbVLp2NZZ99FDcDCARh5
	 6CPFwNcJDFPdA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-455ddb90934so2785665b6e.0
        for <linux-efi@vger.kernel.org>; Wed, 14 Jan 2026 07:54:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUz7uKA4q84uNAJWS5+bb0suywEQ913hazfFo77UHpV8ELXxphpnSLP/DLKhje7TvFs2KIabQvHmvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlGtJxqQmOK8MfBYtBPAkmUe/ixWe9ug15aOJYkvihwgJXUPgw
	WsdEWuZCx1jHuOA5v0NAlxUVtnlekclqlBpyUc7yZifTjOMYCT38DVF1FoEBaTzmMzfbhmpikGv
	JKB/4TRD6hVPnRocRxn+muluZVh9zrvo=
X-Received: by 2002:a05:6808:1887:b0:444:1450:c1 with SMTP id
 5614622812f47-45c73e614d1mr2012498b6e.64.1768406074506; Wed, 14 Jan 2026
 07:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767871950.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1767871950.git.mchehab+huawei@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 16:54:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hq_CvW3P6F7paGSaKOw6kzX_yUEsFPfL1Coco6yBAUBw@mail.gmail.com>
X-Gm-Features: AZwV_QgR6vNMfQl8dFjf7vOcP8tSnhD2ep8Y06c90VtuR0ELeNasIQVPSS6lTjI
Message-ID: <CAJZ5v0hq_CvW3P6F7paGSaKOw6kzX_yUEsFPfL1Coco6yBAUBw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] apei/ghes: don't OOPS with bad ARM error CPER records
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ankit Agrawal <ankita@nvidia.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Huang Yiwei <quic_hyiwei@quicinc.com>, 
	Ira Weiny <ira.weiny@intel.com>, Jason Tian <jason@os.amperecomputing.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Len Brown <lenb@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:35=E2=80=AFPM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Rafael,
>
> Current parsing logic at apei/ghes for ARM Processor Error
> assumes that the record sizes are correct. Yet, a bad BIOS
> might produce malformed GHES reports.
>
> Worse than that, it may end exposing data from other memory
> addresses, as the logic may end dumping large portions of
> the memory.
>
> Avoid that by checking the buffer sizes where needed.
>
> ---
>
> v6:
>  - No code changes, just a cosmetic change at patch 3 description
>  - Added Jonathan's review on all patches
>
> v5:
>  - Changed the name of a var as requested by Jonathan
>
> v4:
>  - addressed Jonathan comments;
>  - added two extra patches to prevent other OOM issues.
>
> v3:
>   - addressed Shuai feedback;
>   - moved all ghes code to one patch;
>   - fixed a typo and a bad indent;
>   - cleanup the size check logic at ghes.c.
>
> Mauro Carvalho Chehab (4):
>   apei/ghes: ARM processor Error: don't go past allocated memory
>   efi/cper: don't go past the ARM processor CPER record buffer
>   apei/ghes: ensure that won't go past CPER allocated record
>   efi/cper: don't dump the entire memory region
>
>  drivers/acpi/apei/ghes.c        | 38 ++++++++++++++++++++++++++++-----
>  drivers/firmware/efi/cper-arm.c | 12 +++++++----
>  drivers/firmware/efi/cper.c     |  8 ++++++-
>  drivers/ras/ras.c               |  6 +++++-
>  include/acpi/ghes.h             |  1 +
>  include/linux/cper.h            |  3 ++-
>  6 files changed, 56 insertions(+), 12 deletions(-)
>
> --

Applied as 6.20 material, but I changed the spelling of EFI, APEI,
CPER, and GHES in the subjects/changelogs to all capitals.

Thanks!

