Return-Path: <linux-efi+bounces-2638-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C266CA12679
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 15:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81DF161EDA
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014314B959;
	Wed, 15 Jan 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSFTwu3I"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5714B077;
	Wed, 15 Jan 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952578; cv=none; b=TM7SMvDf2dPFqEizCJlrofm6o4QtbhsvWJ79K4VgJIH1Sfxe8MPfSsmVamMgTDvQZgj73aK2YokiejErNT6vxqOcBQ453PjujLtdy1oPpUmRcN36722Uo3JDy9z5mpGxHQDusndLKXEBt/banAEl84UpfBrMJnvQdEz68dPg9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952578; c=relaxed/simple;
	bh=HYmDns0/ZHClPcY3GHW30oQcrRcty2cPWMgZUsCgKN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPG13UEbcOAM9gPzy584Tu1jSteZlNajbCGPpcDi0XjqLr0yJvAxMnN3g+vzJURZe9WHKlZSa49lH9I7Rwj6CJ522pmYpZv1AEG02rnXoJx6j2hwFEZdmUSeDUQt/cY4vDbPEkmGzVsnwyKH/s+dWr35/Py2krzt+hiAoyd1Jhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSFTwu3I; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaef00ab172so1064787966b.3;
        Wed, 15 Jan 2025 06:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736952575; x=1737557375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj2rjdqrFe/GVBz4nuOUzGX5ROmEJSFNmYf29Er6Gz0=;
        b=TSFTwu3IKFTEKc0/4S/mA4KqxS8KvJdjEVmY1KHzK0Fj+OQpgNgU7i+8O1e1GUlwr3
         mNlMpuSzL3HEKVyiDaI8BrWlMxfhiOZ+CHYM0rQsijZHsz0IegDPBbKi0KXqOrETuICd
         XVJcIyIXMsioQhVya5ylu5r/63OhTmA+IAWz+3Hng/74J8QDWZDwW3+cOwCxwRbzoRsH
         Xmj1kx+NIoT1jH0ePlLTuSLxY4lCCmtCwyKNtkftWS/FcA2EXMaewW3m0BjhoBdDx5Nf
         BCFnNDw7AHARMSaTKApQ2pnj9VxaTVcRSTNV0CvqeZuLNCV+LzG5uswU2E4b9VxYq0z8
         W00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736952575; x=1737557375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tj2rjdqrFe/GVBz4nuOUzGX5ROmEJSFNmYf29Er6Gz0=;
        b=roZZro8JWUba7kuw/LUeUAh03FbhdL1Rfh9zzIfTdtK6KUevmpl7ypFs+CGKN2BUI9
         +zGh4Zqvd2aGLhVngfn2U2O4yKunJfIxgRQELHVU78bvuQhc/AC4N6uMJqQAb2URZHU0
         o27LlvTlOTeBe56pqDwPaM+30pSTXqLefI/oeVPj3z3hkJ6gbsnFB8E/0ELXFzgSKTQb
         c4EkuqTx5B09BcJJWl+euvMn3UZsZn+G+qRzjj37mD29sxi48m/2sMan3xCPIH8Fgi5z
         AB2VC2E5JNVRBqBcX+N/s+04Uv32nyy1rHYE3mVmNcGZqWJOVQcAzv+JyD5DgU9lHmDG
         Wdwg==
X-Forwarded-Encrypted: i=1; AJvYcCV2tujXKUGqhFtl7HAqV/3kNQQlNzClZcaFvCF9yD2hDseNIAVII+YtaIZeLr0gKlMz9e2Eq4AFd7w=@vger.kernel.org, AJvYcCVkg0iVEBBqakS5z7UgEflrCwOsD4poNlUHo5GFhl7ZAYnjULNeAnpjbq85tRY6ky6/GSeXamJ7DjZB@vger.kernel.org, AJvYcCWRHtsEppPbgzRtr+W9eLxfjaLIjIyAWF8ofczMllzh5Rf3tKpU+jSDXfWGeDAaJRrR98I0ttZbdxJk5CPp@vger.kernel.org
X-Gm-Message-State: AOJu0YxYti1gfCbILl6+Q/Hn+ljw0ZbIuHAC/ZPpB4gNKnmT/OQyDLQw
	emSOeKscxxDn0TkqA1beum+1Aa+3bv1YwrOuCD6ZY94pVdDaj1OPtskZ94U6l+3IGxpVCVvyCgy
	sBz1XFl30P0ox6Q5y+5zJPyUunde+CMyP2s9hmQ==
X-Gm-Gg: ASbGncsZOgyn60w9AXNDrr6/D8npMflzIAYI6xpJjOPUoUnAOaqd/bWP/odXoLeKDNN
	hRiJJ5jXwNjTpczJMc7D/djT4C5S66ofok87/pA==
X-Google-Smtp-Source: AGHT+IFkExYCfIQy2nWN8Lcxq+824AjZpo0o0ZXDeoa+FU5IAuF5qAII3OFz94PIXwQ8kmpFdQ5FrPAmlN0hsXjg/NI=
X-Received: by 2002:a05:6402:1e94:b0:5d9:fa36:5964 with SMTP id
 4fb4d7f45d1cf-5d9fa365c32mr13866849a12.2.1736952574317; Wed, 15 Jan 2025
 06:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115141458.9182-1-o451686892@gmail.com> <28105c4069a81c017b501551df7aa67aba743241.camel@HansenPartnership.com>
In-Reply-To: <28105c4069a81c017b501551df7aa67aba743241.camel@HansenPartnership.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Wed, 15 Jan 2025 22:49:23 +0800
X-Gm-Features: AbW1kvZp0KkYQAY1Mv2PdvpKtvqB8cpxzH5bAfI691hY0HJfIyOalcetItoLkbs
Message-ID: <CAHk0HovnRgxrKu0uoj1x3XSB1vrTaGtMn-7iaoSR5Fs+=EYd5g@mail.gmail.com>
Subject: Re: [RFC PATCH] efivarfs: Introduce efivarfs refresh remount
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Tim Schumacher <timschumi@gmx.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 10:34=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2025-01-15 at 22:14 +0800, Weizhao Ouyang wrote:
> > Currently, when setting efi variables through the runtime service,
> > efivarfs cannot sync variable updates properly. Introduce efivarfs
> > refresh remount to support efivarfs information updates from other
> > sources.
>
> What other sources could there possibly be?  While the Linux kernel has
> sole possession of the EFI RT interface after ExitBootServices has been
> called, nothing else should be able to update the variables except
> efivarfs.  This is a guarantee from UEFI so why do you think we can't
> rely on it?

One route that may exist is: drivers/firmware/efi/test/efi_test.c holds
some ioctls to call runtime service.

BR,
Weizhao

>
> Regards,
>
> James
>

