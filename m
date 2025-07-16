Return-Path: <linux-efi+bounces-4385-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6899AB076DA
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 15:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4565584B72
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 13:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA1F1C6FE1;
	Wed, 16 Jul 2025 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="rY3fLhyQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581D1C54AA;
	Wed, 16 Jul 2025 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672367; cv=none; b=gCcN6MhC7ulwO35zBTsDQYeS2cuCLJ1OKBqkp7jpHZ7pWrHJJGSUZekjCg2DQset3QqX/wHA/5yZ8M5/WjuPF/TEHn1UA/05e9+YTQOmFqXhTefniC9t0dVPK45M+k7en5SG8X58XZH8pbCTUYJRh+Nf3dgW7+vVE310rQA88Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672367; c=relaxed/simple;
	bh=S3vbo1Uc5mIXUvR/z5z8bfmhiPJf0YBwu4i/p3VtPpI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Upz74m7DM2M3FHg3GHjcn5lPKJtPm6OFb4yWtIWWUw2BkaEGGSAKLKPHyzPoZNGNJbKCfI7dmsPrLfFRAOPka9HSfTJYzkLmTTsWhQe4F5tPOx71qu8VT/nsN6qUE1J6tHyENjjLp3IZ5wj9xWAjPuNERmVptWP3QSEKe/E/Dek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=rY3fLhyQ; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1752672364;
	bh=S3vbo1Uc5mIXUvR/z5z8bfmhiPJf0YBwu4i/p3VtPpI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=rY3fLhyQcZzTFg5VugUJGS46+VIj7V8hYk7L+BXBE0MXCOflQun83qJCAIyUK9SCi
	 QkjZxtLUYF7+CUQyaPAx29hxQKBBg4/qRR0Y2NhfkTeNfOItSISoF6dMaGoXcXpp9+
	 Mcup1X1ivq9of2ooLlC5oKUgxTtfmaRTNeUORHhI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id 056931C0347;
	Wed, 16 Jul 2025 09:26:03 -0400 (EDT)
Message-ID: <ec0a66f40bc826bd016f338568e01908b86be35a.camel@HansenPartnership.com>
Subject: Re: [PATCH] efivarfs: Suppress false-positive kmemleak warning for
 sfi
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Date: Wed, 16 Jul 2025 09:26:03 -0400
In-Reply-To: <qdw7skjlcw6dvnewpfrtxc27pm7sroan5eyn53exndehp3blav@z25oqkoo3ohw>
References: <20250715-kmemleak_efi-v1-1-c07e68c76ae8@debian.org>
	 <CAMj1kXHJpRioZD7aUJnkMLWkiTmQ_Nr6MNcSYR0adeLdjf5BrA@mail.gmail.com>
	 <rvlw467lzx5yx3sl56u3xcc2hhhn3vj2fu7msg3e5o4giwtkcb@oomdafhhnqcv>
	 <a3d063f4b0ccaad7595938ea0dca016872882f0d.camel@HansenPartnership.com>
	 <7fe68ef138e43a5cf83c8b5d2dd3fc8101a8a225.camel@HansenPartnership.com>
	 <qdw7skjlcw6dvnewpfrtxc27pm7sroan5eyn53exndehp3blav@z25oqkoo3ohw>
Autocrypt: addr=James.Bottomley@HansenPartnership.com;
 prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-16 at 06:16 -0700, Breno Leitao wrote:
> On Wed, Jul 16, 2025 at 09:09:00AM -0400, James Bottomley wrote:
> > On Wed, 2025-07-16 at 08:31 -0400, James Bottomley wrote:
> > [...]
> > > If the theory is correct, the leak is genuine and we need to
> > > implement .free in efivarfs_context_ops to fix it.
> >=20
> > Rather than trying to trace this, which will be hard, it might be
> > easier just to try the fix below (not even compile tested) and see
> > if
> > it works.=C2=A0 Note there's no danger of a double free because when fc=
-
> > > s_fs_info is copied to sb->s_fs_info, the field is nulled in fc.
> >=20
> > Regards,
> >=20
> > James
> >=20
> > ---
> >=20
> > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > index c900d98bf494..90a619d027fd 100644
> > --- a/fs/efivarfs/super.c
> > +++ b/fs/efivarfs/super.c
> > @@ -390,10 +390,16 @@ static int efivarfs_reconfigure(struct
> > fs_context *fc)
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +static void efivarfs_fs_context_free(struct fs_context *fc)
> > +{
> > +	kfree(fc->s_fs_info);
> > +}
> > +
> > =C2=A0static const struct fs_context_operations efivarfs_context_ops =
=3D {
> > =C2=A0	.get_tree	=3D efivarfs_get_tree,
> > =C2=A0	.parse_param	=3D efivarfs_parse_param,
> > =C2=A0	.reconfigure	=3D efivarfs_reconfigure,
> > +	.free		=3D efivarfs_fs_context_free,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static int efivarfs_check_missing(efi_char16_t *name16, efi_guid_=
t
> > vendor,
>=20
> Hello James,
>=20
> I was testing something very similar based on your previous email. I
> can
> confirm that the following patch make kmemleak happy.=20
>=20
> Regarding the fixes, I think this was introduced in commit
> 5329aa5101f73c ("efivarfs: Add uid/gid mount options")
>=20
> commit 035521e8a5029ea814337d680e0552ccab1f97e2
> Author: Breno Leitao <leitao@debian.org>
> Date:=C2=A0=C2=A0 Wed Jul 16 06:08:57 2025 -0700
>=20
> =C2=A0=C2=A0=C2=A0 efivarfs: Fix memory leak of efivarfs_fs_info in fs_co=
ntext error
> paths
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 When processing mount options, efivarfs allocates
> efivarfs_fs_info (sfi)
> =C2=A0=C2=A0=C2=A0 early in fs_context initialization. However, sfi is as=
sociated
> with the
> =C2=A0=C2=A0=C2=A0 superblock and typically freed when the superblock is =
destroyed.
> If the
> =C2=A0=C2=A0=C2=A0 fs_context is released (final put) before fill_super i=
s
> called=E2=80=94such as
> =C2=A0=C2=A0=C2=A0 on error paths or during reconfiguration=E2=80=94the s=
fi structure would
> leak,
> =C2=A0=C2=A0=C2=A0 as ownership never transfers to the superblock.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Implement the .free callback in efivarfs_context_ops t=
o ensure
> any
> =C2=A0=C2=A0=C2=A0 allocated sfi is properly freed if the fs_context is t=
orn down
> before
> =C2=A0=C2=A0=C2=A0 fill_super, preventing this memory leak.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Suggested-by: James Bottomley
> <James.Bottomley@HansenPartnership.com>
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Breno Leitao <leitao@debian.org>
>=20
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index c900d98bf4945..07a3b9293396b 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -390,10 +390,22 @@ static int efivarfs_reconfigure(struct
> fs_context *fc)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static void efivarfs_free(struct fs_context *fc)
> +{
> +	struct efivarfs_fs_info *sfi;
> +
> +	sfi =3D fc->s_fs_info;
> +	if (!sfi)
> +		return;

Here, you'll excite the coccinelle checkers looking for if(x) free(x)
because free() already also has a test for NULL.

Other than that elision, it looks fine to me.

Regards,

James


