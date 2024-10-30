Return-Path: <linux-efi+bounces-2067-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B2F9B6B8D
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 19:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE22C1C23672
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE11C3F0E;
	Wed, 30 Oct 2024 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rOU83etl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A161FFE
	for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2024 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311341; cv=none; b=ABxcVA2ySEuuQItr26BcGu4YI9/L1RtvMQ/fLZrVtwgMsRE26oFaiq3gyWP2cO6zb6JUPgf6zsYtWdRcBPjjxtANY8eSnoMcs2IwijLwWT/JhdaSgmYQRtjBb3/CcrdRgBJDSBwmyj3R29x/6Y9j3+w0g1nzYbxhkjtIwg72aps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311341; c=relaxed/simple;
	bh=EKlh2PNcustAN2BbV6glBzhNvINYFOpM3KHJCcAFnL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrUQfQOyrthUW++h8v6e1+iHI/C+QtjyJeqwBUDWU9y+jg2QYZEc6WTXPboM7TF8qXz04N8W2/fr9bVlk46bKib50Hl9zsVr/V14kap1qpFaCJ9rJLO+tVBC04Eup8Rlz+f03V1GxC15aaXfquvehDE4/R1O9X5NbSm7BHbPIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rOU83etl; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbe3ea8e3fso885296d6.0
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2024 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730311338; x=1730916138; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K17p/KYL7BaOYgmUduWmWY2xrt41oxSD9UX1LKxND/E=;
        b=rOU83etlkq8cth7r/9dWnzEjfBRO26GPOLm0BPoEwGLApBxjGVihkyfMLXbPkCWqAk
         i6XdaU/iUGAqvJ3M+DEsyYChNA+1ycwkd721tfs48hcep5QHl40sKjAlxX1Y2T8ZHJod
         KB6Al1Xgr19OzCte4zoSaKOKoLpdZFuP+nHKauiDK8GBjdC0cKEt6Q9tXdKYXi80Ro2E
         DP7KhRqgz82d5PPPSDbQmFcED/gNXcDUsd6TNQlNB3JtkmxV77uQcDyFEPFggIrJ2Ff+
         5OjUeaLO3jFN+7c1chG2iAoyweOA0sg2eH18z8GFdRKRQGSEWlsCQYVIY2aM4dUuRDUr
         Wo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730311338; x=1730916138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K17p/KYL7BaOYgmUduWmWY2xrt41oxSD9UX1LKxND/E=;
        b=PtYnHkmyoVa/joYDPHlSkHDnGJZkxLsp1GudkAWyM8ARJMNXYhPXOYjVZHdvVbk57b
         6xKC4l+mnqRdJVrCpy4w17WcjCfzA/ZyTjYKYjBn+baqMJfW7z1ks949tDfx/mNzOnov
         R0N+7rJYFO3tp22FDCMKzSLOD0rgJXtTePSx2QXfQ7YaoG2XfSH6GOub7xgN51IrHGoj
         KJ7g7kHP0M5OUe/Rzy/ftsUGkdMDPX+9HwtQHwQ20JCWeXkZykJy1/sCfu56LQ+z31TO
         E1ltTRagYjIOFQKS9jWTbzIu3O9vhtap4VKwFk0yy/kuinFpGwK4xLcXEhdrQw0klsH8
         e3wA==
X-Forwarded-Encrypted: i=1; AJvYcCUOIPmts/EGwfbBp50in8et02gJtS9qstgTlGlgbyX/s7+wql8pk9ID5yc6dsbJBijpeiY+hIJUxQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCikb926YscVYYQgQ6y4JoEtvazUg4nvVH+z+YXc/nx6QYBxeL
	Unwp1xHK56F2DpFa+/MYdryYephQAUqdPKXRjne4Z73sxKKEmah1+LceE2kuzQw=
X-Google-Smtp-Source: AGHT+IEnMn7agR2PllR6wW47m9qx5f3YfAmEbuVpAerd5/uQy2NQAdmZHCs9WLK6x7WcGQGA/MTdvg==
X-Received: by 2002:a05:6214:4890:b0:6cb:ece3:d923 with SMTP id 6a1803df08f44-6d351b25274mr6343746d6.42.1730311338234;
        Wed, 30 Oct 2024 11:02:18 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798a8489sm54483756d6.37.2024.10.30.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 11:02:17 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:02:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
