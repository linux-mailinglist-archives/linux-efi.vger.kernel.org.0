Return-Path: <linux-efi+bounces-1447-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A979340B8
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 18:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F5128180C
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAAF181CE0;
	Wed, 17 Jul 2024 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7o7UgZ6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F316FB9;
	Wed, 17 Jul 2024 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234825; cv=none; b=EeLRgxDAInxF8KXWwMpo6BXQY/ZmGv+CHeBdA0j3LL7oesKe7eqeYcDX41MEfHJqjFP58U3j5XG5hJSzjw1aNRAUg5xVsIou/N7YmR0nqDPplV+VRFDmq87o2gQ+csOH1NOrl7w/l7ARwUnexH8QGEor7d3ra4pXisPLIC5copY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234825; c=relaxed/simple;
	bh=bjfZpRRhlg4PJZjWOwnrypPHq2aJtJFQKmMzYU7HJA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+Zi5pu23xwugLn8Dt+8WrNy8IyDPQZHBPzMb12AiEf+6DHbLodkA8H1vquH53G6x1j3DiC1W6vivAOuWbk80+LQ/VCVuP/4qjIdUplo+w0o8sNzHsq3ZqHlK5TvdTrxrQiBrTpbZlp3j1r04um7jypmbFPlqEC9RoJ6JHi/Kz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7o7UgZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C21C4AF0C;
	Wed, 17 Jul 2024 16:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721234824;
	bh=bjfZpRRhlg4PJZjWOwnrypPHq2aJtJFQKmMzYU7HJA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G7o7UgZ6EfkezTfgXM/OKVeOJKYo7WyWrqehnyGd2QOeFmG4pe7VAFiBfC6cmASUW
	 8cHY4wOJyGgOBXG1oS37U53OxHtM5kIowQXjTwK2Ls9sM34IY7AwhxAD5yJVBZ/s9q
	 3EqTudX3bYESsk+/NlJmciApyus20oPSCQP/mNFLJVNNr1ilV5s13h4KAH1bUhe6s0
	 RMZXullt7hVJ8ZhNFY7rnnfM2VUpNltFnPWN6hHjbkN6bIOQkxW6SZV/66HpF5HNaX
	 rySznN1T+EQGmrsSLE0z4lVsJZDHIp390OsL81Sxv55dSuXJSnkkkB4THR/uh9YWRV
	 rhf+NZEQXCuRQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eec7e431d9so91463071fa.2;
        Wed, 17 Jul 2024 09:47:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjtKzQkoJ8wAopvZbRv8ys26c7YOQBrqvyJBSc0r5l2G9rMtRiTLZvR0FKQTC70Npu51xQv8u3Z9558f0eec52DpZFPHA2ZVe+bFad
X-Gm-Message-State: AOJu0YyCzjOjxzbDdmK3i93pxkr/OhfupMmkq5FLW568/E/GKI3Kvmcm
	W5po4GGRNLOCZqFZZG3Ml9h1ieX7KD9W0L9QxHE4oUtk4jPnu0cWAWSMcUJ4nlE2rimqeTpyUkP
	Rk0RJln0aAvo901mnDDhIv06IQMs=
X-Google-Smtp-Source: AGHT+IFeguZgPWKv5F3wDcTmi3Pu6/ZfD2nDPZBfd/jwmjzZt4tiBnUUPex+wwRdBMi8sCHlC3PsIotQifWy26FS078=
X-Received: by 2002:a05:651c:b2c:b0:2ec:4487:6a8f with SMTP id
 38308e7fff4ca-2eefd138815mr17924531fa.37.1721234822854; Wed, 17 Jul 2024
 09:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701140940.2340297-4-ardb+git@google.com> <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 17 Jul 2024 09:46:51 -0700
X-Gmail-Original-Message-ID: <CAMj1kXEGsnd5S3-nnCUNYJ5tVr2LU2BOkNp513OfU6A=jgVX2A@mail.gmail.com>
Message-ID: <CAMj1kXEGsnd5S3-nnCUNYJ5tVr2LU2BOkNp513OfU6A=jgVX2A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
To: Aditya Garg <gargaditya08@live.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Lukas Wunner <lukas@wunner.de>, Kerem Karabay <kekrby@gmail.com>, 
	Orlando Chamberlain <orlandoch.dev@gmail.com>, 
	"sharpenedblade@proton.me" <sharpenedblade@proton.me>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 09:35, Aditya Garg <gargaditya08@live.com> wrote:
>
> Hi Ard, Lukas
>
> Although the patch has been upstreamed, and works well for the Macs included,
> we have noticed another issue. For the Macs having a single GPU, in case a person
> uses an eGPU, they still need this apple-set-os quirk for hybrid graphics. This was
> not reported that time by anyone since people who use an eGPU are quite rare.
>
> I'm not sure how to handle this. Had a few ideas like:
>
> 1. Enable this for all T2 Macs.
> 2. Enable this for all Macs.
> 3. Add a kernel parameter.
>
> Would like your ideas and a possible fix for the same.
>

Hi,

Is this a theoretical concern? Or are you aware of any user that is
actually affected by this?

In any case, given the niche nature, enabling this more widely by
default does not seem like a great approach, as the risk for
regressions outweighs the benefit.

I could imagine the use of a EFI variable to opt into this, would that
work? It would have to be set only once from user space (using
efivarfs)

