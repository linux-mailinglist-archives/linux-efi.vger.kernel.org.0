Return-Path: <linux-efi+bounces-1644-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FA3968B09
	for <lists+linux-efi@lfdr.de>; Mon,  2 Sep 2024 17:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34831F22BBD
	for <lists+linux-efi@lfdr.de>; Mon,  2 Sep 2024 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2331A2634;
	Mon,  2 Sep 2024 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="G5J5YmVf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD84419F135;
	Mon,  2 Sep 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290916; cv=none; b=EvzJy8cxAUuNPUYVD6C5H2UgiFhkRnSkvqJY22O6SEsHQjT4H/9fLmZiOerO8UTd69kc08ChwQWZ9RHpTtyjsQZewS3nG9tcTsA4xc5HQ42c1NX2vkaiDkC5/Nt6G/fUeOu12A27qSup13t8Qb/+UA8+i+jpynq89XnQzXiCHKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290916; c=relaxed/simple;
	bh=Do0rvgKlkHq8ASU6039rFshbKnhl+L6kgjVSUyIV/2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxqCI4LpJ95AhVZw7b85/RikApuWwshbjhQZwK9076mZYI3IeGOs+MhNDZtiwvPjU4mDK+gaZXs/yUmgJJ0wEFVqRSuccCfP69xxt6W+O00R0t/FjgL0WPSygUblShuAgu0vKFCKswsd/zT4ZSaiU0TqPafxyTzKYVQAtcaYAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=G5J5YmVf reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 476F440E0284;
	Mon,  2 Sep 2024 15:28:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mxqVLOupLElX; Mon,  2 Sep 2024 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725290899; bh=v1rVrPx0zTAxn60ub0hHERL/EEmSzE33L7q+4cw2pqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G5J5YmVf3YT9NhA986KamNtE9zh3OAey7J2/sgPKpUnF6j4cMZdjDE8RDFmX/qC28
	 Uoe3ZXyRVP7PTGHi7qYS1WGrzgOsKKeUlNZisWaM0mxoDQ5TLgfnIzXVwSxL635kLD
	 yKgAkh70AvUx4OjB9uMlNb1EZrBIAeD50fFl+VPAg1dub+YgQPjbDcMD2/tSHKOsf9
	 wKsZqf38OfBH0HLxkO9kWNIpI2OIit78tvvFnBcH/wnxjTi/vu73SD4yA82yY3krtq
	 kWwKVeIpEyfSEKxb2wGeBfdbD7h91mewH0ljomOsQ4SkySmQW8npn8Nx1xiPoLaM1Z
	 iXz6lbcrlmsdnnm5A/9YYz0FTomZF79+YQVNd/sWG8vFQIv0gn8cGAgBAFUr3oO0Y5
	 EaDs+XScP/p7fXBO8LLbwVhKQ8Mbarl10asKZaXEnbyPFKAzDIXIt1eWN7HiMWst8t
	 n3Nn9JinCnhfO6x7hla9BdawuBhcVmqqZFRP0mIEOPOBvpx38qt+ideRDPtNByeatt
	 enlSgK5qZ4QVcTc+/yv7wP0XqkKwUlylrw0CpBlCKXp8q6gH7mW8xhmJbfVQizMq8D
	 Qdn/q7HRE+5woDgpgziR/lt+7qRVivMwtr+jtLnJYgmtM3MH1MrEpzfrA/JYmfNWeb
	 vMhIzX8tGdSaR36fKHO+RWFg=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D8D240E0081;
	Mon,  2 Sep 2024 15:28:01 +0000 (UTC)
Date: Mon, 2 Sep 2024 17:27:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Ferguson <danielf@os.amperecomputing.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] efi/cper: align ARM CPER type with UEFI 2.9A/2.10
 specs
Message-ID: <20240902152755.GFZtXZe5FPSfjRa9u3@fat_crate.local>
References: <cover.1720679234.git.mchehab+huawei@kernel.org>
 <1ca1274f57fac69eda2f193de53077e8254a70fe.1720679234.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ca1274f57fac69eda2f193de53077e8254a70fe.1720679234.git.mchehab+huawei@kernel.org>
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 08:28:55AM +0200, Mauro Carvalho Chehab wrote:
> Up to UEFI spec 2.9, the type byte of CPER struct for ARM processor
> was defined simply as:
>=20
> Type at byte offset 4:
>=20
> 	- Cache error
> 	- TLB Error
> 	- Bus Error
> 	- Micro-architectural Error
> 	All other values are reserved
>=20
> Yet, there was no information about how this would be encoded.
>=20
> Spec 2.9A errata corrected it by defining:
>=20
> 	- Bit 1 - Cache Error
> 	- Bit 2 - TLB Error
> 	- Bit 3 - Bus Error
> 	- Bit 4 - Micro-architectural Error
> 	All other values are reserved
>=20
> That actually aligns with the values already defined on older
> versions at N.2.4.1. Generic Processor Error Section.
>=20
> Spec 2.10 also preserve the same encoding as 2.9A.
>=20
> Adjust CPER and GHES handling code for both generic and ARM
> processors to properly handle UEFI 2.9A and 2.10 encoding.
>=20
> Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Reco=
rd.html#arm-processor-error-information
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/acpi/apei/ghes.c        | 15 ++++++----
>  drivers/firmware/efi/cper-arm.c | 50 ++++++++++++++++-----------------
>  include/linux/cper.h            | 10 +++----
>  3 files changed, 38 insertions(+), 37 deletions(-)

How was this thing ever tested?!?!

Geez.

drivers/acpi/apei/ghes.c: In function =E2=80=98ghes_handle_arm_hw_error=E2=
=80=99:
drivers/acpi/apei/ghes.c:565:34: error: implicit declaration of function =
=E2=80=98FIELD_GET=E2=80=99 [-Werror=3Dimplicit-function-declaration]
  565 |                                  FIELD_GET(CPER_ARM_ERR_TYPE_MASK=
, err_info->type),
      |                                  ^~~~~~~~~
cc1: some warnings being treated as errors
make[5]: *** [scripts/Makefile.build:244: drivers/acpi/apei/ghes.o] Error=
 1
make[4]: *** [scripts/Makefile.build:485: drivers/acpi/apei] Error 2
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/acpi] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1925: .] Error 2
make: *** [Makefile:224: __sub-make] Error 2

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

