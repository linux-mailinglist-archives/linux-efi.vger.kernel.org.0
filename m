Return-Path: <linux-efi+bounces-2491-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7B19FE228
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2024 04:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71003A19E8
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2024 03:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9913CA93;
	Mon, 30 Dec 2024 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fyralabs.com header.i=@fyralabs.com header.b="3BqjR29i"
X-Original-To: linux-efi@vger.kernel.org
Received: from hosted.mailcow.de (hosted.mailcow.de [5.1.76.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C2D40BF5;
	Mon, 30 Dec 2024 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.1.76.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735528170; cv=none; b=gFCQlvIS6rKGLbBv6dPjxijeMG3ZQEXaYTNTMiik21T+oZiM1RiIB9IOPsTXnI+NrdisAtC15VjYB/78P0uVmoN5lBgnZXWpGCdgYmJk3kLv2htTf5Nm9p0/3ZCUbq+SRfCrj325XGJAyButCF+pxXerk0B0XU4l7XrKfEQSRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735528170; c=relaxed/simple;
	bh=E1wAwjpfRxMD45B9uecCVx0ygQpx1598b/+ir1WbN7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mY6H2duUhDl+0A0y4CweaZ/PJz98TylsVdnyZO83E/vdG0j7wJ8z7LzlorKkzOxCx3T2s1PKDF3GlEsNmx06ezdeN57vc0Zea42RyaSmflbq8il6+tP2rV4KX+EjK2Xb2T6QAPcamaOE2Hgv/CgspBfq69PL0R8eJC/3KrvnGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fyralabs.com; spf=fail smtp.mailfrom=fyralabs.com; dkim=pass (2048-bit key) header.d=fyralabs.com header.i=@fyralabs.com header.b=3BqjR29i; arc=none smtp.client-ip=5.1.76.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fyralabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fyralabs.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fyralabs.com;
	s=default; t=1735528160;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mahv68/v1HodYjPQWE1PBX7LKrXKXw8Boe5ARwJWpdg=;
	b=3BqjR29ibts1xIkpHTqxr/6xvREwwQr2CA9HTAmZtqhpOzCXrNf4LvntWgc+prBjBcFK4S
	xVMYwe/jyHfZwT7QVd3+iHYm8Eq3qibyrqQQ9rPkDwLqfs1DOAHr9oCjCAIwU254hjbIcp
	eqRxxrgTWAPjhnoJeQTDB81nSV0jBVlgULbOKgFgUm7oyhn5XBxLyPGCaTVF+lsGKBlRao
	8Y7tgZqnWyWeoJZ9WwFs2FwqGG5fAaZsBM9m9Rlxn3LQGLK9tWlfYEAFc9aANAJSpo2xwX
	QqbayYmJwJHbCTlPcIWauMPi74AND+Vq2kaHL/SQ86Qb2eAAjBo1umkia8R8Gg==
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24A7B5C0227;
	Mon, 30 Dec 2024 04:09:18 +0100 (CET)
Message-ID: <abe2274b-4341-4212-85a8-113273ce1b18@fyralabs.com>
Date: Sun, 29 Dec 2024 19:09:15 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] x86/efistub: Add options for forcing Apple set_os
 protocol
To: Ard Biesheuvel <ardb@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: gargaditya08@live.com, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org
References: <20241228202212.89069-1-lleyton@fyralabs.com>
 <Z3EdkuCBzTGzTHK3@wunner.de>
 <CAMj1kXHWoD78QdFnEY_=Mtz02zN3rhN5+Skgv=fHG91TD8Mmvw@mail.gmail.com>
 <Z3EmoNWbkbYZ7NZO@wunner.de>
 <CAMj1kXEb9NPSwEr2brHYJtFQhnW55hoPycjcAgoPAfjU5ZFqZw@mail.gmail.com>
Content-Language: en-US
From: Lleyton Gray <lleyton@fyralabs.com>
In-Reply-To: <CAMj1kXEb9NPSwEr2brHYJtFQhnW55hoPycjcAgoPAfjU5ZFqZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I believe this is another issue that requires the same set_os quirk. In 
specific, amdgpu fails to initialize when using an AMD eGPU in a T2 
system, unless the set_os protocol is used. Because it's currently 
quirked for the product names of dual-gpu T2 Macs, if you're on a system 
that doesn't match those names (ex. 2018 Mac Mini), there's no way to 
enable the protocol to get an eGPU working.

On 12/29/24 10:22, Ard Biesheuvel wrote:
> On Sun, 29 Dec 2024 at 11:38, Lukas Wunner <lukas@wunner.de> wrote:
>> On Sun, Dec 29, 2024 at 11:08:55AM +0100, Ard Biesheuvel wrote:
>>> IIRC, the original issue is about not being able to use the discrete
>>> GPU with the built-in panel, and the issue about an external GPU did
>>> come up in the discussion - however, this does not affect the built-in
>>> panel at all.
>> The original issue was that the integrated GPU is hidden (powered off)
>> unless the set_os protocol is used.  So only the discrete GPU is
>> available, which results in terrible battery life.  Using set_os
>> keeps the iGPU exposed so the OS can switch to it and power off
>> the dGPU.
>>
> OK, thanks for clearing that up.
>
> But this is distinctly different from the eGPU case we are dealing with here.
>
>> We could have solved this by checking whether there are two PCI devices
>> with VGA class in the system.  But that would have triggered in the
>> iGPU + eGPU case.  We wanted to avoid that and thus quirked for the
>> DMI product names instead.
>>
> Yeah, so it would be good to know what issue are trying to fix with this patch.

