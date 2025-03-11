Return-Path: <linux-efi+bounces-2966-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CA5A5CA93
	for <lists+linux-efi@lfdr.de>; Tue, 11 Mar 2025 17:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF7A77A2397
	for <lists+linux-efi@lfdr.de>; Tue, 11 Mar 2025 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C81613DB9F;
	Tue, 11 Mar 2025 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b="XAlCL2Ge"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602A259C
	for <linux-efi@vger.kernel.org>; Tue, 11 Mar 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709809; cv=none; b=JoV+gmZJjPszzb9n1QlQ7CAdG2V+MNGZsUMLi4hYOSdYXWC41ZNQ9Yvr0a+Z5Rmvyv8G2apWDkiKNT1rJ5jBHJm8L0rcS6JDgeybidt16+pa+Z31RC9sMRkmvmNofPrqcWoDNKI2aq7u2PlwxY2SIy3zi3pyUZl2zFtzASc1yqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709809; c=relaxed/simple;
	bh=7LjwHmm9/K3bKq4e9/Y0SlCZGAQc6szkpV2att5RP2U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXnMcypJhsffrWOZbkvfgAG7mQBazOIZH2KxsAa5+QeHeSH1y/2GypKUPZ3It0sXfUGkIbVqYMQvkq1ahMIZEztKxBu/C65roOvvQT/rb9YJqILuHfb6/pJSfgjRzmHQ2BRcddyYPl4slZjLEO2wji7tnuyFqELlQ/xS+rhRNYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus; spf=pass smtp.mailfrom=bens.haus; dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b=XAlCL2Ge; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
	s=protonmail; t=1741709798; x=1741968998;
	bh=7LjwHmm9/K3bKq4e9/Y0SlCZGAQc6szkpV2att5RP2U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=XAlCL2Ge+lJMkucNsT6NrIpM5f+zNlCdPQR5abUuwV5ATUYdJVGf2QWQjR033jNZ/
	 YGt7gLfM6FCWcWzN1OCBY6TDX/6HMg3j5y0byuu4oo9C5I4KaqurqgMKmpWZnMh07L
	 TdD3ekWc1Q4Lv4D5NZubNKRrUD5cvZMfJuejFJV9fN89x8VkbmdNJb0O6pHfU1e68e
	 3c6coTz9ZrJvt19QpO1/R8QY6tBbWW4eU/IXjCmtUOFWNDmJylNsQLaUCa9imimZut
	 utW9/lvV6wyOYCONYKo2ITfgVcsDnx9LmFAjO8JZxi5UB7KokHkX8Bu72n2YlmbyqK
	 uafHejScqbriw==
Date: Tue, 11 Mar 2025 16:16:33 +0000
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Ben Schneider <ben@bens.haus>
Cc: Ard Biesheuvel <ardb@kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: efi_random_alloc() returning EFI_NOT_FOUND
Message-ID: <gqqWrf3trBPlLLAJDR55YYQBffE1dToIMzSMgebh-GuI-06E3pX4WcYuFU7XOF3s_ZEjK70ePUUJBXu_V0tAxKc8dmNcQjlqR55cLRAHAJI=@bens.haus>
In-Reply-To: <CAC_iWj+9DNswD7qCc7V8UxsAOaBTzx7QTYA7Yo8py5pEuHdWDw@mail.gmail.com>
References: <5BK24Nc0mA4pe8BFp-FUgN4Q9lCFpR1TUFMKB8mRUJIhOG1hP3yYcVIulRsDSQA_7MvOOH9dg1nUiDvQSkQ2tS1vZeiZbMEFEnsMbPzB0cg=@bens.haus> <CAMj1kXHN4qTTUzCUvERy1iZVMy6jQ_-iha0EyHBsE5jH0_WaUQ@mail.gmail.com> <YT8Nabg2mhqfljPaZg1ruLmAwW-C6iNOaSA4yUC3h8tkwEgaHJswhIP0fKxb_0Tvmsc6muBWW7TRgnCgXejXrXZ5zxx8gMc1aMFZW0A8-v0=@bens.haus> <CAC_iWj+LdNXYO-nTzenCvhQN=--hmfJLzH1w_D5g676_6wQ8=g@mail.gmail.com> <PkBypGXyjiJ7T845148vEiHaoabJOyVg26qTLI-SygtRbQ9aQjnMWUddWHiYB9KPR8JVqDFQ1pZRnRUq06vIRR7L4CDLERwJL9-2LdvcxBc=@bens.haus> <CAC_iWj+YFNMZZneaQ+zh3ziM2iogB-whRsH81A8hKyNVPY0H9w@mail.gmail.com> <CihxtexZ2w9qfxFQ1v6_JhRD4eYGMDbKtlXqd7KTBfgKhNif3Qq3yaJriSzdiInTiywwgk-CxDDPCYqRPdfYKK3hf93yx774aFfjJKeIhs0=@bens.haus> <CAC_iWj+9DNswD7qCc7V8UxsAOaBTzx7QTYA7Yo8py5pEuHdWDw@mail.gmail.com>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: 7d4c1d6f82257eb08e5516a720c12b39cef27fff
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, March 11th, 2025 at 12:02 AM, Ilias Apalodimas <ilias.apalodima=
s@linaro.org> wrote:
> Can you also print the size to ensure the requested size
> is less than 0x4000000?

Size is 18087936!

Ben

