Return-Path: <linux-efi+bounces-6086-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDGZGaJ8g2nyngMAu9opvQ
	(envelope-from <linux-efi+bounces-6086-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 04 Feb 2026 18:06:42 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E147EACA1
	for <lists+linux-efi@lfdr.de>; Wed, 04 Feb 2026 18:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D662302B51A
	for <lists+linux-efi@lfdr.de>; Wed,  4 Feb 2026 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5403232D7EC;
	Wed,  4 Feb 2026 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="moen/VYO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2EE340A70
	for <linux-efi@vger.kernel.org>; Wed,  4 Feb 2026 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224644; cv=none; b=iLGRqhuV5Hnmh6SYmTLjIUXKeBsDAtFbmonzhIN/Nb85RzHTz/jHUKY5Ow0lYmmPexmi5wahAZjhDl5ixGsJVLvenX8QOXVP8woGP9Q0ybeI7C42krIg72gyy2g/eIn0rEwXQpIoENs0IU55i+DFM6HO9eLd9axiOS4/hpDbnbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224644; c=relaxed/simple;
	bh=6+CkfrLTtjZlH9fTVCCKcz8x8islFo0zdgYGbjCwpHs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gG80II1EIo7jMkMRVgrLqV08vIUP9pJcryoRapd/Qv7EkB0z8xuSNtv9PggDAHmXy7KEJn+hbFYIYbt+GkTCPUYRzXiKmvBeoyCGAaUrQMLgp8kQ0LM+URjw7nEAQxhx/92w3Ei1QhBAfolugdWs7TDkF8azWsY77VIBA/O4Lm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=moen/VYO; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1770224635; x=1770483835;
	bh=ZBn5kzNLw5QXk9rYVHlNbsbry1C8l/I3ewTrGqA4X9o=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=moen/VYO3pNAnk7j4QeloICgbx5ennDWIQsN7y4nbA3EMXBv85Hp2RAYUWpUZwdyO
	 tiou3w4imW+OXeoPoXuE/N4stoDTduGBEWZqezCTsIlrBmNIXgOn7GvEF/JfmVn4s+
	 p7lPRSyOGsZV0dQFAWLfMMjXzRE9lLCoQbZEY3Q01sSThS1FDDcY37aHb+z4SOfdNK
	 tKz2ZXEouXJEMk9q6CTqgK6NuWxSwInNdrxO7ReatAMrppsKdgziJOyeNkRr9vuDLd
	 Pg6K3jicmJ35TqbFFQVcM0ZNKuP7ODuals/3/JExpj5+xI2nAtzFmqJi0p+MjT9Ilb
	 2WGI5/SYRBMUg==
Date: Wed, 04 Feb 2026 17:03:51 +0000
To: Sohil Mehta <sohil.mehta@intel.com>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Tony Luck <tony.luck@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 0/3] x86: Extend LASS support to EFI configurations
Message-ID: <aYNfqAl0MQRnyYqj@wieczorr-mobl1.localdomain>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: ccc70aad8fa6d04526f80aae8cb09377502f9065
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pm.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[pm.me:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-6086-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.wieczorretman@pm.me,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[pm.me:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9E147EACA1
X-Rspamd-Action: no action

Booted successfully with the patches on a Sierra Forest system. Checked it =
out
with LAM enabled and my KASAN series, and ran KASAN kunits without issues a=
nd
the LAM selftests also worked as expected.

Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

On 2026-01-20 at 15:47:27 -0800, Sohil Mehta wrote:
>Linear Address Space Separation (LASS) is currently disabled [1] when
>support for vsyscall emulation or EFI is compiled in. This series
>extends LASS support to EFI-enabled configurations.
>
>Changes in v2
>-------------
>- Rebased the series to v6.19-rc5
>- Improved commit messages and code comments based on feedback
>
>v1: https://lore.kernel.org/lkml/20251204072143.3636863-1-sohil.mehta@inte=
l.com/
>
>Issues with EFI
>---------------
>EFI boot and runtime services are incompatible with LASS because they
>end up accessing addresses with bit 63 cleared, which is blocked by LASS.
>
>  1) The most obvious one is the SetVirtualAddressMap() runtime service,
>  which is expected to be called in EFI physical mode [2].=20
>
>  2) Some runtime services fail to switch to virtual mode properly and
>  continue referencing physical addresses even after SVAM. The kernel
>  maintains a 1:1 mapping of all runtime services code and data regions
>  to avoid breaking such firmware.
>
>  3) Some boot services code and data regions are referenced long after
>  ExitBootServices(). Most of these access use the kernel direct map so
>  bit 63 is expected to be set. But some odd firmware implementation
>  could access that memory via a mapping in the lower range.
>
>Solution
>--------
>These patches take LASS out of the path of all EFI boot and runtime
>service interactions by:
>
>  Patch 1: Deferring LASS enabling until userspace comes up, which
>  ensures EFI has completed switching to virtual mode and all boot
>  services memory has been freed [3].=20
>
>  Patch 2: Temporarily disabling LASS every time a runtime service is
>  executed after boot. Runtime services execute in a special efi_mm
>  which doesn't have userspace mapped. So, the security implications of
>  disabling LASS are fairly limited [4].
>
>Please find more details in the respective patches.
>
>Alternate options
>-----------------
>One option is to not support broken firmware implementations (by
>avoiding patch 2) starting with systems that support LASS. That would
>trigger #GP faults if runtime calls try to access the 1:1 mapped
>physical memory. Even though this is expected to be rare in modern
>platforms, there isn't a clear benefit of keeping LASS active during
>runtime calls executing under efi_mm.
>
>Also, client BIOSes typically get validated with Windows during
>development. So, some users could see in-field failures when they start
>running newer Linux kernels with LASS enabled. Though Ard suggests that
>things have improved on the Windows side, it doesn't seem worth taking
>the risk to me.
>
>In the long run, to encourage BIOSes to fix bad code, the kernel could
>trap invalid accesses to 1:1 mapped physical memory and then warn about
>buggy firmware. However, such an effort should be pursued independent of
>LASS [5].
>
>Links
>-----
>[1]: https://lore.kernel.org/lkml/20251118182911.2983253-1-sohil.mehta@int=
el.com/
>[2]: https://uefi.org/specs/UEFI/2.10/08_Services_Runtime_Services.html#se=
tvirtualaddressmap
>[3]: https://lore.kernel.org/lkml/ee2fce64-91ce-4b78-b2f9-33364ea0c52f@int=
el.com/
>[4]: https://lore.kernel.org/lkml/F707CA45-DA37-460A-AEFF-C11AC6AB6A05@zyt=
or.com/
>[5]: https://lore.kernel.org/lkml/255724be-a6d8-4aa6-94f9-1e6ffba3a3cc@zyt=
or.com/
>
>
>Sohil Mehta (3):
>  x86/cpu: Defer LASS enabling until userspace comes up
>  x86/efi: Disable LASS while executing runtime services
>  x86/cpu: Remove LASS restriction on EFI
>
> arch/x86/kernel/cpu/common.c   | 30 ++++++++++++++++++++++-------
> arch/x86/platform/efi/efi_64.c | 35 ++++++++++++++++++++++++++++++++++
> 2 files changed, 58 insertions(+), 7 deletions(-)
>
>
>base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
>--=20
>2.43.0
>

--=20
Kind regards
Maciej Wiecz=C3=B3r-Retman


