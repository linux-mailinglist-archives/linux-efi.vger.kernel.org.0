Return-Path: <linux-efi+bounces-2945-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A06A586EA
	for <lists+linux-efi@lfdr.de>; Sun,  9 Mar 2025 19:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C330168E77
	for <lists+linux-efi@lfdr.de>; Sun,  9 Mar 2025 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3931E5200;
	Sun,  9 Mar 2025 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b="go8JZcHf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1AF1DF244
	for <linux-efi@vger.kernel.org>; Sun,  9 Mar 2025 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543986; cv=none; b=SoOk5qeCT339VdpsBjJDNQftrqqo2YIZcqUU2VtRYTowM96wxsiou9WIwLZQRhPMICpWVtPlZXt7H6Ouc6Nb3qWQiZmu36KX2GlULNq7jjqoNDpw72D9ZSvQrkklHfBrY1ZJixT9BeVFAal1aJGImDwCeadwoPIqvZsvNWlHRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543986; c=relaxed/simple;
	bh=zyvv6LE5+/RI+8XoWGFK9P0N4tsvDV6NnM+TvTUIRp4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgW4x3NOkv3CaoONmfOdTv7G0c5nqKGVSPI5iW2UAvYEA3FhxuGcb0xuDINlekAzu7z1Jqex/mvr9af9M9U94OJ2NtYrl2fGnNg4JuG+tJqOttLYrumWuuovZa3f1vhO9XmOLmt1/qM8VVn/f/o+bgUwMPga6RxdZfXAM7h206I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus; spf=pass smtp.mailfrom=bens.haus; dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b=go8JZcHf; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
	s=protonmail; t=1741543967; x=1741803167;
	bh=D+ZO3yA/5q2BYOGvFkMiUSl/RH69JsisG9aWYBA4aYc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=go8JZcHfC6W3WMsZZo4FydfgyW8vyXV/S2H5CIWQgJjqbigkJNnLdVdFQ6vX6AHka
	 GXbY/DRk0dp5ZfjB03RaC9BRvFVkv3PwhKDrEIXdpRyT/bIEfc6YdZ3HejqKdqjVfB
	 zzECymQ6PfLpdM63tdAPLU864up++rUdXKXt0tYjk2hkPIo/avPqsBJePuByEa/qyz
	 7POKMSytMlcyfrrkgXq89QeSTJaISzSClEPAzP6ePRBkm02DXTevdbs6NUlPWFgIBN
	 3M9wVCyfx/6V97UeQcJ85O4lMJzezh2d6PN/f7NqlpueaGrPvbcefxAtstjkyONFzU
	 cAhxq2s25YLyw==
Date: Sun, 09 Mar 2025 18:12:45 +0000
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Ben Schneider <ben@bens.haus>
Cc: Ard Biesheuvel <ardb@kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: efi_random_alloc() returning EFI_NOT_FOUND
Message-ID: <PkBypGXyjiJ7T845148vEiHaoabJOyVg26qTLI-SygtRbQ9aQjnMWUddWHiYB9KPR8JVqDFQ1pZRnRUq06vIRR7L4CDLERwJL9-2LdvcxBc=@bens.haus>
In-Reply-To: <CAC_iWj+LdNXYO-nTzenCvhQN=--hmfJLzH1w_D5g676_6wQ8=g@mail.gmail.com>
References: <5BK24Nc0mA4pe8BFp-FUgN4Q9lCFpR1TUFMKB8mRUJIhOG1hP3yYcVIulRsDSQA_7MvOOH9dg1nUiDvQSkQ2tS1vZeiZbMEFEnsMbPzB0cg=@bens.haus> <CAMj1kXHN4qTTUzCUvERy1iZVMy6jQ_-iha0EyHBsE5jH0_WaUQ@mail.gmail.com> <YT8Nabg2mhqfljPaZg1ruLmAwW-C6iNOaSA4yUC3h8tkwEgaHJswhIP0fKxb_0Tvmsc6muBWW7TRgnCgXejXrXZ5zxx8gMc1aMFZW0A8-v0=@bens.haus> <CAC_iWj+LdNXYO-nTzenCvhQN=--hmfJLzH1w_D5g676_6wQ8=g@mail.gmail.com>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: 0e3c5e7a52cc5901918cbaa23fa57dd5a8eabeaf
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilias, thank you for connecting the threads. I'm clearly
struggling a bit and appreciate how patient and helpful
everyone has been.

On Saturday, March 8th, 2025 at 5:43 PM, Ilias Apalodimas <ilias.apalodimas=
@linaro.org> wrote:
> The 'efidebug' command will dump the EFI memory map. Can you send that?

