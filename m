Return-Path: <linux-efi+bounces-1198-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA626903E66
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2024 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728851F246C0
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2024 14:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5417DE03;
	Tue, 11 Jun 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGms9eMr"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D317D36F;
	Tue, 11 Jun 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114911; cv=none; b=Tj2X6Q+Le40NOTMi4yNNRPfm7VhDR5lVzluMVqGZSb5obe6z5NAdkkhLMOmOxDh7a8LG2Tj3gbyNd6MTUo13Zy9TRzL0aYmvSLeOd6VhZqQ1D0RtuF6rkLZ8ckxEWS1QDkseaHlf6LbSp3285tNVVQ43XM2hoeQiGhNY4vRgUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114911; c=relaxed/simple;
	bh=Ug+0BWagYk5Mzmb742j9kYJmSIhwwYfyx9El/SNy6GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8wqo0TqY99dtlsyZiTykE5PeNbOz2DpUe8HBGEXqZngPaniIdKWMyAQdL09lLJcR0ag+raA8QJsDCPb1YJXM5tBW608mfDoBqRufRd1CYLzuQbMUcmABsucyDd3P5LX3WNsZo+ZSC3Q5lphJbRuDpApbQEv+Ly7QToTGBIJg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGms9eMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0B7C3277B;
	Tue, 11 Jun 2024 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718114911;
	bh=Ug+0BWagYk5Mzmb742j9kYJmSIhwwYfyx9El/SNy6GI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TGms9eMrrx2Vs2PnIECv7NyiTYLtiGAzLNmy9UJjOxR7g86dsDOd6d1FBMguRFXSL
	 qbCrGCJbAiqE6I/fwNFOz4BrVGRc8BNsEmaJghXVUyBU1YFXwxO+ioh7SIZlX5HJ4P
	 +VzaSNTYQVuC76bxZtcASmmDzX6eCIuJ3NFUsOXLcU/6XjsV0CbRyKt8VjgsQn07/p
	 DgtrX+mx/LImPfAS3f8iKx+lW4w1cZ5z+1j0gAbj2FR1YkBeXLgccBvq8FKv+sGyG1
	 4KYCqBDt3vYWKA2PdswK2EF0QJuVWbHGJNJBhsE1uQPvPrbHJXwKK1kSa2mF3priua
	 fbItjT/9XAKJQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52bc1261e8fso4490055e87.0;
        Tue, 11 Jun 2024 07:08:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVbGpPLzNOK+1LU6Y6CdmEMNsGR0kdkEZ9Sms7RqKs3uvUPP+x04Kxs02lXZ+7X6lWjT5WouZdXGVasyUcZ76YjerO/aAuIfbEB0kl4QLCDpIqr0SIi15q3StiWctQrf6WKdlrtdtwlnCp
X-Gm-Message-State: AOJu0Yz504CnXYU5L9lnky/gL/A9MzsdP4dFaoVSzrjihNFOQ+TwwPL3
	UPWaWaz3pnd0nLbzyGEime0/pEMvzLlSfjrzbufdW0tTndGP+oqavG3uykGRpMfEtflzZrJLV9B
	GGQrQKyjdEF9MVYUMikNMkVciXL0=
X-Google-Smtp-Source: AGHT+IEHCcZ0L18ptzFjtje3/hjujwWCWzoNsTme4hlV1Cd6CftpYWPcV4nFBE6jv4u4sLJfJecM5s3cZpADJ0Mtmq8=
X-Received: by 2002:a05:6512:b1c:b0:52c:8206:b986 with SMTP id
 2adb3069b0e04-52c8206bdc8mr6905563e87.56.1718114909332; Tue, 11 Jun 2024
 07:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610122437.2358778-2-ardb+git@google.com> <CACRpkdbmQ6Foq_Rey5_etoNDoLmEh7v+q=sEzrcYt1tcrDaAoQ@mail.gmail.com>
In-Reply-To: <CACRpkdbmQ6Foq_Rey5_etoNDoLmEh7v+q=sEzrcYt1tcrDaAoQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 11 Jun 2024 16:08:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHMK1iwT4enpcPYn59OhYV99JuEvqxMwr+7vx919mJTiA@mail.gmail.com>
Message-ID: <CAMj1kXHMK1iwT4enpcPYn59OhYV99JuEvqxMwr+7vx919mJTiA@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: Disable LPAE PAN when calling EFI runtime services
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux@armlinux.org.uk, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jun 2024 at 15:17, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Mon, Jun 10, 2024 at 2:24=E2=80=AFPM Ard Biesheuvel <ardb+git@google.c=
om> wrote:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > EFI runtime services are remapped into the lower 1 GiB of virtual
> > address space at boot, so they are guaranteed to be able to co-exist
> > with the kernel virtual mappings without the need to allocate space for
> > them in the kernel's vmalloc region, which is rather small.
> >
> > This means those mappings are covered by TTBR0 when LPAE PAN is enabled=
,
> > and so 'user' access must be enabled while such calls are in progress.
> >
> > To avoid the need to refactor the code that is shared between ARM, arm6=
4
> > and other EFI architectures, fold this into efi_set_pgd(). Given that
> > EFI runtime services are serialized and not pre-emptible, storing the
> > flags into a global variable is reasonable here - efi_set_pgd() calls
> > will always occur in pairs on a single CPU.
> >
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Makes sense to me! Thanks for looking into this.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>

Thanks, I'll queue this up as a EFI fix.

Note that I have to fix an error in the patch: CONFIG_ARM_TTBR0_PAN
does not exist, it should be CONFIG_CPU_TTBR0_PAN (and don't ask me
why it worked because it definitely did - probably forgot to do git
commit --amend)

