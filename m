Return-Path: <linux-efi+bounces-5609-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 461DEC6D9CF
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 10:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55E6E4FA63E
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 09:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBDB3321BF;
	Wed, 19 Nov 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b="bVWKCzwH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.novencio.pl (mail.novencio.pl [162.19.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3559331A7F
	for <linux-efi@vger.kernel.org>; Wed, 19 Nov 2025 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542924; cv=none; b=F6wt7l9SBN8TBbdBbHLgcKjAuXXbSTd/j9+W1Mq61njLVpUhFXWq0lHJrTjYXIK2t6PxH9hEj7BMmTPtbafBVN4mdCmkcPQq4tOzc01kuJ4mTlNm5cZd1sZ9Yg8h3NjWdmC5tbffy4YICvxM9Awuz5jpsP3z1x1odA7z857PYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542924; c=relaxed/simple;
	bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=PBzg3pGdP17gftMIefBbVrbeUYAIsHUphlqLwxA92tZ3Vu2zH6OReJfmXHzGDxJC5vWydcbNY5ozP5EoorJRMbxPGWPstqHroXJ6rT9R7TPNBIo8Xz5Q0MhIYcK7CwYdvUu9eV5/eIWOYljSL5TN6X5+GEwfbmTWAUkcmgtnrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl; spf=pass smtp.mailfrom=novencio.pl; dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b=bVWKCzwH; arc=none smtp.client-ip=162.19.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novencio.pl
Received: by mail.novencio.pl (Postfix, from userid 1002)
	id 4CA7624D0F; Wed, 19 Nov 2025 09:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novencio.pl; s=mail;
	t=1763542921; bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Date:From:To:Subject:From;
	b=bVWKCzwHOBt4wwiRAFCgOVEGSt1PP9+4X6AqDtrl4aBv3c1aMkm8vdm074ojZKteI
	 4EsxzkYOpDz/039osNuNFoo8rGw2/ZTxBWjhIq4RcQxJRg2mHY87oeX7RP9f2zAsqK
	 FDehrVC7q4v7yoK8f02tzthkQqU3SLH80Ivg8c+i6E05eGTYZa67xGEe2GOoxDSmd7
	 WV/XRe0IATuoxIBtk0dvAgOHEU0SBsqYtLMMl0tP1PSezahpdPqiVLamccwL6FK+CJ
	 SxI6MjywOGkMybnEa21qL0cdG7ypg36fTx7AmZHVh9B/Wi4lJuok63DiYEEaXfgAOz
	 p5ckYsBBs/kmA==
Received: by mail.novencio.pl for <linux-efi@vger.kernel.org>; Wed, 19 Nov 2025 09:01:03 GMT
Message-ID: <20251119074742-0.1.5y.z4k6.0.ffncnrdpam@novencio.pl>
Date: Wed, 19 Nov 2025 09:01:03 GMT
From: "Marek Poradecki" <marek.poradecki@novencio.pl>
To: <linux-efi@vger.kernel.org>
Subject: =?UTF-8?Q?Wiadomo=C5=9B=C4=87_z_ksi=C4=99gowo=C5=9Bci?=
X-Mailer: mail.novencio.pl
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

pomagamy przedsi=C4=99biorcom wprowadzi=C4=87 model wymiany walut, kt=C3=B3=
ry minimalizuje wahania koszt=C3=B3w przy rozliczeniach mi=C4=99dzynarodo=
wych.

Kiedyv mo=C5=BCemy um=C3=B3wi=C4=87 si=C4=99 na 15-minutow=C4=85 rozmow=C4=
=99, aby zaprezentowa=C4=87, jak taki model m=C3=B3g=C5=82by dzia=C5=82a=C4=
=87 w Pa=C5=84stwa firmie - z gwarancj=C4=85 indywidualnych kurs=C3=B3w i=
 pe=C5=82nym uproszczeniem p=C5=82atno=C5=9Bci? Prosz=C4=99 o propozycj=C4=
=99 dogodnego terminu.


Pozdrawiam
Marek Poradecki

