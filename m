Return-Path: <linux-efi+bounces-6016-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ACAD3A27D
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jan 2026 10:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32EA1300160D
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jan 2026 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A46633C1BD;
	Mon, 19 Jan 2026 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="eNxRkDge"
X-Original-To: linux-efi@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A7429BD95
	for <linux-efi@vger.kernel.org>; Mon, 19 Jan 2026 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813871; cv=none; b=OMV6+jBWoIoOkeSpBkT27q0M+If/rDqPzCjD6A4FNSWzRw5IXKpJi2CfZvJ5M9WMUkXxg3fUPSDSpPKLuPSt4YQF0ohgo9BuhqPvflQec0Vf35c8Z7th1JAtiKEFRGBBOTioI+7iHWRjuuVeV6dfjcdhPAo/X+jV/mko9Df25yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813871; c=relaxed/simple;
	bh=GuWSMN6a51hahYvajqJ1U/zYgnC7gufJ0id7r1O3UU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4g0J884qDcPvH6cOeTIZnDahSNJrzF+Yz2OzYLg4MqjiDAdy3tSqEV1e1KksRUD8sEz4FGhziSkW6UKswkw0z+JLUygWS4oNbs+ajx7YVCx+ocQBI+aRbH7pTqSwNySpS9lXddZe2n4FxpsNkHIPL/EA1q99q4+ujPfjDiFInI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=eNxRkDge; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (79.192.13.160.dy.iij4u.or.jp [160.13.192.79])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60J9AhtB060559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 19 Jan 2026 18:10:43 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=SsOrfO2Mk9DY3FLggBSvxcsKpfsTYts5i6AA41NKiqg=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1768813843; v=1;
        b=eNxRkDgeSs+SAQNzh3Tr0b6j2L4pQUc2Tr+4IyR9lf9LhfvEFKnbvyGp2mOz9Ph4
         /YWAJecIlnSBXIwTmJM9lm5KdMWwioI30f/SpwEwgajOajK0vohEQfDcyYqa1K5e
         mtoUwmkxMb4MS/pnUZ1/zRBOXjEVySOwHBhvLfSgTxTApyTUNnNIG6Zi1loVPA26
         F2djOAip3X0IzOQTvJtLNb/uCdN6feHAZ/kZ403rjkE0/7SJgmlhZZR6Jitcfn2Q
         y4UfH+N+ACUpbNAXklAie9vcvNDagxq84td4lNYD1BwUves72u55VD0Mf+Ykgxq3
         75bzXNtT6UzkknWRCzoSgw==
From: Kohei Enju <kohei@enjuk.jp>
To: ardb@kernel.org
Cc: jk@ozlabs.org, kohei.enju@gmail.com, kohei@enjuk.jp,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v1] efivarfs: fix error propagation in efivar_entry_get()
Date: Mon, 19 Jan 2026 09:10:36 +0000
Message-ID: <20260119091043.80155-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAMj1kXHNNgtBgoz9QgYiK1e3AagGy5Lb=7nrza8GPExgOD+heg@mail.gmail.com>
References: <CAMj1kXHNNgtBgoz9QgYiK1e3AagGy5Lb=7nrza8GPExgOD+heg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 19 Jan 2026 10:02:05 +0100, Ard Biesheuvel wrote:

> On Sat, 17 Jan 2026 at 17:01, Kohei Enju <kohei@enjuk.jp> wrote:
> >
> > efivar_entry_get() always returns success even if the underlying
> > __efivar_entry_get() fails, masking errors.
> >
> > This may result in uninitialized heap memory being copied to userspace
> > in the efivarfs_file_read() path.
> >
> > Fix it by returning the error from __efivar_entry_get().
> >
> > Fixes: 2d82e6227ea1 ("efi: vars: Move efivar caching layer into efivarfs")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
> >  fs/efivarfs/vars.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
> > index 6edc10958ecf..70e13db260db 100644
> > --- a/fs/efivarfs/vars.c
> > +++ b/fs/efivarfs/vars.c
> > @@ -552,7 +552,7 @@ int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
> >         err = __efivar_entry_get(entry, attributes, size, data);
> >         efivar_unlock();
> >
> > -       return 0;
> > +       return err;
> >  }
> >
> >  /**
> 
> Queued as a fix, thanks!

Ard, thank you for taking a look, and adding Cc to stable!

