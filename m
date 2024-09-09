Return-Path: <linux-efi+bounces-1681-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D63971488
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 11:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD10128441C
	for <lists+linux-efi@lfdr.de>; Mon,  9 Sep 2024 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949891B375C;
	Mon,  9 Sep 2024 09:56:48 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240D1B3726;
	Mon,  9 Sep 2024 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875808; cv=none; b=lE9W1kJG00AC98Z8E9cWwETnmmE2epCQH/HRnC/LkXFbxOwe1a0TreCg1CjVgAiHLCSGLzjkucqGXujAPQN6XUj1L9Ib8LR9yoGO7dORfC3ofHcTDwRlYixKRo4Sv74UVwGIODj2/nzeHoIrs76O+3YrkvIkt7Bi7+P05lN60Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875808; c=relaxed/simple;
	bh=MLbbJIq+Zfe089qhtzy1npRgcDSTp273ZtecQnMVJss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4XRBgPQkPeR3FvxTMZlE5HssavbH6Yg5qenm2ZNKj5aY+Q1K6LgbeAJRMrXl/V46NEGOWGxO2Cd4FrUO/VlP7rruqbE6f/MMMjalCjMcOHYYf7p/F2fOZ2dnj7Y+tlWRN6sN5LBWB0C3qKr5S3ZAjvy+tZ+LFORjqO7pu0jtzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id EDB21E80261;
	Mon,  9 Sep 2024 11:48:30 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 68469160143; Mon,  9 Sep 2024 11:48:30 +0200 (CEST)
Date: Mon, 9 Sep 2024 11:48:30 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Philipp Rudo <prudo@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Pingfan Liu <piliu@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zt7EbvWjF9WPCYfn@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906125438.1e54c5f6@rotkaeppchen>

On Fr, 06.09.24 12:54, Philipp Rudo (prudo@redhat.com) wrote:

> I mostly agree on what you have wrote. But I see a big problem in
> running the EFI emulator in user space when it comes to secure boot.
> The chain of trust ends in the kernel. So it's the kernel that needs to
> verify that the image to be loaded can be trusted. But when the EFI
> runtime is in user space the kernel simply cannot do that. Which means,
> if we want to go this way, we would need to extend the chain of trust
> to user space. Which will be a whole bucket of worms, not just a
> can.

May it would be nice to have a way to "zap" userspace away, i.e. allow
the kernel to get rid of all processes in some way, reliable. And then
simply start a new userspace, from a trusted definition. Or in other
words: if you don't want to trust the usual userspace, then let's
maybe just terminate it, and create it anew, with a clean, pristine
definition the old userspace cannot get access to.

> Let me throw an other wild idea in the ring. Instead of implementing
> a EFI runtime we could also include a eBPF version of the stub into the
> images. kexec could then extract the eBPF program and let it run just
> like any other eBPF program with all the pros (and cons) that come with
> it. That won't be as generic as the EFI runtime, e.g. you couldn't
> simply kexec any OS installer. On the other hand it would make it
> easier to port UKIs et al. to non-EFI systems. What do you think?

ebpf is not turing complete, I am not sure how far you will make it
with this, in the various implementations of EFI payloads there are
plenty of loops, sometimes IO loops, sometimes hash loops of huge data
(for measurements). As I understand ebpf is not really compatible such
code.

Lennart

--
Lennart Poettering, Berlin

