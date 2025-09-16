Return-Path: <linux-efi+bounces-4845-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AB6B597EA
	for <lists+linux-efi@lfdr.de>; Tue, 16 Sep 2025 15:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF521B28898
	for <lists+linux-efi@lfdr.de>; Tue, 16 Sep 2025 13:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175D1311C1B;
	Tue, 16 Sep 2025 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PBvn7xUk"
X-Original-To: linux-efi@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3E28315A;
	Tue, 16 Sep 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030025; cv=none; b=On2mU2w6LOiYu8ZB6aLc5Q0zgA4PqYLwJkctAI+2xu58vn8QUEgqt7DS1jbHgiqb2BUd41hYKjunLsL2UPbxt+BBd4/nn7VJVVIglmR1H+rHbYYDCbZD0DXh3E8KuzvGqfpu/gQPdlGplbND5Gz5RrmGa5tQ+S1/D0I74L5pewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030025; c=relaxed/simple;
	bh=UhTq+R/AUTW6A3P9mK1PbaeFocy/C4nhfcZgpQRqIzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uOn+KmSTw7U9jmN3aYK3cyUuZdm22bCkiw73lErt9eTcA/QDXykcVLoLHZR6pmRnMJS4gkfQT1k8wW3xe6z0ereW62Kabn1Tvb2TgWCy6ltn85nZq93B8P1WNuFL2KW/DBWCrGnMasNlTeKTir4Dyb2RMicY/ixrVebvxaIKZ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PBvn7xUk; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 400A740506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758030022; bh=/m0af4HgbIhj1vQuCxwLnH+xOx3/lPu6/JnM8FLaM3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PBvn7xUkY4P63BNYkyZuH6TtW1A0GGX5fEngTQhahRsYvcnOkAt9z4SpvBEACcwJA
	 RlCL0iRORyHoU4ydSDg1p/bDjh+G/ZES54pmuxl7whdqy+4dOyeGwb7nuSotKfwUP0
	 Y8/EoPE5TG7j4boQoKW0Mdc6gLNb8Yjyjs5wy6pQsMlLBsH9lRZcsaNgZm8aGKXwzi
	 BWY1uwgFidkFOf1jY3X0kxp+aLmB5tW340C1sgFRZaobaQGljsj4Lr2L6hNz4y9Eov
	 Voz3O/ZTLeQXWEw9fKMiFY+QWBSweT0GcwV3hH5/YOIq/ed5NoSdh7c9ftHtbqNTqz
	 4xpQVaS7a9qZg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 400A740506;
	Tue, 16 Sep 2025 13:40:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Hugo Osvaldo Barrera <hugo@whynothugo.nl>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux EFI <linux-efi@vger.kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] Documentation/x86: explain LINUX_EFI_INITRD_MEDIA_GUID
In-Reply-To: <b629ff7e-a223-467f-8e32-78f825bd31ac@app.fastmail.com>
References: <20250916073244.590483-1-bagasdotme@gmail.com>
 <b629ff7e-a223-467f-8e32-78f825bd31ac@app.fastmail.com>
Date: Tue, 16 Sep 2025 07:40:21 -0600
Message-ID: <87zfaufrcq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Hugo Osvaldo Barrera" <hugo@whynothugo.nl> writes:

>> +When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed 
>> as a
>> +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
>> +implementation details.
>
> I must insist that it's a terrible idea to replace an actual link with the
> name of the source file.
>
> This might be (marginally) more convenient for somebody who's editing the
> documentation, but it becomes completely useless for somebody who's READING
> the documentation. Documentation needs to target readers.
>
> For someone reading https://www.kernel.org/doc/html/latest/arch/x86/boot.html,
> the above filename conveys no useful information.

When the documentation is rendered into HTML, that file reference will
be turned into a link automatically, and people reading it on kernel.org
will not notice the difference.

Thanks,

jon

