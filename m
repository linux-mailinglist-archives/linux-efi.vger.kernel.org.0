Return-Path: <linux-efi+bounces-2948-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B41C6A59DD9
	for <lists+linux-efi@lfdr.de>; Mon, 10 Mar 2025 18:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788D516FF1C
	for <lists+linux-efi@lfdr.de>; Mon, 10 Mar 2025 17:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E22B233D88;
	Mon, 10 Mar 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt3cuynU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC4E22AE7C;
	Mon, 10 Mar 2025 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627453; cv=none; b=ZGJGtw6SpM1ZKa532v2MLl4JrwzTTp5wbz0t/Y4SP4C/Fx1KCSvKJBFImQsoS7DRUF4+mwHQsXg8Oe7dRmBZPhQnlc4WMKGuE9s8gge17GMpilzTIobvXVWPGS/TI8D59VrSG8BUOJp3hslW1abxpPMPVFzyO42LMdwdOT79KOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627453; c=relaxed/simple;
	bh=KxCVrFtEEQ489IO+8LWASMRjBenAxwUf883ccdADMVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXoSGCHg4ybUNCilarScnhno2Fz0X44zcoxSq0CyIIQEMzFuMKjEpotdBQPACqbDs/h4b1SaQ3hDavbxWLyhzjQfmtUzjAOy+H9cdktw46W1P6dnbxrtTs4PwNk95RSj9lR2Hj/0v0MEkyaQOp6FYmIIfhIR9OTuy2PD2eLe19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt3cuynU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AC4C4CEEC;
	Mon, 10 Mar 2025 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741627452;
	bh=KxCVrFtEEQ489IO+8LWASMRjBenAxwUf883ccdADMVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pt3cuynUjtE+SMseBKPGdQYThBoNnPCnoJwgIL0KGM5Ixz0N3mCXFufKTs9kkSFsH
	 kotbgn9hmuA9XQu5LX0coGkGs+/v6b9jm2PfsNvHj0MHc+SBjsEl+guByNBzS3nCZR
	 615PZLM5isfmdCN7xk1S0aDZn8Hh2X/GsXDcBRObtjn0PDtBEvDixCqpT2l13hy7CG
	 As8CP9unJ2bnI6QAvpjQmFONddNeFeM+giBRkh+4hs792q+I1mcBa+bn2s5H3MmhFC
	 cs1REYTNtcwepOAoE/wX/VReN8YT8DVyIjMtCjnfxYbqj7idUILczrUfSq1Z3fljgD
	 B4QSzSWe+RCDA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bf251025aso34247471fa.1;
        Mon, 10 Mar 2025 10:24:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpFiIjixI31TEawQARX4CafUigwrU7f1ZbpIJxChytzzT4vm9mMfuKpQEHk1mnBYhTkYf8OhhQ2kSMNEdx@vger.kernel.org, AJvYcCWtYxHG0UHC7Kn/IrdZ0EWXuokzEF28+PYmUi8ncYeQimiA3X3cQjpbVmXwe9dL0e+sraFTFvCunafL63fPIZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydE3k38yVFxtMOkDLSW4GNEa9ITQYR2xn9k1TqfRU9HpzgY1ZD
	Ump9ybTsM55lKblTsG/beglPbbOQYnanlrINcg7QF0Pp8q3dVPu5KjeJKCYKSWLzdgkPuI5R+m6
	PsQq+QLAJWF6/Q/PyALTkIx2hhiI=
X-Google-Smtp-Source: AGHT+IGDP35HxL6L4rAJ9cayRi1yFXnNJWJ+1hc45NrBGj/WElMB/wxvCYz04jCP6aYQds3stLvQSAMSUrqB0yhFHXw=
X-Received: by 2002:a2e:9d05:0:b0:309:23ea:5919 with SMTP id
 38308e7fff4ca-30bf462423dmr40930191fa.31.1741627451205; Mon, 10 Mar 2025
 10:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308-efibc-kmalloc_array-v1-1-7bfc4013986f@ethancedwards.com>
In-Reply-To: <20250308-efibc-kmalloc_array-v1-1-7bfc4013986f@ethancedwards.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 10 Mar 2025 18:23:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHuMt5QfkKbErmou3TB=5aOENPW=0+Vexom_Y_iFd98qA@mail.gmail.com>
X-Gm-Features: AQ5f1Jp7a1_yGUrVfOp-0rUojPlpvr9tH7JA_CWRKmb9aQX44_SaGdio6iKyS_Q
Message-ID: <CAMj1kXHuMt5QfkKbErmou3TB=5aOENPW=0+Vexom_Y_iFd98qA@mail.gmail.com>
Subject: Re: [PATCH] efi: efibc: change kmalloc(size * count, ...) to kmalloc_array()
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Mar 2025 at 02:27, Ethan Carter Edwards
<ethan@ethancedwards.com> wrote:
>
> Open coded arithmetic in allocator arguments is discouraged. Helper
> functions like kcalloc or, in this case, kmalloc_array are preferred.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
>
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  drivers/firmware/efi/efibc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
> index 4f9fb086eab7b0e22252d22e59e5aae55865322d..0a7c764dcc614fbba3cbcd94183dc07939837a03 100644
> --- a/drivers/firmware/efi/efibc.c
> +++ b/drivers/firmware/efi/efibc.c
> @@ -47,7 +47,7 @@ static int efibc_reboot_notifier_call(struct notifier_block *notifier,
>         if (ret || !data)
>                 return NOTIFY_DONE;
>
> -       wdata = kmalloc(MAX_DATA_LEN * sizeof(efi_char16_t), GFP_KERNEL);
> +       wdata = kmalloc_array(MAX_DATA_LEN, sizeof(efi_char16_t), GFP_KERNEL);
>         if (!wdata)
>                 return NOTIFY_DONE;
>
>
> ---
> base-commit: 0a2f889128969dab41861b6e40111aa03dc57014
> change-id: 20250308-efibc-kmalloc_array-ba78097a0708
>

Queued up in efi/next, thanks.

