Return-Path: <linux-efi+bounces-860-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BC78873F8
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 20:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFA31C228A8
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 19:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B177AE63;
	Fri, 22 Mar 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="Kj1QB2Ki"
X-Original-To: linux-efi@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFB7AE5C
	for <linux-efi@vger.kernel.org>; Fri, 22 Mar 2024 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711136059; cv=none; b=MrPjP3dO3eqHdo2OpwufC7cKICa8esBnyCdkEGvTbNrMvmgpOkuyGAquW0urEpS0j6XkOUuwEKVcrVQeRa4FThwTn6PYSg9mmQ0ZAw+0M8Hm1r8bANk2zDONCIfkoFhJBmr8a6h6Go8l/QxrQdvJJbz1zrXmaltNoD6buwrVygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711136059; c=relaxed/simple;
	bh=rmSxOJ7PesryFAlCYmpPV9lPM91ZLNWCXgJKf7O7vEw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=JbiG3/BYiKJvW9tlHsFgB45hJXI/Z5UP31t6tnpNHRej7j+Ey251rVxEhWf66yNDT9JRo1GvxMnt171iHv9k+Rx6EgIM/qpyxE0tm9Huay38ca9f5l1o72beeZAYuHWk+kvSjmxiiSsooh71Yf+pdqQvNgZM9myaOfS2IXp3e5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=Kj1QB2Ki; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1711136055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmSxOJ7PesryFAlCYmpPV9lPM91ZLNWCXgJKf7O7vEw=;
	b=Kj1QB2Ki6DZ6KhgM77hUzPva/yi9CQDjDrOeQcS8zioPvZN9//CpoNvsSLuS1VUy4Vm+k9
	mIAnA0OHemCkGxjj75TnqezkmBWoyYOw+xtVpoDNDBNsUfpK4yQQyTwZ7uIOYoLHC/6QW2
	ZLVCr4yfVkn94nTHfTQYamuWuC84m0a8md9x4dfaVp1V7Zk+TpyKxc0zJvpdZEgn/ceps2
	qpDj1YAamo819kmdnvIl88Z20VBQoF8OVZsxASapbyuF3avfj7R66qnayIORrTqbxfaT3Z
	B6f+PpzazTzdg/EoFu+pE8XBgzKf68olAEY9Sl5gaSOkzESJ6i6Fzcw3CeDmVA==
Date: Fri, 22 Mar 2024 19:34:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Clayton Craft" <clayton@craftyguy.net>
Message-ID: <8a64ba697d719bc9750e6fffc268e194dfde16e5@craftyguy.net>
TLS-Required: No
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
To: "Ard Biesheuvel" <ardb@kernel.org>
Cc: "Hans de Goede" <hdegoede@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, "Thomas
 Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, regressions@lists.linux.dev
In-Reply-To: <CAMj1kXEH4CTnQ3d+Z-TnqNUhFaFc1yH+Eaa6cHk9-vZ_geQ2nw@mail.gmail.com>
References: <20240321150510.GI8211@craftyguy.net>
 <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
 <20240321170641.GK8211@craftyguy.net>
 <CAMj1kXE-sxGM2H8akunJ1mZPDSVX1+2ehDtK-jqW--8tw9J5LA@mail.gmail.com>
 <20240322091857.GM8211@craftyguy.net>
 <CAMj1kXFmnv+FGRMnnJMJejj5yvSybgZTNEYZz0hxb6K9VAeo1Q@mail.gmail.com>
 <fe09869c2d853bde8ce0feb537c4dab09014f5d9@craftyguy.net>
 <CAMj1kXEH4CTnQ3d+Z-TnqNUhFaFc1yH+Eaa6cHk9-vZ_geQ2nw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

March 22, 2024 at 11:30 AM, "Ard Biesheuvel" <ardb@kernel.org> wrote:


>=20
>=20On Fri, 22 Mar 2024 at 19:57, Clayton Craft <clayton@craftyguy.net> w=
rote:
>=20
>=20I have pushed a branch below that reverts the patch you identified in
>=20
>=204 separate steps. Could you please check which step makes your system
>=20
>=20boot again?
>=20
>=20https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=
=3Defi-clayton
>

Thanks a lot for doing this, I really appreciate the help!

It looks like if I build from 868a7245, booting breaks again on my Bay Tr=
ail systems. If I put back 00e85ab5, they boot again.

-Clayton

