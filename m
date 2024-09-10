Return-Path: <linux-efi+bounces-1696-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CFD973D09
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 18:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2257B2868D8
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34448A945;
	Tue, 10 Sep 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Oz4xwql6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965139AFD
	for <linux-efi@vger.kernel.org>; Tue, 10 Sep 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984915; cv=none; b=Oz6JtWGsczVRlSpUtHlUzVKWz3q6wDEnUGBS2qr1n5MY6xk7/0iNmB3JxERbfMwtMBy6hFu0Vvgi9+xpKusQGZdf7357CNc7OYMBX5pz2VLnezw98UhzR0Yl3GnW9Jask07RZIY5+UV1+DKYDS7Ncbu27ldoRxroR0pqvVdWD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984915; c=relaxed/simple;
	bh=h3D6yLVnl0C4f6sVy9dxu2fh6dcxO99LkIn1UgnfwEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrAcfQHwQT1QO7EARHR0sqhB1hk7aYT2/YNjAZcqeEVagQtp5czuqlMWK+BkxfvJl1J48WPVhW6qfugFbr8wOwQ/KiylxEimmTFdSjkPy4LrnbfYvSJxwY016qvVCs9jiBv6jcTaOqElpcO3+yAE38oJai0530mdDo5cX/u6blM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Oz4xwql6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4581ec0e00eso30427141cf.3
        for <linux-efi@vger.kernel.org>; Tue, 10 Sep 2024 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725984912; x=1726589712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U5oeFB0UtmNBoPkoP3tI5YAp46EtRYc2ABouATqet3Y=;
        b=Oz4xwql6a+vKTqs3VWXOBKP1hy+LVV45TtXaUexAvwhvC2NEVxKkakdJoCHl/AHyDK
         dNg5mw+M2vMvriFQJ/b9BlcD8lnz2rYIyPoYuhNT8WipSjhvyE6hMhk0EWb5EwBCoIUe
         Jys+H8rxl++i5oMz+LJqDGQfBy8Io6Dx8CqlzIST7W2D4WB75yz+zCH71nhEaaq2Bqut
         rDf66/Rf7iwlMvnQH3PShdxpfyNqVCOk6UB6a2zNyWLeB2qiWoqZjTTPI/HnIcrriIH8
         EGyvndKeTqj2gRc6yG0nAIPcVd8Mp1MFqnGja+682Xp6pkxP2DIIAQtljfEvg4Z+TcUG
         lPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984912; x=1726589712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5oeFB0UtmNBoPkoP3tI5YAp46EtRYc2ABouATqet3Y=;
        b=XmDzyyQFNDK4Zp+sBMLIGZYkZcdzofuU/uDFiSvbjJsan2+rnOioGVSmYgIFNEVcLD
         DoKTlxGWkCVOeYvksGUc3nEeImdT195gFTTk0DPjig9bNMm0dlfKxdEXg9+mz6BBLuyt
         5Y0VhNgG8Znpx01pLQObOzOyr85rVuyNgVmC7qOsXqscnbJdffITqC7A3FHQyeo6YTdx
         Jy1dI/ZeHLCScpcwqXkaMEhQwNxA8ZRbmQ3PRrxxa8yi3gj256XK7lcHCRMS0iwVcpoA
         PHeO1nI1sEr11w2Y8xCd4GVXoxMLVkKD64dZEW0i0gjIioNk50hmNwZy1kZEU1VpvSu6
         yI9g==
X-Forwarded-Encrypted: i=1; AJvYcCUb8rlHLA0nUBgFXBKlzGqBSdyfcoUiz09iochHNO/8QiQrAyXe960nFUJdRddBlMfUhYc7N+fulg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwynPPFtVfa/Jg979xEGu1X78KUkidiTEPJPdUBnE4XtpStNqaN
	wX1Akm55jnRlGIzJI3tzlmFZxo0EiPisaPZRRM6qOlWZ3mGHFO9E535IGFXTe2Q=
X-Google-Smtp-Source: AGHT+IFTpWJi2aFDiPPHk0+23A7HN9yHR65F6ZyPjK7cId6epq0hxHHaXBsc3ShG3FbcaSvGW7M5IQ==
X-Received: by 2002:a05:622a:198e:b0:458:294c:39e7 with SMTP id d75a77b69052e-458294c3dd5mr172987661cf.38.1725984911873;
        Tue, 10 Sep 2024 09:15:11 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f93978sm30231351cf.83.2024.09.10.09.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:15:11 -0700 (PDT)
Date: Tue, 10 Sep 2024 12:14:32 -0400
From: Gregory Price <gourry@gourry.net>
To: Breno Leitao <leitao@debian.org>
Cc: Usama Arif <usamaarif642@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, ardb@kernel.org,
	linux-efi@vger.kernel.org, kexec@lists.infradead.org,
	bhe@redhat.com, vgoyal@redhat.com, devel@edk2.groups.io,
	rppt@kernel.org, rmikey@meta.com, tglx@linutronix.de
Subject: Re: EFI table being corrupted during Kexec
Message-ID: <ZuBwaAA_84weAzuW@PC2K9PVX.TheFacebook.com>
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
 <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
 <9b024f7d-e326-46eb-bd88-71a16151fcf0@gmail.com>
 <20240910-strong-dancing-rottweiler-aaed51@devvm32600>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910-strong-dancing-rottweiler-aaed51@devvm32600>

On Tue, Sep 10, 2024 at 09:09:21AM -0700, Breno Leitao wrote:
> hello Usama,
> 
> On Tue, Sep 10, 2024 at 04:46:15PM +0100, Usama Arif wrote:
> > --- a/drivers/firmware/efi/tpm.c
> > +++ b/drivers/firmware/efi/tpm.c
> > @@ -60,7 +60,9 @@ int __init efi_tpm_eventlog_init(void)
> >  	}
> >  
> >  	tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > -	memblock_reserve(efi.tpm_log, tbl_size);
> > +	if (!memblock_reserve(efi.tpm_log, tbl_size)) {
> > +		arch_update_firmware_area(efi.tpm_log, tbl_size);
> > +	}
> 
> Shouldn't you reserve the region into 8250 independently of
> memblock_reserve() return value?
> 
> Thanks for the patch,
> --breno

Probably also want some sanity check here that we're not over
writing already reserved areas before we just update the map.

If we're dealing with the scenario where we can't trust the
hardware/efi generated map, we probably want to put a small
amount of effort to ensure we're not wrecking the state when
the system is working correctly.

Only so much we can do in this scenario.

~Gregory