Message-ID: <ZyJ0r_zZ5UD8pvzX@PC2K9PVX.TheFacebook.com>
References: <20240912155159.1951792-2-ardb+git@google.com>
 <ec7db629-61b0-49aa-a67d-df663f004cd0@kernel.org>
 <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org>
 <58da4824-523c-4368-9da1-05984693c811@kernel.org>
 <899f209b-d4ec-4903-a3e6-88b570805499@gmail.com>
 <b7501b2c-d85f-40aa-9be5-f9e5c9608ae4@kernel.org>
 <e42149a6-7c1f-48d1-be94-1c1082b450e0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e42149a6-7c1f-48d1-be94-1c1082b450e0@gmail.com>

On Wed, Oct 30, 2024 at 05:13:14PM +0000, Usama Arif wrote:
> 
> 
> On 30/10/2024 05:25, Jiri Slaby wrote:
> > On 25. 10. 24, 15:27, Usama Arif wrote:
> >> Could you share the e820 map, reserve setup_data and TPMEventLog address with and without the patch?
> >> All of these should be just be in the dmesg.
> > 
> > It's shared in the aforementioned bug [1] already.
> > 
> > 6.11.2 dmesg (bad run):
> > https://bugzilla.suse.com/attachment.cgi?id=877874
> > 
> > 6.12-rc2 dmesg (good run):
> > https://bugzilla.suse.com/attachment.cgi?id=877887
> > 
> > FWIW from https://bugzilla.suse.com/attachment.cgi?id=878051:
> > good TPMEventLog=0x682aa018
> > bad  TPMEventLog=0x65a6b018
> > 
> > [1] https://bugzilla.suse.com/show_bug.cgi?id=1231465
> > 
... snip ...
> > efi: EFI v2.6 by American Megatrends
> > efi: ACPI=0x7a255000 ACPI 2.0=0x7a255000 SMBIOS=0x7b140000 SMBIOS 3.0=0x7b13f000 TPMFinalLog=0x7a892000 ESRT=0x7b0deb18 [-MEMATTR=0x77535018-] {+MEMATTR=0x77526018+} MOKvar=0x7b13e000 RNG=0x7a254018 [-TPMEventLog=0x65a6f018-] {+TPMEventLog=0x682ac018+}
> > 
> > 
> > thanks,
> 
> Thanks for sharing this.
> 
> This looks a bit weird for me.
> 
> The issue this patch was trying to fix was TPMEventLog being overwritten during kexec.
> We are using efi libstub.
> Without this patch we would see
> BIOS-e820: [mem 0x0000000000100000-0x0000000064763fff] usable 
> TPMEventLog=0x5ed47018
> i.e. TPMEventLog was usable memory and therefore was prone to corruption during kexec.
> 
> With this patch 
> BIOS-e820: [mem 0x00000000a8c01000-0x00000000a8cebfff] ACPI data
> TPMEventLog=0xa8ca8018 
> i.e.  TPMEventLog is reserved as ACPI data, hence cant be corrupted during kexec.
> 
> 
> In your case, from the logs you shared, good run without the patch:
> [    0.000000] [      T0] BIOS-e820: [mem 0x0000000065a6f000-0x0000000065a7dfff] ACPI data
> [    0.000000] [      T0] BIOS-e820: [mem 0x0000000065a7e000-0x000000006a5acfff] usable
> [    0.000000] [      T0] BIOS-e820: [mem 0x000000006a5ad000-0x000000006a5adfff] ACPI NVS
> TPMEventLog=0x65a6f018 
> bad run with the patch:
> [    0.000000] [      T0] BIOS-e820: [mem 0x00000000682ac000-0x00000000682bafff] ACPI data
> [    0.000000] [      T0] BIOS-e820: [mem 0x00000000682bb000-0x000000006a5acfff] usable
> [    0.000000] [      T0] BIOS-e820: [mem 0x000000006a5ad000-0x000000006a5adfff] ACPI NVS
> TPMEventLog=0x682ac018
> Both with and without the fix, the TPMEventLog is part of ACPI data.
> 

Just wondering - why would the TPM log move a total of ~40MB between COLD boots.

I would expect this location to be relatively fixed (give or take a small amount of
memory) - especially since it's so early in boot.

> It means your firmware has already marked that area as ACPI data. Are you using efi/libstub?
> 
> Thanks,
> Usama
> 
> 
> 
> 

