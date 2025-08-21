Return-Path: <linux-efi+bounces-4585-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E072FB2FA74
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08CE5821EF
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACF533437E;
	Thu, 21 Aug 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4spp80R"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C432233436C
	for <linux-efi@vger.kernel.org>; Thu, 21 Aug 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782832; cv=none; b=dARKMKI31FwpzShTiyiyC+MFCp8+S8zfe6G4JWcs+RKIUYbL9rSgZ22lJUFhqkK6OuW4U4yuvKKbvVqLfYD5wZhjy5684kUICjWfDphdDqrkZ4gxWXnIsAPZhocCuIuDEec94c7nsLO87KAvr9a88fFuEtljb6SCqMTwVFPfie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782832; c=relaxed/simple;
	bh=7wm2W8BdjxtMx0zQmKaAvq1NAERm3m272ZTgG+IyrPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYsYSebVSSn2I6B4wKgt+NvWl+aJtBv6dfRXBo/5mM+kgzlm+rJAGeY/vqgusoUmH3Zs+Rnegr7R/AGQitU8Hun+B2k22bdgLLsus/1TQzhFhsSd5EK89WmK2m3Y9xCT4mi/naFJa3q8ORP3u+b/VSOzXQpzJzCsxan2Ko/V0jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M4spp80R; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e94ea56725aso1043045276.2
        for <linux-efi@vger.kernel.org>; Thu, 21 Aug 2025 06:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755782830; x=1756387630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7wm2W8BdjxtMx0zQmKaAvq1NAERm3m272ZTgG+IyrPg=;
        b=M4spp80RizxkKWhudgP7/pg/zb7cRJHzvJfRdyWE3uvfpbCbdUKO22InPbELwWyyvJ
         Z/+mS9+K1N54hwVHfPt784IGXP4icgznEobawSD0jwNxkRJP5X+8QONVqj+4kAPI+kBQ
         iYLTmXgZovDfw1jvOMI2c0bv7wOi6gcluWZPGBBg5zDTswLGJXkszU5qbdeBYb1VCOG4
         7CcqHwoYgizRsGZDPvJjxGhkKXjrNihHNd31ZL/vGyxl1yKXappHpPc/Sm6mcO6jLM2l
         zs8DMa0wM9gufC5J1Jzp+YX4BNQtZA1bto0XmaltLVnLsP9J2dfEnS7X4Xgc6YvIy3uB
         +yqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782830; x=1756387630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wm2W8BdjxtMx0zQmKaAvq1NAERm3m272ZTgG+IyrPg=;
        b=nDe39bPJJWEOfPzrDpU1U4TWa7oN5N0kcFqnCJLyoGFc0zPCqwnentuxvIuTRYUKj3
         dscCT1G7WGEQ/X/MZNK7IM3i0dpMyR2sZWK+J0nTGZAYnttKhy/wLJh9ITKFRtaWk9qq
         9awQ1kLdRiNyJp6yAOcKTwkP6fL7ktN2RToKcCFIWUoIvAcezvyFr3Mhg43CewXv8rEJ
         Fj3JtUbn1SmV2ryA83mJ/JuYAmm0fIxo02UbKMEvz03aotfbmMOP/HC5Z+Tz/kFKTGf+
         BYh1dwKOGwAcM8AEcxHs/d6KrTxKY1p2EUPvFNNNn1l7EjZ6CErKWlz7/IS2R5RTUv+X
         CmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlesBect0/iXxAPcbsuoVe90UT2XN3XaStK3Io1WjdF/9HR5QkiimenFfRg+5ZXLIehWxe6rHv6zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs1eVPYOra9zzuB6i+qx007tVIXjCZv0fvmACzzhjv3IXdz5dg
	WCy4v9FTozJhiiQ/Mm4w8Cp2gMhQqjqhfOgoNCXHc2YLJndpKQoOLSpRJXlnYW/M5PW1ghI3w0Z
	HRCueK96JFTzS/PsbLEYhmxYjWEZ+Zm4l1LEaIysaKA==
