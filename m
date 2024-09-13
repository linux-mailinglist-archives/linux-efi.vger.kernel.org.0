Return-Path: <linux-efi+bounces-1740-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BAE978232
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 16:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181791F26AC1
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B931DB52E;
	Fri, 13 Sep 2024 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FoJ7BDpx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0037C1DB523
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236275; cv=none; b=miEk35YqRr6FpJBIXu7MwD9hvJsGk70uqS6ERPBPBdL34WNoJFzs/UPMabdSgCZAva/VoaaVXII5Pkxbtv2+ZAJw55ADU6KW4VMuSTY/8ceVDX1rSf6ZI6rNbmDO8WQ0Ml+m++3m+NB+dx/IQRW9iIkorqpg60r/qqbKYJBavKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236275; c=relaxed/simple;
	bh=lRAFs8AFzw/PpSoN4wy5HoNo5gRes9DuFwQpRAs/ZQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/IwWqPdZ1acbZC2SY3MJuba0UwDmVAuQXZUF7FmtnKABW0CzANegI6fmJXm6SexD35jQn9t+2bScu91WkzlBOAbjl4R2ENjOJS7h+qNBSRLoX9lVIQ77Zvfx6JFw8zmkqeACp5oy2oeRmmU7QsCkTkip/XRxiL0yBnEMLwjMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FoJ7BDpx; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a99fd5beb6so261401385a.0
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726236273; x=1726841073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLksJP/rhb8eqI+HK9T7IjB9aZnFUbuXu6ZyAADYNVg=;
        b=FoJ7BDpxdim40YVUJxAmrb9RDGqP5jp1AVt5LscfcHM69DlCddJArGdxJw5vd3efTq
         Owqexb2wdc5SdkbDUGq3wjKT4LzD0Kuwc/bjqKFIjDwMZJq/3Rjc8aAB18zZ1EjTM8+j
         9LZ4dIa+pBZ/WFGeoINeywNwnVXpbf6ZbaGT1k6yRTQ8F/j5Ew416NxhreWfjuCjGtzB
         9SATmE3GPEaDN8d2uAjx0Ue0GJ1AOSPhT1n6IwiWA4Yait/InvOfZ5wEydQvEyZyAeor
         gdGs/yMZiFCsjPgW69+/XVlHJtTkuT2D8wjBi8K9++rEqUi/AMPtD35/CUbnvlsrnw+q
         cpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726236273; x=1726841073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLksJP/rhb8eqI+HK9T7IjB9aZnFUbuXu6ZyAADYNVg=;
        b=qWs9xIV9gqNkNqdiZvUvE96PCidjKp40B2Jczdy2HWaHCrImTunAK51DcUbuLAxJgl
         mT4MAtZG/7HNzuwIP7EXmEjol0yLF48PVkZYsyfmkHaU2PzjCkJebKDND2H2h6k6AJVO
         RcuH9C16JSSUfn5g4PSi0OBRxmEeMMxsMywyIdCC2WUyk3IBQhGDaMCx5plEkeUalATZ
         MFKFQHK6uOZuXmubz27hm8AqHZsuhhMNwWmFEia5ByHNDoX3sD+m8PVVWltsnfx/G4v7
         8dMXHLoCE319w+6qMCTWm1WLIeWjTL7a610F71nBzM9JIKYsCjt9X0aHhCmrZ86olK7I
         GRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUt0XEiYE5BSM5qKz1AHStCymJCcz2UYZlhLYILiTRjX7LaaXB9yRt/yG4myu7xlS0Wpz9hbjIBnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxocYAVqhaLsIMn+KXV13sDczzPgyatSMumJDzmdRdCvW++i6Iv
	/eHdMlxwQvPCpWjvv1IYV2Nk/qcef9/espDYUADteFSXDhLhbsWJso+g7RzHAwI=
X-Google-Smtp-Source: AGHT+IH4NCvGaNE+Es+iBNh83ffGpuZef2D03EDpMqVLxAngpEsawFYZLw/f5SZOMq/7k2BuNz6o+A==
X-Received: by 2002:a05:620a:4145:b0:7a9:a690:caf7 with SMTP id af79cd13be357-7a9e60bbaacmr1049715385a.18.1726236272630;
        Fri, 13 Sep 2024 07:04:32 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a799119fsm660409085a.57.2024.09.13.07.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 07:04:32 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:03:47 -0400
From: Gregory Price <gourry@gourry.net>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	leitao@debian.org, usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH 4/6] tpm: sanity check the log version before using it
Message-ID: <ZuRGQzirtUfih7sO@PC2K9PVX.TheFacebook.com>
References: <20240906202745.11159-1-gourry@gourry.net>
 <20240906202745.11159-5-gourry@gourry.net>
 <CAC_iWjJizjQWucDbrqKGdZTcj7FFxiPN97=p1zwfnPE=sAC6RQ@mail.gmail.com>
 <ZuQ2c7XOptYMJEtD@PC2K9PVX.TheFacebook.com>
 <CAC_iWjKoptBngCj-W6axZ9bmJmhT11JMctn1m4maVvO4mzcENg@mail.gmail.com>
 <CAMj1kXF9rpKJV5Df34F_oYZ1ZVbQ8Lumiw0ZOUnpVH6Dffq-Pg@mail.gmail.com>
 <CAMj1kXGnqact9B+=uhbGCV=2zaNQQBGsTk=a-NejUjWCoWDutg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGnqact9B+=uhbGCV=2zaNQQBGsTk=a-NejUjWCoWDutg@mail.gmail.com>

On Fri, Sep 13, 2024 at 03:47:03PM +0200, Ard Biesheuvel wrote:
> > > If we agree that this needs to go in btw, I think you should refactor
> > > it a bit. That function already defines an out: label, which unmaps
> > > memory. So you can rewrite the above as
> > >
> > > If(....) {
> > >     ret = -EINVAL;
> > >     efi.tpm_log = EFI_INVALID_TABLE_ADDR;
> > >    goto out;
> > > }
> > >
> >
> > Validating a table that was created by the EFI stub seems redundant.
> > If the version check needs to be tightened, please do so in
> > efi_retrieve_tcg2_eventlog() (in the stub).
> 
> ... and actually, this version is set by the EFI stub based on which
> flavor of the TCG protocols it found.
> 
> So i don't think we need this check to begin with.
> 
> If we need to detect corruption of these tables, I'd prefer to add a
> checksum or something like that. But I don't think we should bother.

Will drop, east enough.  Will send v2 later today.

~Gregory

