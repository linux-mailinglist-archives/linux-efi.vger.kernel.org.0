Return-Path: <linux-efi+bounces-2940-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B14A57FEB
	for <lists+linux-efi@lfdr.de>; Sun,  9 Mar 2025 01:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F283B0CCE
	for <lists+linux-efi@lfdr.de>; Sun,  9 Mar 2025 00:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA624380;
	Sun,  9 Mar 2025 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b="VUUXi7vf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B336C
	for <linux-efi@vger.kernel.org>; Sun,  9 Mar 2025 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741478619; cv=none; b=rdT8YsDd2G6l6gwg3RnSRTS/X2Y6yz2IbjAY43lQNNYNImGYYa539kmghY0kn/o1VS6b3lgt7ZKvWD2f1iYGwcArYs2omHHUjGwiKJIlOM9FvAf7RafG+EMe/k+v8k427sLr6h8QdDt05M8Rne0c05lGiLy1g0wn3yPtYkykim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741478619; c=relaxed/simple;
	bh=J+XTXd1Wz8T5YSo4dwAKjborFVB1YVduG7AGjrRY8N0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uj+48UYotHOH8x6IzyZwJ0HVuDt4jbvZ/4G7SGlRo/0G9vPZWEw01fo9Hhe7MXzHZOZkutgedovrMTMNlXFA04ds9BfM62l1kf7QtC7c8FRlo7Qk2JdtK1pr4ulTktNU3BHyMWOppeu8Gx8L0dXdo36SDwlVn7AWScBE95trKvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus; spf=pass smtp.mailfrom=bens.haus; dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b=VUUXi7vf; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
	s=protonmail; t=1741478606; x=1741737806;
	bh=J+XTXd1Wz8T5YSo4dwAKjborFVB1YVduG7AGjrRY8N0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=VUUXi7vfsbMwoSxiVUPQKytgrCF7XqSfEFqzIqiz4GNT+QU3ZHXwYhVPgkS6Pvflj
	 xuu9eOf3569QpZGZceKRIKMiln0r8tf5MsOxOoQCxRyxDfIJmF/zfvzzBgLeqXyemj
	 yNu3H8ZxF98fsba/iY+eu45zWaZCP6rAbdI4PTDSyK7t3YGI0b/CHKZC1Fp4B7ZDCl
	 jnLOcImiTTWr7JnffYATHt2WaZnd21QQBt0I07+JdmsZj4m9K6uK378Wobz5PWlWSE
	 /Ad8wWjoaZy1+nV0jILTB4vh28ZvtNxDnH838M8rPhcbZAcvaWcvoEHQ64KVL+qLBg
	 NPmXgAAri2Otg==
Date: Sun, 09 Mar 2025 00:03:21 +0000
To: Ard Biesheuvel <ardb@kernel.org>
From: Ben Schneider <ben@bens.haus>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: efi_random_alloc() returning EFI_NOT_FOUND
Message-ID: <YT8Nabg2mhqfljPaZg1ruLmAwW-C6iNOaSA4yUC3h8tkwEgaHJswhIP0fKxb_0Tvmsc6muBWW7TRgnCgXejXrXZ5zxx8gMc1aMFZW0A8-v0=@bens.haus>
In-Reply-To: <CAMj1kXHN4qTTUzCUvERy1iZVMy6jQ_-iha0EyHBsE5jH0_WaUQ@mail.gmail.com>
References: <5BK24Nc0mA4pe8BFp-FUgN4Q9lCFpR1TUFMKB8mRUJIhOG1hP3yYcVIulRsDSQA_7MvOOH9dg1nUiDvQSkQ2tS1vZeiZbMEFEnsMbPzB0cg=@bens.haus> <CAMj1kXHN4qTTUzCUvERy1iZVMy6jQ_-iha0EyHBsE5jH0_WaUQ@mail.gmail.com>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: 17a255198128883daad4a962a08225616b836c27
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, March 8th, 2025 at 2:49 PM, Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> what happens is that the second loop only considers memory regions that w=
ere found to be available during the first loop.

Ah, I see what the intention is now. Sorry I missed that.

> What firmware are you using?

U-Boot 2025.04-rc3 which I use to load systemd-boot which then
tries to load the kernel.

> Can you share the contents of the EFI memory map?

This is the memory map at power-on (before systemd-boot has
loaded):

lmb_dump_all:
 memory.count =3D 0x1
 memory[0]=09[0x0-0x3fffffff], 0x40000000 bytes, flags: none
 reserved.count =3D 0x4
 reserved[0]=09[0x4000000-0x41fffff], 0x200000 bytes, flags: no-map
 reserved[1]=09[0x4400000-0x53fffff], 0x1000000 bytes, flags: no-map
 reserved[2]=09[0x3eaf3000-0x3eaf5fff], 0x3000 bytes, flags: no-notify, no-=
overwrite
 reserved[3]=09[0x3eaf6950-0x3fffffff], 0x15096b0 bytes, flags: no-overwrit=
e

When efi_allocate_pages() is first called, U-Boot reports the
memory map looks like this:

lmb_dump_all:
 memory.count =3D 0x1
 memory[0]=09[0x0-0x3fffffff], 0x40000000 bytes, flags: none
 reserved.count =3D 0x5
 reserved[0]=09[0x4000000-0x41fffff], 0x200000 bytes, flags: none
 reserved[1]=09[0x4400000-0x53fffff], 0x1000000 bytes, flags: none
 reserved[2]=09[0x3dae6000-0x3e2cbfff], 0x7e6000 bytes, flags: no-overwrite=
, no-map
 reserved[3]=09[0x3ea6f000-0x3eaf0fff], 0x82000 bytes, flags: no-overwrite,=
 no-map
 reserved[4]=09[0x3eaf1960-0x3fffffff], 0x150e6a0 bytes, flags: no-map

It also seems like when it makes that first call it is asking for
4,416 pages at address 0x3faf1138. It seemed to me like this was
inside an already reserved range which I assumed is why U-Boot
returns EFI_NOT_FOUND.

