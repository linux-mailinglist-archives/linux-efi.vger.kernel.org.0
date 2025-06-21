Return-Path: <linux-efi+bounces-3899-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE7AE27FD
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 10:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 530757A39B8
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FB018DB26;
	Sat, 21 Jun 2025 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVVXGTYc"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14DB46B8;
	Sat, 21 Jun 2025 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750494205; cv=none; b=cRRqtFyXxbxIukJHqIIXb/D8r9AwRT5NoG7rqjZ/GvXc9SO0vpk7RobOhViJqfn+qV/ZjrxhImz+c+5nQlpPu6jHISmSvmLdXtmTYY/Q5dTMCA03IQKxReVNiCo2BY3cJuruKDLi2sEcYJ44W0lZK8Zb0LEBaWOFhbhEDgsFtak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750494205; c=relaxed/simple;
	bh=SZjLcvfhH4BHwBWNAGHSLpHqW7zEvj6pGY9nmqQyAlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt9K5l84Z4XwG/F47kLE318EM3QiCrlZbt4LJxGlfW5EGtthoLDzvT+Xw5SuT3glkn/hA02r9PWLLcO5UVrtaLaTvgjtsUnPxR+cFiMHDpY6Or5x1f4/8KaVEGAdW/cHAZk44Qivs14dCV0jI5y8JMyCg0cD6GZeDZvh2JgXPvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVVXGTYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7377BC4CEEE;
	Sat, 21 Jun 2025 08:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750494204;
	bh=SZjLcvfhH4BHwBWNAGHSLpHqW7zEvj6pGY9nmqQyAlg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tVVXGTYc4mfuDnvYMLh1NrppnoOGb+K1KQgM2Q3KpnwsIQ59+9qNGxscrPzAO/NGV
	 W99yYhXSpEj22QBVlN7paaEhPzeBVn9emmy6lJdRnruFvzQnsYPbWRAnoSdn3jbYGu
	 THJSWLcKqSXIQy0fMeU402mGaALMJ7SXRpixRW7T+W6U9NtLFHZ9YM3WVGMSgbtWLT
	 cbqsRNmmbNgBove4OXbMMyu8TZKXIZ0lQcx2310OuBqRRAqyOvF+EIg7DsAexKRPOR
	 J4tmDlZUdEP3bBn1po1y5SmN0aeJHXqI8JVtkHM1IFk9ppqmf8OrDlFAcW0QgJP3Dv
	 pA6+ubRxQYdBQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553b16a0e38so2716301e87.1;
        Sat, 21 Jun 2025 01:23:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfG2lzicsV29XAayh+5cnIsy41cfuvah/nNPlsrgdhWEFzRcH5cmyAn/FFCFe0d63kbjMN3JTiBso=@vger.kernel.org, AJvYcCXAJGhP4el9hQjZN7eMSKuYbdYUbnLirvWkHQJGWEOCQGzrAqgrE2WR+j1PESO0RkrbsQM2AX1s42qm+qS3@vger.kernel.org
X-Gm-Message-State: AOJu0YzRStfHtcju52ZujYUnLaK+1a66b4eYt03nN2tpvlfSFNd0Ysfx
	UXncwDRi5e24jCI7dbqsGFrXuSe/LNZsmeOQFjIhh3iP3QDYNxTQeOGo8P/vJGrHEGmNNQGNl4P
	byFHRjrzwzgEsy/VQN+3qdaZoNXhS+yY=
X-Google-Smtp-Source: AGHT+IGUaaV1RTtm4HIkvdnEESt1QJhuZXxuKWNHTfE35/8j+dlKegSg1Gi6VqJ+Jwq2tEcaijJpeRCltz80kSljnKc=
X-Received: by 2002:a05:6512:3d8f:b0:553:5176:48a with SMTP id
 2adb3069b0e04-553e3bc0523mr1818526e87.21.1750494202845; Sat, 21 Jun 2025
 01:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619151759.355893-1-vkuznets@redhat.com>
In-Reply-To: <20250619151759.355893-1-vkuznets@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 21 Jun 2025 10:23:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHPvqaF3VK3E5HbvrChQ2iCqDRhkP6M25xAWaprx-XcxQ@mail.gmail.com>
X-Gm-Features: AX0GCFv8BftNe3NMI8IxGnRlQkF40I8Z0M68n_oGN-aCMNCp5ccps2Xx8g4YYlY
Message-ID: <CAMj1kXHPvqaF3VK3E5HbvrChQ2iCqDRhkP6M25xAWaprx-XcxQ@mail.gmail.com>
Subject: Re: [PATCH v4] x86/efi: Implement support for embedding SBAT data for x86
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Borislav Petkov <bp@alien8.de>, Peter Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
	Emanuele Giuseppe Esposito <eesposit@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Luca Boccassi <bluca@debian.org>, 
	Peter Zijlstra <peterz@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Jun 2025 at 17:18, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Similar to zboot architectures, implement support for embedding SBAT data
> for x86. Put '.sbat' section in between '.data' and '.text' as the former
> also covers '.bss' and '.pgtable' and thus must be the last one in the
> file.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v3:
> - Update optional PE header so .sbat is accounted in
> 'SizeOfInitializedData' and not in 'SizeOfCode'.

As discussed in the other thread [0], let's not fiddle with these
fields - they aren't actually used anywhere.

So, Boris, Ingo, Dave, mind applying the v3 [1] of this patch? It
already has my R-b

Thanks,

[0] https://lore.kernel.org/linux-efi/871preptml.fsf@redhat.com/T/#t
[1] https://lore.kernel.org/linux-efi/877c17pxsz.fsf@redhat.com/T/#t

