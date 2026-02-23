Return-Path: <linux-efi+bounces-6205-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCsyMwGonGk4JwQAu9opvQ
	(envelope-from <linux-efi+bounces-6205-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 20:18:25 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4281F17C3F6
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 20:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDCB4307A544
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 19:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF9937106A;
	Mon, 23 Feb 2026 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec7rpLCA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B13371064;
	Mon, 23 Feb 2026 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873873; cv=none; b=qoV9UrhZeRX8Koti0jdn/AMOYxYlibeqgGUqryR+X1MIg3CIJw01/c6pBmyvErxAiBbLbIH9wSvMHlK84A7hBetsXu0sKiHvPEA/pHW3pkpuAGoberWuLYYOe62G6tAjvBqiJCoLdaUXSmNISHBuLuVPSwiwH2vkXy1HcH9cbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873873; c=relaxed/simple;
	bh=HnBXmWSMpA4wuIlOSxrj2rJBVS6hgScD9wUDZt2+qlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XcNsgIbSEdX0gFjuklQl5ezkJZLW5XeNa6R029cUzZdmVWu1TCQ6kPZjVbiKROSw8C2aFuZfx5Es/uufjyKOLJU4TTliDP8F4iwpr8zE2Yz0slzt0h5AqElQd7eOOmW8ibnCewbegiO27pUp9CKbyI0g/h1Ycr5WnaoO2alY4Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec7rpLCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEF7C2BCB5;
	Mon, 23 Feb 2026 19:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771873873;
	bh=HnBXmWSMpA4wuIlOSxrj2rJBVS6hgScD9wUDZt2+qlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ec7rpLCAzCv/KZRrk93iS8TKBy0dmX0TGeVU6K4v5xX/A3r84WlF1+spB2Ck3L8+F
	 Ly7Wrk5nDJOONGQAATDn57wpDwS2nId7NK4Vw6pPbxqhuUY3hzAD8tHDKWPeYQ16aq
	 CDGEXsS4binEbD98XFg/kkeskjcNzRQjVBeAbf9hU+krUTPdo4EdS3QsbFUpmWqK+x
	 83fmxFV+JzQ6K58ijzWKw7NoMdRiJVu6YnkQ+ER5K9bPSOKZ9CiQSYDQwcw9L4xCAq
	 zh+5+/I2WpfYgv6lc5TMsUwpiBXIECDLTQU1MmY+kExyurkj5huthCznFvUTJv9pGV
	 pHQjm+oF6bRiA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 23 Feb 2026 12:10:29 -0700
Subject: [PATCH 2/2] kbuild: Use '-fms-anonymous-structs' if it is
 available
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-fms-anonymous-structs-v1-2-8ee406d3c36c@kernel.org>
References: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
In-Reply-To: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2260; i=nathan@kernel.org;
 h=from:subject:message-id; bh=HnBXmWSMpA4wuIlOSxrj2rJBVS6hgScD9wUDZt2+qlw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJlzllnaL/tzZJ9j+UqRFKP/HVNX104yzPm+PPiz5Fdep
 pLXR1Z0d5SyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJlJ1h+Gf2bHvS3EU6Cuzv
 6lVV6lZmRpcf6jghx2ystVX28+qCK1GMDBd67Cest0lolmS6u+nMHYW1j73/xRXE1p4vP+5/d3u
 xCTcA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6205-lists,linux-efi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4281F17C3F6
X-Rspamd-Action: no action

Clang recently added '-fms-anonymous-structs' [1] to specifically enable
the Microsoft tagged anonymous structure / union extension, for which
the kernel added '-fms-extensions' in commit c4781dc3d1cf ("Kbuild:
enable -fms-extensions"). Switch to this more narrow option if it is
available, which would have helped avoid the issue addressed by
commit a6773e6932cb ("jfs: Rename _inline to avoid conflict with clang's
'-fms-extensions'"). GCC has talked about adding a similar flag [2] as
well but potentially naming it differently.

Move the selection of the flag to Kconfig to make it easier to use
cc-option (as CC_FLAGS_DIALECT may be used in arch Makefiles, which may
be too early for cc-option in Kbuild) and customize based on compiler
flag names.

Link: https://github.com/llvm/llvm-project/commit/c391efe6fb67329d8e2fd231692cc6b0ea902956 [1]
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=123623 [2]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile     | 2 +-
 init/Kconfig | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 06ff3032a6bc..1d5c0ab9ed5c 100644
--- a/Makefile
+++ b/Makefile
@@ -791,7 +791,7 @@ endif
 
 CC_FLAGS_DIALECT := -std=gnu11
 # Allow including a tagged struct or union anonymously in another struct/union.
-CC_FLAGS_DIALECT += -fms-extensions
+CC_FLAGS_DIALECT += $(CONFIG_CC_MS_EXTENSIONS)
 # Clang enables warnings about GNU and Microsoft extensions by default, disable
 # them because this is expected with the above options.
 ifdef CONFIG_CC_IS_CLANG
diff --git a/init/Kconfig b/init/Kconfig
index c25869cf59c1..c4282d049463 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -960,6 +960,11 @@ config CC_IMPLICIT_FALLTHROUGH
 	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
 	default "-Wimplicit-fallthrough" if CC_IS_CLANG && $(cc-option,-Wunreachable-code-fallthrough)
 
+config CC_MS_EXTENSIONS
+	string
+	default "-fms-anonymous-structs" if $(cc-option,-fms-anonymous-structs)
+	default "-fms-extensions"
+
 # Currently, disable gcc-10+ array-bounds globally.
 # It's still broken in gcc-13, so no upper bound yet.
 config GCC10_NO_ARRAY_BOUNDS

-- 
2.53.0