X-Gm-Gg: ASbGnctmYSsHrknOCV/gfFCedvZrrhVZB0aYMC8kMUI3jS3wDnbtzx/VD9XU3Dmbocm
	k98Yp79/USWwfmMBg4Dn6J4lL1nF3i4aHLxrzYgNU5QQgAbfhyYFMTArcPecw7Man8/BRQQr4pS
	SJUgAYQCG91EJauQZN7V+TDRAyI8cqetfokWczueng6Ds6TQCa78E4vSDH5JrrWHENh8DoR5vlr
	UKL8C8xdbUfc5tesj8xU9lKhOmLhezmbsX6o00b
X-Google-Smtp-Source: AGHT+IEj0h/LwZOxGTRuKo85/IJqDM49Kxictjq1uzS1PpYHjDIs+ZTlaJVAyyLzNrazr70KAnjmjUib9T5ZdeFnFMQ=
X-Received: by 2002:a05:6902:5404:b0:e93:3ba9:9e45 with SMTP id
 3f1490d57ef6-e9509a6de27mr2684091276.43.1755782829678; Thu, 21 Aug 2025
 06:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755285161.git.jan.kiszka@siemens.com> <c53346c183ce0c3d02322726ef5808f468441a42.1755285161.git.jan.kiszka@siemens.com>
 <CAC_iWjLMFGp3wg=59PruJQb7heds6CUcy8FMZ_cdT0b2vC5a3g@mail.gmail.com>
 <50f7f2fc-2c6d-4ae1-bbce-e132b1d9c9fe@siemens.com> <3a9eb8eb-3420-4232-8259-3b33ed45dc66@siemens.com>
In-Reply-To: <3a9eb8eb-3420-4232-8259-3b33ed45dc66@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 21 Aug 2025 16:26:33 +0300
X-Gm-Features: Ac12FXws7T5AEBgk39TXNjCs8naGRTEnfry-l4q5CDOLsbQ6YRDbnIK3SKhYQik
Message-ID: <CAC_iWjJ5bogQwhqGRVBB59=J6wcB0q5h5B-LkiTkZOmwN4z-2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi: stmm: Use EFI return code of setup_mm_hdr
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahisa Kojima <masahisa.kojima@linaro.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 16:00, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 20.08.25 16:59, Jan Kiszka wrote:
> > On 20.08.25 09:10, Ilias Apalodimas wrote:
> >> Hi Jan
> >>
> >> On Fri, 15 Aug 2025 at 22:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>
> >>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>
> >>> If a too large payload_size is passed to setup_mm_hdr, callers will
> >>> returned EFI_OUT_OF_RESOURCES rather than EFI_INVALID_PARAMETER that is
> >>> passed down via ret. No need to fold errors here.
> >>
> >> Apart from not folding the error here, the current code kind of
> >> violates the EFI spec.
> >> If you look at GetVariable, GetNextVariable, SetVariable, and
> >> QueryVariableInfo only SetVariable is supposed to return
> >> EFI_OUT_OF_RESOURCES, if there's no storage space left.
> >
> > And with storage space is likely meant the persistent part of it. ENOMEM
> > is something different.
> >
> >>
> >> Should we also change setup_mm_hdr() and return EFI_INVALID_PARAMETER
> >> always? It's still not ideal, but much closer to the spec.
> >
> > EFI_DEVICE_ERROR? The "hardware" is has a problem by not providing us
> > enough RAM. Yeah, not optimal either. But invalid parameter is clearly
> > described, and nothing fits.
> >
>
> If there are no concerns, I will switch to EFI_DEVICE_ERROR and even
> drop the error "ret" argument in v2.

Yea, I don't think there's an ideal scenario and the EFI spec doesn't
cover the case where some allocation failed, but please add this info
on the commit message.

Thanks
/Ilias
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center

