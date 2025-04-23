Return-Path: <linux-efi+bounces-3436-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BE0A99594
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 18:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7536F463900
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 16:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0232927979E;
	Wed, 23 Apr 2025 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieZrL53C"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980617B421;
	Wed, 23 Apr 2025 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426502; cv=none; b=V8rhVFSlO4+JFjDzK/HqTx+vI+SGwE3Yr3kV06tWnWxWVV5Py021zKo7pa+dVUPVtSMB6PKpuRyK6MtSyXe2JiAwZX/foWT/4CNIC8gBHx6hJbpQxLrSgISmjYmyKmyuoNtNXPpjhSERollTG9eCtGNGuTMeVlJOWqFVHZJO1Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426502; c=relaxed/simple;
	bh=+NbL2oSE3TVPn5qRJxJNJP6XmHYxcXYA0NDuyWW3TvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuzmxBopV2oNXWXt/T3TA6ltxvhXdsTa03odAO1PbyaccRbywRjW1BpIQ5IjzvmqqQm2HOOqUaHT62ha7rBdgRcOAV7Ezw0KP0QUOw/3gJtNhHgAUegMLrNI+pskAqBysEzi2laplEOp0MZkC1Lgbkym8SWWcihEGn9igLZkTCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieZrL53C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D592C4CEE2;
	Wed, 23 Apr 2025 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745426502;
	bh=+NbL2oSE3TVPn5qRJxJNJP6XmHYxcXYA0NDuyWW3TvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieZrL53CXwpnER+cb8kBOAGLGdL4n2GFUq8DtnXvVnpAouDvfC3xSXV+PIC6b7nud
	 TuAiwZW/v+OiRUlHKSeI6DKfKsrmprVvIqKYPADK48XXV2lIvz+cLlObPlguCKCTc3
	 qRbxiMheZNkazPG3us1S1fKeJy6YUl1z+NCyQ3DDm+mBO5DytM6xdlMRMWDmD/9eht
	 tSzrRRXgYZoeGzfRTYQf4IUgUTAwcVxULovAQ+ZoiD84ogTAdE859lH+DNN6l4vaFc
	 r48KOC9iVVIpxVNjblYMYKtcfQtS1SrjuGv6tlMFv7/PV560f/1JBGZwjTJpJbJKtJ
	 vg0hMx/Y+y5Bw==
Date: Wed, 23 Apr 2025 09:41:39 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: tip-bot2 for Ard Biesheuvel <tip-bot2@linutronix.de>, 
	linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-efi@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/boot] x86/boot: Disable jump tables in PIC code
Message-ID: <4dxg5dunoft5r5hd5kddqzap2stn2ytiwvgik7vvktifbhiyv4@2dxkkjlygnia>
References: <20250422210510.600354-2-ardb+git@google.com>
 <174539448176.31282.2929835259793717594.tip-bot2@tip-bot2>
 <odoambb32hnupncbqfisrlqih2b2ggthhebcrg42e5fg25uxol@xe5veqq52xif>
 <CAMj1kXFpE=P0_a3fTAnb7qQmXLt19dCtuEcd5U8xwYzAcO=ufQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFpE=P0_a3fTAnb7qQmXLt19dCtuEcd5U8xwYzAcO=ufQ@mail.gmail.com>

On Wed, Apr 23, 2025 at 05:01:42PM +0200, Ard Biesheuvel wrote:
> > > So let's not bother and disable jump tables for code built with -fPIC
> > > under arch/x86/boot/startup.
> >
> > Hm, does objtool even run on boot code?
> >
> 
> This is about startup code, not boot code. This is code that is part
> of vmlinux, but runs from a different mapping of memory than the one
> the linker assumes, and so it needs to be built with -fPIC to
> discourage the compiler and linker from inserting symbol references
> via the kernel virtual mapping, which may not be up yet when this code
> runs.

Maybe objtool should ignore .head.text.  It doesn't need ORC, static
calls, uaccess validation, retpolines, etc.

-- 
Josh

