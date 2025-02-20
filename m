Return-Path: <linux-efi+bounces-2807-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF683A3DA85
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2025 13:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C74319C1BE5
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2025 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A941F7916;
	Thu, 20 Feb 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnHPz/Rv"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281251F3FED;
	Thu, 20 Feb 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056074; cv=none; b=sW0Ozh7nMkuCXVhSIlckmRy7jflbOFEFFME7d7gNJWuyfelEj4WTxa7IZp1PimVF6VwjO6mGWGYtcRU76OguOHuO6MBfS72yn/Zp/j1H2M9RTNpKogvjUZ9fjggAvb/8lk6TkZwA22twywP6D6yt1f7XUBYfw4fLsAB5KJXNxZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056074; c=relaxed/simple;
	bh=gtg+Q/NNLXydxjooTCTdHuHrfQqGn/j2nsDU1YMjgOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYlAQIoKWZ0WZPU50GvXacNqtk0J3br+VX7RHDYPaFqN9YHoa7S8/cKU+aXV3OPyi4xByYVP953i9CBBH+MJRX2Bb+5I0ux0U7gQQqfgMPW3PxRZDWmnYiiXDU2mA5hnGbNCrGC/q10QqkHkSx6W2JPGI0tkE4R8lHU++O+grtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnHPz/Rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD22C4CED1;
	Thu, 20 Feb 2025 12:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740056073;
	bh=gtg+Q/NNLXydxjooTCTdHuHrfQqGn/j2nsDU1YMjgOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZnHPz/Rvdx42vIu9ch7pFcpCY1lW52+Rns90qH46ru2ui849ew9YY4zmnf9EDI1Ww
	 Prnb6zIw2bvq6HCWqrUlq7lUNwpfDxv1kQToPM0r66xoOqPZ2GFHvI/IbLagIwHDSG
	 rJuV/m0eexoDfjIbOgIRVkei3X62m96nbJ7pqlPVLFOeGgszO68h8E13rViZtQo+7X
	 ZRgCqPaOHcAiS1V5SBYvGsEoxg/RG/0dW7Vx87K0eVY1ZNMHrc7cZu3IGx9a2M7NCS
	 9AxYjiJKRbEpmNdiGJx78V2ZuRqMSukfzaVeluuC8r6lx7jKKfTW1nsNq3n1HGMDhi
	 koyEZFlpR0ZWw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5439a6179a7so1029533e87.1;
        Thu, 20 Feb 2025 04:54:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVba6Q2NQmcyFDBrqwgFXPrne6+OC/HkxAFz3UVdDlIa9EcAJb2aQtKajG+RNzwAJs8Idk4isUs5m/7CZhb@vger.kernel.org, AJvYcCVwKD+9jR+N8uMvU0mLwhRosu7QsDajnKB0a64JmIOx156Jg/ZakkBAO+pi9CXM0BO3YExw6DRPfuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx26Uu3N+xGdvNG/KpbvuiMdoTaid8byAMEAnWBlfahyTO326e
	dsQRUzgNS9L1hirKXL7P8PAj7/SQA8k6l8+/PiuWdxUT/qHQmKzH5NzcS0coJfruXKHIQsYjcvo
	9/kzlUkRjHybW95nky3l4/v7a6XI=
X-Google-Smtp-Source: AGHT+IFO+WPs1sJlb+fu1U7kSTL4NlxywB1EQREGG9craD08px4/tSGEdqnSbF7T5TNDGekwyGuuUzuHgRFRWyqFJsA=
X-Received: by 2002:ac2:4c0a:0:b0:545:2a9a:aa02 with SMTP id
 2adb3069b0e04-546e5000497mr978274e87.19.1740056071884; Thu, 20 Feb 2025
 04:54:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210174941.3251435-9-ardb+git@google.com> <CAMj1kXHOqMM5uGxLTYuEf9KrxY5WzYvwo847JzoB-Qa2SN67Sg@mail.gmail.com>
 <20250220124831.GFZ7cknypjWiZoZzK5@fat_crate.local>
In-Reply-To: <20250220124831.GFZ7cknypjWiZoZzK5@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 20 Feb 2025 13:54:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEkkShwDfbwJ5abc9Q+LaqbvTNh1O5rVXy3EW85DdYTuQ@mail.gmail.com>
X-Gm-Features: AWEUYZluNgy6069In6F_ZrD7XyXSo6Dr6LBPV7bsob5yDG-8ruGB4ZVQBrzVLzU
Message-ID: <CAMj1kXEkkShwDfbwJ5abc9Q+LaqbvTNh1O5rVXy3EW85DdYTuQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] x86/efi/mixed: Decouple from legacy decompressor
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, hdegoede@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 13:48, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Feb 20, 2025 at 12:29:30PM +0100, Ard Biesheuvel wrote:
> > Unless anyone minds, I'd like to queue this up in the EFI tree.
> >
> > Boris, Ingo?
>
> FWIW, it looks like a nice cleanup to me and it boots in my 64-bit OVMF guest
> but that doesn't mean a whole lot.
>

Thanks. For the record, I tested this both on 32-bit OVMF and on a
mixed mode tablet (with 32-bit AMI firmware) that I keep for testing
purposes. Notably, 32-bit OVMF boots with paging (and PAE) enabled
whereas the AMI firmware doesn't.

Not sure how many users of mixed mode remain and how invested they are
in upgrading to newer kernels, but decoupling it from the legacy
decompressor does help the cleanup work I am doing in that area.

