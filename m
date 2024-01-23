Return-Path: <linux-efi+bounces-422-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB1A838D59
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jan 2024 12:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A63287A26
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jan 2024 11:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F90E5D8EA;
	Tue, 23 Jan 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAJqhnlh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6335D8E6;
	Tue, 23 Jan 2024 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009065; cv=none; b=RnJW6kiYGKxv3KaYGz1FR2c3PQeT+lYVizOPpxY8rJJebjg67dNqc/2zd/rOTTIoUaIY3UWLXJ1DRCvOtDv62trwNn/YHadXGEnX+VFRcdNhwDbSENrF6mEseDkom6aigJi6Is8qlSeFQGy77SYdS2WMFMgLwPRACDQwTMaq7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009065; c=relaxed/simple;
	bh=diM7LQAsZU5GLiPrROkBho/LF05pjJDQI31vycUb4HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSqWlSHd/cQanv/vTyELh+Uf0weylUSYr6StA81csAa69W8/X0Z9WKyLT4L0+NdvcwMNEzpoiJjle7Koohg5E+ItoBtDtlZAVbWIDpASBROksnMOGNYEsYjtLA81uBivSKC3GJn/ciLdJ83y6udzTjTKJKFTrlS1a7xXdygTa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAJqhnlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81088C43609;
	Tue, 23 Jan 2024 11:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706009064;
	bh=diM7LQAsZU5GLiPrROkBho/LF05pjJDQI31vycUb4HQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sAJqhnlhtusoW9Wf6vBB09ZUC0YYHAlGNQNpFRa+taj2Tp/cf0j2LLwryEr4R4uos
	 ZmRnthm9ceOUeR1dYoPHgnc6sE048tvVjX/FfG371IskF7UUKIL4RsnPP8BEgbDtko
	 EHH/5qo18gsSi4wJSr1VuznQ2SvwsU6UjXuPyyR9OXr+dHxFZsSFeIyV7WEfpJUxAW
	 rHSPRDL7PwsOFOFsJut1RIJu/yPjO5k8cRBEFbIsrZaFNkZklNPVdVNLGirrm0qQMy
	 YP6Dlsf1ARAg2QMQScf/T1MXOWFsjiCaG4TTrqEwn3GRqy37aY84TtdM8lUC063rrc
	 B2a45j6e9At+A==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e80d14404so4547126e87.1;
        Tue, 23 Jan 2024 03:24:24 -0800 (PST)
X-Gm-Message-State: AOJu0YzTvpH1HY7TH0XHn1oxGhPVqbVvf6vX+auDZULF1xyJ8iQB9Q4D
	pCmnXNkL1Yn9qpKPyL9IG62QvyHR0xpHzpM7zBqYT4k5JsL+6zap3B6U/mM7S43Yt6tx+jHfKea
	bzoQv0H1Htb8OfcMpZyoK00qI1Ik=
X-Google-Smtp-Source: AGHT+IFaDczuxtyHw1NKUn7RytqhjYCbKXNhAROvcZkBCm4MLR0i3qP8o7ORsqByTAFNwcvIIE4GVVVddFpKsdUKn44=
X-Received: by 2002:ac2:5187:0:b0:510:545:d884 with SMTP id
 u7-20020ac25187000000b005100545d884mr549163lfi.22.1706009062727; Tue, 23 Jan
 2024 03:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122231507.1307793-1-timschumi@gmx.de>
In-Reply-To: <20240122231507.1307793-1-timschumi@gmx.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 23 Jan 2024 12:24:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHSSRacU3hp6D3sdUKDESi1FoD33Qi=5Df+=_biZ-vqhA@mail.gmail.com>
Message-ID: <CAMj1kXHSSRacU3hp6D3sdUKDESi1FoD33Qi=5Df+=_biZ-vqhA@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: Iterate variables with increasing name buffer sizes
To: Tim Schumacher <timschumi@gmx.de>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Peter Jones <pjones@redhat.com>
Cc: linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 00:15, Tim Schumacher <timschumi@gmx.de> wrote:
>
> This sidesteps a quirk in a few old (2011-ish) UEFI implementations,
> where a call to `GetNextVariableName` with a buffer size larger than 512
> bytes will always return `EFI_INVALID_PARAMETER`.
>
> It is currently unknown whether this is just a botched check or if the
> length is interpreted differently, so the underlying buffer is still
> sized for 1024 bytes, even if we communicate a smaller size to the
> runtime service.
>
> Cc: stable@vger.kernel.org # 6.1+
> Signed-off-by: Tim Schumacher <timschumi@gmx.de>

Hello Tim,

I wonder if we might just reduce this to 512 and be done with it.
Presumably, Windows boots fine in UEFI mode on these machines, which
suggests that it passes a value <= 512 too, and I don't recall ever
encountering systems using extremely long variable names (i.e., longer
than 512 byte)

