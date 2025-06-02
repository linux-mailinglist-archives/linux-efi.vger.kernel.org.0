Return-Path: <linux-efi+bounces-3809-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658B0ACBAE1
	for <lists+linux-efi@lfdr.de>; Mon,  2 Jun 2025 20:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22B51788DE
	for <lists+linux-efi@lfdr.de>; Mon,  2 Jun 2025 18:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEBE22A1D5;
	Mon,  2 Jun 2025 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVeSVJvM"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EAB22A1C5;
	Mon,  2 Jun 2025 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887907; cv=none; b=C3vVH1yi+IiGvvUWbAYnK+2Cv5TY++15XnCSP629t+L9ztzfqkHchziShPq/2p3cb4M63uq7ahCMSmVoYs2QpAPrAj1uNBY/GjXNNG2lPTq7rOW3dIlccd1zTQU2bImnLZSF+4VT4yh2TmCKVDQr4jIt6zECdhT8EAXN4Ef3AwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887907; c=relaxed/simple;
	bh=FV3+H8QXvPANRqtUuE5ThoL4FRz85WqkMoojFaRyZcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LbYG6VRT+KgTcK87hvicf64pn4Mv4e8hZuQWGj01MHMrLxBFvobEqhVdWq0ErKpwYnIeHPoal9HY6+LFBkP+4TwYIASkgd3MkZfTwXUCBIZ/vzQJm15Bw6zLGW6Gb12Jvm9wjJ+sUAxwhoON2F5227Rv1dPyEzl+cu8At5jB75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVeSVJvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BCAC4CEEB;
	Mon,  2 Jun 2025 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748887907;
	bh=FV3+H8QXvPANRqtUuE5ThoL4FRz85WqkMoojFaRyZcE=;
	h=From:To:Cc:Subject:Date:From;
	b=IVeSVJvMOj2hmossFVXASDjIsYo9KhGH3O89ssTjbv7NDZzG3d2Ed0t8Me19fO58j
	 pkJkgRkpZjY48WuIUMOunSX9hYoMD2wjSlRLUK4DOXftJqFxXEZVFa6TghqkXzLnFA
	 Q66BRret+r+Lu5BCa2cVVd0UCmiqpwYs5zQVYdq6ivCLql5hLA/EWxzQNblp3E7nFU
	 s29E7PaJRHZkp5ELXM3Uq0O+qE6N6Ns1dn+B01UmlaDJDVtjngg9UjO71SQvT45/WL
	 cfoAzMJfI+HWBXhguaaAwZ5/gwBlAETebGoNf+iYPN47SxuSu/0x5pv6X/G72F92c1
	 GuK5zoxcliyNA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-efi@vger.kernel.org
Subject: [PATCH] efi/libstub: use 'targets' instead of extra-y in Makefile
Date: Tue,  3 Jun 2025 03:11:41 +0900
Message-ID: <20250602181143.528789-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These objects are built as prerequisites of %.stub.o files.
There is no need to use extra-y, which is planned for deprecation.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d23a1b9fed75..5ce9f2098b99 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -102,7 +102,7 @@ lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o $(zboot-obj-y)
 
 lib-$(CONFIG_UNACCEPTED_MEMORY) += unaccepted_memory.o bitmap.o find.o
 
-extra-y				:= $(lib-y)
+targets				:= $(lib-y)
 lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
 
 # Even when -mbranch-protection=none is set, Clang will generate a
-- 
2.43.0


