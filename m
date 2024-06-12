Return-Path: <linux-efi+bounces-1209-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4516A90570A
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 17:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99519280F81
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jun 2024 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3EF180A74;
	Wed, 12 Jun 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSK3fV46"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8B61802CC
	for <linux-efi@vger.kernel.org>; Wed, 12 Jun 2024 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206572; cv=none; b=Z2RJQ+S8FrKvyXT5mymptMYiJYCeGXrCcHxj2zuMqGQFYxtsrSGBPBgu86w4xTPcYjioChD/9Pp3rKtJ3/1I3TUXMN55pZRV8JRU8Ho0ZHet9jica7k5si31dc+33eFAjYT1GvvZWWrk7U3KDCFGQVsejytBtgxDNviFZ9Pe8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206572; c=relaxed/simple;
	bh=Ywj4+xx4Wk/3SiXP/7pqMhasrkw1wmuWT27166IujGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iel+pGpUihibaSUc8idxks+bAuI1Zour0nC9ravyLN+mY+qm31FFgYTL4KjDaz2+6rkjzXifoMJKTL5vEu6ap8AwYWrpiBH4Nc6wZmxmjYpf+ngA6JiXKG6QkOZwcdHvAtmW4zYd96RRp0vKK7lAbsIDtZmxLS5Gt5OnMWGv1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSK3fV46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BD3C4AF1A
	for <linux-efi@vger.kernel.org>; Wed, 12 Jun 2024 15:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718206572;
	bh=Ywj4+xx4Wk/3SiXP/7pqMhasrkw1wmuWT27166IujGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BSK3fV46c4MOI+R/b0SwPs73oC1w5sRFhasBcxvjOQbwYrdGIIbCbfMmBtj8xx8Xs
	 mjJn8uViE2i1E5ZVUmxM0GX5bncLldueq94Hfo8NAtMcfIWW/n5XDDqj6DeYKurrFp
	 gsiz6CP4qe4TxCLfWgtDApNVaB7RRgs2z6KW5jLKOtz6Ki4If5xw95hismYwPibXQ/
	 PG2IyGcL54CyH5k4mOSoBqoPpa+zwzqT6WMFNXuwlDmuh27oIzgp6fEyz4CCq/TN78
	 QfBypxnpNMW8KV5l+jikfcOp5e+eGfXPLIZWJ/MRu3L5wp1ue+zlNR033Ni13fy9ca
	 yHHKI+Xh4zW0Q==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52c85a7f834so38406e87.0
        for <linux-efi@vger.kernel.org>; Wed, 12 Jun 2024 08:36:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YxuBCPR2q8i0iQ9m65pL6Lw7vgrQAeFwvx8p2QcfZT3L4m4MU3g
	d5F9th3aKm3MXlXcFZPPfInnbon8byqioFuhDQvaKBpcaYnh6tqO5TVrOO9fPuNSYLHJJSGRMXB
	pky8FfIuXk5cfQBFP3iMnuy0McaA=
X-Google-Smtp-Source: AGHT+IFf9eLM1pxPznQcckBE2pxZy6Svov6xnt9auw7GQUNX58YXbIGo+v0yYTgxHMldL7pqqhHQqdtg0zb1Nzf52ds=
X-Received: by 2002:ac2:592e:0:b0:51e:11d5:bca5 with SMTP id
 2adb3069b0e04-52c9a400f8cmr1248500e87.54.1718206571128; Wed, 12 Jun 2024
 08:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAzv750HTnposziTOPDjnUQM0K2JVrE3-1HCxiPkp+QtWi=jEw@mail.gmail.com>
 <CAMj1kXGvdRwboAZZGEvOh2_wFjzhc1OY2F5BBcYJF5ZhT8=Bzg@mail.gmail.com>
 <CAAzv752N7mZ58uzMkaxAFDbefCLSqtLkZBVXXuY00RA+UQ6ppw@mail.gmail.com>
 <CAMj1kXHuNCexwOZNoqncLdY2NQk8LTZvXztSYmv_kTr1jr2E7g@mail.gmail.com> <CAAzv753ZHR46sgncZr4p3dXzxQAZpVgLAzGBhJ2nOPNHo1jttA@mail.gmail.com>
In-Reply-To: <CAAzv753ZHR46sgncZr4p3dXzxQAZpVgLAzGBhJ2nOPNHo1jttA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 12 Jun 2024 17:35:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFL0F4H=vj9Rf1ZSeo5Smsu-5ZH7ZSEnhfaju9XW=68Pw@mail.gmail.com>
Message-ID: <CAMj1kXFL0F4H=vj9Rf1ZSeo5Smsu-5ZH7ZSEnhfaju9XW=68Pw@mail.gmail.com>
Subject: Re: EFI mixed mode boot failure
To: Nicholas Bishop <nicholasbishop@google.com>
Cc: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Jun 2024 at 17:25, Nicholas Bishop <nicholasbishop@google.com> wrote:
>
> > Interesting. Does your custom bootloader implement its own PE loader,
> > and if so, does it correctly clear those parts of the PE/COFF sections
> > that are not covered by data in the file?
>
> Good call, that was indeed missing. Confirmed that clearing that data
> also fixes the issue.

Excellent, thanks for confirming.

Btw could you elaborate on the failure mode with mixed mode on recent
edk2? The current tip of tree works happily for me.

