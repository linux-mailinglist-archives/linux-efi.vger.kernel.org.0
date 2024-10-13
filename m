Return-Path: <linux-efi+bounces-1959-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DD899BA8A
	for <lists+linux-efi@lfdr.de>; Sun, 13 Oct 2024 19:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B391E1C20A8E
	for <lists+linux-efi@lfdr.de>; Sun, 13 Oct 2024 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB7D13E043;
	Sun, 13 Oct 2024 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbyV66Ko"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1C013D508;
	Sun, 13 Oct 2024 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728840658; cv=none; b=SeutuNK9mpXMaYb7bHg/4ih8oU6Ge79gn7HxCeZbsDHf/ggyL+qs5+zlEO2bik52+IRMmDhrWlYHrrJLjaiDZjlGgRE3+q83BADO19H37Mj5yhn3MWerd8wFVYsgheSVgwz0mSo7+9QtsclPk1z4VFYLqMHt6ZGngzcROna8y/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728840658; c=relaxed/simple;
	bh=SnPScOCb71pfmlidyIdszTJzOuwQmlyc0aA02tY0cfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mml0AKGEBfQJYCSIvzUiwl3taHPILtVGe+By6+v5IxzTFlphFVh666MonnVNn+IRMfDYmYfapZMHjKKvp3QBoLRSesg6x1QBm+cmbWz1s+HyuozUhy8yOcBgsOih7QJP8VX8TpD1/LmlZPxqiC2OkTcnm37OMVnsoNNY6wVLF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbyV66Ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AE9C4AF09;
	Sun, 13 Oct 2024 17:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728840658;
	bh=SnPScOCb71pfmlidyIdszTJzOuwQmlyc0aA02tY0cfA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SbyV66KoQwbmyQyS8Guhyjjn1lLPw6Mf9FjT1dCeOLEdrLAdkeornO19BmWachNy1
	 SiruhUbtCM4xoPN6NfIQNo7dTcfcZl8wRU8QQ/bo5ADt03njzv4S5afh1+wVG6YdIz
	 M8XjrFPPxd4m/8w05PLuID36ArebvQRFpH4nlUf69E3VP+/naJOoyyaKTAOkhFpyle
	 3k20dPnq7A/gH2MsRaJ7kpT0KlSvqTUVuF8xsMnIZCbEHlCt+qe2GuivjW241t7Tz7
	 dnYBHkxL5M1PGKSLwLs5rHevTTBb1Lxax6ONfR6TnpVhO688qbBff9JKIzWRrSbTYn
	 Qzf+6MOgAzRXQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f8490856so58072e87.2;
        Sun, 13 Oct 2024 10:30:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9BaqVKlGsgWy6tkQts78NZxQ47m/3nOVw/W70ObEYq9KYfZh0oz8CoqZcTa5saEt+77ue7ydNTMKU0BI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/yhrvgIACuqkC1mubEzfs8baNdQaqbwKJskxjZor06kecJpK
	we+ch1B0gV35Tz/pOk1yz+rZ3wkzJy+/+MfxOrT+24ZMv7oVNlbBaIk4osAQbO99pn1X8b7LGGD
	6P8WbSKD6qUxRMcLxT68WQRuBDmI=
X-Google-Smtp-Source: AGHT+IECelgcESbRmPsRqehda3GFvVUbEDY5jU9ogdAPc7VgE0w4gWikxv6zLqCYCPjJ/ZSU1vf7dUhb5fNz7xOHLCo=
X-Received: by 2002:a05:6512:2213:b0:539:e6fc:4170 with SMTP id
 2adb3069b0e04-539e6fc43aamr1805927e87.32.1728840656497; Sun, 13 Oct 2024
 10:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013051239.22564-1-jonathan@marek.ca>
In-Reply-To: <20241013051239.22564-1-jonathan@marek.ca>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 13 Oct 2024 19:30:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHvOgGysdPSNNk1bUR2f5tzRaxr4=saqF8KFXq+q6gDCA@mail.gmail.com>
Message-ID: <CAMj1kXHvOgGysdPSNNk1bUR2f5tzRaxr4=saqF8KFXq+q6gDCA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] efi/libstub: fix efi_parse_options() ignoring the
 default command line
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-efi@vger.kernel.org, Aditya Garg <gargaditya08@live.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	open list <linux-kernel@vger.kernel.org>, Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 13 Oct 2024 at 07:16, Jonathan Marek <jonathan@marek.ca> wrote:
>
> v2:
>  - changed to check for NUL character instead of size==1
>  - reworked cleanup patch to remove cmd_line_len
>  - moved 3rd commit out of this series
>
> Jonathan Marek (2):
>   efi/libstub: fix efi_parse_options() ignoring the default command line
>   efi/libstub: remove unnecessary cmd_line_len from
>     efi_convert_cmdline()
>

Thanks. I'm inclined to fold these together and just merge them as a
single patch. Any objections?

