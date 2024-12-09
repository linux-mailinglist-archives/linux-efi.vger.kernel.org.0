Return-Path: <linux-efi+bounces-2323-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 876369E8E91
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 10:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CD218864AF
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82D4215702;
	Mon,  9 Dec 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl6B1YGx"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31291EB3D
	for <linux-efi@vger.kernel.org>; Mon,  9 Dec 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736051; cv=none; b=tEQNEnNYXJSoSNyKWLNFWiggZoGJ0LZmmBH4xD+dH9f3egFncsGLD3P4p+fxHMZOTQiB6m1B+/lFHkjXPfkAIhLy4jRcZQlxxP2c3PLDKpuU1Rdnn7lWueYhOGfxKd2LsSEkl0mKikaDk0LM//mQepmOefzoJoKji3OdUCBnWKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736051; c=relaxed/simple;
	bh=NWNmrQ1I7V4khd9WQwLiBjUqqowyyVf4fcQZSnqggXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQ/xw28s7avE70Kbm4wLXZwZ4fzP6xneznbwekxnUoUjfgQ/bMbhcd/dq7h27GblTnHV6fAWNq2sR+HXMWMWpHiGHvid2gXMa6UWvCVwoB34OuMXlg48hs9xBj+NTtl23ePx1E25hO62A5JCZwrj3pv1cehkVziIwJnU5c9lpL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl6B1YGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4A8C4AF09
	for <linux-efi@vger.kernel.org>; Mon,  9 Dec 2024 09:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733736051;
	bh=NWNmrQ1I7V4khd9WQwLiBjUqqowyyVf4fcQZSnqggXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kl6B1YGxXe3XAPt2mG0l0E3WcwYpT04XmEWdCJp7BnoQVxMH++bvNY2ejSsCnRtoM
	 TXJS9KVTLU793d7sfNcIyptfj5WvxhSpepB1h+e506xsN1Itc7CkWz1mvicdqgNURA
	 m4jJQr8crAF/aR/FkUJQ877VsL8bHaUnirwYFDGbx/+sl7N5J10kkmcrlO9Vqvsmdi
	 mWHYjvw7q76bIYtjKF0RJ2wRw32eZuQlN9ptVsK4fmIGfVZKKib7J5ufkNyN1AmBKG
	 EOAspmwtOsJ9qotkE6e8OS7cNwTq8pFAfQIolQi+N9o1nx/QYupWSueZy+vqWo33AU
	 FVdE/ezLVYOjg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e274f149fso4625666e87.1
        for <linux-efi@vger.kernel.org>; Mon, 09 Dec 2024 01:20:51 -0800 (PST)
X-Gm-Message-State: AOJu0YzN82gT7bguWzPxOo24oBYR8Zxm6NSE8d/eJpHVbMj3mt8Ps079
	mWf+nB7CVwURjOfFIqQbSBg2pdm6vKi07wrPi5hLpH0gUyEdvZrT2eU2/qCeNBSOJiurguG59TK
	e1n+P88k16JeOv0iqbjknltPrDcI=
X-Google-Smtp-Source: AGHT+IE9jZ+Karb+t/YpSxwwC9kLwFn/BwNVjx3GI8dBSi6C8W5jZDfQxs7vgkBY34Qd6+mTkEdX7SfjK4Z/XgESju0=
X-Received: by 2002:a05:6512:e9d:b0:540:2208:cce with SMTP id
 2adb3069b0e04-54022080ef4mr566265e87.24.1733736049528; Mon, 09 Dec 2024
 01:20:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208183415.21181-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20241208183415.21181-1-James.Bottomley@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 9 Dec 2024 10:20:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEULbHRF4ywSGeRGPJeVe9P5r1D_Gvt55TZBKHvGsEdGw@mail.gmail.com>
Message-ID: <CAMj1kXEULbHRF4ywSGeRGPJeVe9P5r1D_Gvt55TZBKHvGsEdGw@mail.gmail.com>
Subject: Re: [PATCH 0/3] efivarfs: bug fixes
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Dec 2024 at 19:34, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Patch 1 is stand alone, but 2 depends on 3
>
> Regards,
>
> James
>
> ---
>
> James Bottomley (3):
>   efivarfs: fix error on non-existent file
>   efivarfs: fix memory leak on variable removal
>   efivarfs: fix incorrect variable creation
>

Thanks James,

I've queued these up now.

