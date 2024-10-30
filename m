Return-Path: <linux-efi+bounces-2069-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F93D9B6C12
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 19:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814301C23EAB
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 18:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F4D1CB333;
	Wed, 30 Oct 2024 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jztXfXL2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EACF1CB515
	for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312766; cv=none; b=OMMxgsbvj4rqgti5RvI0mxGCGqWpGhhjc0/UUhW+A0aS0sRyKdL7VSS7aaDrWHLtOMZc9EHbf8CA4YqbbkAkb/vmiKwcgEqk7fOiAhVzKRatcxf5GGoFflWG687vCitYetcvtWSgJgXlJ/P2qgkXY8IYXSedw9pOWGxvBr3f7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312766; c=relaxed/simple;
	bh=G3YGB2i7Fqd9ihHSxO8Pi0dveD/nQZafEDr02VMTORQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvKZ/VGtrO9OBjhnb/ibhVOiZjfWlKc1UmrmFjcFtfSu/0e0q6bvnMux1HWNbCjOhwbUKbtN62R0oaS7+sTZme31sO2untx2maw9DK+rBdxvSIOdZ19eQ3ckLCEPcVirHpc5isIBewwknUvTpI0ksZjtrA5AvkRWWISg+2M48Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jztXfXL2; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46089a6849bso1089611cf.3
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2024 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730312762; x=1730917562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DbjE0LVey+AU8nkE8GiAZE2/PJGlPEdVxDqptqhMLAI=;
        b=jztXfXL2NFrCWvUzjZhCHvDX0JlqjFDX1+zqO0ZNzrhgBYvt//AOvLqle300cVLtTd
         zDn2qhCRfH36OnGpDnnYp9Y65amjXRbITRBKDVw4sHfhmkbGg3fH/EujKrtntXEmHRbr
         9X21j9FoRs+uHixntfxZiigg66F81eR0OFS6QTb9dV4y2q/4zVbATO+frXqwPP/D5Vf1
         jc3pSpH35PiXFDGMup7/YCNFsTrtMo5BblgHwZJReQsmI+N2oAi5ZlM35pZFh4nGSh+o
         heXHiawO0eObTA16OEOnvnLZqDB7WVmjdBHt829lES2ncRtia1RpoDyRT5RfX5jt5Bdy
         mJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730312762; x=1730917562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbjE0LVey+AU8nkE8GiAZE2/PJGlPEdVxDqptqhMLAI=;
        b=GB2vMYn5fT5yqMLsbXK6UarzuYFXXHLpWKltfPSJ2hbVsk1c3kFKAvgg6q4muEfbGM
         ejiyfHV3dpoEkUFNcJ7he4eN2kXTeOdp5DQOjYeVOPIkWPp53H9UgWUR3Pgj/FIZsrjd
         I9U7h7rqU8ivTyAr8b/h/PSvKxTNAI2FKnB/YZJT/gVfYOBvovtn7yEp+2JEvoezJTJb
         khThu9J0edXzUBmO5iZ3amKt21aY6Pr/6Hk29Z2ZstzsSq8A3cC1lRnsURZX1F0Ax49Z
         DAqlF2i4+fxc9la4mO0OcsSmdnOpj5/mgesKc7c9IMLvElSm+oQ3SPulnRiygjTyLFz8
         07Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVwygfrc4bb+uFwq6jqdEfdt4D3Ns3kk3IAmgU5O7YjDJn9UdoaunhwrWnpTKw9dVunc/ug94hFEzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojZTfmxauMHplcz05AEv5qbVdrN++/v27y2z/ohpKfheDSJZq
	ho3OYj02t7Wu1NUwzcMi3Dotcnl0Z8N8tSQxiPlGaKrSw3szmfWKlE8nBvVj1QE=
X-Google-Smtp-Source: AGHT+IFYDQQKS4cOudgXSyZkOKT8naielk8Nl7dGnc5cJxXyNsgI0H5LFNiELyY/pqK62ZdYy6tkVg==
X-Received: by 2002:a05:622a:52:b0:461:43d4:fcb4 with SMTP id d75a77b69052e-462ab280929mr6249451cf.26.1730312762497;
        Wed, 30 Oct 2024 11:26:02 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323a1fbesm56805021cf.82.2024.10.30.11.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 11:26:02 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:26:08 -0400
From: Gregory Price <gourry@gourry.net>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
Message-ID: <ZyJ6QHc9FetDckqo@PC2K9PVX.TheFacebook.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42149a6-7c1f-48d1-be94-1c1082b450e0@gmail.com>

On Wed, Oct 30, 2024 at 05:13:14PM +0000, Usama Arif wrote:
> 
> 
> On 30/10/2024 05:25, Jiri Slaby wrote:
> > On 25. 10. 24, 15:27, Usama Arif wrote:
> >> Could you share the e820 map, reserve setup_data and TPMEventLog address with and without the patch?
> >> All of these should be just be in the dmesg.
> > efi: EFI v2.6 by American Megatrends

Tossing in another observation - the AMI EFI we've been working with has been

EFI v2.8 by American Megatrends
or 
EFI v2.9 by American Megatrends

We have not seen this particular behavior (cold boot corruption issues) on top
of these version.  Might be worth investigating this issue.

you may also want to investigate this patch set:

https://lore.kernel.org/all/20240913231954.20081-1-gourry@gourry.net/

which I believe would have caught your "eat all memory" sign extention issue.

This is queued up for v6.13 i think - but possibly 1/4 deserves a stable mark.

~Gregory

