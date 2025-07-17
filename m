Return-Path: <linux-efi+bounces-4399-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00429B093D5
	for <lists+linux-efi@lfdr.de>; Thu, 17 Jul 2025 20:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1347B0143
	for <lists+linux-efi@lfdr.de>; Thu, 17 Jul 2025 18:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5A2FE38F;
	Thu, 17 Jul 2025 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N21Wm9PT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6890298CCD
	for <linux-efi@vger.kernel.org>; Thu, 17 Jul 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752776539; cv=none; b=cP/S5f71d59j3dl6bZUsj3jNRc+gALURuC8xXSWF4molfbugSqYMXG6VDe+vnrKOZ6XqNdLAqaaOlBUeFsoY/Ka6BsdoRD4y9h5V1weDn7hLW09uyRuGJRrB57612hwLyXK+Dk/AqPsctw1bl+KHbSEatwZINXO3CnkMMUVvUPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752776539; c=relaxed/simple;
	bh=G3jL+wG+8NOo0C9q/J7PTimEdtDkh4rD9YQDFto56U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nzchj/Y3wftj/ILCTc7lupa6CVl6vxbo8mn9wpyZh+7a/j+Yx9X4RJ0odgBmwPIKm9enuqS0X4HfQBW5/7b+vaxgN5gws49THutsMrtCSMfF35bjoRq/rUrgeOYLDW/dleWHIUxi8wP0QKRfwEWuBZoqWNsrsHVXZKO9Nk0KYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N21Wm9PT; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e740a09eb00so1165721276.0
        for <linux-efi@vger.kernel.org>; Thu, 17 Jul 2025 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752776536; x=1753381336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dj/cZu4K955u3WxbJO5Yyn51Gj07gNitENbpCqXBrlg=;
        b=N21Wm9PT616dOulvzkGsVasCVbVeqicWkekZa2o7Jwi6tNsB9ScbQOk2uCWrJ4BSgQ
         byQZpN5CcZQqZCfF6dv1uY3Y10LswZOOjDIh7iNF585cz8MaPb+VK4T1ZxOpP5MeBpdF
         gE8tnyZnY+O1DwXMOndAnND4Sam1fGlvwXn9rMcnKlOuJocT7ZCh9vFGp7nirLEIMhLx
         iHSpY8YCtdmbAOVhEznjsbwFgHt3ukCVD1+uCud1upaeTJhzmYtfasW7Foewh5npChNE
         mUiIpQEOfvtHtLkXVJ/bLu0e4cgf382HGv00YzcVAm7HMwyOG8NZRa3Oi/lH1JQby+0S
         y7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752776536; x=1753381336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dj/cZu4K955u3WxbJO5Yyn51Gj07gNitENbpCqXBrlg=;
        b=XDLR/+zLquySyS6KTkFYBn1fmRmOG8t3LpFm4NkzruYFAloKLm3Bx0Hg6dZ6VwzzNo
         qlUQNNnhSlmcUqltDWLS2ZDkDv1IMqSm3zPMfPlyYZY/gmnyhC3m4ik76tHXnFKPv1Z5
         1FTYAOGG3szCzCePW1heyuL3NVjwXJ0Cuj+cQjpLsCiWsZr5D8mYQqYlkYRBqGHIMuvR
         eRSyP0300Y1yCSdcUtKFXG08qoozw1wOc6Pg4ne7pkILHbCPRBc3LZJUx5wHD0md4xpB
         cmf57AhJpYjwSzTt/ufhqHSCwyWoUaSUPc2PnIhVTNUM5ac5aQamfygcu8JqsOu9lI6E
         nKIw==
X-Forwarded-Encrypted: i=1; AJvYcCXmfVVaNkSaw47WKY8g60PZ4fYVfnj7E7nInRTBIibEb3l7JJi3hh7J2qaitKHgGxK8v5eQ6gtvMhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm4AT1ng7VWWH9875tTg0TdPYBp3lKFo+NPT7HsABJ3CUNsH5n
	GegkpHFjXqTir6/CBrrACc8sFFFnvSIzOYnPI7NPCnZnqm5KvjseZ5nQlKyD09nLZkIsG/b2YA9
	yWAnBkN3BH1iUc9gIQwqw3/vuw4bMBLiFecGZxhGd
X-Gm-Gg: ASbGncuGVwMoNH6sVJfo4Cu8B79k5bMQecONvAK968AOXM205E2NHQKCbtOm49x5aRC
	Z7BXOa8GGzUdiIzbxgjOuVUO+jlsZ9utUyBRyWWf3wJqYpLySTf4bCjZZRamNGy23qXMsnGimON
	8JQ2Ad0xKa3dDh35cWrCKES3QyAeYOiNAYe0MPsYBEbr5Ss6uQd+7GNnChSUP5rL2IPw99o4mJ8
	DvHfxXE54wy1GrPSA==
X-Google-Smtp-Source: AGHT+IFl6UDPpr/oWWaFnlHMWZyVT1LMOLcL/IIjAuyhHi/01vC0aMu35s2078tcgwodJEbgmu0BPGrHYuDoxJtxfp0=
X-Received: by 2002:a05:6902:248d:b0:e82:1f55:effd with SMTP id
 3f1490d57ef6-e8bc269ebadmr9165657276.5.1752776535732; Thu, 17 Jul 2025
 11:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
 <20250716212925.GA14322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20250716212925.GA14322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 Jul 2025 14:22:04 -0400
X-Gm-Features: Ac12FXxe4T_hN6jEbI53FNZzZFqap9jNRjhELwIEMsW3hFfT4g6e4hyRn79zWz0
Message-ID: <CAHC9VhS3qY=+DVYqzkgbHLETUo4KgQ17qr_BC3pn9TeG+cr8Mg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Secure Boot lock down
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Yue Haibing <yuehaibing@huawei.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	Kees Cook <kees@kernel.org>, linux-efi@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 5:29=E2=80=AFPM Hamza Mahfooz
<hamzamahfooz@linux.microsoft.com> wrote:
>
> Ping?

Adding the new Lockdown maintainers to the To/CC line for review in
case they missed it earlier.  For reference, the patchset can be found
at the lore link below:

https://lore.kernel.org/linux-security-module/1750975839-32463-1-git-send-e=
mail-hamzamahfooz@linux.microsoft.com/

> On Thu, Jun 26, 2025 at 03:10:37PM -0700, Hamza Mahfooz wrote:
> > All major distros have had carried a version of this patch-set
> > out of tree for sometime now, but with a bunch of magic (typically
> > sprinkled in setup_arch()). Though we can avoid those architecture
> > specific quirks if we call efi_get_secureboot_mode() from
> > efisubsys_init() and that allows us to have a generic solution.
> >
> > Hamza Mahfooz (2):
> >   security: introduce security_lock_kernel_down()
> >   efi: introduce EFI_KERNEL_LOCK_DOWN_IN_SECURE_BOOT
> >
> >  drivers/firmware/efi/Kconfig  | 10 ++++++++++
> >  drivers/firmware/efi/efi.c    |  9 +++++++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  8 ++++++++
> >  security/lockdown/lockdown.c  |  1 +
> >  security/security.c           | 15 +++++++++++++++
> >  6 files changed, 44 insertions(+)

--=20
paul-moore.com