This is what U-Boot reports:

Type             Start            End              Attributes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CONVENTIONAL     0000000000000000-0000000004000000 WB
BOOT DATA        0000000004000000-0000000004200000 WB
CONVENTIONAL     0000000004200000-0000000004400000 WB
BOOT DATA        0000000004400000-0000000005400000 WB
CONVENTIONAL     0000000005400000-000000003eabc000 WB
BOOT DATA        000000003eabc000-000000003eac1000 WB
RUNTIME DATA     000000003eac1000-000000003eac2000 WB|RT
BOOT DATA        000000003eac2000-000000003eac3000 WB
RUNTIME DATA     000000003eac3000-000000003eae5000 WB|RT
BOOT DATA        000000003eae5000-000000003eaee000 WB
BOOT CODE        000000003eaee000-000000003fb8a000 WB
RUNTIME DATA     000000003fb8a000-000000003fb8b000 WB|RT
BOOT CODE        000000003fb8b000-000000003ff00000 WB
RUNTIME CODE     000000003ff00000-000000003ff10000 WB|RT
BOOT CODE        000000003ff10000-0000000040000000 WB

> Any idea if we can reproduce this on QEMU?

I have not attempted to reproduce with QEMU.

From what I can tell on my device, total_slots is 467 and
target_slot seems to always start with a value of 0 despite the
comment that it should be a random value in [0, total_slots).

In the first iteration through the second for loop,
MD_NUM_SLOTS(md) appears to have a value of 24 and since
target_slot is always 0, it never reaches the 'continue'
statement. With current builds, &target appears to have a value of
3faee138. U-Boot appears to send this address to map_to_sysmem()
[1] which seems to return 0, which is then what results in the
EFI_NOT_FOUND.

I went back to try figure out why it is somehow working when I
block the 'break' statement with the condition status =3D=3D
EFI_SUCCESS. Doing so causes the loop to start its second
iteration when EFI_NOT_FOUND comes back. In the second iteration,
MD_NUM_SLOTS(md) is 0 so we reach the 'continue' statement. This
happens for the third and fourth iteration too. On the fifth
iteration, MD_NUM_SLOTS(md) is 443 so it makes its second call to
efi_allocate_pages(). On all iterations, target_slot remains 0.

What is confusing is this second call to efi_allocate_pages()
seems to have the same value for &target of 3faee138, but this
time when U-Boot calls map_to_sysmem() it returns a value of
88080384 instead of 0. As a result, we get EFI_SUCCESS and the
kernel boots.

U-Boot also reports a new reservation in its lmb map between the
first and second calls to efi_allocate_pages().

During first call to efi_allocate_pages():

lmb_dump_all:
 memory.count =3D 0x1
 memory[0]=09[0x0-0x3fffffff], 0x40000000 bytes, flags: none
 reserved.count =3D 0x5
 reserved[0]=09[0x4000000-0x41fffff], 0x200000 bytes, flags: none
 reserved[1]=09[0x4400000-0x53fffff], 0x1000000 bytes, flags: none
 reserved[2]=09[0x3dae3000-0x3e2c8fff], 0x7e6000 bytes, flags: no-overwrite=
, no-map
 reserved[3]=09[0x3ea6c000-0x3eaedfff], 0x82000 bytes, flags: no-overwrite,=
 no-map
 reserved[4]=09[0x3eaee960-0x3fffffff], 0x15116a0 bytes, flags: no-map

During second call to efi_allocate_pages():

lmb_dump_all:
 memory.count =3D 0x1
 memory[0]=09[0x0-0x3fffffff], 0x40000000 bytes, flags: none
 reserved.count =3D 0x6
 reserved[0]=09[0x0-0x113ffff], 0x1140000 bytes, flags: no-overwrite, no-ma=
p
 reserved[1]=09[0x4000000-0x41fffff], 0x200000 bytes, flags: none
 reserved[2]=09[0x4400000-0x53fffff], 0x1000000 bytes, flags: none
 reserved[3]=09[0x3dae3000-0x3e2c8fff], 0x7e6000 bytes, flags: no-overwrite=
, no-map
 reserved[4]=09[0x3ea6c000-0x3eaedfff], 0x82000 bytes, flags: no-overwrite,=
 no-map
 reserved[5]=09[0x3eaee960-0x3fffffff], 0x15116a0 bytes, flags: no-map

[1] https://github.com/u-boot/u-boot/blob/master/lib/efi_loader/efi_memory.=
c#L493


