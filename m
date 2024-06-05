Return-Path: <linux-efi+bounces-1172-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0991A8FC6C1
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 10:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4841C22C6C
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 08:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A061946AC;
	Wed,  5 Jun 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phXFqZvf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF41946AE
	for <linux-efi@vger.kernel.org>; Wed,  5 Jun 2024 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576827; cv=none; b=rBHykxcsd1xDrtG6VhwORw8dCVD+00/QGsWGLbnFxxbsbqOPYCrh2kVh0+b7u7hRcmQk9gZH2XLgnlXqYM6ipAn8tUam6OyiuCJ+2tzOFU0uSu+1964sJLE4yxWF0c1kIi+CJXiMioaEQICCPdAuroI8Ksg9yipmrcuQX/KK89g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576827; c=relaxed/simple;
	bh=XvxE0RUDvxAuFsV02ROhP7KO5j6IqriYD38+9yq+8hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBlZm8WEKwJHiUXXyQgAChIqfV6R0l87HjNmaym6bSNFWOTqjRrVJJPOzAKvWUy+lfGVFvsFxtcyA7pgc7fOCn1D/qWsuAVMizcwbfWqSSHlkseUIAVYVSowKBzETvFaxgyIz9ukFOkEBtWs7D+c5KPvI7grqML1AsCb7xVmcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=phXFqZvf; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaac465915so19854881fa.1
        for <linux-efi@vger.kernel.org>; Wed, 05 Jun 2024 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717576823; x=1718181623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvxE0RUDvxAuFsV02ROhP7KO5j6IqriYD38+9yq+8hU=;
        b=phXFqZvflK9QHjYTWnE0OpHkKgjOVjs1XCVIkr35GBQ1yKCIcqOMsHGthItsrdRw35
         n95/BpTMfh8vjIYRDnzL2Q86cLksfN/kJuHpWeO5bmvNjMfox+WvWofBoQjnOCI3KgPO
         ibwjb0VA8g6s8BktfSHoD9JflE8QrKvLq1C5Axuk93NXRvNX2+0b1qHeDPlt612JNV8c
         CNkpO1KLcX6ad3v3t88HWe52yUkCVWLI6DEx6BjZVt5qWK8RtunWtK0/VmrCpC/Y/BIc
         0s4u1aR6RGACxhH3MDMMqALECszh/hLWNCtlr+Z8kbMczB+RVP/ZZpv2OOov0G/QocBP
         nNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717576823; x=1718181623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvxE0RUDvxAuFsV02ROhP7KO5j6IqriYD38+9yq+8hU=;
        b=KV99wSOWBjFjUEo2AEHezb/2pAmflhzQJHNBgqsjcLxjaeZ7R8Mn+aCFCVXOcbaHRw
         Mu28V6YfdRyE7q9sNmVO3Kq0dsp+iYdvpzRv0wLOJNJNc3f93bmo/HAiOrOfq+rCB1to
         g1PTaHmLQ7G5rIeSbfhJ3rFxll5mwzjArErONQ7QujkUoxpU2qI821cMTDheLSRG8qQC
         l2klnt8J07q+32EttIOqc36x3/btjptUU2agU1vzO7Mfom6ElLizeqaQDo1XP4WI3m7I
         fW5odHySBlZJc2yjG/KGs8csrFumLTKxpEuLnnsPXaQHoah5SiI5qErn4w+Qg2UtliL9
         fFtg==
X-Forwarded-Encrypted: i=1; AJvYcCVTDOeVqbyU2U7q6ZMxVtGCbKAnVq3OcyHrPz+BJnY+ukNZDLWv0Q32XPIAhTEmvMwdK+pAM3WYuQDkiMP+7q5azFtXpC6OhXLR
X-Gm-Message-State: AOJu0Ywhzdk4pm/0ynWKcTRIqY8Oyuk1FL8eHzWRz2LzZJkgzBn0t3WD
	0ReIxVqDs3oVB6r7NApdV1qxdq0P8h8tCtp9IyriH0kIMCRe7vjZunjT9kydKwi48/nbSzUvJWl
	5IrF1Njv+d70//zN2/najBfnbgpr+5TsIcirOXA==
X-Google-Smtp-Source: AGHT+IH7cOWi/e77wK/0DMS/t5Yrzb6yuNqs3r46xhSqOdntXdmg6Vs7uwEDi5wPbEumqQarcP9fW8N2W5L32IBrWo0=
X-Received: by 2002:a2e:9d11:0:b0:2df:edd9:d005 with SMTP id
 38308e7fff4ca-2eac79bfefemr8576061fa.14.1717576822846; Wed, 05 Jun 2024
 01:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604155625.2197275-2-ardb+git@google.com> <CACRpkdZ=-OMFD0d25m_YBjo+Wt-Ca7mjSNphgSA+2avxkcDYBA@mail.gmail.com>
 <CAMj1kXHZ=tchvZ7qmJiE2ajU2nbzkcMnbviyhZeug58wMWzNUw@mail.gmail.com> <20240605060618.GB279426@thelio-3990X>
In-Reply-To: <20240605060618.GB279426@thelio-3990X>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 5 Jun 2024 10:40:10 +0200
Message-ID: <CACRpkdYs_DR3s3m6kqgcn5Ke84UGpJoXKjJTXG_2P7qhpDG=og@mail.gmail.com>
Subject: Re: [PATCH] efi: Add missing __nocfi annotations to runtime wrappers
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 8:06=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:

> You don't need to rebase to include it but just for the record, I tested
> it as well and it resolves the crash I saw when booting under EFI in
> QEMU with CONFIG_CFI_CLANG=3Dy.
>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Thanks for testing the EFI boot Nathan!

Now my only remaining worry is BPF trampolines, I will
try to read up on how to run BPF on ARM32 unless someone
beats me to it.

Yours,
Linus Walleij

