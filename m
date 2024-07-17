Return-Path: <linux-efi+bounces-1449-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC993423E
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 20:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D3C4B21FB6
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 18:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DA6183062;
	Wed, 17 Jul 2024 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QS+SfFse"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F41822DD;
	Wed, 17 Jul 2024 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240855; cv=none; b=ZPb0mP1jd2Q51U4dbiNYdRfKGb5sGHuFicaFjihsi86lg9DnfQhb3Wr/wm+5EVJ0UmGa0cJTDcUwQeu3s+hI0GkT+CMxHRll38PCI52/I8ZkgAndL1R0Kqg+IGWCw5r2E7mtECc6sYK4mKqddkDdqIs9nIKtQ+Y8dKpuF3iY2lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240855; c=relaxed/simple;
	bh=Q8d+wqQV3Y1mwGV2wmGPBJlfpY/dnACslmNjMxRU13A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/CQuGLlBQokF6zYlXoWEXQfj/KyJfcxyRtdDM1B6H2Ks0cpbWKcUqrVNqoCEk+waurLGO6CgpcbKJYj9xwh+CIeOCSS8DliVic9MrdnkjEVCPsxhS79sCp2dSdGokUA5l+zWgGoP4SQzBhkBYpkwTr69BbKDBZhib3GrMcBBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QS+SfFse; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721240844; x=1721500044;
	bh=Q8d+wqQV3Y1mwGV2wmGPBJlfpY/dnACslmNjMxRU13A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QS+SfFsegZdUVMzsy7uTyixQRDJb9hxqb6+h6L8erLjn2+xbsDcOps+BEBeyy4xQw
	 rM9MxyNWD7NTEjbsBCtE0K3qm2BdQewDAXnrNSyODyTvleJU/qoSpL4krVnlbCFbmG
	 3eO9Tt/nyA0tf3vj1oXf7HXQxVwherkiWQxvdJiMBmnl+Fmfk/cUPjwoDF877srCBj
	 yQVTp4CThu20w6KJZ/Y+vL5oPGm4xNFWOxEWVHYgKR24mSg7UFOuDIrrA5FSuj1VQR
	 vB0alPkD3SDEGZT1QFgFcmfgTbQxAAOziaIvnHz3EU1faLpfTe5e7e8TpOYL7fAOXV
	 PnuMLJTjtJ1ng==
Date: Wed, 17 Jul 2024 18:27:17 +0000
To: Aditya Garg <gargaditya08@live.com>
From: Sharpened Blade <sharpenedblade@proton.me>
Cc: Ard Biesheuvel <ardb@kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Lukas Wunner <lukas@wunner.de>, Kerem Karabay <kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Message-ID: <pqPZcYgBsBnpSd8MTxyDtnXAeWgjlIhAgUK_nGg-s4IbXPl311zGwY6saehL0ODtShMvUpTEo-K6PlJw5DivrdeHolVNUVM5MJii0K4Lq48=@proton.me>
In-Reply-To: <MA0P287MB02171286CB1BF5CD506FCE55B8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20240701140940.2340297-4-ardb+git@google.com> <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM> <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM> <CAMj1kXEGsnd5S3-nnCUNYJ5tVr2LU2BOkNp513OfU6A=jgVX2A@mail.gmail.com> <MA0P287MB02171286CB1BF5CD506FCE55B8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Feedback-ID: 49108975:user:proton
X-Pm-Message-ID: 2d7a6afc3dcb3d4e5106d45c9c24941436e33608
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Hi Ard
>=20
> > Hi,
> >=20
> > Is this a theoretical concern? Or are you aware of any user that is
> > actually affected by this?
>=20
>=20
> We had a Mac Mini user who wasn't able to use hybrid graphics
> on his Mac after using the eGPU. So no, it's not a theoretical concern
>=20
> > In any case, given the niche nature, enabling this more widely by
> > default does not seem like a great approach, as the risk for
> > regressions outweighs the benefit.
> >=20
> > I could imagine the use of a EFI variable to opt into this, would that
> > work? It would have to be set only once from user space (using
> > efivarfs)
>=20
>=20
> I'm not really sure about efivars here, but am ready to test. As long as
> it doesn't break booting of macOS or Windows, I don't find it an issue.
> macOS may also reset the variable, again have to verify by testing the sa=
me.

On my mac, macOS does not reset EFI variables that it does not use. It shou=
ld be the same for other models and firmware versions.

> I guess it will also get reset if a users resets their NVRAM.

Users have to manually reset their nvram so this will not happen during nor=
mal usage. This is actually a good thing since users can easily disable the=
 eGPU if it is misbehaving and they dont have graphical output.

