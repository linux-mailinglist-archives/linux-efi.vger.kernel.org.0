Return-Path: <linux-efi+bounces-2974-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CD0A5E36C
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 19:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729CA17C439
	for <lists+linux-efi@lfdr.de>; Wed, 12 Mar 2025 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C51DED52;
	Wed, 12 Mar 2025 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b="SxMYhf0Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D42505A5
	for <linux-efi@vger.kernel.org>; Wed, 12 Mar 2025 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802722; cv=none; b=IQr5QEppyxQs1mgljYaYwBir/yhrt1Qybo7SXiMl/frgEHEWhrU+HC0dMi36yyBguIRq5xKbiRH/H4Hymg7BADdIL+HdWSIa06qbSbRiUN5RQ1sSnVxRYccMPxz581j3RfgXXFd7Gzq5pPSbPfdhznMrrneVEd7ANl0VLliDhhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802722; c=relaxed/simple;
	bh=NEVxSA8BM+i54WQUCxlBDw7wbbw1RSn+B0W2KgEwGOU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQ9WAGYb6Jt/1Rr0RUvdOqyL+/hRDp5B068GGkNfAbF6TTHd0FiacoRN1a931WKxVvfdkgTgMb5tjXypwxvAXjfwNiqP8WjHxgZOEc2ElN9Hkp4ZYFF27DwVfq/alAZahBq9uWwYt1N9VjGb1NcPdAdGs+smpM3WjAVqqI4J+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus; spf=pass smtp.mailfrom=bens.haus; dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b=SxMYhf0Z; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
	s=protonmail; t=1741802711; x=1742061911;
	bh=NEVxSA8BM+i54WQUCxlBDw7wbbw1RSn+B0W2KgEwGOU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=SxMYhf0ZAPuX68eAat443gGmZrkTHHIF/+a45OzCGjRxIJOG3sbmptEPvkzCXM0Ji
	 074nh4ZJkVVaSnhbGhX8Fi2dS/Okrlu9kTXofnEcbQlCYACDm1LEyghQawQmDXnsQk
	 Z6eJE7Y7t3V6SDYEhpWqZc8v3ejcf0WJ9NJi/eTl60KLQ/n2e9N4L/FOl2UHHEKSR8
	 zxwvwLGsxGjfksrdAuieuqw7lnEiblmcpheUhdvXVKAx/9/eU0e3bJWfU1A1w9fpjv
	 o76dWhYpl5krqsTx22OlaAVrxGzeO7d6n3xj+T1R+MkEEdFzwLviX3eO07RwdRhtbi
	 u6zCNvd9Ypkgw==
Date: Wed, 12 Mar 2025 18:05:07 +0000
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Ben Schneider <ben@bens.haus>
Cc: Ard Biesheuvel <ardb@kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: efi_random_alloc() returning EFI_NOT_FOUND
Message-ID: <xPmYxk1shimT-7PEuiLsqTN03MY68Lcvo9Yud8PBo6IW7UdpvL-sS60VXmLbH3o3CgkyG4bH7kpZ2sgWaVQPn2y69m1vCj_AC_ukMKJKaz4=@bens.haus>
In-Reply-To: <CAC_iWjKL7nSkr8CyFW6hOzfOTiCU+tES_PsEYC7hkcCA9gAp=Q@mail.gmail.com>
References: <5BK24Nc0mA4pe8BFp-FUgN4Q9lCFpR1TUFMKB8mRUJIhOG1hP3yYcVIulRsDSQA_7MvOOH9dg1nUiDvQSkQ2tS1vZeiZbMEFEnsMbPzB0cg=@bens.haus> <CAMj1kXHN4qTTUzCUvERy1iZVMy6jQ_-iha0EyHBsE5jH0_WaUQ@mail.gmail.com> <YT8Nabg2mhqfljPaZg1ruLmAwW-C6iNOaSA4yUC3h8tkwEgaHJswhIP0fKxb_0Tvmsc6muBWW7TRgnCgXejXrXZ5zxx8gMc1aMFZW0A8-v0=@bens.haus> <CAC_iWj+LdNXYO-nTzenCvhQN=--hmfJLzH1w_D5g676_6wQ8=g@mail.gmail.com> <PkBypGXyjiJ7T845148vEiHaoabJOyVg26qTLI-SygtRbQ9aQjnMWUddWHiYB9KPR8JVqDFQ1pZRnRUq06vIRR7L4CDLERwJL9-2LdvcxBc=@bens.haus> <CAC_iWj+YFNMZZneaQ+zh3ziM2iogB-whRsH81A8hKyNVPY0H9w@mail.gmail.com> <CihxtexZ2w9qfxFQ1v6_JhRD4eYGMDbKtlXqd7KTBfgKhNif3Qq3yaJriSzdiInTiywwgk-CxDDPCYqRPdfYKK3hf93yx774aFfjJKeIhs0=@bens.haus> <CAC_iWj+9DNswD7qCc7V8UxsAOaBTzx7QTYA7Yo8py5pEuHdWDw@mail.gmail.com> <gqqWrf3trBPlLLAJDR55YYQBffE1dToIMzSMgebh-GuI-06E3pX4WcYuFU7XOF3s_ZEjK70ePUUJBXu_V0tAxKc8dmNcQjlqR55cLRAHAJI=@bens.haus> <CAC_iWjKL7nSkr8CyFW6hOzfOTiCU+tES_PsEYC7hkcCA9gAp=Q@mail.gmail.com>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: 02088d5dd4cc5f839a6a0f387b25b7310b006d1b
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, March 12th, 2025 at 4:24 AM, Ilias Apalodimas <ilias.apalodim=
as@linaro.org> wrote:
>=20
> Can you please apply[...]to make
> sure the map doesn't change from the time the slots were calculated.

It doesn't seem like they do. This is the output:

7 0-4000000
0 4000000-4200000
7 4200000-4400000
0 4400000-5400000
7 5400000-3daef000
1 3daef000-3e2d5000
7 3e2d5000-3ea78000
2 3ea78000-3ea7b000
1 3ea7b000-3eaa1000
4 3eaa1000-3eaa7000
2 3eaa7000-3eaba000
4 3eaba000-3eabb000
2 3eabb000-3eabd000
4 3eabd000-3eabe000
9 3eabe000-3eac5000
4 3eac5000-3eac9000
6 3eac9000-3eaca000
4 3eaca000-3eacb000
6 3eacb000-3eaed000
4 3eaed000-3eaf6000
3 3eaf6000-3fb92000
6 3fb92000-3fb93000
3 3fb93000-3ff00000
5 3ff00000-3ff10000
3 3ff10000-40000000

Inside get_entry_num_slots() it skips everything that's not
conventional which just leaves these four entries:

7 0-4000000
7 4200000-4400000
7 5400000-3daef000
7 3e2d5000-3ea78000

As a reminder, size is 18087936.

For the first entry, I am seeing region_end =3D 67108863, first_slot
=3D 0, last_slot =3D 48234496 so the function returns 24. This is the
entry that is then subsequently used in the efi_allocate_pages()
call that returns EFI_NOT_FOUND.

For the second entry, first_slot > last_slot so we return 0.

For the third entry, I am seeing region_end =3D 1034874879,
first_slot =3D 88080384, last_slot =3D 1015021568 so the function
returns 443. This is the entry that, when used by allocate pages
by ignoring the first EFI_NOT_FOUND, returns EFI_SUCCESS and we
continue to boot.

For the fourth entry, first_slot > last_slot so we return 0.

Ben

