Return-Path: <linux-efi+bounces-6203-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDkJLNmnnGklJwQAu9opvQ
	(envelope-from <linux-efi+bounces-6203-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 20:17:45 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF4317C3B9
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 20:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E671317F402
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 19:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CF936E475;
	Mon, 23 Feb 2026 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7lb9mvt"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D76836E469;
	Mon, 23 Feb 2026 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873857; cv=none; b=K79FsP6ZQKOKLSnEtTpYxumStHdvMWaNtxvFr5xNpXJlzzS62J5eUs99oZcqzku72RPZGvfyAK6lLDtQV17Vq/6LEvK1yt/BhWqh6ahZExAmqWO5BPPrp418Amz6nqDI6CxwvvkMvf9V69kV0LQwcAtk/2qTtXCZQhInnhRbB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873857; c=relaxed/simple;
	bh=lEKimZnEjne2BNdsm8RfAwEFAB1/q1VUQbalmtODD1Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hItMJ4WkOwdN+wKqoPgyhAw37f14lR+eRGgFkn3SLqL1QB1FZ07SNkB+ZHiCZbTLKga4hXKEKjc01884NMZNdvf6kD5QQYgpIlWYWD1xV0MsTd1UnJpASOEeQwWOhhkMzdDw1MJDS43J/MaFwP172UjiJRvsqgcB2WgRhXvnfkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7lb9mvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55F7C2BCAF;
	Mon, 23 Feb 2026 19:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771873857;
	bh=lEKimZnEjne2BNdsm8RfAwEFAB1/q1VUQbalmtODD1Q=;
	h=From:Subject:Date:To:Cc:From;
	b=W7lb9mvt8Ss7DIDpVVbHvo8HG9uV2RHrY5VNGVfhxu/bODlNHPOMU8AHU7cyge+Yt
	 iRloWl9TfRuTMAM2B+UtspS3O6ZXW8kKmkvGes8uLVlEMNdiU2xt3fqmoiVtIi1Cod
	 SarcI/AdLtw17TCwEFJVDqDlJoLVMkEcAdtk4srZiwFRO4xHP50LbwxcaP0hEea+z4
	 RQpOuIRuHl6d6iyM1gY+9wf/r1WTKKzhKqKQITVCr+YsLeL7dTY8wNVJ/jbAXYxUvW
	 G8FCGINS88O6kG4fIPtGvpELH4y3kmpwj/vyFTEAcpNbcJGdv8VyHGqk/ExuZxYFDL
	 2gl/lR3828f7g==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] kbuild: Switch from '-fms-extensions' to
 '-fms-anonymous-structs' when available
Date: Mon, 23 Feb 2026 12:10:27 -0700
Message-Id: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDtgIwbxKqWLGCc6gknJJNIi3
 t1Ul2/x/w5CkUmgr3aItLFw8AXPRwV2Nn4i5LEYVK10rVSDbhU0PvjfGrKgpJhtEnTajKRtN7R
 GQ2k/kRx/r+/rfVvysJBN/xkcxwnoIdTAeQAAAA==
X-Change-ID: 20260223-fms-anonymous-structs-f6ade6c8b5a6
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Kees Cook <kees@kernel.org>, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-efi@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=nathan@kernel.org;
 h=from:subject:message-id; bh=lEKimZnEjne2BNdsm8RfAwEFAB1/q1VUQbalmtODD1Q=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJlzllkKpdb9/H8vK1IjjHf1par1+w9qXs5/w91Rs6jo7
 o0KpXUhHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiR+IYGR7dj3Mv9tp9XOzY
 T6tjbKzOTUe/79vdcuXP9qw297/fahUZ/qec2K/kXJAvNPuxK8fqb9Jb/zLOkuXmujS3dH7QXL9
 tnWwA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6203-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,arm.com,kernel.org,xen0n.name,HansenPartnership.com,gmx.de,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,alien8.de,linux.intel.com,zytor.com,linaro.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AF4317C3B9
X-Rspamd-Action: no action

Hi all,

The kernel enabled '-fms-extensions' in commit c4781dc3d1cf ("Kbuild:
enable -fms-extensions") in 6.19 to gain access to a Microsoft
(originally Plan 9) extension around including a tagged structure/union
anonymously in an other structure/union. Since then, Clang 23.0.0
(current main) has added a flag to enable only that extension, rather
than all Microsoft extensions, '-fms-anonymous-structs' [1]. Using this
narrower compiler option would have avoided the build error fixed by
commit a6773e6932cb ("jfs: Rename _inline to avoid conflict with clang's
'-fms-extensions'"). While these errors are not expected to be common,
using the narrower option when available has no drawbacks because the
kernel only cares about this extension in '-fms-extensions', no others.
While this could result in build errors for folks using
'-fms-anonymous-structs' if a developer uses another extension in
'-fms-extensions' (either intentionally or unintentionally), flagging
these uses for further scrutiny seems worthwhile.

This series converts the build system to use that flag when it is
available. The first patch consolidates all of the C dialect flags into
a single variable to make future updates to the dialect flags less
painful, as updating the logic in every place that uses their custom
built C flags is getting cumbersome (and C23 is looming). The second
patch makes the actual switch.

I would like Nicolas to carry this in the Kbuild tree for 7.1, please
provide Acks as necessary.

[1]: https://github.com/llvm/llvm-project/commit/c391efe6fb67329d8e2fd231692cc6b0ea902956

---
Nathan Chancellor (2):
      kbuild: Consolidate C dialect options
      kbuild: Use '-fms-anonymous-structs' if it is available

 Makefile                              | 16 ++++++++++++----
 arch/arm64/kernel/vdso32/Makefile     |  3 +--
 arch/loongarch/vdso/Makefile          |  2 +-
 arch/parisc/boot/compressed/Makefile  |  2 +-
 arch/powerpc/boot/Makefile            |  3 +--
 arch/s390/Makefile                    |  3 +--
 arch/s390/purgatory/Makefile          |  3 +--
 arch/x86/Makefile                     |  6 +-----
 arch/x86/boot/compressed/Makefile     |  6 +-----
 drivers/firmware/efi/libstub/Makefile |  3 +--
 init/Kconfig                          |  5 +++++
 scripts/Makefile.warn                 |  5 -----
 12 files changed, 26 insertions(+), 31 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260223-fms-anonymous-structs-f6ade6c8b5a6

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


