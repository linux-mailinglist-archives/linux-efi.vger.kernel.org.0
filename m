Return-Path: <linux-efi+bounces-3699-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FA4AB72EC
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 19:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F41D7A7896
	for <lists+linux-efi@lfdr.de>; Wed, 14 May 2025 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B089280A5A;
	Wed, 14 May 2025 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="desxf9ue"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521628033D;
	Wed, 14 May 2025 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244247; cv=none; b=ji6V3xTjAXgjv/D+wgyphXvXRyPDwCH24UQsVGDxNr5Izc01073FSvCLySORRVof7iHDK9PO/UBxRrdFygTzcYKdWFsSgn6tGkkuNcAKHg4ZLtonr+z9oxXJINdTWOdr5Bw4V0LLNcsmliovBDbn7ZgiOQPGCeud/hWxvu2yGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244247; c=relaxed/simple;
	bh=2vsnY1VIonumgi7rO1JZgVFYJRfcy5sO6agtjfM5oFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmV6AeFmYlODk0bN3Y+JdqKFOWJ9dfuzXK+89t8RM/AkWfr+9JgmBAdx6XxWH1DCdBieYmSPPOwqFigZx4N6rMNmllRpL8Q/lKL2osm8Oqc/aF2A1AKopxvjA0Gr4v9zFa2LASvsh/DtOeV3d+1wfj/Fp6cLlKig0Az2id9za2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=desxf9ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93C2C4CEE3;
	Wed, 14 May 2025 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747244247;
	bh=2vsnY1VIonumgi7rO1JZgVFYJRfcy5sO6agtjfM5oFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=desxf9uekgSlhyUjWpzXll2MPFWGdd+3cAWgoxOWpdgvutYqADQ+Kystb7ATgh2+v
	 HAN6Z2d/skka94+Io7gVrsILep4qiGUZG51EsMbhmDWDW7+PaZoArWGIwaKr6V9zTG
	 OlTD6eoJvPqeicrb3UqQI9IQrLa4reDo2bYTotHv92iS/LfjqfESfw9XNUNldL2r3O
	 zMArd3PODe6/El+00UJ41pfCN5/64iw2E0BDUFf407KhdpPZvOv8FCuYrK1rcVepz9
	 2t58ASoLLJ1TTAGmmowkLZ5XzAOYmTCa4eUJVdZ6m6aMiWFoTh5jQu7rXsdUlkO/Zj
	 Qn85oAZZ+cDyA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54d98aa5981so11036835e87.0;
        Wed, 14 May 2025 10:37:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4nP5YM3pzO6RPBHRgh6iuVfatOQYgFWqMtohiqbHdrOux1TCebAfxUR0Pwj3zoHsrXuCfJA34uUd/zZil@vger.kernel.org, AJvYcCXaTXrt0ALyo6ucSiLjkwoqhOe+heL2mdlazRM97tHOTfGWb2flKJK+7JHEtzZ0j7SqzZNIu+rlIs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4SXfNkY+t/y5I4sBE+l2y2SdgFWI1k6jJyy703bsAUBGX10Az
	9Z5Yu5Lgq+pH6P+Om79J/UZ9q9jtzyOWHFxvY7gffFBtzHLsM4+lWtfr9cI4tUofWKVeMv1fL7z
	+dLc1mFP5PSD4XnatpT5H6+/BaEA=
X-Google-Smtp-Source: AGHT+IHKoe00cgjRW9m1AuAz62C/8GjQSojbSBolbP7oj/UrgqO18zSvoXSsNIcxh3XZJZFle6naODcfwx9oeJq5LCo=
X-Received: by 2002:a05:651c:542:b0:30b:d35c:4754 with SMTP id
 38308e7fff4ca-327ed0de340mr19837261fa.10.1747244246027; Wed, 14 May 2025
 10:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com> <20250514172130.GAaCTRGoRL3nYieIE7@fat_crate.local>
In-Reply-To: <20250514172130.GAaCTRGoRL3nYieIE7@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 14 May 2025 18:37:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHnt25JoTLdsPWB2C0xqzs+21PBGC_NXNhmsHdL0yLFnQ@mail.gmail.com>
X-Gm-Features: AX0GCFv36qQ9k2nC5FIIbTFKOBoCn1YPzkXLzNY615sC8xlLW4svjwTBcGkTv7s
Message-ID: <CAMj1kXHnt25JoTLdsPWB2C0xqzs+21PBGC_NXNhmsHdL0yLFnQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 00/21] x86: strict separation of startup code
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 May 2025 at 18:21, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, May 12, 2025 at 09:08:35PM +0200, Ard Biesheuvel wrote:
> > This is somewhat intrusive, as there are many data objects that are
> > referenced both by startup code and by ordinary code, and an alias needs
> > to be emitted for each of those. If startup code references anything
> > that has not been made available to it explicitly, a build time link
> > error will occur.
>
> Makes me wonder: what will be our rule for what should be made available to
> startup code, what should be moved to startup code etc....
>

The rule is really that you can no longer randomly call other code
without being forced to consider carefully what else gets pulled in,
and whether or not that code is guaranteed to behave correctly when
being called via the 1:1 mapping.

> I guess as less as possible but past experience teaches us differently.
> I guess applying the usual skeptical approach should be sane enough...
>

Basically, the first order of business when calling the kernel via the
1:1 mapping is to create the kernel virtual mapping in the page
tables. It is just really unfortunate that SEV-SNP requires so much
prep work before we can even map the kernel.

I don't anticipate that this code will grow a lot after I'm done with it.

