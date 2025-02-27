Return-Path: <linux-efi+bounces-2838-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1CDA47808
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 09:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0AA164ACB
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 08:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B312222A5;
	Thu, 27 Feb 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hughsie.com header.i=@hughsie.com header.b="lKYn1QWs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D21225412
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645624; cv=none; b=MGZQ8LubrElwwyj2S+r81gty5RKcEF5t9SteKKMJ9/gvF2pXQ6ETAzB6nKLi7Lrowmh59yhM6zaJ3f1/mz5kwhoskHEh4szZj2LVJJkubziEapa5ZrXwUuHt59k4x0q8JLWKyxHOX2xS9sGOJZNW3dXvk97FNBWpalGdllgqSs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645624; c=relaxed/simple;
	bh=t96aeVWOkwMmOawgRqXeVYngPIe88blRB5Aib5IfT5o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/n/qcSdUa4YIGMj/Hr9cLyKPtNdTvXBgZICkSRuN8HEpWBOPzW+DXr23r4eFSjXR9hDfpWOGL0CRrBIp9lmh3HyPXpXoD7fkRlrk3zFeGZ7eQcfld1odiNF/VcAZNuAeu96pSWHvflc/5Xw2QrQMExT84Upg+QFAjFoDHwK6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hughsie.com; spf=pass smtp.mailfrom=hughsie.com; dkim=pass (2048-bit key) header.d=hughsie.com header.i=@hughsie.com header.b=lKYn1QWs; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hughsie.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hughsie.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hughsie.com;
	s=protonmail2; t=1740645618; x=1740904818;
	bh=t96aeVWOkwMmOawgRqXeVYngPIe88blRB5Aib5IfT5o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=lKYn1QWsdmk6DjlqWOVf+7fLBaSyU97ktciSOJwyiGa4fjXdv7Wfl9zGkcyyHtAC0
	 kyCDOcI+knhFqAuP/Iu798cgn6crc7fwLmQt0cA/42InCdy2hJG8C2CICX6NZ5vXQJ
	 e7SOFfWLPUZFFZFOgcVcjU3L5ps6MIyItsnoq4Dsu4t4eE1IKGyNTmWxxSrMC6Cv3G
	 OcjKtSGkXhoQggR85xtAzcCZ69xPkos2334K4W6WhYbKB5wDN0RsgDToSuAAtlkR9G
	 7FKSSHvcErmUK0PVLIGBdBn0bFLLIG7IMHiMyoDmOoUPquWH9lK8UNhTioT391u58B
	 oLDUaCdpZWttw==
Date: Thu, 27 Feb 2025 08:40:12 +0000
To: Ard Biesheuvel <ardb@kernel.org>
From: Richard Hughes <richard@hughsie.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-efi@vger.kernel.org
Subject: Re: [PATCH] efivarfs: allow creation of zero length files
Message-ID: <NIeHAFFHF2oBnFOiEzczq-JCgaJIzUEcexhq-mAxNYqhqxjnFILSFxotUBWDw6n-uOq34hV4hyKOd5BZzFXxQslovRvatHJAjQOK1GiHuqA=@hughsie.com>
In-Reply-To: <CAMj1kXFqFHZHntOp78wmhpBzTMoCcSQXVDd1yOVv3Z3VpRj0pw@mail.gmail.com>
References: <63837c36eceaf8cf2af7933dccca54ff4dd9f30d.camel@HansenPartnership.com> <CAMj1kXFqFHZHntOp78wmhpBzTMoCcSQXVDd1yOVv3Z3VpRj0pw@mail.gmail.com>
Feedback-ID: 110239754:user:proton
X-Pm-Message-ID: 18b95ab36b08a5d952b3563ae1169d26f0370549
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Also, a tiny nit -- "fwupd" is the program that actually deploys the capsul=
e updates -- the "LVFS" is just the webservice that vendors upload firmware=
 to. Thanks.

Richard.

On Thursday, 27 February 2025 at 07:54, Ard Biesheuvel <ardb@kernel.org> wr=
ote:

>=20
>=20
> On Wed, 26 Feb 2025 at 22:48, James Bottomley
> James.Bottomley@hansenpartnership.com wrote:
>=20
> > Temporarily allow the creation of zero length files in efivarfs so the
> > Linux Vendor Firmware Service can continue to operate. This hack should
> > be reverted as soon as the LVFS mechanisms for updating firmware have
> > been fixed.
> >=20
> > LVFS has been coded to open a firmware file, close it, remove the
> > immutable bit and write to it. Since commit 908af31f4896 ("efivarfs:
> > fix error on write to new variable leaving remnants") this behaviour
> > results in the first close removing the file which causes the second
> > write to fail. To allow LVFS to keep working code up an indicator of
> > size 1 if a write fails and only remove the file on that condition (so
> > create at zero size is allowed).
> >=20
> > Tested-by: Richard Hughes richard@hughsie.com
> > Signed-off-by: James Bottomley James.Bottomley@HansenPartnership.com
> > ---
> > This should be reverted in the 6.15 release
>=20
>=20
> Thanks James. Mind resending this with a MUA that doesn't mangle patches?
>=20
> > fs/efivarfs/file.c | 10 ++++++----
> > 1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
> > index cb1b6d0c3454..c294a8fc566d 100644
> > --- a/fs/efivarfs/file.c
> > +++ b/fs/efivarfs/file.c
> > @@ -57,10 +57,11 @@ static ssize_t efivarfs_file_write(struct file
> > *file,
> >=20
> > if (bytes =3D=3D -ENOENT) {
> > /*
> > - * zero size signals to release that the write deleted
> > - * the variable
> > + * FIXME: temporary workaround for fwupdate, signal
> > + * failed write with a 1 to keep created but not
> > + * written files
> > */
> > - i_size_write(inode, 0);
> > + i_size_write(inode, 1);
> > } else {
> > i_size_write(inode, datasize + sizeof(attributes));
> > inode_set_mtime_to_ts(inode,
> > inode_set_ctime_current(inode));
> > @@ -124,7 +125,8 @@ static int efivarfs_file_release(struct inode
> > *inode, struct file *file)
> > struct efivar_entry *var =3D inode->i_private;
> >=20
> > inode_lock(inode);
> > - var->removed =3D (--var->open_count =3D=3D 0 && i_size_read(inode)
> > =3D=3D 0);
> > + /* FIXME: temporary work around for fwupdate */
> > + var->removed =3D (--var->open_count =3D=3D 0 && i_size_read(inode)
> > =3D=3D 1);
> > inode_unlock(inode);
> >=20
> > if (var->removed)
> > --
> > 2.43.0

