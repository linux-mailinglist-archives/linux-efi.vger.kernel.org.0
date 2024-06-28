Return-Path: <linux-efi+bounces-1311-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A9B91C283
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2024 17:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0671F214DE
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jun 2024 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B5D224DD;
	Fri, 28 Jun 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QITENeLb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B0B645
	for <linux-efi@vger.kernel.org>; Fri, 28 Jun 2024 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588123; cv=none; b=BdOygLy1PD7Mugwj+w9ZbR7i3GkbQ4CKloUd1IKbx5q0kgW1Lw74vUK37pp1qw3ohq/LrlObCp76UTegiXD/7vfM/TYbwY8hfaW/fP2SnGVZPQXM2EFQUX50txQcdLuiGqojL9Fw03OBaGKMvLF9JilwV8C4lp5ShV/gndGV/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588123; c=relaxed/simple;
	bh=sM0vkoUDxLSG9pkg+ozT89atMz2SHL+WPEPGkHtMRMc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WNVp59SwIasm2OcPBUnjMJI0ePX+JfIWCK9AOpyKAnQZBjGcH4EFahCxIP4PRL0fu2EGbhLEo95us57vGV+Ia4KrHtpMctTvtO788z1x0QcJ48NyOXmryJiJhnfB7E7h0d5u/dVCxXNq1bym1xqE1LEE6PQ918fRBMDIfbp2plA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QITENeLb; arc=none smtp.client-ip=185.70.40.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=tvj2eq7x4rgfbg6rhktcv5t7me.protonmail; t=1719588113; x=1719847313;
	bh=sM0vkoUDxLSG9pkg+ozT89atMz2SHL+WPEPGkHtMRMc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QITENeLbw3CLguMzZ9n/luWU1RGq/VstqMuxtCBiEDCB+7aCvIYj6K24RG59Po1iN
	 ZHuHTb3M4tnrCpG2nrzJGJDtRZVt/zb0LZQt5243YAwp3As8YDLZd9ydvUqh+T47zz
	 Eh4lWC5aLked2Y88USgq4/O3tqmHiEw6Jqn5CewSkSnEOzEZbX8afSQsK7ivJg/g9U
	 QHAEgTi8U6M4xMT8Ss+yE/mzzvKCzRu9hLsEO6ee98ShE98lR7VxLT8cN+gKa83uct
	 dLG1bW7T5MNoA0Am9inn0nD4yuYTQVc4Rdy/rvFcK8Fk2BWs3cRowUcv9gq72xZE5l
	 qrfhnY4N04pXg==
Date: Fri, 28 Jun 2024 15:21:49 +0000
To: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>
From: Tj <tj.iam.tj@proton.me>
Cc: Ard Biesheuvel <ardb@kernel.org>
Subject: Regression: drivers/firmware/efi/libstub/zboot.lds DISCARD
Message-ID: <6_Pz5RcQjqur8JTEHcvFxmszE0W-Ptt80fUB5Fbt8oUFUQxkrYweR2p9n9thV9_VPchd0N-zqKlC9DKXf8mNmVtshUQs_VwrV0_UNn_4nSI=@proton.me>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: 1583edf21b4a66e129d3082a59324e729bb8618e
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Commit 5134acb15d9ef27aa2b90aad46d4e89fcef79fdc may be the source of a regr=
ession that means aarch64 builds are unbootable when using recent binutils =
and GNU toolchain.

Originally found in Debian [0] and reported upstream to binutils [1] it isn=
't entirely clear where the fix should be. The binutils bug report is the c=
urrent focus on attention.

I found that reverting this DISCARD allows aarch64 kernel to start.

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1074111
[1] https://sourceware.org/bugzilla/show_bug.cgi?id=3D31924


