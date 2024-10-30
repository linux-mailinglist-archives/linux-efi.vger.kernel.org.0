Return-Path: <linux-efi+bounces-2065-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5C99B693C
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 17:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043B4282A8D
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA21E47AE;
	Wed, 30 Oct 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uvhIiQJx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3526296
	for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305947; cv=none; b=jj8DRHQX4Z+6Z3ibS31Ycl25U/nKZyEYOV5PPtd2nP3eRzMXFXsTXVjET/3BwJR1ztpJFM2TaRQznS3cAk//afNjhJx8WauXADZCpf/mCvICspRJTRCc4sZrkJBrAPiLZA7tKeOu/LqQ3JcC4jWlh9B3yxEo0JnkuD9f1ZIkHX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305947; c=relaxed/simple;
	bh=pEPVRF5+DgnXnRZSZ1kKlI9RGplVRziuZFa2Pl+8l/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzNQrX3BbX6e0+avgEpWoVhV8y5pzZyKeh6Zrr0QF+uCQyl6ZQc4nuO2i07WCc2l5IvCUoKlgfbtdrC6s4oReeL0Rmxfz/Zykdh+PAx1+mpZibn9LTZarMR0gAzWkV2g6BYckVgh91hLtiOv+BwY2gGt1HHlrJDEXGsPJ2JUZx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uvhIiQJx; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b1467af9dbso2831885a.0
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2024 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730305945; x=1730910745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnMPV7W7l2RvnnW42qBLhLXVbPCvhd3V2TD3GpAwLro=;
        b=uvhIiQJxhFDz1hh87cX7LNbYavIB5UJkWGG6BuIyzTTGE4ZWZru4AEjFVzFILU/i4t
         oFtsYuh11e9L/3yO8b85+Z9B6ZTIHeEGTNZ/0VDpeTMKpMpVKRZqnS8eXLe7AzfEqDmt
         MWpY3vtExCmbmDSpi+SaMVwUdsUY6pH7ITHL2RqVO0r8LV1hk/3iWyccKMUQeNbjQRym
         GCBNXInQtuv2uRn8U75aOeEP0pQ7LZbwRuMCws0l9NcfnuhWbtwhMW3PcByrDJ2MNzeL
         dy7ZmG8MNSQkH9D6MSGPC4KW+XXJj5IIKa31vdjWmweo4DYqdJk+50P74BNSN/ul+Lc/
         yQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730305945; x=1730910745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnMPV7W7l2RvnnW42qBLhLXVbPCvhd3V2TD3GpAwLro=;
        b=Iv35RqpjLiv1MhHpP5MT3pYDWRfLhOXHAAhVxlsba5v+wZV9En5pzF+jU/vAPYYlV4
         SJpq2VCaoawHlLyrAkK4cYwiv7juHRtFQZvYdVPuv+16EiKdheO4iCnMyR/5C9tQLeaG
         6rn0AzU15rQOSyZPR0MuzRLkzywVbSbSLJ+fgNdI5GcMQS/7y95vI3URGQE4KpZ+d2E0
         8h5E8PYjEVTwkEk6zCyKOzWPYT3nQLeBQM4NvVrZUOEj76AZmgx9pUe7gmOR7sBcCTGZ
         KVxGHinYGTIp2/XaIh3Tx/jvu9KXaGYqOXd77OicCPI98a7kaeFoiQWufiDHenxjGwBV
         4Fow==
X-Forwarded-Encrypted: i=1; AJvYcCVgh1n00xd6WkwzSHIWBz5wmLEI5KpoGTVnd75eEyIBJMmT7+M+CwprP9vWkmS+b47Y1H5UpOQR6nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRusp82NmLPh0D/91TVFzn6nIEATRDCZxsGZTgv7EE3V2AP6Ei
	NZjWSglRF7hMvhhUTxSZRj4imTiXLke5Mx9ppcWWUsgLTD7+cNiXq2+5FYm6ao4=
X-Google-Smtp-Source: AGHT+IHUGJKPPztjwHDZ1Fsm8kR2ulAQuHxmZmgEri6RNBQkQaPuB9irRDhhHGF1/Pcdxylx7HnUWA==
X-Received: by 2002:a05:620a:2989:b0:79e:ff4b:3401 with SMTP id af79cd13be357-7b1aee75a24mr461410785a.66.1730305944807;
        Wed, 30 Oct 2024 09:32:24 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d27911asm529745285a.26.2024.10.30.09.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:32:24 -0700 (PDT)
Date: Wed, 30 Oct 2024 12:32:30 -0400
From: Gregory Price <gourry@gourry.net>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
	linux-efi@vger.kernel.org, stable@vger.kernel.org,
	Breno Leitao <leitao@debian.org>,
	Usama Arif <usamaarif642@gmail.com>
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
Message-ID: <ZyJfnjj9lkd5MBQH@PC2K9PVX.TheFacebook.com>
References: <20240912155159.1951792-2-ardb+git@google.com>
 <ec7db629-61b0-49aa-a67d-df663f004cd0@kernel.org>
 <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org>
 <58da4824-523c-4368-9da1-05984693c811@kernel.org>
 <CAMj1kXHqgZ-fD=oSAr7E0h9kTj_yzDv=_o2ifCCD0cYNgXv9RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHqgZ-fD=oSAr7E0h9kTj_yzDv=_o2ifCCD0cYNgXv9RQ@mail.gmail.com>

On Fri, Oct 25, 2024 at 09:30:51AM +0200, Ard Biesheuvel wrote:
> On Fri, 25 Oct 2024 at 07:09, Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > On 25. 10. 24, 7:07, Jiri Slaby wrote:
> > > On 24. 10. 24, 18:20, Jiri Slaby wrote:
> > >
> > > ====
> > > EFI_ACPI_RECLAIM_MEMORY
> > >
> > > This memory is to be preserved by the UEFI OS loader and OS until ACPI
> > > is enabled. Once ACPI is enabled, the memory in this range is available
> > > for general use.
> > > ====
> > >
> > > BTW doesn't the above mean it is released by the time TPM actually reads
> > > it?
> > >
> > > Isn't the proper fix to actually memblock_reserve() that TPM portion.
> > > The same as memattr in efi_memattr_init()?
> >
> > And this is actually done in efi_tpm_eventlog_init().
> >
> 
> EFI_ACPI_RECLAIM_MEMORY may be reclaimed by the OS, but we never
> actually do that in Linux.
> 
> To me, it seems like the use of EFI_ACPI_RECLAIM_MEMORY in this case
> simply tickles a bug in the firmware that causes it to corrupt the
> memory attributes table. The fact that cold boot behaves differently
> is a strong indicator here.
> 
> I didn't see the results of the memory attribute table dumps on the
> bugzilla thread, but dumping this table from EFI is not very useful
> because it will get regenerated/updated at ExitBootServices() time.
> Unfortunately, that also takes away the console so capturing the state
> of that table before the EFI stub boots the kernel is not an easy
> thing to do.
> 
> Is the memattr table completely corrupted? It also has a version
> field, and only versions 1 and 2 are defined so we might use that to
> detect corruption.

When we initially identified the TPM log corruption issue, I had a gut
feeling we were about to discover a lot more corruption along the same
lines.  It feels like e820 should have significantly more ACPI entries
marked to avoid kexec from touching it - instead of just 1 or 2.

Hopefully I'm wrong, I'll take a look at the raw memory attributes on
a few systems and see if there's a disagreement between UEFI and e820.

Not looking forward to a thrilling game of whack-a-mole :[

~Gregory

