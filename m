Return-Path: <linux-efi+bounces-3931-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E348AE58D1
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 02:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DD04C1C5E
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 00:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EA9157E99;
	Tue, 24 Jun 2025 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Nx5PwA5v"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEDF1531C8;
	Tue, 24 Jun 2025 00:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726189; cv=none; b=osL2zv93xSAspNpvzNFdulxNLKbyXW7gV5Nxj3cDyAAGJQM7Fj96sUryZP3uzyfeL7Chh7I1I5NWG8u7mDWmhEcRihKVDiimDOJd5EruznBPb6LuhmkmJyy+orsn9bgBJnP2R8ZR8IRgj9ry/rMoxVpGmvd3/blaugT0rKFPoy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726189; c=relaxed/simple;
	bh=l6bL4ooYHBmAM34XGQ5KcRXT/b1jW8PZcoXDsVaUvF8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VQapqMoZgWrA2urITH6gNMzICPGZzYE/VMqQbixblWr132RJRgF5iyG0i1Lya9RtTQ3P0aRNsJQ+Cxprc/5D6Q8xKWiqvU1sLZ3mNiFdQavp9PGodoU3M4D+YhAjsifVquU2KvroK4LTEhK+zSP2G8k66rig7rHah3hgEcPADnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Nx5PwA5v; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55O0nN8K1144767
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 23 Jun 2025 17:49:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55O0nN8K1144767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1750726164;
	bh=l6bL4ooYHBmAM34XGQ5KcRXT/b1jW8PZcoXDsVaUvF8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Nx5PwA5vDohBi/OvvjEnT04gh5KrdbsCOIQCJCRka/POZQqiUZUfflY09VDUexW0l
	 75TuY7xHhlXTWEXzGw58Gyax11dSiLjv13Wprio38uD5dVpDqkXKVYNYnCEKAZ+RUO
	 AWhXlah7NbY89k0SKNzp2ybqRT3lWrSvecINEHVZdVWqvE4Te0ZjGdWt4+mW4Lcnsr
	 HhicpbQlK8OLSZKkrhIqX+WDWudDTk1AwgGxP9IVMXiB07fbBIuhdZGsS4ojOCZKE8
	 n3RwbRvuNlI58C9LnvLaQWX7+VrVUDjmHBjdA0pv8ZtoreLSDlK3FmgoTG8TkRW+vY
	 w8arb7wTz6Uaw==
Date: Mon, 23 Jun 2025 17:49:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Khalid Ali <khaliidcaliy@gmail.com>, brgerst@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        ubizjak@gmail.com
CC: x86@kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_0/3=5D_x86/boot=3A_Supply_boot=5Fpa?=
 =?US-ASCII?Q?ram_in_rdi_instead_of_rsi_from_startup=5F64=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250623183917.13132-1-khaliidcaliy@gmail.com>
References:  <20250623183917.13132-1-khaliidcaliy@gmail.com>
Message-ID: <DE5A95F1-CACB-4CF5-B459-3DFEC294DDD9@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 23, 2025 11:39:09 AM PDT, Khalid Ali <khaliidcaliy@gmail=2Ecom> wro=
te:
>> This is also invoked by some external bootloaders that boot the ELF=20
>> image directly, even though this is strongly discouraged=2E
>>
>> Therefore this patchset is NAKed with extreme prejudice=2E
>
>Thanks both of you peter and brian,
>
>however, the boot protocol document saying "%rsi must hold the base addre=
ss of the struct boot_params",
>it doesn't mention why=2E Maybe the document needs update to justify the =
reasons=2E I wouldn't have known it=20
>if you didn't tell me, so this shouldn't confuse anyone else=2E
>
>Thanks=20
>Khalid Ali

It is a *protocol*=2E An interface=2E "Because the interface specification=
 says so" is really all the justification you need; otherwise you have to h=
unt down *every* user of the interface and verify your change=2E=20

