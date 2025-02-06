Return-Path: <linux-efi+bounces-2764-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7DEA2AD68
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 17:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2181699CC
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4781A5B90;
	Thu,  6 Feb 2025 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MXSIOQbK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5181E2144A5
	for <linux-efi@vger.kernel.org>; Thu,  6 Feb 2025 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858454; cv=none; b=XiMlzYOIJR5mDcrPFqMc4B+OLtDqfOy0FtQx6HoeMG7qFv4FI+A7yw1GvpHI8yDqZZv3G5lhuGu+mDHoGBcBzalG+wWs7oyYbAdtvbp2sKNPPLO1Qka6oaSkd9qaOvf86ZwWA3qdad9iWYG39sFbgG04tCbk9e6WGD0YZGgHlWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858454; c=relaxed/simple;
	bh=nrsb/6slrFvGTvXm0j6jKPf8WGzk1y3PJkT9vMo0J6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBSrBykxar8D9xzkws05SVNSZElxdLqbGc+ddzYKJU6DIbKF6IlkGbQEYQpGOMo00yhvvFt9QyRXnpk7JGSnrU4G0Ipt9rKd/UruqKaxTeh/l4oFl7YceHzftEIrNmd6cFSLNwbcKaoeKJgy15NAURjhegMd+f14dRzoyA+Ly/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MXSIOQbK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ddcff5a823so8143006d6.0
        for <linux-efi@vger.kernel.org>; Thu, 06 Feb 2025 08:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738858452; x=1739463252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+lewjv5vC1GR7f3hvHTYC7l4Dem4ZyJ3lIDyklSVdf8=;
        b=MXSIOQbKzUhMJgC2KgT13lK30usYCjG8wmjIQI3l61TJsDYwmYVqM9u0BpBd+LfwA+
         BhsXP1hWS8FGpZ/ZU8WgQly1pvIcIFeGSl0CGB1zzBXGuhw8fbKZKurHmzVUG+bb91b/
         QZ01xuwDDP66llHu8c/Rs1Qw5ElbAOEJiQJgUntOEnAJHsvNpW99ALlLekhS81355jq7
         4uL98hNkH5dbtPvqU33ewYJaP2qgzZqRvWjKsFwxa7ZVufzP9VDN/ttSSMIh9yxT+dDw
         TW7ceMxTXyH3wKyx0gfgT1FMlEkoS28zSD/PbARL7hp+JpLeq6PeRfqJnK/CfKrjtyuM
         X9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858452; x=1739463252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lewjv5vC1GR7f3hvHTYC7l4Dem4ZyJ3lIDyklSVdf8=;
        b=eav3I+tNoS0pS+x4nvJ0JlvXP1z90wQ3sMbuS44BN4G6IFD8zJKnJuxGM+IIMr11L+
         rRg0OCJw6FTroOKYIgu4XvBm0qhetoaeIw6dBGkr8cG2OCFHmrQ+ivFQhbfamw3RMJgi
         vjk5Q4kWdM5FvKfGaC5lyu34DcqdxIahSnSlBTI3/4NYj8DqjD5XYud0XDvr3UghLEA8
         9rAl50zrgx4eTV3LtR+aHeqJSmMTQz5TWX64yE5tE9SnfdKP0egjlhnL/RInlwTqLDkP
         lGVmdT0FKfp1ES8MEjhbOXFjTDjuo8Vc9plRjGuI3wNfpr5KIb08rj6JlyTwop/1DJ6/
         Ij2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEW4n4gJAH2Q9o9kTSw4mufPwx8Nw8idpirAZh84bEEK2jixLT7PtwSxo9P+CXvlnCI5q/NnvrStY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCnc5fIgusO7SL6M2P+zBF6TLTzeD6kBBXdGRJv4F0zVDe50W
	vSTT5l6jRKWqpbf7zMjGjxVJscCupv1/adqnwnegVdPcu9WTRywUiTwRRUbQQwE=
X-Gm-Gg: ASbGncuIeOCwMfz3Mvo2aQDToi5/RSX6e0KmDPiNnDCErBnGTK/8kLdznMMmnNLmEq7
	fEurSBLXJ/QaoqP4zD3+uAjhrehemTnlzM7/WoCtnGxxKtc0osH9lJuV4V4c8KtNmSmYtEwxhX9
	U0lUqXO8i2z0u9/QTUH7hSuaKlrf+PAVbEDwftW7kb97yHxSgXSg+0U2P19tZRsw276CHQ2tORi
	c2v/7urJhYI7C/Xz4i6b7jCRjcqPROf9SFhyZPxTycJXcOvEWdBtV3XpLWTNidT+0LmVUzzkjbX
	PCmVh+yw04WlCmBE0AYP26fFVb7d02IssWw7WGQ8/dsiN/Q+KbpLcjMhNIBHbm4N9vzwJwFF1w=
	=
X-Google-Smtp-Source: AGHT+IHCPJkVR/Y9XWSDTzf6oo12O1B1UvudAIA23zaHHHxZzlraEKKuGMKsqWMkD3DIEDgloKWNDQ==
X-Received: by 2002:ad4:5ca8:0:b0:6d8:a946:eee5 with SMTP id 6a1803df08f44-6e42fbc629bmr106479266d6.23.1738858452144;
        Thu, 06 Feb 2025 08:14:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43babbaf3sm7039996d6.109.2025.02.06.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:14:11 -0800 (PST)
Date: Thu, 6 Feb 2025 11:14:09 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 2/6] efi/cper, cxl: Make definitions and structures
 global
Message-ID: <Z6Tf0ZvZMfqth_t1@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com>
 <Z6O5JqL30lFr4S8Q@gourry-fedora-PF4VCD3F>
 <20250206105403.00007062@huawei.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206105403.00007062@huawei.com>

On Thu, Feb 06, 2025 at 10:54:03AM +0000, Jonathan Cameron wrote:
> On Wed, 5 Feb 2025 14:16:54 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Thu, Jan 23, 2025 at 08:44:17AM +0000, Smita Koralahalli wrote:
> > > In preparation to add tracepoint support, move protocol error UUID
> > > definition to a common location, Also, make struct CXL RAS capability,
> > > cxl_cper_sec_prot_err and CPER validation flags global for use across
> > > different modules.
> > > 
> > > Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>  
> > 
> > Reveiwed-by: Gregory Price <gourry@gourry.net>
> 
> Reviewed...
> 
> If Dave picks this up will need to tweak that.
> > 
> 

that egg on your face when someone has to spellcheck your tags
:facepalm:

trivia: The last upstream `Reveiwed` patch was 2017

Funny enough b4 takes the tag as-is.

~Gregory

