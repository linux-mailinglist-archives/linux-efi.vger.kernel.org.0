Return-Path: <linux-efi+bounces-5204-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5841DC17710
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 00:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07AA1A65751
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 23:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D233290A;
	Tue, 28 Oct 2025 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b5mm2fmB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88143314C3
	for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695937; cv=none; b=W1+7buGdfzDrjF0iMoTcDls5YVcWbYO2KLB32lJbr7IkreqZQEX52dih08lkCgns59LpNgaODapO4ux1Plzo1jy9YIkC4gBQFUiVAj7KlWovgeZCpM05JAt3lxk9L7EzineqonZaprT1WZNOpjwtNR9JLl4UMSnSkgEq+QEpijE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695937; c=relaxed/simple;
	bh=kk8zkzm83REChxkZSsstjBUXBS7wFfE2QPwc7AaZrqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjB35b0asHckj9NZgCAG7LkRcGTjZDxiSY3GisIPZO6aHb7ELS/+lsM8H2D/qbMY4T+4rQoA9rUvbwLMClslN4zgA0xx0wMmtsFyEI7smaOI+jHJqokdUPRckXSx02DK2FAG9SG0E2XzEMI2qv3ibOz64jGAiRP23hXbGllXBr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b5mm2fmB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso9605490a12.0
        for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 16:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761695933; x=1762300733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WE4n4TCb18hPsMXmSS/+ET4xqQfmAur/mQUYq6ibGY=;
        b=b5mm2fmB9zTSMmFv4iKcb4cYmBOnPB/Zy4oRNHUHZ2iikAuKggazvFoh6D8vH5ZaA9
         DhmA+LKcnFO/ZrtWv+2TA34YvpTl7erhnFKoSbM2HAtVpRNrZuJyEJhtkWIlZY9GLHks
         +/MXfaI5oLqKh5dze2y6Rt0r5nN8ipVqo9HD3i/WJISxOx+NS6+V0zoCuTSi9yCJkwlh
         lqEpqob3fsMnFyMfsJoSfvvOBZDCMfGFjBNH6d4vTByQp0KRH60bi9LyW2aLznonIwV+
         XUn44AEioKOrWDBMX7EER2Pxhi4Hytd2/q/OVHWxKd1TUG2EPGrQA6fIBm6xvgqMNQor
         I30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761695933; x=1762300733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WE4n4TCb18hPsMXmSS/+ET4xqQfmAur/mQUYq6ibGY=;
        b=ZrciiMXE71ToK0zzrS0+wYa138iFwltP0udbC3OrnDOt5ZSU/IEzO3ssmbTpDk0htp
         oe4Cfu9568YyaVGi/WnL42L/e6iqs//jSDTmvQXOOpK5F26njJ0beKGaQIlH4kutoZlo
         jxLOQjvlx0aEXjsvIBKubX7FBUKK1lmKvRxjDNn2OPQ1ikmwF+uGsAOxwFqbTx+/lCxp
         BwfOrIB7NQQ9BFIeO91KhdrDECaOIT55+TlMd0Q1yY+NOC+focXAeif1g3q/KHFkgFUt
         vNmfAerFB1qUfH8FEihikOQcYsY6w/iMdHzytDTd2PASiYczDXrSl9bwNd9Y8FPe58lQ
         5xKw==
X-Forwarded-Encrypted: i=1; AJvYcCXWmqxJYqkpFza59dWwvFPGBJW8DReZVcdbcvXAcIGnm4zCf2wVONYCCbyYubsag4wOOmXoNVR7uS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU4VUPxVrC9fm4WG8bKFzpsrrDFbIYA/stLPg0ZF8uxyZ/wsi/
	VyVOJpIfx2i1qIeudonhz2lKpSRLYELnFWuKjLO6pLdnQLgT6OM6nmvYCpaCjNaVV1V0fszi4Xj
	iaTHOFF0fe8cRSnZNt3T/TR7OeE5ORWh0khHp2i7i
X-Gm-Gg: ASbGnctZ+fKwBlQddLUd+vgRQzwU10oD+Vopri2x/mSBaJNtKUU2EpgTWsshpLsEtuP
	09WXrrMD3PYGB75t2IxelHY+ECVobqf4HfIqXs+mgXIRIXe1voy/JFZup8Z4G3wWeKFvZGopg+9
	NlwFhyxqy1ZiqwS0AW5F2D2c5pR8xpo4otKrgLlNL/ScR4iFOUJ8/zmOGygcTzoji32C3yG7I8j
	Qre7ZS0lwQT036gdS7nnUNIQECsFoosbDKOi7B7KqUfFhy8hhrFN1JaE91M
X-Google-Smtp-Source: AGHT+IHvIzFCAVsIe9KLnMzhe7HeHw161tWjaGF8dq9LK8mHTJ5LNBNsg03z1RN2kv4hUoIzYntUB79AzDiL37F2WAo=
X-Received: by 2002:a05:6402:50d0:b0:638:74dc:cf78 with SMTP id
 4fb4d7f45d1cf-64044380bd9mr816143a12.34.1761695932545; Tue, 28 Oct 2025
 16:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-11-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-11-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 19:58:33 -0400
X-Gm-Features: AWmQ_bnbOFuYYw7q6A3vKx1W9tiGVviHbdGsSFCW7Z6eJ8jFBd6mwoz2mbQdJG4
Message-ID: <CAHC9VhR4nO+TanWwz4R-RQijy9h5B2h6HuBDXxBNp0+kAE4Asw@mail.gmail.com>
Subject: Re: [PATCH v2 10/50] configfs, securityfs: kill_litter_super() not needed
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> These are guaranteed to be empty by the time they are shut down;
> both are single-instance and there is an internal mount maintained
> for as long as there is any contents.
>
> Both have that internal mount pinned by every object in root.
>
> In other words, kill_litter_super() boils down to kill_anon_super()
> for those.
>
> Reviewed-by: Joel Becker <jlbec@evilplan.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/configfs/mount.c | 2 +-
>  security/inode.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Paul Moore <paul@paul-moore> (LSM)

--=20
paul-moore.com

