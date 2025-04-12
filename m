Return-Path: <linux-efi+bounces-3319-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750C6A86FAF
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 22:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684603BDAC8
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 20:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702B8203716;
	Sat, 12 Apr 2025 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBP5ObJR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1019CC39;
	Sat, 12 Apr 2025 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744491060; cv=none; b=PRc/78GBXQ8jZWzwV35t4DUSzlIXZrqphxzJMb8QRzNcbIJyJ+hjnM03ckbUUYuZ/r132P6P6JPU3zkCg+1dkBZZvrUU8u0rvdPV8rdDD0+XQja1/jEjWrkwv24XDU0MJiJiPPb9ezKX/YKBLkxGfsGMg6MoWiY8AdQfs+r272A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744491060; c=relaxed/simple;
	bh=0MT26XVZZQ4V4BA9jaSO3dCuTt5CB8MV/Du+VKgZpR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9szakATsTSXjsXa8/t3jwMLN8i/+p2oUlHyfBqbsobwjiwUY7kDnpaw9atQBHT510tbfXHo4U9tqS5nZuJa4S+mKZBxPvKEGe2ZtXXoh3zhQINgWtj2nDYi/8E4jj1GLBxRvuGkvDYgOFmyhV5pE0EhIjWD0Mg2YR+6Hb8Dt5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBP5ObJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2CEC4CEE9;
	Sat, 12 Apr 2025 20:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744491059;
	bh=0MT26XVZZQ4V4BA9jaSO3dCuTt5CB8MV/Du+VKgZpR0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lBP5ObJR39kc1p4+HWCfTRiz+hz9aC6QSm8+Zc775CvsiEwU1IutDY+wL8YKnAqR8
	 IZBl+6GQoiLizHRU9z/zdNMRG2IQB5fMj1I7fM+PeBEvWOoJN9NixY0jHl0eM48fAD
	 5gFQw8FDVSQ5tXVUVs45h/M0ruVITgaZmCEiBVGWUjsHXngmwonaXGGa2xF+FXibLh
	 LSLQQcHyIQ9OALFahW1raV28Ceag+LZqWZ+sAfVzdcG8c9CEQ/bFZbrcLLZ7/JFFBP
	 fVvntgBfIl+RWegtAaT1AdlIaYrEvoxhMbvFxF9TF1Z3JFP22P7+Yp7/F81yqvq+Di
	 geh3kVwodXx+w==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so29312691fa.1;
        Sat, 12 Apr 2025 13:50:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURB5yBWXitb633XV6JNWedHDHb5tVCcqSKTGMB2SM1HR6WnVbgT/TASyn5A87ijuDi6p3/11ww1bE=@vger.kernel.org, AJvYcCVBfH4nggCu+SQQJLO4wTwq0DA87Hn2U9c6Z4Rk18QNSJP5E5qHjx/RLrU+OlKYwVhLetVLVh94XArrIuAqPR4r6/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1KKqbPj0PPDzdfLCNcv6fjmQGyNxfaOUWBnmPVbpzGWn1vZst
	ptTj/X3QId95+ugTo/E5J1+lAUdLWCbR9r6mbM7SUk2NZujRRlpyV/V6cygBnVmVrvddONVgme9
	3M8i1tshTf+tRA3QbJq7E2YzcQ9w=
X-Google-Smtp-Source: AGHT+IFmOu5EggYdezT8rGeNdNJWVzW7cdkm6iqOJnDsQBdc+NPBO4rWd1rczoel/xAsi/eQD7Z1wZkkUJC6IbSP1lU=
X-Received: by 2002:a05:651c:1b06:b0:30d:62c1:3bdd with SMTP id
 38308e7fff4ca-31049a20b86mr24205451fa.23.1744491058072; Sat, 12 Apr 2025
 13:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410132850.3708703-2-ardb+git@google.com> <174448976513.31282.4012948519562214371.tip-bot2@tip-bot2>
 <CAMj1kXFEXZ8cGMwz6N_ToYp0Wf5Vr9UBFRueWx_MtrwbDLq+LQ@mail.gmail.com> <Z_rQ4eu4LYh6jGzY@gmail.com>
In-Reply-To: <Z_rQ4eu4LYh6jGzY@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 12 Apr 2025 22:50:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH+foh4gNwJopVvAspmO9AGQH5O3ZHctQ_cJ5gAvPWz6Q@mail.gmail.com>
X-Gm-Features: ATxdqUHFChk_vtwsDoiG793aEMtwTh-HX3XvlLHt7hBcyzvxQGZnsOFY2vadIbs
Message-ID: <CAMj1kXH+foh4gNwJopVvAspmO9AGQH5O3ZHctQ_cJ5gAvPWz6Q@mail.gmail.com>
Subject: Re: [tip: x86/boot] x86/boot/sev: Avoid shared GHCB page for early
 memory acceptance
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-efi@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Apr 2025 at 22:45, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > On Sat, 12 Apr 2025 at 22:29, tip-bot2 for Ard Biesheuvel
> > <tip-bot2@linutronix.de> wrote:
> > >
> > > The following commit has been merged into the x86/boot branch of tip:
> > >
> >
> > This may be slightly premature. I took some of Tom's code, hence the
> > co-developed-by, but the should really confirm that what I did is
> > correct before we queue this up.
>
> OK, I've zapped it again, especially as the rest of the series wasn't
> ready either, please include the latest version of this patch as part
> of the boot/setup/ series, which hard-relies upon it.
>

OK

