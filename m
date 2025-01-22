Return-Path: <linux-efi+bounces-2714-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 023BBA19463
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 15:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2ACC7A0280
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152532135CF;
	Wed, 22 Jan 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Hx0ep8Bw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6E1448E4;
	Wed, 22 Jan 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737557561; cv=none; b=i9rFtJxbqVNZV/HOimlEZzc2xAHO/q2hBsPTmxGFS2/LQN3ic1ceklV09GEpBbF5CEyyL9RbMJJTncfhORf6CtV1l9Av2kKFOqI+NEaiOTGuhe3iVHPr/5hIAtWK3mij6zGqsQjUnVabrny0dcR8D3hEp0NEVPDM+JbES1bP9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737557561; c=relaxed/simple;
	bh=cmGytEN3vf5CnwV10raistdt4OyK/aIaHRtOMALyvm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6RLO2SUvDTZGp4LMMsjwBRqCodrAT6OQGdJC1yjY+WWDzFyILv3l9CRiB3elhoueOjXFByTmPXt21E4lr0MnDbaPRF85d6IJTyUcgcMscw/bIcwjyAohvIe8ir7TgQn/Qm9TAKPyTykau7Vl6eoSCQIEFR1Aiu6KntBlyHF25M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Hx0ep8Bw; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (unknown [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YdRrM4NH7z9tVf;
	Wed, 22 Jan 2025 15:52:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1737557555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9FPWU26FzKRtbHAEmB7rzFsjIiwtYRI/y6BueNw6rc=;
	b=Hx0ep8BwMRkONw2TqCkFnL/Afb9kV5AVFiYLAzb1PfjCQ4zlJbOjGgqATsGBC+Ggy6GfFz
	Tj7ieZ9AHd1J6n5aOk5ySscoMENXdjacKdOuagXb5aarP6za6P+eofvwl364qek+B9nwyB
	spvcx/IKVVW4c9dGiCnCZohCetfOY7tqQWz01WwhUoF839pL7GWkjLYjEz5L3sEOFaV/y3
	xGnPYDrlO219d6GHT/o9F9EtNTCt6zwmQuiP3+4trkcu7PbiRWOaff9NZqDF7AwauWYuFs
	MHn0MIvZJcK5EhcuobkP51tPliFyTOyD4AXwpNuOVFl6r9fbBP9ga5iSTHhFbg==
Message-ID: <a6d347be-efdf-4cd8-b43a-5179a58b6e72@mailbox.org>
Date: Wed, 22 Jan 2025 15:52:23 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC] x86: Add CONFIG_KERNEL_UNCOMPRESSED support
To: Jann Horn <jannh@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 linux-efi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250121-kernel-compress-fast-v1-1-fa693b6167d4@google.com>
 <CAMj1kXF-GSB9Ty7X1h4u1uA6qhO1Y1UvVrNF=R+hk3PENRz7WA@mail.gmail.com>
 <CAG48ez2hVHk-C4XAGW2GieHZ9JAF0RrFfpZF7XhYc80pznMwbA@mail.gmail.com>
 <39417993-9fec-4ff0-aac2-6bb2c5a96b3b@mailbox.org>
 <CAG48ez3ddjXA0HiRyS-wT6Fs_fkX-5cf9XRD061YhJu+NZ8dGw@mail.gmail.com>
Content-Language: en-US
From: Tor Vic <torvic9@mailbox.org>
In-Reply-To: <CAG48ez3ddjXA0HiRyS-wT6Fs_fkX-5cf9XRD061YhJu+NZ8dGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2ed66fdf9543850ad56
X-MBO-RS-META: cwh4psasempqp718iq1iqbzt1oi3o1do



On 1/22/25 15:30, Jann Horn wrote:
>>
>> Hello,
>>
>> In my opinion 'lz4 -9' doesn't make much sense.
>> It's terribly slow and the compression ratio is also not exactly good.
>>
>> Instead, zstd seems to be a much better choice. Not quite as ultra fast
>> as lz4 levels 1 to 3, but much better compression.
> 
> I think you're describing a slightly different usecase.
> 
> My goal here is something I can use for when I build a kernel, boot it
> in QEMU, test something, and then immediately throw the kernel away -
> I don't care that much how much disk space the kernel image uses, and
> the goal I'm optimizing for is pretty much just the time needed for
> one build followed by one boot.

Ah, yes, fair enough. In that case, 'lz4 -1' makes the most sense I 
guess. Sorry for the noise.

Tor


